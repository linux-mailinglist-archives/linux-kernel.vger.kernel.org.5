Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FE7ED773
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjKOWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:42:58 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F419B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuYmksxSDtJUYVFyZzb6cFRH9NGtpbb9zGSM6+onAM1obsZJERjN+CTgHWTWfOIXNYgJYfi4bBNQA5iIqXHj7WVPzOK3AxT4x4qh370AHHAZ6rIfQRinBOqoxCWgD2fqXfH17SpOjk01iFbvsw2vqnnvU7cGgdMvhXShFV9Xo3Mqsix7fySO5s997U8/hi770q6JzQcPVkMlEISsm7l3F8AaAghYyZqEfHFi0/JolZkKXXkFboxNmcMb1sM8HKEk7JAyFU00Cr0xWwhSw2rreayoONYxMSZ1gAq/tcjuAGI7t4bPih3w1EyojsULqVgawzXHp1M1EMH0dxmZLkuKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx4f8RChWmElYB2mrNBfpiiJXzAp+U51Usc5oWYwHsM=;
 b=Cuoe6BPbfYcFwsycnTz6YSW4Td/5QmEZb9BcZDBi0wfC5pYsC7G/kkqpFfI4ZGk6uTlDONk/HNLLjgf1QT9TPqkrCGGWwcgClcj0rVcgYtJ+LSQ2KXWCBUKWC206yHQLATlsnxT1ZIcwoO38NqSkf0OzXsKnGqVr087rsMgWnMULdTYURxTr+p5+n7cwZARCREVVFpGgH8CszNPR3Ad3Jt0nyWP19Fn0LABigFAHdxyjShje23kS8iKO/uHZHv+sDYPTNoA6k9roTIJ2iGRX5gMnma+PW85ztHR+6DQVT1lwhqnzYRBnZQ++GxztdhscDbqzhZ/rJ+iyO+XbO+Ir6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tx4f8RChWmElYB2mrNBfpiiJXzAp+U51Usc5oWYwHsM=;
 b=MsSvVk8NKGq/Ju0J7TflUYIBphSDYgf5X5zxVDdLToXtPi6D5G1rX3cZDFjgyNPBmzW8jXKLSlywLALr1WoAsbNhZobqfFMx7lIDcnv+B3jG6j0IrRNblgxDQWHsZ3jqimV9MndJmetwlaU3nj8NoHtIvKfr51mVSn2hQCKdQus=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 22:42:52 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dc:cafe::70) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 22:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.9 via Frontend Transport; Wed, 15 Nov 2023 22:42:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 16:42:51 -0600
Date:   Wed, 15 Nov 2023 16:42:31 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Ensure input to pfn_to_kaddr() is treated as a
 64-bit type
Message-ID: <20231115224231.xmxfktqcb4sls3fb@amd.com>
References: <20231115201431.820278-1-michael.roth@amd.com>
 <e42524f9-87ef-47f4-9c79-bc06b4d71a58@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e42524f9-87ef-47f4-9c79-bc06b4d71a58@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f737a3f-c274-4608-b38e-08dbe62c33d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiPylsic782ckdf7BCx9BgfkVkQ4stK57C28Kz7lVkbqgcgUsKgWkSb/wywMBQ4ycW5TPDCKgbSvRTaNrtVEN6fy+MKJinvokhn0F4eswV9nHH6J8c9E8j2s8gi9cS9um1I3gxdLlPE3KHrsce05DxEmgJAsTgpA+9RJXJlaTnLk9mK8OUaHYXe86KuOxmmSU/VKHEAyNQd++yJpnuxVlcSxI2+EC0cSLYpAvWTo+ym2Jxd2jKrqZUvGVNmYjuxRFeJ2unJbXlrbmA88NLXU9nQQlmje91cO1dShK/vBO4lDPQq6ZzzVtdAO2mHIY6xBE+TpCWtbYR4D28NiTp5KWVAtjkmXySndvLIKaYRvDJ0yBPdfYTdStxyOE3QjLF7jpHirP3fdrYtHKptcslu0IAaxoimT+1/J1MzqBvmR2q5BilaSnrD40nAmCvIXicTZDzLnEObQ3thT4u02qXm1sbp6IPgvhh70piEWLCOIK6/w43AerAAEUKtgiRP3BJMGcveaDzlvc/tRPclr+fdowSvKKfO3rqWj/sRbO5bpAPqeNQjArPFNrX63ifmPc4GfDMSFtDD16gcFj7U7Ql3DrXmQQQ/ghhtMm/dWm4hoIQDhipOsXH8tmlRzRkLpKp1p/rispZCbz1Oy6MnBouQQdraPt+6UAbBhNJlLAYpNPmzoyksWbbc9RHPwQTig3DYdboyqLHF2zz4tkHGZI9fjaqPF4SecwPyd7rnSd0t+XoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(316002)(4326008)(6916009)(2616005)(1076003)(5660300002)(53546011)(83380400001)(6666004)(86362001)(336012)(2906002)(426003)(26005)(70206006)(70586007)(16526019)(8676002)(82740400003)(54906003)(478600001)(44832011)(8936002)(41300700001)(356005)(36756003)(47076005)(40460700003)(36860700001)(66899024)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 22:42:52.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f737a3f-c274-4608-b38e-08dbe62c33d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 12:48:58PM -0800, Dave Hansen wrote:
> On 11/15/23 12:14, Michael Roth wrote:
> > While it might be argued that the issue is on the caller side, other
> > archs/macros have taken similar approaches to deal with instances like
> > this, such as commit e48866647b48 ("ARM: 8396/1: use phys_addr_t in
> > pfn_to_kaddr()").
> 
> Gah, I really hope nobody is arguing that for real, or is even thinking
> about this as a valid argument.

Not that I'm aware, but I did have my own doubts initially, which is
why I thought it warranted a note in the commit just in case it came up
from someone else.

> 
> The helper should, well, help the caller.  It makes zero sense to me
> that every single call site would need to know if the argument's type
> was big enough to hold the _return_ value.  This nonsense can only even
> happen with macros.  Type promotion would just do the right thing for
> any sanely declared actual helper function.

My thought was that it is easier to expect developers to know the pitfalls
of bit-field types, since it is universally applicable to all C code,
whereas expecting developers to anticipate such issues when writing similar
macros is potentially harder to enforce/audit and could lead to similar
issues popping up as things are refactored over time and new macros get
added that don't take such usages into account.

But neither argument seems to hold up in reality. Experienced developers
obviously do fall victim to the subtleties of of bit-field types, and
kernel devs obviously do tend to address these instances in more robust
ways based on the various pfn-related macros I looked through.

-Mike
