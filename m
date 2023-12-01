Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B038000CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjLABDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLABDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:03:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8EB6;
        Thu, 30 Nov 2023 17:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoxGAriFu22dix7FB4ZsO7sVrI0WzYS7+zoo720o+tLN+qyi5B/7JEEO4GBXkPVphP+BYXFpwbsuZUiQXugWugapWxhhMimfSCE0YxRNdAV/K1gyNg7N6Bywt1t4H25ysMaojbJZ46dBkDU/qJa5fMHQ0HZmrY0q8DIDQKWvt1QY7pVheCnP6+JcjPUS3gK+TZd4GNNZaxCzfgIOkkjyJAyNpjkUfD1KaBi36SJYtvBzvQ6fb6c58ESEu/ROwUze6KXgiXCK0OvCAltdPoKLgtm+1JNDHgMqHTOjv7qSQCIj9BimLva6NRZTCN/AmKDnGdBMjnCc0TtS3s/Ezwl+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnr5ay54QjD/OVJj+C7qKz0RS2qv5B9hxRUNaKmLEOs=;
 b=NwXChEPi8MsUlxGGsZlDqllg9/t2mM+JCgahJNMU09hASQv/Pu0+CgCi4kNJjmbXTATbmtvQt5kK5vYmrNK8zQ6squ+ceKeVnt8wzpH9F0ZC2SsUwDF1bhyg/s7lH+YpsK3w/szSvhvWDjmCFitqaFZNkq1SgMKuY/dDDghqsXfTJaUMlif2pkUVjbZqp8vjJ3tHyEN+Ik2P8N0e5IHOJQ2qkvusK8ew1/4mNiEEnYmzDnztIL+YB/q/NqavNUqizj3ufiU7A4yapJRwEVBC+0SKT53oD4PwM2MwIX2r743GuWxeTGwMcw7RPiwvUAqzmKOhsZKzVJm6P65hWt/P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnr5ay54QjD/OVJj+C7qKz0RS2qv5B9hxRUNaKmLEOs=;
 b=hdx7Hg1RdW6XPkk2hHRkTAa1dUOFbrEmOA/2EgpxVj1ciPoOYJ71MXbYgV51bzc89tbuR2fCGkArWi8ke3LIRU1qEOtYq5+J7PzY3cQwokV1ZRn0c70DgEp3QjuBuJT8gAlfdHS6dfD10mIg4iOYifZtHSj4diFJOsbgKr9UJMoFBMmu5IVvtPKMcca4GQXBTcG1wZ/fAZA9vtJp8QRcB/wuFKHfmnwStAofdCyXYYlfLDzuJg0rBLRNWrMTNGo7dwJqB46StxbRAm2hFhqPEYff43gHJy6uDnna0pLCB3AN8ayV5nxXR7hF3IFlC/IwsO1aosKH2F+UjOP2pwTJJw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB7084.namprd20.prod.outlook.com (2603:10b6:a03:575::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 01:03:11 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 01:03:11 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
Date:   Fri,  1 Dec 2023 09:02:59 +0800
Message-ID: <IA1PR20MB4953FCB8B9BA4F2910B25C66BB81A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201-nullify-overhand-9fb99d0752ad@spud>
References: <20231201-nullify-overhand-9fb99d0752ad@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2A5Dh8a8a2sd0iaPUQjUPlrO0hai7Sy4yMwox2RQQP0=]
X-ClientProxiedBy: TY2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:404:56::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231201010301.88569-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b30044-2bcf-4356-aac0-08dbf20949c2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEFQgnKHAHNYoN+sfH9ro5T9WZ2XOu8by3rHVnCirGqguf078QDlaQqb9w+ZhHR1PJikJVdgcqojnj+32rCvOCzl4Z8ofqGfaBqRi9c0ZjPcLcyI4bOyT3ldH2qIsQn0Cs8eK7eJNX1Zx7LnAhoESyr1sWlJUlekZsOAGz4odmGbZhzn0BD5N1dQDvJg5OSWY45JCmpgUVKN5DlVi8KqIO/TdVT/rkdYXUZn/IWmCAC6j2GDWyEIo2XzDt/J5l1MObvWceQD5VqcVE61RS/RdIcAJtyHFdAQL7Hj9sMUhEMXDZRpYKIDR93+w3lvRJXe0JIgOgbhExLjwtez5OOC0FPZKJWGOgtfcTFL2Kn587AxLWNBzrKgI5jzt6Y/R25klS1OAc/MzkD/qK5wvDYpkFR8Y6K0GV47PFnYqKt3LqhcDom9VB34Y+vpFwIODxoN04EdD3kyWWzsqy/q5Cz3fqQSPvNePi/vOX3yCTgU42hzPni2XWh9sKFPmcgONkf0b+ze+hCqx4/oa+z7Iec/HklYO70kQgCYEUYDYabQ8lYfxZsqEQ0Poafuq3gmiRzZBXsAe219RijycN6wHI842OsDCx+i+5/l6UC+clYrbPdY4RPA8B2wpJ9yj3/hRTMz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v/+1HrB3QgP0mTJzjyhXlO1emBxx2bqhE5cbmji3w5JpP34hahjZv2Yrc/hd?=
 =?us-ascii?Q?HZZZyyGAoRTfADD/H2jBNVkDaig9jiHZ6kETmB4bM5S69r/WoTfQHA3Z4Afw?=
 =?us-ascii?Q?ONwnfmfeyi4++WRgDU7A0qYfEziBYksuj2uW+3tY8wORPp78TvZmTY2b2ZzB?=
 =?us-ascii?Q?nCdkoBb63zIa3XdmaPHl29Wa2XgODN4gMzxyA6x7wWu4hqte9v7kHftg6tDc?=
 =?us-ascii?Q?h2zVb6yy+6G483r07LL0Qnnpwz8DLajH5KI/ytVF81lerLPDEJMDZ1NSd2UQ?=
 =?us-ascii?Q?HYZWND4izDEGEhPMJ2b/XB0+p8N6cjOPMVam0+HwZobMmjo+bFgUHfCh7hnT?=
 =?us-ascii?Q?aj38vav6E5iqOibGLY1q8O24GhvOkqb4BTYW5HrPkYib5Z1QJ1P4nPQhC4zl?=
 =?us-ascii?Q?GpcELcgNV1jMJkQPvVsBoq7NDBmwFSy6E0Ij1HfW5Sg7suiFDPYMx5d2MZau?=
 =?us-ascii?Q?1mhmLFJ6jNbGB7Ats20jgwLj5JokvuDSxj1Cq6Powc8MyP8xLI0V/Q9JAMIV?=
 =?us-ascii?Q?isQFNW7DtVLJEgGPEg2M6pqzfHZZtMvXVvoL4PW+eu/7UhwORZjA7eEFO9rS?=
 =?us-ascii?Q?nkM2/G7hKWogO3Hb5TEjvE2HFhiQco2uCYZgKHA9Z+PUZgTxOH/nSfbTQMmi?=
 =?us-ascii?Q?xlXwfk6jj+f5GUffWdDIV6Hs2Nt1Ef62Zl5GKDddroLD0esaRMjLzB+k/OxD?=
 =?us-ascii?Q?p4XkX3LeHV1splBYnKaraqCUqGxCFQb0AIKD1SL9NlcgwrmspI0zGOwHlOZO?=
 =?us-ascii?Q?6sWeqmLbzQCeuagzPIKJFDBilo+bYL4V8wFZ2BnBFMY/3y3pvP/P5Wnrx+aX?=
 =?us-ascii?Q?yDzdvzfNwiGAUDzCohfJiGAk+p/9BVbETqQMrP1kGUs06Jy/1UZ+z85xVj9b?=
 =?us-ascii?Q?9uBYbX+SoyILqLgMbmcp8uGXGU3tbH9tcRifwc7wrMNgFrxiYtS8tRyjg6gG?=
 =?us-ascii?Q?xUDvtPDL0nPtbAU27u65Xi3J/YrWIYAtazS+SawxsmpMmrapUkd99e+tZJvt?=
 =?us-ascii?Q?+Gx5vKiQh80YF8GOqE5zJjUPvYLLIlwRXkTQLXr+2p18gLn9MFCao4xFadi8?=
 =?us-ascii?Q?mf2rpg8lIgWh9/4RV3qWN7iOYdfSMKKZYaIXXKul05KlGhXLWUmKhiBj4lDV?=
 =?us-ascii?Q?7nOlSIvohvooyX8ghw6ZQJcg54HoAtMDN7jhnDG1NmwKeKTvdpTyLpUoJFws?=
 =?us-ascii?Q?kBaCPmcxgWy/6JlQMe8+kYjmoBSv1L8p+HCzt4LDMwNk5w9EfMx2IgZowLM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b30044-2bcf-4356-aac0-08dbf20949c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 01:03:11.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB7084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Fri, Dec 01, 2023 at 07:21:29AM +0800, Inochi Amaoto wrote:
>>>
>>> On Thu, 19 Oct 2023 07:18:00 +0800, Inochi Amaoto wrote:
>>>> Huashan Pi board is an embedded development platform based on the
>>>> CV1812H chip. Add minimal device tree files for this board.
>>>> Currently, it can boot to a basic shell.
>>>>
>>>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>>>>
>>>> Link: https://en.sophgo.com/product/introduce/huashan.html
>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html
>>>> Link: https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
>>>>
>>>> [...]
>>>
>>> Applied to riscv-dt-for-next, thanks! LMK if something looks not as
>>> expected.
>>>
>>> [1/7] dt-bindings: interrupt-controller: Add SOPHGO CV1812H plic
>>>      https://git.kernel.org/conor/c/21a34e63afcc
>>> [2/7] dt-bindings: timer: Add SOPHGO CV1812H clint
>>>      https://git.kernel.org/conor/c/06ea2a1968a9
>>> [3/7] dt-bindings: riscv: Add SOPHGO Huashan Pi board compatibles
>>>      https://git.kernel.org/conor/c/d7b92027834e
>>> [4/7] riscv: dts: sophgo: Separate compatible specific for CV1800B soc
>>>      https://git.kernel.org/conor/c/5b5dce3951b2
>>> [5/7] riscv: dts: sophgo: cv18xx: Add gpio devices
>>>      https://git.kernel.org/conor/c/dd791b45c866
>>> [6/7] riscv: dts: sophgo: add initial CV1812H SoC device tree
>>>      https://git.kernel.org/conor/c/681ec684a741
>>> [7/7] riscv: dts: sophgo: add Huashan Pi board device tree
>>>      https://git.kernel.org/conor/c/2c36b0cfb408
>>>
>>> Thanks,
>>> Conor.
>>>
>>
>> Hi Conor,
>>
>> Thanks for the confirmation. But I suggest to revert these patches.
>> Several days ago, Sophgo informed me that CV1810 series will be
>> renamed. And the Huashan Pi will switch to the chip with new name.
>> To avoid unnecessary conflict, please drop these patch and I will
>> prepare a new patch once the renamed chip is launched.
>
>This is a board that exists, that you (and possibly others) have, right?
>

Yes, of course.
