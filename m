Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44EB77289C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjHGPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHGPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663ED10DE;
        Mon,  7 Aug 2023 08:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi30Wghu3SgpJ5f2U8EgcK8bQ5GibSLNDGc1lY2tpahlXKLbyTcsx6Ib3qyWj6vmumDoxnbJckFj2bKhQAkxBtCB3v0whqRBFmyxoCpH0SB8W94hkJY3BxZDmCV6wDPYteEWddmaDkKY4pqOxvbfJi0DzEvfMOb6MZVuTFS3Gu+NG8SLImGrhpRH5eWJ8WSCPd9Lxy61RornRFwT+rB9+aOdELLREEmaUE2MeRxZctbEQ54bVUXVngMY4SlnBzuNS2OqlKi8yiKw/lPItgcuTHEYHNF36Idbn1HddmXOWvplcHxF9XEyhTWeHZ6Eva7Q9ScfPzebFbLqH/E7UtwhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=g7nuk51Cj3N/Y7vq2DaY4SdSG/23CcxI5iAitVUOJaBFw5MuQTFryqNV2YLPQ2d22DP5C3nWV1BrBGoxsD9XTY8Z2s7Kdq+/gVPHiG5JzaI8ykUEw0I4p3NMULldHIr0Uff99zTNRhHPgtw5Ry6+FrDw2+WGCuqnRo/+kd9WGYembyCWPmZAYJRHpHI9KrxCANh0nyxvqBku4fUjYLJM6WKiD+e/RtSZIfe74eB2BCtiB1mbN5gX3zjUiGy3YmEL52QKExKsYVAoQ8lKShmc65JIQa7tr0MVfCzRvfLB3MXapg82C3hghXx2dLKwM/wMoFEVEQ0NLM0Bmh0bCOJYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=VrwpgkTYg3dKtdW70CC8HmLnsYuTIgdCol9t3bl3MJ2fzkDFtwpd6I6BbljSjGPiDSiVGaZUQ4NfASKtkll17/ftvBgR+zJ9GZv73ugTqswBSIPAqr8uVFlXD0Vn9JW/kAX2vIkPhsqBdlE4neUJa5CdndFqkbO8Q+2cLn8WtMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:06 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:06 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 3/9] wifi: wfx: move wfx_skb_*() out of the header file
Date:   Mon,  7 Aug 2023 17:05:36 +0200
Message-Id: <20230807150542.247801-4-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74570109-ed36-44bc-3170-08db9757d2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JG/+SZcRRnPXCR9bkPacmUfVJcLYxe3RJqcjuFWBaoCmNflH0avMsA8UJb7+D6uXds5O2m5yyzFRbgBajz/4hrhjg3O3+SYILDi4hiiTrQWXkZl5LwFYvd0Z9M8KMDIDv6tjkkMdFbmi8JgmW8IBacN0V2hVLVDqR2tiCCzkitubHGN+tpv96H+baHcavc9nofKWfJ6MvjuCghEUNbAQ3vNspFRv7ww5euKFtAeq2n4t8W3Vf+lkwr7BiTFX0eFziNV1ILDsLokwx1Q8XhfroFjaHa8I85C3pPo85wK/3LZzD+zU3WYGebiKyNG7JLvadYRVKiW2T2guoFo8C8zT2F16FiuQtR7fh4R9vF2qfJz4dPC21AHR8tKGh2pk/NImBlO487TaiwILAnhAeZ9Kxa/+AO5cJnBBmMTBJFBsFs6KAZIirDgT/hqYAsaBGwQ4T+Sgu5cbQnMLCAiulO0dKIpHf8ZCGNEoCk/TpI891H4nhV6/It9wDExrkbrYcD1d6AE8fiXAR1bgXfz7GXNY6H3ASEF/XbZmPsFlre2HIEAFB331xDnTfX5mRmPrCzKNgY0s+qGbZ/l3zue2+CH26CBEePUIbASXs33boJIu/vOxhdTOMmSXg/dfhbCAQPW7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JOVG9yQU5XM3BMcUhiT2NYOEREWFgydG43bGY0Rk1IcUc0ZnVzQXBhTWVj?=
 =?utf-8?B?dzlMaXpkcDJOUFV2cFl4NXdXbDZFMlRSd2pHekRmSjNIV2VTNmZoSGhvTjZY?=
 =?utf-8?B?b3pYNjdEWXZaWDBKNGxUcHZpNUloVnIralZ5WlJXYUVZVzR4N2JWSWtVMzlj?=
 =?utf-8?B?anZGKy82QkFxMDJVYTRVbFpKZUlEdEN6UXBTYTVWd2lBQTQwMmYrMng1czY1?=
 =?utf-8?B?RHZwQm0wTWNKMk4zUFlCY0RucXpSNVZoQm43QVpBS0tlbG8xcDlSanZxbTk5?=
 =?utf-8?B?ZmM0d1M3Zkp4Z1RVQ0IwcjZHMGpjVXB1b2JwUkhVa1FITFBXWHNFZ2Uwci9E?=
 =?utf-8?B?V2JZSzV2YjJ4Zm80dVhseldyalBPNzZ4emRzelJta2ZxQjl6UFRLRG5PdmZZ?=
 =?utf-8?B?eEM2RFI4OXFYYThRcWNObjM5cFZ1SWwrazR5eEVucCtZbjNyWng2elVZMk9Y?=
 =?utf-8?B?M3dFSXlpY2tOUW1PME9ibWpxZkZqN0NpZEU3WHNJL0xmYXBUWlBaa0pYR3kx?=
 =?utf-8?B?b3cvbkhIaGpseEdZMDUzYlFCOHVpd3dITG1UMEg3TGVWMVJpd1IwRE1GSk5n?=
 =?utf-8?B?RkkrSlI3UitnQWFWK2xkQ0lzMjFoemFTbXlNdC9UZS94TW9uZVl0THdTQ3Bl?=
 =?utf-8?B?d2gxMjVSTFBDZlU5K2VZUzJiSjE4dUtZRGE3QlU0eVBEN0pyY1VIKzZIczVp?=
 =?utf-8?B?K3lGczlxSWp4NUtUeHlibFNLTDkvWjhvN25udXlNKzZzRXdiNkJHKzhoL2hh?=
 =?utf-8?B?cFFqV1NKa091Q0JUSmFBVmtnd001WjlwNjNycERxdkpXa3RBZDIwN1RjRTZM?=
 =?utf-8?B?b21GSEp0azVVMGE1MWlONE1hOXNmSVcwOXIxcG9UZ0pEZzBqZUI4NThOWTNl?=
 =?utf-8?B?Vit2TUJGZ2dmK2VhZVlubm1sZFc0Mmlqb0FmT3NHR0xXUmp1NkhNQ0hQZ003?=
 =?utf-8?B?Mk50VkhreFJIeVhtUk9mWDllV3FreHBEOER0MG56RjNQZ1ZYN3REeGMwS2dz?=
 =?utf-8?B?ZHRCcEpmL1dDWUh1Qk1ldi91MzgyTWpXTUVRV0xIVjRCc3Q3WkgrZVRYVWgw?=
 =?utf-8?B?RkNSc0Jvby9nQ2hFUWRpeVRtYzRtU1Q2UHZpUWhwNThQK0NDVzc4ZUVwdk1N?=
 =?utf-8?B?NDVGakhnamYvVVd5UDlYRWNyblJqZDB5ZStkU2FrZ0xCemYwYnBaK0VpT21Q?=
 =?utf-8?B?TElrSytCdlRHTmEwNmxwQXVFVm9VemNmMGFjNlZucG5BYW9sSGI2WkpOa2ZR?=
 =?utf-8?B?YUljTDRrRHR6Ym8wNTM0dStwV0w2ZXI4M2hTOGFMRWdaeFBzSFVKUHhHd3Zh?=
 =?utf-8?B?aWlscnBUVVh1NDJmUzc0amxycklHYTJXMTY1NHZPc1gyMFV2VHVDdHo5NWtw?=
 =?utf-8?B?VS94Z3NINUNsWXp5aWRWb25CUkk4VXJSeWp3anRSdjYyWEEyOGdSUG9GV3J2?=
 =?utf-8?B?R1J0UXl0S2Foc0VSNStMU1k3VnRrV01YYldqOFFRWFdWZDdGeDBpWU1VcGdT?=
 =?utf-8?B?cTlGRUJYdFkrNmJJdXVzbkFGWUtEMFY5U0ZkeEJ2SGJFSkJyNEtwbThMd2hF?=
 =?utf-8?B?aTNoOFZOejljTGpBVlk5ZGJvZm5tWFRWOG9ua08wU3U0ZG03Q1NObVZlWmR2?=
 =?utf-8?B?L2FxVDIzRzNuN3VxY0tBQTUvbWt1eUdDcSt6Q3EraDhtQTBnTSttcnlBVnpu?=
 =?utf-8?B?OUkvVzE1bCtZMDJJYTVQVWxRZGhQRE9hYWNvdnRjRW5FdkNIUVZTTE9EZXox?=
 =?utf-8?B?QUZ1R1ZNcVZib1Q4bk5FS3llY1JJa01jaDEwOEczdWpzK2tnZVBNbU9uN25I?=
 =?utf-8?B?bHRGa2RVM2VZdkY1V3VDbXRvcmh6LzR2NjZyckVqdEx6c0lsQW1ESnlkdVN2?=
 =?utf-8?B?c1FaNjNZN1orOWtudmNFcEhZUU9OaHRxdVh3NVFSSWNSc05XTWtQYVVyYU1z?=
 =?utf-8?B?eTJGYVY0OFJ4U1BSNzlwT0x2cTVxV0RtRjhzYitDM1dYUStSYW13Snk0a2NK?=
 =?utf-8?B?SFNEbENlRHRtZklSdFhXY080U1VZcUx0Tlo0MjkyQjZIS0ZQUmtXOXdyVzg1?=
 =?utf-8?B?d0svZ0h5Y09FL29mQ0U1Rm9oUVo3V09LVzAvRnVGb3BUdEJHU3NROUdCNXVS?=
 =?utf-8?Q?jK9z5X6OTKHm7WQR0QnwW8rws?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74570109-ed36-44bc-3170-08db9757d2f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:06.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnUZmCQtDln8h5qbZsvP6XchfRgJbgT4eu1qb+PGpLo/6QQUN+rKD7z/SkJsf5GJGHjj7Bo1jviBBglP4+MvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgbm8gcmVhbCByZWFzb25zIHRvIGtlZXAgdGhlc2UgZnVuY3Rpb24gaW4gdGhlIGhl
YWRlciBmaWxlLgoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3Vp
bGxlckBzaWxhYnMuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0
YV90eC5jIHwgMTggKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L2RhdGFfdHguaCB8IDE5ICsrLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L2RhdGFfdHguYwppbmRleCA2YTVlNTJhOTZkMTgzLi5jZTJiNWRjZmQ4ZDg5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguYwor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguYwpAQCAtMjA4LDYg
KzIwOCwyNCBAQCBzdGF0aWMgYm9vbCB3ZnhfaXNfYWN0aW9uX2JhY2soc3RydWN0IGllZWU4MDIx
MV9oZHIgKmhkcikKIAlyZXR1cm4gdHJ1ZTsKIH0KIAorc3RydWN0IHdmeF90eF9wcml2ICp3Znhf
c2tiX3R4X3ByaXYoc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4
X2luZm8gKnR4X2luZm87CisKKwlpZiAoIXNrYikKKwkJcmV0dXJuIE5VTEw7CisJdHhfaW5mbyA9
IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsKKwlyZXR1cm4gKHN0cnVjdCB3ZnhfdHhfcHJpdiAqKXR4
X2luZm8tPnJhdGVfZHJpdmVyX2RhdGE7Cit9CisKK3N0cnVjdCB3ZnhfaGlmX3JlcV90eCAqd2Z4
X3NrYl90eHJlcShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCXN0cnVjdCB3ZnhfaGlmX21zZyAq
aGlmID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwlzdHJ1Y3Qgd2Z4X2hpZl9y
ZXFfdHggKnJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWYtPmJvZHk7CisKKwlyZXR1
cm4gcmVxOworfQorCiBzdGF0aWMgdTggd2Z4X3R4X2dldF9saW5rX2lkKHN0cnVjdCB3Znhfdmlm
ICp3dmlmLCBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhLAogCQkJICAgICBzdHJ1Y3QgaWVlZTgw
MjExX2hkciAqaGRyKQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9kYXRhX3R4LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHgu
aAppbmRleCA5ODM0NzA3MDVlNGJiLi5hNWI4MGVhY2NlMzlhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaAorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaApAQCAtNDUsMjIgKzQ1LDcgQEAgdm9pZCB3ZnhfdHgo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdHhfY29udHJvbCAqY29u
dHJvbCwgc3RydWMKIHZvaWQgd2Z4X3R4X2NvbmZpcm1fY2Ioc3RydWN0IHdmeF9kZXYgKndkZXYs
IGNvbnN0IHN0cnVjdCB3ZnhfaGlmX2NuZl90eCAqYXJnKTsKIHZvaWQgd2Z4X2ZsdXNoKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCB1MzIgcXVldWVz
LCBib29sIGRyb3ApOwogCi1zdGF0aWMgaW5saW5lIHN0cnVjdCB3ZnhfdHhfcHJpdiAqd2Z4X3Nr
Yl90eF9wcml2KHN0cnVjdCBza19idWZmICpza2IpCi17Ci0Jc3RydWN0IGllZWU4MDIxMV90eF9p
bmZvICp0eF9pbmZvOwotCi0JaWYgKCFza2IpCi0JCXJldHVybiBOVUxMOwotCXR4X2luZm8gPSBJ
RUVFODAyMTFfU0tCX0NCKHNrYik7Ci0JcmV0dXJuIChzdHJ1Y3Qgd2Z4X3R4X3ByaXYgKil0eF9p
bmZvLT5yYXRlX2RyaXZlcl9kYXRhOwotfQotCi1zdGF0aWMgaW5saW5lIHN0cnVjdCB3ZnhfaGlm
X3JlcV90eCAqd2Z4X3NrYl90eHJlcShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQotewotCXN0cnVjdCB3
ZnhfaGlmX21zZyAqaGlmID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKLQlzdHJ1
Y3Qgd2Z4X2hpZl9yZXFfdHggKnJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWYtPmJv
ZHk7Ci0KLQlyZXR1cm4gcmVxOwotfQorc3RydWN0IHdmeF90eF9wcml2ICp3Znhfc2tiX3R4X3By
aXYoc3RydWN0IHNrX2J1ZmYgKnNrYik7CitzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKndmeF9za2Jf
dHhyZXEoc3RydWN0IHNrX2J1ZmYgKnNrYik7CiAKICNlbmRpZgotLSAKMi4zOS4yCgo=
