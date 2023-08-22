Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466A7840D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjHVMdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjHVMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:32:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4248A199
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNt0m9WW8xebIEmnA0UpRHFRrCmK0IWU8LVxjvPKBhiiJF8TCkeNC50M3IXZPBaelZeAj6R8JUtoKouU56AycXZYs95nCjr00LM0TZiZRuBR+bCl+/vnlwICV/Ra6B1tG81U/k+MyF9C+EFvbWNT59zmcH4nvGrGLIwpF9Ns54Fy/Sj8eInmLkY9tdRdLIzzeFbopNJDXMqUJw40XwmVJeN11QpmPWzShhPOE7FHm+BWxo4iRJ7C+lub0FUiQWHznb1QRJcLmjmFuzCrvfzvHlL+qmdhy5mC8zCVpIxPx1vBO1tLQiGYNDRNbKi1Jl29PF9GVcb8fKG8SY6byYs4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CETup5PSjuChettT135yHk0epw6YzAPh95dCNWRsD6A=;
 b=js5PnQH4/RKOahzyzB+05uKfglhpEmjd0Vat33j2KEQkKyWDZuKRXgGH5JmpsYnhS6jKjoK3v6BYwSYZQvexU0q9qif60mfvCsxrHrSkYB74e4MhmqSNVv/eAEH5cjxl+rddy676jaPhq8G3cTNrc9XPcuB7qZ1wIwaDJnJpD2+tXf2Nipw3FNnqh5UiZ4Zl/SsKN9K3KuNKl8hBGjZ5gCqvhD6DHj4KAAapBRw4kppBj0cbRyfwtWnk36NWDgWUlDJVmZ4zOLP29jaxZkXdayuTqkBY1xj17ediyod9mkDMqW6xD3AXL4NQlwoMJs3v3uTvTbuhs74nsItxOWqGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CETup5PSjuChettT135yHk0epw6YzAPh95dCNWRsD6A=;
 b=C95bvGV9+BxyV/05uWrUisq21Eqb1rSvo/dMDsut+V0U3wdo/E8eJ4MZ7ieQoF9/vwqzI/GhrDs6EpqmH/2Nruuu+JNWlZCPI8YEeMVtH6y1lb7WBVaxckwnwu6iQXNAJmhSlStDx8etCSCoYe+SMg8Einx5U6VhpnFS6VmXcGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 12:32:53 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::95ae:6cb:e93:cce0%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 12:32:53 +0000
Message-ID: <3acc6cd6-abdb-434e-a4da-c371e7f49a70@kontron.de>
Date:   Tue, 22 Aug 2023 14:32:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Content-Language: en-US, de-DE
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
 <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: a8880bab-8019-4083-9e96-08dba30be7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83hX8gAIHyA6LRa19eR5zXANmsL4HcrRRYpVD0lLf5NFYIx5FchV2whJOLpBrRP+pr4lMuhUFaP3MiIcpGL5t8U8Fga76GimhtwOGbhjNGi5FzdSB1+Z9MOHUYW8jfd91M8u6ML91/RkPndGBAxoVblonCYqN40q4e8qMq7lYSS73C+REylfE2vRH+PQHpX6HiB/JRMeA88wIctbBMHOqrgxfI0daxbMbWv5Maz/izjtBj4XKq6CSwEO8tUpVuHWQXDyG1a/jn6Y+ho89hJ2XdBRh508MI1hqZunCWCb3d08vVBh7fZbI6Qo1XAWZf8/wFaS79V9k5Sc9wJST6p/SyQygRT9LsP74ShMHsPb9Yn7kwCU/x6y32+tZIXXbr4kgQZ+2bSESLDYq23z1xxFGftJ7/paf5OSLkI7yXWXtaPp/xnYpVUr2kGX8uiRd1MzqzlWXVzxIA+3BfXJR0BtSkpKZDZKmd+h1VZ+q8X6Zoywetnie9Kd4Pq+bR9uNzS4Fvqjae62MhcjzDLS6Qkf6tr/LrrBRmzma1+uqLpmiPtQ/FN5mM6SzzqKMwi4BVL6zYepy0fckiSrTjizb6yTEqvBciEulvbu6WPBWBqZjwbd+/biDDNXwwZcE+JGyvnY2BbZhtjNOPxYXU6f3Cf8pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(8676002)(8936002)(4326008)(44832011)(5660300002)(2616005)(38100700002)(86362001)(6486002)(6512007)(26005)(53546011)(6506007)(478600001)(83380400001)(41300700001)(31696002)(66556008)(66476007)(66946007)(110136005)(316002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWxub1gzaitWWmNuVXpxa09mZ2RlZ2hkYzFhZnVIOGxhdkd0UXZ0ZnFLOVVF?=
 =?utf-8?B?QkdHYnU5cTEzZmRZcXZLWlA5WU1aRFpHeVBkcVJvem5kbi9zSVlUeXFyWDd6?=
 =?utf-8?B?bGNJZ0JyYVV2YkFwT0ltK1F1QVFybi8rSnJ5dmMwVVpVMFZvUmEzeWNzQzV6?=
 =?utf-8?B?N2JORFpyVGRQd3Jjci9meDFXN3dCYVZKYjlOcjhuUUgyejV4YlI1bWtTWU5X?=
 =?utf-8?B?OWJiYUpKdStlWThGV2xGL2JjVjA5YTNhZFZKYVd5bFIzb0p4RjgzYWZUSk8z?=
 =?utf-8?B?bzFmd04zcVFzV09iOFQydUNOcVFmcXUvR3VId3A3enhZYjVWMkM3bmp0S2tY?=
 =?utf-8?B?dTB4WnZ2QzFseXBDb0c3OEh2WmVaVHFhMDRzM3FCYkxEcUJiRk1FYUJDK09W?=
 =?utf-8?B?YWtIdTdIUFZPS2t3WVV3Mnk1aW1kVGRSayt4c0dhL0hUd1pNRjdBN3VtWXRo?=
 =?utf-8?B?bzQ1Z1NucTlOVTdtNE1paTJlcklncjJZMWR5WHUrN1M5SHRSUHM3WHlUZk8v?=
 =?utf-8?B?djM1elBTUTl2SmRTU2ZLQ2tBMWVaMDVXVEFlZkcyNGxMNmIrOUd6Mm54aXM3?=
 =?utf-8?B?eXk1SW5VQkt1VExpMURnRGM3MDVGWGhlZk51REFFejZCYUhNL3l1QlNUK0hX?=
 =?utf-8?B?MTJJRUNCKzZHSUVCNmZubHhmOXFMT1RzU1lqOVc2Z0IxTCsxQTFZM0R5TWlL?=
 =?utf-8?B?RVMxOUFtaUVuM0xFUWlkb1Npb1RTMEV5aFozS282blJDV294eDJSaXo5N2hz?=
 =?utf-8?B?RzdKQkMreG50V05wbVNiMlh5eHM4Zko4NXd2ZFcyODdiTXVJM1FsY1lZWmpp?=
 =?utf-8?B?QlUzNFhOV3c5c1pGNmVKaFJPcVFGNFdhYUtERTU4NUVrTWg2ZGFKM1R3bXhx?=
 =?utf-8?B?eEdNeHhldXhjTk1JR2d1NHM3ZXA0QVJNYkpqamxzZFkxSHNReUpTV1AvVDNm?=
 =?utf-8?B?L3doY1hoMllRRmpRQ1RYazRpYkhCQ3ExK2lndkJ3RHc5VDVLRngrN0ExNTY4?=
 =?utf-8?B?bXEvOThwOEE0MnN5UVZFcW5KMXM4U0NveUZrVCtDam9MckkzWDNHN3F4aEJa?=
 =?utf-8?B?U0xnUldjL1VGTVBTWXRnNnNGa29qSzVIQ3BORTNsOXFzYzExMzYvTTdOQzFo?=
 =?utf-8?B?QUlSS1dESmpmRGgzWTBKOEw4cTNqbWloV1l0TS9VM0lQQlVubVhmNkhRdnNV?=
 =?utf-8?B?UGsvZ2JlajhOWWlHcHFNYk1sZVlrbmRsWmsya3NrbFhFMWc2Ly9kY1dadXNm?=
 =?utf-8?B?cjBRNDYvT2QrVUM2QjM1UUxWNjMra0VhVkpDK2s4VWRKQk9wazVLeE5JUy93?=
 =?utf-8?B?N3hjYW5mMmVNV0ZsY1Q5MXAyZy9ic09TSU90dmpXbHkvZm5iRTlYMnBnT01F?=
 =?utf-8?B?dm9lYTRyNjZ5U2g1N2t2aUFoWWVYTEorbnFDRlFhZWlVTk5jaEdnSDd2YmZK?=
 =?utf-8?B?M2xUY25JZjVxNnFNYmM2UmlSOXg3ZG9sQS9PbElaUllKKzlldUk4WmtNWUdE?=
 =?utf-8?B?a1M2blJHOERWSmNESTZjam1vSVp0MFE5M1M2WGt2Rzc4Mm1MZkhZaVVoR3Z3?=
 =?utf-8?B?UUE3RnVCMFJBeHNnaHgvak5DalAzRmR5R3MzcXQyME9hM3daWHRqNmJYQmJK?=
 =?utf-8?B?T2lpc1p6c0J3MGtzVHlYdTU1dUdLWDRWQjFCc280NjZCQmRYRVAxeGY5TVQ0?=
 =?utf-8?B?Y0ZDb2tJMmJTazNYZzREdEJ4NmRUVjlxZEtLNk01ZHh3bnZSMGUvR1psRkRF?=
 =?utf-8?B?b2hqTlVCcWZ6YktqRWs2SjVHRnZGNjN0NkNlSjdJYXoybm9QV2J2WWFKb1Zv?=
 =?utf-8?B?aEUvTTlQV1ZqdDQrek53eXM2ZHlocndvSXN3d2FzVzN6b3lRTEVZRU1yczhj?=
 =?utf-8?B?QnJjUUpjMHlFRWQ3ZHBsSTUySEhWaVVEZUd1RDhkamJ0VGNRTW05ZFQzbjI4?=
 =?utf-8?B?NlVxdnBGdHJ6TUw5S0tNdEhQcW9kNmt2aFZ5c2lIcVVkV3drOVZPNlk1Q200?=
 =?utf-8?B?eU9jK0xvUVRpNjNCMkxxS1g4aDdEcVFsT096ZHF3dUg5dWFhdGQxNUsxQkxV?=
 =?utf-8?B?Nk1jeHQwdjVTa01ESXVvbDRnbFR4NDdRRldIWFhxNVh4VUI2SEVxdDdlVkov?=
 =?utf-8?B?cEhHRld4dGhKSHlXT0RuOHVFUlJrOEl4QUNPbmpWaUtLaCttZUh6cndPdHQw?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8880bab-8019-4083-9e96-08dba30be7c1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:32:53.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6TBgnsTW6fUW8e1kMoPwaEHMHPJbQKBA8N947FDu8T8HxpA6LCpRArRWZvqsudi02kj2ygCG75RXQeB1tm5eHQc1kcinatkhb7z+bL6W/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7190
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 14:25, Martin Kurbanov wrote:
> The first 4 bytes are reserved for bad block data.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

This should probably also have a Fixes tag like:

Fixes: a508e8875e13 ("mtd: spinand: Add initial support for Micron
MT29F2G01ABAGD")

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/mtd/nand/spi/micron.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 12601bc4227a..64b41c7c9cce 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -57,6 +57,20 @@ static SPINAND_OP_VARIANTS(x1_write_cache_variants,
>  static SPINAND_OP_VARIANTS(x1_update_cache_variants,
>  			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> +/*
> + * OOB spare area map (128 and 256 bytes)
> + *
> + *           +-----+-----------------+-------------------+---------------------+
> + *           | BBM |     Non ECC     |   ECC protected   |      ECC Area       |
> + *           |     | protected Area  |       Area        |                     |
> + * ----------+-----+-----------------+-------------------+---------------------+
> + *  oobsize  | 0:3 | 4:31 (28 bytes) | 32:63 (32 bytes)  | 64:127 (64 bytes)   |
> + * 128 bytes |     |                 |                   |                     |
> + * ----------+-----+-----------------+-------------------+---------------------+
> + *  oobsize  | 0:3 | 4:63 (60 bytes) | 64:127 (64 bytes) | 127:255 (128 bytes) |
> + * 256 bytes |     |                 |                   |                     |
> + * ----------+-----+-----------------+-------------------+---------------------+
> + */
>  static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -75,9 +89,9 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
>  	if (section)
>  		return -ERANGE;
>  
> -	/* Reserve 2 bytes for the BBM. */
> -	region->offset = 2;
> -	region->length = (mtd->oobsize / 2) - 2;
> +	/* Reserve 4 bytes for the BBM. */
> +	region->offset = 4;
> +	region->length = (mtd->oobsize / 2) - 4;
>  
>  	return 0;
>  }
