Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD951804D15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbjLEJCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjLEJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:02:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B4186;
        Tue,  5 Dec 2023 01:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifRV/QVGiHyNAipob3b5IUUpXQFMZ3EbgnVsZvkYcg0bo9s1rMiXxMDxPsChpNFD4e7vQMICU05B4S5AMl7brktA7FUDVy5PvqVeHDuH6hoxt5GI6uFJwTBgCQXCGKyDkKygpclMCnKKChf//Ub2ETtsQBcxwE4Wk5nXL1QA7UzB5/7ni5o3Z+0SyBnR+DpjE+sfSPPfUowAI0F+bfc+m+5je0rxXI6iP/B4jnbT2fi9XWqgGO4npWhWTbxEUufqoUTmUO1kKs0HBaERvfBKBPx40+28HQkh67IcPD4hY9x5UAydsUDCvB1nKy1LbFQZ/zk0Rn4I1fkVUy2V+Pp+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYY1dlKz7XRZSHjkJle7feKn+k9Cgkr7NBlAOAoWdKE=;
 b=AFTRGE+gD5wQjxe2HYRFqXd2XSnAySLUW/yo9LlIvl1mfdUtxsuv1QjHqLsEMgfFj+iaePxVWYSHfhRrt1C8fSG6AG+eKX7PWXM7UWSKHDxtfuU+4bLDTFNeP6zohpgZKnSAN5lZVAqCI6ommIiW7I7opPH5s0nVmH2rRiLtOGjGgYnCqPvj326OIz+yu/+E0Zw0kCqKLKRPAG0pDO9FUR4yNn47zEEAgxfPCNV9NoixJghYwdmCOv4oKdHRaS06WvBFDVcdJTRr06TTkISFHilXcuzTTHY0CWoPysiQExOYpob8VAHIR41w1CM4apvQvyO8SnGvBzLnoAexOPt8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=suse.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYY1dlKz7XRZSHjkJle7feKn+k9Cgkr7NBlAOAoWdKE=;
 b=XG0L0iU9PeFPATRUe45PAharioBZEXUDoazY1daDrN2O3r8dc2refzE9BStsWZRwPrljHv5MOw96XWL0DbKYxyBbHagEGXlhcax4yOgZ2qW8UuVnuM9K0sA5pEZtotKXXT5XVHwbJqEUoWSgKia+n6s8igFysm8E9czWIBKUhMRjpykV5E9ndcFz9cHe4QKkfRbIk68P94Pa43j+sFYdevECBpQDsea4O0IPEyX3+5jFAh3vGnAMsSkMqqxj1mIbRHbDLvTBYHaZ4H+r9t+WxvK2dBTPfkxRtQzxyUI2Ja1nWzxgu6W0WrwNaL+YpjzOmIzmHIy9iAe4oUVLHiIiMg==
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by CYXPR08MB9261.namprd08.prod.outlook.com (2603:10b6:930:d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:02:33 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::a) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 09:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 09:02:32 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Tue, 5 Dec
 2023 02:02:29 -0700
Received: from [10.3.101.85] (10.3.101.85) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Tue, 5 Dec 2023 02:02:22 -0700
Message-ID: <8eae7d95-fc98-4ac7-8f83-d0caee00bc87@micron.com>
Date:   Tue, 5 Dec 2023 14:32:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC PATCH 0/2] Node migration between memory tiers
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <aneesh.kumar@linux.ibm.com>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <dan.j.williams@intel.com>,
        <hannes@cmpxchg.org>, <hasanalmaruf@fb.com>, <haowang3@fb.com>,
        <ying.huang@intel.com>, <gregory.price@memverge.com>,
        <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>, <fvdl@google.com>,
        <john@jagalactic.com>, <emirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
References: <20231130220422.2033-1-sthanneeru.opensrc@micron.com>
 <ZW3zl2Fke5FtQCv3@tiehlicka>
 <1db561a9-6984-418d-9305-a2a5ece93696@micron.com>
 <ZW7g4ExYF79gMEBU@tiehlicka>
 <2552828e-6865-4fa8-a9c4-8ed76dd85257@micron.com>
 <ZW7km-SED5oIGGnZ@tiehlicka>
From:   Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
In-Reply-To: <ZW7km-SED5oIGGnZ@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CYXPR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e08090c-9afb-4ec5-04cf-08dbf570eaa5
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pH+rTWh1ZBt0vY8tPoHIkZfCRFBrYu4havX3fg1Mpd550AfzOtKtJt1MWopf2tQP4t1kFFkHj4uMWwprBigOBvYJQXR63bj/JG4pc2/OG3vS3VjUqPwHgeQTRzGXRGykiA91u19ryTI3HASeHS6LbxZjnJMb3xFT1zIOHSlowhBL5EQf3PqCgPpehLVcezgniJkxWtTaaV4nGoWaa6DwYtJFESXIPH2pMZJd+mUocTvS9TKaCns/FG87fmNJquL1PCdg9OpSlFGkIKwH6lB/lS9WBlxk9oGzovtbZ4fK3iOfCQWpkVr/zQMimbcr5jd7Q1D5xxV0FIOABpVRwAqZ09Pi6Eh3Mv6s3+u5wXC6my5HAE8X1xwKruGvae/LDyw0hyMBy2vC4sNFXmCOh5QEWPlsQnnmvpG5pID97QX+OsMw0x//3RFRLbOlloqdyaese1ZR2/nl2+EJdIyYag3rbuRk2Pk43qonPUUDaoedFgJQfc6rpS0hAngzqgJXwmLUhPvbHhJT+GEmBA0umvdiZnIp7E2t8WBeCGJGl4htQr2EnV9ovfzPWKc/A+E8TK1BogroNYaluDVIkl+vIvE6HCl6ZCWDVZa8tJNooUpdfvDR7JaWEUeQQJ8QftXUVfnyylU99xSzkOPvJyCb2gKDUhM2Tu2TgMUDTsxe0KqSPyXEiZapD3OO0Yg6yLRdwrXSkO3iUuY4ccl2a6NqysKpCDBkRwjJQQNC/JKA24hb7OW46CfzWApodkshVwo2p8tPKNqdU2l4b5e8WIQybZXL0CfsB0PoeG6SfklnOaIyq8c/gtGWTDaB6j4ssgJpXB9pombGMUsahmQ2912nsX15NgrGCLNJ8UK+UArxmQb2Lvw=
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(7416002)(2906002)(36860700001)(31696002)(86362001)(36756003)(356005)(7636003)(41300700001)(82740400003)(47076005)(53546011)(2616005)(26005)(478600001)(8676002)(4326008)(54906003)(6916009)(70586007)(70206006)(16576012)(336012)(426003)(316002)(83380400001)(8936002)(31686004)(40480700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:02:32.4101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08090c-9afb-4ec5-04cf-08dbf570eaa5
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2023 2:21 PM, Michal Hocko wrote:
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> 
> 
> On Tue 05-12-23 14:12:17, Srinivasulu Thanneeru wrote:
>>
>>
>> On 12/5/2023 2:05 PM, Michal Hocko wrote:
>>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
>>>
>>>
>>> On Tue 05-12-23 01:26:07, Srinivasulu Thanneeru wrote:
>>>>
>>>>
>>>> On 12/4/2023 9:13 PM, Michal Hocko wrote:
>>>>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
>>>>>
>>>>>
>>>>> On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
>>>>>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>>>>>
>>>>>> The memory tiers feature allows nodes with similar memory types
>>>>>> or performance characteristics to be grouped together in a
>>>>>> memory tier. However, there is currently no provision for
>>>>>> moving a node from one tier to another on demand.
>>>>>
>>>>> Could you expand on why this is really needed/necessary? What is the
>>>>> actual usecase?
>>>>
>>>> Hi Michal Hock,
>>>>
>>>> Following two use-cases we have observed.
>>>> 1. It is not accurate to group similar memory types in the same tier,
>>>>      because even similar memory types may have different speed grades.
>>>
>>> Presumably they are grouped based on a HW configuration. Does that mean
>>> that the configuration is wrong? Are you trying to workaround that by
>>> this interface?
>>>
>>>> 2. Some systems boots up with CXL devices and DRAM on the same memory-tier,
>>>> we need a way to move the CXL nodes to the correct tier from the user space.
>>>
>>> Again, could you expand a bit more and explain why this cannot be
>>> configured automatically?
>>
>> Yes, in both cases above, if hardware not automatically populated properly,
>> in that case this interface would help to correct it from user space.
>>
>> We had observed case-2 in our setups.
> 
> How hard it is to address this at the HW level?
> 
> Btw. this is really important piece of context that should be part of
> the changelog. Quite honestly introducing user interfaces solely to
> workaround HW issues seems a rather weak justification. Are there any
> usecases you can think of where this would be useful?

I'm not sure how difficult to fix it in the hardware.

Sure, i will capture the use-cases in the change log, will be sending V2 
by changing interface from adistance_offset to memtier_overwrite to 
avoid complicated math for finding offset at user-level.

Thank you Michal Hocko for the feedback.

> --
> Michal Hocko
> SUSE Labs
