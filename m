Return-Path: <linux-kernel+bounces-11021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B285681E028
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6962D281ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2E539F2;
	Mon, 25 Dec 2023 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="ymtlYky5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD7537FE;
	Mon, 25 Dec 2023 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNJRRw5ymkA3Uy05q0jMMQa5CX78MCbwxqk9nm442VexDQuxS4R9IjoBcoxrHx9LkDLlDXlOYFgylXFXj3AaFG+aWQzs0FAqGjMV37QhIcHJJbyQDyFFhZXF635LyOo3jZGQ6buqT1MnkKIXI1736tZAgAOnwNl+qj9uThDO5DvO5alPpG5jZaZFy5PJ5jfoWVjkMVKYDGwXsKhAtC4WV4bYbRuO9A+R5NA5x7vp3W+3ck/EFmYZki+er8xOo8jzy7FmSh8jkcWY1LB/uN38VBeyzHS7qUKgtUR6OYc5C9hnga2WV926RW41k/tgPscsuWrzq3TufqFbzEYX6aG/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=QiOByNnSXuhOU2V7uzwkcQkLBUYUrviqa79k+nrvaZaH0jJUvAcAB4PTEkouJHxYOvo6wU1MZCWsn1rJYBgBtN2jktlVYmi/G0k9bsCfwTVBtoxf/sLkLxBLqYDmAwe6RXmUqjbInKnv6B64XhYbwTCJ2I2j8oJqn2SXqtqgYW58FZvxAW6U3p+8gvjj+OyF+iQv0hFSQBCKlxHQN7AsFtSXvE7tVKB29iWV1VruOOO3CL1VT1SbmXyabuPGQODumjPRBum3vRT3Nnxc+5EwLHtgo6YzYfks3ZlXkNtVdTWgoXGYlmGN+WvKtZwKgTEmRBLHiGZwWeOyvAO11GlfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BcGoe+ESDzoCivkDyl+SvQ6vxiyAUtVpHN4Fyf7TKI=;
 b=ymtlYky5Jx7ECUkTPyeLk5uXWVw33reXsylPatPOT9sq3qdhnozvCEUcMkfjdJUTsBKJHcACzEazKwz32GsQhlNewkOuWfaxCAbGl8zOe62tuNhvLE3nXi+C1PnHDOfOLx2Ai9xLec8sKorGhQfvGrgOG01qcbzkNXnUVK91TgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2061.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 11:35:56 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 11:35:56 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	cniedermaier@dh-electronics.com,
	hugo@hugovil.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date: Mon, 25 Dec 2023 12:35:23 +0100
Message-ID: <20231225113524.8800-8-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR5P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2061:EE_
X-MS-Office365-Filtering-Correlation-Id: 81315aaf-8be6-4414-619a-08dc053da860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v5bPqL66AomTiIOdGfSSBg5v7G/XFizRuF1lz8EvnjVkNkUMD1mFowQaWYTTHpzMF6ZKO2OVB1R4+oV2c56CQGA9Pq1ZbxIgr2N0WenDpAth6N8xhCCTGDywZDQSRc641mklS39T/ErKvpEv17HRdQdXL6QCrn81dKFVUhW3IPk4CeeCeFnPcOOq//vCfbiApxzGITVgus4hci1KJsEjtMSs1HJLfx7EB3kUYikWKYgufnqvDFCY4k8xZHrz4yawVGWEQa4dSDKW+aSgsq+mqUCD73s7yuAj6BiujFoxTxlsFUeuBxuATWx2AanFjyskv2qUy21wfiabdWlBmagOSfoqeesx/biYscINCyEKHC25TTd3oya1qzMNuPALt+PqNbtkMYUI00unaHQFCxpbdJeQg6hBlIzCpreb2aaQ5a6cSnblX9ZOkB1HmCeJdhaqgI075M0ousPzGc+tEzqMsW86q0aBZyBbP/bA101NtzXoC4eACix0NP4NSDlDiutYrxh7rAjjstRsfQkZuDQrHHssaztRr3kkpCTvztth5jBXvGRsa+yw+k/zkTlRo6SWQpk+gAZDTZD3/13iz13JvuwrZtsrAiQdWR19zGRX0ayD48lqzDIQH0XQYHt6bCu3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(366004)(346002)(136003)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(2616005)(6666004)(6486002)(478600001)(2906002)(8676002)(8936002)(5660300002)(36756003)(7416002)(52116002)(6512007)(6506007)(66556008)(66476007)(4326008)(66946007)(316002)(66574015)(83380400001)(86362001)(1076003)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1BSOXlObXJVY1BWMVlvNFRDSjFwTjYxODgyNllOMm8vMEJ4VEd2QjNVamZ5?=
 =?utf-8?B?bWRRVzZyTFhuVGJMeEpIcjVCSDg2Z1pUenRBSjBWNHViOEx6K3hwWGNCQmND?=
 =?utf-8?B?WFJsMXJab00rQUNqKy9OMjRIVkorK1pVUTg3SUwzTFIyUUNqUjBINjArZmZy?=
 =?utf-8?B?QzVwcVZsTEVYMG10bk9GbFIzWnZxZWJuKzBYSVU3YTlvV05VNkgwR05DeEls?=
 =?utf-8?B?UXljbmRCSUNVcS95Wm9pTXdXZjNpTDhFbzdoVVdWOXNsZmQxdEJVcG9ZTCt5?=
 =?utf-8?B?ZnRydjJnMDg3dVhyNXlxRzF2cWFkSGRENnZJQjhXdTR3TzROdjltK3N1Tktz?=
 =?utf-8?B?bCtlcFpKMDR2OGVZcmV2YVhzUmVZREdTZUdDaDNqZC9sL1UyUnMxQlpUejJQ?=
 =?utf-8?B?M3JPbzBGYWp3Yk0wU2lsNjQxRktBQkc2U1pYRVQ1NzJISmlabERXaWMvazh2?=
 =?utf-8?B?dmVPL253ZFFZWlN1QTJUeTgzcHZsN2xpNlA1RHBPMGFqTVVzdDhlc2ZQYTR4?=
 =?utf-8?B?NVE1MHY2TytBNURNamZFRGZrQTc0RVVrNWRucCthUTJrN2VHSjVFdjlhL1ha?=
 =?utf-8?B?TGx2bzFlOGhuZkRnQTZma1hWVU03NUc0cnR4TEtoTjRMd1p5VXJWU2hZVUxN?=
 =?utf-8?B?em1hckdzSUxENmgwRExDNEdRYnRQZE9ETWZNb2F2Y3VMMlVIMTFqUjd2NTVX?=
 =?utf-8?B?YVp6Q1R5OVJRM1hzcXlneHZnTDZaekxBTnRBZnpROHFhaHVOQ1BmK3JvSytY?=
 =?utf-8?B?YzVUNlVBZzlRNUpLQnUzQmdsd1d3K2hnSnlzOHltek9JN3E3ZVk0SjQ3djRs?=
 =?utf-8?B?QVZaNDBaN2JaY3B1ODRSdGlsVG9taXZyelUwZE5qdURBZS9IcU1IMWUycTVQ?=
 =?utf-8?B?UDkySEVKVnE4Z3VuUXdkQWcraUZGZnVaZWZjZzMxWVUyNXlpTTEyUEFNOWpv?=
 =?utf-8?B?NWJuQlZyeE9yNEs5TW9HYkN2U3ZKNFh3NElOY1lKb1JzOFZBdWxPQlBEMU5G?=
 =?utf-8?B?S3RLZUJ5cXBYTEZFQUcxc0UvQ0ROazh4TDJoM2hmS0ZncGhVZmNOSG1JSGp1?=
 =?utf-8?B?NDVMSXg2WjBMdW5HaGswYmEwck9BeEVQUm1Qczd4TXAyUWNKYlBnSVByQ08v?=
 =?utf-8?B?UVVvaUJsbFNaNDUxbndsN01FbmE1eXdUNTR0bzRLay9QMHpIUSs5UGRWK0pl?=
 =?utf-8?B?c1RJd0U1MVNZK3BHVWZmOVpWUzZac1NmNkhsSHhkV0M4SC9DMkZHNmhhVGp5?=
 =?utf-8?B?WXFUdk5vTFFHNVZxV2d3UVhhZHZvT3dkeUJWcWM1K0VsQ2VaaTFsVEw5SUJj?=
 =?utf-8?B?SStwb2lqS2dycmpYc3JwdlFuVys5VW01dktpdTlCdDF6dTRNdUszeVczaExW?=
 =?utf-8?B?R3FncTB1MC94anN3aWJVSmc5R1VSNzNTMjd5UUErbzQvWVNWa3VhMzFjTEk3?=
 =?utf-8?B?NENrNUI2a2puNlVwNTFXY3FDS1pnQUFXdmltak9OQmtmeGJxVEZ4SlI0am16?=
 =?utf-8?B?S1BkOFZjTFJycnhXdXJBU2RubFRtbG42Z3BVVElnVXF5bDJjOExmcUpaZ3Av?=
 =?utf-8?B?OW5ybXJOSzd4bmcybmZnc1QwaTFWUGNlcGxmL2ZtTEF3QjdNZjdkV1JxK1ZR?=
 =?utf-8?B?MUE1V0t5YVRoRTZjRHFraTY3eHZyM05JZ2x2RW80cHBIbWJZUWQ4Ymw3KzAy?=
 =?utf-8?B?Z0NpRlh6bjZ4bUF1eXBhTHJZOTh4MWFzZEwxUVlZR2tmZ01EMTdMQWlXdWZT?=
 =?utf-8?B?RFBaWStUM3VQWUZyK0ZkWkZnRnB0SS9Zc2lKN0VIY3dJdjhhK08vdXBRWDNY?=
 =?utf-8?B?eG9xT2ZXUSt3d2FCQmJMNFZuM1h4blQ3bTVCZlN4OVNFazNacGs5enFpMHlt?=
 =?utf-8?B?U3YxNndzcmsxQmxBV2RxQnQxTkdrdkY1aEtuY0h3b1g3Z1FhVkk1NmpUUlZJ?=
 =?utf-8?B?VVRpZEFFbzU1U1RPU3dZb3ZTWEZ5MTB3OTF0MGV5dEoyTFNjQWFhcXRJdHVN?=
 =?utf-8?B?MUhvMXEwNEx2aEZZV2xlN0JZbDc4TWo4VEIwYVJHRmNxVjRnUWZCa3hTb0la?=
 =?utf-8?B?bmhUeENLTjdzaVd0UnNtRFNTRk0zNWEzNkFGTEgvRkh0NUdjYUFLelUxLzIz?=
 =?utf-8?B?MndhU1I1cE1GdUpQYUYySzNJTEZhV1NQRmt5NVRrOHN4N0ZwNUlkVWNWRU5t?=
 =?utf-8?Q?eP3rcRXhxzrlTLoKUBcwhQTj/prB8OVAxOAH8B5wwTa8?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81315aaf-8be6-4414-619a-08dc053da860
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 11:35:55.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9PtAv4d1Mr5FjJOCaUd6BWAdu/RCgZDRXN0ZF3JMMESeExq84rhkPQMSsUJzTTn7Muibbgy6ARAcunKNtM8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2061

VGhlIFVBUlQgc3VwcG9ydHMgYW4gYXV0by1SVFMgbW9kZSBpbiB3aGljaCB0aGUgUlRTIHBpbiBp
cyBhdXRvbWF0aWNhbGx5CmFjdGl2YXRlZCBkdXJpbmcgdHJhbnNtaXNzaW9uLiBTbyBtYXJrIHRo
aXMgbW9kZSBhcyBiZWluZyBzdXBwb3J0ZWQgZXZlbgppZiBSVFMgaXMgbm90IGNvbnRyb2xsZWQg
YnkgdGhlIGRyaXZlciBidXQgdGhlIFVBUlQuCgpBbHNvIHRoZSBzZXJpYWwgY29yZSBleHBlY3Rz
IG5vdyBhdCBsZWFzdCBvbmUgb2YgYm90aCBtb2RlcyBydHMtb24tc2VuZCBvcgpydHMtYWZ0ZXIt
c2VuZCB0byBiZSBzdXBwb3J0ZWQuIFRoaXMgaXMgc2luY2UgZHVyaW5nIHNhbml0aXphdGlvbgp1
bnN1cHBvcnRlZCBmbGFncyBhcmUgZGVsZXRlZCBmcm9tIGEgUlM0ODUgY29uZmlndXJhdGlvbiBz
ZXQgYnkgdXNlcnNwYWNlLgpIb3dldmVyIGlmIHRoZSBjb25maWd1cmF0aW9uIGVuZHMgdXAgd2l0
aCBib3RoIGZsYWdzIHVuc2V0LCB0aGUgY29yZSBwcmludHMKYSB3YXJuaW5nIHNpbmNlIGl0IGNv
bnNpZGVycyBzdWNoIGEgY29uZmlndXJhdGlvbiBpbnZhbGlkIChzZWUKdWFydF9zYW5pdGl6ZV9z
ZXJpYWxfcnM0ODUoKSkuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpSZXZpZXdlZC1ieTog
SWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0
eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBf
ZXhhci5jCmluZGV4IDYwODVkMzU2YWQ4Ni4uMjMzNjZmODY4YWUzIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX2V4YXIuYwpAQCAtNDgwLDcgKzQ4MCw3IEBAIHN0YXRpYyBpbnQgc2VhbGV2ZWxf
cnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVy
bWlvCiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGdlbmVyaWNfcnM0ODVf
c3VwcG9ydGVkID0gewotCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVELAorCS5mbGFncyA9IFNF
Ul9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JUU19PTl9TRU5ELAogfTsKIAogc3RhdGljIGNv
bnN0IHN0cnVjdCBleGFyODI1MF9wbGF0Zm9ybSBleGFyODI1MF9kZWZhdWx0X3BsYXRmb3JtID0g
ewpAQCAtNTI0LDcgKzUyNCw4IEBAIHN0YXRpYyBpbnQgaW90MjA0MF9yczQ4NV9jb25maWcoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiB9CiAKIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlvdDIwNDBfcnM0ODVfc3VwcG9ydGVkID0gewot
CS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCB8IFNF
Ul9SUzQ4NV9URVJNSU5BVEVfQlVTLAorCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VS
X1JTNDg1X1JUU19PTl9TRU5EIHwKKwkJIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggfCBTRVJfUlM0
ODVfVEVSTUlOQVRFX0JVUywKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHJvcGVydHlfZW50
cnkgaW90MjA0MF9ncGlvX3Byb3BlcnRpZXNbXSA9IHsKLS0gCjIuNDMuMAoK

