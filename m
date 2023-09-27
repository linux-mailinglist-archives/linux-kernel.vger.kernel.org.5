Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBB7B0A65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjI0Qdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjI0Qdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15250FB;
        Wed, 27 Sep 2023 09:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDmhIeCnsj/CZVQfuGpig6c07e24aYc1av/S7yps6PmMhNvtFOPF5Vt9h6x7wG6EU9usj2E1DKY4YALbZ79ENWZa8zT7zVjfqVzZh+5uc7Wbjd1xg5RB+vzNXLiczHqKH1Ky8rd8WokTuC532XHP29kTDPdIIIEspm9qNcL8wUeDoLbe8i5JsefjPhEkIlW9iZf5pj5IvofKQ9q6nBPDELXgleCYueJrxj1yCrmFlahgzXzpki1h3v8T5INWj8s/j1MbQEnim6xvtTdmN29bL5sUeFpoDllNLA6SB2DESQmLTuiTj7NygAfdpuo0cbUGBZ14XqU9ZpN4R2WEw8M9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4d8aGNrGVWl5jnWEQiq+LEGrvdAMc1Dqh0Q/+W4ZM0=;
 b=YeZGXlMjO3nHmg6pCrny9nSMaiocIz8bv/0pTGOpz74mM8H8nLnIYmIHO6t6DFWosyFnZTNGZX1DC4pFkcoZFHCnu9e9QRDQqu1e5bDyrJDwJpxgFWcAjp9q267u4tdUk4gx/ZwRid/XMqTgDyda5Mqz3vrOYlsbed4Rq3/WHlXCyYMuihXZp8NbsrgjKB48jU7Pnnu0UsjReprjTrf8Yrp9uBLrwxo1LFWPDbtOUlzVec8gHJgOM9YCB6yY6lqXial/PgRK5GNAxYXiQ9GJcoOGjpIHzSv0QhDdjBKne5OkYMXR+Oo1rD9qHzS4Dd4R5a1rwRohpSJxH/xMuDtmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4d8aGNrGVWl5jnWEQiq+LEGrvdAMc1Dqh0Q/+W4ZM0=;
 b=llobKuD98Yl0fF4wXHm2hoWeU6niu7sqNCvTieNzh/qWYAWprSmj60j8AmFYYgpz9UbG3hti//cZ8EZXIaRsuyzAqNeJ4GagvxBOlGH5hWTqxxW7+5H2L5Me2xcL/lm8tP7Q1cwu0swCNVCOz3pHPPVaFmxzcVWjNtVkWMAokPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:23 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:23 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 5/9] wifi: wfx: add placeholders for remain_on_channel feature
Date:   Wed, 27 Sep 2023 18:32:53 +0200
Message-Id: <20230927163257.568496-6-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 888293cc-2bd1-425b-0db7-08dbbf7777d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7pZLZT+GOeqwF8OBpbP+hi48vwggqwMmTiWdH0G+lXvnR14lFl9dyTO0z/7z24UZkGTDK1epQWVdK8Mi/4ApsIhK0PSiDWWXctz+4WXJePBgdS/kRDSMqL4BjE87n3700QEUe6ooJnZYvJJc/VasNEIPOy798kfCat04MSa6ivfqrEfBCyh8JfYswJagcD7bEBCYogu/9SH2Rh5lodBmtcSz1vRHBsEbLFy5Z+kYA4fBbFeYE2Lj2TdPeu4m/xWy7+O226USCKkspKh+8kyJPzbpXgDAitFjpvkDCl28eSQqgo/qbb3wYkBJ6gzgwR6xDDNfxIe21CyTTCR9Fwm/exyhY52+WYIcRS0hy30pNG6LCYkwXu7EH4ViR1+qxBoM5myc1URXzldfTO+6AsxQ4HwTL3JN7UoJdatRY2nZqfztlT5a/DBPQ6xLG9eMtHDxgBIXJP5r//bbgKj6tMvofGji34R1ipRX8ha/ZtOjYbCmdI4wPPrHy6stFbFq+wLjkhx7L4syZ3VIrhtXcjQcM1TsJO+K0GCO737cWfzv6/UZc38QJWPyT8k4/fV3UtB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slh3K0JhbFJVY0RHaGU1K3Job2pEcXFZMEc5R2ZmWnNRODZoNWg2eHl6VHpa?=
 =?utf-8?B?b0F1NHZQUENCUS9DWDhUcTNBUHJUU3RlZnUwQ2RhM3Y3cis5WVVMRnFaUytH?=
 =?utf-8?B?OUxLTmo2eWFheTJHNjRtN2hBZDAzeU1MUGVYOHJtS3RnR3owZkZVbTNzQUMx?=
 =?utf-8?B?bzNKazFWeUNTVjVBVU9yWlNkeC9oaCtlTGJ2S2FuYmZteEdDanN2c2xmVEht?=
 =?utf-8?B?RGxNazJBTXlKYURlZlNNSmJtOFBTdGtjZGg4S3Q3VEpaRWYvaXFBUm10djh0?=
 =?utf-8?B?Z1R1Y0U1amt3alVrQjZvYmxnbERtT2RyTXFtTWprdjJqbW5QOUZKbHJkcVBS?=
 =?utf-8?B?UjdxOFpPNjE1ZXVBMkNjdnZvUk13d1dlaXFwMFJPY1d5Z2cwME1DTXkxZnM3?=
 =?utf-8?B?US9vNHV3cjlXN253OVFVOEIzSnVLMkQwb0dKZjk0NTZlQnJuT3NmV0VMbEtP?=
 =?utf-8?B?cUdTU0QyQXRGZHQ4eHFvdVNreC9QWENRaE0yZ2FJbHFOVVFKamZ1NEVtdEQy?=
 =?utf-8?B?UEE2djY0NCswd1pJYjQ1Z3dtaU5vUjhpSDAxSS9FWFpQU1B4b3FPZE9aNXNp?=
 =?utf-8?B?bDFZVHNVNmFwYVZvMWtjemNTWW4rR0JXdTR6MHRSYmhMYmQ4OHBkalc5YzFz?=
 =?utf-8?B?YnA1ZUpDOW02VXNhTndSRWk0cndrK0l3OXl3aHprQ2VyRnJ6YnNnR3ZqVkJk?=
 =?utf-8?B?TDhjaStFSThiUjZPaDhPZ1hnK1lZcmloRkFDZUlKRGRmanhYb25VdXRTMk9D?=
 =?utf-8?B?ZXE5dk5tSEREeVhvSGdDalBUbCt4dER4ZUpWKzlSYnhMREdMR1JZd2J5NDI1?=
 =?utf-8?B?TFV6MFAvaE50R1RXNjdKVS94ZFNpNllSUC9XdmVoVExqU3o3VXdKd2lEaXNE?=
 =?utf-8?B?clJaT3JjdUhUMmQyUHdEeFJCdzlRdWVhZDcrcVNrTjdrSmJDbE9tdHpxZzdT?=
 =?utf-8?B?NFlkaE1BUkorVjRZTGtvNWdveTJKSXhUWTB1a21UakZnT3o4MjNwZnJ0alNq?=
 =?utf-8?B?dG9IK2xhKzVpSEVQbDYwNXlFMVlHMWZkemJKdzgyTEcvL2pXSlBRQWJSS3hT?=
 =?utf-8?B?SUoybEd0UDFpVmptcGxvbnFUUjZ0NnB4cmhvOE5hM2tCd1h4VUdCbXVacmhv?=
 =?utf-8?B?Ny9EZUpndzlkS3FlWndZb1NSTGVxYlI2QTRWbEhmOTNhSW5xZEdFTVY1Ylh2?=
 =?utf-8?B?WmVJYlBGS3dOV2JoeFpNZlowY2wwQmxYb24vNTJjOU96UG5qTHJwUE51eUFH?=
 =?utf-8?B?cFFFcnRPYUQ4UUc1NDYybUpDdFM5SEg5dXg0NHhURFB5WDJpdVhvS1ZtejBm?=
 =?utf-8?B?VjRhblpRQ3k5QnFiek0wOVJwUld5QWRxcUFoVDl2TWlVS0FkYnBWZVdMSXBJ?=
 =?utf-8?B?eEFtZ1BWYkdrSFJJNWZ1TWNYTzkzNms2MTMrS1BFZGRiYXNreDZnTmE1UjZl?=
 =?utf-8?B?eEVpazlMc1JlUUF0bWNJbFQzR2FSS2sxV2liRVRheWxadEZkSGI2cGlSNmZQ?=
 =?utf-8?B?T3JXd1V6dm5TZVVWeVdMOTk2YXhlajE2Sjl6Qjk5c3pna0ZOc29YbDBySWQr?=
 =?utf-8?B?SXdvMzZUNkRaT1pCOXg4U0ZWZUN0R2kzTEFWZmNQTkZlOXh5bDBma0FvVFNF?=
 =?utf-8?B?TmVOc0V2ZnFYajUzcW5weWdaQlByVlhzR3FrbUtvZnFBMnJPeTA5MVNBKzFD?=
 =?utf-8?B?bzZDdWdLMEFrbDFzNVcrZ24yei9JNVVQeTZtdTFENnBRTkN4T0g3cGx4OGs3?=
 =?utf-8?B?amdnTXkrOForSXhUV1NxNUlzOThodUh6SGFCeDVJcXVGVkt3R1NWSHNJVUdH?=
 =?utf-8?B?a3RiSEJxM05XakM4NVdxT0NNOU8vMksxRmdRZ2ltK0NjZ3dhZTBpb3lIRjV1?=
 =?utf-8?B?OHhiQkJpWmQwQVVJM3kwdnNsNjRRQU16OWJDNU9ray9VUFYvZzRKVXpOc0pz?=
 =?utf-8?B?UnJIK3YxenBNaXE4a0ZCWG51WGJpOWlucE5nNFNLZHNpVEt5WW5YY0t3ZHF2?=
 =?utf-8?B?ck1zYTVHUUV0czJENXYxOERERGMzNzlWNzk1ZkVidFJyMHBjSlh0MHJIcmpV?=
 =?utf-8?B?SW1vOTNNV2Jka0EwSmN0Z1FhV3IxM1EvQ0d3blYwYStsWEw1L0pTSnlwaE5z?=
 =?utf-8?B?OFVzR2czOGxBTFpxMW1tNDBxNEErMzRlNHVDT2ZvNXJEcnBLMjdLQm1IRkN2?=
 =?utf-8?Q?QoTDq2NPrT5eckLCv8ppLH4IZmMfEowe4YzxMAA3QgLF?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888293cc-2bd1-425b-0db7-08dbbf7777d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:23.7662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOd4TEOqk69XRUve+iecX+Y0BGx73BO1jojFv7QkYwilUU+Djqab1rLawOAKIOZ42Tc/VQdh/Sv9vMcitoMv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rmlyc3Qgc3RlcCB0byBpbXBsZW1lbnQgcmVtYWluX29uX2NoYW5uZWwuCgpTaWduZWQtb2ZmLWJ5
OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgfCAgMyArKysKIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jIHwgMTIgKysrKysrKysrKysrCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uaCB8ICA1ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQs
IDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCmlu
ZGV4IGVkZTgyMmQ3NzFhYWYuLjMxZjZlMGQzZGMwODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvbWFpbi5jCkBAIC0xNTEsNiArMTUxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
ZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7CiAJLmNoYW5nZV9jaGFuY3R4ICAgICAgICAgID0gd2Z4
X2NoYW5nZV9jaGFuY3R4LAogCS5hc3NpZ25fdmlmX2NoYW5jdHggICAgICA9IHdmeF9hc3NpZ25f
dmlmX2NoYW5jdHgsCiAJLnVuYXNzaWduX3ZpZl9jaGFuY3R4ICAgID0gd2Z4X3VuYXNzaWduX3Zp
Zl9jaGFuY3R4LAorCS5yZW1haW5fb25fY2hhbm5lbCAgICAgICA9IHdmeF9yZW1haW5fb25fY2hh
bm5lbCwKKwkuY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsID0gd2Z4X2NhbmNlbF9yZW1haW5fb25f
Y2hhbm5lbCwKIH07CiAKIGJvb2wgd2Z4X2FwaV9vbGRlcl90aGFuKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2LCBpbnQgbWFqb3IsIGludCBtaW5vcikKQEAgLTI4OCw2ICsyOTAsNyBAQCBzdHJ1Y3Qgd2Z4
X2RldiAqd2Z4X2luaXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IHdm
eF9wbGF0Zm9ybV9kYQogCWh3LT53aXBoeS0+ZmVhdHVyZXMgfD0gTkw4MDIxMV9GRUFUVVJFX0FQ
X1NDQU47CiAJaHctPndpcGh5LT5mbGFncyB8PSBXSVBIWV9GTEFHX0FQX1BST0JFX1JFU1BfT0ZG
TE9BRDsKIAlody0+d2lwaHktPmZsYWdzIHw9IFdJUEhZX0ZMQUdfQVBfVUFQU0Q7CisJaHctPndp
cGh5LT5tYXhfcmVtYWluX29uX2NoYW5uZWxfZHVyYXRpb24gPSA1MDAwOwogCWh3LT53aXBoeS0+
bWF4X2FwX2Fzc29jX3N0YSA9IEhJRl9MSU5LX0lEX01BWDsKIAlody0+d2lwaHktPm1heF9zY2Fu
X3NzaWRzID0gMjsKIAlody0+d2lwaHktPm1heF9zY2FuX2llX2xlbiA9IElFRUU4MDIxMV9NQVhf
REFUQV9MRU47CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3Nj
YW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jCmluZGV4IDE2ZjYx
OWVkMjJlMDAuLjUxMzM4ZmQ0M2FlNGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93Zngvc2Nhbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
c2Nhbi5jCkBAIC0xNDUsMyArMTQ1LDE1IEBAIHZvaWQgd2Z4X3NjYW5fY29tcGxldGUoc3RydWN0
IHdmeF92aWYgKnd2aWYsIGludCBuYl9jaGFuX2RvbmUpCiAJd3ZpZi0+c2Nhbl9uYl9jaGFuX2Rv
bmUgPSBuYl9jaGFuX2RvbmU7CiAJY29tcGxldGUoJnd2aWYtPnNjYW5fY29tcGxldGUpOwogfQor
CitpbnQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1
Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgKmNo
YW4sIGludCBkdXJhdGlvbiwKKwkJCSAgZW51bSBpZWVlODAyMTFfcm9jX3R5cGUgdHlwZSkKK3sK
KwlyZXR1cm4gMDsKK30KKworaW50IHdmeF9jYW5jZWxfcmVtYWluX29uX2NoYW5uZWwoc3RydWN0
IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCit7CisJcmV0dXJu
IDA7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4u
aCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5oCmluZGV4IDc4ZTNiOTg0
ZjM3NWMuLjJmODM2MTc2OTMwM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93Zngvc2Nhbi5oCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nh
bi5oCkBAIC0xOSw0ICsxOSw5IEBAIGludCB3ZnhfaHdfc2NhbihzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIHZvaWQgd2Z4X2NhbmNlbF9od19zY2Fu
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKTsKIHZv
aWQgd2Z4X3NjYW5fY29tcGxldGUoc3RydWN0IHdmeF92aWYgKnd2aWYsIGludCBuYl9jaGFuX2Rv
bmUpOwogCitpbnQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5u
ZWwgKmNoYW4sIGludCBkdXJhdGlvbiwKKwkJCSAgZW51bSBpZWVlODAyMTFfcm9jX3R5cGUgdHlw
ZSk7CitpbnQgd2Z4X2NhbmNlbF9yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZik7CisKICNlbmRpZgotLSAKMi4zOS4yCgo=
