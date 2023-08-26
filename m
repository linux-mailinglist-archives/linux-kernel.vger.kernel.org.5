Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D026C789699
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjHZMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjHZMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:13:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2075.outbound.protection.outlook.com [40.92.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49297;
        Sat, 26 Aug 2023 05:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO/tLuuNXjNsAu3OLZExAT/KUpOZqJEc7S63nQDwiHrdFJ4KicAbg7fwgF2OtOyPfUCiGtSoverIyj6tk9dZKUSaQmJOAOEluILABhAsdl6XIhop+3JXvLvYVMYYXvclf3BwMDKvsKwLqXwBeGo3ZMRneGk+m2V6jo/3WbxfGdPPUsd/s76wk2SBkpUN8kuzRledO5ecZwfHYfuYcGLyjNrbjCwCLnXFuz/4094Kmt5hah75rjUWCETFwzJU7elChrfZ3cS4hPUdVePXBFcRSlRbkkAZb/B8FABwhkxvd+n+4wjN/ttmSCIwoxlnFLrcHDGhiZGiNFCVHN1y/+pr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0Yqr+htEmnMIFuJZw5/WP/Yvn/tZVs5lFvp65D3DEM=;
 b=FgjJ0eU9iXDS6kagS53DFpio+aK/7ZD/Vh99boYrssvTta07ewM2ys6ZdiIHUwFzLWev25iZi3C8K0X3yeHR0E+LDJU/KyHZBNZ3l1eiU2+uxQ80YUcGrujIHO+C/pGQSQ/rrQDXK8KLelly7OtKSwhyD6gj6uuqerm+G+FYuKOOldbug+rCGG403rRQmPnEG2hqzougoeuKmCMvP8ltFHqNe4jAaQW5rkh89qsZ7/e/Q7VKIqn8o+9sm/Y9GzzFkrSRRr3jG2HZ537O8bm11X+WXershjo1Jt9GwxKLHh//Wo3QPsTtjlZb1EW/F/+mz40jAyZ0jGeGXxPHypOg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0Yqr+htEmnMIFuJZw5/WP/Yvn/tZVs5lFvp65D3DEM=;
 b=dFtNjmBOsaf5r0z1OX4y2aFuOgODZJmCygmEtcRkk3OMw0T/F7fQkxccL+wEbRadCO1CIqTprdtKbi3Vnmd2Yh54KOX2kERVF/Wraq0/iDIaeXw0Q9zRxoC3WTfRd7MeaPLPv69SgSpvu4e91Fh2fRmw5/VPAEhcSCNKnM3GBjTajanzh7WVKHleqJKzhwEYPAg3xgGMPpsi3JvRnbQTSz0VHQLGXYEnC6a70CBD+oinH6R97L/ieVv8/gRnRDSRV7IWOIBy1iG18Ix6ZvmsipTrhs6HjBpjafjUNh0qN5T2FoyPjz23LpkHcRSti+OiWu+Cyz7RlxOWR+x6sSRmnA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4550.namprd20.prod.outlook.com (2603:10b6:510:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 12:13:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 12:13:47 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sat, 26 Aug 2023 20:14:17 +0800
Message-ID: <IA1PR20MB4953AFFDEE0BFCC8A0929C41BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826-cubical-publisher-2580c5991069@spud>
References: <20230826-cubical-publisher-2580c5991069@spud>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cJyhnsd19RNojxwQyKCWB/P3LAFRb2xPX6WGOFOG7uE=]
X-ClientProxiedBy: TY2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:404:e2::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230826121417.292785-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e590152-5ce6-4476-11a0-08dba62de6a9
X-MS-Exchange-SLBlob-MailProps: cn60g5V53KNKBQSRra15jXhWKYZplGnb4qI3NG6O3zJukDOki2sF9phjEa4i/gTApSmzJc7X7q8irKGwDMswz2034Jkrnd6Njq52ZEGO+mhcGbWpizmIbYjwQJtDqGtfeZDSHstc6oQUUUQP83QU8ExoQz7lhXK2mGZuikJC3o2HmEBOuMkYv0zVK9OQFtcmDh5igWqjxl4HTH2Kjxyu5f1qGId5L4Qd6PL+IShQk0SdhzeGZ8rex0w06mbu8wKLqRIN+oY3nRgQ0pGGqIArlAe/mWYP2VVAHqQkgEQeg1rAwMsU0fU6qQ5w41S+mAUTrqZsLlyT3r0bUQ+IRf/qAFjmjsTjZWboqEnHiZKtrrzR+U54ZQbo5VOJfc/+dVmeCnRBcJRH0zroxJTOLZvcI/6E4dzGYSIvp4gsZ+M6HVL/GCZTpggNIYuacDp/KmA2dTNXi7YTZdVklHTUSIIyl910sJUZ1p9dpAqyb703x83htTtAGV4LHS24JewcDVHfE9N4RrAdJCBOBEawtScguVZ4Db2y+A6VfTVXn2mmAyEz/dBbtrLrIYStXjN8KaO0umstcVTXXKVdNUoU8QvvWnayzCAn71V1sSoMme2qAHTrJy4fWKTPDWikZd0xzZk6/aAl6WKszmupkBQCmXtd2B6CMXWqLfjh3cIEAj4blPkFtGlTQmY2VfZ788JXM4MvbK9eoX5pTbhbD/QNCTzIFiO85LkpCYaSljwWQdCVnUQAf+HjQiorHgxQkhdOldQETN10Ccpp36QfrPCGfOTKjlCe9jPAFu0zFPzIRat1WXLUBeaBEVoN9TG8BMERZzPZV2jXzS5Ky+pV2LQZZz8Hkf08sh87xqMzOiVd5uehGRllWYVDWkGM0Q==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psgQNg4SCFGK2mKMrb3tYk0efWT8XzcdzzwFCx4Tf9nMQJK5EmOGQ4QjPbaOjmrwcmcte2V790wkCBVBOU4jrkdWFbtluKSQv4wVLp7QGIFkpVlCfhEdUwh669DE9j0se3fg6ZJP1yKtzuxwbNt78waijaVN3tVLG/tvAm3v7Wj2WhGfNb1uO0YAe9erRPFsgdhXxVUmcAbE3GgHXpuzs4MH42x4hRN3YJikIEJJd0+/VG9nY5LDn1royiD/oOfXw9aQeVIqNiilHKJqf3r0cJGiGGpNaKY4SBvSAbgFQPYm1hn+Em7nApyyu3UDpmNzX7EZzWAwI8/zs64Md6fHny5E62DZ9PvRz6O2eKq96BzuOOCljlUMjmT/Dqfyl77OH1omDrz30yXkIA5CCvM+D0512Hj7lkaxELKZCEaSpWR+yL6RqdX0QGnCYywBXXeZJpZg2DUHNPyz3qAeywbmLX5knb6pTuWtYeVmouKEM4RbQfLqahCZvhim7o7GDAPKrbrV9nv9urBN8etYJiA3OkLHb/lRmfITLiszGHp6Ul2vaKtL8syonMWlRtuIVos0giCYKNpBZqDMp61SssEZjPEhPA4AetVrqZmfKygSRe4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+ges2GorsTZEq6hFzbbNDpIjr6tDAC3ZcvFHrfuTTtxC1fFegdes4AL79UA?=
 =?us-ascii?Q?KmnDjAbS3rpfvLNmMIw4rBldSgKGDjFUHt1lIH1ntpn0M39obraOzcZyo9K/?=
 =?us-ascii?Q?cTK9dPjgGPmHj5yFrfXTQohFlwwxMWVyTxjN2CB0+Fmab4H/RAG8CXkxjhIu?=
 =?us-ascii?Q?JGn/OJY0l9F76FDYFz3/V78JYgKK73I/umuDujUMXcVYcUU7nr0/1PihqVw/?=
 =?us-ascii?Q?61P25Wcj7YgWm6gl033wbJFbtWWHIQ0FwE38oSfrzN2bn9ldWN8j5IcSdkIZ?=
 =?us-ascii?Q?3rMgc0ZdNWjqDNAOpHtO2xhNfYZbGaN4hCct+Gsd+pfArq/i/aITG2FFG/z8?=
 =?us-ascii?Q?2wqCFRRp+4K3y8SXf53jQvEee+q2vjqgbfbquPL4dSe1bqn4929uClKMAvu9?=
 =?us-ascii?Q?zOzxdFqbDZe2NeffG8VElb0sxy8jUvDG4QRgBXqQw9m6xBTR7GNzG4moLE0l?=
 =?us-ascii?Q?NU/NuZ3c4tVZnVSYXGK7eBzv42e03QqC7DegENWcD/FjRSRgVKwiZ92LySSF?=
 =?us-ascii?Q?7wY8Se51kCtiDKmcVeJpUdMF8MqVxxvmefwDL4dFbN1Os50RP3kHw5JtYQYp?=
 =?us-ascii?Q?L5nkvLAji0h9yuSys8pbU1kfbjzvm0P0EuG5+ADVpvFWEVKyo2j9g5RJrE7s?=
 =?us-ascii?Q?3/saCfdQFoDUUymhsamIG++y3fzLvMXFKQRJ/owiR7AJgHF88q/u3xTwnW8B?=
 =?us-ascii?Q?yDe3QeqAvspSBiot0Pq5umB5sMg1kCrhz7M4bKl6wMt/nPLX9EQdn6+HwO4f?=
 =?us-ascii?Q?s1zFWasTKq+86I3Ys05FdFQYSWtoOo/yrela22yKWZpFG3mOrXR9pRYtoU9q?=
 =?us-ascii?Q?51q+6M+UcyraMHDtUnum1F2CQ0Z02dVHtJI5+foD1MKDDvFBOGQGau1qiXZ5?=
 =?us-ascii?Q?tpEFelQJOldB1aC908tWciuVXLU53LRiLfyy++dzhht+hzA861JXe2ieT9pU?=
 =?us-ascii?Q?5bkZMPrgm1/kS2bIwih4s4Ec7MNn+5rpfyTLh9/RKm74c6Ug0e/jK6khIziZ?=
 =?us-ascii?Q?RsbfwpC+y6r9heLAVr23PSlRG5jpMLRelElQKwZCRrZJ+ny8HUwB0oxrfybB?=
 =?us-ascii?Q?Icrx8TLykIrmi0hzseyn/nRc8ERiJAW+lKjW6+a+VlXZAql392KHICYL/2tr?=
 =?us-ascii?Q?x4q1QF9/bqRavOmaBQE8Z4HGCAQRtgq34bcy1Qti5xdU768YUfqGnpDtBLh0?=
 =?us-ascii?Q?yFm1rH4aHcsQdI5dn8S+QXCtIBJuAzYHRFItohxelgwkksB+Duno3wK1FgQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e590152-5ce6-4476-11a0-08dba62de6a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 12:13:47.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On Sat, Aug 26, 2023 at 04:38:53PM +0800, Inochi Amaoto wrote:
>>>> D1 has several pmu events supported by opensbi.
>>>> These events can be used by perf for profiling.
>>>>
>>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>>
>>> Could you please include a link to some documentation as to where these
>>> values came from? I know several people have had some trouble with
>>> understanding the pmu DT stuff & having some documentation would make
>>> this an in-tree end-to-end example.
>
>> The DT field of riscv,pmu for opensbi can be found on:
>> https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
>
>There's an actual dt-binding for this.
>
>> The value can be found in the R1S0 version of C906 documentation:
>> https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
>>
>> The meaning of T-HEAD events can be found in this patch:
>> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
>>
>> The patch above also provides documentation for T-HEAD events and a example
>> that shows how to use perf with T-HEAD events.
>
>What I meant was can you provide links to this in the commit messages so
>that people have a way to find the documentation.

OK, I will setup a new patch to cover these info.
