Return-Path: <linux-kernel+bounces-151556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547008AB072
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF251F25A75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12312D1FE;
	Fri, 19 Apr 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UiOOSX2D"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2C12DD90
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535907; cv=none; b=B0EecNqgWMuUIvynCeyuuwpkpm1oX0BqBf1xLG0rmUWpB6ju/c69Faivf5JheMCwPJd8yT0ZMqiDOryZ2VsdZoipwaRlIVJDhTufLzh1hBrxsWfh0IsX46ZWzOoFv3H9VkwMLZA90OBSzxrb/LDdpApTimT50CAEuMP5RCpI7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535907; c=relaxed/simple;
	bh=lhuuhlHoSybByQn0SwSCUX4ACgq5MHGKsq4NUwZKxu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DN9rZppkm5ha1ZX0ALRgpUBEpyzMpoY7RduquUmoGEYzrP5C0CJAvRElvaAEJIk9OgIcBlPGG8EAAaEkCIYmh5+LW/707fSomYVJdC805M5cIJ9Ne/IszEnhZdrdOOdwrslFoUfuOKfok/HnSoKOCxGojmI1LMm/FhcvB/moQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UiOOSX2D; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f055602a7bso383196b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713535906; x=1714140706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wys6ZkDgxTEpvXL6YfKptglVkZTc+L3A3W2ruhO3H8E=;
        b=UiOOSX2DlMO7U9TZ+vxC/jv1gdvL39YdO/msZ/zuGeVVDQTNOYmmWnWpUwECplo7Gz
         eDP0TuZ/PgwFTZ4PVkZcYJw7i/apVF6uUF2EH/mWkTYnN9oobSVLgwHLf1KqwLC5G4vF
         8BdiApGl68BKfGfeixLLymHH072rDGToHpc3d0X9roqjOlRUxpJIhpOwVMo+WyN1ptaX
         FYM4Ngvp0ISgnYgZ5hGAAAoII8WEjfvzj7EX+nId901af/Zw+yM3FKEnCU3Pjg5ERBJB
         Ui1PC91i3jNtKOk7Fs1DPh2Se7otXvT2LfVc4SprzDUb19t/REPx1UetJxTBqvtQU0cz
         jA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535906; x=1714140706;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wys6ZkDgxTEpvXL6YfKptglVkZTc+L3A3W2ruhO3H8E=;
        b=M8e9t0Lwcc43Bsnmm0dtZiNeMDu+tKzOE+lK3/Wdr4O01VQ9eDcHm3RxG8fOipXAxx
         5GOl87NIl9e7jgE3bH+Eh0ne2hQXz7gpcWcQrSjtPOI3B+sLYLCDSuHOSxYc+qFPRjbI
         2KocbqbaQh719BCmwfplgmRJJJrzkjGJT/+/83e7p3KlpgStJfwnI1wlups504vEntjX
         8xk2GpJX3lxa+WkF5jVThOlNGJKfZB2D2Fqhbx3jOnlLRbFm3FKpuY71D4ukh07q8EkL
         hfRxtLQcLmdWxRvbXmjTTlWtpl53v/GTM4XsHSMeoi75BUdBjP7q13MkEj2t4kGieppk
         /3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWn8PXgKjrhy4TmbYEF4Yj1GzJkySwf+sO/J8XuKj1YsTXKRlMX+gEvnx4a69NC5QIsRBd1KJ3zEAztY8XdI8MxYCzAnYj6HbBXLwZ1
X-Gm-Message-State: AOJu0Ywmt7efN4TO5YigbJZiO3i7WO4a4sNdMz3YLBiWbzgCJz5obKn7
	ZTBsZ2q1Cf5vfOPVHwNoKOhVBy8lUwZEmXuTPlmZ+IpgcU16tDJkwHimuEqNoyBc+8W1bT+XXZu
	z
X-Google-Smtp-Source: AGHT+IFCc8KLLf1SOEMuhb+QGId8pOkh7M0fMhCUVy5hGkteY0WGoCWDclRF3oRGhPuIjxvMuKmAMw==
X-Received: by 2002:aa7:838f:0:b0:6ea:6f18:887a with SMTP id u15-20020aa7838f000000b006ea6f18887amr2483792pfm.1.1713535905614;
        Fri, 19 Apr 2024 07:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006eceaccaec9sm3240102pfb.131.2024.04.19.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:11:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240419025610.34298-1-jiapeng.chong@linux.alibaba.com>
References: <20240419025610.34298-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block/mq-deadline: Remove some unused functions
Message-Id: <171353590474.449375.12575665892825233453.b4-ty@kernel.dk>
Date: Fri, 19 Apr 2024 08:11:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 19 Apr 2024 10:56:10 +0800, Jiapeng Chong wrote:
> These functions are defined in the mq-deadline.c file, but not called
> elsewhere, so delete these unused functions.
> 
> block/mq-deadline.c:134:1: warning: unused function 'deadline_earlier_request'.
> block/mq-deadline.c:148:1: warning: unused function 'deadline_latter_request'.
> 
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: Remove some unused functions
      commit: 8294d49adbb06d7df8cfaca5a4f4eb9064a91b90

Best regards,
-- 
Jens Axboe




