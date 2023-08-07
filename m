Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF37728A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjHGPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67510DE;
        Mon,  7 Aug 2023 08:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6Pxi1NoX/sePte0ctlIr6F6J8VZ+pp8U9YdoBNDP37aSSmkW4tq/wiVuC3tOLF0218Sx+FvULhTHiGrFvMY5BSEcYzL2M89NzHtA3WEiNX5DZrzJWWLcE7rqZ5G8fHV+vxSQ6KpUqbssJV+SGeEWii03gz/TrEorZ87LgP0WJM1GFNfHk67aGdwjFxwEEFaYUHE//j+tLMaNxAUr1QpouJP84oB9nMKulod/vw3D6/gEvt0H3ygI5CBz5y+HtVk4QsoTKpHfashtGp0gk1UkNkcVyHiwY+HJALRAayGf1UYAlvvmoqgVJ71x8xFuz72dmLwTMoLvNh1ZHPaJiC6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTH5wIR+R1oRA1WM5IDcLdUhxe6B0hWxMJqCmFDulfc=;
 b=JThJTvZgxnn7W9tWPwkZNd1GWWd30ST11nD41jfcY/CeFKa73igw5LTzRLzk5lQzK3W/HHBXtDIGFYaKlo3/3LA+FiNAWJpyufaFBNw5Uhgnyj2ZTupnZHTzJlRomgrg+oZpr+UGTMLrSVKTDFrawGLqg9Qfqk0MEOLCaVVOO28khj1bc/IlCJgyD5DFf5+1V17u7D3hRc1etvupHp6ByK2SXRmpnimDGIVsKQ9XxO2k96WCbBzv7EK0MO7dFKnqJuc0h7y2nUan7KISWqWtFkgLErQgE2Ih6bkHRXkhPYerT0NvyVsU8MMNVad9aCDasndBzknGq3yBYwP8vNUqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTH5wIR+R1oRA1WM5IDcLdUhxe6B0hWxMJqCmFDulfc=;
 b=jX0fJWMgPDgLhlUhN4yG1yTrjgCSgAPSBljFWeWo+KhxAZoqgLu3UViGs6L90Hq10hiuQZRBKWGULi1fgyrsU7mhCcMLvwXr6LF/f2NunOTE1FqJN9AuLt9iLG711hmpJEcbGytftHt0pQZORM3Bkv0/lm+h2NA/oZ1GOxJEYhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:09 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:09 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 6/9] wifi: wfx: implement wfx_remain_on_channel()
Date:   Mon,  7 Aug 2023 17:05:39 +0200
Message-Id: <20230807150542.247801-7-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807150542.247801-1-jerome.pouiller@silabs.com>
References: <20230807150542.247801-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: f833c409-4e72-4aa9-c87d-08db9757d49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJ++EnFr0GQiQQmkZ4dW4f6L9trGBrNT2YJ8dHyiAP7RIlU5Z2+GHzQAFeDgMDc5CKVPhcazuXaPmzzW5MsHsKFiNyW8BMoLlEBogsqpXWC8dkPR9Q6yTSbwUgcVsDimAHsQhrTU93ADs0HJFjlwxzXDvfyfalw4KzEyHD0DgMhM7xa7Jght+NfaFaf1//rAKb6moXk+y6BlV8TCaXil/HVWISdPWyjEGvaFDDsBkNvERgfE4CNBIanOE0jC/hUQP9nna0eCmH0MhWRrIjGOe3HfxIVKCKM+Y+9+8XT++r6qGAS38PDOMo0wpNZZ5PKvl74W9CNWyUs30og/SK5iVd/kD2/BAMdeeNq+ik8gL0sOeMf2EC7tbHTSGFXFHJy1KbBXtBLgmZ/3CU3AqxWhsB6C97jihQ9DZw/c41sk4gKuBz4/WVSetThSwR8DO4XdtQXum3xViBAUCXF/y46knV5/uah6LNOiLYomJngKO/2ASIaaj7uhMK9jGOzXUk3ZgMfViKSnFZrbIh0vD0iRpkVM6TkbhvNYDUdMyvdhTZAT6uGI5LBk/v5KcIidds9zoyWoewPeMDmnIwPN84e/xQRsV+edodR9MTiUwous5b7zwFRK63jaTSLPKYMcG2dE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRaeEtqZS9xa3lGemtHT3RUMEZCWWxKdWtWT0orMGdEM2duL3E1d2Flc0pW?=
 =?utf-8?B?NEdxSzR3MVdzVTVmNVFKczhoT1U5WG5QVkdTRGtNMUdlK3dZc0RRWndrR21M?=
 =?utf-8?B?aE91dFBrcFprZW1RWjd3MEVFN1JPMXFvTjRxdUhwUWRZaUNVWG1JQkY5UEN5?=
 =?utf-8?B?UXdYL1N2Y2hacU0rNmx3c2s3cXM0b0thOVB2bkd1eENQNGtaUXZSTjV2Mi8y?=
 =?utf-8?B?VFhTZE9tbnNsNWtXK05COWFEOHMwQ3lYQUdQY1QwbDdnYkNHZ1NEeFVCbWtU?=
 =?utf-8?B?bzdpVnRNUjlkVlVIMk5ycjVQRENTWjZESmp0QjFRNVF5U0F2Z2NZQ0lFVlB3?=
 =?utf-8?B?NmRuTnBFZlhMUFdwSndpYno5WGNCRDBsTG0wVUdNNjVRQmV0ekt6SG9vYVoz?=
 =?utf-8?B?YURpbXpDRG9JSDRuVDdQU0Q0UnhvdkpNelNHcWg4d2d1Y0xkd1NCWGVMeE1G?=
 =?utf-8?B?Rk9vUnVlTWNqeEFJbW54UGlkWi9zaVBqbjdmMXNNdDBzM1JVSkNNRW0yMHhD?=
 =?utf-8?B?ekxCNHNpeWZzM2k4ZFNmYWpwbmJOb09MT0JyWXRGWkh4dGJhYWhjRDE1c0Rv?=
 =?utf-8?B?dXpsL3dDNmhjK2JjU1JESWFHODBxMkdSa3dWaytoQU5aMWcvVVJEYnk2WFgy?=
 =?utf-8?B?QU5LTFNYQ3VDRU5RcFBWWHdBeVllZ1RlQVB4MllaR0pUNDZIWWhwc3lPN0FS?=
 =?utf-8?B?dTVMd3ZhVUNZS1h2ZStUUkFObmF4WnZRTDZNbEtONmV3OFRrRHpTSWZqSWlw?=
 =?utf-8?B?OHE5aHh6L3dtNGtsRzhLZXRDVTE3MjlYcUp1Yjdsa3hLMjYzMWJXZFJISmZQ?=
 =?utf-8?B?RlJSZllUNGxvcmszYUJJRnJiK25DT3o1cEZ6dU5reTRrNTBFMXFtdWxPTlpB?=
 =?utf-8?B?WTF4VVJJMStPZVFueHh2ZnUvcnl0ZmR2TGJCMWJNWm9zM1oxN0F6eU9IdHFN?=
 =?utf-8?B?OGFpd0NwTVZxYm9GZE1VVUdYTjFmc0xvSWVTNzh4eVZhNjV3SDl5bFI2a3hZ?=
 =?utf-8?B?UEExbUJRWUpzd0JvUmlDNU9DVjNsWHhmVDYzWkJ5aDNlNjVMcVFDMXVjRkZr?=
 =?utf-8?B?eDdtY3hEdUNGbFVjVHN6U1hpSVMrNEs4azVpV2I5RUMvbTNCS1ZTZ0JpQlRa?=
 =?utf-8?B?R2dUOS80OFlHWEN0dW9VUTJOeTlHeTBtUXZoTXdmOWh0SEtIRnhBSFNSZWMx?=
 =?utf-8?B?eEZBdXVsMEw0VWxYMDlmeUlZa3hwOVdEMDczUEFMckFIZ2NWQ3pnL2xpaVJJ?=
 =?utf-8?B?MVNtRHZxai82SW5YWGxKdXRFMWRMdEcwemNlYVVHem40TjRyWk5ndXE3aUVS?=
 =?utf-8?B?NENPSEU1STZNdlRPbjJlT3NpbndTZEVqbldJOFErQWh3dGhzL2tyK1h5eWl2?=
 =?utf-8?B?VUFBNysxZUY2VjVDZ2lBRTdEdU16MUk5ay9kM0V2NjAvaTBIZ3h5RUk0WFZp?=
 =?utf-8?B?ZU5SVFlDRWE0ZUZiTXNraXMvTEdocE5MaklKaTJWV1I4SlBrNFhmc2JXOEtC?=
 =?utf-8?B?eG1GR1d6bStTcW43cnZDaHJ0bHlibXJReWhaQ3JvR0FqTFlRa0owcEVUNFph?=
 =?utf-8?B?Vi9QOGJNTXhCRno0eW45WTVBVW9TMjE2dFBscFc3aENXN0ZKcTcrYjh4SmJo?=
 =?utf-8?B?R2lxUXhBWEhYeStXUXkxSkFySHFTRTlhTms4dXRQNjVub2xCcUF6WHM5T3Jx?=
 =?utf-8?B?SlJHdW52aVdPeVZkeVdIVFAxL0RUODZSdVdlTEVPRHpLQmsrMW1GRW5NTWNY?=
 =?utf-8?B?STIrS2dYNGRqYWhndzQxVFB5dTh2UUI1WHVYMDFZdzJLZ20zYURKMXZZVVRj?=
 =?utf-8?B?UDVPNldFMVprNTBXR2lxcVFqOFNmQzNQS1dzKzhuRG83Q2lDbkNEbEhxS0Ez?=
 =?utf-8?B?bkhidlIwK2xZbE1iWGQ5YkVORmRWNi9HNXFCV0dJYTEzKzJRdThKeDU4TW8v?=
 =?utf-8?B?YThTdVFBOURONkJlcExrWHF6NDh6cGhFcVdxS0dOQm1QM3BPOVdxb3ZNT1Fo?=
 =?utf-8?B?ckJtT2hXeUFDRnlPZ1pDTUkyMkY5WHlIenViQUpSRXFncm9kMzhIeUJia3gv?=
 =?utf-8?B?Y3FCSklOdWUxRUZ5Uk9NV3NXT0IrV2VxY1pucDYvbTVNY0h4QjNXbVNLNWZ1?=
 =?utf-8?Q?YkEpQE2V0zOJOKWN6mVs/8Kom?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f833c409-4e72-4aa9-c87d-08db9757d49f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:08.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cx8GKo0PGKLvApt3+Uqn8W7pWGQSOOqkik/92zeZod1Pbm/mt3mCOa7f41ILD8RCoR5b257B5HSGbzAHBYoWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gc29tZSBjb25kaXRpb25zLCB0aGUgZGV2aWNlIGlzIGFibGUgdG8gc2VuZC9yZWNlaXZlIGZy
YW1lcyBkdXJpbmcgc2NhbgpvcGVyYXRpb24uIFNvLCBpdCBpcyBwb3NzaWJsZSB0byB1c2UgaXQg
aW1wbGVtZW50IHRoZSAicmVtYWluIG9uIGNoYW5uZWwiCmZlYXR1cmU6IHdlIGp1c3QgYXNrIGZv
ciBhIHBhc3NpdmUgc2NhbiAod2l0aG91dCBzZW5kaW5nIGFueSBwcm9iZSByZXF1ZXN0KQpvbiBv
bmUgY2hhbm5lbC4KClRoaXMgYXJjaGl0ZWN0dXJlIGFsbG93cyB0byBsZXZlcmFnZSBzb21lIGlu
dGVyZXN0aW5nIGZlYXR1cmVzOgogIC0gaWYgdGhlIGRldmljZSBpcyBBUCwgdGhlIGRldmljZSBz
d2l0Y2hlcyBjaGFubmVsIGp1c3QgYWZ0ZXIgdGhlIG5leHQKICAgIGJlYWNvbiBhbmQgdGhlIGJl
YWNvbnMgYXJlIHN0b3BwZWQgZHVyaW5nIHRoZSBvZmYtY2hhbm5lbCBpbnRlcnZhbC4KICAtIGlm
IHRoZSBkZXZpY2UgaXMgY29ubmVjdGVkLCBpdCBhZHZlcnRpc2VzIGl0IGlzIGFzbGVlcCBiZWZv
cmUgdG8KICAgIHN3aXRjaCBjaGFubmVsIChzbyB0aGUgQVAgc2hvdWxkIHN0b3AgdG8gdHJ5IHRv
IHNlbmQgZGF0YSkKClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91
aWxsZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3Nj
YW4uYyB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L3NjYW4uaCB8ICAxICsKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvc3RhLmMgIHwgIDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaCAg
fCAgNSArKy0KIDQgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMKaW5kZXggNTEzMzhmZDQzYWU0
Zi4uNTdhMmQ2M2RkMmE2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zY2FuLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMK
QEAgLTE0NiwxNCArMTQ2LDY0IEBAIHZvaWQgd2Z4X3NjYW5fY29tcGxldGUoc3RydWN0IHdmeF92
aWYgKnd2aWYsIGludCBuYl9jaGFuX2RvbmUpCiAJY29tcGxldGUoJnd2aWYtPnNjYW5fY29tcGxl
dGUpOwogfQogCit2b2lkIHdmeF9yZW1haW5fb25fY2hhbm5lbF93b3JrKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IGNvbnRhaW5lcl9vZih3b3Jr
LCBzdHJ1Y3Qgd2Z4X3ZpZiwgcmVtYWluX29uX2NoYW5uZWxfd29yayk7CisJc3RydWN0IGllZWU4
MDIxMV9jaGFubmVsICpjaGFuID0gd3ZpZi0+cmVtYWluX29uX2NoYW5uZWxfY2hhbjsKKwlpbnQg
ZHVyYXRpb24gPSB3dmlmLT5yZW1haW5fb25fY2hhbm5lbF9kdXJhdGlvbjsKKwlpbnQgcmV0Owor
CisJLyogSGlqYWNrIHNjYW4gcmVxdWVzdCB0byBpbXBsZW1lbnQgUmVtYWluLU9uLUNoYW5uZWwg
Ki8KKwltdXRleF9sb2NrKCZ3dmlmLT53ZGV2LT5jb25mX211dGV4KTsKKwltdXRleF9sb2NrKCZ3
dmlmLT5zY2FuX2xvY2spOworCWlmICh3dmlmLT5qb2luX2luX3Byb2dyZXNzKSB7CisJCWRldl9p
bmZvKHd2aWYtPndkZXYtPmRldiwgImFib3J0IGluLXByb2dyZXNzIFJFUV9KT0lOIik7CisJCXdm
eF9yZXNldCh3dmlmKTsKKwl9CisJd2Z4X3R4X2xvY2tfZmx1c2god3ZpZi0+d2Rldik7CisKKwly
ZWluaXRfY29tcGxldGlvbigmd3ZpZi0+c2Nhbl9jb21wbGV0ZSk7CisJcmV0ID0gd2Z4X2hpZl9z
Y2FuX3VuaXEod3ZpZiwgY2hhbiwgZHVyYXRpb24pOworCWlmIChyZXQpCisJCWdvdG8gZW5kOwor
CWllZWU4MDIxMV9yZWFkeV9vbl9jaGFubmVsKHd2aWYtPndkZXYtPmh3KTsKKwlyZXQgPSB3YWl0
X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnd2aWYtPnNjYW5fY29tcGxldGUsCisJCQkJCSAgbXNl
Y3NfdG9famlmZmllcyhkdXJhdGlvbiAqIDEyMCAvIDEwMCkpOworCWlmICghcmV0KSB7CisJCXdm
eF9oaWZfc3RvcF9zY2FuKHd2aWYpOworCQlyZXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVv
dXQoJnd2aWYtPnNjYW5fY29tcGxldGUsIDEgKiBIWik7CisJCWRldl9kYmcod3ZpZi0+d2Rldi0+
ZGV2LCAicm9jIHRpbWVvdXRcbiIpOworCX0KKwlpZiAoIXJldCkKKwkJZGV2X2Vycih3dmlmLT53
ZGV2LT5kZXYsICJyb2MgZGlkbid0IHN0b3BcbiIpOworCWllZWU4MDIxMV9yZW1haW5fb25fY2hh
bm5lbF9leHBpcmVkKHd2aWYtPndkZXYtPmh3KTsKK2VuZDoKKwl3ZnhfdHhfdW5sb2NrKHd2aWYt
PndkZXYpOworCW11dGV4X3VubG9jaygmd3ZpZi0+c2Nhbl9sb2NrKTsKKwltdXRleF91bmxvY2so
Jnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgpOworfQorCiBpbnQgd2Z4X3JlbWFpbl9vbl9jaGFubmVs
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAogCQkJ
ICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgKmNoYW4sIGludCBkdXJhdGlvbiwKIAkJCSAgZW51
bSBpZWVlODAyMTFfcm9jX3R5cGUgdHlwZSkKIHsKKwlzdHJ1Y3Qgd2Z4X2RldiAqd2RldiA9IGh3
LT5wcml2OworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gKHN0cnVjdCB3ZnhfdmlmICopdmlmLT5k
cnZfcHJpdjsKKworCWlmICh3ZnhfYXBpX29sZGVyX3RoYW4od2RldiwgMywgMTApKQorCQlyZXR1
cm4gLUVPUE5PVFNVUFA7CisKKwl3dmlmLT5yZW1haW5fb25fY2hhbm5lbF9kdXJhdGlvbiA9IGR1
cmF0aW9uOworCXd2aWYtPnJlbWFpbl9vbl9jaGFubmVsX2NoYW4gPSBjaGFuOworCXNjaGVkdWxl
X3dvcmsoJnd2aWYtPnJlbWFpbl9vbl9jaGFubmVsX3dvcmspOwogCXJldHVybiAwOwogfQogCiBp
bnQgd2Z4X2NhbmNlbF9yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywg
c3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikKIHsKKwlzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiA9IChz
dHJ1Y3Qgd2Z4X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7CisKKwl3ZnhfaGlmX3N0b3Bfc2Nhbih3dmlm
KTsKKwlmbHVzaF93b3JrKCZ3dmlmLT5yZW1haW5fb25fY2hhbm5lbF93b3JrKTsKIAlyZXR1cm4g
MDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5o
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmgKaW5kZXggMmY4MzYxNzY5
MzAzZS4uOTk1YWI4YzZjYjVlZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zY2FuLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2Fu
LmgKQEAgLTE5LDYgKzE5LDcgQEAgaW50IHdmeF9od19zY2FuKHN0cnVjdCBpZWVlODAyMTFfaHcg
Kmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAogdm9pZCB3ZnhfY2FuY2VsX2h3X3NjYW4o
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpOwogdm9p
ZCB3Znhfc2Nhbl9jb21wbGV0ZShzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgaW50IG5iX2NoYW5fZG9u
ZSk7CiAKK3ZvaWQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0
ICp3b3JrKTsKIGludCB3ZnhfcmVtYWluX29uX2NoYW5uZWwoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiAJCQkgIHN0cnVjdCBpZWVlODAyMTFfY2hh
bm5lbCAqY2hhbiwgaW50IGR1cmF0aW9uLAogCQkJICBlbnVtIGllZWU4MDIxMV9yb2NfdHlwZSB0
eXBlKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmluZGV4IGM1OGRiMmJjZWE4
N2IuLmY0MjM0MWMyYmFmZmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpA
QCAtNzMzLDYgKzczMyw3IEBAIGludCB3ZnhfYWRkX2ludGVyZmFjZShzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikKIAltdXRleF9pbml0KCZ3dmlmLT5z
Y2FuX2xvY2spOwogCWluaXRfY29tcGxldGlvbigmd3ZpZi0+c2Nhbl9jb21wbGV0ZSk7CiAJSU5J
VF9XT1JLKCZ3dmlmLT5zY2FuX3dvcmssIHdmeF9od19zY2FuX3dvcmspOworCUlOSVRfV09SSygm
d3ZpZi0+cmVtYWluX29uX2NoYW5uZWxfd29yaywgd2Z4X3JlbWFpbl9vbl9jaGFubmVsX3dvcmsp
OwogCiAJd2Z4X3R4X3F1ZXVlc19pbml0KHd2aWYpOwogCXdmeF90eF9wb2xpY3lfaW5pdCh3dmlm
KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvd2Z4LmggYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5oCmluZGV4IDEzYmE4NGIzYjJjMzMu
LjVmZDgwYzQyM2Q2ZjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93
Zngvd2Z4LmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaApAQCAt
NjksNiArNjksNyBAQCBzdHJ1Y3Qgd2Z4X3ZpZiB7CiAKIAlib29sICAgICAgICAgICAgICAgICAg
ICAgICBhZnRlcl9kdGltX3R4X2FsbG93ZWQ7CiAJYm9vbCAgICAgICAgICAgICAgICAgICAgICAg
am9pbl9pbl9wcm9ncmVzczsKKwlzdHJ1Y3QgY29tcGxldGlvbiAgICAgICAgICBzZXRfcG1fbW9k
ZV9jb21wbGV0ZTsKIAogCXN0cnVjdCBkZWxheWVkX3dvcmsgICAgICAgIGJlYWNvbl9sb3NzX3dv
cms7CiAKQEAgLTg4LDcgKzg5LDkgQEAgc3RydWN0IHdmeF92aWYgewogCWJvb2wgICAgICAgICAg
ICAgICAgICAgICAgIHNjYW5fYWJvcnQ7CiAJc3RydWN0IGllZWU4MDIxMV9zY2FuX3JlcXVlc3Qg
KnNjYW5fcmVxOwogCi0Jc3RydWN0IGNvbXBsZXRpb24gICAgICAgICAgc2V0X3BtX21vZGVfY29t
cGxldGU7CisJc3RydWN0IGllZWU4MDIxMV9jaGFubmVsICAgKnJlbWFpbl9vbl9jaGFubmVsX2No
YW47CisJaW50ICAgICAgICAgICAgICAgICAgICAgICAgcmVtYWluX29uX2NoYW5uZWxfZHVyYXRp
b247CisJc3RydWN0IHdvcmtfc3RydWN0ICAgICAgICAgcmVtYWluX29uX2NoYW5uZWxfd29yazsK
IH07CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGllZWU4MDIxMV92aWYgKnd2aWZfdG9fdmlmKHN0
cnVjdCB3ZnhfdmlmICp3dmlmKQotLSAKMi4zOS4yCgo=
