Return-Path: <linux-kernel+bounces-71778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348185AA56
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EDFB249D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECC47F63;
	Mon, 19 Feb 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h4sRlf5z"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771544C8D;
	Mon, 19 Feb 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364971; cv=none; b=c1OBW3QoofEwpzeZKmFnJ0WiOmSGaXh7rn1D4yFmOY4lQNdz+pCgTQ9EPOk11oAR/O5p4CcikEHFC0+5Y+FDI2YWnnMgYm2Wr7VecEfPDu2Az687pd5Oh2eaJMMWeO/ADN27sNCjmH7fggaxJEH7fj9W3KGxuyJla/PKehSObkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364971; c=relaxed/simple;
	bh=hPupRt57+r+Pl0dfVnsjq1GsNhHpCJ6eXReICe+eDDo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=elpbcyqsRDbiOr7y+H9F8/zr0K9L/Lw2MV71f9DXzp5Iab4noMbNf/+EsuBzCXnnx/wBBZAl8XCPuQkC4zDBC26O8gEaBOyge3+r11CUbighCudMlQM07tGSVRWvOfccWZu1xXMquPTqmch5k3CBR5Sg70B64QBuJA6q0pYnH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h4sRlf5z; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708364915; x=1708969715; i=markus.elfring@web.de;
	bh=hPupRt57+r+Pl0dfVnsjq1GsNhHpCJ6eXReICe+eDDo=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=h4sRlf5zIV+QWDila5ohfglWmS12NfxX6Wx6NvhudyKq05oHZRWmmvB+yQAl/USd
	 s/hF88fZLogXlVoPr9rYZcV6U1BvLPtgrwOs3I0XIdBFv8XpCNCNY3EEijkJj1DzY
	 5VvHfB+6tRpIy0Tq9+g7oAj5CiRYslmyzxurJVIsHN3Kc9uYA8tBa3N1Mp5L6Y/wr
	 oucP7TurufLy2QMHeMn/SgfhJjg31IVk1/FHtcdSB/Axxv9EWjjleNaSPrJeU4eX5
	 oZ7w/z6ZtPYAINIoef5Lp0bfUVTHb8xQlzM7tiiHXC7yK1h1ujvgMvoDn/CvIgI7W
	 Yu6xFw2F9eBfP/W1YQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1rfQbv2m5c-003JhM; Mon, 19
 Feb 2024 18:48:35 +0100
Message-ID: <c95f5ff3-8dad-4302-9384-92a9b83f7bdc@web.de>
Date: Mon, 19 Feb 2024 18:48:30 +0100
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
 Rob Clark <robdclark@gmail.com>
References: <20240217150228.5788-2-johan+linaro@kernel.org>
Subject: Re: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240217150228.5788-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1qY8TG6XGBPBySkXD9Iw+B/jMk+ITC9FUkKiHaIFz/AtRCFm3X8
 A2bG3gibnYIc7UfT5py0ZV3IHcRAAwqod7yJen0dD22Od/rMMXKMtv4O3ehHFd6NK1O47oF
 2FKhSK+MFr0qgPhK4sp6Gvv75D7So3Dsd6VTfJ4FGrbLdu71hXEBz4h4bEnOqoDzSyVLUQM
 FFo2segx5J963ehK0Nyqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vt1j2p9N3tU=;Y5Fkv24B75ZRsEO6v+JeViz6QDS
 Z0Qr1vSndEAhOcBQzzzF9Hc+zTH8Lh5ACQIDs7Em43y0RsMfANmO66fe8KzHagSpTU3nCS9yw
 seqRMXtdrL7zS+FYfxRWVQMh2n+AW0LD8yuU/LvcAOqSzpZuAxCp9sB894cWb6Vs/KQwhcvix
 0c0MCspFvzytZ8Z/VmjJpOa6U7u79EUFZbSTMcXdtOidhEyGaXoD1ed1lSk72ZHY4WrxBcoIG
 AQDpd7AAX8XoGPbGzDh8DSIIf76R1xfHsRz/IWtBKre8C5hyOZibsT6rlCWZf1Hn4OY8nyGe8
 0R7jtfGDhFTNaLob/euJ4Xouo1S6JDEo6roUqqRQhLm+eihsK/1yoocr3e4TN5EfooNR/mqlb
 JU0s2ZXbFHxS1HxFt10qTR2Q3UBDpjnHxaf0nc6H7jpfWpYApArkm5d6/CArQHWMYRyHggilo
 NOJYAzpbA7OAaB9NNxId1wvcwZvrTgkzAeabC2c5HsL0UzNsbWqKbMMceESmfn72wOIfsQIsP
 L1S6NcAESVAnTYRBVYmDfWpuRiWfiWzh6aw9JFeF6HLm6Y4ajY/9ve+rE1vwM2zw9Na/oA3vn
 fbfuZnuDVcd6HgPLX6VmhUXnUzA/O+87vE3/mjhRZ30qPnFNmB7/gDo+4lkRApUIZ+Y5SsU8T
 C/RmhXE33yy5bOoTU1jR3W+iZ1ylFub+AO8utosVVJ5xfLspRIaoR6ptLogpbtO8A+duLEl5g
 BTecZA4H8EdbrwYdstFYfumSnHWDkijS5WNqggvyMOhheue05/XZGimtzonJucoBOFIY89JRK
 mjveQA3OLbiH8J7EvTIIAlcAE3cn0wtcE7uXKqhPCSnq8=

> The two device node references taken during allocation need to be
> dropped when the auxiliary device is freed.
=E2=80=A6
> +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
=E2=80=A6
> @@ -74,6 +75,8 @@ struct device *drm_dp_hpd_bridge_register(struct devic=
e *parent,
>
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {
> +		of_node_put(adev->dev.platform_data);
> +		of_node_put(adev->dev.of_node);
>  		ida_free(&drm_aux_hpd_bridge_ida, adev->id);
>  		kfree(adev);
>  		return ERR_PTR(ret);

The last two statements are also used in a previous if branch.
https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/gpu/drm/bridge/au=
x-hpd-bridge.c#L63

How do you think about to avoid such a bit of duplicate source code
by adding a label here?

Regards,
Markus

