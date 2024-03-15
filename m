Return-Path: <linux-kernel+bounces-104374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D890887CCF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161C31C2250E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A651B94A;
	Fri, 15 Mar 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KI8IzfcJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VGT2EROv"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA91BDD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503528; cv=none; b=FgqInSpZOwyPcjkg8ppQ8kFwFzFPcjDWhX3cxA6KwE6tCcOB4DJjeDz3BBkMD37QQbOzSgFAhxLRLDDV4LEQa8JfROp6jiV0UdqVsIR8UNII5qVuAChxXJazhYANm0E8ob8/agFvsJXOd6XdvUKBuV2afn9akzSSjJneLCytkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503528; c=relaxed/simple;
	bh=rcK/ldyvDa/8RW+IpbhKSxMPhLTBwFXqCdlQe78OaUc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MKy0e98VhBcBfwypxxbXJw3LbD9rJmX/uZeuC+LK8hS/xYmMs/3PX03+MivODa5KWXkQrcsyL4N14BgR+SdC68dbo0kTzYm0JJ5+UA7FIWjycuhjEsDnXOzxJbiJivw5EaJobpBSdcM1dHSH+F+D7RljBRYo91Q1+BxfGPnYb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KI8IzfcJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VGT2EROv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C224E138013F;
	Fri, 15 Mar 2024 07:52:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 15 Mar 2024 07:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710503524;
	 x=1710589924; bh=jknW9WWF+VdgstTIF8AQnFVI9wHG/mgCmIn+HmwlOdw=; b=
	KI8IzfcJ4vTIbmohutG4dfv3tHJJTk+CXusIzaSdTSIWiN8x1RdPuUwERQElws93
	SBFql9/PXjhILZr1gp0MFXTJyysdi8In/mN1MotpEuQlm+Hplpq2dGywQOuno457
	+sZou9WzvPKLHCux1b7mN9573+WC8wHQB8+4p3kBrFyHEb5oKk1SsF+FefK74s+P
	y6TRXW40MoKM85yFlDTM9lAVc0LDOEsq2wwb8gobf5E8jF6Yba3vzUBNqJwfYO15
	xMjQ12uN8BAwi0XyHPCUxK67h1v48dizm9ba9jBhC4YBOpikGZszY4ZcJ/Bn5uIK
	usvyFKNN6KdBzk4Obxhy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710503524; x=
	1710589924; bh=jknW9WWF+VdgstTIF8AQnFVI9wHG/mgCmIn+HmwlOdw=; b=V
	GT2EROvLKfijX5fxg+NdPeLtNRxHqIomIgOB82h3E/KX6qy5Bn2SLNCb5aHzatDk
	jnTRnm9VdqbsE6G5VVUWwHvaiWWJpoRWCGZOuEbCJUfrfHHCD+sKZ7UnJXFGzKGo
	R3brSLqD+JgDZl+LIab+lvCq3OBniLhUQB01W8cUe48ilKmrs3K4L+epTQGRDTzo
	Mevx0FJTUFEq0iMEm1bgsfIftGPBB1BSr+rdF/NjYnBZMKKeoW00rfFe7uY8MTMv
	3iXFbpOXdCHY1NN5k5T4OTlQ7MLIs7yylA3MY3E55K0ErsRHcOCY2swVy946nq5m
	IzV+dbAJhjMv4wGkhbZLA==
X-ME-Sender: <xms:ZDb0ZUB-1swkFt1luRvfnZbVVGpFhjelh8YAQkAJy2rngp6E8vR4JA>
    <xme:ZDb0ZWhdtxcFDWxH4PNzao3x6ODN8Um2uTTWPsYTkvSYYE1lRxadHlXcx4BtrwYpM
    1TiS4u8hwUsYsGkLKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ZDb0ZXmNPhq_dzU6pK6CaT4CjpDEGRTVhndxwhxjn3TOi3jx9V0igQ>
    <xmx:ZDb0ZaxeLP54gxTAzgXMi7C1IaYJS4MaATWLLSKwzhg99LS57fwkqQ>
    <xmx:ZDb0ZZSbxsBZaghZzGLpj1eBsXkGn5tqH1MJEBCkwXHDfBzMUNLoFg>
    <xmx:ZDb0ZVbSrcnB1TEoqvNAjp1vCchCJLwwkl0LO_IBgOVIpAv_OmkBTA>
    <xmx:ZDb0ZaBXps3Spk1wT1ys6L1OZcrv7YtgijhYRbrcjYHvNkotKr703A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1ACC4B6008D; Fri, 15 Mar 2024 07:52:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d91cf190-e583-422f-884d-79552b674f72@app.fastmail.com>
In-Reply-To: <b3e3f664-f8ad-41d7-b8d5-3c83818ff489@huawei.com>
References: <20240315063154.696633-1-liuyuntao12@huawei.com>
 <CAMj1kXH+FaddHV5--kqB_wVgw_M682MvchPB1BoCuDuA6vVyvg@mail.gmail.com>
 <d7a1996f-f558-4cea-b8ca-eb071d02c6d4@huawei.com>
 <CAMj1kXHP-M7hTsCmorgzvDiPB1jRXHciJrXjJR82zmkxUTD-5Q@mail.gmail.com>
 <b3e3f664-f8ad-41d7-b8d5-3c83818ff489@huawei.com>
Date: Fri, 15 Mar 2024 12:51:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>, "Ard Biesheuvel" <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Fangrui Song" <maskray@google.com>
Subject: Re: [PATCH-next v3] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024, at 12:48, liuyuntao (F) wrote:
> On 2024/3/15 18:46, Ard Biesheuvel wrote:
>> @@ -28,6 +28,7 @@
>>                                     -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRR=
CHR \
>>                                     -DEFI_HAVE_STRCMP -fno-builtin -f=
pic \
>>                                     $(call cc-option,-mno-single-pic-=
base)
>> +cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $(=
CFLAGS-y))
>>   cflags-$(CONFIG_RISCV)         +=3D -fpic -DNO_ALTERNATIVE -mno-rel=
ax
>>   cflags-$(CONFIG_LOONGARCH)     +=3D -fpie
>
> Another error:
> cannot initialize array of =E2=80=98short unsigned int=E2=80=99 from a=
 string literal=20
> with type array of =E2=80=98unsigned int=E2=80=99
>   17 | static const efi_char16_t shim_MokSBState_name[] =3D L"MokSBSta=
teRT";

The line sets cflags-y to an empty string.

It probably should have been

cflags-$(CONFIG_ARM)           :=3D $(filter-out -fdata-sections, $(cfla=
gs-y))

(small cflags instead of CFLAGS).

     Arnd

