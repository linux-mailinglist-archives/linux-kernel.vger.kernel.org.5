Return-Path: <linux-kernel+bounces-15209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F9822861
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B533B22D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6018B09;
	Wed,  3 Jan 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="DdkWwkVO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656D182CA;
	Wed,  3 Jan 2024 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZujBbf01IcdCM1f3Jwg5ek1O0b3+3vg2wSG1XCxC23RBNl9lVMp2xWC8zSEe2xnHQqf7CQHu8eGN3Kc3Qo66LZv8TDQhaTzb4KaARchySEPOphTroDS2cra5IN55TDXFgFc7cg09CCgsLUgrwFvmJm75LrHy33YIrZabLZbi2hA7xCeUzIePCX69quOmjLJPWL6nFeChZ9/xdyha1WgxbQdmfU9lDVGjX9khmDmez/7DQaDDyjhT2J0XtNMdFy2qpCnOyALxewRTLXZUZzfaeea02v1ym3iAhNxTDFFfS2CGgA3bBAptx1Xe87Qil1uOn8E9kEBVaZaLyCQnn3PbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPnBAB65jmBQDLunpS8k5O/cIgfIkQi5kIiRI2Szkg4=;
 b=VLpap3fysCN1L0A+G61Ig5vjNHDwq5LMYvqjA8EDBHAOdm/cyAqBhjTudQG73p1lJU/EItYdn/DAedi4JKEJlN17r8GLmat8GudK3o+0rvQB6wBGgQXcTvs8gvw9CJg14XhnvvcMmqJAEQKiHAATWEgau0fTnk1zxpMmizNeK6cQ5wnxatuEayTn2D5MrA5t7+pOa4TaN4pl34pQ4bQsEfZ7lEAA/2EdxoiIscMsILQjoIzqDciChFyGSt3QlXAlI+nGCsvdzyj+wJB8kQ9PMq4th2vR29ceDdeDOa4wnWbUVFUV9zePrzUAraTZfJM7a0K0k6D4XDBVFnbxhI2RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPnBAB65jmBQDLunpS8k5O/cIgfIkQi5kIiRI2Szkg4=;
 b=DdkWwkVO1EUqR1dPhDi2gD3XFmzCHU9GJW3Z2m4ZHY7y2nLbZvfivXT60ONHOVfqkSCyXLytdOREhF2mpLFu5wBuOSFSOVqEKBQLNcv0QpnhgUbNb8p5/ocn5TBDHeGFCk5DrMEk2XNzUaJWrF4mKDuBJi99kO6RUk6laQsk5GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:12 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:12 +0000
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
	m.brock@vanmierlo.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date: Wed,  3 Jan 2024 07:18:16 +0100
Message-ID: <20240103061818.564-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103061818.564-1-l.sanfilippo@kunbus.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f77156c-8206-4263-c196-08dc0c23e767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nGEyZu1xfvJUAaMFj3Wd25DC2K3Rxxu9UMussr0XYAx36glD5pvZclkOxHQNvIETGcl0nBFj8rCsTD4rp75VS4dlFeZct+afsWTEjSkuxRvtzEitS9ZOpaiXvBPPkqrhE8wqaDHlKwr+UhHtM8BKIcSaXMuGsggVzFl2mQF1VqMt60mBBe8XcjEhheTZ7BZrL1kvUTvmnd7def+d2HIvrxJzJBJ2rCl5B6T/rz6u2Y/Z02shkhKLjQPRIPFDENASnkfvwfJbH0u4CHDWDIQ9bB6QvjySclI7RSfKfDtGhfOV0WmuzlaiVOB21e5+YdzMdFpp1lTdIn3VJlSCp20ZFnUnIK3rVa/dKQw/IVUQWQmxhzYOHeCLy9/Ll6AO5mXLPKXqw2vl9WB/GvtxWRszuo0EQcnklo5g9q4gGqS+RtwNkIscK5l5LBsblbhlwryBssZZZ13CZuwj+p1txfmCrTpm7G4KPrgJwePIxtRLNH9zx9iziVWdk0Y2Dfqj+4aOxi0zSqgirQfyXiISXOw2LBtq85UzgIr3KDwXAjivQhuwYFmFGYrn+QagHd3SLX0C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(52116002)(1076003)(2616005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXJTZ3N4QU5sRGVlcjFsd0JsUUxXbHJpT2pPQ2FQL3JEeDFNNmVNakYvcTZ2?=
 =?utf-8?B?RUlyL1BITUUxTVd6L1VMOHlvNVJzNG5pRm1lQk42RG1QQlBrMHR5bzhVR1lR?=
 =?utf-8?B?RmZORWVSL05Ta01pZWJQOC92SXIraXdtemV6M29ZZzBPRUg0THVwTU5LZkI3?=
 =?utf-8?B?U2RoSkxSbmEweWdWRWYwNEs2TWluS0dYTjNUZjM3b0IxTEhKT20wLzJkaldL?=
 =?utf-8?B?aTRIai9aUWJBaDljMytUdE54dTBMSTJVcVZCbDIyRUg2MkprOXpFcVZ1UUpl?=
 =?utf-8?B?SHo3QnI0YzNTWEg3U0RPQjFhUUJxSjhUVnFtdzFyaXJuQnpoUEtMaWt1RXJw?=
 =?utf-8?B?TUtaU01tcWpNa0xUQkF4alhEUllUb3JLMzMwT1htU3c1aVNCbVo5TUhTbnIx?=
 =?utf-8?B?UUNmdU1ySmlFMnlwZFNFSU1CdWVMT3RncVZSVG1NbC84Yk11SmlHcFg3Kyt6?=
 =?utf-8?B?QnZkeTgrbmU0Q3hDTE1UWGE5d0FPSHR2Rnh1U2ZicFVSMEZsZ1FUUVdKZ1dO?=
 =?utf-8?B?TGtzbzFlemljcDNDNkM1c01hNFkyQXlQRWdIeXVuWGZMOWl2dXU2dUdac1Yx?=
 =?utf-8?B?SzJqQy90TXo1MWQvZ1puUVNVaEJyMDFuaHJIVUpZVm11cC9QaStuTXFQc0Mw?=
 =?utf-8?B?UmNXa3BRcXFMS0VLTDNzT1loSmpTcnU3Z3M1ZVJGR01VeDZMN2JEdXI3alM5?=
 =?utf-8?B?Z0l3MlVTK2VCQlV2MDRVMTFQL3BIdS9PK0tBeDc3bUt6M1dTOXRHNWV1Nm5P?=
 =?utf-8?B?TksrYkVDVVRYUDFuWkIwYVZTSGlZQnRBaGNSTVhqeDNPYTZtaysrdTV4a2Jq?=
 =?utf-8?B?OFo3TFdGSnluTmNSOU5UQllXWlUyaGJ1RkFoUVV4RmhCaXhpNGhmQWhLcTQ0?=
 =?utf-8?B?Y3l0ZFZKYUMySjBFdjZxeVlQV0Q0clVsSU80L1QwQkpwUjFjUFI5L3dTWURr?=
 =?utf-8?B?akRJSkRoN2JnRnFmZzhPbkhHVmtnRVloUFFrbHdoUlY2Vzk4ci9nK1hBMUFT?=
 =?utf-8?B?RmFneTBacTlQdmUvazRJVW1oS2FCaDZJdHBoN003K0VxcGVyN29MN3hNbkE2?=
 =?utf-8?B?Y01ydExwTmhSa2ppUFhKWG5JdWZLUFh1OCswK09WbEVUNmV1NlAxNEkzT1k1?=
 =?utf-8?B?S2ZWU3F6RFdQd0VqVXc5RXJ4d3FUb1k4R3IxRWdKRkZJYTZPcmJPc29YNlNJ?=
 =?utf-8?B?VUtZdXB2Y0MxRHBPczUvUXJybzFiZ0FFaFZ5Z1B1QjRoZ3h6U0MzTFF4S1dC?=
 =?utf-8?B?ZnV3S3o4a0JaM2dLbkZmb0twZ3lONWp5djdYOVYxb1M1NVNQMGxxOHlPYzVr?=
 =?utf-8?B?VzMzNUxubTlndlVHbXhyWGxqNE0vMXJKQXozUk9nYlhYQzBBVFZlcGZwYjhE?=
 =?utf-8?B?SnhsaWphWCtmME1tQlNoWnowTzBsUmFPcFJDR1NucUQ5Z1ZlZUhLdm9aVldn?=
 =?utf-8?B?b3A2NkpiOEgzK1BoMkhNVFYwNE4vcjcwRFhiMXFqeGFsMDY2RHo0TlI3Yll1?=
 =?utf-8?B?cDFwY3lDYUxzbnFPbkFpUnN4MWtHbUdQNE1wK2VYYk1lSjVER0krNC9md2hM?=
 =?utf-8?B?eWRRWUtQbWZIbU5QemZvV3VWcGRwRHp0eXVwOTNCMEJMcHAzQVVmMUNzcWRH?=
 =?utf-8?B?ZGxpOUdEMzJySDI5VFpLT1BHaVVNanlSdzkvRitCbkpLQmpiaDdFUGZKNTBx?=
 =?utf-8?B?TnBUU1MwZGwvcFYrWWVtRXZ2eHQrTjdtTktzSTJwdzM2Wnl2Yk82OGh1ZWYz?=
 =?utf-8?B?ZzdYeHdLQ0VLRGE0VVNENG05amltRXdHaUhlLzNScGxzd1pJRWZSOENLZEFG?=
 =?utf-8?B?NnNtbE5PdzFRcEpIY08zdHhTUFpwemp4enpDR3pCamtkZjhkWENLbHo1Vytv?=
 =?utf-8?B?TFZ1K293aVhaZnRKZDcwV1ZkR1dYU3VaZVI5WkUvbXVHbnFkcVAzSlZsYVpM?=
 =?utf-8?B?djYyS3FkOXZNcnA4ZUg2cGdrL2xQcFdScTE4VkFOeFhjVGEvSlFCOTdUSjJz?=
 =?utf-8?B?UDZzczNoM2E3UVR2djc2OHM4Z1NwV01ETFZ6S015QVlUa0t2T2N5NUVLTjZX?=
 =?utf-8?B?T2lEaFZ5a0xKSUtZbDRKWnd4akF2ZW9ZcHRhWkNFOUxJa09RaGY2ZXFmb2gr?=
 =?utf-8?B?MHVKY3pxWnBaRGRGWGZtdG9rZ3M4b1VzaXBZWmIrV09yclVleXA5bXZXS0w3?=
 =?utf-8?B?RHVKZy9LTHRGNWZGM2c4a2NFVWJVLzlFeUUxaVRlQWNiNStxZXhJdHpLYVhF?=
 =?utf-8?B?cElZMHE5aSs3Y0hEMlYyNllnZnJRPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f77156c-8206-4263-c196-08dc0c23e767
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:12.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZhpjmiY5i1KRCeGKK2uOixqTpu5Pw1Xub0Dd+vXMU8gSay4CMDqgQoQDB56Zq4y5TjlEYkFxrWe2STNIxU+gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgbnVsbGlmaWVzIHRoZSBw
b3J0cwpyczQ4NV9zdXBwb3J0ZWQgc3RydWN0dXJlLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFydF9n
ZXRfcnM0ODVfbW9kZSgpIHdoaWNoCm1heSBzZXQgdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBuZXZl
cnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJTNDg1
IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRlZCBp
biB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBieSBi
YWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJMRUQK
ZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEgY2hl
Y2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJpdmVy
LCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFNvIHJlbW92ZSB0
aGlzIGNoZWNrLgoKRnVydGhlcm1vcmUgdGhlIGV4cGxpY2l0IG51bGxpZmNhdGlvbiBvZiByczQ4
NV9zdXBwb3J0ZWQgaXMgbm90IG5lZWRlZCwKc2luY2UgdGhlIG1lbW9yeSBoYXMgYWxyZWFkeSBi
ZWVuIHNldCB0byB6ZXJvcyBhdCBhbGxvY2F0aW9uLiBTbyByZW1vdmUKdGhpcywgdG9vLgoKRml4
ZXM6IDAwZDdhMDBlMmE2ZiAoInNlcmlhbDogaW14OiBGaWxsIGluIHJzNDg1X3N1cHBvcnRlZCIp
CkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEgSGF1ZXIgPHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClN1Z2dlc3Rl
ZC1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
U2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4K
LS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8IDcgLS0tLS0tLQogZHJpdmVy
cy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDljZmZlYjIzMTEyYi4u
MTk4Y2U3ZTdiYzhiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0yMjA2LDcgKzIyMDYsNiBAQCBzdGF0aWMgZW51
bSBocnRpbWVyX3Jlc3RhcnQgaW14X3RyaWdnZXJfc3RvcF90eChzdHJ1Y3QgaHJ0aW1lciAqdCkK
IAlyZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7CiB9CiAKLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2Vy
aWFsX3JzNDg1IGlteF9ub19yczQ4NSA9IHt9OwkvKiBObyBSUzQ4NSBpZiBubyBSVFMgKi8KIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlteF9yczQ4NV9zdXBwb3J0ZWQgPSB7CiAJ
LmZsYWdzID0gU0VSX1JTNDg1X0VOQUJMRUQgfCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgfCBTRVJf
UlM0ODVfUlRTX0FGVEVSX1NFTkQgfAogCQkgU0VSX1JTNDg1X1JYX0RVUklOR19UWCwKQEAgLTIy
OTAsOCArMjI4OSw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikKIAkvKiBSVFMgaXMgcmVxdWlyZWQgdG8gY29udHJvbCB0aGUgUlM0ODUg
dHJhbnNtaXR0ZXIgKi8KIAlpZiAoc3BvcnQtPmhhdmVfcnRzY3RzIHx8IHNwb3J0LT5oYXZlX3J0
c2dwaW8pCiAJCXNwb3J0LT5wb3J0LnJzNDg1X3N1cHBvcnRlZCA9IGlteF9yczQ4NV9zdXBwb3J0
ZWQ7Ci0JZWxzZQotCQlzcG9ydC0+cG9ydC5yczQ4NV9zdXBwb3J0ZWQgPSBpbXhfbm9fcnM0ODU7
CiAJc3BvcnQtPnBvcnQuZmxhZ3MgPSBVUEZfQk9PVF9BVVRPQ09ORjsKIAl0aW1lcl9zZXR1cCgm
c3BvcnQtPnRpbWVyLCBpbXhfdWFydF90aW1lb3V0LCAwKTsKIApAQCAtMjMyOCwxMCArMjMyNSw2
IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlpZiAoc3BvcnQtPnBvcnQucnM0ODUuZmxhZ3MgJiBT
RVJfUlM0ODVfRU5BQkxFRCAmJgotCSAgICAoIXNwb3J0LT5oYXZlX3J0c2N0cyAmJiAhc3BvcnQt
PmhhdmVfcnRzZ3BpbykpCi0JCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIFJUUyBjb250cm9sLCBk
aXNhYmxpbmcgcnM0ODVcbiIpOwotCiAJLyoKIAkgKiBJZiB1c2luZyB0aGUgaS5NWCBVQVJUIFJU
Uy9DVFMgY29udHJvbCB0aGVuIHRoZSBSVFMgKENUU19CKQogCSAqIHNpZ25hbCBjYW5ub3QgYmUg
c2V0IGxvdyBkdXJpbmcgdHJhbnNtaXNzaW9uIGluIGNhc2UgdGhlCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxf
Y29yZS5jCmluZGV4IDI4YmNiYzY4NmM2Ny4uOTNlNGUxNjkzNjAxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwpAQCAtMzYwMCw2ICszNjAwLDkgQEAgaW50IHVhcnRfZ2V0X3JzNDg1X21vZGUo
c3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKIAl1MzIgcnM0ODVfZGVsYXlbMl07CiAJaW50IHJldDsK
IAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVE
KSkKKwkJcmV0dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXko
ZGV2LCAicnM0ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxheSwgMik7CiAJaWYg
KCFyZXQpIHsKLS0gCjIuNDMuMAoK

