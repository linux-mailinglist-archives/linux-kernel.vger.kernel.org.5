Return-Path: <linux-kernel+bounces-16967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AED82469C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B031C2253D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9212555A;
	Thu,  4 Jan 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ysu1uxvg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C425105;
	Thu,  4 Jan 2024 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7//AwO7bLnEzcVZk7yrHxasTgknhD0fvF5nt7LztcHXeCFZMBtiZWkzquW04xXryfVdmi1RPfu4ksamf+pJMxORu5ktekWpDgUS1V9LHr5kWO0IFf7aYkFOv6LDRhun3A64xjW85HKwiHOePt12LGctFxIHW2jFG3cdphq1XGjhFCSRr/fO0lIuR7BAtt2+V8W9gLX35XO4vVK2BnqFWlrLlllS/fVC3IOsir8iYQ5hHaIG7ETeC+5bmwpxp+Aaq2xrsruqlf+TAIDFoZlrMul2TsEl3rgQWFW+vh0xiLcSMeeZfUAXiBOhLqgW8cXsOfskBN9XucNdWwdJ/l6e/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2bO2lIkTbp/2Z+j47XPyBcdA/KxTYQq3WADxGN8rQM=;
 b=Vq6rtkCYqwc3VpUxq718yt3GyFRXNKGJvu2nwF1JBFK+gThcgovmp92941G/fj+UvnllPVsfWO8LZij+0bAmNWSG+J/MiLVlde2JWi0hhRcq5SzpZkrepPKZGEX1lcWUhgxy8eZs0nI6ISSHtqPZdHRrq19Ptlasfh+4+twdXQCpO5dS2YCYAeVpiFKa9E3Fk9wWP2ytjVllnHpw8AOJc33aoQiRUexxH+4eXpe1bIuh3WEvAwbNyZGmcoZjRfOqCL1D+pOLW3Wmx7XNwqNEos4eF2bLyUuO4RghZBq6q0QXi1wY4s7RGDOM3aKFVwPgOC3QrGXtcmCRKiOyj+Aj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2bO2lIkTbp/2Z+j47XPyBcdA/KxTYQq3WADxGN8rQM=;
 b=Ysu1uxvgI9gUxufSptZl/zYXokr9ltTW9TMj/idXJu3cKSwTv2tvJr63f/gwAKDR6j0WsStjMngD7EZaPm1eddbma9wI2iX6u1veI/1b2llWVmyyfQ+CbiAlhNkeF8ZKu8muNPWLttNSCZXB2gyZ+2r7jwWqCAwjtkqhQLJPoHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DM4PR12MB5359.namprd12.prod.outlook.com (2603:10b6:5:39e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 16:49:29 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:49:29 +0000
Message-ID: <558fb39a-470d-16e3-0043-510e6b4b3f8e@amd.com>
Date: Thu, 4 Jan 2024 22:19:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231219122634.GJ1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DM4PR12MB5359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f897333-2602-4dfd-7b4b-08dc0d451e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cLR4McybXJWL2Lzwz3ENonWHoAJvk9DfcFMugRjD+AVwUhweB4NC9GDZPulXtBt3R70BrF+F879Q0b0bsJe5qrGV0M2+7DQJZAN6C6yy+gA73BXMPmDIBSnNzjuYAY/LxuR7BdX/lZnBd+pNGnx2f0M5kFoD4ZDdw9a5P6LfRb/euLg6ItmYBybAc5eb51dkHOR1A9OKjxZDF9nsQruBTx/Jj+jfrF/2DQeRMV9JOTzy/DeX8PY5OfvMO/aoizf/xHcgD8VKQhH/4vBWpifp0ogF+ALw0rJ1jX1kQ+EAtCw48r6IHMQXtjVN/sCLYtKsTpuQR67DqBAiTjXIL29AHFq/g2/mwd9ImQAWacC4nSpXeKahyhsQGUkpyc2FpayxNNEm40/OzGTHMsAI/WRryWtGLDzYQWfrI06qotuDVyJ2tataeB/gBVfKhusQknadX2CqClsqIoynXvC3jDbfDNEfYhsiTIA6lKZGJIQ88wGL7n4+LL9EEPmD5xXQLtwp+kGde+uybIuq0IP7zkt/Ke/iBUY2v8Nvyc1NP+DaTxKx4DYnasVebIr6qNrTTVTNTkYOAXTtZXSebC4o1cqvf6rUHJpCWhqH/oa3bHlz21fTfvttUJKtYTZwem7rZDF0X/BatMuI+1bO+3iOwxBtvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(2906002)(41300700001)(53546011)(83380400001)(26005)(2616005)(478600001)(6666004)(6486002)(6512007)(6506007)(31696002)(38100700002)(31686004)(36756003)(66476007)(6916009)(4326008)(316002)(66556008)(66946007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d29abmlWMnBaNzkzWUUyZnBQK1JkVVlnT0FEeEhVeWk4Mm04UDZmMFJybjNm?=
 =?utf-8?B?NUFZRFFhVUNMRFNWdUhMY2pJZ2h1Q3U5djZVZkFzQ2ZNeFBDTy8yVnU1UjBz?=
 =?utf-8?B?LzBKTkl5Zys1dzc0ZXFlZUU4Vlg1dy9mTDc4NE4zdlJnUHRRdDRHTnoxWHN2?=
 =?utf-8?B?YlQ5eFhDcHkwVWdqa0hwaloyZXZYbEhySzlBV25qZytGTFhHMm1INjRvb2tI?=
 =?utf-8?B?TTRCaHZ5dHJld1RyZzQ5cmJUay9KK0N4S3BFV0tqYThGMmdQS004bTdaeUcz?=
 =?utf-8?B?QWJlV3lISXFBbTVZczRuS0NFWHY0VDc5NVN4SkFYS1dPd08xR1ZEWHllUFBt?=
 =?utf-8?B?eDlTTy9PTDh2ZEhsMDRWR0Y5WERqR2FiYkNtdCtJczF4Q01BRURUYzE2MGNi?=
 =?utf-8?B?TSt1dU1ITmF0bWFva0pPTU43dnJPQjV4VkdhbFJTZnFTRDNHc0pKQUNvMUpn?=
 =?utf-8?B?M2E4WkhmZEF3bnFWWGIvNjlON3F6dTJ0OUMyVHBXSldWTE5ZSVRhZko5anZt?=
 =?utf-8?B?VFRtTnFDUEM4UFpEdWRrR2Zkd3hpTFVPdGVUT1FFRkhrYjA5SXFCRFByT0t4?=
 =?utf-8?B?OVY2YWpKa3ZjZ012ZTVGdHBTeXhZMUdiMDRHK1pWRi9ZMWordVpsLzBGVFhB?=
 =?utf-8?B?TEFuenV6Mkk1T3VZTXd1YkRTRnpZelM3LzBQV2VlK3FlKzdHeU53YlRsSjlT?=
 =?utf-8?B?dExydEl2QzIra3lSU0hjcUhRMWNyUCs2VHJLTGR3ZEdPR0NOblo2M1hjTEVp?=
 =?utf-8?B?QTlPT2NabmdQOFAxUzVwN1l1cW13Mm16d2FRbXZmWGFYcFRkRjFhNjExSzFG?=
 =?utf-8?B?UzJXaXRTRUFUdDNGLzdtcXpoQTZBU1NOUExGMG5pUTkwMDhLZm1taUtOMVA0?=
 =?utf-8?B?SkxnS1RxRXgrNXJWcERSbyt6RTRzNUJHTHRkKzFjc1kxUHFrUlpNV2tPUllG?=
 =?utf-8?B?Sy9WYVBvaEhienVlQUUxUTNlazh1bUhLL2dmVUtpY3Q1VEpZV3V5dEhhMVZS?=
 =?utf-8?B?TnNHUVdvdXNEelpJUGcxRVRKWWNpRG9kbkVlTEJ3S1Y3NHVsV3pHa0JNbXg5?=
 =?utf-8?B?bkliUkh3RWJFTERpU3JycmdIUWlpdFEvWVlaSFJGVGExM1RpYW5HZVQrcEdG?=
 =?utf-8?B?cVpTcFk4elViTnkwUW1oZFNHMnlBZlZMQ3dyV1pwdVJFQkt4ZnBYQ0gxZ0NQ?=
 =?utf-8?B?M0VMREJ2SFQ4TjM5dVVaZWpsTE1LQmYwendMNisvYUp3Q2Vkenk0UEkvM2tP?=
 =?utf-8?B?MWhTbXVjTkN6RUQ2WGptYVRHeWNIcmdDNU9ZTG9VL21hRFI0YkduWTdxeVo3?=
 =?utf-8?B?N1grTURkSEtlbUFqWDFLQzNCQXB3cXN4bTdLSmh4ZG9WNGx5UDVZYU13OUMz?=
 =?utf-8?B?VkRhVkRkRG9CQUZTTkhkdjJGUGlRSTdQNWk5Z3pETnNYU1J3anBTMi9jWTk0?=
 =?utf-8?B?K1lESzBQd3duckphOEt6VVR2SCtWM0dab2N2UUR2U2djTzY2cmI4eXpBaUtq?=
 =?utf-8?B?UERQUmtoQU9HTXQrVmcwdkh4Z3RFL1hsbHJCRmVXakRLclJTVUVmbDJpcFVk?=
 =?utf-8?B?bitHQnZHVi9jSnJJemxQRVpEWXlhOXVieEFCZ3BycCtPRjdSVXplQStLSjVh?=
 =?utf-8?B?Q2RRdzliVDVidFBQWDl4N245Uml3THFUQ2NLY2VROHV5SkcyUXRCYkNhUnFr?=
 =?utf-8?B?RjVJRXNaT0NoeDdDc1hmc3Q2dFhuS25PQTRZdDZqbUtaRjRiK1RrTzNzYlND?=
 =?utf-8?B?elJPU2IvMkkzYzUybW5zQUJ2QVNCMmNyejNIbWxzWExmUUl3Z0xtWjVHVDhF?=
 =?utf-8?B?eTdvbkdYZmNJYWI3UlpkeWlqSWtQWFRvUXV0Z1FvODBhZHZTWGlDM2k4aTQr?=
 =?utf-8?B?RWFkY3JpWitmbzUyOXBIODFITDcvVE1lVWtjS2l0S2VYTDVVMUg1Yng0SEoy?=
 =?utf-8?B?emRBcENQMWcycTgrb2tDTUZYYktKcDNZKzFVbTZ3KzJNZ3ZBeFFqUTF0Y1hB?=
 =?utf-8?B?aGVteEpJVVRVTUYvamtMWXZTQW5OTytkdzFmU3pIY2d3QzBlK3FGMUlCT0xm?=
 =?utf-8?B?cVZlT3FMbmdhZElLOTRWK2hmSHp1amJFb0NuMUxsMjdMQjNXQm9DYlBGZk44?=
 =?utf-8?Q?OvG6VIjWmyLJMlFxetnwBujUc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f897333-2602-4dfd-7b4b-08dc0d451e1b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:49:29.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLoQHPEMnSs54V0ZNYCydRiR30G1YDW+8CcxGYzELRT6RxyRjwpS67M+Y8rZyut3SXXo4vcghwCEx3qFEhu1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5359


On 12/19/2023 5:56 PM, Mika Westerberg wrote:
> On Tue, Dec 19, 2023 at 02:41:08PM +0530, Sanath S wrote:
>> On 12/18/2023 6:48 PM, Mika Westerberg wrote:
>>> On Mon, Dec 18, 2023 at 06:35:13PM +0530, Sanath S wrote:
>>>> On 12/18/2023 5:53 PM, Mika Westerberg wrote:
>>>>> On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
>>>>>> On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
>>>>>>>> The discover part should not do anything (like write the hardware) so
>>>>>>>> perhaps it is just some timing thing (but that's weird too).
>>>>>>>>
>>>>>>>> I think we should do something like this:
>>>>>>>>
>>>>>>>> 1. Disable all enabled protocol adapters (reset them to defaults).
>>>>>>>> 2. Clear all protocol adapter paths.
>>>>>>>> 3. Issue DPR over all enabled USB4 ports.
>>>>>>>>
>>>>>>>> BTW, what you mean "didn't work"?
>>>>>>> Path activation would go fine after DPR like below:
>>>>>>>
>>>>>>> [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
>>>>>>> [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
>>>>>>> to 2:9
>>>>>>> [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
>>>>>>> 0:5
>>>>>>>
>>>>>>> But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
>>>>>>> see below logs)
>>>>>>> [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>>>>>> [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>>>>> Okay, what if you like reset the PCIe adapter config spaces back to the
>>>>>> defaults? Just as an experiment.
>>>>> If this turns out to be really complex then I guess it is better to do
>>>>> it like you did originally using discovery but at least it would be nice
>>>>> to see what the end result of this experiment looks like :)
>> I feel it's better to go with discover and then reset for now (as v3).
>> I'll keep this experiment as "to do" and will send out when I crack it down.
I got what we were missing. It's not required to do a discover_tunnel 
before we tear down.

We were resetting the downstream port and do a "continue;"
So, we were not cleaning up its path. Actually we have to cleanup its 
path after DPR.

After changing it, It works without any tunnel_discover() api's.

+            if (tb_port_is_null(port) && !tb_is_upstream_port(port)) {
+                ret = tb_port_reset(port);
+                if (ret)
+                    return ret;
+                continue; >>>>>>>>>>>>>>>>>> Need to be removed
+            } else if (tb_port_is_usb3_down(port) ||
+                   tb_port_is_usb3_up(port)) {
+                tb_usb3_port_enable(port, false);
+            } else if (tb_port_is_dpin(port) ||
+                   tb_port_is_dpout(port)) {
+                tb_dp_port_enable(port, false);
+            } else if (tb_port_is_pcie_down(port) ||
+                   tb_port_is_pcie_up(port)) {
+                tb_pci_port_enable(port, false);
+            } else {
+                continue;
+            }

-    tb_sw_dbg(sw, "resetting switch\n");
+            /* Cleanup path config space of protocol adapter */
+            for (i = TB_PATH_MIN_HOPID;
+                 i <= port->config.max_in_hop_id; i++) {
+                ret = tb_path_deactivate_hop(port, i);
+                if (ret)
+                    return ret;
+            }
+        }
> Fair enough.
>
>>>> Yes, I'll give a try.
>>>> As an experiment, I tried to compare the path deactivation that occurs at
>>>> two place.
>>>> 1. In tb_switch_reset where we are calling tb_path_deactivate_hop(port, i).
>>>> 2. While we get a unplug event after doing DPR.
>>>>
>>>> I observed both have different hop_index and port numbers.
>>>> So, are we calling tb_path_deactivate_hop with wrong hop ids ?
>>> Wrong adapters possibly.
>>>
>>>>   From deactivate tunnel (called while unplug) :
>>>> [    3.408268] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
>>>> 2:9 to 0:5
>>>> [    3.408282] deactivate hop port = 9 hop_index=8
>>>> [    3.408328] deactivate hop port = 2 hop_index=10
>>> Definitely should be port = 5 (that's PCIe down in your log) and
>>> hop_index = 8 (that's the one used with PCIe).
>>>
>>>> Deactivate from tb_switch_reset() :
>>>> deactivate hop port = 5 hop_index=8
>>> Can you add some more logging and provide me the dmesg or
>>> alternativively investigate it yourself. You can use tb_port_dbg() to
>>> get the port numbers to the log.
>> I've sent you complete dmesg.
> Got it, thanks!
>
>> Here is the log w.r.t port numbers and path clean up.
>>
>> [    3.389038] thunderbolt 0000:c4:00.5: 0:3: Downstream port, setting DPR
>> [    3.389065] Calling usb4_port_reset
>> [    3.389068] thunderbolt 0000:c4:00.5: 0:4: Found USB3 DOWN
>> [    3.389193] thunderbolt 0000:c4:00.5: 0:4: In reset, cleaning up path,
>> port->port = 4 hopid = 8
>> [    3.389203] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4
>> hop_index=8
>> [    3.389682] thunderbolt 0000:c4:00.5: 0:5: Found PCI Down
>> [    3.389811] thunderbolt 0000:c4:00.5: 0:5: In reset, cleaning up path,
>> port->port = 5 hopid = 8
>> [    3.389817] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5
>> hop_index=8
>> [    3.390296] thunderbolt 0000:c4:00.5: 0:6: Found DP IN
>> [    3.390555] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up path,
>> port->port = 6 hopid = 8
>> [    3.390558] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6
>> hop_index=8
>> [    3.390686] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up path,
>> port->port = 6 hopid = 9
>> [    3.390689] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6
>> hop_index=9
>> [    3.390816] thunderbolt 0000:c4:00.5: 0:7: Found DP IN
>> [    3.391077] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up path,
>> port->port = 7 hopid = 8
>> [    3.391080] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7
>> hop_index=8
>> [    3.391213] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up path,
>> port->port = 7 hopid = 9
>> [    3.391217] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7
>> hop_index=9
>> [    3.391342] Reset success
>> [    3.391391] thunderbolt 0000:c4:00.5: 0:2: switch unplugged
>> [    3.391434] thunderbolt 0000:c4:00.5: 0:4 <-> 2:16 (USB3): deactivating
>> [    3.391471] thunderbolt 0000:c4:00.5: deactivating USB3 Down path from
>> 0:4 to 2:16
>> [    3.391477] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4
>> hop_index=8
>> [    3.391641] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1
>> hop_index=9
>> [    3.391651] thunderbolt 0000:c4:00.5: deactivating USB3 Up path from 2:16
>> to 0:4
>> [    3.391659] thunderbolt 0000:c4:00.5: 2:16: deactivating_hop port = 16
>> hop_index=8
>> [    3.391664] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2
>> hop_index=9
>> [    3.391701] thunderbolt 0000:c4:00.6: total paths: 3
>> [    3.391720] thunderbolt 0000:c4:00.6: IOMMU DMA protection is disabled
>> [    3.392027] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): deactivating
>> [    3.392154] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
>> 2:9 to 0:5
>> [    3.392163] thunderbolt 0000:c4:00.5: 2:9: deactivating_hop port = 9
>> hop_index=8
>> [    3.392170] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2
>> hop_index=10
>> [    3.392534] thunderbolt 0000:c4:00.5: deactivating PCIe Up path from 0:5
>> to 2:9
>> [    3.392539] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5
>> hop_index=8
>> [    3.392637] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1
>> hop_index=10
>> [    3.392799] thunderbolt 0-2: device disconnected
>>
>> But it seems like we are not cleaning up all the paths ?
> To me this looks correct and even your dmesg the PCIe tunnel that gets
> established after the "reset" seems to be working just fine. I also see
> that in your log you are doing the discovery before reset even though
> the original idea was to avoid it.
>
> In any case this was a good experiment. I will see if I can get this
> working on my side if I have some spare time during holidays.
>
> I guess we can to with the discovery but taking into account the
> "host_reset".
>
> One additional question though, say we have PCIe tunnel established by
> the BIOS CM and we do the "reset", that means there will be hot-remove
> on the PCIe side and then hotplug again, does this slow down the boot
> considerably? We have some delays there in the PCIe code that might hit
> us here although I agree that we definitely prefer working system rather
> than fast-booting non-working system but perhaps the delays are not
> noticeable by the end-user?

