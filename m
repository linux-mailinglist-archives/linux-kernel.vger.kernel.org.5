Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF41810E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjLMKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjLMKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:35:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E547812B;
        Wed, 13 Dec 2023 02:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygfg6hkyLsZtOvAvAG8JQ7fb9KesUajYU1VHFgpDIj6JnqVyCJXBGgWy85q0BuThU0nha2qxKHNJzKxiOrtsIVXWqY6zvi7SGQRSkXfeIoNBn9/Ey7InVQsl0L3V2Y7FX5DPAK+Ym/np+uyeHRazjVI+WcRYNekR8M6JI+7l3DCiZBoDq6F3ik4LfKcuR0ZdJ21ZsjwFKvRV4Tzyve3DNCXBDJm93rbBkDrE72TjFvhPqRK5gQC9Bq6NpbsLBRsTAlrOPnyufZrkBMfIh+Op3H1dlHkm5Q+DjaAsPC6/hJJLwo8c8BR6H14JxADed4uGpPpcMQ7XjYIlT/9D1pRS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJWm9Rx+UtwUZYZFJkczuFMdP7EjzEq2ZomOQRsasbU=;
 b=XhKjRMhrmxCghHt7o/Pr79QH1ie3dh6UvxWjdBsHdQrvvPR/pwZX2pyom+4RY/7llUvUrBV9H2lV052iERomtBiBxXXHyZMMBtlnG1SBDcetQijzoDhcEEtZCyGy+kv7S8rjCJG7CRKsKzKIBzL1B2CVIKWVT3iY97TCOjxbElvX9uh0JRTpa5f4Ac6IResPHAWQeKcOQhi96AX/0GPvyQvewYh7/ZaW8KBz8Q1UaF3RE9xFxdkGC3UVqywLrbw47OHKA66jBh6nuKqN5KxaLGZdDxgbo5BOU/YBQmapC3T5qjKDWLE4/0zDM0BojBequ+GZ5DUt73R8Ke4R8VQCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJWm9Rx+UtwUZYZFJkczuFMdP7EjzEq2ZomOQRsasbU=;
 b=n4dmVWyRbLZpLmczzUyTYl/wW97IEOBWbi74rcEIEAh2yLY1Fzjg9JRatNoLb0ACiVwqXHq4+TDlB/UF4pMUfJgpJuD3I/b/Km9XWsAxxUspXQnKCWjGuGeS30W9qACP77hXNeQ2Ths1zawSBHzLWg/6x4narJqNWRACt/1RFeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 10:35:06 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 10:35:06 +0000
Message-ID: <adcc6446-8c30-a258-e19b-76fca2c50d21@amd.com>
Date:   Wed, 13 Dec 2023 16:04:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <20231213054914.GI1074920@black.fi.intel.com>
 <20231213061805.GK1074920@black.fi.intel.com>
 <20231213062306.GL1074920@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20231213062306.GL1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::10) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: bd63527b-82d5-4077-ec11-08dbfbc72bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ1yueQKTDarkYS34B2LhfUJGWOZ7XQc70uuVXtZgiBQvooL1oJW2qGy/McUYewwBGObGb36WP8y1uWXHirHbNI56fM0NFcsxQOchrJXlBKVURIKl17vLQIlR306231obt6QcHdv92lAee8G/qSElcy3/udv6J27kV63VQ9LCObDdxEeZeETp2ioaGTRnRDFJgLKu5bvs3b4C/iRMZPU3gXDWAzBNAGZ3plzYyN+HEPG8UEc3Q346CPR7GQh2R6DQnqwOt+ugSQn5iXN7zxMijIJxqp1pGpqn5PkvHDOnJj9nMQJivojlQk//5bNTxYrkYxYuBaloguDdHPK81OX23cURVmBFFxNKCPQxLxn3O8HBrHjqaPJgnPAwh4eJT5dcNwYDMhcR2rSAHNmK/vPzASpi7NRzKZYsJ9eST8uaR1Fgu7BO/mhj20M/7PJe045qAFMg74qdv/W01jyChUhj9C7GcGDcwkP1smcOX0MhmBVL0jNEarFYESJhsEbaraNrxCSRvDsr2BNLTVYALhAMzgSUYeKZ3bX96GVpdO31bbCaoTwf/uBV9PS330zWQ0cdkC1ndEFkTfXDyQaFGfoB0MxoUmG7AvpU/a11QOgzmFPs4jYq/9J+dKT2pc55rYJD506YtR3cnOgN0ITB6imLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66574015)(2616005)(26005)(6506007)(6512007)(6666004)(53546011)(83380400001)(8676002)(5660300002)(4326008)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(6636002)(66556008)(66946007)(110136005)(66476007)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTdRUU9oSjZRUG9CQzNxem5CZHZMcUx6ckVmNVJ5cVJiaUMyRUR5L256a1dx?=
 =?utf-8?B?dHJTVWFrYjd4bVZaRllNSTFRTnFGVFJkK0hRbWxaOFAxdUdKRExEamZ1VlA2?=
 =?utf-8?B?MkFCcE5uckhOUGhnZHlRNE9GaFNzZnU5T1h0NVBXUnVBNWRHcUgvTno0Yys0?=
 =?utf-8?B?VUdKK1MzUUcrblV5WkpsZzU1ZUJ0c01SczlUNmhwNFFwdmk4dnBYd1oxUk9l?=
 =?utf-8?B?QzQzYVFRWVF0THJYWWFLbU1QYmVKT0JpTmFYTW50U3VIUzhXaDVUUktiT3VN?=
 =?utf-8?B?YmhaVXRGZUtZaDFOVGlDNHpqaXVxN3pRdkFpYysxNWhub0ZqdWdlNUkzUTF2?=
 =?utf-8?B?U2FXWE96VWY5bHQ4WDdabTJaMFdBK2pZWUpDQWt2Wi9Qak1VZitEbkYyeFlh?=
 =?utf-8?B?UXFRc3hkM2gwWWxIWktsRDZkMW1YZTBYRnZqM2QzbVYvTGlNU3I1U3pHK0lR?=
 =?utf-8?B?b2t2ekVCTVhJNTJ4ajU5dGZnTFBxVkxSYWZKNitzaXhsV2ZRMWpWZGFtcVN2?=
 =?utf-8?B?ZlNpRy9TMEZVUUJ6TDd4TGVPZGk5eFFSZ3JSL1VXblBIQVg3aWd2dmdQQUtW?=
 =?utf-8?B?S2xaYVI4TkdRd0lZdU9TdTZHUVdpbzRVVVpGczBWLzVWQ2VvdGxia2pWNTJQ?=
 =?utf-8?B?T3dYOGJCL3BBbHkrckpUREdtRkV4L0pMN0oxd3JCMy9NQUFJK3V1YU1Jd245?=
 =?utf-8?B?ZCtuQVpkUXVXdGE0ejFpQnpMckhIN0dhSjFWWU1ieWxVelRmeXdsS0pDcnlp?=
 =?utf-8?B?bU11bEJQa2cvcHRIcEV3TWtIb3ZBZzN1NGZXMmxKa0VjOE0ybXdxVU9meDZX?=
 =?utf-8?B?VExOVTZhdnZWSEhUQTdFanBib2VhRCtiaEIxaWNuT3NUdDh0TXZpUHJMdTdP?=
 =?utf-8?B?ZndSUnJLZTZaQ1liWHJnbElXQkpJa2lOZU54cHorNmNVQUpXQktrNkRGcVAr?=
 =?utf-8?B?RGhyU1hia2lMekNCU29Ud2VjNG5hbnJ0dlkvU3NIVEhOV3Y1Z1J2Y1pQcDVG?=
 =?utf-8?B?b3dJdkN3ZzBNazBDU3pvTmJOM3oxQlFzdVRQR0xLTis3VDlTbVNHUG4yZitR?=
 =?utf-8?B?YjFvU3hXMWZ6Tm5BTFZya1l2T1RSbGduZ1VYc0IydVVBOUg1SkhibkJoWGtk?=
 =?utf-8?B?Y0QzNGRwT2xHbGovRHZ4THU0cGZlb2ZlMDQ2eTlVbFBycmNPck1qbDlPdXJh?=
 =?utf-8?B?UzRCalZjRVZGTzkvM0dnRERzTUpQZ1lCS2hWZDBkemNQUGpWUHpra3hyVjg1?=
 =?utf-8?B?b0JleHQzb1E0cXZNaW04NkQrL25PbmppYWZ2TlY0eE05dGNYR2cyRS9lVlRL?=
 =?utf-8?B?eTRsNHlLVXdkdTY4S3F2Tno0akliWFl2T1dPWEVKNTB4alNPeHpQdUppMFBw?=
 =?utf-8?B?MHRCN1VrZjJ2ZmZrYUJhQk1PSU53bGFmZDF4WTBBWVF3U2hNSDlWSkp0WmtB?=
 =?utf-8?B?cDlPLzNtKzBFTW00b2xJcXNUR3RtZTVXYjN3QWJHMEdpK3JQSFNibGhNV0h1?=
 =?utf-8?B?WngvclNEYW1xWUljbHJYbmFyUGtJcG9PVkE2ajh5ZEc5SDVDalJVTm9tOW1m?=
 =?utf-8?B?RTQxZ2cwbFR3VEpuSEFMa2JKZE1JSlROZnVNcHBsT3JkQTNvNlBtKytWUU12?=
 =?utf-8?B?YkdQWlR3NC9nNk5nc3hqWkhYVC9Xb1ROWWF0bitPYUgvOFRHZHZUZlJFaEl0?=
 =?utf-8?B?d1NVZzNuUy9hZUhreWZxUG5xemM5VHpSOXQ5aW5EZWRQWGVMSGpWbmpCcnVi?=
 =?utf-8?B?S3RWYWRyNmw2V2tMaFB1bkVZZlFuQ1pTT2NRRGpuQTJuT3RoZCtQcjBNTUhp?=
 =?utf-8?B?WUdxcnNLRjNoVVlPdGEzNXNjQlBsTG5UbE4xMWprZEN1ZmNMUVV0NjhkZmxJ?=
 =?utf-8?B?WDZuZVdkN01wQmwyMUtqeDhFbk5WaDdwQWZVTElFSHFXMlJrRlJMZ2dTK0JK?=
 =?utf-8?B?Z0VIY0ZiN01ocTBYZFhOdDdXODl6dmF6b0Vac2c3V1JpajhGNEJ3V1BBRStQ?=
 =?utf-8?B?WlhlZ2JiekZzV01RblBCU0R4N05BM0NxOG8rUDIrVW9SSlhqd3BsL0F1OTcz?=
 =?utf-8?B?bW4zYTVMbVR5NEdtK0t0OGVabUdqOXd0M0xWNjBJQ3JiMFlUZForYkJLdFR4?=
 =?utf-8?Q?K9MidB1Oq7xSWGCKnV60w5mr3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd63527b-82d5-4077-ec11-08dbfbc72bff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 10:35:06.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sPjR0WE0h4UDwaoFjr+5mHTgOtajIDHhrEN4X4lwEbG08tfx5W1aq99V91+izCjx+jBa773pLNOTJhTk8mKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/2023 11:53 AM, Mika Westerberg wrote:
> On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
>> On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
>>> On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
>>>> Boot firmware might have created tunnels of its own. Since we cannot
>>>> be sure they are usable for us. Tear them down and reset the ports
>>>> to handle it as a new hotplug for USB3 routers.
>>>>
>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>>> ---
>>>>   drivers/thunderbolt/tb.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>>> index fd49f86e0353..febd0b6972e3 100644
>>>> --- a/drivers/thunderbolt/tb.c
>>>> +++ b/drivers/thunderbolt/tb.c
>>>> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>>>>   	tb_switch_tmu_enable(tb->root_switch);
>>>>   	/* Full scan to discover devices added before the driver was loaded. */
>>>>   	tb_scan_switch(tb->root_switch);
>>>> +	/*
>>>> +	 * Boot firmware might have created tunnels of its own. Since we cannot
>>>> +	 * be sure they are usable for us, Tear them down and reset the ports
>>>> +	 * to handle it as new hotplug for USB4 routers.
>>>> +	 */
>>>> +	if (tb_switch_is_usb4(tb->root_switch)) {
>>>> +		tb_switch_discover_tunnels(tb->root_switch,
>>>> +					   &tcm->tunnel_list, false);
>>> Why this is needed?
>>>
>>> It should be enough, to do simply something like this:
>>>
>>> 	if (tb_switch_is_usb4(tb->root_switch))
>>> 		tb_switch_reset(tb->root_switch);
If we don't tear down of tunnels before performing the DPR, the PCIe 
enumeration is failing.

PCIe link is not coming up after DPR. Below log is missing without 
performing path
deactivation before performing DPR and hence PCIe enumeration is not 
initiated.

[  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
[  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up

I think when we do a DPR, it internally does some handling with PCI Path 
Enable bit(PE).
So, deactivation of PCIe path is necessary for DPR to work.

>> Actually this needs to be done only for USB4 v1 routers since we already
>> reset USB4 v2 hosts so something like:
>>
>> 	/*
>> 	 * Reset USB4 v1 host router to get rid of possible tunnels the
>> 	 * boot firmware created. This makes sure all the tunnels are
>> 	 * created by us and thus have known configuration.
>> 	 *
>> 	 * For USB4 v2 and beyond we do this in nhi_reset() using the
>> 	 * host router reset interface.
>> 	 */
>> 	if (usb4_switch_version(tb->root_switch) == 1)
>> 		tb_switch_reset(tb->root_switch);
>>
>> (possibly add similar comment to the nhi_reset() to refer this one).
> Oh, and would it be possible to tie this with the "host_reset" parameter
> too somehow? I guess it could be moved to "tb.c" and "tb.h" and then
> check it from nhi.c as already done and then here so this would become:
>
>   	if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>   		tb_switch_reset(tb->root_switch);

Is host_reset necessary for USB4 v1 routers ? I did not use host_reset 
in this case.
If its needed, then we have to modify to enable host_reset in nhi.c as well.

> With the idea that the user has a "chicken bit" to disable this
> behaviour (and consistent one with USB4 v2). Feel free to make it look
> nicer though.
