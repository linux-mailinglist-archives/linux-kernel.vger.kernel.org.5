Return-Path: <linux-kernel+bounces-29337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB78830CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C91F2295C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117692421C;
	Wed, 17 Jan 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mxCNEdNa"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214322EE4;
	Wed, 17 Jan 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517468; cv=none; b=YS9K4ChnWe8TeAavCR+dIRgtnzwjK95yNCz9s58SKZzt2dnPKSpO5ngOC+AFx1Ml1nYRNja24QY1iRlZQVJ+177WpC5G+cwiBY3eXNPgvfzyOFpgzh5iv0ANogh7BZ0cBvxaw2NJcYzNhgpMfMdKh5qRTFfgFOCOdxEFuuT56BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517468; c=relaxed/simple;
	bh=gHbMmG9mjXr6MC8IitFnD6yZiJj8cwylv4XvI4+3y1o=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:References:Subject:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=CCn9MC6NT09k00eOGLTZkYx8Y1JUwVxd6APWg3WpiIWwI1etNOp0w4rD9YqvL42qeOQx2dnKCr8u14olCvVz0ZnXqBDO60wT6mFH2QLN1O7kudnv/WcDqpnMWhlUEKILCkL6VzbeQfnB3NN7tUYwU+gQ1NVHvO//1P5QPi6B3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mxCNEdNa; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705517440; x=1706122240; i=markus.elfring@web.de;
	bh=gHbMmG9mjXr6MC8IitFnD6yZiJj8cwylv4XvI4+3y1o=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=mxCNEdNa3xyU8eOUI8WnAbdqGIaQ0cD0UwcPi/M0HbzsfNe7Ls7kgnPJ07HB5vEG
	 z4BQRbUK18o39eF/MzT381dTPv0/CiU4V6M75zCpLMv7dVmRzId5c6rBFc3/Zm1Ua
	 imM00XT3R5/YzL3erdLGow5aI/iTtLZng/awG5FiQ0a5M5MLLiaW4rqGdSiEr+n4c
	 yWM4zh5EMmVBTF7iOxBoQ4gXlAyvXXXw4X2Wlg/FiQG16Xv6NZoVFRrJpQIGZLIwi
	 7YqUReNd+DXQfz6VAOPR86viIcjmHecSZ8P0dF/OJdhWkWhKWUsAwAV/YwO6lSLE8
	 fZ0b2vHp2FT54IRo/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1qo4sM3Elp-00nmDL; Wed, 17
 Jan 2024 19:50:39 +0100
Message-ID: <9e390783-05c5-47fc-a0c6-b95e249fe691@web.de>
Date: Wed, 17 Jan 2024 19:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240116032732.65262-1-chentao@kylinos.cn>
Subject: Re: [PATCH] drm/msm/adreno: Add a null pointer check in
 zap_shader_load_mdt()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240116032732.65262-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:64Yp8Il+v76dSKALZwOZTLIbWnWicuHh+tqzpvHzm0141/YUBpH
 uQkmmNuiA5pT2tJs3TAAtrvFgkgL1YzbBXndtL1dJL1KPXC9ozY6s5RMSMfVGwWMjw3zVvR
 LEN5+Lxf9bStpvYPOYFO2LznYZK33wtfOpyixYUuvpgZ0clb62hzD0jV9nW+mJlqzbGrswS
 A6BMYtJVPopfHBxUrGSog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q1U7tOoGFmc=;2qAZd1fwJ89oCNw5xB+ACGuHRN9
 OlKyRbV/lW8xNgPDwaGaaxGOq1xyBe69U/YdbBszFpCd3SNB9TqgA/eRUInsblCqA244SAUwt
 XPNu/4Xx5qHdunhEctjDVNdVJA/19AYCGlFXQfFiiJZXkB1z5OAXgl5Q0HfKubuhiVBWhL5A3
 +h8/JrGtj5aC0e7GXiXugiNJb6dWDYhaQQt1sJli1cItKY+kxxTaW7ToMzAba4+Hil7A6+cfz
 D3sYWSMde3F/uwa9X7YTHqqOFPzPzueWYJAVr3JnEd0h5yZh8QbdJemPvDxTXUUosrMuZENl1
 c1SxV9ztyPweI/zHprQ3rmZkXe9XjmrpvBYjMXhTxmLy2C0rGqA8ZAY+SrkEGuHxX/fR3pn7a
 Xk5QeesXmU0HgARQW7tsmJDstjvsJk2drLqeevRvX/Vx3Nrwf0Naq7rFR9CKIePee5qNVcieA
 h0xRtXgNKoMHNDmdYMTSp1bgZ6q/u3A1qR4+Edb8+et5vnAaHJhZEYxWKhwuAIlwcPAofi1D+
 rMkWsMW9nGd0U5Es3VGKeareSOnaM4GFHxQ/vzBsqVJUEsHEIHLKPU7K56BAnuojyUuyHCAtx
 KudzjxGpnS7Q+DJucVZKTokP52rozOXWY5SnWzH8GvC7cX1rwL7gBwyLSALGENnk4wTIsWya/
 cw+RG1/ZfLFYab8y+IgTWliHeMYDZfAcktCopcAUileHyE6PDJAIYYccTPxtx3r89YqLnAwrc
 yoeasqhXoAHRUGf1/xa4LcYacHEE7Wv8A+zkleHpfMJEHanb9hkDHMx5Un8XcXtRk19iaSUhZ
 QwERQcA7O8I2ol5pYwVRdBDhLungdrRqD3+ZNwW8iT13Nb8SWthxRRCr82wbIxrqwEZ2qlX+9
 GwcNwQUDOQO5k5ZTZapRo02I9RttueCCWvSGF8U6XM5I5fzRFwo3aZZ9k3u4NWJus9NYgQspw
 PABCvw==

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
=E2=80=A6
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -144,6 +144,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu,=
 const char *fwname,
>  		char *newname;
>
>  		newname =3D kasprintf(GFP_KERNEL, "qcom/%s", fwname);
> +		if (!newname) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
=E2=80=A6

How do you think about to avoid the repetition of the pointer check
for the variable =E2=80=9Cmem_region=E2=80=9D?
Can the usage of other labels become more appropriate?

Regards,
Markus

