Return-Path: <linux-kernel+bounces-154511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8698ADCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C951C21AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE02032D;
	Tue, 23 Apr 2024 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="V9IV65LR"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625861C2AD;
	Tue, 23 Apr 2024 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848057; cv=fail; b=iMdq2fZL6cgzz4jpPwahIzwfJVSqG3YsHPx3GTxwgw/GiDbXlCdmK7z577jbBWGCXx/a3O/0Qom8gVHZqSai/+o/9x/rzcH4JDdxsAxyHsmu5PIaMbLXzDkbp9T4uPIArNnoJ4P7rQMq+O8XkQd53LvXGIVocDB/bUqNnJa6kPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848057; c=relaxed/simple;
	bh=J+Pj4Yao/oJksHunVXCYsk2ytrf2JyD20l3wg3iv2Wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEbRwpAwNXh2XCF+1FH3fwsNk/bKwfy3a9HE0r7magYyYo52m3COV7Ihdih5ERZ3TYyv7CUXDrZwVmKOMZTGIXAnGrPUeZhdOv16O6lSmcXCWTZyd19IbY7ktmryn0Fc4vbtr0XRxyn8OoE3zFT5t2LRpKjZekbkJ46qBSpJ000=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=V9IV65LR; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MJ3aSu011727;
	Mon, 22 Apr 2024 21:54:05 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xnngcut4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 21:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZmGdrPiObCJEMd3Pctn3WmxnSOGLHBTc/Xc5cFtwFqytugbDoaBQvneAe3X3KqLb+Bf+OBgsHUFF86G+/Gg8n484X1goUuYQsKgp6OodarcA4GzlUHFjGENRMyWNHqo6fahF2/OQ5RnUPmG8oMQYqKObmAJbQ/ba8gFUxVXjWtIrALMjUcqYvzUWw8O9JU/aWG3O/O5vzH/DGh5/A5DC48HiQy3fh3XhSg1BJwOrxPn9aZpTE2IVGkV3a//KszDGjUUruwLzlrs+XQs+E8v6Vu4JlgwAMIhgYQAW9oF8DzXKRPX+OEL9HK5joniVtZ8t59SZ7blhFnIurf37Nu2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+Pj4Yao/oJksHunVXCYsk2ytrf2JyD20l3wg3iv2Wk=;
 b=cuksxX1gVvxino2Sn5ViTAzk9HcVc2lXFeo0BSLbB3TnyIxcj864TTmaXOagy0K5WqVQYlQIXcIthCFKUA0sff8x5o0k65f9fIpNIY/qN0E/XhZCLj+HIxcD4ZRiz1Rt6WPMes4XROWBeyOF3QBSdv3CqG7anoIc0ZnrzAdCMlX5qCReOgFmTOYxcgDgEDPZ2gGyKeg/0fESw07Fqs6kC0MM4Gcxw8SrhYcUz2rZJdwPrFSk6XyGC6cpCRqFv9ap4XB0fO++IL+9LozlhhyszHEsIKrHw/bU5swl57bV6wuKgjXiH+i2gnqUXWpGSrUjgp7o8DJFhtcO260S4b9xDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Pj4Yao/oJksHunVXCYsk2ytrf2JyD20l3wg3iv2Wk=;
 b=V9IV65LRCGk5wyd92vzJc660OfNFLVKBeKisTfzjk8G5TDKXs+JcZ6w32wk3HwOM0qgxrfK0ODaxTrtrtRK1zTYwXDpw0JIJpjAk1V/86cr9wuqW5wcTyIjXwr94RP0bQj/tArwjfIBsuoVxkrsg2vLGnZf3j5gCEK3kq5TKDdc=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by CO6PR18MB3907.namprd18.prod.outlook.com (2603:10b6:5:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 04:54:01 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 04:54:01 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Suman Ghosh <sumang@marvell.com>
Subject: RE: [PATCH net-next] octeontx2-pf: flower: check for unsupported
 control flags
Thread-Topic: [PATCH net-next] octeontx2-pf: flower: check for unsupported
 control flags
Thread-Index: AQHalTpCLTYCrsndvUigf1DR7kGv8Q==
Date: Tue, 23 Apr 2024 04:54:01 +0000
Message-ID: 
 <BY3PR18MB473745831DE04E6694F9EFD4C6112@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240422152735.175693-1-ast@fiberby.net>
In-Reply-To: <20240422152735.175693-1-ast@fiberby.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|CO6PR18MB3907:EE_
x-ms-office365-filtering-correlation-id: 7c1dd922-3852-46cc-5d2f-08dc635164fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RGt5SGZxS1JkeS94NXhBUWE1QTdMc3VVSFhPRWlhUk4wRDk1bmlqRWNvOHpM?=
 =?utf-8?B?dTV5LzFUYk45S3lJQVdxTWpvSWhhVDdxbGNSbUlnb2drZUJpcDI0Y0h6MFVH?=
 =?utf-8?B?aGdHaUJjNnVhRkpSaXoyWHpUL0dNcFU5bG9VOGl1ZEVadmlDdUJZLzVHZHh1?=
 =?utf-8?B?MWlBZ09KTmQxTzBSQ2Y0UkNUS1l6Um81eXZKS202bnE3UHQwSi9RUWR3UVk3?=
 =?utf-8?B?MTgrbnVUTW93TkVvcjFrektHS25mTlRCSXB4OXBwUGlnSmlDcGNPSlFyMDBl?=
 =?utf-8?B?YldOclZGc0cxMjFpTUZMV0hpOUZWNW42dVFSTTV3clkxWTNmN0J3a3MvbHIx?=
 =?utf-8?B?WGkyMVVTUW5YQVY1VGRHZlVCNEVrSmFRbzh6RDdZNE4vNjMyOUJJbWhqUU5X?=
 =?utf-8?B?TXNZbzNDMlBUSUhPemh2MUIrRDIvc1ByVzRBWDZhRVI4dkF5YVRZUHpzdGxQ?=
 =?utf-8?B?SUg5YXdWK0Z0ajRYU3dNRkNsdVRxY1VmbFlaeDluR0RBNml0dGMyeEw0S0ZK?=
 =?utf-8?B?c0dBS09EcGl6RTVod0l5U2NvSVBzM0dmdmJReS9Zdm9IUVpLcGc2cko2L0xs?=
 =?utf-8?B?NjZTRDd4ZGtFaytNUWhEbXpacDhjakp1Z3psdHlmRGgrMUtYNnIvZE50ZEZi?=
 =?utf-8?B?RVBQUEwxZGxXWnFDdU94dTYzemZ5ZGFkaFJjR3loU1dIYTF6eHFkUktEeGFq?=
 =?utf-8?B?cllzVnJ3aTl5akZmWFd5WDFrUWhWWjFmUHBLcm1KOWpxT0R4eTQ3Z25MaDU4?=
 =?utf-8?B?SUdsOGNDOXpwaUtVaDF0SmcrSHd2c3dHMEduVklqbkhkZzZYM0grVEQxUzVJ?=
 =?utf-8?B?dzlCZ201d0RSWldsYXVoM0FNNjVHYk80Y25OKzFCVHk2dG0zdkN6aldibzg4?=
 =?utf-8?B?UmJ3L000MUV0OHhLU2dJZ1FOak5nMERucEp4NjRXTWFGTDJTM3l0Wis5ZDRp?=
 =?utf-8?B?UXNtQkxXcTJweXFLa1ZIZEdTdElKNUVEbS8xZkpQQXZvYzMzSVZnZGN3ZVFR?=
 =?utf-8?B?U0YxSXVkMmRETHcwWnlLMWQrcXJJY1ZGa0hsVCtmaW5jSzNoTEJ5YUo0Mk41?=
 =?utf-8?B?YWZxaHZoR1ArWmo5MnVxRzJWa1BFQy93NkNMUksrSEF4TXdJbFZEMVgvUjhH?=
 =?utf-8?B?VlRBeTkvTHVHQ3IrWkJ1QSt6dmlTcXc0RDYxRnNISWk2bkhYQWdIc05obHAw?=
 =?utf-8?B?cEs0c1FhbXlLeEx0aXVUTlNzNUcvZE1jSDByelVtNXlqN3c2SkdlT1VKUXVK?=
 =?utf-8?B?STdKOERWbVp2UHNsTjA0Qkx3MUZiNHhabUpzMmpOUFpmYXBYT2k1Q1I2OWZI?=
 =?utf-8?B?SlhEZjJwWitzTnFScU9RN0FxUGVlS1NlUmx1RFhOS2J1V3RtUFY5ZjF3K1Jx?=
 =?utf-8?B?K1JaVUxxM0syV0dCWlhRNDFYdkZ6T0krZFVWVXJkOEl5YzZSQ041b3FzUXVL?=
 =?utf-8?B?MmVaWE4vRlRYL3ZNa0N0djA2a2VsVG1nekdzMGNQSGpTeElSYzNwcFZrbEpZ?=
 =?utf-8?B?eDhDdjFuRG9FZmVMQ2MwZFVqZG9mTmt0aVkySGIvMU95L3pwZ0t6aFR5aVFQ?=
 =?utf-8?B?VlNrYU5xbnE1cXFteW1kaXF2MmpGYVVXUzdTYzBEa3dFZWMzSFlIOFJXcFVm?=
 =?utf-8?B?TVJSVTdYODd6VHczWDVhbjdFMFJhR0VpUnk0OG0xc0lFT053eEVrNW9LNTBz?=
 =?utf-8?B?OFgva1BEc05jM0tJN0t5YUdFNHJyblZvR2o1RTZWbXI1UzNNakJSUWhEVjdM?=
 =?utf-8?B?dTFleGxUd3U0blJQV2VlM0Y1ZTZrU3MxYUdhd1AxOEtHcjdaanZpMEJRVVFq?=
 =?utf-8?B?OFV6SjZ6WWRQbi8wSUphUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TmlSOU5oV0h4MVdLeWlPNFc5YVBzVm54dktWcGhaMWo1cTR3T3dIVEZvVkM0?=
 =?utf-8?B?aVRscW9PaXFCb1hrdGlhSElnejAzL04xOWc5ZnJoaHF0RlNIRTZKWTM1WThr?=
 =?utf-8?B?WVltbFl3ZmdsRE9oajhTcjFJeHBwcytGdmFteVIvaENqVmRlS3FNbHdQdUhp?=
 =?utf-8?B?THV1eFJ6cG9nUlFnTHNKK2M2VTR1eU8wZ1BSb0xLNnhGSTlXeTJteGpjbzVq?=
 =?utf-8?B?emFzVnFRQU0vZnNJWTZ3VmtQQ1R5Kzc1U0FmWlFySU9zVmlPWG83dXRqREhD?=
 =?utf-8?B?MGI2Q1c5RGMvVjJJOGIvN3Z2UDlTcFhYYW9la3hNbmYwU2ROYkhwRnZ1aXc2?=
 =?utf-8?B?QldFYzBZYjV3Ylh0QnVzWkc0NEwwVmR1eDVNYncyRnNzYXRrbU1kcXZsRFE3?=
 =?utf-8?B?SE5mVlJYNlhSazdNQ2lzUFNyOFNNY0xNenNRb2pQMWxDdTBDSG0vanJ5MDRh?=
 =?utf-8?B?UTFEbTBCOFBwWDFYTmljV3NlaW9VRGRReWVFellHTTZ5MUVnd1lGcTc1QTNP?=
 =?utf-8?B?d3JlS3ZnMEdESndKQUx1TVY2a1k1Wk1zVXovYlUraDVVSkd1Y01TN0VHemI1?=
 =?utf-8?B?ZFBMYkx5UXFkTDY4WTJpaE1BWHVITW9aSS9OdkorK3BXYTA1OE5kcWRId3NN?=
 =?utf-8?B?U1EvZE5ZOUg5anl5UWpqMzROaDNQSHBPbmN1RDZkUjF2ZlRTT0o1dXkvUVdK?=
 =?utf-8?B?ZDRtckJvOHVIZEFIUWkwUzk3YVEwdTlQNUF1ZnY3Q0pTVUt5ZnBiWHlBK0d0?=
 =?utf-8?B?NGl1WFdtNzVaZjNhWXlDZ3dTYUZmZi9sejVsWkl4RUdJME9ia3NwbnNLR0Nh?=
 =?utf-8?B?NUd6dytpdFFka2E5dmlIT1o4YzVuM3I5dmlDM0diTktlQUlucXB6MHg1cXBR?=
 =?utf-8?B?bEtrVGtuUkptWHg0V2Z4QnRPcjMwZExWSXR6dElaOHZDaEtQRENzSWJrTnlN?=
 =?utf-8?B?dS94bGlLVE5uMmJzaHgxcTA3UXZZVXA3SHFyRDRUcWsyRnBsdDN2Rzhyc05C?=
 =?utf-8?B?Tnc5ZUxhZmlFQTdGcVJSTnh5SFFiNFlCTGs1YmdDMHV4R1hJZFpwc1h1ZjRr?=
 =?utf-8?B?Y0o3Ymd4RUh5SWZxTFB1S1NpSnJkdWJ4OVdERXYremNpcXNHaTBJWXIraEll?=
 =?utf-8?B?WnNINUJ3NlhPYmFBVGV6aklKVkt2NXZYaVNCdTAySVhPTmRGbmFlNjV6bHFz?=
 =?utf-8?B?eTllZEdXK1pQeUR3OFQ1T2wyNDhoKzhuelQ1RFNzMERXeitvZWJnZHNNd2hm?=
 =?utf-8?B?OG1HZWZkSlR1ZjZjTGNjejhwSnFmRC9GbkxHUmgzWURUOHEzTzJWV3JEU3dW?=
 =?utf-8?B?NCtHNER2Yit5MGxiRVBpYjNmMDFoUE56UVIvVDByd3U1cTFydEJ1OTYrN1Ja?=
 =?utf-8?B?NlQwWEtIM1hrRWFEalZnNFRkekxQd3JFSTVMUEJKendRS2VEeHNJSEVuaFQ3?=
 =?utf-8?B?eTJjTWM4VFFvMXJ2V3hETXJxcnVlTjFFdjl3QzhnYVZ5UnZLZ3g0OWx6c2sx?=
 =?utf-8?B?RVo4QkdXZ0hzUVJRdEkrSTZWYjBTQnZmM29IaEcxS0pJV0NyR0RWVW55UDM5?=
 =?utf-8?B?S2dvUnl2YlAwN203Mko5ZHd6dlFUM1FnY292c2lrSjVacVpyTU1tdEpTVnNu?=
 =?utf-8?B?M0sxSGVqWU1UVFQrSlpmbzN5TUhOMXNZYjlkcUVxLzRrL2s1SzNsaXBvTnZq?=
 =?utf-8?B?Zmk1SlMvblpQNHMxYUNwQVZFZFU2ZUNYK0kzU3FuYURKa3JlWW92RXV1WDY3?=
 =?utf-8?B?bGdrQ1VISEFtVFZ4aURoYVU4ZWhyQ0IyQi9aYzBscjJtWnllZnV2aG51ZVNy?=
 =?utf-8?B?dW9VdnI0TXRJSkpzSEMrSDd5ME41dzR1NG81RnhVdlZsVmtnZlFZTWxNQmJa?=
 =?utf-8?B?TXN1a0Y1eGtpaEZxOWE5VzRycUd4eUNyQUMvUE0vTUlUV0V4cjQxQjhleHpq?=
 =?utf-8?B?UVo4V0xTVVkxcTJiSFpVdjNmTk9wNTZXMWRvWVRucHpwT05EemRuQThzaEhF?=
 =?utf-8?B?ekNzcllHM0hoTkNZNUFpd09sTWtkSlU2alp0VHRhWUdxYXJiTXI4N08zM2F4?=
 =?utf-8?B?ZHpOQVhkeGxyWmp6bWJ1bWpXTXc1NFgrMWJqb0ZRdkxJdWtVcjlUYzFKYWd0?=
 =?utf-8?Q?JZusx4umeaUc3xlG2DyYcbF+s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1dd922-3852-46cc-5d2f-08dc635164fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 04:54:01.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFn3fnbJmYXmGYcLYCq6S00zOD/poVVhLUDEn3s2oZ1opplE2DAI7eA8ZVj+hYuKtwyUx0VV9J2zg+W7oDtryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3907
X-Proofpoint-GUID: 5azF_PRluqhukFhxWEJ-T-yRuu9aOhiA
X-Proofpoint-ORIG-GUID: 5azF_PRluqhukFhxWEJ-T-yRuu9aOhiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_02,2024-04-22_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXNiasO4cm4gU2xvdGgg
VMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIw
MjQgODo1OCBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogQXNiasO4cm4g
U2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1
bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJu
ZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgU3VuaWwgS292dnVy
aSBHb3V0aGFtIDxzZ291dGhhbUBtYXJ2ZWxsLmNvbT47DQo+IEdlZXRoYXNvd2phbnlhIEFrdWxh
IDxnYWt1bGFAbWFydmVsbC5jb20+OyBTdWJiYXJheWEgU3VuZGVlcCBCaGF0dGENCj4gPHNiaGF0
dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtIDxoa2VsYW1AbWFydmVsbC5jb20+OyBT
dW1hbg0KPiBHaG9zaCA8c3VtYW5nQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFtQQVRDSCBuZXQtbmV4dF0gb2N0ZW9udHgyLXBmOiBmbG93ZXI6IGNoZWNrIGZvcg0KPiB1bnN1
cHBvcnRlZCBjb250cm9sIGZsYWdzDQo+IA0KPiBVc2UgZmxvd19ydWxlX2lzX3N1cHBfY29udHJv
bF9mbGFncygpIHRvIHJlamVjdCBmaWx0ZXJzIHdpdGggdW5zdXBwb3J0ZWQNCj4gY29udHJvbCBm
bGFncy4NCj4gDQo+IEluIGNhc2UgYW55IHVuc3VwcG9ydGVkIGNvbnRyb2wgZmxhZ3MgYXJlIG1h
c2tlZCwNCj4gZmxvd19ydWxlX2lzX3N1cHBfY29udHJvbF9mbGFncygpIHNldHMgYSBOTCBleHRl
bmRlZCBlcnJvciBtZXNzYWdlLCBhbmQgd2UNCj4gcmV0dXJuIC1FT1BOT1RTVVBQLg0KPiANCj4g
UmVtb3ZlIEZMT1dfRElTX0ZJUlNUX0ZSQUcgc3BlY2lmaWMgZXJyb3IgbWVzc2FnZSwgYW5kIHRy
ZWF0IGl0IGFzIGFueQ0KPiBvdGhlciB1bnN1cHBvcnRlZCBjb250cm9sIGZsYWcuDQo+IA0KPiBP
bmx5IGNvbXBpbGUtdGVzdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXNiasO4cm4gU2xvdGgg
VMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYyB8IDggKysrKy0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMu
Yw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3Rj
LmMNCj4gaW5kZXggNmQ0Y2UyZWNlOGQwLi5lNjNjYzFlYjZkODkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3RjLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdGMuYw0K
PiBAQCAtNzAwLDEwICs3MDAsNiBAQCBzdGF0aWMgaW50IG90eDJfdGNfcHJlcGFyZV9mbG93KHN0
cnVjdCBvdHgyX25pYyAqbmljLA0KPiBzdHJ1Y3Qgb3R4Ml90Y19mbG93ICpub2RlLA0KPiAgCQl1
MzIgdmFsOw0KPiANCj4gIAkJZmxvd19ydWxlX21hdGNoX2NvbnRyb2wocnVsZSwgJm1hdGNoKTsN
Cj4gLQkJaWYgKG1hdGNoLm1hc2stPmZsYWdzICYgRkxPV19ESVNfRklSU1RfRlJBRykgew0KPiAt
CQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIkhXIGRvZXNuJ3QNCj4gc3VwcG9ydCBmcmFn
IGZpcnN0L2xhdGVyIik7DQo+IC0JCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+IC0JCX0NCj4gDQo+
ICAJCWlmIChtYXRjaC5tYXNrLT5mbGFncyAmIEZMT1dfRElTX0lTX0ZSQUdNRU5UKSB7DQo+ICAJ
CQl2YWwgPSBtYXRjaC5rZXktPmZsYWdzICYgRkxPV19ESVNfSVNfRlJBR01FTlQ7DQo+IEBAIC03
MjEsNiArNzE3LDEwIEBAIHN0YXRpYyBpbnQgb3R4Ml90Y19wcmVwYXJlX2Zsb3coc3RydWN0IG90
eDJfbmljICpuaWMsDQo+IHN0cnVjdCBvdHgyX3RjX2Zsb3cgKm5vZGUsDQo+ICAJCQkJcmV0dXJu
IC1FT1BOT1RTVVBQOw0KPiAgCQkJfQ0KPiAgCQl9DQo+ICsNCj4gKwkJaWYNCj4gKCFmbG93X3J1
bGVfaXNfc3VwcF9jb250cm9sX2ZsYWdzKEZMT1dfRElTX0lTX0ZSQUdNRU5ULA0KPiArCQkJCQkJ
ICAgICBtYXRjaC5tYXNrLT5mbGFncywNCj4gZXh0YWNrKSkNCj4gKwkJCXJldHVybiAtRU9QTk9U
U1VQUDsNCj4gIAl9DQo+IA0KPiAgCWlmIChmbG93X3J1bGVfbWF0Y2hfa2V5KHJ1bGUsIEZMT1df
RElTU0VDVE9SX0tFWV9FVEhfQUREUlMpKSB7DQo+IC0tDQo+IDIuNDMuMA0KDQpSZXZpZXdlZC1i
eTogU3VuaWwgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+DQo=

