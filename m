Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687EC7C80F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjJMIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJMIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:55:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2027.outbound.protection.outlook.com [40.92.21.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862ECB7;
        Fri, 13 Oct 2023 01:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFwCYi96odg+M8n6o+qEcPx3rhvxTabTAO4yeXHDmNSxoS6zMsaz80eszVegYz/eqL8B9XnTzxe9wdVqx7Q83+Mjo2XNmozH/0Sop0AW6Wanht4UD0Uyp3VuNR8TEL5sO1APZ7w3r58YCvFBce6AH8/vgzZPvu9pFlNKPpc/W/14bOJniYDiB9TlLK5HWBvbUjTzoMZ1TA3KW38Ejd2FvGvIos2JMm5//k3YzB6atbI9Fi8UEJZ1gogE09Gw6E6fnv9p81YKZcPdRL+S/4mjP7srtseSPh+xuMeDBEeyaSl1idFQ8oLXD1GoPI9M+0HpYCDqfTf7I33Xz1yoEnkwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb3BUgkVgvcqA7Wlgjhpby29+KWoSquyYdSU6t5Sbgk=;
 b=e8sbg8/Q97/2yd7QqV34p5Y1pJ/tif534r1/fOOS9S1ctp4Swe4OWzfC4UP/UQ5Hb+wWg8g3Bo3vBAHDzGpGHi/jdwsc4p2Tte8twsiKAlVXJLmjVu0/z7H9SPg7LQTgZKnllflU5fFHuf3otnNxKpKdrs99BMCzmsIWucIJx8W2a6gL5K1yb+4gZX5IFiW4KD0uecCCBKYYMnu8eGwqA2/LRpdOpLudpCQDfnFEC4t3ZKpYLE2UkAR4tFdtFZd1q909i/1uzlulqhZBCk5MddqE3N9TRXeBIbyDJylqUWRfu0D1EVm2SF67R8bF0LSdWSHvNW+TILVl+1C5pggL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb3BUgkVgvcqA7Wlgjhpby29+KWoSquyYdSU6t5Sbgk=;
 b=PZ1PzOuQ3AZ/OQODZijOAzvdW3FFkSZE6Qchz/muZkIrWmz0EuXoHRROo++apiE41PmISH1AXBuNfLuOQBgy5Nb+kGBd4YwuDoLV/7D20lgtF37MSBy1kednW9h4ICHNXFbslOgIkHXVNU8k0rleSzNqOMiSgxHRkMp090mUANPaV82RLEBOXhL06s1ktEqmgk5DuZAhakzYCqBO3OuJT3OG55k9pOdBp9F8+cMvubKoSQgGnYGSlfllN2V+5UusuPHnRWRJnyPE8esF6+OGPGvCMHbkmaM7fwTqJBAer2WXltDt4tAlBlhbze+ACsq7D4+QEoBcAbFCUEg/Qevz/g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5686.namprd20.prod.outlook.com (2603:10b6:8:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 08:55:13 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:55:13 +0000
Date:   Fri, 13 Oct 2023 16:55:18 +0800
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/7] Add Huashan Pi board support
Message-ID: <IA1PR20MB4953B73EDA0F872B10D79CDABBD2A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <c3920f4e-9e93-4a33-b3af-cc30cf6c1fe3@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3920f4e-9e93-4a33-b3af-cc30cf6c1fe3@linaro.org>
X-TMN:  [OrLtoNhOaaW7f8ePkC+kTAbiotstX9HQ7AexpreVrZc=]
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <gp63m3gioxy37ozd2tpwu5qdwgfd3nifao2htfbyduabrccwse@zd7igtqr23vb>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fed2b0-b6b7-4023-cbde-08dbcbca1c20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIbvuDQF4MT3ZcI+okSco0UDl/d0kiIfa1iFmRJgN8wPS76sTeMJjQBiJ58nQ1xvWVmKCufJVbWqbVbfEKruUtD9dF76WBhBY4guRtF2Mzu2q1KiIVaJ3KienZsjjgUR/KHuezi58GZ2pDSkub4Mb2XOA97TXU93nlsYwX43sGEnQX41cfCCuF7lvou+BRydW0INS9D67mwu0LZXXiiNoxvOmgh48HWLu6tZz8KltWxXiXDPEj8mLGCyFCYjSNCerfFBzxfCOtC0INeOuKxXzlVgf5MdgWvaRm2z/tWeB41KUv2Bas93Dydmu1LD3S7/Fml3zI1p9eXE7pkf1N7g9iy6pxLm6K8xM2oWTcTm7LqWExC7vBUadFOxzjGuF/REzn87npnhCYldmMjsRRQxRqjTDbUdv71n93uuK4/Bsy1/lM6ogQsoG4L2yBKSIkiHZ8SBZkMMOhj7ndevb08/tz5KV3XKS2q/i9yimzfMMCwPnPOBO7bsJA4iUA2kVm3j7OhdFArnoDTy4HYWZXZPfuxnBPaSmhI2GmSZq8PxwPx3rB2tYPlaoxdmr/+02bcua5a4QfgnFR0E7cpMzmr9jrF1j5bkOm519tAUgYuSEjg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjZfYR/Ugq2y7FI/52XRrDnyErkDE/l7NQaJhX5zZbMgwbZSXuNriAdlTj8H?=
 =?us-ascii?Q?asx4lUVxJWsy8hshR4RVSccDA4EHiwgfPNZ+IjZc/B/CaIob2c+m9nOkL/zP?=
 =?us-ascii?Q?JeT+zHdBFwIzFNHpzmcio40QwsjOD5O6fl5/Xb1Wz+az9A9+xEKAGMzyinfN?=
 =?us-ascii?Q?XywhDebyeTUkn3d0gNgkYO/mVhhutuYntPz7O+mN/jysE9wqGeMj7Fv41aGE?=
 =?us-ascii?Q?XnDNQS/UWeu7M28/L/tda16cRBmFI1SJ9KIczHFbMqnCvHZ7OX/ttTpu1t4m?=
 =?us-ascii?Q?SyWXK4Bb2m1e1GXZOwmeM6/NHGI3yZ5QMwmEh2Nt5Cv9i+mWdh0hBomTCZLv?=
 =?us-ascii?Q?6PEj6AMehtGoR30fryT1iRSoLq6PKgeZVv7auKLPFbj63pRTBvboVrzrFHCy?=
 =?us-ascii?Q?ip1CRUH7FP5OcdUiEvTilscVSAFjSJpeYFTDyttDiDc3jGXfLxXPpnJWA5NP?=
 =?us-ascii?Q?Gy0q+bGo0C1FxtuPDURAXWKKlreyybEtZG6LXWk+TbxhlSF2SDeccVOUC/cN?=
 =?us-ascii?Q?3A7sEmASRjl/5c/JOksYnI3N+tuY3/tZSqreorNMArp3mPLhXnIpjWs1+e1J?=
 =?us-ascii?Q?/M3+lQlmgYwDlo2F/AgVBjhDhlwLoV46yvGZ2s6gHGHY4gaEzj+YfgdF6sbN?=
 =?us-ascii?Q?L9Q6EuftL7tQ8czyd6ucvVChxNPZnjItnA9cv2uu+9wEw9GgLiKdBB0pR9Af?=
 =?us-ascii?Q?6M88nqrXsCQt1pT12wwuPavzFV0ZbcLh5ke88DZTAEa2az3e+ODZuugOoX7P?=
 =?us-ascii?Q?rH0wjKJG48b/p+yo26uFh4HxFN8oqtabYOfq4Nd1iyF9z1HMPVoTCpmjIVhI?=
 =?us-ascii?Q?tVz/3peNQ7yhzO6wCzCAM6RPVfB9CloF2RHi53VYNdvz7uf732pkp3hqjyMC?=
 =?us-ascii?Q?rydgsE2tVft0gFx8bs74UtyAiixqv3sdBeKe72SPtDOrAqzUlNuCwN9rJze0?=
 =?us-ascii?Q?oIcjiFQrgBAWEbSd4UOdFDdnU+4vOztLceaU+2wrMACrWXkEKabdShrjWJH2?=
 =?us-ascii?Q?fLGlc5cQy90dW497J4sqXkOarD12Kk5eNcMz1MiT2fGbJaTwUT2BxhWvmFZz?=
 =?us-ascii?Q?MFtwA6GewWaecjODmjWONRpByE+VMHS85SfxAXxcgFFbvO4g3iB6m/afBzOC?=
 =?us-ascii?Q?/i3sxt+eDonuzIG5Nv7VaM6MyQn4sCU6/DAQSa+AQTL3s4P2faeSLa8JYOaI?=
 =?us-ascii?Q?mnge7Jnj2tEEKW4a34GLBv9tchUQ4KUwvMCBeO4zYCz8lAmV8DqsTXZ4G7o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fed2b0-b6b7-4023-cbde-08dbcbca1c20
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 08:55:13.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5686
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:48:23AM +0200, Krzysztof Kozlowski wrote:
> On 09/10/2023 13:25, Inochi Amaoto wrote:
> > Huashan Pi board is an embedded development platform based on the
> > CV1812H chip. Add minimal device tree files for this board.
> > Currently, it can boot to a basic shell.
> > 
> > NOTE: this series is based on the Jisheng's Milk-V Duo patch.
> 
> Which is? This must be clear dependency - lore link.
> 

https://lore.kernel.org/linux-riscv/20231006121449.721-1-jszhang@kernel.org/
AFAIK, This is merged in the for-next.

> Best regards,
> Krzysztof
> 
