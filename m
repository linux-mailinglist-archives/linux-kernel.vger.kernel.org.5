Return-Path: <linux-kernel+bounces-30939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C1832652
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396B71F238F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971FB24208;
	Fri, 19 Jan 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EXuqvTcb"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF5A53;
	Fri, 19 Jan 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655521; cv=none; b=NrdT4tlLaV3TCtr0cZS1GQn+Z3TlajFxDHMktcSGAwJHoKeXhL5z+ldO2+9I082/RIBLwi00F1+He9G/3kZNN9rCW5QJ4nVvVzpx5/Oah4OQAIOzC4EZOs59szYUS4DboYltwhwg1rynS9wwU2VdWtn7r/7cV4xi01bP3ZsO3S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655521; c=relaxed/simple;
	bh=tXJxt9w/oJ0XNk3Nt2w4s8/VSDNpnSFcsu7XbSCZO8E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Y4QnYYf8Wa0yq4S5Fr62kqOmN+5T3AVKVbn8e75v8MV8WO4Q/UvKBmw/Z25J10xPmkp1Yv5lmWpXsPyh9Dy8oi9q09Pf2J54hPacUKmJDPnMmkj5CIKC2s+H7ZSjF7S1toUGGX5SY0kigFQoRLKmGUgB2/TMZZQgMVgcbUsKkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EXuqvTcb; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705655516; x=1706260316; i=markus.elfring@web.de;
	bh=tXJxt9w/oJ0XNk3Nt2w4s8/VSDNpnSFcsu7XbSCZO8E=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=EXuqvTcbYD2Zi90s6T4Q1ox9PYgwfrpbV02TzQ5U+J24VRCAeO+kPE28tr2BImMS
	 o/Gei0iJpLIid7iVOx64jjqKXoTFIslOXrLshxm35HyztQiAEAFco7qi83dCH83LW
	 uItQtW9H+Vd5JgDVXq/KUyq/gnxCRw7rktoDZUHEU3ZQpY77/aIfRpL1KlnONHyc8
	 x177psnPPbiFyttdzXKfYBjlJ2RhXC1o6o0bqVOxfga/8F81tUsWmPpfJ9F8h7DI2
	 eo0CJ1BnnUticEI2AUMYRXw5rBWCxyWr6a+jCc3N2OxqwKv5oZYCrJ7qtjSpeHpKI
	 kHNzlvMtWeLuUf4gkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1rPeMg2Pe8-003JVi; Fri, 19
 Jan 2024 10:06:18 +0100
Message-ID: <a5f974aa-826d-421b-bfe2-bb6c9b43ea9a@web.de>
Date: Fri, 19 Jan 2024 10:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240119074635.265218-1-chentao@kylinos.cn>
Subject: Re: [PATCH] meson-mx-socinfo: Fix possible null-pointer dereference
 issues in meson_mx_socinfo_init
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240119074635.265218-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hyKdlCkKgO+YTVOmB/GLcZr1wgCtUsa5eeb6696qbaPYs4p0tvm
 Wra2BA76jeC0HAYFadK3zTM811Z1GpZWxG4iCWQ5Bk+trVGnKthKiHdAFS2TbN04JmxxTCx
 WONU3Oho+j5ZwCDdVyNhs2AqyTtnjqq4XRtR/jwqQJatLceP9A53aOnjo5HdqunAr+ij8gY
 32k/iA4rAfXkBY8Sfs/ZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UigNfyhaB4k=;UdHpO01shOQaaFwGIPHVxcK+HUZ
 VbqH4e0fYiE5esvL3Xw20BGCS6Cwt3LUi/oLUtC+x9bio1PMIX8BV2MAmQp3BTgYMMF20OV2s
 jqsL5x7oZ0o+ELhtDwM6es78LAWh771mbjZoRvBnaJC+CID8i5WAnCL/4zDH7p0AYLpeLy5Gv
 FB/3CTSv6IRRYiRbs2ORvYZwPgJuFdlyZX8VIcQKygJFT1AadFSzitsqNz5DnRkihyypVIdUs
 rDDY7k8bz1SJu7/2WKLHcuqF30COXLYj4n8Sb1B5Bh6i3X5VWChXMB9riXQn0qix6+P5f6WYb
 Xz/sBicYnxTLFEdn+zL9OVn7nmhKEm8ea2b5Z/fFFHBMY/uTdKL4ZA62LgKhxOEemfQk28Nzq
 2Uhvl5cgCcMptCu7Je+FnAO9YhIU3iENkaphqjl0OF9zi5WnGnMt7/B/Dob4zlkidM3VX9VN8
 oNNOsCvDX/0q1srFjbJw9np1RCttc88P3DJl8sjhLYHl86id10e8U6JC68qkQ59aDvXguINBP
 EbauE4ekg6nsw57Vt4x22stfFyabslQHHx8ORWKZJgk30PB5iU0dJK56ssbDHop23VJY+WAbt
 iQvciVgpuNf0j+CVPcUPS60b2221yJJe2ltNkZS4kOLCtRfP2dFbsDG3Huoxo1vRnONbzLglq
 rso0SDsasPYbKcg1L8UUetmBcoVOT80Z7JWZGPlPXssPTjcqXvCNU5iv5PySJQwYz8hn1aySw
 xxrumNfL/u3EWOwNKRPpfr1aUqNwfpTZ2wJMuUbXHu3DR3DIwtrjXoeqx+1DaNcPD2q0t7a3S
 eppSn08LWTLSaqwodjD3PmTVi8pTRRlbdcEzoFsw6AOVha/U2VNPD7GKCBVftw79J1nwyKkwo
 UuoIn72v07Lx5z6Q+N3yo71kFM48JGGsEqVwUYE3vhSnFS27hm3KCGmJFjtpJ9wrtKOHvEcDU
 abogjg==

> In meson_mx_socinfo_revision, kasprintf() returns a pointer
> to dynamically allocated memory which can be NULL upon failure.
>
> Similarly, the kstrdup_const in the meson_mx_socinfo_soc_id
> returns a null pointer when it fails. Ensure the allocation was successf=
ul
> by checking the pointer validity. Avoid null pointer dereference issues.

Would you like to add the tag =E2=80=9CFixes=E2=80=9D for the completion o=
f the error handling
in this function implementation?


=E2=80=A6
> +++ b/drivers/soc/amlogic/meson-mx-socinfo.c
> @@ -160,6 +160,12 @@ static int __init meson_mx_socinfo_init(void)
>  							   metal_rev);
>  	soc_dev_attr->soc_id =3D meson_mx_socinfo_soc_id(major_ver, metal_rev)=
;
>
> +	if (!soc_dev_attr->revision || !soc_dev_attr->soc_id) {

I suggest to split such a check for null pointers.


> +		kfree_const(soc_dev_attr->revision);
> +		kfree_const(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr);
> +		return -ENOMEM;
> +	}
>  	soc_dev =3D soc_device_register(soc_dev_attr);
>  	if (IS_ERR(soc_dev)) {
>  		kfree_const(soc_dev_attr->revision);

Please use a goto chain for better exception handling.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

