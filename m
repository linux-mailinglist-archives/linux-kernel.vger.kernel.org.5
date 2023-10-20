Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D77D1197
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377566AbjJTO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377496AbjJTO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:29:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCED53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hehMfuqgl1xh+pOSOseCWXKrcSQvmbBhlyxM1+hHZZl/CQAMITwJjEnOxoD0zzOVGarGTVvyYgIrnoxrEonzY2LDsmFiC0CigqPNpdg/hs5hKsWyiOY5rAGwPs8M265zX85q+qWtqlaqtn4Xsp4tvoj30z7kmACDeo2yKJbeNPoevok11qdrWPEXGTMx+65qk3cziroVSm0+ZjssxH56+gCVcbm/hvSwOWdMEpTge6hT/F3YDSL8tNvwlR4A+NMLzNT2LWSP9DqQgJqJl4q0C1eXZUrtAsMFNVSZK7X0H9oRtofhQHUNbfHS3s5WMwN50EKpC7pY8oYZwuARRHvmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j31BCaDIQXsXSkWq9Xib7jbddEm8iZVJcnUPR674CYM=;
 b=c3RVveqwRa8sFQllF3BJRWlJb+IrArRilocDRLfQGRq2QoPN45vGOseO9HTPLZEF8RJs7OHOiF/BsdFkDTp1VgR54wK5k3MMM0dtVS1A9j7cIE9dkOHF/UfIvzSqUR7bt9gSIoHDRaQMroLPx3RcHWv7IM1E8O3QkGc6Io5bqLxYK9G65QyJrliq92rkKiYjjbNa++mkFLdkM1J3sv+eQXU4n7xsabARMJ+8Fdrfr4+0phDRSUkEFekmFOvmWTZqJf7y0VzEUN9mTvP6HL3/PqaPuJZaVjZTieUdytHPm8O/N71W+Rl7ys1aqTugBqZev68tCzMYelX/bprPWsc7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j31BCaDIQXsXSkWq9Xib7jbddEm8iZVJcnUPR674CYM=;
 b=sRSWh7ioNdghg7bVhoTrEmlY7OYuhWcAgWquXAsmVBKBr6rjpI3iWyAmD9jPR9vwkC+TwLsnS2eqhIs3pTUGv/tPCtjy/K/F4g4rXVo1wHDsVnhXyJvbWXOFYzaSmtCRKV2KvlkAQOLRWpNSrTTDGvdm4GZH60W0WY8Q7eOhUWP2C33rucrO9LPjbfupGyhA7JmpWDeU9DQgYm1PEd1AnEE9cDb+chixTpGZayuBQAXFx6xavttHJ1Gsy7tnFLV/fNq0+gLTfOJaZf/Q+QsSfj0obZaIYIyMReHTvuutQpj8OyvzlrSJkZtQDgmUyZFnnG8WE2SbjUnW7ngMIfXYqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 14:29:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 14:29:00 +0000
Date:   Fri, 20 Oct 2023 11:28:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231020142858.GH3952@nvidia.com>
References: <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
 <20231019115142.GQ3952@nvidia.com>
 <ZTJizmxV4Gtb4g3S@arm.com>
 <20231020114719.GE3952@nvidia.com>
 <ZTKIzZk3lGATLkGz@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKIzZk3lGATLkGz@lpieralisi>
X-ClientProxiedBy: BN9PR03CA0788.namprd03.prod.outlook.com
 (2603:10b6:408:13f::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5dfbf9-3986-4971-8140-08dbd178e6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKrUjVOyyV6oCdYwGDezEjHSMjB7neTEqsCMMc+YNJcTHr/CtSS8fokpYfkfOAlTXFuJEuQR2/u5WMQsq/5qFioHwxJ36/mLI7pheTPOPuZEdzK0GnW47Gvy/NtgvNJ54dasEsg0s5S18YOgX9cunyVBh7RXFnAqB4xXvDjr3yq1CVN0tq6UEThLqh2fyrB7u+ME4BSPXJk/UO4rnQVq/1WXp9o0ECx7jO4LgkO/SkKtw5alxtugc/lT9eN7q/ilpGxahwjFw1fRRVwyTG3SsxE0Rztq6SpA3Kx7xVEelzAAWHgh/EMjpJgnUXnYsFLujLnncs3OEToBAFfS9zy01xOmFHfhW4VPC2rCa1tQpUnC7m0/EP5TrQlJPm1+Psi55KpkwMNAiB29PqwZqNM0RVqxmeKplCfflYvcm5A7XBE3y2H0S/XcCnpquHk3HmEHB0X6LcZTTIhoGPnIDhW54wZ6waKiGnAH3W/Kwu/t/3XWRq8NIiGkqnSe25U5d9ZQ/7eG1j0wQ3inhHigVGGf1rjfk/8HWjIA05CX1pCDN9waAk5OwmUE5wGus38031xe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(66946007)(66556008)(6486002)(66476007)(478600001)(6916009)(54906003)(1076003)(86362001)(38100700002)(2616005)(83380400001)(5660300002)(33656002)(316002)(6506007)(36756003)(6512007)(2906002)(4326008)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGTHAByW6su7k3MekRbhWlttP8szHOVbtAt0wTIpCdhOVM9FhQ2hwD+M0yyb?=
 =?us-ascii?Q?f89KGHxdqD+l1LChI3Wzz0sNAxt1KhcmjngaVzSw1njjDOWGHS998b154XwU?=
 =?us-ascii?Q?l5ZnpyRt1lnZWRiO3Csx/c20gpU+dX7yvcDwuWcu7ath6MvW/rRPhoG0ymWQ?=
 =?us-ascii?Q?08NYFuUF+M23RkIkYLXaIQEauVzJ7jJcvvsP6l+pdG2C0fL8r4mMN1/QPeoD?=
 =?us-ascii?Q?NBocdzragffQEqLTpV10WYDmXjdwhJrs+5ALoW2BM5fXcdZxPt/ntYyUTy/n?=
 =?us-ascii?Q?x84lxCRwSrS/pfY4TXPemyivlh5CbG4cKsMpATNfpuO8fWVPEBatgNBS9BgP?=
 =?us-ascii?Q?wPh4X/t1kPMWUEAPM/Jx608aA6EAoFAGR7a/LLvKrItvi0AWslVSWsJ8V7ht?=
 =?us-ascii?Q?Oug6iUelW2DXcnWiwfNhlB+di0UuV/tw9/so4BEPz5R6pS4vfMbtSfi+gt96?=
 =?us-ascii?Q?kbK+AYeVxWqnJ7j29pkqlnZlbU0JK/j63coQQp8P/WfslWkHuYXcQcEiTZOL?=
 =?us-ascii?Q?rodGIdGtQkXRvJJSzvkK2i+MedXs79+vrTHz3DUbGyIbAzBcQ12FzxmGYx1k?=
 =?us-ascii?Q?OBPCPE3HDBVvBgBJxagl28sqxY3aKACmQ2xROnHguQc2dxd9GY12UNJ6e6l+?=
 =?us-ascii?Q?xqG7pFMxEm9hI4wU1zZxRpHlS9QezyqyHbybAjwbCbQgHXt+9j+CIWnrFI5a?=
 =?us-ascii?Q?qc+CjpsAwi8oIjaR0PnbflYrAs3V1Y0fzZ94+o3yG6zW8qOHIOE80XqfMAzH?=
 =?us-ascii?Q?B3dgMk5Z9q8fti1zndYZu700jI8iohv7is73KWFgFobVx0TgvYRZrScCMw0N?=
 =?us-ascii?Q?6pXM70OU7AJ8qq2U/VesQ8/LOTgtn4zgwirPMVxzTfs723mWZbiReV5wi0tp?=
 =?us-ascii?Q?FJrv9BygO3h0Wm68nwiy5oVavps1853wuXP9cfUEmw3XhHece1SHhfzMnrTP?=
 =?us-ascii?Q?AjNUPyF5OWf7oR/5sAEYna380LhKIKUBJDsF83OUEA9KoCTkc2ozxGX1eY/a?=
 =?us-ascii?Q?gmodiIB0avUltLCOvOGfZ4uy0uCRKy94Kky1BtIZ11IVtyv8HRyjlhep2+uT?=
 =?us-ascii?Q?TmE13xxIuw8b8Zm9YbjqSR2PrkmYf2pp92RwiGwf5VWgL89iGL2fC7e2yRF/?=
 =?us-ascii?Q?MtDd4xuLu2A/vDHdfZKbmmwbDk3uNglZ06q3M/h1gshBFoaJBKMa4pYJyPGi?=
 =?us-ascii?Q?levDvWIc/jzu25KG06VTaZkMv1H6XcNWCEjlreBa9/x7uri+IkkW76E2M2MU?=
 =?us-ascii?Q?r8P7U06LlrVcBnWbTSsmp0H/XD+efBxdIRfLringJwxh4IOJHo6tXBMAhxo7?=
 =?us-ascii?Q?5txcJag+FJ2/zFMu7h9JgA08M/Ns3IiPdVm1vVQfT2+EbnKrmvJY2DQQjXK1?=
 =?us-ascii?Q?uGB57ozuHyTiIugpCkhSrmpUJoCBnEzVwapeZIjT9lRp9lH1sMP+u13BZxVz?=
 =?us-ascii?Q?72De8AG+DeMaQCOkOIEq7ssBrUGhD60q84WoG9JTIalPCNr3W50uFfc06XNu?=
 =?us-ascii?Q?nshLXKoAy9SJdUbINTrgAzeVLMoi+PWikKJvPcLkIJPHckRdxJS6Crh4Ov9X?=
 =?us-ascii?Q?ePTKgROF6/E+a/qHmUo4+NV9mEXBDQ+GuGCejitp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5dfbf9-3986-4971-8140-08dbd178e6e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:29:00.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCf3L0/lqfLAsMBojMyLdKRWktbNRmnCsCF/Z8QYfGDIUFsYREvGBZAPcPTgPD/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 04:03:57PM +0200, Lorenzo Pieralisi wrote:
> > My point is if this becomes a real world concern we have a solid
> > answer on how to resolve it - fix the VFIO driver to have a stronger
> > barrier before reset.
> 
> Just to make sure I am parsing this correctly: this case above is
> related to a non-PCI VFIO device passthrough where a guest would want to
> map the device MMIO at stage-1 with normal-NC memory type (well, let's
> say with a memory attribute != device-nGnRE - that combined with the new
> stage-2 default might cause transactions ordering/grouping trouble with
> eg device resets), correct ? 

This is what I have understood was Will's concern, yes.

> IIRC, all requests related to honouring "write-combine" style
> stage-1 mappings were for PCI(e) devices but that's as far as what
> *I* was made aware of goes.

Yes, this is what I am aware of as well.

Though I do not object to the idea from the VFIO side that platform
devices would also have to support NormalNC too.

The theoretical missing peice is that someone would say they have a
SOC issue XYZ and thus their VFIO platform devices must fully block
NormalNC. I suggest if someone comes with this and really, really
wants VFIO, then we could use a VMA flag to indicate that KVM must not
upgrade it. Currently I have no knowledge of such a thing existing.

With PCI we've made the argument that if NormalNC is broken unsafe for
KVM in the SOC then probably so is Device-*. I think the same basic
argument holds for platform devices too. Thus I'm skeptical that
someone can come and say they have SOC issue XYZ and NormalNC is
broken but Device-* is perfectly safe.

> We will do that, I will start adding the recent discussions to the
> new documentation file. Side note: for those who attend LPC it would be
> useful to review the resulting documentation together there, it should
> happen around v6.7-rc1.

I will be there, let me know

Thanks,
Jason
