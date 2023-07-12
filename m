Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B01751187
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjGLTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGLTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:51:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC021FDA;
        Wed, 12 Jul 2023 12:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX81eHP0ve6blHf0Fzc/lltSiFDyAUzq3RAPh8QtxhzhoZKX091+YOyuuYnUfoNqHIEtOAJZigpCa0gIMC3e6LLannoZHUeZVPB5aP4U6ur2UkArGkvAVDWGYUukQPeh8a+DJ1HNGefi07LoOrHujhXLBiz44LH37DL/fybr89R4WkMvTyYth37qisHOk6yTNg6JuABbWqh49qBjzC8oIaptKqyHG+nJ3utV6jaMBX7aVyk140TcVPF6jCleluXHz4aqO6RjTdWhGg5hrbJKqPIV6Ko6Oincs27X4BoYYd97bnofFPFIB7gzEIT44CbaOyJfHYtdXnowVHAJjBf7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+k2XdmDGudF64QoMdaApvQHzwrAaXMPWMVo81A80ww=;
 b=UH8fia2OcXYPQebFWfn/kDFL8Mcej61ks8qMiYvKWmi09h4hdG3ojBE/a0LfwhEoorZ1VPgCMqEeLJYD7+45ep91eLCgve8+FHRVDrAZ2d4H1ev9Mw4hr+KfC7VUSqQUXCJKMcPeGBuOnMaHKyVc9ViBlGIUOO7HKkeknG9WcKWGhGBOSmF0SIbTE33MYBORnuudD9lpc4yX8ktABRCn6sMEdz35pLyOhiGR9EICDnsG6WvZLDLq7McDy+QRNOgClF9nv08mJ+UcZYRHvWpFAsW7pOvx5KVoGcTDKLt2LuQERJ1M+fyPIezfrRShQ9vgECXyuRQXA+r8fmu05fcOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+k2XdmDGudF64QoMdaApvQHzwrAaXMPWMVo81A80ww=;
 b=OOPnY9SqdFH0Ps6MIgQ2+fhf2n/DfKoNJpkpv8VtRd0a+qvN/b0Wvezzy7S4a3Vl4C2lc88YiX2BI3D/89bB27KlGeNAraNJi/7qQXCeC+jyqO4KESIINYgx3qqzk+Vav3p0PlOaPv/OEOap9lIyvZ9W89bWSry0RbU9dEI6c8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 19:51:28 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 19:51:28 +0000
Date:   Wed, 12 Jul 2023 20:51:19 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jinjian.song@fibocom.com, haijun.liu@mediatek.com,
        chandrashekar.devegowda@intel.com, matthias.bgg@gmail.com,
        chiranjeevi.rapolu@linux.intel.com,
        ricardo.martinez@linux.intel.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        m.chetan.kumar@linux.intel.com, linuxwwan@intel.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH] net: wwan: t7xx: Add AP CLDMA
Message-ID: <ZK8EN4dfZgICvPl8@corigine.com>
References: <20230711062817.6108-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230711062817.6108-1-jtornosm@redhat.com>
X-ClientProxiedBy: LO2P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: bd186a9d-5885-446c-9b59-08db83116167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kg1Vz4jySmbypTYnY9QDfwbQZDd8whMU/gmGn5yEV2pUKEjwueUOsiLmodAXgEY2gLeXstwMhaE60p1Eam7uXiE2Sz37F6BYO7P49/k1hPAE50m4GtZef9ekaBcXJ2mPwEKCoKcD7c1MAcm3dENfNnF35rqGRgUgl6t575D97QCSMwSscbKszzDOslfDikXnN4vZdsdntuXvi14ViZbJMYT8LJMT3CN2XbXYYM6cAEylCxRRCjgExN7pfH8xPe7D1TXIMoC9oIv6blf+8OKZvJB/3Xhf98Rn8oX9icbXnQmP5+hnYaIn0tF8D/zQuSOwQUscgxRixzxpSbTD03k2cUSHY69z6TFi1K14kHBY6edQBDY/JIUZV9S/UZY6zlg64vDkp601pA2KHFbkcyiJWT4GU34SJ+xdepqZ+i3c6bofpEdiKXC+cR6UAbev6hBUsWh0cX12qVMk8nPfgsyyon6gPGSu5WccdqU0bbtyY706IBrjPBqlu3YCbWemM+I076awE81o7wfdfrxuYm0Ui8qIpxZYz0HnFa1L4TtYM++XcV0cSJLalBDvPh8NhYFHHTalJuj6aU2HiOqX85HJV0es8DgbnSuebWt2SoeSUuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39830400003)(376002)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(26005)(6506007)(186003)(66574015)(6512007)(36756003)(316002)(2906002)(38100700002)(41300700001)(4326008)(66476007)(66556008)(66946007)(6916009)(44832011)(8936002)(86362001)(7416002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qld3NXdCVUJWcmlzWjgyZ1p6Qi9CTjJ6bXcwNmdadFFZSXA0WW9GdFAvTmoz?=
 =?utf-8?B?V2srNVk1YnlWTXJrVXZzK083ZFZxUXFoRFlldjNidWpaWmVpdmtKZ013QUdQ?=
 =?utf-8?B?QTRkbUFZQzA4UTMxTXV6VTI4VkhtRmZEMnRsMkRIVnMzdW5wNFg2T2hEaGlp?=
 =?utf-8?B?RkYvYlRUVCtRU0JWditHWUhtcEdKWlMyb0xqRHJZUjUvQnNNTVdOZVV0V3R4?=
 =?utf-8?B?VnFKL0dQWXpaRnhvNHI1Z09UQVB1dFJiRUZ5dWtYUHRRTDZYTjhJQytUU3pq?=
 =?utf-8?B?K2R5dTFZamNSNUlNamdlbGZUS0dEY2JTS3RySEVNeHg5K3VCVUlWVEwvYlN4?=
 =?utf-8?B?eTV5NGlZZ3M0d3dXWGNaK0k2N0liTUwxWlUxUUY2UnhZUmhaeGM3ektuRENG?=
 =?utf-8?B?K3dleUJZbk9tTzJEZkczZjlWL2ovbUl5RFo1YzRvblBiNklPb2V5cEl2aWZM?=
 =?utf-8?B?dFBscGF2OTExZ1ZTKzZ1a2VqR0Yzc2taUzZ5ejZyVHNDbFQrK0JYQXdZN1FL?=
 =?utf-8?B?UW05MHZxQjlHRjBuRnEwSmtOeWFwZHdaaWZxanUvQm5OOWxKMmF2WmFoM1Bu?=
 =?utf-8?B?MS9Gc1ZpUzFnMFR4SkgvWlFud1dJSDJNY1RrQVVWbUhvdWhEMHp5dHUxQmM3?=
 =?utf-8?B?OHh5YzdXL3pJRW93WUFVWlNtZW1tMWhzbXBsd1NJQmVsZzRiQlRwYWF1QzY1?=
 =?utf-8?B?amFGN1MyR1dyV2FYejdDVTE5RXNGcEZoYVRUb1AwZVVLUlExemdPcGFiVUdk?=
 =?utf-8?B?ZktzOUtjVFdwam1vUGNzTmxoUFl3aXc2enFhSFVrOXhYbTRiZUZNSnpGaGdX?=
 =?utf-8?B?amZxdDFiWlhFUjZuUmhzMmVtWEtlNXJENk1oMC9zUUR6dlNVd2hPbXVpb3VE?=
 =?utf-8?B?a2ZoMlliZnNvb05IUkFvNXpPc2xRdVlwK2tpaURFcG05L3JPcUxrZnNKTHRQ?=
 =?utf-8?B?TkxRbmduREk3QmZxM0RjWnRrc2NBblYzWXhoUEJVZytWZE4vZVd6WW90MTRv?=
 =?utf-8?B?U1ZVdzkyNVBKWGI0NmxaT05TaUhTMEpNT2pxR1BFc3BmdTJMZFpmSnppVkxH?=
 =?utf-8?B?WkZxVnlqR0RMempyWEhyc2k1RkZpVkRha2I1VlE3Z1RQNXc3VjFCWlY4bHlS?=
 =?utf-8?B?YW5sUDRnbVBaREFPZGhid0dXN1dQTitDcGg3R2tFQjRNWWprUUluSDZQazZi?=
 =?utf-8?B?aGY4NHpSSGxPWGRhZmdLSTNQVkhUcXFXOU5VZHZaWEdqNkVndU55aDE2VkJs?=
 =?utf-8?B?djJHMVVGR2tBUVlOaFNSeWp2dERwQnFkb1FhejhmYzZjdzQ5dVUwZ3JDRWZL?=
 =?utf-8?B?T3VjdDZMNVZYeU52NnNYMlBwVWsya0VscE1IRnhoSk04OUNrNk5uTXAxSUI3?=
 =?utf-8?B?QVRJKzZwYU9NREVjZ09YWXY4M0tyQ0tNSGp3bW9lNUR5NlNBNXJVa3VOYXR4?=
 =?utf-8?B?OGkrQThVZDF3SFV6L05Gam5BcGVlaDNtcWdSUWg1NkYwbTMza0xld0lPUVdU?=
 =?utf-8?B?NHRvUjB4ME9WSlROVGozckpYanRDVnJGbVlReGJRVEZQTlRlL3RvQkVjZGM0?=
 =?utf-8?B?a2dCV2czTEk3ZTVvblZMVXdYcnFRMS9SN3poVFB2Y1Jma2JzeW1zcVhJYXBM?=
 =?utf-8?B?MkRvVDgrazZ2TVg0M2FYQkc3TmdNeHl2Tyt4NVhzeXJkZEdSbkJNWEVhTGk0?=
 =?utf-8?B?QlBGNjRUR1pYS1JlejhsSmZoaEpNNit2bkRadUpnTzYxcWV4b29LTytFZkU5?=
 =?utf-8?B?TExIOUxSdUo4SHJlNE9tSVlpbVE2Z21EalFha1I0Nm5oZ2xtQ0p4d1haMnIz?=
 =?utf-8?B?MlRKenFHdVJyME5BeUJjTHhValFRckEyUmkvbWJkZ0VPbHVNSFBndGlqbTV0?=
 =?utf-8?B?QkpFOHVmOXFJcW1qbDhkTnhTMzlHQ1hNbFUybGNtdENPRnFzNGhnY1hKcjd1?=
 =?utf-8?B?Y09RVFlQYkE1bGpJWDFIRjV1WWs3N0hzZUZXcE9kOVcvQzNKV0JwS2NhbG0x?=
 =?utf-8?B?UGJ2Q3pSQWZ1SGpqZUllRDNOWHVXVy9oS09PL2Y1Q1Q0ZllBcjh2MmM1anc3?=
 =?utf-8?B?OGhVMXRwR0VXSFZqbUg1bzl5cVhLY2JEc2hESVBkTnlWWG1oLytpeUI3MWFS?=
 =?utf-8?B?SjRST0JwZjNyWFFGZHpINXlBY2VNK005c3VPNkFILzFkTWJDN2FPTVRHTWFX?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd186a9d-5885-446c-9b59-08db83116167
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:51:27.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkAx//JOpQPp0cl1Z7DWnQVMR66RmiC9haCy662H+8aIAJ/+o8NOsU9NhNoVwdqlYyiRU8/0G9qlkeDDt+ruM9BxU2kqIORscKnj71tc324=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ maintainers and MLs as advised by get_maintainers.pl

On Tue, Jul 11, 2023 at 08:28:13AM +0200, Jose Ignacio Tornos Martinez wrote:
> At this moment with the current status, t7xx is not functional due to
> problems like this after connection, if there is no activity:
> [   57.370534] mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
> [   57.370581] mtk_t7xx 0000:72:00.0: can't suspend
>     (t7xx_pci_pm_runtime_suspend [mtk_t7xx] returned -110)
> because after this, the traffic no longer works.
> 
> The complete series 'net: wwan: t7xx: fw flashing & coredump support'
> was reverted because of issues with the pci implementation.
> In order to have at least the modem working, it would be enough if just
> the first commit of the series is re-applied:
> d20ef656f994 net: wwan: t7xx: Add AP CLDMA
> With that, the Application Processor would be controlled, correctly
> suspended and the commented problems would be fixed (I am testing here
> like this with no related issue).
> 
> This commit is independent of the others and not related to the
> commented pci implementation for the new features: fw flashing and
> coredump collection.
> 
> Use v2 patch version of d20ef656f994 as JinJian Song suggests
> (https://patchwork.kernel.org/project/netdevbpf/patch/20230105154215.198828-1-m.chetan.kumar@linux.intel.com/).
> 
> Original text from the commit that would be re-applied:
> 
>     d20ef656f994 net: wwan: t7xx: Add AP CLDMA
>     Author: Haijun Liu <haijun.liu@mediatek.com>
>     Date:   Tue Aug 16 09:53:28 2022 +0530
> 
>     The t7xx device contains two Cross Layer DMA (CLDMA) interfaces to
>     communicate with AP and Modem processors respectively. So far only
>     MD-CLDMA was being used, this patch enables AP-CLDMA.
> 
>     Rename small Application Processor (sAP) to AP.
> 
>     Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
>     Co-developed-by: Madhusmita Sahu <madhusmita.sahu@intel.com>
>     Signed-off-by: Madhusmita Sahu <madhusmita.sahu@intel.com>
>     Signed-off-by: Moises Veleta <moises.veleta@linux.intel.com>
>     Signed-off-by: Devegowda Chandrashekar <chandrashekar.devegowda@intel.com>
>     Signed-off-by: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
>     Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>     Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

