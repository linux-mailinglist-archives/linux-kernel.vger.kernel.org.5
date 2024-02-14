Return-Path: <linux-kernel+bounces-65655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C144185500F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3471F250DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114685920;
	Wed, 14 Feb 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl/qMYks"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8344839ED
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931261; cv=none; b=q/N/D7CT09BjiNdSAtGWhEohbUG+8fKnLZopVDeHPg7HQOi71Ks+GpbeoC8nHZ8tbY1UhCI01dzTkyTIEphVrrgGEt8kx5RjXiMxU8KjgDexKGaD+1eTMSaOsUsfXTCVawakosXmeFBdUFwp7LTAAyDxEEwlfgGumYNRtfyaSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931261; c=relaxed/simple;
	bh=NqXEuuPW3pnuNH/qAePRl00u3XMEnk0fe4Hf71aiV0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DvxAlIFflO0po/EYLTuo6FsrfXugg/jaWNnKyaGlmGWbvBa3v6IE5hH56jP54LJz7OMlQtZwmDWogYfuHLLXwxedowJTTuvjt8W6zeOEpwm3p7WOVwYSlIUlj67ov2gdL1+05FvtkQsNNuCBgpjIMqra6/vCwx7JHKIL3rYAmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tl/qMYks; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41205e196b4so1077235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707931258; x=1708536058; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y87s3zopO2jwBVeBUHCI4rxjiSkOy4fC3WNgHcDeAKE=;
        b=Tl/qMYksUbp3yANbn9IrBmFlv4mOvvrV3cmgqg2tE1w311yQ3oFWxcL1XZ08Os24Bx
         o7m9/TQrwLKNyCyO7IrxsVZBqAHMexIv80L9pVgwDmdXh75nPLIPM9z4zXHdH2Ecs/ON
         DclT/fOqV8zpr0FpXcUjxwiySJuUNq+1yJDpnMGIZkSD26JZywzV3ljE+I6vfhRblMJx
         sLFO62RdHhuK2hpqienXl6svvx+rTCxJD3SwIE44v9GrpCPo0xoof0d7ImFwtiyVMPfB
         4xSMeIMPQVxUUkPxRkKqrgftd9OWEVS0d0nb02eq3dJ6Mt1XWqPZmiyitfXliiblRzJu
         fAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931258; x=1708536058;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y87s3zopO2jwBVeBUHCI4rxjiSkOy4fC3WNgHcDeAKE=;
        b=r/KEGWOs7w/2RmniiO41qxoMpvNHiW2572nFmGsTA2zOz5RWimm+nBG/UhKE3Te5Fp
         QWQ3ha54YkR4RjHx0hWJ8TrNxQ2+AWiSUCZVbvK7JujhAnxaQyKY6F08zHdU3qyzKREh
         FPO2TUMH9nAo22va1On7W5SiPwDQ4EOrBy+yC7aK4BnQUJUnEMV3LdcxPnUNfIBwWa4S
         3Cp/BsUQJ3kHe0LdC/p5nn2ydwG+ZYBhacb/r0Ez76snRXO8pt6Np8aq3fBUCbvgOQsi
         mf16iLUF58ZyndSKeVTaWvxOF4JxW68nPaYu/f+yCEeiLqAvf0J+1J2jgoD/ddm99F/J
         afFQ==
X-Gm-Message-State: AOJu0YzfyjTza/qKIZhltl0mv08VqOOVQ6aYdursL/lou5cmYmm4XKdN
	IVDjQVnN1wex1aw/L+msd7nWAj5t7dw0OgZRnhbWbHCju0Us68I=
X-Google-Smtp-Source: AGHT+IGYqCGnojWJHVdW2IZduoK8mGInmcSp6/2+cqDh1Jh0JpJkOnv0ufA4Rk5k1BA5Vbauhk3mBQ==
X-Received: by 2002:a05:600c:a14:b0:410:ecc2:3072 with SMTP id z20-20020a05600c0a1400b00410ecc23072mr2906118wmp.7.1707931257593;
        Wed, 14 Feb 2024 09:20:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiENfw0/AwN1v1Pv7CWxEzISBfLsuKzdkS92Ab92oONhAvJXiniHKYUq0ag6n66hYCbnekCplTapGPwczQRBRTWs/jSRpXSKq50Ki/lC1eXDq+P3YAk+pGIyVG28TzdtS8dgzGF+iEqpQu18TZVVvh2UiQmXGxqTck2+iKxbPCGw==
Received: from p183 ([46.53.252.131])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d67c4000000b0033b888a0a63sm6820022wrw.0.2024.02.14.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:20:56 -0800 (PST)
Date: Wed, 14 Feb 2024 20:20:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> +#define make_u16(hi__, lo__)  ((u16)(u8)(hi__) << 8 | (u8)(lo__))

	Public Service Announcement

Identifiers representing macro arguments generally don't need to be
undescored. They are local to the macro, they don't leak outside.

	End of Public Service Announcement



Firstly, make_u16() doesn't return u16.

Secondly,

	#define make_u64(hi__, lo__)  ((u64)(hi__) << 32 | (u32)(lo__))

doesn't truncate hi, why?

