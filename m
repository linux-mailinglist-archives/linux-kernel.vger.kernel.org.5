Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D546804CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbjLEIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:42:27 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2DD3;
        Tue,  5 Dec 2023 00:42:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmEF3YGCyFUdEuAzidXP7gwXJui05n/Fgfy6nxIXRoxtbGvYrLYabCdT7mn/dMSADiqjuRoDfNOyghspbIwU55lAs4OrZ6LEzB6yoRzdrJRPim0czkvDQjTx/BfAZK9K2e7CKcIg7W5Hz4Ig9lnbGopw1zLED22qtYqFn6Iw+1xe+Gw30U109npiCK3f/C99PmB9LxNLCz+5BgaxFxRR7XwDKUUlAvN7J9xwJcbub9gQ9SOCR8DKH+eNgYJWNdSe0zOCkaE1wiqmBoMN2DKqXHnKKY4X8/RNzjz+PBIkuPLF852FoYvr7GebnnqQs+ZfMe1oy3WelhbxMf9HaB16WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r2kKGVp+XYl3zfMpQaQhPsbOW9XCf2yDig0v3uMkO0=;
 b=KIujEE/IS/qfmpidIUbAVAg6KLIpSZyq9LoGVUvbKcajPIUvzi7bgd2exd4Kk9kKaGgz757/SYFmtqK/2Ipmqo3p+y64O40vfFe/bF1wVux+jbWYAUuPVlP1K9DpDrZK71goPEIRj6gtQT1XvjsvBso18a3O7Gb2TPy7ryS2vo8pvCV3g6CuodLAXSPSxgyJ6JrNUM8+UNMDMw3vDZd1RWQISEtn8bIQ17Xzwymlk2qImEJ6D2LwAyyU4aXSPhBCf6QzO9fs4G74t02iCxKUfuXwQhGpR+n2kiKjukxiIHOwXyRZFl+AtnscMn22CtvZlOheIs/VuPvlz6Tkgry1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=suse.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r2kKGVp+XYl3zfMpQaQhPsbOW9XCf2yDig0v3uMkO0=;
 b=X9Xx8bSqeUnItSAphgE6QSDSXnLAbpvWlrYzEkCoyX5fw9oKtgIwPQPeZpF5Z8qgCpfU4NhZc0EIMwSynRmJ/twexcQUWjd4b9lp9dt266a0C8/YA6IXNzcrf2kM9PjUW+4GzVsQqVwGgxtWsHzrL3p30PgSBzhDxa6KXMTnu2tUj5QwDyvXgZ/rSABc9TMUci1PgBfGnt/hvyMKmNvb+o7heAkWn4nC47HdxhEBrOHheLSL6nbySFU+aALpwXotmTx1hmbktsVNa6buHQipSLTe7svakhXq71LMhn/kqLLVps37uVMBGPmOpou31rxaEacv/mfVchGt7D3zbhbL3A==
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by SJ0PR08MB6717.namprd08.prod.outlook.com (2603:10b6:a03:2ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Tue, 5 Dec
 2023 08:42:28 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::3) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 08:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 08:42:26 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.27; Tue, 5 Dec
 2023 01:42:25 -0700
Received: from [10.3.101.85] (10.3.101.85) by
 RestrictedRelay17EX19A.micron.com (137.201.21.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Tue, 5 Dec 2023 01:42:19 -0700
Message-ID: <2552828e-6865-4fa8-a9c4-8ed76dd85257@micron.com>
Date:   Tue, 5 Dec 2023 14:12:17 +0530
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
From:   Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
In-Reply-To: <ZW7g4ExYF79gMEBU@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ0PR08MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a080d3-c46a-45d3-2715-08dbf56e1c14
X-LD-Processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYwp7ZKtzecaEQ1PhczekeY12ZNUH589G5s6/ne3w0SLyShUyvY4f+kiSmGs2nYXHcoVoqzAD7bthFpKFhbgs84GwNPqvRjwDFpHQVb70h5KDTmymlywiimfuwOv6aHXfTBRUBtd8XndTFLd4I1X8NFYBn1BRfq5dzBpDNU8SHYpuQXmamUvt9fnpbwSSDUeVY224Lkl26PzNEtyXC+92dZGKZMkkaPmA3mTcjB7SemFfZJO8kcnbfOVsd1NvsS93x+T3ylBqu1z/p4+JSJr69j5/mcUyIG4wdP6exV4yFcxLH/qla8247WXgtlzLt/HJq0MdSfGWIDcrWxVSv0aMjhhscrYXZG8VzWqVnwCjeJhWd8Ia54p0SFfTeUxoda1/nshQmtpUsUpRrUL04o+OFRvSD46gt+OgKRsGm7/2q+HAUAVM9oU+GuEQv/cBb6Bp4AV3M6qcXI9avZgll8adZ5xNdrHSILsD9EGvWqy4Brog5wprMr5fBT8faS6SEYxqliIV59YUKTgNeVJlz0nXeq6u8zCJgyoNPSewdxt1eVSMqzZYmoq+HbG9sC11xTcoT5ZboNTHxB5ak8tRKGYSvF7aF6wps67Y1xjoUVv8nhBA8spskAEYEbxAwQm89MhPdE2Bk4W1QWcX5gcy/3ylnGK7dl7zdORVlDY20qYNM5x84eFvl3Gd3VoUuRR85YSmSzrvZ9hoh2LAjR7H8CZet6rmIKFpVRG+yXTfYlpT0x7JjQBddcr5fdJPi9j08DN3JcJKVwLbX/GWVB+e0UlgA2gcCec3FEY5wjmKG3vHuFHQysFnm57UPXJUrHdrJqbU0ORfwOMH1UcN2PQJXGKd/VEBj7J2D6dtr1QqUeIxlY=
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(46966006)(40470700004)(2906002)(31686004)(40480700001)(5660300002)(7416002)(40460700003)(82740400003)(36756003)(36860700001)(4326008)(478600001)(426003)(26005)(54906003)(47076005)(356005)(336012)(86362001)(8676002)(41300700001)(53546011)(83380400001)(316002)(6916009)(16576012)(2616005)(8936002)(70206006)(70586007)(7636003)(31696002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 08:42:26.8410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a080d3-c46a-45d3-2715-08dbf56e1c14
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6717
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2023 2:05 PM, Michal Hocko wrote:
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> 
> 
> On Tue 05-12-23 01:26:07, Srinivasulu Thanneeru wrote:
>>
>>
>> On 12/4/2023 9:13 PM, Michal Hocko wrote:
>>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
>>>
>>>
>>> On Fri 01-12-23 03:34:20, sthanneeru.opensrc@micron.com wrote:
>>>> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>>>>
>>>> The memory tiers feature allows nodes with similar memory types
>>>> or performance characteristics to be grouped together in a
>>>> memory tier. However, there is currently no provision for
>>>> moving a node from one tier to another on demand.
>>>
>>> Could you expand on why this is really needed/necessary? What is the
>>> actual usecase?
>>
>> Hi Michal Hock,
>>
>> Following two use-cases we have observed.
>> 1. It is not accurate to group similar memory types in the same tier,
>>     because even similar memory types may have different speed grades.
> 
> Presumably they are grouped based on a HW configuration. Does that mean
> that the configuration is wrong? Are you trying to workaround that by
> this interface?
> 
>> 2. Some systems boots up with CXL devices and DRAM on the same memory-tier,
>> we need a way to move the CXL nodes to the correct tier from the user space.
> 
> Again, could you expand a bit more and explain why this cannot be
> configured automatically?

Yes, in both cases above, if hardware not automatically populated 
properly, in that case this interface would help to correct it from user 
space.

We had observed case-2 in our setups.

> --
> Michal Hocko
> SUSE Labs
