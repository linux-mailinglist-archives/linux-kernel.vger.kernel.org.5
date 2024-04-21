Return-Path: <linux-kernel+bounces-152495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64E8ABF4E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C16281A97
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27381772D;
	Sun, 21 Apr 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VrMEtnc9"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A025B64E;
	Sun, 21 Apr 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713705992; cv=none; b=GF8lpuc0wLHdGRbTeG6VO2f1UtyrJyoIwJeb0HYEVeKagjO2hPYPnv7kwPWkls0qm6FuBlpNBSADOI5+xGJOZxhAd1xIoMzWHS4Zd4U5DXV46iglj2H4E3D84bdXqn+1uC08X5zx7lbDWWUDE/0kcFqU0VgIZrGAVFJ2x96o1cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713705992; c=relaxed/simple;
	bh=evdFeQD/L6zQL0Vd61pp1Z/7nDj1MNxAxQVGWpoT+5Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uDCXFMxyK9eD9J+8lZQxIQV51gbw9TZKuUSjYl/xUIcg1eVd6x7DF9x6ppfyKkKhuQ3/7md3OOga2hEr2pl3cuYyU3odliWmblhoBsE/KaXooG5DhCac4aWNrT5ox/bS/Kf+mY1ayVcQWyWnKLTFnJxRkfAM3MJ2rpHKLUdOuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VrMEtnc9; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713705934; x=1714310734; i=markus.elfring@web.de;
	bh=evdFeQD/L6zQL0Vd61pp1Z/7nDj1MNxAxQVGWpoT+5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VrMEtnc9KLC3MVNt+764ZSr+yQI43wvtrAxVexemR+a2TAlQU2e13mDeYYxxa41k
	 eBxqAT4Q9PO7QwttE0oQozSSRa0rOfTL7FmSWudrmTzm3PqZFHCyRnNn2l2uKMDcU
	 MjDU8myQE2eiYt0BCRDhkVqdmMyBFRienuQiUwRAsHvMD1My+eSbTEa+hTgry6y4T
	 Ij8kIPM7cRc7mdocsUgID8hImuuqQeWz4fJQCcFrpNWujyze8CU4SXP7r0U8NxLbm
	 eo0Kn9ZYoV9BSlI8C17rImOfH1pkK5oBEZ4PRGznRhR2q22Amz3aODSmAP5ETRTHz
	 xBLNIAWtt7/GLoELSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MftBr-1seBTb1bXF-00fyQd; Sun, 21
 Apr 2024 15:25:34 +0200
Message-ID: <0ab13de0-0fde-40e2-958f-6a0818911009@web.de>
Date: Sun, 21 Apr 2024 15:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Abylay Ospan <aospan@netup.ru>, Alain Volmat <alain.volmat@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Osipenko <digetx@gmail.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, Sergey Kozlov <serjk@netup.ru>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240419-fix-cocci-v2-24-2119e692309c@chromium.org>
Subject: Re: [PATCH v2 24/26] media: venus: venc: Make explicit the range of
 us_per_frame
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419-fix-cocci-v2-24-2119e692309c@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f+xcXKGB8fMYocFsidy+XXBPdzMxPgl2Bxmk935xBBJ0DD+Gcty
 j1XvabjoHGtqRYRbI3aytRF1rLCJy/qnL6uH5Qjwo2isbCxkSmr83hqGFgfb+rZindmRZkP
 7b5/xPOBLNxbkBZRtB+LF96jEnjSkG6NJ2bAerMk8dCRH4l+CGOCaV+QMLUd8dHLW9DBI4/
 IQgsJ8R9nI5jVnbE38Iog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xNXyt8dZPDc=;Y7uEzsTI8kIrdS2HKx1S7oMARXC
 zhL/9IZGvmHS+qMR1kWXhvEx0vczsVLuzYOS3s50U+Wh4kOFPFY/ipDb106XuODweI2z56ZYs
 epMaAG640SkZGwGkxo69M1FQhxOL86ofKVKBflyZ2q6dGpQhyOisDuATNDI4Da0RSRdCRwpIC
 wRMSldUQLSmAOUIC2Z7HuO+5G+IevRTVI49kTcmUBuN077tL7QQRBkjynLrWZ3SSSKJ9uoeCw
 RHxlZF7VU6ik9L7SCHYTpd0p9S9Q2sOKaCg2h0rWKoTJI1dc3qXedw0Y0JN6hk4dPndniYvAM
 IcGkljfJc78/PJhwKlumc51peBiKPUFXYXcpP1Jnor/n1SkoMn062xnKN00aiB+suto3tuobo
 oiBrqGPsBRh+Ty6fbUX8lAKSjPKS3eF/wCEGXkr6FlRWDlW8Lmp5wr/PmZfoZEUoiiTGblK3i
 Ey+yyh+IZSz4Ek5ZIENH7B4oyMdZApIiYIGvsupHXyo0F1YHvmjO8/K2eNIhcitjX1HRWrqRQ
 2JGfYGXZry6ursP07yqg/N0FCOuzzHDrpKQUSA+Z2FkoyedUr0IUYgHOlFmaC68041rele+lD
 2cug/M1AeebbQ68vxJFAA8ZI20IjTd7qObtFGEYUoneUNA/BR0/DoHTlxFPBMWHijnY1ZW6Fg
 Q5awNCoSI3V0k9sX3r1ReXcvlgT59yf5zk/e0ihl3a7dZbYEUihTv2d0y50NEmVpnPkWJ+V55
 NoqUyej3dphqT2IscNXw9F9aTiCntferd1ug6KOLmSh9O02PeaE/XxnjwKREdfRonSaN1Q84A
 Q6jpoxvLdnimwOaHSn/yZwiRAXm4FacX7YZbhoPrhcdUg=

> Unless the fps is smaller than 0.000232829 fps, this fits in a 32 bit nu=
mber.
> Make that explicit.

Would it be more appropriate to move the word =E2=80=9Cexplicit=E2=80=9D t=
o the end
of the summary phrase?

Regards,
Markus

