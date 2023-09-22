Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260377AAC76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjIVISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIVISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:18:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2054.outbound.protection.outlook.com [40.92.19.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981B0FB;
        Fri, 22 Sep 2023 01:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo7+svDyzy1d6LuX5Fu36EilVivW95MN7g/xiJ7neiftLI71+21VRfNdBue6FvA4eDHZQUUnMxWr50R3croF4truurgIZaK9PZHOFlrzjaSiiZE5FVSF03VY1hh92mAsQ/lrt60shc6yYM9sjGRFAKVH0GNMuNLYnEAcia6qqL+rGBwuDPxlLE0iIE7Ex9pmEH2mpaYGwut6cJi/QMoBxmPTfTmhLsXGD1men9u1VgX74Y+oHFlIeoFT7WgGcqYa/bPgZEfV/PwH9KgRTMBZkO+0JLeZbGI+U5XdsOdIjE9MIA234KFV1575CMn8NNVmQpnhTgYKuQTPouwBZGvWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCb2vGV3sykMoOW1BjflfC3tiouppm9a+ZgibVIk/tU=;
 b=lYQez6WEoxlYGTOGTKheXeOX6WF+7O22HcpbQOj1OyAPQnHXqchhj9D/IuLB1uKD1ndR477Aflqwrh7qpAtVWyLgm2P5rixOfQHCTLLAQASs5tUxRYzRqTU4vPcjMiBmRMd+CNasKd4mZtNd0XBLaqQEIr6xftNFnmnHFus6c0Q68oidxbXzNW5wrppuIGxe0tnlp/m5hmV1/wV2VtFA0E204qghi4aJhZvtsCn8nh2vHAP1icHgA1BpK1+VW8hqw5UUWorQMvpeCFEJbOzEImBLPzzs3A1ECfQhMXqQU4UV8Ow0v9YJYr8zG0TG2AWMGPHYwIdtU9I5MmEdwASeyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCb2vGV3sykMoOW1BjflfC3tiouppm9a+ZgibVIk/tU=;
 b=MOewNjufJ34wivz+3yqMuR5pSAtCIci+YFmVMHw10aPLmA+Aa7Vq2w0RyrrYZmfxLHezVyDw27aP7WisA5/Ecvslroz7LSfnacPUEwiQ/ICq82hlOQSut3qHp/20vfevj5vJjpkc/o3ni7C94NvxP0H/Sdc4hovHL5K07SOd4DjMFPUpK98L77j9iZu8Gg83Al8l9G8n/DKLsIegwDozCed2yV935AcilkEseWnOOpOEhVaRB1Cylzt/1emcOdHsCbQaJGlvF5BcqsgOAi1qYvwvAnORSrq5ncIv+oA6pE2yuB28ZlYWh2pUAIw7KsO5gTtzak6MKxWDwkt5XX873Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6987.namprd20.prod.outlook.com (2603:10b6:806:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 08:18:38 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 08:18:38 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Date:   Fri, 22 Sep 2023 16:18:27 +0800
Message-ID: <IA1PR20MB49538AD51ADC3349B2AE8542BBFFA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922-thumb-galvanize-bef393a1bda4@spud>
References: <20230922-thumb-galvanize-bef393a1bda4@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [n5Ndjbvmii4WKvDMYGHu9+bLco9m5DI6wdBVwKP4WKY=]
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230922081827.114904-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c488745-cc43-4ef3-eaf5-08dbbb4485b2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbzRDTiFkx2RkOACkdoTBqF08xnwlRv4xwchDLcS1YDl9vFpAxgkbuSWlQ6EMS+qTtCjoDo+C2efWIivuyKuxuNVbrSGjQCgxg20vT+C9A3Nxl5cL8RSS1qfRaMXAg00wMJG/39FfbV0YnLXF7i8V4BKGwYW2netv+DSDqN7ctDjuKafRLsP4Wealktck7z+q3GNogXGTwnJCy0s9OL+xyK978SQ+hSp9NEN7QR23etuVOOACSpetQy3ZoOEWNLv4jM1lwRYP+Mu3y9HENgTTLHJdYPS9iOoi+qLLYxfDRwa20x9CUIgBH1LF4bBm6YpE+OPzXkWI3eyIB0nHHDL44J0Pk3tv1y814WWQ8c9sZZ/FtMqHMUT82Outz3+Mrx2U0fh2at+8BfGv9ZFnyycHJSQ7ccAgbYPHoqJrLUpUzfPNe+uLJn3Sz+Jg/L3DHLULiNo4XHX/Tye5uF2vgpksvncKMg0vyfa1LoH9SgeT/WkllQoe/xqttBYNUXInMoLlL32nU7HynHdYODWDQWhA+Gc5Xi+pG2EZpoKUObwGUOe7lPv3Fb/9jpMRRZ97dg4LVrTDr1qRuQMrcaekeRiK1XXqSYur4+o8j0onqboZOe+4K7r7YIQZcGy0t69mAup
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ov/G7UtRLRVKRcfVf9JLB8gDMkGahpFj2L9bc8Hhq39oAkX/OkqKBaMpAb2d?=
 =?us-ascii?Q?HiIPsIjjiKFlsoaTU9ABrJA+C4VmtFPpmbjvU+yptNwbuaTcOsxd9+lv9OJM?=
 =?us-ascii?Q?1OVvqoRxZ1KmmAD4JYPl4BxV0kdZimOqdcjj6k1ueSdy0PbgTltlSW+M7wge?=
 =?us-ascii?Q?+xJt0n9VhC6KiWCJ3doVneWeaQUcyshzEjn4Ey2w3e25EgAt8GY6W2hdirIB?=
 =?us-ascii?Q?He4nEAGTlwolVCBUrsvp40gSegPsOVLxoZW5HkGHTNubYt7k5p87NtwQhIwG?=
 =?us-ascii?Q?bLWdAM9shsJ/eFNlbzu8PLa6u2lZU91zmX8VX0n7VByrnYkcm+zeKMzoK4uc?=
 =?us-ascii?Q?o4VsomkRMF1hqM3/TR3hmQzq6uA/gM7gdn2XlCFhk85xVUgrn+SeqWlOpC6g?=
 =?us-ascii?Q?S0GXIpKhVbTnG+KhFiAs60Iklk+ORv6RYmZIqWi+kccEhyTrcoQ0fcBgQave?=
 =?us-ascii?Q?WTw3fBqUQYxF7pBEzoj6np/zq6i9OFDiA4/vtJPrcLWsiqxdZrORY2ckNfRK?=
 =?us-ascii?Q?EEl4KhMKoTxtZ+xd0b5JK1IK81OUmpY+qM9vmePCk66irb4L9vBC8pXvlpH/?=
 =?us-ascii?Q?wHnWjwr8CeBvOWjivvGKnDJQUyCePM5TmiLvv1VUN9pZg8ZtduUIdC+rPsxf?=
 =?us-ascii?Q?v2ohF1nAUKW8NPsa5o0m/a2SWuuy5zgHeK51r2iOe074jJ8h4Q2QIr1Qsxwc?=
 =?us-ascii?Q?vPMI8KDFSwb1CFnH9wyVKSSc7YJhF6T2zx6MAeiY6c3mQZXR/PDBq+TSTHLV?=
 =?us-ascii?Q?eMECCYqJDJWBdRBSQaJnOH3VhBd87vr0LMP+Wq6Ae6pf0uHcaLzT1sbG8xU6?=
 =?us-ascii?Q?qdPRTTt3HY+I9SZI3aEhPG5ENdtMKH3SjDl/png9BO/MZ4tUBzWq3QVP8XIN?=
 =?us-ascii?Q?/OxnV3I4NJpkvhASbvoQIGzxlolyOPYdN2F3+x6sGx1YrELjIdoCOBbRAQLt?=
 =?us-ascii?Q?OvnSpQPdJ4FfKeDfZQW5pHHGVXoepMGs4n61qBEB6LqG4DmneMStb3XDpPpL?=
 =?us-ascii?Q?E91TbCnMK6PqCgJ/PaFLPilqPfAuj0pM25efe/NIIfcBL2DzkUjsihxO5lql?=
 =?us-ascii?Q?zkdItfPVpZgR+MgJvSUob9epaLUccRSXfWJKJkBodY1EqBBpNGucrNpLPf7I?=
 =?us-ascii?Q?udQVJqnMdEPmButFYUy/BeM9hvT/QbNTiMdZiHzBI1YIbP0oFqWz88RHCF+I?=
 =?us-ascii?Q?vWuaiY6w1JwxFH4f5ePLpSVtkqgeONyj13gP6v7+aMfVUzyvj4/CUNcYD5Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c488745-cc43-4ef3-eaf5-08dbbb4485b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 08:18:38.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Fri, Sep 22, 2023 at 01:16:35PM +0800, Inochi Amaoto wrote:
>
>>>> The SiFive CLINT has flexibility related limitations which makes it
>>>> not useful for multi-socket and mult-die systems. The SiFive CLINT
>>>> is also not useful for systems with AIA because with AIA M-mode has
>>>> a new way of doing M-mode IPIs. Due to this reasons, the RISC-V
>>>> ACLINT spec breaks down traditional SiFive CLINT into two separate
>>>> devices namely mtimer and mswi. This allows platforms to implement
>>>> only the required set of devices. The mtimer as defined by the ACLINT
>>>> specifications also allows platforms to place mtime and mtimecmp
>>>> registers at different locations.
>>>>
>>>> Refer, https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>>>>
>>>> We need a separate DT bindings document for ACLINT MTIMER
>>>> and ACLINT MSWI because these are separate devices. The
>>>> Sophgo sg2042 SoC should add their implementation specific
>>>> compatible strings in this document.
>>>
>>> If the spec isn't frozen, I'm not accepting a binding for the "generic"
>>> version of it. Bindings for this specific implemtnation are okay.
>>> For sure though, squeezing this into the sifive,plic binding isn't
>>> appropriate.
>>>
>>
>> It seems I have missed a point. I wonder whether it is better to add a
>> "aclint" binding firstly and then add sg2042 to it, or just use sg2042
>> specific binding?
>
>sg2042 specific, being frozen is a requirement for merging patches
>related to RVI specifications.
>

Thanks

>> If use "aclint" binding, I wonder it is OK to add
>> thead quirks as compatible specific properties, or left this to the SBI to
>> handle? e.g. T-HEAD timer is not 64bit timer, and we should identify this.
>
>The compatible string alone should be sufficient to identify the width
>of the timer etc.
>

OK, I will take it

>Thanks,
>Conor.
>
