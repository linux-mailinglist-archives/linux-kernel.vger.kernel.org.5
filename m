Return-Path: <linux-kernel+bounces-139602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5519C8A0527
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10678284F36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D355FDD1;
	Thu, 11 Apr 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErkRUmks"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB63201
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797334; cv=none; b=Pi960cFTGGTsH6x8+HkZbP9xQN8ng2LqK98FNXZ0XYBzYvAcUjtKZsVhrTf7FapwAVEwZAF2oVVOM5BTSFG6tCrhixtX/8qyEAHLAOvy8U3524JFf45O9sMNg6aSobQqso3N25j29hamxYNTnKUqimukmXsltJkZQ+nsXfXzTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797334; c=relaxed/simple;
	bh=kLD5kpB2LP2j5uUBOjlchyyyLOgJsQ4KSunDLcwJfvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S44Kh4lBmnEpDThWMieu6GKXmox5EufNjab1jZ/Eqg/H9IGjEeotlfdEC3hXzHdl2BQ4O28DVbvNAKLKGNu2m9+coB54zwtPp4Ec7EryQk4P2hBpY1Sg+6YNTo3g6B/7gbmhO0lasLHFlI3js2qBPwCkrBR2N2Qf/yrueo19Uos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErkRUmks; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3907ff128so6035972a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712797332; x=1713402132; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLD5kpB2LP2j5uUBOjlchyyyLOgJsQ4KSunDLcwJfvc=;
        b=ErkRUmkswlG2WpWs3Nv1ctlIYWScrZti+1b+RMFRtawck0PArWsHFGqS2LbufRED3Q
         vs9kmAdxrLeZQT8WSLv4dJGorzzy6Po/6wGcR8RuwpOlUSK1in+eBBUXBj2g9oPeU1Wn
         ZFL/jkdWRE9DDnW735csFbN5sNgyGHFrtYZrif8FwK1uziNT7ddxyTRLp32h4IfoajJ1
         mX0nlVoveEiNv/hFp1JXlGv7cHRgTQHoLxOIYW90bV0HnVo0lEjmZeVIxhAInHTqqSi/
         6icYq+SffD2i7bUcUKJQwG9hzRBMe2BrCcriKOpyuPrlzKVxSvzjXmRuaUYuxSRceBZ8
         9lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712797332; x=1713402132;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLD5kpB2LP2j5uUBOjlchyyyLOgJsQ4KSunDLcwJfvc=;
        b=a6XcrzQ+F/7oxw9HBYIzw4vsQN/EYC64rfFkRoPM++EKPy403H7nkKDH7/Q67kBucg
         pGh2/sDLUzhdwl13GgKJ4gxYsU1RJtaMNIc+4Kkv/pwPbinym3IkmaLxkTmUDegW6Ryv
         CABGaB/eahyzr+3d4xLtt54+ImMlvSSf47lc3wIwBvkkD3zCJ0Qey8mDO8Ybp4xkeIuF
         eL/GdkfAgBIv5wkYaS1Or6TpU6B58w/2P/esk0AMsgQ9W1CI0BZzvIUEdMJasr25dteC
         zXfJDuiUvZ0ftXrGcRIKaNPMAvxNb4Tbg84Mdf/ujIXEMnWWjmSL+jhUt7N0OvoVwtZ3
         /kBw==
X-Forwarded-Encrypted: i=1; AJvYcCW2bUTMdpzTNT6xiLlwlb7y+kF3kujgiXCErgxJyNrrKq3gHAAdXOFh/vCjZSlbpW5avx2cA6GKo+omRXboRDNMYIzQmUM1K5Qjwnrp
X-Gm-Message-State: AOJu0YyWWJNCQYpg9z2ssJ4O+pYn3vYfkEoRE9MKzu8YoiA70JCn+/5Z
	6Dg7ETMDVWzPJPjPXAloh0D7jqCK/AnwGv718ewBfn00bfbgh5qJMHGr4Dos8dk=
X-Google-Smtp-Source: AGHT+IFCQFsX0y012c0RYVyy1pzruF/1YvRQvQO3mIZBA6xLw4Uhegn+z6nHl9NsGJg7fqoOGUPO2w==
X-Received: by 2002:a17:90b:3643:b0:2a5:608e:1012 with SMTP id nh3-20020a17090b364300b002a5608e1012mr4531315pjb.21.1712797332116;
        Wed, 10 Apr 2024 18:02:12 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:fcac:9b42:fe81:c62f])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a68c400b002a22c8e99afsm248176pjj.12.2024.04.10.18.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:02:11 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
  amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com> (Samuel
	Holland's message of "Wed, 10 Apr 2024 17:47:27 -0500")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
	<20240329072441.591471-14-samuel.holland@sifive.com>
	<87wmp4oo3y.fsf@linaro.org>
	<75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 22:02:09 -0300
Message-ID: <87wmp4ogoe.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Samuel,

Thank you for the quick reply!

Samuel Holland <samuel.holland@sifive.com> writes:
> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>
>> Unfortunately this patch causes build failures on arm with allyesconfig
>> and allmodconfig. Tested with next-20240410.

<snip>

> In both cases, the issue is that the toolchain requires runtime support to
> convert between `unsigned long long` and `double`, even when hardware FP is
> enabled. There was some past discussion about GCC inlining some of these
> conversions[1], but that did not get implemented.

Thank you for the explanation and the bugzilla reference. I added a
comment there mentioning that the problem came up again with this patch
series.

> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
> 32-bit arm until we can provide these runtime library functions.

Does this mean that patch 2 in this series:

[PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT

will be dropped?

--
Thiago

