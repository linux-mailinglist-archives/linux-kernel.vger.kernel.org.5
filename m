Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E5B7A7596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjITIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:16:35 -0400
X-Greylist: delayed 3505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 01:16:28 PDT
Received: from cluster-e.mailcontrol.com (cluster-e.mailcontrol.com [85.115.58.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358AF9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:16:28 -0700 (PDT)
Received: (from mailcontrol@localhost)
        by rly71e.srv.mailcontrol.com (MailControl) with ESMTP id 38K7Hdk5001336;
        Wed, 20 Sep 2023 08:17:39 +0100
Received: from rly71e.srv.mailcontrol.com (localhost [127.0.0.1])
        by localhost (envelope-sender ttayar@habana.ai) (MIMEDefang) with ESMTP id 38K7Hc45001142
        (TLS bits=256 verify=OK); Wed, 20 Sep 2023 08:17:39 +0100 (BST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by rly71e.srv.mailcontrol.com (MailControl) id 38K7HI0A046645;
        Wed, 20 Sep 2023 08:17:18 +0100
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
        by rly71e-eth0.srv.mailcontrol.com (envelope-sender ttayar@habana.ai) (MIMEDefang) with ESMTP id 38K7HHcR046572
        (TLS bits=256 verify=OK); Wed, 20 Sep 2023 08:17:18 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iutA4mcGJ91gdmb564ZeMAadHnXjs3P4O7gl+cjpLe5GjoQyvOlTlxpvFiVUjXPChOT1Xl+IdC7yfDbkCQAXjtw+s0gwwJCrRVOwbRn9esK20jp4A+T+rydUn4xYpRRFvpOfZV1JFIkmsAA8pWdk2pEVWzxNM94CxhMdtmiUpJngePtlSJMD96g1m6sMlDo6S375yNHMuLfbJULpkn/C3fNUmXYEIpAvrRsV6eUjtnAa9T41EsltnInG2qa2thtiQvUgDfd0HKMfwgHmXUZRIPvKxKSJtndo3UiuQRfd2reKI6i1IIN8PGQTeuEyq2xIBcfnFEFP/J7JVjurjD0PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uffGUJv8X1yglI3deTex7bmooPK821XJ/Mb2mRLOrKE=;
 b=AFEdHS7gqde35NuD5wvBIyBYx1/VJJgZizuhDba3ojWwRJDw8p9Ul01dW0feYgaX6dUv2kPKCdG/G6sM8bwaH1F1+m9NDwuJfJqyG32dv5pi60enaiBoiLkCoMOS8OKzYij4ON53TmgBiuXx1ADgV0CrGM8W6lwtwgGNebQxWJ4jLRiFi/ipdyKw0IkOGIHc9ZAp88PKn7tKZ437Wf+Ax5+2TQP+Qg/oakI/i2P/RQugBwRdFBMeIq6HKUEhzzMnUgSzHRVgANS9i4M44GC5hbf+Lz8bN3xn9CGYG7YlRGwhm6Mg+GS6YPSv5RvmhTT3FlvwUPIy2jyMpIvhcOavhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uffGUJv8X1yglI3deTex7bmooPK821XJ/Mb2mRLOrKE=;
 b=iAl4Dp6zre+y6iFKMuOs3kkCfb+BBf9WR7JOXL7LXdYnsysLKwLHUO7EpWuVzPeI18lq8ERxWPYvtoU0T00UzbvQQSEB9pwi9UyAlMBMCROure3hZWq5olZ8RjGu/IQkVDbGE106xm2tUxGNJlVs/iyrnsNJp2YbgV3fbP5Ht0amt/ZakE/B9dwYxWtxs34Pxvjh5BiYdvYW5qsgJ4MOdHgGl3FONwm+xGXGM0kpvpUB3PcSfLQ5s4BRanGinGAOWwmcmH581JJH5hXIR7r6/zn7o4p31a+UHm936nurDWPRpnNNo5gfIWi4a2kxsfbf5rxzTt5o0ftHWfYHnZQvXw==
Received: from AM9PR02MB7580.eurprd02.prod.outlook.com (2603:10a6:20b:43b::9)
 by DB9PR02MB7866.eurprd02.prod.outlook.com (2603:10a6:10:325::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 07:17:15 +0000
Received: from AM9PR02MB7580.eurprd02.prod.outlook.com
 ([fe80::e963:4964:e1:374f]) by AM9PR02MB7580.eurprd02.prod.outlook.com
 ([fe80::e963:4964:e1:374f%2]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:17:14 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: -Wuninitialized in drivers/accel/habanalabs/common/memory.c
 introduced by aa7b6367186e
Thread-Topic: -Wuninitialized in drivers/accel/habanalabs/common/memory.c
 introduced by aa7b6367186e
Thread-Index: AQHZ6zyMVulBFMD7xEmq/ZSqPzDVSrAjTnwA
Date:   Wed, 20 Sep 2023 07:17:14 +0000
Message-ID: <3b9da2e7-e9e8-4aa1-a1cb-5b7b04ff1a48@habana.ai>
References: <CAKwvOdkShCL8MAE+rJzSeAf54=UeHRnuWkHkfMKDeC4A0KoEEg@mail.gmail.com>
In-Reply-To: <CAKwvOdkShCL8MAE+rJzSeAf54=UeHRnuWkHkfMKDeC4A0KoEEg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR02MB7580:EE_|DB9PR02MB7866:EE_
x-ms-office365-filtering-correlation-id: 1a689037-475f-4c90-c279-08dbb9a99d8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++j1vEfzzhjQEfZeG6BLasLzkeXFjnZfKygi/A1WJcEGRt9vJ4vuzsmXGE89DQlJEX+rEBNa3D8/YSXh5IRG+G8YnRoCzppUarazG2onVIgB8gtkorL++kqg8U1fdGHd0qHImuCTAPel++ULcEt7C1ETILKcWKQCRKIZSrXHVpVWXMqciK1V0M3pKJbOvE3xAqmJ1RO//lZ+hwLUpOiqPAJ5DXl92M3sjuQvBf2FV0fWNp8AKEM3rLwBV3zhGPIGy63T+xzP8TuTLPMoKXKq0G725fIXg05n/y2287et7Bf3nODZmXWI0/U1Kco4jlW2Nj9r1EW33ewfgd9Dj3oeoKrgeMlj2oZw+DEIRtSKNKiycBPXrkOEg5/riS9M0qnydR8uLP1HbXj4ARfhqKuvwxPe+IEGaC/kpPCnxxbDSK7WfYh8ycCg+a3X/thGX8nh3O41JtnSTKwng21MalrzlrwKFv/H83yljkuXpEBTjIpIMkAvfRJltia6av5Vn4CYcTDLfQql8/zh1j7/vgcJtTyIATfHM11+9O9uGT4TKOji4QUTLEEJNFWIKc27OcA5yfPKek/3I0XfYLUMibeDgRd2f7oF7EcCq4dpwJJe+gFWgp2Hqf2MopQtGamaDcaAfotqNk5rEPUM+myPBMaHWcHpQ1DYUJPKL+GANFIwGiK+uZ11/PJ3/xXxvzfFT84B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR02MB7580.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39850400004)(396003)(136003)(186009)(451199024)(1800799009)(2616005)(5660300002)(41300700001)(26005)(2906002)(122000001)(82960400001)(38100700002)(31696002)(86362001)(38070700005)(36756003)(4326008)(8936002)(8676002)(83380400001)(6486002)(6506007)(6512007)(478600001)(53546011)(316002)(6916009)(91956017)(31686004)(54906003)(64756008)(66946007)(76116006)(66556008)(66446008)(66476007)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhZa1RmWjE5RmQrdEV3OUw0QTh5aU11aWtiR0haajZNU2ZjWEdQTm5ydU9t?=
 =?utf-8?B?ZVltY0NZOVMrWHRlMFJmM296a0NQQnEvSml6Q25PYlY3d0hTZXlpWFgzSU5P?=
 =?utf-8?B?elZKc1U2S3psUW0raE9BU2VsbHNwSWJMOWJMVGJDaHBMTHFzZDVLVTBTOEw5?=
 =?utf-8?B?TTFSMFNFSCtPamFoMUpCRExibnZqeUdUK0J6a3JsYytDL0ZRTm5GR2NmejYx?=
 =?utf-8?B?aTBkbVZhK1RGclIyVVc0UTZZRm1UMEN2QUtZU1BPTi9qQlVZU05DVHpsc0Qw?=
 =?utf-8?B?VXhUWkIxei9LWVI5OEpDZmF5bkU2Ylg1a0huYnc2eFBoY0c2MFR3TXFLamV0?=
 =?utf-8?B?T3FvSUxZQ2hBTHVDUFVOUkkxREMvYlk0OU9VVXdxSE1QeGRHa1RYT1F3aENC?=
 =?utf-8?B?bFIzUFZrNHNvaVJHNXVGOXRmdWJMZlhtQ29LemF1VnNBeTR6NFN3OTU1Q0hl?=
 =?utf-8?B?NTdsTDl5d3lUS2o1K2xsTzB5ZUx4MXZSalk2U1VwSFkvNmpXRytwb0lGVDd4?=
 =?utf-8?B?RnNMYWRyeWxUMWpxNnFNdTVXaW9LT2taQ3ZFNHRaL1MxY045RlBtU1d1TnRz?=
 =?utf-8?B?UGxOTU1kZ3NhTkE2b3ZkcDZkaGJoS1hiVW1qemVCdGF5Q0EzdGxnK1BxVHYz?=
 =?utf-8?B?Rjl1d25QR3RETWxhK1pjWmRhYUxQd0tBaFBSUFBMOHNpY1paNzJBa3M2NEJH?=
 =?utf-8?B?bE1vVVRLK1BOUzk0RW5YQy8rNDAwSEJ3MWQ2YTFYcjRmTS9SQUVaZlZOWXVx?=
 =?utf-8?B?cEZsSll5M05TdTZ4R2xZYVRsRFM0RkZZNUo5UVQvbEtSVHlwUFViNW9zWlE2?=
 =?utf-8?B?TTB5QzVwYnhzWFA0SG54RDZXV2JvdmhyZHJOa1ltTHB0WUUrNTNwcFU2cHF0?=
 =?utf-8?B?dXkwazlqd2RuU1NIT0FRTXhaQ3RxekFQN3RDMjRuU1hKejRwcWU4d2xiRFZZ?=
 =?utf-8?B?Q1c4VXlwd3g4NWFaZnBqeUZyR1hEc0t5SzhBbW5xS0czZW9TNDcyUDFTQjJL?=
 =?utf-8?B?czdaUTM5NExZREQxS2w4TTdQdDMwL2RYaXNjVHRSR2RUei9lK0ZESWxIMXVX?=
 =?utf-8?B?TTdnMGtnRnRxVjVEVHk3R0FDdHBOeE0zenM3dUtHekNHS0FMcXdXNHZxYkxR?=
 =?utf-8?B?ZGhKdm5pZytOK1Eyc21zMlhjVDNCY2ZBMlc5RVdYcEYrRzVsa2JGUEI1Nm1t?=
 =?utf-8?B?MTJnWk11a0Vqd1luZWtTQVZHNDZsYStudStYVm43Z2RJdWg4UWFTY1pMQ09i?=
 =?utf-8?B?U3JqWmVDT3ZZcVc0U3ZsU2p6VlNtOFpFWmNpSFNWSVdYd3pWSFZSWlp2V21T?=
 =?utf-8?B?Mmc2RmdhQnE1dUFuY0p0RHlKMERBSnl0ZjNSTWJzVmhYR1FiOE9zeTFDZjBT?=
 =?utf-8?B?dGtFTDhCdjlDczBzTWZXWUo4dkhJUmtocjFXSkQ3c21pSUdob0d5cjl5amNT?=
 =?utf-8?B?M0hqVHlVNTRHVVB2NlVBaFMrS0F1VDcxWFZyV3p2eksrT2ZjLzlnY2hiREVJ?=
 =?utf-8?B?UlRHc1NYSGFDNzZROFpEbjFCb2YzQmlhaHZhc2RLOFVselgzYzl0RG5UcUN5?=
 =?utf-8?B?UmNicUUwdFVHN2RTekZaN0FlYjhVbXZOU1labnplYndVbUZoRVU2M3JKZFor?=
 =?utf-8?B?WFg5aUNKUTJNeW1TWDBtaFk2UnVuV3MxaDZBZE9qZDFGOW42QkZSMFBwa29W?=
 =?utf-8?B?aUNQUlh2N0V0QnB2bVMzUlBNbmVaQ21LRFNaazZNMHRJd2JBUWJiVSs0NWU1?=
 =?utf-8?B?c3FHc3JCeGVYQ2dDNEs4a0VkSzhvOHVDUTdNSWE2cXRnY1crWG83WXA5SHJz?=
 =?utf-8?B?SmFUc2lrdUFuVktnSWw3cnNqcHVzVElabFFLSCtTc0VKQVE4QWs4eEhEb3FG?=
 =?utf-8?B?VXNEeW9aaW10eGVwYUlBUWZvUlNRb0N0ditzS0JoaW54VldBcUlrV09uVUc5?=
 =?utf-8?B?U2luRWVacm8vRkZrWlZHUkRMK2RTN1FZSFI4cXJRbHZacmN3MUo3NGx1M00x?=
 =?utf-8?B?S2Z5cmtGdkprRWFEWXdXQitwMGVMS0U3MW54TjM3TFpEZWcwRzZzNitxdWJ4?=
 =?utf-8?B?L3htbjRUMEtVU2N5Q2V2K2NkbjVVWGxtRVhPOVdmYy94eldCQnpVaDQ5S0d4?=
 =?utf-8?Q?wI4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B551F6A5A7F6AC47AE229980CEA2AAA5@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uBU9XVAo7Fr5DD8V8VSKKQvFFP39pK5Vkyomz0W74qeeyL5Z7AdfFmgEk2SDHXeOqGiZJQoZ1E16brqZvXuH412L+jBBl98YLqROyaj0OY67SV8wWqrUFbf3cUuGuLI+1/7o8VYeycp6SaF+MlGftgN7Be9tVqSQLCLTqDFgILhzAZBuj9Gwayt9x1cwiU5CTpT2vN/AQ8I90aCnocshQMR3k2+xCKsiOnz5lXhBVMHSDUa3TuRibCro8rq9cdQ1B9fsGJSFVv7Yoy0JWofGVnO5bwgVB7SVooICsn8kXguXalo8KXCJ9Ruy1Mx5ZkVMHQ2vZaLcF7u2y6lZJQhOQjsYSBVRdyE2rsmm3fo1xZMCgLF87/909ylk4OfPX7bfHqkSu1fZ13m7X8LvnXuav6NW6MpB/6atYqN1bwJzyyPloRorD5UHa9wd/8GDux88jX8nAKfUd1g3ETB2Sm92q6Z5dBIzJB3BnKGrqwtcRE3eEf0IDhHF0PCimsUME6goQaDfytdw7p8uhNISxbuC6ziJwybL5mhwNPcz12U84cNtu2s60O0zr/mHJBUhH82PYwzo57QJuRwfbfg5DqESxo57Cy8NEzVEaQe4Aqth1upC3cuo6EAgCVasVQDxEhaVJEHAhB1pR1fZY6ot/SNZU2+vfMu26CgoxnGyhQgl+UeJ2c+fqWdJcZRx+cE/0rSsoV2IL2fCniDAO9tri4EY3hEGiJ5tzyhowT7bCllx1EUO0ypkR8tFuXifO6BWMedlQ6fXd6XB4XeDJ8QT0iE8PgeP8l/j/a5AJCMjy6LGdPhNJOwX3nrPdvNJwOhR9Lkq/HzW00sNMVA4m+v3g2+cCLgX+IHogpzVLMAd76xhBV3pSUQ3+ciji4fcsurHSjg2
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR02MB7580.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a689037-475f-4c90-c279-08dbb9a99d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:17:14.6876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfJgdpvqaVO8XIPa+sPu0J57TypJbuZQrfnEOSX1e1xJ1TKf0k6lH/kDcebK4nnlR5rtl5e1+e4Xg1rwRFsQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7866
X-MailControlDKIMCheck: cGFzcyBoYWJhbmEuYWkgW3Bhc3Nd
X-MailControl-OutInfo: MTY5NTE5NDI1ODpGUEtleTEucHJpdjoGualN8fxGn6HI5K80V6zHQBRQ24nnHPA/20o5GrAI5tRF5iy8yrmEUD/M3gmkff5/K+j7H2xPzEXrCq6EXdS+bjDpz7rvi+X6D6vvQZuqMxPPNbi7WbqFR96BRXJGNquJN2M++ImQ/rmc8ER4ymyWxTWLUO8JvzBSmyG9dLmHJT1uRkr38hzEhT9hlFp9bTtzyJIHZlK29kGQwW6ZqbIYxRwMCLbFuJ/f+51aRSlxMenBmx3h9sC7kuThBw5yhAlHq1lYBYRFH00Gh0mDaQkys2rAESY6m+tCX9m13WDDnDyO/IGXUEMxEKUNq76WeEDya1QaT5mjir6DnkCPMudc
X-Scanned-By: MailControl 44278.2141 (www.mailcontrol.com) on 104.47.13.51
X-Mailcontrol-Refers-To: 38K7Hc45001142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=habana.ai; h=from:to:cc:subject:date:message-id:references:in-reply-to:content-type:content-id:content-transfer-encoding:mime-version; s=fpkey81949-1; bh=uffGUJv8X1yglI3deTex7bmooPK821XJ/Mb2mRLOrKE=; b=A2HPQojZbdsCZ21LXYEu1WNjnJyyzg7Fed0RgePv6QWtvbnkasiSflMm52GLuRBZsPiKKu+IChBy+wC7e7HRbNAxsUYPGw2aI/80vXHyLCBtaEwmaC6QduJikTGe6MJt8Fvinu2BHdnEir8vbmUB35di3wT2gg1R+rs7Wx7RVvUElolxUnlPk9O+UWgCArrdn0207mCT9SDZ6F3MStwhkNwNSxqzWPAxIrsKNn5C8Rrs/tZya9SIFe7bE9iejKU8eO0lzjFvIsnTH6ZGvB+EcQ5meSXdl+ulUMAX96KUJSbnRaCqU56obV7VmoJVW9SjsgejgQi9EAamsZugnObfRg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDkvMjAyMyAwOjAxLCBOaWNrIERlc2F1bG5pZXJzIHdyb3RlOg0KPiBjb21taXQgYWE3
YjYzNjcxODZlICgiYWNjZWwvaGFiYW5hbGFiczogdGlueSByZWZhY3RvciBvZiBobF9tYXBfZG1h
YnVmKCkiKQ0KPg0KPiBpbnRyb2R1Y2VkIGEgd2FybmluZyB0aGF0J3MgYnJlYWtpbmcgdGhlIGJ1
aWxkIGluIGxpbnV4LW5leHQuDQo+DQo+IGRyaXZlcnMvYWNjZWwvaGFiYW5hbGFicy9jb21tb24v
bWVtb3J5LmM6MTczNToxMTogZXJyb3I6IHZhcmlhYmxlDQo+ICdoZGV2JyBpcyB1bmluaXRpYWxp
emVkIHdoZW4gdXNlZCBoZXJlIFstV2Vycm9yLC1XdW5pbml0aWFsaXplZF0NCj4gMzE3IDE3MzUg
fCBkZXZfZGJnKGhkZXYtPmRldiwgIkZhaWxlZCB0byBtYXAgZG1hYnVmIGJlY2F1c2UgcDJwIGlz
IGRpc2FibGVkXG4iKTsNCj4gMzE4IHwgXn5+fg0KPiAzMTkvYnVpbGRzL2xpbnV4L2luY2x1ZGUv
bGludXgvZGV2X3ByaW50ay5oOjE1NToxODogbm90ZTogZXhwYW5kZWQNCj4gZnJvbSBtYWNybyAn
ZGV2X2RiZycNCj4gMzIwIDE1NSB8IGR5bmFtaWNfZGV2X2RiZyhkZXYsIGRldl9mbXQoZm10KSwg
IyNfX1ZBX0FSR1NfXykNCj4gMzIxIHwgXn5+DQo+IDMyMi9idWlsZHMvbGludXgvaW5jbHVkZS9s
aW51eC9keW5hbWljX2RlYnVnLmg6Mjc0Ojc6IG5vdGU6IGV4cGFuZGVkDQo+IGZyb20gbWFjcm8g
J2R5bmFtaWNfZGV2X2RiZycNCj4gMzIzIDI3NCB8IGRldiwgZm10LCAjI19fVkFfQVJHU19fKQ0K
PiAzMjQgfCBefn4NCj4gMzI1L2J1aWxkcy9saW51eC9pbmNsdWRlL2xpbnV4L2R5bmFtaWNfZGVi
dWcuaDoyNTA6NTk6IG5vdGU6IGV4cGFuZGVkDQo+IGZyb20gbWFjcm8gJ19keW5hbWljX2Z1bmNf
Y2FsbCcNCj4gMzI2IDI1MCB8IF9keW5hbWljX2Z1bmNfY2FsbF9jbHMoX0RQUklOVEtfQ0xBU1Nf
REZMVCwgZm10LCBmdW5jLCAjI19fVkFfQVJHU19fKQ0KPiAzMjcgfCBefn5+fn5+fn5+fg0KPiAz
MjgvYnVpbGRzL2xpbnV4L2luY2x1ZGUvbGludXgvZHluYW1pY19kZWJ1Zy5oOjI0ODo2NTogbm90
ZTogZXhwYW5kZWQNCj4gZnJvbSBtYWNybyAnX2R5bmFtaWNfZnVuY19jYWxsX2NscycNCj4gMzI5
IDI0OCB8IF9fZHluYW1pY19mdW5jX2NhbGxfY2xzKF9fVU5JUVVFX0lEKGRkZWJ1ZyksIGNscywg
Zm10LCBmdW5jLA0KPiAjI19fVkFfQVJHU19fKQ0KPiAzMzAgfCBefn5+fn5+fn5+fg0KPiAzMzEv
YnVpbGRzL2xpbnV4L2luY2x1ZGUvbGludXgvZHluYW1pY19kZWJ1Zy5oOjIyNDoxNTogbm90ZTog
ZXhwYW5kZWQNCj4gZnJvbSBtYWNybyAnX19keW5hbWljX2Z1bmNfY2FsbF9jbHMnDQo+IDMzMiAy
MjQgfCBmdW5jKCZpZCwgIyNfX1ZBX0FSR1NfXyk7IFwNCj4gMzMzIHwgXn5+fn5+fn5+fn4NCj4g
MzM0L2J1aWxkcy9saW51eC9kcml2ZXJzL2FjY2VsL2hhYmFuYWxhYnMvY29tbW9uL21lbW9yeS5j
OjE3MzE6MjQ6DQo+IG5vdGU6IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdoZGV2JyB0byBzaWxl
bmNlIHRoaXMgd2FybmluZw0KPiAzMzUgMTczMSB8IHN0cnVjdCBobF9kZXZpY2UgKmhkZXY7DQo+
IDMzNiB8IF4NCj4gMzM3IHwgPSBOVUxMDQo+DQo+DQo+IFBsZWFzZSBmaXguIEFsc28sIHBsZWFz
ZSBwb3N0IHlvdXIgcGF0Y2hlcyB0byBMS01MIHNvIHBlb3BsZSBjYW4gcG9zdA0KPiBpbmZvIGxp
a2UgdGhpcyBpbiByZXNwb25zZSBkaXJlY3RseSB0byB5b3VyIHBhdGNoLiAgSSBjb3VsZCBub3Qg
ZmluZA0KPiBhYTdiNjM2NzE4NmUgb24gbG9yZS4NCj4gLS0NCj4gVGhhbmtzLA0KPiB+TmljayBE
ZXNhdWxuaWVycw0KDQpUaGFua3MgTmljaywgd2Ugd2lsbCBzZW5kIGEgZml4IGZvciBpdC4NCg==
