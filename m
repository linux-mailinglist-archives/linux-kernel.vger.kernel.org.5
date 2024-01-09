Return-Path: <linux-kernel+bounces-21382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE5828E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1232867B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE473D967;
	Tue,  9 Jan 2024 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrqEk1PO"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C13B789;
	Tue,  9 Jan 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3367632ce7bso2700295f8f.2;
        Tue, 09 Jan 2024 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704831309; x=1705436109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+B0yD7FjBgqTqLo7b2/IVuy2rnma81MvruhVPGvifo=;
        b=UrqEk1POUffrf1aE98dSIWSZikviyFIO4/rL/LYb6+aBFnLHXbjYKRs7UCPJy/EFa7
         P3kIYPrP7cHBa9IA2weL9dMiSQ3iz9kyFssGWVZZ/9kFod6Ig3/EwUaj5ZTMcj3/CUox
         M8QGFxj85ZyrBSqZAebEOJGfXlBaXwVvPzi9HT8VXwag1RNzIKKi50LoR3R5sheUjs8U
         g4HRNW88C1VYxQ+0rb5NQv5vxb3InAExj1/DjfTOyVl/NWV7TgAktvuzmQBJXHXHwTHn
         jAyJt8rpCuLMjHVk1LUdfnH89lwVK2w9/3SkXTmVJd6eKo9DkBF8nZccX4STDxiLDTZW
         5DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831309; x=1705436109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+B0yD7FjBgqTqLo7b2/IVuy2rnma81MvruhVPGvifo=;
        b=jkOxYBBkMZyeJD/NPyblkPJmwRT8MJGbu9s6G8Rccm9grNlZsCInvuedLkVHviz+WJ
         et0NtGZ/a+5ZLAR8WSMk84ygN6dIwziPe0vFkh6JXg/VggFXOuSghgNn1YTncamKlu0r
         BHadx4p8kgXbIVHLJLLStw30GWnJtZWt6SiMDfKtxlPK16QK3aOZ+xnhDuZSXbOEQk1t
         JrIVVOY391uQam1cN937mPl+fwMQpTDlboky70w3TePci1hw3O0ek2X5wDVkI3y1v4Rq
         PWKE7X64pdIBUzyDQ14VRYY3MxhzPEhf2pk71SpwHUI70uVSEKF6ScmMghQYI/ymrSen
         OdtA==
X-Gm-Message-State: AOJu0YySufpR/mn+BJxbW5Ph8EdcamMFJVRgDF7I/iHGJ+YoPYg672pr
	qoiHMulADtDwEjarE+Q+B7k=
X-Google-Smtp-Source: AGHT+IHCUv6AIBjSaTr/8HPaqeDyMqGvcLyT6MaYhYhF7PYV0/3Jv2044yKOg30ZXyxDXKOcj8h8FQ==
X-Received: by 2002:a5d:5406:0:b0:336:5b14:525f with SMTP id g6-20020a5d5406000000b003365b14525fmr1021417wrv.132.1704831309212;
        Tue, 09 Jan 2024 12:15:09 -0800 (PST)
Received: from jernej-laptop.localnet (213-161-3-116.dynamic.telemach.net. [213.161.3.116])
        by smtp.gmail.com with ESMTPSA id cg4-20020a5d5cc4000000b003377c5b8a43sm45539wrb.93.2024.01.09.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 12:15:08 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: fuyao <fuyao@sjterm.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 =?utf-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] gmac: sun8i: r40: add gmac tx_delay support
Date: Tue, 09 Jan 2024 21:15:07 +0100
Message-ID: <22143664.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20240102075807.1a4cac92@kernel.org>
References:
 <ZYKvCQBD-SY9uVLF@debian.cyg> <ZYPmZj8l01eQsDS5@debian.cyg>
 <20240102075807.1a4cac92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 02. januar 2024 ob 16:58:07 CET je Jakub Kicinski napisal(a):
> On Thu, 21 Dec 2023 15:16:54 +0800 fuyao wrote:
> > I don't see it in the user manual also.
> > 
> > it works fine in 100M, but it doesn't work good in 1G without tx_delay
> > in my board.
> > 
> > Read the sdk from allwinner I found in:
> > 
> > https://sourcegraph.com/github.com/tinalinux/linux-3.10/-/blob/arch/arm/boot/dts/sun8iw11p1.dtsi?L1826
> > https://sourcegraph.com/github.com/tinalinux/linux-3.10@r40-v1.y/-/blob/drivers/net/ethernet/allwinner/sunxi-gmac.c?L877
> > 
> > And I add it to my board, it works fine.
> > 
> > So, I think it may be exist register but not documented.
> 
> Unless Allwinner can chime in we should at least document the situation
> clearly in the commit message (incl. what HW+config was tested, exactly)
> and add a comment in the code?
> 

I agree. Fuyao, please do that.

Best regards,
Jernej




