Return-Path: <linux-kernel+bounces-163481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169B98B6BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC17F1F218A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4808E45BE8;
	Tue, 30 Apr 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W8siq2RI"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039714AA9;
	Tue, 30 Apr 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462427; cv=none; b=NxMJy6ve49iirmDnnZFsbEY588yuJarvk4AbuCKVFlL6g+iGLdmJnDQ+Zj8ymqiveno6mkeMyyjxAMG2LkHmX9C7gYObBx5GgCNf3W1uUfQuEp9ELBRrw2rtHCWHWCWRulPvCXiRepokNs+tIEydN4XJ0NHn/YGBd8ODdxu/vEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462427; c=relaxed/simple;
	bh=7dyCd+XT/wrQkCsgsqTU/+v+pFnIA0EzpEmxVk6QQ7Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Fjl+Y1hPqlp2FmEFY2yLLBLaZ33eVKAe5VRYCwGyuJctRVb63BpuuM8oPWe/DIHv+9sBYzJFIDchAaSCg831sSmxF+f8OUevCmAFCD5t5Ek4L0fOaySWMzU/lEwXH76Dz5tN3cDVZGzRueoeCfDloerNgqZ+gLji0k+3Zv7vzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W8siq2RI; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714462412; x=1715067212; i=markus.elfring@web.de;
	bh=7dyCd+XT/wrQkCsgsqTU/+v+pFnIA0EzpEmxVk6QQ7Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W8siq2RIuAF9aG5uFEjllD1snUDaT/M9pQ8Ok9h+rku2TmMh6KVg3YF+Gpm5cE2C
	 X8m2UDjP6GEVUSOOVcXas/i6arH+8SfxGzhqdByJbExVLm2Hog1nS6CLACd8XZjh/
	 dFXTy1rzwvC0q7ef7YNomfofgXEPUSAq0V29na13JPrEWtuTBXpu6GZrN6In7O01f
	 hHrnHcr/C1X6pFJb6AfllU0xhL3L6hWYBufcStG9+K+DjaYRLOJjUSWzDTFtUkiV+
	 nz3iM3YnlyptKA7O3mWEudwLpFoBzPtbxhqcA7AbpmbaWimoE/4wjkh4WhU1mGUmf
	 kwMJPTsOmeBujuhHtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrLL-1sFmbX1LT1-00McyD; Tue, 30
 Apr 2024 09:33:32 +0200
Message-ID: <8b274e8b-ca1b-47a6-90f9-eb2c9d4a538e@web.de>
Date: Tue, 30 Apr 2024 09:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sungwoo Kim <iam@sung-woo.kim>, linux-bluetooth@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Dave (Jing) Tian" <daveti@purdue.edu>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20240430063209.584244-1-iam@sung-woo.kim>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_connect()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240430063209.584244-1-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QvHTTJRCPvNgpxwGrd1n/gHVdpelP5AGgJB+Cx7Am88MdC5hGOo
 2mwAeUwHGVS+XCPonspE35PEzsPaApe94hAcBynnJ7GCfp/vT0s7xsasBEI0AS5SelaID1s
 aDo70ATno5bAcOMhAHGHe4BRViDwq5d5vKfb14rWiBb1X6gL73xbjim2FvCVpHEe69TPrGJ
 lIKBSzzCAMsWETn80R8Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SDzHgZwpg38=;uxcivH2DTMrR2XSBCJLrLol/OUT
 lHdQ/sOmsEO7kKMCaOu6SbuLXpdTX4aNSpvMOSswlXqIML8PRrdsmLgJr/XmLvVfQAEU3GTUi
 W0ersz6ZMJNGqH5A4olwFWo+SHcTjgjFA1NKwxxCRq/z1KqZivm3J7vD+tsyWFOolhV0T0BZ4
 DxYtm2pyoijArs3Y3WMZ+tgI2ER178eaPd2Yl9W3J8aMvVjnXG+z2on1J+dVoBXefvNGVMWzb
 Xd291QhjI5+UCMzJG4ZwrDxh+ygxDai3WiI3iKAh0lPQ0xQ9QNpd3eJtTP3GryjPnP9b266hy
 LJbz5tjpUomPjSkBB/2Qx/ilo4vFjWR6TWY9jtlguqdCC4q6lIgMzu3xlE8f0XEx/pzIIlgtT
 xFTln/MTv3urzrQlY8yS74EyTJxv0RxfIqaVwt/zg+N+Qsqq59ZJxyr7/25OtF2WmHdQ8Knj+
 pClv2Z2dG4f8WDOXwh2Ss08f/FWwzPBXErxkHED05JcXYm2D+19uDiNbLhF5AhHSO+de3fusN
 OUDsB3G2wgQkfNEmRjLMKveAEMdDPuDQk+1kYLovVBRSQfgxekWLRaK+y+md2c6qysrqRAX18
 wfwcSl4KMuRei5rlX4+7sPWmm0+p08nh5FDrdxhi9FkFXlc89pqlX/mHd4xC51dr+yc0jLQ2E
 p+TPndSp3cUWHCskGEBT2tbltHuMH11QvNNFBINBtS81frCnGpammjaNy3XUi3dLSyXmuHjmv
 bHu/OPs+VEUs2McE8Mh94qAU+UcEXyx8dfuUAkJHCRwIc1N2aZgxM1tArnaTgXivcMKUCilCY
 hN0ft07K9i5t/OUXZr1QpDPKbjsNfvtv+628aOa+YKgno=

> Extend a critical section to prevent chan from early freeing.
=E2=80=A6

Such a data processing improvement is nice.


Will an other distribution of email addresses over recipient lists be more=
 helpful?

Can you imagine that the usage of the message field =E2=80=9CTo=E2=80=9D w=
ould occasionally be
more appropriate for subsequent patch communication?

Regards,
Markus

