Return-Path: <linux-kernel+bounces-74314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500D85D2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1944F1F2414C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8953C699;
	Wed, 21 Feb 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky3TB3BX"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2533C494
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504745; cv=none; b=gUJ0rh8sFinZCRLZeZ2a97KUMoYQahdh3Z+kElnFUDALNuxiFKqfuGf1YVHdB1IvTcYpva35A4/8P8OAwYpF96jDo0z6Qp2k/sIpL77solo+SvmQ3hOMaDxnneRwNE5KQM7F8KcwtRbHpf3TpG9TB7PyXZP3lYZfE+CzrP94OU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504745; c=relaxed/simple;
	bh=ueDrwd5a7WHb4KYYxYDBPeBwlNvd4m2mCQVm5lEgLIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMipAL72fYXeAcYJZkX41I2wr970DYB1Nxpi2mZNeq5JHnrFh/dj3hS2gtff8vsQ7qSxPGpKCaiYd08VnKW3g6UaY3vga66RcgWFaXZq/vL6TIyA1jlgosP9zjMMBDCZiA+KaqEVRC5DsVDx9o/FO0NVB+Ea6WAj0N//c5Gz2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky3TB3BX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b42b6697so3676505e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708504741; x=1709109541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPELjiEKNsJRBnHqTRdMM8Q+eG4K1vI0RBfRjoo95ss=;
        b=ky3TB3BXfK19PIN92WEXFT840CqVC9OXxZ5ajaisAiCosLhqxWUGWksHDaLsbfDNkb
         72nXE2U3+las7Z/uJR3qB5QjQZqXuaj6u7ACdJIqpiMB21dNW0Yh+Im0uIIM/tJczNla
         VRvWUMAaAYVK3IQ5/Gm4sXMd40iEV1BnUrRkqyQ3GhAAJ0quieSSf1RI/SfxL82CAUiN
         MSp+ctW0NDeKSA+AHqS873DZhUGgZkF5RtYAN9WYQQHoj2ZFS/nvYIEv/cVcNhTbqUZg
         Yrpe/sCIRKssmRFbiZH6jyZkYaZTl+u7wnjkxhx6VKb3xJB+0TQF/BGcT7gLMJZSjl06
         1AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708504741; x=1709109541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPELjiEKNsJRBnHqTRdMM8Q+eG4K1vI0RBfRjoo95ss=;
        b=J3mjGld3KMTeVFJPjFEfuVT2tFnnETXEabk4BYrG37rDrUK4TyXipBEXoUy68whrrE
         cZxZe4Jpj5yqPeUQK1u0DBXdwsWNsleXwBCkgKr+j68k1kn9OkSJJgDNyBODKgV6SxAC
         o02NZEG3Emo/vok84olrLNJ0IQy5zwQBNembweA9KUmJwn4FWHzV0p/fKoJwrAMlZD0Y
         ZlOY/W/U3gjJKy8tmwdkKCw+LrrL0LW+9RAFkHCMTgqpe9tCrh4pcsecJ4PmWTtRQ6aB
         eqdJf31qhm2H6pzJn33shdU4nPF4GPY96rC+qnQ3VXwB56xv9lPB9h7HbXZeaZRs2aLF
         Qz/w==
X-Forwarded-Encrypted: i=1; AJvYcCWKZPLYTSTlDIedRuOSpdtP4GLAyrkX5iLMZZVvjVkJpu4rhrjoHW4+h/br6VPPYaa392BgIANip4k5zB4dnfDNLj4gx6ipr/DiFQOr
X-Gm-Message-State: AOJu0Yz3Oqy2petFp7lDwev2xK4I3BrtI10QahpvWFJ4cs4a3qElwJRv
	EayZ+KJpRcMDhZee3ldsZ/LHyHe2pfSFr/1a80d7sCBk/Xal6QES
X-Google-Smtp-Source: AGHT+IFCPFj4LN6dh3oAb9dYHm1NuipCWPQs2NheA5jWAIqLEeKg7aclhPVm9lkmiNhOorI5EZ2yRQ==
X-Received: by 2002:ac2:4256:0:b0:512:ae0c:6a89 with SMTP id m22-20020ac24256000000b00512ae0c6a89mr5702983lfl.9.1708504741352;
        Wed, 21 Feb 2024 00:39:01 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id y23-20020a199157000000b005117b2cdd1esm1640550lfj.152.2024.02.21.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:39:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 21 Feb 2024 09:38:58 +0100
To: rulinhuang <rulin.huang@intel.com>
Cc: urezki@gmail.com, akpm@linux-foundation.org, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tim.c.chen@intel.com, zhiguo.zhou@intel.com,
	wangyang.guo@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZdW2oo8Eor0tD9Yi@pc636>
References: <ZcNMa-CFEDNWDO2J@pc636>
 <20240220091240.3316840-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220091240.3316840-1-rulin.huang@intel.com>

Hello, Rulinhuang!

>
> Hi Rezki, we have submitted patch v2 to avoid the partial 
> initialization issue of vm's members and separated insert_vmap_area() 
> from alloc_vmap_area() so that setup_vmalloc_vm() has no need to 
> require lock protection. We have also verified the improvement of 
> 6.3% at 160 vcpu on intel icelake platform with this patch.
> Thank you for your patience.
>
Please work on the mm-unstable and try to measure it on the latest tip.

--
Uladzislau Rezki

