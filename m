Return-Path: <linux-kernel+bounces-14693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA48220C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017ED284041
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F52156E8;
	Tue,  2 Jan 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B17v+BgF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F3156D4;
	Tue,  2 Jan 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 89AA440E0197;
	Tue,  2 Jan 2024 18:08:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q0k_IJQCGsqP; Tue,  2 Jan 2024 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704218924; bh=v3NyClcomG1/HfmBt2wrCT5atHNkOtucru3CNjcR+L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B17v+BgF7jrid9KeVpHKGGK4IiKoC/E/PhSWWtzqcD8mDzMZTqGF0Rz65KP82KAHT
	 TYWhwLBCFMOE0LfYXpbyOfwlqHHI1XHuC6iy9w1FjktxuZuLyU+GVObBl5DMIuqoMN
	 lp18la9IQ34hd3L5SyMvcjugql+zJshB1J5t8GnWGSELCtMSm/MHd0VBaFoyaClFN5
	 wQnlI5ohMuhGvxgqfA97GXBx1jmTZIH3RbUfpLKDeWyv1V/UjktRT7NglFHaC0dKan
	 CO9OrK7++zH8ItOgP3WKqgTcCrzz/qFNEqJof3HsWWiM6IRnkSZTYBAMdzWgC9quCz
	 C/PafimLnhiJVJCJQyUzI7/xtBrIO+Uv6u20p2+ghXtmsqluSyVx8p3xo1Cu3ZFHAG
	 NHT5Iu23Csdk/yQK+xfcw6olzGG+sfwRbpPyMz7RE/WQ9WsBbGkY9Hmu+O5zvcoQz3
	 O6CiTpqLEuRbRawCQWphlJ2tYYlINOA8GRqW7SqIifFIMaGy3+N3D8aC1+6/Y1OwLO
	 JMDJmtyqk+8Ik0TgjcRgCALjWymOj8ivQk/DPEf1Rfp3PZVIn/JDFPq0pQfF2JZyQk
	 /34Jc8+Rmws5xmY3ijTeWahef1sLlrIrVaSu6K+zL7v7vzc/P6lJ/dEllbKrL9cBG3
	 4MoJ3260kJxOOyOaAd5Ee5a8=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C32F40E00C7;
	Tue,  2 Jan 2024 18:08:38 +0000 (UTC)
Date: Tue, 2 Jan 2024 19:08:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] EDAC/skx_common: Filter out the invalid address
Message-ID: <20240102180833.GHZZRRIWAHmLW6eqrF@fat_crate.local>
References: <20231207014512.78564-1-qiuxu.zhuo@intel.com>
 <SJ1PR11MB6083F4553DE16D2B7878C94FFC61A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083F4553DE16D2B7878C94FFC61A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Jan 02, 2024 at 05:37:20PM +0000, Luck, Tony wrote:
> > Decoding an invalid address with certain firmware decoders could
> > cause a #PF (Page Fault) in the EFI runtime context, which could
> > subsequently hang the system. To make {i10nm,skx}_edac more robust
> > against such bogus firmware decoders, filter out invalid addresses
> > before allowing the firmware decoder to process them.
> 
> Applied. Thanks.
> 
> [Boris: This one with a "Link:" tag]

Thanks! :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

