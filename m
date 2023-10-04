Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C07B8693
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbjJDR3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbjJDR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA534A7;
        Wed,  4 Oct 2023 10:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laRXG6CIpEE6TaINlFtrZ7qAJxhtXgs9k1D5xmIw2S1q3U2kl36+ZzmrIkI0ZdL5Rj5dNqyMU3EGBKrE0J/UEavKIYu7fYGliXAzgYVzlzg9ivzaWosUXipfPfHZpzUDqhfgG7cxOVfZSqqFdwOdqpZZABWfK/3jwqYkcg/X/0TZO0CrNA9GZ3sRvZwqL9b+h8y1E2nJ/6MFQTfgWdkIBT0yZqmOZf5GdmTTjyZRHpJo1N2reWMdkeKawSRnBpF1PTWZQQvbAAV6lOGOk+r2bI9U5yohmItCI68/Bj8MMpA5lQp5VBqefge8k4SDMoMT/jpHVRgCFlstbPqlLyHCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=EwIaUrNrCW3n84R00YvxajMa9LvmWXVQvvcnYf1NHIh+s7yJ8ftreA+I27kR0tffjzyCsrHxg6t8WKFVOGUxeCB/TsJXxGhfPZkOD18OUcMNC5rw41VPzEiccLSQdvre64rNk/q3FxyP6OhI2LElj8uGwtbhOJr1MnbA6jYY5dHHViMjQk+Pj0M7hLrvsqDwmfml5mBMUR9xBQLMRZF8YGcACP/IfvhNG1IHREicvVwGflIyjEMCEmawbNA09+2hgrFFsiYdfiLKIt+/D8ASxg9XCRSPmjRJXpGVXcy2nWkN6wAMl92d/0LSFr/h/ttBhlzQJ7u7J5Fm9fDzpywTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=o75cJpJtJBwDmSxh2rzB5zrJRbxazcd1hTuxaC0/oBY0eyORfHHJza5eQmGMWPimFe+0RVIcIJ2cSZ3WKKqBz9GvQhvwlHNwqx9m7walsGu/FBex0qUSCyjKGTfst+fFuBUf8W1YhvILYKW9zrPFQK6EnDPZXDG9aN0cjSIXX/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:28:57 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:28:57 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 2/8] wifi: wfx: relocate wfx_rate_mask_to_hw()
Date:   Wed,  4 Oct 2023 19:28:37 +0200
Message-Id: <20231004172843.195332-3-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004172843.195332-1-jerome.pouiller@silabs.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 548c618b-fea0-4d8a-4370-08dbc4ff63f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5V5M2pEkRHL7tLoZAGRO9usdWKX1IrYoVKrdEY/wdpRKt0sUe7D/PwflCy4Udy5t47PlB1xG9zDAmuj+Gdfj/aYupG2mBG2F8ErXbpETkE3mg9YaAYhjbg5Nj5XK0m/UoaRtkn7utDY9XEd0+GmPQZz1Lhpeaic2m+/qgmCu8fxckCGevBGhinP0RR2J4C05ypnEkd3YpoO59YwyGaiQuTWrZPahiA33BnpH+SIrOF1pLTdWNWU2k4BmBPg4tr1i9kvNRTv+qJ+BsL0zGjtOfVXPWX9/qIdplJftU6wfdE+GsRtYZVhc/Ecbm+kjhRUxNDAxC+mbk1Bft18kDY1xfa+nL6tCF8LuSoBPtvum/UC+8m12zjbRAsPL7vPC3o3WkR8vK1lT1pNEBlQ42KwFLwSvgYd3z1vT/xfLJJbemPwr1aWUsrX9uU2+Qr3nHrDwObAg+U2Qm9dqvOl+WihAmBQEt3cOxT1vtVtRlA5FidZdk8MsB6LaLrSuzImJ/f7lPteo6dcLMMxVuEl6VGJHGGDA/4vAoTLxRPrs31gM9X8IyAvQpxU7j8lHNgAlSl/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5TNkVBczBlME9uZUVDQVdvLzdJZ2gzU2E2elBnTzRCRmFySFdHZGt0Ni91?=
 =?utf-8?B?c2QwbkRjZGF5MVpIdllLa0JCMlI5OTZLR1VLd3pCWlRGazRzRlc5SVFaQ3l1?=
 =?utf-8?B?RncxWmNzSENjdUJuQ0JsMjZCK3EzQndJRER0RkNqSzhJN3FzMFBjbis0Tk8w?=
 =?utf-8?B?cS9yT2pVb2xTNmtmYnVYWkF6R28zVDR4OXczcENWTGloY1B6TTdPQmQzdVlY?=
 =?utf-8?B?TWR5TkpjRWVvSFRFb1NvVGN4Z1l4SnRtdVY0TEZHZ1p3YnkwQkd1OW4vRSti?=
 =?utf-8?B?QzZQRHVPOGEvNGVjaUdrMWlIVDROVzhJcnBFa1o4Nlp4VmFjd05mYUZYeit3?=
 =?utf-8?B?L3RSWGEwbWN3S1VFbDVwNU0zWk1SWmZqSGF6cmIvM0g2RW5aUDJ3MW42WXdr?=
 =?utf-8?B?NXBTTEFvdFBtNUFKQ3dxU2ZDblRXMXZqOHdtcHRyZkVOM2VNWFRqeDZPY3p3?=
 =?utf-8?B?cVdhUzUvV3dXUlNPb2xDbnpXeTEzVHZZQ2lkUm82UHk2ZkZmRExKdTJ5czRv?=
 =?utf-8?B?ZG1lRzQ1MERreEgxdERlVVRrdXlMMDAwdmN5ME1TU0dsZDNvdEFDQ2N5TDV0?=
 =?utf-8?B?ZXYvSmlxY1YzWTlxSzRobVZFcjFETEdJb3prajIxL3pPZ09EekpBSXFIMkVP?=
 =?utf-8?B?NlhvVDFUMFY1K0Vsem9WK0dXejdlaE92S1J0M2l3Ty9kY3kxWXdVdUtCa2dG?=
 =?utf-8?B?Tml0MXk4Qy8yYVJCc2JpdkRFYlZJejJaQVJvNUlIRzd3dnBpbTZBSHhJeTlT?=
 =?utf-8?B?MFNvMktVd3ZYelBTQ01TYWoxeWprLzQ3eXpHVHRTbVl3Yk16b0FTMkM4aVJk?=
 =?utf-8?B?SGRuQ1FHRkpVbEF5TnlSdkNHOUp3SVg5cmdIRk1BRHVwUWU4Y1d4MEZzUUhr?=
 =?utf-8?B?cXZTNGxyaVpoR2NaUHFadHg5UWQ5Qkx3Q2w1WnFzbkJXd2pwMUNyTjhMTjZo?=
 =?utf-8?B?d1laajhRbGtpREpSRWY3TWt5M0UwQS9IeENjVFpZdWFzSDBTd1dOVFY5cFoy?=
 =?utf-8?B?OFVqVEZNU1lJY3AyaGVNT1BlNi9ld2s3TVAzQVdqeDV0REFpSzRDSlVIZHc1?=
 =?utf-8?B?UVh5SXRqUWszQURWK3ZMdXd0M210MUxOMkFCWDZrZU52MkZiVy9pMXprYmtF?=
 =?utf-8?B?bDc2Y2ZoT3c5R250SzluVkZqZXFoeVJwNlhDRFVXYWg1UGZCSEJVSlpjV1Jq?=
 =?utf-8?B?eEt0bjVta096MDJYTlBTNDRtYkxtSFNBR2ZNb3BnQkVlNzJhUFhPSE9xTllY?=
 =?utf-8?B?YklTdm9oRFFCSVgzaStIaEczcmJyVGE5QUhORGpaOUdKWE80bmpjN0NNenBX?=
 =?utf-8?B?U1F2bWc5K1V6OUtaL0c0T2dodlI4M0hSWlRkUHYyYjdSRkg3bHY2dnlZRi9j?=
 =?utf-8?B?UGs4bm1QL1NYbTF0ejk4cXErdzRrOW84TzRaQ0tlK1hsbUR1V29uZUlaWkNH?=
 =?utf-8?B?OUplWWxVSmdxUGV5MFo2cXh5cUxzQlNmTXplTytKa1dHMkVYaG00QnkvTjNs?=
 =?utf-8?B?TVk4N1VpR0djV3Q5NWdVa1doY1ozaitxeEl4bkJoaDQ4MnY0YkRmTkg2dkk0?=
 =?utf-8?B?Umw3L2hIWEJFT0tNU0tibzRqUmpEOUVJQWN5REREODNuTEFaK2Z3K1QrZ0J2?=
 =?utf-8?B?djRINkdPQ2xYQ1Fra3dVb1c3UEliazE3d0NRY25FZTM1K2NSWWZ1Z2lBY2Zm?=
 =?utf-8?B?eVk5RVJWbG0ydFlCOHl1VnB2R2VxbWRJMU5nK2w3dC8rL2tHQTFaRHpmL3RF?=
 =?utf-8?B?UGE4NWNGcmZ0cUl0WGJnQzh6Tm0xY2M3R0ZmTjBXTzRhM2E3Q0VuMVlSTTJO?=
 =?utf-8?B?cStWeDlYNEgveGFqaHVLaUIwVHAwemNPTFZhUDZIU0J2YjN5QU9ObE5lZyta?=
 =?utf-8?B?RnN1VHdieXBqNzdySXd5RnRWTUYwTFdaRnRCY3ZOdmtxR05heEl2Sk14aThH?=
 =?utf-8?B?RVpuYWtmb2NheTc1anpMT2dEbS9zbzVQNFU2MmlaUWJNRXFES3VpWDZWZERS?=
 =?utf-8?B?dS9wUC9lTW5PK1ZMRTlJWCtRM05Ga3hyNTJOdm4wTGlpZHBUYU5Yc3JLMHhR?=
 =?utf-8?B?N1VvVk9QV3R5TUcrQlB5K0ZhTTQ3YmJMMkNMb1MxK3prN2hZbTN3TTFxeFV2?=
 =?utf-8?B?NGljcGtPVlFmV2RQQmtsRVlVcnJLZ0FOWUV5bkgrS0FGL0xIWUozVVJIVks3?=
 =?utf-8?Q?uleSc8JWFUysvGAlw21OmY1E7kvQW0u5gAa+1yNTJwqq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c618b-fea0-4d8a-4370-08dbc4ff63f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:28:57.7424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQnnQKM3fmwn5kY4P+c5GcbRVYh5D9RpG30S1/Hnwe8rZ3zFlm7C4R9jmEbdf2J4PwpfmF5szXaJgSCX3gbWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d2Z4X3JhdGVfbWFza190b19odygpIGlzIG9ubHkgdXNlZCBpbiBoaWZfdHguYy4gU28gcmVsb2Nh
dGUgaXQgaW50bwpoaWZfdHguYyBhbmQgbWFyayBpdCBzdGF0aWMuCgpTaWduZWQtb2ZmLWJ5OiBK
w6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyB8IDE4ICsrKysrKysrKysrKysrKysr
KwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyAgICB8IDE4IC0tLS0tLS0t
LS0tLS0tLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuaCAgICB8ICAx
IC0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmMKaW5kZXggOTQwMjUwM2ZiZGUz
Yy4uZGU1YTMxNDgyZGYzOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9oaWZfdHguYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5jCkBAIC00NSw2ICs0NSwyNCBAQCBzdGF0aWMgdm9pZCAqd2Z4X2FsbG9jX2hpZihzaXplX3Qg
Ym9keV9sZW4sIHN0cnVjdCB3ZnhfaGlmX21zZyAqKmhpZikKIAkJcmV0dXJuIE5VTEw7CiB9CiAK
K3N0YXRpYyB1MzIgd2Z4X3JhdGVfbWFza190b19odyhzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMy
IHJhdGVzKQoreworCWludCBpOworCXUzMiByZXQgPSAwOworCS8qIFRoZSBkZXZpY2Ugb25seSBz
dXBwb3J0cyAyR0h6ICovCisJc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqc2JhbmQg
PSB3ZGV2LT5ody0+d2lwaHktPmJhbmRzW05MODAyMTFfQkFORF8yR0haXTsKKworCWZvciAoaSA9
IDA7IGkgPCBzYmFuZC0+bl9iaXRyYXRlczsgaSsrKSB7CisJCWlmIChyYXRlcyAmIEJJVChpKSkg
eworCQkJaWYgKGkgPj0gc2JhbmQtPm5fYml0cmF0ZXMpCisJCQkJZGV2X3dhcm4od2Rldi0+ZGV2
LCAidW5zdXBwb3J0ZWQgYmFzaWMgcmF0ZVxuIik7CisJCQllbHNlCisJCQkJcmV0IHw9IEJJVChz
YmFuZC0+Yml0cmF0ZXNbaV0uaHdfdmFsdWUpOworCQl9CisJfQorCXJldHVybiByZXQ7Cit9CisK
IGludCB3ZnhfY21kX3NlbmQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCB3ZnhfaGlmX21z
ZyAqcmVxdWVzdCwKIAkJIHZvaWQgKnJlcGx5LCBzaXplX3QgcmVwbHlfbGVuLCBib29sIG5vX3Jl
cGx5KQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggOWMwYTExYzI3
N2U5Ny4uYzU4ZGIyYmNlYTg3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zdGEuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5j
CkBAIC0yMCwyNCArMjAsNiBAQAogCiAjZGVmaW5lIEhJRl9NQVhfQVJQX0lQX0FERFJUQUJMRV9F
TlRSSUVTIDIKIAotdTMyIHdmeF9yYXRlX21hc2tfdG9faHcoc3RydWN0IHdmeF9kZXYgKndkZXYs
IHUzMiByYXRlcykKLXsKLQlpbnQgaTsKLQl1MzIgcmV0ID0gMDsKLQkvKiBUaGUgZGV2aWNlIG9u
bHkgc3VwcG9ydHMgMkdIeiAqLwotCXN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKnNi
YW5kID0gd2Rldi0+aHctPndpcGh5LT5iYW5kc1tOTDgwMjExX0JBTkRfMkdIWl07Ci0KLQlmb3Ig
KGkgPSAwOyBpIDwgc2JhbmQtPm5fYml0cmF0ZXM7IGkrKykgewotCQlpZiAocmF0ZXMgJiBCSVQo
aSkpIHsKLQkJCWlmIChpID49IHNiYW5kLT5uX2JpdHJhdGVzKQotCQkJCWRldl93YXJuKHdkZXYt
PmRldiwgInVuc3VwcG9ydGVkIGJhc2ljIHJhdGVcbiIpOwotCQkJZWxzZQotCQkJCXJldCB8PSBC
SVQoc2JhbmQtPmJpdHJhdGVzW2ldLmh3X3ZhbHVlKTsKLQkJfQotCX0KLQlyZXR1cm4gcmV0Owot
fQotCiB2b2lkIHdmeF9jb29saW5nX3RpbWVvdXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCiB7CiAJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBjb250YWluZXJfb2YodG9fZGVsYXllZF93
b3JrKHdvcmspLCBzdHJ1Y3Qgd2Z4X2RldiwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0
YS5oCmluZGV4IDg4OGRiNWNkMzIwNmIuLmM0NzhkZGNiOTM0YmQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3Mvc2lsYWJzL3dmeC9zdGEuaApAQCAtNjYsNiArNjYsNSBAQCBpbnQgd2Z4X3VwZGF0ZV9wbShz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZik7CiAKIC8qIE90aGVyIEhlbHBlcnMgKi8KIHZvaWQgd2Z4X3Jl
c2V0KHN0cnVjdCB3ZnhfdmlmICp3dmlmKTsKLXUzMiB3ZnhfcmF0ZV9tYXNrX3RvX2h3KHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCB1MzIgcmF0ZXMpOwogCiAjZW5kaWYKLS0gCjIuMzkuMgoK
