Return-Path: <linux-kernel+bounces-95794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C28752AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3052B1C24C01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF7129A95;
	Thu,  7 Mar 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="r0tuvbzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMAiRVXx"
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635F12F365;
	Thu,  7 Mar 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823800; cv=none; b=dQx0pGF9Xysa1vhUHDwuWIjkJT9eVeMK6REWA1z3zITFZJ5NuSmRqR9jwbeMdB381uYcZugSxU5GX1bMVYcMMRq3Dm2U5heh3ElVB2qwau2x3Mg0luCIHJ1qvGG3kxx6lyPyzbiaZLcggFBbc/QepKOBdRuFdSwrSgPYZd6tF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823800; c=relaxed/simple;
	bh=zrHvih0CRLls3gfTaqe/nco2QOUS/ZrmpGJoEnrrwuI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uVP4BEtUOuoGCmsCe/iEgqI0/YQftIVcS2h1MX+sJU2JbP9tuckBhkz4Ez/r1bVsbMBR3+csgzB+Lag/GUoNsnTMxvsiIJ9DfXApbOKwI++mpcfxkvrjfk5flIRqydrQs5LQTv3xFK5/Pi1HiURL8NLWrSWcKTX5z+khjyfhoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=r0tuvbzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMAiRVXx; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 403272CC00B9;
	Thu,  7 Mar 2024 10:03:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 10:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709823795;
	 x=1709830995; bh=KIk1du4pHCXSqXMFodBfcBDhm0Cr4cLrqXMscpRsEQg=; b=
	r0tuvbzYDU2G/VrHHuosGqT9d0Rw3cKHv6Dja3Jxrfr92jUcWA6aBzINFkHmqsc+
	W0VPxtTJ8B0vC2EEnOjj10f95OpjzDadOL+ys33iJqrTg8dt6h6A0ioD1vUy9eMA
	rQDiBqRQkSnBZPzAryAgcIPLujfFbbQTaz+hhiYXup1yh83mGte/M+WqrDS75stp
	2tn2S7bWM4dirwvRqVwurmSpM4mKZ4dA3+y3UwmilVoT8OJZAYdcOgKoABGNvuCQ
	DseDxJwnKVLzq1eXCX1Zfa1nGfeI+Bygh/lkjPFh+98io7m1+xeCFmZxMh1uq1gJ
	QEGpyLuNpu6sMRWsDUXowA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709823795; x=
	1709830995; bh=KIk1du4pHCXSqXMFodBfcBDhm0Cr4cLrqXMscpRsEQg=; b=I
	MAiRVXx8U8UQHv+vZM3R4xLoWsqTcVM3UY8wf4FghptGdmRky7R7aKeDRrkxCmlU
	6PHp7EG14pk2yboSB2QBFOlfKYC7DTi8Gj7hhiqnGmzXgANPCaSGRKEJwpQqQo+G
	LU5ovHcTsYMe40U3G3h6/XsSKGY9V3rhFgzfEc6G+5QW+c+K/QXyacm+LdwWffUS
	5KwOiWwOSyWsjja1bb+V07UAuBGmHNSHvCmIlgAKOQ/oIk2V8o7FIkKBBjCB/NQ0
	2e7ZOdnJ2lulDwQaf9JwqnKNK3OAkH9n6agTMm0DE+GI//rCz1e+A9cMc6rKX2uC
	QH9+Y3ks/2AkJoHdUqC7g==
X-ME-Sender: <xms:MtfpZdjIhvvj2w5LIjBaYeBRm68khe7SPUWUIPyz3Qzr4DqMiJH59Q>
    <xme:MtfpZSCw6-_D15CzMMJ6aMq4FMi2a38HaisIGgcg1cjfGUuDJtjoZKI4NGvsMsMWJ
    8nh4Z6KFttFTRDe0rk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MtfpZdEVd_wK33nQCCOfgC58V_P6HRkYxs0fK98U48nw3QCN6N9QrA>
    <xmx:MtfpZSR83RszXpjRHFyEGpw4PYmBtg8qqnJj2iwBSZDSGIiLP24o7A>
    <xmx:MtfpZaz3ScCYYHDe4yULQs_p0ex-0Ng_lJ48VBQtqruta0LNNK4Gmg>
    <xmx:M9fpZfEH0QTEMK1lJt6knYQSuFAbpSIeOW9pH5A-AO4-PVMsrOqDdxgBn8g8FLuD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F1F00B6008D; Thu,  7 Mar 2024 10:03:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8d42bd5-5a89-49da-8da4-570e26ecc0e3@app.fastmail.com>
In-Reply-To: 
 <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
References: 
 <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com>
 <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
 <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
Date: Thu, 07 Mar 2024 16:02:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Protsenko" <semen.protsenko@linaro.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "open list" <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Christian Brauner" <brauner@kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "jh80.chung" <jh80.chung@samsung.com>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Oleksij Rempel" <linux@rempel-privat.de>,
 "Manuel Lauss" <manuel.lauss@gmail.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jerome Brunet" <jbrunet@baylibre.com>, yann.gautier@foss.st.com,
 ludovic.barre@st.com,
 =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>,
 "Chen-Yu Tsai" <wens@csie.org>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024, at 22:18, Sam Protsenko wrote:
> On Fri, Mar 1, 2024 at 2:51=E2=80=AFPM Sam Protsenko <semen.protsenko@=
linaro.org> wrote:
>> On Thu, Feb 29, 2024 at 8:56=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:

>
> Sorry, just noticed I commented on the wrong line. Here is the change =
I made:
>
> -               mmc->max_seg_size =3D 0x1000;
> +               mmc->max_seg_size =3D PAGE_SIZE;

I went over all MMC drivers to see what else sets a max_seg_size
smaller than a page and found these:

drivers/mmc/host/alcor.c:       mmc->max_seg_size =3D AU6601_MAX_DMA_BLO=
CK_SIZE; // 0x1000
drivers/mmc/host/au1xmmc.c:             mmc->max_seg_size =3D AU1100_MMC=
_DESCRIPTOR_SIZE; // 64K-1
drivers/mmc/host/dw_mmc.c:              mmc->max_seg_size =3D 0x1000;
drivers/mmc/host/meson-gx-mmc.c:        mmc->max_seg_size =3D mmc->max_r=
eq_size; //  1536 bytes
drivers/mmc/host/mmci_stm32_sdmmc.c:            host->mmc->max_seg_size =
=3D host->variant->stm32_idmabsize_mask; //  GENMASK(12, 5),
drivers/mmc/host/sunxi-mmc.c:   mmc->max_seg_size       =3D (1 << host->=
cfg->idma_des_size_bits); // 1 << 13, only on arm32
drivers/mmc/host/wmt-sdmmc.c:   .max_seg_size =3D 65024,=20

I've tried to add the maintainers to Cc here, these likely all
need attention to work with large page sizes, in case of
meson-gx-mmc it even seems like the limit is less than a 4KB
page, so it will stop working entirely.

There are also a couple of drivers that look like they have
an off-by-one error and pass a segment size of one less than
a power-off-two number, e.g.:

drivers/mmc/host/davinci_mmc.c: mmc->max_seg_size       =3D MAX_CCNT * r=
w_threshold;  // (64k-1) * 32
drivers/mmc/host/atmel-mci.c:           mmc->max_seg_size =3D mmc->max_b=
lk_size * mmc->max_segs; // 4095*256

I think some of these are intentional, while others are
probably bugs.

     Arnd

