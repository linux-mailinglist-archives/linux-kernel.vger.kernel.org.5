Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4278B26F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjH1OBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjH1OAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:00:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48902BA;
        Mon, 28 Aug 2023 07:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqVOqSeGeqwU4JPR0YknDF4KfqCsZUTHVYzAMjlczz5igGxqv7nuoDBLjznbXRAfO4IE0RmrchECAeO0LNicE9eNasqJ+pO0bwbNx9ICrjrPYDFE+pe+CrJVaeZ9vIrGf3WNUocHiq2w4AwTu98thxPfC/I+gmaHJVLlCH++1qjdN65OpV+7PfhCnvOMFdPfvX4nak9rwgNaPzku2CbF97YrrzLJGYiXQgCFr7VyWhjc22L79rTBry7YESfwHiuLXKL1ul85MZTVriPYSaJ00/tfvd0XiO8uayirHPCPwKcI1bsX4Nv71obYxOzuZfR39afkFB3giAQx4BhsgZhYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5aeD/kjPJq+SnAlXTcc7LVOz+F90Cp4fZJGg2FA3GI=;
 b=M+kDW0GfczwthOf2p/l14wxMsLvTnaTV2fEszqQWna17tv0cAFc6a0wH8Wx9Ho14OQt3auJt4QwMTROd2HbvWT5i3xs0HcnbQ5UsNR5csoBjn0stfdW5OS4vydfvD7gljJlIxKfsk4nzM64LgDUW2TvoKmN2ImdVfXK/TUty+Nr/I4d9mxwjnS7iTjbiG6Icb5osBa3JKRSfd8yabMaBD7E0SjeKyM7cWmZCge5bhAQebaXt6Zzm/C6plL4vPrWJ3+wd/j6YUI6XCUg+ZYpRF6cY3qvApkYemiEdS3fncs5ecxpIR2TYLad47aBsU1w8qCg04pS41aiPUnQrgFiU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5aeD/kjPJq+SnAlXTcc7LVOz+F90Cp4fZJGg2FA3GI=;
 b=aKpzWjMCEys2ducYb66+8q4PHFQMfM66wiXFEi6uCOhD/iIABfVVlbztCl8j5qbDLGWXjI8OVh8mwQgrs2qeHN9kUunhR0CloxeWPv8FOASF2IHHq5mlP+DLG+txHOHqphydvJmAB7e8R3mLgejUa+2LdsQVZ+ciZmBBEeYVc00=
Received: from SA9PR13CA0132.namprd13.prod.outlook.com (2603:10b6:806:27::17)
 by LV8PR12MB9357.namprd12.prod.outlook.com (2603:10b6:408:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:00:46 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::c) by SA9PR13CA0132.outlook.office365.com
 (2603:10b6:806:27::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17 via Frontend
 Transport; Mon, 28 Aug 2023 14:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 14:00:46 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 09:00:43 -0500
Message-ID: <b477d4bb-8647-f1a0-31c4-2658bfa082f1@amd.com>
Date:   Mon, 28 Aug 2023 16:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] drivers: edac: Drop unnecessary error check for
 debugfs_create_dir
Content-Language: en-US
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
CC:     <shubhrajyoti.datta@amd.com>, <sai.krishna.potthuri@amd.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <shuah@kernel.org>
References: <20230815203826.51792-1-atulpant.linux@gmail.com>
 <723e803b-6f8b-ceb3-e987-4a6f83d89222@amd.com>
 <20230828133547.GA58271@atom0118>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230828133547.GA58271@atom0118>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV8PR12MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d63c58-5a74-479d-de77-08dba7cf2d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/HMuwMdB7zXpV2G+kx3WNL2TU9ewTw1v+I6Q/bVnLh428SVulNh4aMvFsyuNPNH+QbyjhLuYAJEMorbT3r4t8LyeDiT4U4zaM8fGk+pzY2TTeMyFRGSdYkz5u9dBhFqzkIMPT+f40D8lAmitHtl++CS3dW6bXF5LdgBkg3GuitDbXXYyBmbL0vSuwXGRQdZTqaaXu5qFwobfSj24LU8S0T4rCOSKyJ8ZT0Y/dzXEGlbCGova7CPfxnq+wgl1KGB3mK5Atxb79mgyE1LoLM+MSTHiez2nMGlb/29UCFdqyuX4rv5jRzgXPQCWY/UNeLNAD9mPH9LM6fUCYncDXEmA4r/XHUem2eepwC0Xjb/07K/ikOWrrOxeExUtaQzr7rKNnCltVUogYuzqRuk2JjKm92zieAWUesxWoe0IRS2Pbj1yNyMQog9s7KSlQNj5KvtZfr5fVq5ocKXIlV2r6ARMcC7Y+oDcTmlICALEAEM2ZwCTKwlZ+Ot/GOltLvDdHihhW+VzG3krHaT6Ug0RSUNbYdNI5oUm5fagEDF/LptYtWzDNPNeZWWcNffnJQ8q6g5GtcKT9qPIZSEUqWWzYa6mb7uo5Rqm8WVz7Nenh/+MDkaReBK0UQRxbgfGISGZA0Ldwj8iES4VBlPWu5crZgKkReY3OEsUt898CsR8bITiX68ZeRV+MEZuUhI/Ga0x8btZ/XV66iOkGE+LvDBge4CsEfke/acqD6ycokdGwLsQ6sFpnokuEssWQiGUnUpm7RDNA8rROIQ6trJg3AfmCiE9F4PQgjHzjJ0FD8OeihtPtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(81166007)(356005)(82740400003)(26005)(16526019)(31686004)(426003)(336012)(47076005)(36860700001)(2616005)(40480700001)(53546011)(31696002)(86362001)(44832011)(2906002)(7416002)(316002)(16576012)(4326008)(6916009)(70206006)(8676002)(70586007)(41300700001)(8936002)(54906003)(36756003)(5660300002)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:00:46.3824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d63c58-5a74-479d-de77-08dba7cf2d60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9357
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 15:35, Atul Kumar Pant wrote:
> On Fri, Aug 25, 2023 at 09:31:54AM +0200, Michal Simek wrote:
>>
>>
>> On 8/15/23 22:38, Atul Kumar Pant wrote:
>>> This patch removes the error checking for debugfs_create_dir.
>>
>> Avoid using "This patch".
> 
> 	Thanks for pointing this out. I'll remember this.
> 
>>
>>> Even if we get an error from this function, other debugfs APIs will
>>> handle the error value and doesn't crash in that case. Hence caller can
>>> safely ignore the errors that occur during the creation of debugfs nodes.
>>
>> First of all which issue do you have? Did you see that folder is not created?
> 
> 	I have not seen any issue as such. But going by the comments before
> 	the debugfs_create_dir API (https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L583),
> 	we can ignore safely ignore the return value from this API.
> 
>>
>> I am not quite sure if this is the right behavior.
>> In the code there is
>> 135         if (!parent)
>> 136                 parent = edac_debugfs;
>>
>> It means you are right that if creating ocm folder can fail and properties
>> will be still created under edac_debugfs but is this the right behavior?
>>
>> altera_edac/armada_xp_edac/i10nm/i5100/igen6/others are checking return
>> value that's why I can't see any reason to remove this checking from one
>> driver.
>>
>> If you want to fix all please send patch for all but I don't think it will
>> improve situation and it will just hide different issue if creating folder
>> fails.
> 
> 	Understood your point. Are you suggesting that we should keep these
> 	checks as it is, or should I fix for all the drivers and upload the
> 	patch ?

Up to Boris to decide but I would say keep it as is. Even debugfs is not stable 
interface I would like to be informed if something fails. But just 2c.

Thanks,
Michal



