Return-Path: <linux-kernel+bounces-3698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2AA816FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A6B229F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB47760B0;
	Mon, 18 Dec 2023 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ma3+Cbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B476095;
	Mon, 18 Dec 2023 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTcq9xBtwLYqeKBbmAp5e1ot7yoh1QGNj1GOPqC6zVwNGCOvKhOdz3470OBKLXaZo0aaN6vu7PTnK8aqIv+1OMYML+IKENiXLFVphEZpe7l8pIfGsr6QYbKBvkCKkNTCblX5jbL4VqCGjeBwMUhlrPKo8Jd7OpZNqyr485S8Yzu1UesCY3ZYSiXysdVgyWrh4ay+SEKnXVcgtUZ4N909DcaTtVtbTKtRrt+Iu3GWAj0jUblf0vJDL2+wHDz81EVx4bCuvygVDhFXsXJ0SiLxWsUfKRh+xuWFIvpBUyjx8RS074fgzshxl5D7g3wO0bwlJfz7yuP9Mju8+ncBxXz48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S0dWtUTWbaOqpBkwoq6dSof8eJglWYNS5VtxqlnABM=;
 b=MgHHtAmUubLylpRexSe2r0b+r+UWig95NM8ekXoySatZmWEPH4WVXbQGPE4yfTm21IiNfgluEjSRqVR9wh3AUTCcrRrOeKXtSiwtxeQZUI5pcRUCP8F2ayj9uxrSdrMX5eZ1AS0SVmzzqJzCXBgCHdDOgqpBjL8MItcj/AeIpiLqRONJtbt/1ykWsKMiUB3Ze5FeaNG+P+nKR9L5rc8tSxf7nOYPCjQagfgd4qvyscj+OtIIMcMNhlS267ilgR6rrxV/77Wbg/jJo2sH94U6IoYIVsQV874FN5YqCY4S5tJJwh5I0NUKb1vn7VafaqEBW6wZ6nVq5EA5JEHq0cutFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S0dWtUTWbaOqpBkwoq6dSof8eJglWYNS5VtxqlnABM=;
 b=0ma3+Cbwb48ZwPzHrmAjGLSRB0Ov2FFvYD+SZEUumHPDOnOjGminUIQEQWBeJdcxjn59qliCdo/OJSIO8gBUh/EOnIdO/OTjhv3DYjm1XPvX3y/mDYvds8zXquvotzOhZNAbp40wxmT9xc0uwgMkDCeQvEE/jTdyXEChyUasN+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 13:05:21 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 13:05:21 +0000
Message-ID: <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
Date: Mon, 18 Dec 2023 18:35:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
 <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231218122312.GE1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::6) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d2dff-7286-4f65-2ad6-08dbffc9fd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yrGR031nKpMnRikQ++LJxo2hgyY6kNKZ5Gp/CLS4oVTQkbTbxf9ixhWG7akmKsxEVr0wrZ3r0z/055uux5cEpWVSznfOGsJcvM59l2/wrJlROtLk/u3h+17QH0q3eDbAsicXBQHZ97WFKk3XPBt9zCIfiexwINQygA7uVkpwP4zZbeugfbOCn4PRCcu2PZP+SJnRei7kFfSdbotFTT1ElgIl1IA7wbR7j2Z0QZnEaNib3R5jDvH5xAHmeGykdpxnbOuaxh+0VpMUX5TeevX5qAnxll3ON0pi9pfg3ZeCKXmUevJsGZIRo9nE80PrgDkyDpfiGc0uzE+Em2zDpgMexwVWQeyw76zyGOGrrW3vH5YIniZ/N96GLfe8Fho4LVQQ36UBY9sf2lIXE0Ak1+I8Tu3oHQPKlPI4CdsFzLaYrgm6Wvjsi1BUqdSD4uw/EBvGMFg+DpUWCGcLpq8wgbsZt9trpit7n+8DBoo4XqJLhfKa62QoehoUF923iMQaVT/2SI+6zQEPHHXvDEokb+8uv0cymDE7nRSeqCVHfJLpj+0KhtPAVQL0Cnd06oEmGbgzHtIjOAc5q1X74vdvFZ/62vtS/msc8avPT2AZaDLdnmq9h1zG8X7IsRNLMrOpTqsRDwQnIlW3whs7emOfewP8Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(6916009)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(31686004)(2616005)(83380400001)(38100700002)(26005)(5660300002)(31696002)(36756003)(53546011)(6512007)(6506007)(6666004)(2906002)(478600001)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWdOUmhYeFZLT1haN0tCSWFiQUtWLzZ5V0dNS21uTmxGODdvUk5WOHh4S1pH?=
 =?utf-8?B?VS9yVTBSNTI1Wk5lWmVmbVNycVd2V1ljbjY0d1BiU3RjV2lRM1V6c25PTTE4?=
 =?utf-8?B?akI0U0swa3QzenNCbXpGSXNRU3BmMjY2SGJrTlZMSzRvYW5lRXpGa3lyc3A0?=
 =?utf-8?B?Rm93V1U3NVA3WnAwNXJQRnZUdEhES2xQNDk3cTBaYUwwT3hoSzNEUTM1MDBu?=
 =?utf-8?B?K3pOeGdudlYremRybm1IREFrM29zSkFUbmRoRUxnWU5oOGhqS1kyQ0lDdUJW?=
 =?utf-8?B?R2NHUGpQbUpKMXBIdWFqU0ZSVjBtL1pMRG00VGN5OUZyM0hNcWpyeHVaWEJx?=
 =?utf-8?B?MFZDRUpwME5rMVUrbDNWS04zdnFxb0h1am5QK2FZVWsyNktSZlQ0NmRDMnU3?=
 =?utf-8?B?b3ptMDROQ3JiZzNSU20xZDJ4Vi9CcDgxbmdwU3pvRnpwd2RtR1BENFdJMS9w?=
 =?utf-8?B?RCtvandSWVBTYkMrWU5mbnNpdjFBcHdHaGNyb3ZPY1QrMm5uSUFlaDRsQ292?=
 =?utf-8?B?aEpId2x3NDdCTXlRRThYekhYZ1Q1NkdLemtERS9QTWh2OG0xVzlEdHhsY1Iz?=
 =?utf-8?B?aHRwWUJ0U1B6SHVzbFQzNlhObnVNdDhSZVA4NmU4OUE1cGVHaHdKSVFuYSt6?=
 =?utf-8?B?Si9Ea28yYmpTclMydXVMblp3ZENCVnNWT0RqN1dHNjZWdXo2cFRUTTNwZ1Aw?=
 =?utf-8?B?bWxIZDI0TG14QmJlenhHQnJhLzVWRE14eWp5dVJpcCt2TkZYaklicHMxa2xo?=
 =?utf-8?B?eThvRy9KcmlCbWtkNlRCaFJYaU5ZR0E2czRtOGk1NnMxWUhnckRRTWRkbVps?=
 =?utf-8?B?aGFqT2lJR2ZlbGZaL3pUMkV6ZjBTYXJYa3FsazlENHovR2NIdVpBUjV0dGhZ?=
 =?utf-8?B?WE55dkJ6NzJuL05PL0xvUUtObGxhSXFaejFlOEJoc1R0eG9IZ0grNnpFZVNk?=
 =?utf-8?B?bExTZEJHU2RnN1pJejJQcHNTNlZZcjAxdVNKdStQUXA5TTM3N0RxbmxsMFJJ?=
 =?utf-8?B?Yk1YeWZZR0U0cm5jSGw1SzR0Zm1mTVlIeFpab3czYTZBa3orSmNnTmtCbnlV?=
 =?utf-8?B?NjVWejNzVElLOHhrejhHS0FmRmFCaC9STXhRUU9xUkZTckx4R1ErUGpjUzB5?=
 =?utf-8?B?akozMlEvMjR5S1p6WkIyOTVyNXJ1TE1PaU1aQkpJTFh3TExsRXVvd2xiM0NO?=
 =?utf-8?B?Z2hOS0J4ZU1XckxtZUpMcW9UWVVpN2tzZDZ1ZVc0VjFXV0U0eW1NT0NrU3Ja?=
 =?utf-8?B?enhlQytKc2JTR25QMi9kdXNiOGdNVWxydzdST1lxMXVBZnA2bDRtb2dFNzcv?=
 =?utf-8?B?L25wN1BJWjgyVzVmZ3VIdFRzaWJtaExxY1plZ3ZYOXQ3a0VjL2hMYVduRHd4?=
 =?utf-8?B?WlBTVnBtNlFMY0VsZTdQckhRei9ZN0hkN3lPWVBwL2lXUVcyVnNlRGM4WENw?=
 =?utf-8?B?YlVIVUM5MHJCMk5YMTk2L0htM2ZIYitxZ3dQN084V2RuRzdJYWR6anZXYTVP?=
 =?utf-8?B?anlBckNwTTE4VkNmWjB5LzBwMFNNUVlwWU5vMk9HcjF1UVFkdlkrWDNnSDc3?=
 =?utf-8?B?SmlUblV0R0VOZzA0Yy9sd1NBeW4vZzVJMDlld1ZnMGpBcG5QemZkdG5XMWU3?=
 =?utf-8?B?V2x1TlZhdGpjbXdRV3dPaEozcDRKb3hJQ0pXT2VlbzZQNDRMaVp3L1dLSWR1?=
 =?utf-8?B?by90Z3dLdWJkT3FzcE5TK3d5NmpYSXpIU1lZRDg1dWhSZGxJUm9BUTVyMHJM?=
 =?utf-8?B?UmkzVkNmdkt5T3lManA3cjhtMW13a0l1RzkyYTA1dWVTdkt0R25HRjdrS3py?=
 =?utf-8?B?Q3RRUjB6TS9WbzZHU0tWSTNuMTlCTVE2ODJONmR4N00xS3JHVzk3K2VhUjhk?=
 =?utf-8?B?STVLbkRncTI2YXFkUnBLZ2JTb1ViSWxWcy91TGl1WlI2RkZZb0pBbnMreXR1?=
 =?utf-8?B?bnYwYzhGRDBjZ2RWSVlOL3d3dm5RNFRUbkdUd2pQRGpEaW9kSGgzVld6czl5?=
 =?utf-8?B?WmJTcmdYdnk1TnJvZkI1dnp0ZXV6aXd0V2dheWtRV1RUeHd1QUEwcUJmRENF?=
 =?utf-8?B?cE5PS0MwVGNTQktjZjRleHhMYysxTTFrUWhaN2dySEdpWDFYWjY1bElzOVVl?=
 =?utf-8?Q?r579HWTmAWiNii06PykyRct8p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d2dff-7286-4f65-2ad6-08dbffc9fd8c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 13:05:21.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C59VHB56UAUDBD0dFrR/64p5bOUL0Y2zTKg22WfPDq1tRYjSinXlWs6Ugr0I4/R4ZpAMXVu91Tq64XeGh4sWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993


On 12/18/2023 5:53 PM, Mika Westerberg wrote:
> On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
>> On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
>>>> The discover part should not do anything (like write the hardware) so
>>>> perhaps it is just some timing thing (but that's weird too).
>>>>
>>>> I think we should do something like this:
>>>>
>>>> 1. Disable all enabled protocol adapters (reset them to defaults).
>>>> 2. Clear all protocol adapter paths.
>>>> 3. Issue DPR over all enabled USB4 ports.
>>>>
>>>> BTW, what you mean "didn't work"?
>>> Path activation would go fine after DPR like below:
>>>
>>> [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
>>> [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
>>> to 2:9
>>> [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
>>> 0:5
>>>
>>> But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
>>> see below logs)
>>> [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>> [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>> Okay, what if you like reset the PCIe adapter config spaces back to the
>> defaults? Just as an experiment.
> If this turns out to be really complex then I guess it is better to do
> it like you did originally using discovery but at least it would be nice
> to see what the end result of this experiment looks like :)

Yes, I'll give a try.
As an experiment, I tried to compare the path deactivation that occurs 
at two place.
1. In tb_switch_reset where we are calling tb_path_deactivate_hop(port, i).
2. While we get a unplug event after doing DPR.

I observed both have different hop_index and port numbers.
So, are we calling tb_path_deactivate_hop with wrong hop ids ?

 From deactivate tunnel (called while unplug) :
[    3.408268] thunderbolt 0000:c4:00.5: deactivating PCIe Down path 
from 2:9 to 0:5
[    3.408282] deactivate hop port = 9 hop_index=8
[    3.408328] deactivate hop port = 2 hop_index=10

Deactivate from tb_switch_reset() :
deactivate hop port = 5 hop_index=8


