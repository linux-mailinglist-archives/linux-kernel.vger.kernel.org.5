Return-Path: <linux-kernel+bounces-17317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8CE824BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879FD1C220B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3CA2D05F;
	Thu,  4 Jan 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s4rGAajc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37F2D021
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdf90e5cdeso195884a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409854; x=1705014654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=s4rGAajcagvdXTON4ibcIgMX5X4+HrGDFzDU7jr6tbabSPoI2Y4gU9qScJW079OaT+
         DQegsilY6JcWxrgiAC3fK65hPrDtRZYBMvalGiB1bRhiS10k3jbHne4qFP7/OBopYy3j
         cCrPEPCvWofbhqxGQWW7eGqphbpnbu0154m+ClbdJH2+mhDNIWy22n0K6L9grF0MJHa3
         6cJL93mzELrlmtUJ2Ht8wdmkkAOn+6OUhyufBN9/+3YIwslyOrTmEnOlVqEKukFpqpDG
         eCp+nAPiUwtKgmCleR72xNpKOVN4N88XviFvhpw3miS3T0qEip13NXQ5O8mjjbCx5W7g
         bUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409854; x=1705014654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtWKzPW+VggNnhjhkGvk6PwM7eD4b5VfXbjsvAZRsdg=;
        b=YTriU5eB8rXTrHlgNd6m0rAkjWej87ZiT7Vt5VnrVUGLGsUkcEPfe7u+4V8uWiMSYG
         uC9HpEzQ4KzVMo8MsQ/mzkLXnSvSIDUF9b2sdYEhwkERMPm+fk6Qs3G/lv7iFHrrb1sV
         ntsmFrdXJXBVF56ayZ+Wce8qTMbpz15t1ZrNxRWX77UM9CAWnCtIHhJHwiWtAq9Swons
         Z2R3T5AtnTaPeS8HFU+eL1Y3w3P1s7L+sNdvnUWX9s1DI8OqpszHv5R7xGyOVlmt35xu
         htnAu9RIpYCYMN7h1Mb+HUb4nwUxl4T497Mrd5aBy3pROsJneCOInH5DuSlaAnBek6Mw
         BoXQ==
X-Gm-Message-State: AOJu0Yzi6Twzo5btVsui59+mVmf24VdCk4fH0YVSAaCP+nYz58CRjt0n
	dwbSJlPrzYme4s+dRFB9ABielTRnKyIrE4xA5XYdcQ8bK2IVHQ==
X-Google-Smtp-Source: AGHT+IGU1glSIcKnbi9+C3kDPTLq7P1ixYqypmQFGI+x4/dzZR5aGRIoxmn66PhikKYpDvkjio+XDg==
X-Received: by 2002:a05:6a21:339d:b0:197:1c10:aa3 with SMTP id yy29-20020a056a21339d00b001971c100aa3mr2816239pzb.2.1704409853904;
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Daniel Vacek <neelx@redhat.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>
References: <20240104180031.148148-1-neelx@redhat.com>
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Message-Id: <170440985277.724469.7162918731895817738.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Thu, 04 Jan 2024 19:00:30 +0100, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: clean up after commit f1c006f1c685
      commit: fab4c16c527e24c804efa4992b3cf40438c9b227

Best regards,
-- 
Jens Axboe




