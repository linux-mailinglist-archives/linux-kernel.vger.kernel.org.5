Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE07B0A67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjI0Qdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjI0Qd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD459C;
        Wed, 27 Sep 2023 09:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX6B+q7wBOAf+fpj6LfIlkq8LhGcB6jUCbC2jBkrX64y2rQWQkO2SRMTPXwLPFRajTiPLrPoj1tfKJ3+HzPQ5EkD6jrOPQUi8WV/XAXWeH/TrZkgeX7Aiy4pSOf6SWDex1zhBRsbhFVhuiTxqNjwsGVoAQho4Wn/E8/P5PjPXJT6sXdk1tBkO0j1uQXefek8nVvVXey7dRvvOtGIvO59M9NO7iF77wdR1fkrMQs4kSywPushYZBiEHyOjRRGwkWwpaU5becviAfIT/qJsDiy3u1EydPaniiZ1/iWyQtct6Pc5zXn0Mmdsh+F0IjiXKDyknRFDptRIvAsLVNLEDvDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=MmOPiZAsFxLiYLxNARVKx8lfkpYJyPYq+C1eKoWMw3T5IEqsfrS43xzWl0GQDVpJ0KY/QOl6ZJU5//i5z5t2faWllY55Oa8ItFhP2ZbJRxLauaUy2nHh7tczpBfPn7xgrL8yLOpbruJtha+88HYGzw+FH47kW86yFFttDoNrP2AjKjIJ8KLtRKHWHM6VF5guwoMWEg+5bVH2K+MJ1MnJlK57GpQ1QdgCXMwghfXy7Q5AidNcPGaVQUbazyzAEBQQciK8NnKSA4Mq6vVbZxjpTvRV2NAf8NtLkrTTu3JCTWcvq3WC441qD8KzFI1HJlVhu0tnOcbvdHHbqqtcCKkImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=a/8E8/THohuDiSzYM1SUx0C24DkaOEHc4oRrmsAh6LfaeOzIqfkvdPijWpty9DADIY1eZ77srjQq3y9Tu6asmtTGYFbM+yqmqCrvh6/pdigdShvKNZusQP9Nj2vSbkgXA2InnRKzt9T5A87mTW0qYT0I/oyGEDzbjhKziWlWMdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:22 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:22 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 3/9] wifi: wfx: move wfx_skb_*() out of the header file
Date:   Wed, 27 Sep 2023 18:32:51 +0200
Message-Id: <20230927163257.568496-4-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26190cda-6aec-4c13-3bd9-08dbbf777628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAYu9IiEHe3gYlAO6UXQyoHXS79n01TxNUXaFWkRtREJYcr9XwqPNgAekqztOb/0jMIGvza4wGELAfxKgDHD8GpiMObmMpOhlJMTh/qX9znQyVDuTOFGodX14Rh+YhFH+lGoY74j4yLA8GdlqCy9EHm9zdILxxKiw1rthXLj4is0Ms6Pf+8nAb7XwILNuSXzBEOhB55ipC8AhWZdyiSiml8hbgXyIPHtRYmHqLN38uGbsv1UhdH95qM2nSckxxqIW2qfJoKt8VbUSK5e5M0rB6XbNY5ao9rVAKJX833d2xSdDGFjFzwcb3wLtTlwWDLqvjp2OK+dbbHAo+Enp4meJHiVWBfUmMdFtxOY1dt9/HDZM2PuWkFtws/N4OpV/8dqAQIptrp7CuuaW1nHGkiiw6dm0PaZLgWVFe7wqNWeljvuhUnDAJvW7aOGNZUkFRflgq+sFHiGvCgmn9Wch3SjOiJ0/pSk7sXSewh+hxPdiJoeV0Rb9vXe9O324+T0nJknAD1u+du4iL+vJeq76RCLcQWQd5A2IWRy65Tn8IhH0MQ8gIsTl22WptaPOEGL51Zi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhCVDZ3OGNtVExUaGhMRlBTdG8wd09TZjI1czE5UHBzclFmdnBoVDdTUDJC?=
 =?utf-8?B?aWJhYndhTjBpeVRKYzlSM2lWeStxeGVNYmxKZERoZlpmQ2hLblViQXNqdHZK?=
 =?utf-8?B?alR1SHdlNU01V3g1V2gwVWRFemVLUHVrL0g1NFZtQXpvTDVtM3dkRm14REcy?=
 =?utf-8?B?VEVXUDZDa2pqZEQzcHBkZWkvKzcrS1R5alVLUDhmY1F1bnd3R0NJMjVPcDNG?=
 =?utf-8?B?eEh2a1ZkVThLZ2RFQlhEZGpWMFNtR0ZndW5KdzRhS3FiZkhWaW04TUV3c0VN?=
 =?utf-8?B?VEs0K1FHcHEwUzlxWXFEdWlLZ1NrUmMxNXRxQmo3NG5ZNFVsTFBBMjlGdDA0?=
 =?utf-8?B?aWh2WktETytVbzVXRlQxTjdHUVZ3M3FBeVdvdFR0VEZ4VURhYlNwWkI1V1Nz?=
 =?utf-8?B?c3dYelIwa0l2dXV1UUVjcXFqV3F0UHdTaWhzbnFOTVRCL01VK1ZMdDBlalUx?=
 =?utf-8?B?TWtTUEFCQ2ZGeGhYY0ZpYTdsRUxQN2o2cW1CVyswTXZlNnpHcXNuMVVEWUN1?=
 =?utf-8?B?NDBmUWFQUVBIdXhIQ1BZVTc3N3lmRTNMQnE2T2Q3UDJqaWE2K0NhNzluRndD?=
 =?utf-8?B?eUlWNlY2ZE9URXRNV1ZQYTV3clZvdVhRaWVGTGxYSDAvT3c1dHBaUTVYYURO?=
 =?utf-8?B?NWorMWxVL2JrQUxvRkhIQTVyS3pQWUxYeDVHT1dxcVNUVTdPUzB0a3VHOXdR?=
 =?utf-8?B?MWtXTEFqSHFhZXZORCtWMG5LTzc3bjBSakZkUnduMEZ4R0xMNXlVVDNpRVdQ?=
 =?utf-8?B?SUVOcUk1c2xQWFExOXluQ0pFemRiUThXZFpkdTBlaHJ3YzNtVEpteTZKcFVX?=
 =?utf-8?B?ckNVM2xmcmR0ZFhvTUJ1d3FEU0VwV25ibzArbU9GVGFpeXlkaG1xeWhBeitV?=
 =?utf-8?B?UVQwSVJvZm9YeGNhWVc0Z0g1MkpqWGt5RTJZN1BnUkZsWmYweFRxYUlVZ1ZV?=
 =?utf-8?B?VWFFV0lSbUF0V3lpL2wvUDhiQVljaEp1bVgrdWp6ZE9BN3NtMHczMUFSTm0z?=
 =?utf-8?B?WG9YZTR2L1lZQWViRmtGVVNtTlpzU003dEN1VlZSR05jVVd4OWFpVnFnaFRH?=
 =?utf-8?B?Q1M4TTRYcDdEbzE5UllhVHRNSTZOTHlnQUNqWWZZNG11MGhhK0VjVERoUlpH?=
 =?utf-8?B?eWNZY0JRcUlWcVd4cGZNTlA5RWZNWGVIWm15Z2FHWDBZSklybkZHUlhZQmxC?=
 =?utf-8?B?MWdJSFNZM2lrdTFsSmVRMURlZGlYTmVKTHF3b2pHT3RSQStmdDVWUndvK0xu?=
 =?utf-8?B?RW12VHFUcER6R1ZVaHA3VVdPbHhkM0NkZzcrcXMrN0p0RW9ZVFA3Q0V4YklE?=
 =?utf-8?B?OWdPbXczWHhWNkMyT0dBbVhmNXliNXlkQUwvUWwzUmZJMG9RaWN5MTZsZ0ds?=
 =?utf-8?B?MlJwLzhUTFR0SWlmcVIxVzBHdjFtc1p1ZldaYlM3UmpZeVFncENxazRZNWJB?=
 =?utf-8?B?Y0tqS1FwRzJmRmhsblZwcWt5ay9PSjE5SXgrNkhEWEQ2UjJBN1VhY09tUmhC?=
 =?utf-8?B?YVhkN2xqYjEyWlh1aGpxZjZpTGJwUi9waGVkM0lzcnkvcUtxVlQwcTBua0Z4?=
 =?utf-8?B?OTFYc3RVeGdtWkJFT1NWeng5U0hUQTFCTDZTcnNpTXAyVXp3NTc5MVkxQWVP?=
 =?utf-8?B?bUtMQnJDVEE5UnNGL01HNFk2VXl0a3ZQc25tdWlsdm5iUVlOTThaSmJMdmw3?=
 =?utf-8?B?TGVRR2owY2hRSlRHb2ZxMXhOemJxQzN0UitqTk1kWXRmczRrUlA4eTUwWGVp?=
 =?utf-8?B?amxVMHFFSzdOREQ0aWVrM3lGRFlnNXVXc1E0QW1QTjlpbUUwVm8ySTcvc3FK?=
 =?utf-8?B?NkF3QmFxUW9ZRDdDb2hXK3hPKzNlcE95Um51VTZHTll2N0lSV0pPN2pFYkhZ?=
 =?utf-8?B?RmU1K2NVMDJOTUljKy9oK1c1cGxRdlRTVGxvQXArNzlYQkd6QlR6Y1M4Q01q?=
 =?utf-8?B?SGUrZlFlaFlWTlRjeUp1WHpKMlZGN0hvbVJVYURTVkhQV24rczRQYXJ0RGwx?=
 =?utf-8?B?WXNkaUdBR3JxZEVsbkdmb24vUFFVK0JhQ3k3UExlOE5oTnRyZmMvK1h2R0Np?=
 =?utf-8?B?d1pCQTZYUmJabGRxY1RWbmNzSlNQWEtQMXhqd2xXSWwyWjZ4K05oOWx2cnNG?=
 =?utf-8?B?enk2L0V3RjBkNXdzb1N4VThVQWFDcGprb2RsSmt5Rlo4eGNNVDM2SkJwcW94?=
 =?utf-8?Q?vZs2/0I4bGLmiXV1LdI+3yxmbvVA30EIUm2qDybL1cv5?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26190cda-6aec-4c13-3bd9-08dbbf777628
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:20.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e71hDkJ9nREtzBGh0Vu4D6qNDPXNrrZxT9Iwlf8Q+/IQfdrsLk45EHyqnXqdtS8icl3Aj9xrbJwDnQ0yUfWMxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
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
