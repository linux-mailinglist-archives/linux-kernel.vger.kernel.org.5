Return-Path: <linux-kernel+bounces-40030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F4283D90D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD66328B60C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7A13FFA;
	Fri, 26 Jan 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KoxSaK4J"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06D134C4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267370; cv=none; b=ZueVll/fsNkr9n3W3co1FIFixSiV6qm9XhNra53wPY5j45EtfFe1J/7RVA/PWFBWf9q0uclzTlnmv5ChhUwD/bHgzHFdxUcJzifsVXMPAg1FWuN9tSUUqUT0G2GapnS+tAherHTSO+AfSqcgsRk0GDAGPJIeO3axNb63bO6ftXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267370; c=relaxed/simple;
	bh=vYVu3R0Ajjz9iW3KBBhozPFQ9NQtKmoziVeDve7tf9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc7ZS8Nc6/e15VmLoMg13FKP0TTr6JT5T2mAqNpBBvVBirZQ4R4TMRGTl9ii+gBH7QTILdXokjMHbKJCBaVc5rS0tIVje/3scO0upDv0zuJAwtITvxwQb4XetQR/0Xn/uKhW1bQI+asQseQaW5vRmIXexsnOe2KI1+Cgerlzjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KoxSaK4J; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0867F100002;
	Fri, 26 Jan 2024 14:09:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0867F100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706267356;
	bh=QC+fwRjPGpDJM4kIQo3FgE8G06XlaXmNPf2j/Q+wUFs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=KoxSaK4J83fjCXCOf38cxfBa7Nyhs/6j4cI+yrQnu8Qs/ehAa5hQfartScrq4C6xh
	 EKVq+XkvNdOi6ylmuJMA1PaKZXygOd1lkqxiga+Ncl6L/OlmhXRridrPAfQeqzc5xW
	 2iS+xeWhJ9lN0aSGueNMRuSGF4Hi0fqF2wJA1vLuftSkmEpXJ6FzScHaAcwshQZDry
	 Qlv/q12+Q2eQ9zJlzgCuI2SxQh/DeQPAl6Not9Aw/neZcH/gHDDay06kFNqkD9Hejz
	 gTt1kOxwtSZZ+Jx2cVfCMw3vv3uGEjRyClLfUx2OUlye5o9pOprjHdApPaV7UnBz6Z
	 Xibli0Qajcm6g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 14:09:15 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 14:09:14 +0300
Date: Fri, 26 Jan 2024 14:09:13 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Ezra Buehler <ezra@easyb.ch>
CC: <linux-mtd@lists.infradead.org>, Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>, Martin Kurbanov
	<mmkurbanov@sberdevices.ru>, Md Sadre Alam <quic_mdalam@quicinc.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mtd: spinand: Resolve GigaDevice/ESMT ID clash
Message-ID: <20240126110831.5ol6jl2kb7uhlq6d@CAB-WSD-L081021>
References: <20240125200108.24374-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125200108.24374-1-ezra@easyb.ch>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182960 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 07:16:00 #23429590
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Ezra!

Thank you for the patch series!

We will test it on the our side with ESMT flash and back to you soon.

On Thu, Jan 25, 2024 at 10:01:06PM +0200, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> Since commit aa08bf187f32 ("mtd: spinand: esmt: add support for
> F50D2G41KA") the MT7688-based GARDENA smart Gateway no longer boots.
> This is due to an ID clash resulting in the ESMT driver being used
> together with our GigaDevice GD5F1GQ5UEYIG.
> 
> The following patches resolve the issue for our board. However, I do not
> have any ESMT NAND flash chips to further test my changes with.
> 
> Ezra Buehler (2):
>   mtd: spinand: Add support for 5-byte IDs
>   mtd: spinand: esmt: Extend IDs to 5 bytes
> 
>  drivers/mtd/nand/spi/esmt.c | 9 ++++++---
>  include/linux/mtd/spinand.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 

-- 
Thank you,
Dmitry

