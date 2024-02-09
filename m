Return-Path: <linux-kernel+bounces-59977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949384FE1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AD51F2300A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32D16439;
	Fri,  9 Feb 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtoxQi2m"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC4DF55
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512685; cv=none; b=AIy6T58BPUOWE9DcEwKwJbTuwOVwUeXIAtvkfF7j3OU3sg0IuJkExymJkrIIH/vE0eWDkZ33msMtUiK2J94+XKp6L8rndBAipMu0+D8+SYzUSoaxkIMFxdelxFrocaFML0dwkFRREziexJs1vwsSQap6/dPQU+pc5JQnBlblGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512685; c=relaxed/simple;
	bh=jOaIm8nfbfABgxrtdcmIj/eatWfnwTghhoqfI3zc2tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGjG+P2VasyOoNmea7xySu+515Os8GcBBJcxOrqN/IlLVU+w4v6tFcOUGopvRp/SoLcB4LcJXfMbnqdmWocjzhUPT4SVfJ9o/FZZGOOgYyzBt9AGMN9M9E0imchadsBcf+SS2TdhqQWT7aG03Qqi0jcnJpTCGSk4KnZZh6WiDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtoxQi2m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d74045c463so12211925ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707512683; x=1708117483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDGRixAT1Zj7pm1YYRGquROBkdOOjYET0NODY7FyUNw=;
        b=BtoxQi2mzbMzl921oFN9dZNzAawvihSwoVPvmjL4fNU7WVeR91RxzxPOSSuVfBQ94u
         8ExbyumfsuFJdXTqLD5Li0otW0Y9VXKQi3KhwDTdTnIlcpaFI8dXK2POY0KJIlaIdinz
         LgjFs7GrIo3g+zOLi6Cml2YEbQ8OWLFjSxYQkOUq5aVfG0JYdgOk6uuTGCx5HnLzzOXl
         CXtYKfTPagC/ESbSaKWBkaYHz8oYP+v/Im9bJPGU/E+pjn72B8Mjvwle+d8nZMSA315D
         YHz4/xzhcxIu5k/6gWGT+cH/JKnG4NQspwCe2wo/yFFhMGcH2YxnwRvzjixkkCIIjdrV
         7CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512683; x=1708117483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDGRixAT1Zj7pm1YYRGquROBkdOOjYET0NODY7FyUNw=;
        b=OLS2X89kq2dPSBCa70pMo0OrAAo22rN27kpGk+cGlOoKLB+/j5/oElYsBvhvLsRrLJ
         c+ViNlQFP7rh4X0yM2sRv157H86gWtzLL6BhnIcDvvd8+dtz9Nz5mrQjvCLfEc7VOc1C
         rA7YCrxl7kZuarrZie4WVw+1eSxcUbe8g81yQR8u185CPOFM91QSxxKigqf8FyJCmRrX
         zFPd47iWsY6iCCLUcjXR2Xc0WNliBobgTaY4Vy3Ak/TUil85SkRowkfof3pH6E86BaDI
         n8lXjDqv1JFcioN+V6EvRXNudVRXDgj59xJeXkUr6FbMW0S21qDRx5FZKswLLiI7jWvc
         d2EQ==
X-Gm-Message-State: AOJu0Yw69dIR/H8ju1rp26QFn+5lLiRohqSJYrHqVENjVsppR/ygf+A6
	Di2Iq4yYYfbY0i5PMnMGF2WZLYSxcxyx4KpiOwsAK2hBrgvuI3WmDy1tzg1SmJ0=
X-Google-Smtp-Source: AGHT+IFxfiYyQ/efV+LtX68kwX8aTl7dhBxjX6SmTjSZEyGMiweAeU2VJRRCloCNA0jgYlotErOnVA==
X-Received: by 2002:a17:902:ea09:b0:1d9:b8cb:3665 with SMTP id s9-20020a170902ea0900b001d9b8cb3665mr540847plg.36.1707512683371;
        Fri, 09 Feb 2024 13:04:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVpK3fwceVRWn0TlsgK3Pa167VfNt3ulLz3wa317NowwuEy8gOlFDVb+DHByqf5p9SmRra9SStDaEp3KdfuFOeInAQbKx1qcgYD4cHYLKIcIsMOdcFH9ncpf87bWZ9yqDO7/Np7YtHTYUgTIMO2A==
Received: from localhost ([2620:10d:c090:400::4:62d6])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001d741873e4bsm1927709plb.95.2024.02.09.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:04:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Feb 2024 11:04:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix kernel-doc comment of
 unplug_oldest_pwq()
Message-ID: <ZcaTaeURGBfJtf-e@slm.duckdns.org>
References: <20240209170611.1166299-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209170611.1166299-1-longman@redhat.com>

On Fri, Feb 09, 2024 at 12:06:11PM -0500, Waiman Long wrote:
> Fix the kernel-doc comment of the unplug_oldest_pwq() function to enable
> proper processing and formatting of the embedded ASCII diagram.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

