Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C117880E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbjHYHcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbjHYHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:32:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4302107;
        Fri, 25 Aug 2023 00:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1xNIivwvofwrx4sVu778PeLZh1HucAFXL2EKN1QhL/IiZX/wILZHoD0oellN6j/kLuBQQY4ei+Me0/kF6FfNBz64QiE6nWBpghqDCJkZtThXd1+ZvTP8Aer7v1yz0aS+8KWPL3g/80WjGKMXaizB5e+ufNRNTEVFOvvuZ+rpe7LHSeHi8dMHJo3adl/Y5sEBoL7m+Od7yeuNo5dP9CZKD+wg8LccHcdNshZWI4nZjI3WOVWq+Rvij2kwZd8VU3MdyFAeg2/jzozXcoNI1F06Qj8l756eP/AkV8dz1Z9dqpbRfldBm1EF9k0E0jHJl3VyPGM9gB6gHVVNoo5EppPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7gWHOERltwEvhu+GagdNTnLMHjPI3gAWHWiaCYx+Ws=;
 b=UdJH0iaSTiXJ8FMKPFq9eLY6mPlYBz1Kw9EGB4j+OrISocyIpll5vU62O/zlB/dS6hMSl2fwc+T+6lw3mI8fy6+vC2uFzT4sbtf19vEWmEv1ZoCc6qNBMudW+IP3gXfay77t/9sCAy/DPq8zp8y24Yyr/OByynEsFOOz4IyRBAYkj0Wim0Gt2Qp1R26mIcT6vqYlG1x2ZsA3wlw8G2CDLCAOdjC00Ela8bVy8rQCVHD42ODPtHMgfKu1IexnRHdFlnNzA8QRI5AOdslAII/XhkfnYhAPsE+yo1CWw3yABRZGYKNQ5oSbxLwmZ5+PsDOicpP4sEuMBEHLIAHZeX0VRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7gWHOERltwEvhu+GagdNTnLMHjPI3gAWHWiaCYx+Ws=;
 b=Sp+XMwbecxfQ3OdxDgMj+u6G29WU/bXnouJlPZImIHXBdrzRA0a51TAANZDWYQOHiDvsdLAvdijK3uRvWYjVnJYXKuSsI0MxxlZz7bu7F+7/vMtlnjK2VGRlHU73pi2B/TAiD1RUTVk3yChTKOEjPlTjWZInj35w9cd/F7cBJW0=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:32:27 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::ee) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 07:32:27 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:32:17 -0500
Message-ID: <723e803b-6f8b-ceb3-e987-4a6f83d89222@amd.com>
Date:   Fri, 25 Aug 2023 09:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        <shubhrajyoti.datta@amd.com>, <sai.krishna.potthuri@amd.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <shuah@kernel.org>
References: <20230815203826.51792-1-atulpant.linux@gmail.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v1] drivers: edac: Drop unnecessary error check for
 debugfs_create_dir
In-Reply-To: <20230815203826.51792-1-atulpant.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 084e0b24-a194-4377-01d1-08dba53d6ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VERokFrkqcSl70j3CnVWGKE1z99qf/Mx28q3Rc969GLqrzAIBJXeDa4AhEgepXJzVl7PNF/myEfWQFckvVuEMHvh9JfPvkzduagR/xex++AHTVXLbv/IrQwFDvwoviQLM+fUiGz/ov7Tp0Fe275bhJ9e5HEp6Rhibllh/ivtrK8RoE/gdkRLd59If8GRCwWo3tR5Jy2ByaFYAPx4+6TggYOOZp4k5u8ggPCq+USHiY1+A9qHzIZgXS9HaeRwG3v/zTvsChKIfPIeM0JK2al98kuyaEHQVRHeyDh0T6/31VCFnsf+A+tlmlNOWUpD4iDufaMvDE4OjiCWvpjDhuUTu7xI70kMG/R9T1TOWwuadz6CPdrHa4cy2U6VX/A/duZZVQuQ1+M8rgiTyIA2oR4BBSqB5Igr5S5XXwOGn8pLvvZ+LupAjuNnNqt2T3bTYp2pwy72vj/SocdwzshqTtwDEiVpsGKwQbqpOzWXekEojNA2sJ8cfShsG5LQ6f2UbqHlHIw8JXf40gxXljOpxvZzJUO2AeHfs/CzIaDs5IR3RBBl/s6lAlTGlPip9GO1lhJPWoGrTSJKd/DJsJULUp8BHdNUbe6FAFZsfGYmfFKaTC31wju+UGNdp1U8EgOl9DTyco2SuLHbFsyUNNb6DtYXG8hQ5HecjkLt3Bg7VfAXPKPrU2dwevpnEE4PcCaAZof0uj9/0a4rLyOxPHHm/l7uQ5zX6HnLwtDETkgJ/b4FSgsQy10Jte3lg9dy04bOdGpt6DvQs9KStOW0DnC7cIB1cvwzJ+jbSEKn5riwrc+MdPTwh+EEfV96VHQ+iz4BMBoT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(54906003)(70586007)(70206006)(316002)(81166007)(16576012)(478600001)(110136005)(26005)(36860700001)(44832011)(356005)(6666004)(16526019)(40480700001)(82740400003)(41300700001)(53546011)(86362001)(31696002)(2906002)(31686004)(4326008)(8676002)(8936002)(40460700003)(2616005)(5660300002)(7416002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:32:27.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084e0b24-a194-4377-01d1-08dba53d6ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 22:38, Atul Kumar Pant wrote:
> This patch removes the error checking for debugfs_create_dir.

Avoid using "This patch".

> Even if we get an error from this function, other debugfs APIs will
> handle the error value and doesn't crash in that case. Hence caller can
> safely ignore the errors that occur during the creation of debugfs nodes.

First of all which issue do you have? Did you see that folder is not created?

I am not quite sure if this is the right behavior.
In the code there is
135         if (!parent)
136                 parent = edac_debugfs;

It means you are right that if creating ocm folder can fail and properties will 
be still created under edac_debugfs but is this the right behavior?

altera_edac/armada_xp_edac/i10nm/i5100/igen6/others are checking return value 
that's why I can't see any reason to remove this checking from one driver.

If you want to fix all please send patch for all but I don't think it will 
improve situation and it will just hide different issue if creating folder fails.
And debugfs will be disabled in production system anyway.

Thanks,
Michal




