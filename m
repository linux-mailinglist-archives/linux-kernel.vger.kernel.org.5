Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE57B7E37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbjJDLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbjJDLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:31:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C3BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 04:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpLLmtAQsDQzekLM/BhVjwsnlzBqqqgGz/a7W/irUjDhWDECAnRTyLvgNN7SZjI6J7abZGgXP1kyjlfpLGKoyxzMaBsLaJ6tQNCjYMN9W2w2/hzmUS6k/BDykDMTPkLYmoAoUwNufyiH1gVH3TkUd0h356XYXW5KjUXrhMDAxYnLavNDm0UK7UGiDBIpD10M+TtUVqUMS4GVGSY3zD4Al6lTsz0hcAd9yaB27j8qae9Os8Lmm+Y7mXfEZ60qh2J+A9EFn3vyRorhZHU44eqZWUxTAWD30Tqhab1U+iST/Zc5i8a7QlG1ccRddgtecVmM61jNH8UO/yqkEZupDD2sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqL5moVqhgXbiMYfuzGwDiT73chj0LsY/YTXfAlYhpY=;
 b=DvI+PxCVrX2od6TIT/7Tun40LHKAE1OpfSdSKrnkPqVShXBCLdJNuQIKeSKQcddQNG0QpJNtZ62juKUdSO4ckLL4jv+fJUokgj3UeNCV1R9bbvTvjhNPR8rc1kN4kOo5vswBpRXWq3G/zTH2xw7J6biDF5wXOxu7LlxSE2BIwKKLk2tENiCnORb+4X1sctlZVYiLQB7YGLFELaGHkdDyit/s/MHlzk33NwdCAv0bSM/z057n4aabluc6k8FSiKzwJG8/9Zk25nqEdKJbu2K3wNeK/sxLm12le6kyhK2j6iJmlaSppVygDr6XPdhSqx7LJJFZng15a51QKKPVYGWx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqL5moVqhgXbiMYfuzGwDiT73chj0LsY/YTXfAlYhpY=;
 b=d/LAd6lnRitBm1kz8EynR0/92Bag7pdLu9/84q9XbL92WHY20xooMKeXmRFOLU8W5nw4JpQsCKdPr10eSv6JDLvLCtXKUmuWs/RVdgCCpVleYnL0lNW7/EmP8IUnpu8pfvhGsTZdf/Dl6LP6gXdlzuFiz5CIRtP3QDJ++F7QH0M=
Received: from BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) by
 MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 11:31:35 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::23) by BYAPR01CA0021.outlook.office365.com
 (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Wed, 4 Oct 2023 11:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 11:31:35 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 06:31:20 -0500
Message-ID: <ce24e662-84dd-4e72-8cb9-737e68349b2b@amd.com>
Date:   Wed, 4 Oct 2023 13:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] update for versal net platform
Content-Language: en-US
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, <tanmay.shah@amd.com>,
        <gregkh@linuxfoundation.org>, <nava.kishore.manne@amd.com>,
        <ben.levinsky@amd.com>, <robh@kernel.org>, <dhaval.r.shah@amd.com>,
        <marex@denx.de>, <izhar.ameer.shaikh@amd.com>, <arnd@arndb.de>,
        <ruanjinjie@huawei.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: df2a51cf-ccb5-41c3-64b6-08dbc4cd7765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wriY/HMaBIRfXeDq+8q/2TAe/r76joqjwrD/PQrLdSq/2dHQ+1V2cmzim1o08Tk+vyVcI8KpTdXUFkYA3g0B1ioh4Pf9FKnWqKMk9Rw74HONCMFSJmVfAUrAisoy2B+IzY4oej60YsxKdEohHA5iTUP5jOZ0sDXSW2Kn5fVXd6uWgPjWIUkZI3ZAk7AoCjKhFEjFD4+cyxWbVDTXhR4Xzyw8k+Px9GJ4E6kS1P8zmsGyBK6A0McrTLXWpRXDJTgoc9rKxfI0gi2JepkOHE8tOf9ZbfQUxE/1s1ivohbokAH6RHmGpml6vL7Opx9Lu15uba4HxmpaPT6c3dH3sQIp3mjgtbS/MV+O7dBc1YLOeIsGaYLwMbfCONbueJOa6U3PN3JZ+Qodb2umIn+nP1SpwPFATUDf7+QFs7Kj1EuXaZIvFWn4C4dZXtVQljFGWQdhEA+SjaFvC4u1qHTCZNWg6RBWD9zfCSRuRhuZuS8moLLXOhEu38jwp/inbM+mNr7FonxGtI8F9F+Zn2W8XvYehDSMwhMT749giPYdY23yeOzYcxHsPQYXY/FQqV5MN8SVnPPFJ3LNYTrQBLxzgPcy1tORoCEBQ09yF80zhyVO/B3hb8mx3iGbInHRV9jCeZhdDmtTIl7wSBkbvNeS76j1W7vMyRMUQJgaLpxJ739MSLfqmHsaeIgWPMLtOPgyapkFBet1kmH78jbigeAqwHsjoZbQBsCyJ1TBY0WfQg6Fum7iV6YQAZZVB24vLAqd5CPYx7xxO1xPms/Erh0y0H5eSWG+IIbwCekdzbZfoAgDHjDjHeAFUcIHBDIPI7MtDjJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(110136005)(54906003)(70206006)(40480700001)(70586007)(316002)(16576012)(36860700001)(41300700001)(40460700003)(44832011)(426003)(336012)(2906002)(15650500001)(53546011)(36756003)(83380400001)(26005)(5660300002)(4326008)(8936002)(16526019)(8676002)(2616005)(81166007)(82740400003)(31696002)(356005)(921005)(966005)(478600001)(47076005)(86362001)(31686004)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:31:35.1811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2a51cf-ccb5-41c3-64b6-08dbc4cd7765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 11:41, Jay Buddhabhatti wrote:
> Update firmware and SoC drivers to support for Versal NET platform.
> Versal Net is a new AMD/Xilinx SoC.
> 
> V1 patch series link: https://lkml.org/lkml/2023/9/29/308
> Changes in V2:
> - Removed below patch from V1 patch series
>    https://lkml.org/lkml/2023/9/29/313
> - Corrected maintainer name format in patch #6 as per tool requirement
> 
> Jay Buddhabhatti (6):
>    firmware: xilinx: Update firmware call interface to support additional
>      arg
>    firmware: xilinx: Expand feature check to support all PLM modules
>    firmware: xilinx: Register event manager driver
>    drivers: soc: xilinx: Fix error message on SGI registration failure
>    firmware: zynqmp: Add support to handle IPI CRC failure
>    drivers: soc: xilinx: update maintainer of event manager driver
> 
>   MAINTAINERS                             |   2 +-
>   drivers/firmware/xilinx/zynqmp.c        | 210 +++++++++++++-----------
>   drivers/soc/xilinx/xlnx_event_manager.c |   9 +-
>   drivers/soc/xilinx/zynqmp_power.c       |   2 +-
>   include/linux/firmware/xlnx-zynqmp.h    |  15 +-
>   5 files changed, 140 insertions(+), 98 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
