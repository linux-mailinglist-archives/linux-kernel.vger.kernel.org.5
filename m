Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29878B00B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjH1MZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjH1MZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:25:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720EA0;
        Mon, 28 Aug 2023 05:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSSzz6bJvZNkQ/ywPaHWEHKFdmGtf1ilEBd4xuJchxEFMcfIaXNkATnl09F+XcdUN8LKv5LwIpfu3c0wgwn851r75nV9dPZG2nam8Aabz+v//WCvKqbD7pdF3R5FfwPzqAnajsAQwmTLIdOPD0kx8RN6dInp8GeQ47QYWkOs2w5r7mEJBKUDUMGydz/vtxNH3oPM6WCfUsP48m43E+wy+E/oVJXwIxCGYjgfrEeJ5tJfLiWkpZtwtKBbmY2MC4z3lGosS77yaHNvzjkeZ2jfBRtlhA8/jHKG1H/6NLxt25SJAPa+4ZkJlh3AAQsDMBWotyULuzZsSYMiwdcTrCpRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GvjNduzca11dkiU2MJUPk4eiY9eFQJu07tgRiUYnpE=;
 b=WyxTZiSxPbtTzhSgybdpKMgDCJIP838BVKebethu7CK85Wwz6zJaqOS1hXvuDjyKw+7s6Gs4WEz1y7gtQHJ9P/fXyaf/cQg7zPNytBA5fkR/Tt3cBULY8ZP5LSxHQ7+ezkPfuKO2L69gyZlw/zBj58FDGLct+blXTZzWMuxNaEVEtcuR79XERMpyywW7e2lk9zHRoGTR96CtWPl0vYBK4Jz9ICGb/gTqdogm/nXPEHNqZkNKWZ9W4SDmPEAdfUvrBQDm9R0fKL/uHCvXyBuVLqXl4mwYt+hCvKsITo00hgouniVG8IR/IT8gvd2wRmm/NEilowU78kFwuFOnc8udqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GvjNduzca11dkiU2MJUPk4eiY9eFQJu07tgRiUYnpE=;
 b=D3Is2L1vomeZJB0etfPmQyHWgGfcC2+VqugWSTbJ4Ipl2pP6fZdxqtmOb85wVITGYxHEjSm2rAl8VspgW0QWJxAWCP9j+nCCt+yMwhbpxjGqy1x355gJsb6OdPKnrIbNB8Pdw+XVln7d+fdFntLatyJUAHLrffLVKvnSoNeNU16On5NaCEb+OBugxLJscWD8sr+TwD3TsFu6HM38n1D4s7XECFSf55SunoqIXfQEIIsOtxbkkE/rTTAerPpuoES7FLjxMZM9cuTFEKl5BvejixHlRf3d03swEHznvnETWj/bF3zJw2732HafTlp2ncNNLmpWSqDMV1FgTziGLvW2hg==
Received: from SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::12)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:25:17 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::4d) by SN7P222CA0008.outlook.office365.com
 (2603:10b6:806:124::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 12:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 12:25:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 28 Aug 2023
 05:25:07 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 28 Aug
 2023 05:25:04 -0700
Message-ID: <d3318a98-4d61-73f7-07ab-787624edfdcd@nvidia.com>
Date:   Mon, 28 Aug 2023 17:55:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2] cpufreq: tegra194: remove opp table in exit hook
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>
References: <20230825111617.8069-1-sumitg@nvidia.com>
 <20230828061115.vsepgtexyv3hvffu@vireshk-i7>
 <20230828101721.zq5vlc53p5umi63c@vireshk-i7>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230828101721.zq5vlc53p5umi63c@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: cef37d31-1716-4158-8ec1-08dba7c1d696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXDiUIMo5ZE9yXqkECl8akXrAeJ+H7TSI7jf1zu+7xeKW4V3ufpRKY2wag9hGkQoibGbBfK9jrz30CTz/GvTnEzxE3r0aFOP3FRwqWdoRaNs9CT6uF8Zuw2OrnPQrgOlG/XoYNmJijS6F2L36uLyKGvCY5rjZnBNydniOzZaSyABjEjaVHV60WUXlwGv4ezwNDVivgT+IQ7f5pQCwD6gyVKBjaXZyTXaq5zSMoFlPSvnHYlnfdNeU5DAY/G7iE/uNW06q5/UsQ8vPyUJa8geYK//KirpbApEsFpChgarQDUx7flKaCzfy8Hbx4xA7lrw+b3UMWWxFlaHuoEx6figJMybn51Qv9Re0GsrG6TzcyUzTy+M7EZ6Hkkdzzw47LMVJBDBRROrbw2jy+PnE9EKebOC50RRgm0C5o6L4v+tUCRsRMdAY9JY6hlNtG8BFr2v7WhhYCbKdRFSWrcofm5wLvozbPb3100kW8UlohuCAGc05oATcuclpmWxEBL0+uNYCTi/htALw9acGkbWJpKrN4kEcUWIBqoHPlI2uiClPBJU3R00xCOARD6wWcjkSuefwqvx/Vbngim4DLXSaQNNV1Bt6lnJHAfsJ/szy10Qh0tDht8AW5lsTlNR0+F7RkgQNwLfOQJjWzuInXdsrQSV9M2C0M/JgVVVH4a8YAsqNDm4/xEBbmE0Wf8XfHtfjBwf/pgmhIorVJgV+solk+HeMRC+NLqm0BIv28xUsMwTC+mKHw8n87Nsma8qPcQPvPF+AH67oD4HlxVrKIt5K22CiwKTe5RYMqVZTVI6IWnaOZcG4LXlAd1OkIwLQ85U883p
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(83380400001)(478600001)(7636003)(356005)(966005)(82740400003)(26005)(16526019)(31686004)(426003)(336012)(47076005)(36860700001)(107886003)(2616005)(40480700001)(53546011)(6666004)(31696002)(86362001)(2906002)(316002)(16576012)(4326008)(6916009)(70206006)(8676002)(70586007)(41300700001)(8936002)(54906003)(36756003)(5660300002)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:25:17.2368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef37d31-1716-4158-8ec1-08dba7c1d696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/23 15:47, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 28-08-23, 11:41, Viresh Kumar wrote:
>> On 25-08-23, 16:46, Sumit Gupta wrote:
>>> Add exit hook and remove OPP table when the device gets unregistered.
>>> This will fix the error messages when the CPU FREQ driver module is
>>> removed and then re-inserted. It also fixes these messages while
>>> onlining the first CPU from a policy whose all CPU's were previously
>>> offlined.
>>>
>>>   debugfs: File 'cpu5' in directory 'opp' already present!
>>>   debugfs: File 'cpu6' in directory 'opp' already present!
>>>   debugfs: File 'cpu7' in directory 'opp' already present!
>>>
>>> Fixes: f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth")
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>
>>> v1[1] -> v2:
>>> - updated commit description.
>>>
>>> [1] https://lore.kernel.org/lkml/20230809153455.29056-1-sumitg@nvidia.com/
>>>
>>>   drivers/cpufreq/tegra194-cpufreq.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>>> index c90b30469165..66a9c23544db 100644
>>> --- a/drivers/cpufreq/tegra194-cpufreq.c
>>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>>> @@ -454,6 +454,8 @@ static int tegra_cpufreq_init_cpufreq_table(struct cpufreq_policy *policy,
>>>              if (ret < 0)
>>>                      return ret;
>>>
>>> +           dev_pm_opp_put(opp);
>>> +
>>
>> Missed this earlier, can you please do this in a separate patch please
>> ?
> 
> I have pushed rest of this commit and dropped this part. Send it
> separately. Thanks.
> 
> --
> viresh

Thank you.
Sent the change separately @
  https://lore.kernel.org/lkml/20230828120959.24680-1-sumitg@nvidia.com/

Regards,
Sumit Gupta
