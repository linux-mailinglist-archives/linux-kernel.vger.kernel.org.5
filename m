Return-Path: <linux-kernel+bounces-15194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6937C822835
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15781F23A19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5438F179A1;
	Wed,  3 Jan 2024 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii+G2f08"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99918021;
	Wed,  3 Jan 2024 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28ceae32e9fso88614a91.1;
        Tue, 02 Jan 2024 22:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704261891; x=1704866691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RADEDc9Gi3yeGmgXekpn/ZMo5Gqri1fLzJEVnaWXUjc=;
        b=ii+G2f083fS29py30lKeyifbquA64GgRt1scpwQH9fR+N/7t8vKBmzusxB91PUdmEK
         4ARZ3HonxQHX0uGR31nekjynMg3QYhKHbdymk3yMBb1BTsxAUHOd8JvDdG5harZNmcWB
         krx//XClRHGuuur15vKuRtsv2DLubcy8nlio0lzkF5osRSKy5ZNrdmTxh1qSeq0BDvYa
         IDdGd20GvBO8EAC+NblY12fGPCe5fmp4d1bCXc4x1NaUtIiyebCMBiwLDMUuBZNTpQ34
         HIVjwvitrMOJsRZQsDmZ1NeqRHYctB1LI+YDzu3fBOZgS+UhYne189f/8B2ly0e8G5RI
         dWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704261891; x=1704866691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RADEDc9Gi3yeGmgXekpn/ZMo5Gqri1fLzJEVnaWXUjc=;
        b=fkN7SYsh0oo5EL+o9ZkAduBQ8DGhMbBB8ScdcZqmV0Aj0N7z4+IrSFHKkCZVGuuxyR
         bbirYbefmGJh81Uxo5c0uY0a7OKLjvceaz10L+YHR1Qp0uQtixr/2Jaw5ozkectTwv+A
         FoUlc67nxry5A0iJpMpM4QBgAZJjaIe153LqLk5PBh6reNxXoY/HzJL31umfAla8vbJh
         3QY2p3RA3qg4+1sa4xKxJWlLD4POfgo4OOzSIIZn5HusblE8DJNDRTvdc0t0EI8/bAxT
         ufN3wQldl9slrHoyAJSfUr9D1SFpzRC71gYQr4WeMc0kOd0MlWnonmu1ZuR2JDPaufpQ
         xETA==
X-Gm-Message-State: AOJu0YyMNggOLyGzAJNz1WF8vy605+rlapbalqlrDU2RH80uZp6FyBjF
	LBhmzDo3CgBKHyTZ00Vunew=
X-Google-Smtp-Source: AGHT+IFqHi+Z9RaxmTv01e7Lhq19U4PDLeD1/DLeP/+2Nj+9uvZb6Eflr8CAJzBj7s8A4fjMAeUQ9w==
X-Received: by 2002:a17:90a:4701:b0:28c:b90c:9fb8 with SMTP id h1-20020a17090a470100b0028cb90c9fb8mr2128463pjg.28.1704261890733;
        Tue, 02 Jan 2024 22:04:50 -0800 (PST)
Received: from fedora (c-24-4-59-2.hsd1.ca.comcast.net. [24.4.59.2])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a46c800b0028caac8d061sm665404pjg.12.2024.01.02.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 22:04:50 -0800 (PST)
Date: Tue, 2 Jan 2024 22:04:47 -0800
From: Tao Ren <rentao.bupt@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	taoren@fb.com
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Wedge400 BMC
Message-ID: <ZZT4/w2eVzMhtsPx@fedora>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-6-rentao.bupt@gmail.com>
 <20231220082714.GA17989@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220082714.GA17989@wunner.de>

Hi Lukas,

On Wed, Dec 20, 2023 at 09:27:14AM +0100, Lukas Wunner wrote:
> On Mon, Aug 24, 2020 at 02:19:48PM -0700, rentao.bupt@gmail.com wrote:
> > Add initial version of device tree for Facebook Wedge400 (AST2500) BMC.
> [...]
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
> [...]
> > +		tpmdev@0 {
> > +			compatible = "tcg,tpm_tis-spi";
> 
> What's the chip used on this board?  Going forward, the DT schema for TPMs
> requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".

Most likely it is "infineon,slb9670", but let me double confirm and will
prepare a patch for fix later.

Cheers,

- Tao

