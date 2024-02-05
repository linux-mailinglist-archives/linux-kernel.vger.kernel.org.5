Return-Path: <linux-kernel+bounces-53154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4584A154
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0038B1C2245F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1802AF18;
	Mon,  5 Feb 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="z8OZncQm"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB844C9C;
	Mon,  5 Feb 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155441; cv=none; b=uzmAQBgJNpwSDluhTYMc+RSOffIB+qplIcZcWPnpQaZ9ASqbttfnx1SkVdWJWNPGB47z+BUK5joVved8YeLOovAiY5joWXn0QYtGsELb1oRZFPZ/hjEcVKAqTdbUSAU+3bkxRL2iWX2/oH9rkTXaeje9jH/6sMjGZcmi2uu+dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155441; c=relaxed/simple;
	bh=3bp8mP5LU2HDSVtF79gXm0Qv9vYGRpul41cBty4cm1c=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyI+wgknH3ximWV8akSIkIwwwLMOTN7DnZPqQwoRSdPsc6EpNCw1kUtBRgS+NepyRquwhkGj/AKl/sOm72o+lDVs5EeDOFYCVixUcDQTuHazI1TJwsto3I/OCJJY7XE5s0CDiKYr1xAuKczFvdavVU+vRGJ7qUEiD/dCqVrtPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=z8OZncQm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TTDSB2BbZz9t3K;
	Mon,  5 Feb 2024 18:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707155434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43fZUpSLN34Hcqn5D5P20QB99YjMTO5/RY6QxJlWZcc=;
	b=z8OZncQmPoCuukgcv9bayNYF6H1VQwFrd6unqx8VhMMFMtIrMhf/fNo+5AotMY6TuM81bg
	7Fkt5eZ9m3iSJOyUxq5WZvUhDgu+YdZbuB9ewPgKwL4VTpT5d9rTXZEfja5Y5+EJDjiZ6j
	UVuPVWVlS0295kPAw5dvwfBywpJ7yGTuQ4z3phV0l5youxBWccl8Zp3UubAGZjpZXnqQGN
	CG6h/RwBYk4/+hZb0mtOqEyQCzG9QtQ6W6B1PUBtzL/KTEya0zUcicy9Qr52W2hHtAx6jj
	57HMGESf+WBq5jGEoYg55vPBZjcvjVIULphNXzZMIzgXfv2YOC3IZ522yOYEiA==
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-1-96a46a2d8c9b@oltmanns.dev>
 <2717565.mvXUDI8C0e@jernej-laptop>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team
 <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] clk: sunxi-ng: nkm: Support constraints on m/n
 ratio and parent rate
In-reply-to: <2717565.mvXUDI8C0e@jernej-laptop>
Date: Mon, 05 Feb 2024 18:50:27 +0100
Message-ID: <87il32ztp8.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On 2024-02-05 at 18:45:27 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> Dne ponedeljek, 05. februar 2024 ob 16:22:24 CET je Frank Oltmanns napisa=
l(a):
>> The Allwinner A64 manual lists the following constraints for the
>> PLL-MIPI clock:
>>  - M/N <=3D 3
>>  - (PLL_VIDEO0)/M >=3D 24MHz
>>
>> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
>> these constraints.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>
> Haven't we discussed that this patch is unnecessary because same effect c=
an
> be reached by limiting minimum frequency?

The patch for ccu_nm was unnecessary:
https://lore.kernel.org/all/87jzoug2jz.fsf@oltmanns.dev/

Unfortunately, we still need this one.

Best regards,
  Frank

>
> Best regards,
> Jernej
>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 21 +++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_n=
km.c
>> index 853f84398e2b..1168d894d636 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -16,6 +16,20 @@ struct _ccu_nkm {
>>  	unsigned long	m, min_m, max_m;
>>  };
>>
>> +static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned l=
ong parent,
>> +				  unsigned long n, unsigned long m)
>> +{
>> +	struct ccu_nkm *nkm =3D container_of(common, struct ccu_nkm, common);
>> +
>> +	if (nkm->max_m_n_ratio && (m > nkm->max_m_n_ratio * n))
>> +		return false;
>> +
>> +	if (nkm->min_parent_m_ratio && (parent < nkm->min_parent_m_ratio * m))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_commo=
n *common,
>>  						       struct clk_hw *parent_hw,
>>  						       unsigned long *parent, unsigned long rate,
>> @@ -31,6 +45,10 @@ static unsigned long ccu_nkm_find_best_with_parent_ad=
j(struct ccu_common *common
>>  				unsigned long tmp_rate, tmp_parent;
>>
>>  				tmp_parent =3D clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
>> +
>> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
>> +					continue;
>> +
>>  				tmp_rate =3D tmp_parent * _n * _k / _m;
>>
>>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
>> @@ -64,6 +82,9 @@ static unsigned long ccu_nkm_find_best(unsigned long p=
arent, unsigned long rate,
>>  	for (_k =3D nkm->min_k; _k <=3D nkm->max_k; _k++) {
>>  		for (_n =3D nkm->min_n; _n <=3D nkm->max_n; _n++) {
>>  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
>> +				if (!ccu_nkm_is_valid_rate(common, parent, _n, _m))
>> +					continue;
>> +
>>  				unsigned long tmp_rate;
>>
>>  				tmp_rate =3D parent * _n * _k / _m;
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_n=
km.h
>> index 6601defb3f38..c409212ee40e 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
>> @@ -27,6 +27,8 @@ struct ccu_nkm {
>>  	struct ccu_mux_internal	mux;
>>
>>  	unsigned int		fixed_post_div;
>> +	unsigned long		max_m_n_ratio;
>> +	unsigned long		min_parent_m_ratio;
>>
>>  	struct ccu_common	common;
>>  };
>>
>>

