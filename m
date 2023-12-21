Return-Path: <linux-kernel+bounces-8006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D1481B07C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED92A1C233FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9425171D3;
	Thu, 21 Dec 2023 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="YoxynidC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzaUFC6d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9A171A1;
	Thu, 21 Dec 2023 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1C8B75C01C4;
	Thu, 21 Dec 2023 03:41:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 21 Dec 2023 03:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703148096;
	 x=1703234496; bh=uDYCns7R2c9+ba4N41tqq3RlwSG0Hhskkv8O0oTsnv0=; b=
	YoxynidCHbY15rnJINRcioZqvc0TbF6Vi+f/gt9wZaNAmDJ7PZmSEeKs/3f3y4+t
	4mTHaUA0e2yFRRkVQ/K9T2NHAhmDd/N1LyrOdFW6kayao81YBCajO1ceInt8lM0B
	iMlxcT/xnHplv0u8QjLSJWfC9AAb0r7zdzAV18zaoGYKxgmd5jT9FjOlg/01iHOB
	Ac1Y2an9M21ZcyRMIy41bw0sk5wuQyttyUrI/cuczaGy6sM0xoXb6NCUkY/iR8q7
	+VVcCnoqN6SSCsLAsiYKulxEtmYkjbqKe9jTH5S7Rk4pMhwY8uLYWp6rNzZtqnyw
	6U5Hd0bcwq8F6FPQ92oH4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703148096; x=
	1703234496; bh=uDYCns7R2c9+ba4N41tqq3RlwSG0Hhskkv8O0oTsnv0=; b=Z
	zaUFC6duztSx+Frn4etT3WSzBTqPNPE4aExazCG+lUg/NxSo/oiOBT6gI19p73IR
	2srVvr1Ajc6+7ERgAjHHmMKzudwQlznxzTOFggFBmXngEHjRcjGZvCk229UYBzIm
	2Xqj5YAy5Gktqd27YgocvdJiYksozuovZozzMopX1z6BeQv/NZBatdHTGa5rzPGa
	7Kfxb3Ub1LSqz6J2VhXs0EnCqTS2BN2yT4R+qxNdfaqUD+wxkLH0YYL4f8a0Pa+J
	oIIzi0ZbmmPwHPrT/CbhErcJFnDKTzra7LmNT/n5j9u1zsO7++BFwLS9gNf1Mfxh
	2hTokzPxLVKw4RlhNVJLw==
X-ME-Sender: <xms:P_qDZdEiVsKIKUmp99ZRZ6RETqc9yWM8YFlcz6z41LNbvIr55cZqFg>
    <xme:P_qDZSW1lsA8FlKBBeYO7lFT0V14hMgaFiZobQODagtgRSOCvN7JcS9wnCHXPJjgk
    YxmZDTdn5xXBMwViWQ>
X-ME-Received: <xmr:P_qDZfK2ZnJlW24drH5S-jzm4pMf63ngjft5eHvA2EtKcUEZ7p4JdK3Tr1t4csqYm_ZAeGt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepkeefffeujeevueejueegleelhedtgedvledukedttdffhfeifeelvdduheefjeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:P_qDZTG9FMb1gGNZpIAt1BJ4jg1Q2sj0VNSvPdl9vL9JGh9ZBFQt5A>
    <xmx:P_qDZTVYPhwijaUNQzlyI_45rLEGaYBW8dY1fTWCTWSzLNBrmumQGw>
    <xmx:P_qDZePIjdHqDie4dwNLzrYt6x8DQf_Wv9pBBGNbvptVF86aKk1qwg>
    <xmx:QPqDZZd3_9dAFVe6tuMdQkWqMERBah4W2EY_1r47YbOdsfocCnYC2g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 03:41:32 -0500 (EST)
Message-ID: <cc07eae78c07e09e378cf37494b0f973905130ff.camel@ljones.dev>
Subject: Re: [PATCH v1 2/7] ALSA: hda: cs35l41: Support additional ASUS ROG
 2023 models
From: Luke Jones <luke@ljones.dev>
To: Stefan Binding <sbinding@opensource.cirrus.com>, Jaroslav Kysela
	 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Date: Thu, 21 Dec 2023 21:41:26 +1300
In-Reply-To: <20231218151221.388745-3-sbinding@opensource.cirrus.com>
References: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
	 <20231218151221.388745-3-sbinding@opensource.cirrus.com>
Autocrypt: addr=luke@ljones.dev; prefer-encrypt=mutual;
 keydata=mQENBGRG7LwBCADC4B1XNMyJpOmtXVhN12glMXTVTV9RxgqunqQt7g+3RAG8kfYcAE+VnCUbcdtjeLRYhVka1zE86VBp0cyXiG9IYNlGZhtBFeik5NdgFt2fBXhDV3fm+91ARLvW7iOxHepyG+jepFf18oI6mPXC7cBzysosEkzdHl0Rm5z9rUoXksVzlT3i76s1AfQL3empFKbKkwSZsMVY/MLzWjPjVloMPqxfwpCex6PHnHfZ37VabsI3CG5Whmo3B+kFvpAYvCZZKYTjGDuFfFEH5Ba6FeY0xNSJYGyvuE8LY1VehipZtEaqnxiNP7kU0t5ZTX7nfDbi9a7uaqqHdPAJDCitJPhTABEBAAG0HEx1a2UgSm9uZXMgPGx1a2VAbGpvbmVzLmRldj6JAVEEEwEIADsWIQRZERbOg6XlNi+ijnEwmht7rUENtAUCZEbsvAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRAwmht7rUENtGoxB/wNh2J4t/Scb94yAUNGXje65tuC9ej+XHtfeDCKhQW0WchSDaXpZHLn47b9o+nBaICIaa1WR29viPNAk4Ss7k0lx5w7A/vSYrGcpO69DLWwMhqk+pVn+RPfeuGKwxGhvEjZkWSwIYXtBDfVXM7Paiq6ZOiaYOlFokbvV1s1NfIaxkTdJwuFK14SYfn3CE1XdyUQ2EQ9572yATPwElcaNp9qXo/UE/yjub7VAkFhg+EI9sXXV0pi+TKWKrF0htpmjoHBzzRz4MdqhE3C6lj8aIrfmRg3lWxUpdYbTVVQvfp0PCWCnXq6y+02QU1RG/WgwHOohDVWr+y5BhzSMX+kP5LsuQENBGRG7LwBCADVsGLOw5YmYJXZQ8FWfwWmHJ6dalWsjI4S6ktBZ+u7gFXJwHbzYw3AYzTrWiBUU+ii0lUtVEQRfh4VeMrO/iufxGMwjquedZeZNzxU/nysEoh+D9cGwgPff
	RWhMBuktASgwULSyaR095YPslFfU0w/iZtoz3uM3YYedFGXyrydb2ZUv+i88LUKiY5qK+4HqaG6wsaS0Bx8vKymmVMSbZi/PWYHS5w+w5q71Z9fNRdF3MTMPIVvFH6mH1AULh6hRK/vH0UMEc2tN93szVupFvLBJVxf2doHjGNzvrytq0nTrRnl7jJspehC29cDKtJ6DtKmaw470bhClgAlE085UhuzABEBAAGJATYEGAEIACAWIQRZERbOg6XlNi+ijnEwmht7rUENtAUCZEbsvAIbDAAKCRAwmht7rUENtKM8B/9UyyyRA6/NQx2xzEibKxyYhHfP3OCPCbnFAyWT0TWF7OVSQg/Hc6PnrhDVUXLyrSxkXUaRtmxjxqhphhODH62jGrCn4nciczcrVwswFP53CMRQXdlpyW72LZ3wSo1XK1twWqFP48L+l00ZEbP3NXYk2rbuNKbyB6SBlmYZu+L6mEfZ+/eAoAgh9+ZCthNg+RsSwqfYwoO+bZXCjuWzLX2Tljg2yYhg+f9TotR6cW+sbcWi5cqjDmezsV0TIkE3FK9LN5Kzc8gUI/jSDSrW6rf72KTw7RgGdywW2VaA/XKz6GkaGReHeoZAetK9/2jxL6xQwDzr5gLUEuTBXG2lJ79O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-18 at 15:12 +0000, Stefan Binding wrote:
> Add new model entries into configuration table.
>=20
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
> =C2=A0sound/pci/hda/cs35l41_hda_property.c | 36
> ++++++++++++++++++++++++++++
> =C2=A01 file changed, 36 insertions(+)
>=20
> diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> index f90423ded85d..a0d808ed640a 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -42,6 +42,24 @@ static const struct cs35l41_config
> cs35l41_config_table[] =3D {
> =C2=A0 * in the ACPI. The Reset GPIO is also valid, so we can use the
> Reset defined in _DSD.
> =C2=A0 */
> =C2=A0	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT,
> CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
> +	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431463", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431473", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "10431483", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "10431493", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "104314D3", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "104314E3", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431503", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
> +	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> +	{ "10431C9F", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431CAF", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431CCF", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431CDF", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431CEF", SPI, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT,
> CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> =C2=A0	{}
> =C2=A0};
> =C2=A0

Very good to see this work done. I have tested on 3 models and each one
has very good sound now. Many thanks!

> @@ -316,6 +334,24 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] =3D {
> =C2=A0	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
> =C2=A0	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
> =C2=A0	{ "CSC3551", "103C89C6", generic_dsd_config },
> +	{ "CSC3551", "10431433", generic_dsd_config },
> +	{ "CSC3551", "10431463", generic_dsd_config },
> +	{ "CSC3551", "10431473", generic_dsd_config },
> +	{ "CSC3551", "10431483", generic_dsd_config },
> +	{ "CSC3551", "10431493", generic_dsd_config },
> +	{ "CSC3551", "104314D3", generic_dsd_config },
> +	{ "CSC3551", "104314E3", generic_dsd_config },
> +	{ "CSC3551", "10431503", generic_dsd_config },
> +	{ "CSC3551", "10431533", generic_dsd_config },
> +	{ "CSC3551", "10431573", generic_dsd_config },
> +	{ "CSC3551", "10431663", generic_dsd_config },
> +	{ "CSC3551", "104317F3", generic_dsd_config },
> +	{ "CSC3551", "10431C9F", generic_dsd_config },
> +	{ "CSC3551", "10431CAF", generic_dsd_config },
> +	{ "CSC3551", "10431CCF", generic_dsd_config },
> +	{ "CSC3551", "10431CDF", generic_dsd_config },
> +	{ "CSC3551", "10431CEF", generic_dsd_config },
> +	{ "CSC3551", "10431D1F", generic_dsd_config },
> =C2=A0	{}
> =C2=A0};
> =C2=A0


