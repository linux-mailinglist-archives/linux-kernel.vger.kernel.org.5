Return-Path: <linux-kernel+bounces-40528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B536683E1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E8F1F295BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CBD21A0C;
	Fri, 26 Jan 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="bHSbKS75"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720321100
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294953; cv=none; b=S0kKKvLmSJCZEFDpVx6KePjr1DIJQKBSbeJjLN6n6xpSZEDgT3Wl0mLSBvfQxSDPVk5+cYZMJXxeyiU55i8wcNr0yzGcfXPACI4KLRK27dSiWJSUmAur7MGIT8pq5doI46C0ItC1ffdPnrDk1Rir3TFki5Y3P83bDgKdawNPceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294953; c=relaxed/simple;
	bh=MB6QUvefQTHnfcnBtYetafL9gNkpdTxPVFWhVgEPY8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HfeSBhZkrT+dc2K3V8pz2qEmBi0rDiEsshe25MRjwfO4uIHEvvhtBP1tr8uDKp9hZ9G7us9n12ssJncsby51BZ8TNXtdviQ2CVVKK2nsMbAaNcVdD4KM/VnlOjJbfSRjL51wp4nz3wQ8NjwMzEFt5nD0dnRwMlnoHiPcBeVmRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=bHSbKS75; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3273F100005;
	Fri, 26 Jan 2024 21:49:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3273F100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706294946;
	bh=+VMT5ekAOGZXIljkx7C8fwo+qbjUMHJIXLSw6QsvLi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=bHSbKS75eQ4Hdknp3gNnbhA06/TKBye7BZCOUUE0xqydAnesgyVUO8cHvYeg0Okw6
	 WyXalaHjHWDb1Jb53Mx9VT3C16NAs7cSCdEZysD5TWU4NU8MWWOXvSOYq3+sc1Tu+F
	 HOAKMnwMa0skf/REfIn18A/Z99teiDtvf9SjmcPAH+J+GlEEZ3VBtntKizGDKFYBwJ
	 7ioT5muvGV87EMBHWdJvwujQnsxBaKLTgldXEjS2B67Q40XqyggA4FB2amfK0i8+we
	 BF71sPDPEurw9MQ0R8OSkdt7RlKx/jiCM7WmEuOKBOoHBO7TnKpSbRrpym8gLg3Q8x
	 ZCuYHdGauKLQA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 21:49:05 +0300 (MSK)
Received: from [172.28.137.2] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 21:49:00 +0300
Message-ID: <adf1fa3b-33eb-4def-97e3-55a7231430d4@salutedevices.com>
Date: Fri, 26 Jan 2024 21:48:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: spinand: esmt: Extend IDs to 5 bytes
Content-Language: en-US
To: Ezra Buehler <ezra@easyb.ch>, <linux-mtd@lists.infradead.org>
CC: Chuanhong Guo <gch981213@gmail.com>, Dmitry Rokosov
	<ddrokosov@sberdevices.ru>, Martin Kurbanov <mmkurbanov@sberdevices.ru>, Md
 Sadre Alam <quic_mdalam@quicinc.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sridharan S
 N <quic_sridsn@quicinc.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>
References: <20240125200108.24374-1-ezra@easyb.ch>
 <20240125200108.24374-3-ezra@easyb.ch>
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20240125200108.24374-3-ezra@easyb.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182973 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 14:25:00 #23442014
X-KSMG-AntiVirus-Status: Clean, skipped



On 25.01.2024 23:01, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> According to the datasheets, the ESMT chips in question will return a 5
> byte long identification code where the last 3 bytes are the JEDEC
> continuation codes (7Fh). Although, I would have expected 4 continuation
> codes as Powerchip Semiconductor (C8h, corresponding to the parameter
> page data) is located in bank 5 of the JEDEC database.
> 
> By matching the full 5 bytes we can avoid clashes with GigaDevice NAND
> flashes.
> 
> This fix allows the MT7688-based GARDENA smart Gateway to boot again.
> 
> Fixes: aa08bf187f32 ("mtd: spinand: esmt: add support for F50D2G41KA")
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>


Tested for F50L1G41LB

Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

> ---
>  drivers/mtd/nand/spi/esmt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
> index 31c439a557b1..4597a82de23a 100644
> --- a/drivers/mtd/nand/spi/esmt.c
> +++ b/drivers/mtd/nand/spi/esmt.c
> @@ -104,7 +104,8 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
>  
>  static const struct spinand_info esmt_c8_spinand_table[] = {
>  	SPINAND_INFO("F50L1G41LB",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
> +				0x7f, 0x7f),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -113,7 +114,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
>  	SPINAND_INFO("F50D1G41LB",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
> +				0x7f, 0x7f),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -122,7 +124,8 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
>  	SPINAND_INFO("F50D2G41KA",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
> +				0x7f, 0x7f),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,

-- 
Best Regards,
Martin Kurbanov

