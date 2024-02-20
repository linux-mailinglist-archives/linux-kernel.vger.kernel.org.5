Return-Path: <linux-kernel+bounces-72878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E885BA00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359FF1C24A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6540679E7;
	Tue, 20 Feb 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BLdU6PEu"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E165BD9;
	Tue, 20 Feb 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427448; cv=none; b=NC20K2+LOAkvQA4956UXuvDUepetV0srKbQYauKXLNyJC9B39+S7dchpwBjoIbXAci/712k0BDg8JXXZMq1DgV+aX8Y8lBKM10Ikg10ARq/32VnZXRuiXFBECzk5K9q1LN3Yef9/57NOEv2Tdx7pdj6BLEte6tnzQpw2KaWxkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427448; c=relaxed/simple;
	bh=MpJcVGRKO8AWBDMnssLpCilOGC18nfaO9n9RoVZq7VQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cgEql6SejxSuarVPtVUuOgkRufbQN6a507YkaeJ8lXezjFlr7svcFkBdBz3qWTzuqaGVWbWS7+/v+feZy8pk/2hnT6DIs/yvNk3HUroEPA0MBPOYXe8NKG8J/7b30wcrbVLqjpvlyeZXhW0eOemNnDS+gZ7gv2b5s4DMRaV3QQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BLdU6PEu; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708427438; x=1709032238; i=markus.elfring@web.de;
	bh=MpJcVGRKO8AWBDMnssLpCilOGC18nfaO9n9RoVZq7VQ=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=BLdU6PEuy96My08QHX+sfAMRWW4IK1X4d0T4z7p4DxV7MRkglWrcZf/j/tZKdw52
	 YPMAa2l6FxXjQdxzj85XS/JNEH9oDG/yKaghQ2vCY2NfS1Kb49HmyUj+GrUD85WqQ
	 8RNDEIiRbmSjIwPbGf/sSU2rQRZhM51J48MM7HybPKuk1Wofxj67i5sJb8fCQZu0v
	 W/79FPqhyfb5sz0FQ05r+Usub8KlNKiZYpi0CoK3MsPsiy0LZ+Q9NgLIEq6arb5/3
	 gu86okYONMl5QBxcn6SytaLQHWAyDAtkOmAFfD5zc4XMnhGSw7Qy4gsQb/CGAeWec
	 m/95GOLhnMPpFIYZBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1rZ6Xk3SFY-007pjU; Tue, 20
 Feb 2024 11:56:00 +0100
Message-ID: <9ff4221a-7083-4cb1-abde-1690f655da8d@web.de>
Date: Tue, 20 Feb 2024 11:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johan Hovold <johan+linaro@kernel.org>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Bjorn Andersson <andersson@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Rob Clark <robdclark@gmail.com>, stable@vger.kernel.org
References: <20240217150228.5788-4-johan+linaro@kernel.org>
Subject: Re: [PATCH 3/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240217150228.5788-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+nHgQKTeGuYog2KEpVvwroQxHKbVWgy4x84LyT/hTMOvc2YQpn3
 JDDJBBZ8e8iXt3Iuyj6UFT2vAkr8MqMibV6zXbFxjjJ4NonyB3VINxG4cgtMo5Xs7xuC6zv
 xHHA+wCH+zFVfPWvJKoIfdB4zOgAfy83sRz8V39oAy7aiZgIKyhsi1FhkeElCu/itLaX0BA
 SMxSEIL5gaOlUNFNP274g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOKHz1US+0c=;Y7LOb2uGXWAxALKRNeJNoMXdSED
 6mThPuSgax6MusWH8Ux/RV+9w1zP98fwHF/F/EFha/52Eso2NCDEZICzFoaqBbjVZwC8X9iXj
 imqXDHI+XMO0+ZsKtOfqx24v88gE5o5vzibabRrgXDJNXGYIMVRv0FhA3zBLzLImf+0yKA0w3
 JipXGp3SXIfH7L7HV9OeJp/lRlCX0T2dcB4emjiyAhry5gg7pglw5q81w+eBAmMASEC7p3QFl
 fNJMxuiOt8h2Rezr4SEiSyEQA6eYjV9YL2u7jd2D7a/Z782fqk3AH3QRs5XYKldiKIQ/ET21w
 kQy5vQRVco7VAXTQBMM4nu+jjOcrp7VwntKu1Lv8lSUeYMgoPk+03t1Jfd7Wq+v0DumL+b69s
 EFpggdlfcwjmUZiY1H5L0aypyi1fqDno1dcoD3BThjr7HInZntawd5DklobDax+czHsflIRKo
 EEald0kztZeVc20C//rszyjaE0lRLHAnbS1xEbuUhgIY6wQNfjOWsKpTlwmKkxJhg+G8V87Hw
 CsGHwCQpWo8JUQ2u8u13to8icfvbIURNZ/+0TOfimg6fk1e3Xp6tk5ZST+n0FupyGgbuzh8Xk
 /ckHy9ppsFBiMNkezud3jl9lRX5YB1WBEQYzDYOCWdxsFvo3mw715qMWQEMJjar3JQR4i/NFh
 wpz15f441+KtAxdh9D+nYKtO57bx/KSH6YPyS0OgfVYWQnCwWw9/FSkWuNj+8E9Xouf+xnsSV
 7i9vSiZZCGaVCFmj7xKEWlGyBccfvDxkylTO9r0FdjfgxCZQFBHfYnKaMD47c7kVBC5lznyEq
 1ZP+jYKEtNDnFoMJvSTvMXP1v6aJ26Z0pgxbocw6whsgI=

=E2=80=A6
> Specifically, the dp-hpd bridge is currently registered before all
> resources have been acquired which means that it can also be
> deregistered on probe deferrals.
>
> In the meantime there is a race window where the new aux bridge driver
> (or PHY driver previously) may have looked up the dp-hpd bridge and
> stored a (non-reference-counted) pointer to the bridge which is about to
> be deallocated.
=E2=80=A6
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
=E2=80=A6
> @@ -454,7 +454,7 @@ static int pmic_glink_altmode_probe(struct auxiliary=
_device *adev,
>  		alt_port->index =3D port;
>  		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
>
> -		alt_port->bridge =3D drm_dp_hpd_bridge_register(dev, to_of_node(fwnod=
e));
> +		alt_port->bridge =3D devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwn=
ode));
>  		if (IS_ERR(alt_port->bridge)) {
>  			fwnode_handle_put(fwnode);
>  			return PTR_ERR(alt_port->bridge);
=E2=80=A6

The function call =E2=80=9Cfwnode_handle_put(fwnode)=E2=80=9D is used in m=
ultiple if branches.
https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/soc/qcom/pmic_gli=
nk_altmode.c#L435

I suggest to add a jump target so that a bit of exception handling
can be better reused at the end of this function implementation.

Regards,
Markus

