Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416557E3619
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjKGHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:50:46 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33669C6;
        Mon,  6 Nov 2023 23:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDFTl4uCFAQ/nnxSUu3H57NN0GFi26fREXuifuNp6ogdD+8SPrZserL9gMS9WDMlTZejuUkyo2B308bALnEZxE3M48Bv6AEK6qPneTPgOzDaxntk2qzSIlaTggG8uY0cGzJMhglx0G6+c27/17LAqaki/SmwhL/d7kFD0qBrayzdivsYgkkpHl8IYmQOQPyMlCh+n1Zk+UzOQATltge80QeTqGT4uWfc+lQyG+I/b8rgltV1SakgeMiKJxZs1o06iOB9CnXDIljTwHq2WnvnMQJdeH5u8hSZfRDCrFTAhQ32DMAcl1XYcbQr/gE57yGKNvT57Ydc+46ZhOuouD1cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdRV7YV7eEqgv3dt5Oh1QYZc83w7yvRNoc8MXW4+uzg=;
 b=KulagwIWzwV3o2oWjcGL/KfZ6gqAEY4uIb684GbGTjQAFQdXFuj7n5M47xjFq024ncZ6RMKsFWsi1HGUIzhJhHcFy1jSfdv4hNbp9SZ9PGGDppYnL5KN2sphSiSE7AdA93X+4SOqjvZ19BzQiF+xmvhGTGsu7VZUd/Owzz/wMsJIoAlNYY2U33FWtrn8EQFJ9XAbEQVyXmXomLEEGDt1Aa8lABVycSPc6vqzRoCEYSM2G3vyODv1ZMm3jOmqnoRtfm3vj/jgJytYnInjIo/Q2/iCddSfpgRuD/iamB64TdaSv6vHd+ve7ymavcFI5rVVzejK/5dUh18rfud1tl1Gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdRV7YV7eEqgv3dt5Oh1QYZc83w7yvRNoc8MXW4+uzg=;
 b=v2cW/pA8JVNuJqnALnq+3o4TRqqX/nmF2DuWtWnw+7SpzosU4WWTAe0fByWFH+Xgd+PNQpkQyhf3oFgadOYG3wI/f7sqBTnivivNCu1cPtVI8s9LQEnn2hSsUlhgPydlCTTh+vQAAKBfHz0St+La2QeXZRSDSCEFYcOcZMqh9n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Tue, 7 Nov
 2023 07:50:36 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::84c6:2a76:40a4:bf78]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::84c6:2a76:40a4:bf78%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 07:50:36 +0000
Message-ID: <f453aeb2-9bc6-a32a-107a-738ba303f107@amd.com>
Date:   Tue, 7 Nov 2023 13:20:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
To:     Sumit Garg <sumit.garg@linaro.org>, corbet@lwn.net,
        jens.wiklander@linaro.org
Cc:     vegard.nossum@oracle.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>,
        ",Jeshwanth Kumar" <jeshwanthkumar.nk@amd.com>
References: <20231103061715.196294-1-sumit.garg@linaro.org>
Content-Language: en-US
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <20231103061715.196294-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ec2c2c-b9ff-4477-9566-08dbdf663a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egSZbKnPBUlcLOwdF41tpn9FDrzOICmBuEXdzrCrCcCkaumlI4VaUeIcsozmhwHmD3EGBISx912zxJdp+yL2LVeMy7aoU8MJroJCtgrzVyPLrGyWUWMxJ4yVlg7aaYPfWVJbZ9DsStfwRy4D3xnPNMnqGoHtTzFrTckhf9gbYlPyPfWW+vbxdCsgTRFiO5qhA2/QMl5GXWE5rSDstKFuXvIB+5CcXViiU62Qu9iDtfZelLe37jFqwWxKOY0RM6gROktG6QAcodXzbQW8Y2k3F9L4/5JPtLZ/eKDhj+6o6lslGxQ+BN6m6p7wTG91PmPyFhcbMuaS6cmChWAbgODdH3+hD/MZKaGb7iPxlTfkmvUuZwFlnTM3PshZaBxO8qKJ4jxYvMBO2GqEBIW2jPzLeDTqT2YkcGEbwxXhwpTfLYG3hUl3behfAtVkoOIW8A9eRwJI0zN6u1IMMmYpbyQdNEJYTtgXfIaMvYydo13fC8XmY/MGbstbwGuqenRKW9E9Vrna1S1rfLwU9UoTt8mFVez9vIlGMRNApieYkNG6g0IQD9L5m0d/wYV+pkGEYxMfL4YCQOorrpbXpbIQfKcntCrBb16tBZz/dI9lpumpCQHUXBzcmlce0alsB2CTxr3MTLrS3So+xmNmkW4BmC/szmQySBtDFxB3Upkh2vp2LEcU1o7ZHpC9wM7B938pv1PiAOndOpLyu4YB0yiVZTzOQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(83380400001)(31686004)(38100700002)(66946007)(41300700001)(66556008)(66476007)(316002)(8676002)(54906003)(6486002)(966005)(6506007)(478600001)(53546011)(4326008)(8936002)(6666004)(86362001)(26005)(36756003)(2906002)(31696002)(5660300002)(30864003)(6512007)(2616005)(66899024)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJFdzF5N09GUmk4cE5tK2I3M3MxODN2Sy9YWlRPNXlkemhwOU1VWmsxMkkz?=
 =?utf-8?B?NkpoSU1QejU2djhYTEUvSEQzckNWV0g4WVhDSWhpVUVYR3ZZclllKzh0VC9X?=
 =?utf-8?B?ejhMR2Rhbmp6TGJYQWZidlV5NFI1NEZva0VhOHdvUXZmNUtOdjZib1JvWURx?=
 =?utf-8?B?VlZjU3Q5S2UwNUNGK2lnbEVySFhGcmY2TTcrUWhwd0YxQzFyUFdDdFArOC92?=
 =?utf-8?B?Rk92cmtkWk5nWXlPcGhkZDZqbW1LQ3lLM01JdTFPVmt5MG12L0JPR0FzRTdh?=
 =?utf-8?B?QjFTRVpnZ1BMZjZGYnl2ZFRTc0lmWFdpcjZQTWVrUkpOWkliRlRSRVByOGs2?=
 =?utf-8?B?TkdmMHFWZEdzb2ozZUtGek10VkJ1OUpKRllBc3ZvRW15L1ZFWHRiZkVGRjJz?=
 =?utf-8?B?U3ZwYWQ3Y2NhcDRrQ0JuVUdRYWFqUWViajZIVnJCN1BJNjVod3hmOEdoTENv?=
 =?utf-8?B?cTlhb241NTlpWG91VjdSVUs2YmVLTU93STR2T0xqdVFGWEw2Sld4TFhaRHlh?=
 =?utf-8?B?eWVGaDVZWWRHN1c0alRVQXJSdUVMZ2t0NjVJdHQ2NjY1VnQ5dXc5eFVpMVM5?=
 =?utf-8?B?dHhYaDI0M2VleTZkQUZwVVoxcElWVUtLeTBMVjBGbnM5Z2p4Uk9RcUNYQjY5?=
 =?utf-8?B?dXZSSnhHbWVJMlpaY3lFSmJqMzEzV0xuOWFjcGk2RURmTE4vc2srd3o3Y1gr?=
 =?utf-8?B?Mkk2c1ljUXcwOWFzVnFZL0o3QlBwUFlRQmxEb0VMMFpsZkJmWU9ySUQzeW1p?=
 =?utf-8?B?VlNOQjZrQjg1RTNBYlpJM1J3WkV2c2N2ZXZYYTJVQ1BGeitWZ2dYNzFPLzVM?=
 =?utf-8?B?ZVphRWVodXFRZm5CZzlIZjB6RHZIaEhtRUFETHZxL0lFZGZpRi9Cd2RNOU1L?=
 =?utf-8?B?amtvVUc4K2ZIMzhlVGQxODFNT1VFM1U1VTdYdGFyYmtUeEFVUXg3NFRUNnFy?=
 =?utf-8?B?S1R6L3hCa0JmVzkxZHBrRTZvUGVDWWxQSGRndHVBamNrblJNZytXRWhMUXgv?=
 =?utf-8?B?Q1NLWU0rRmpKaTU5R1JJS1FQdWFkMWlpZFpqeTdpQkRqMDFDUTlERFlOVU5G?=
 =?utf-8?B?amh0YUxueW5pT000K00wT2ZBOUxHOWxnWmR2Tng5cTR0RWdUcElkZ1BVQ0xl?=
 =?utf-8?B?OEFZU3Z3Y1VTUk9aVkhoUk8rSGNhNUtEeDJTSGdrK1RxZTloZFBjTkdSU3Zt?=
 =?utf-8?B?Nm1aT083bjNyem9mTUhVUjVOUFRzaTY0cHhQUUdkYnNXSEdSeHBWWmErSUdK?=
 =?utf-8?B?ZjJNUmpoS1NSQ2YvdnViOU1FTStFcTBCeFkvZXNPTjRaSzJDaldtU2ZzUlF1?=
 =?utf-8?B?N2FmMU5rSVRiT0c3ZGc2QWJPRndKVzAvR2hrVmpnd09ScW9IM2lCOEZzcU1u?=
 =?utf-8?B?QnBlamYrdGM0TjhNY3VockFnQ2pHTU1Oc01DS21KTXM4Vkt5elVRK3BaU2JL?=
 =?utf-8?B?di9iSU1ZOGNPelRZbmVBc0pYWHNtQ0JURE5lVmVFek0xK2NBdGhLWXpua2lC?=
 =?utf-8?B?S0laK0Q2Q2hXdFQrbzcwa0E0NjBPRGppcGl2RWpsd3pIWGRKL0xFRDVOQkNt?=
 =?utf-8?B?NFAyVFZ6bkRNbDNvZlpjeGlQaE5jcHM2N2V1Qk1YbExQOXZUNWt4VGtlbEll?=
 =?utf-8?B?L1ZXZ2lRYzJXamRxS3lFdjZhSEMxNmdWbmNLSzV5c1EvWEpHZCtZY3g1U3A5?=
 =?utf-8?B?VVRyWHA0cTNiNlR1UVhINHdVdDhuaytsNnhFS2tDVEthdjZsc2R2VldyUWp4?=
 =?utf-8?B?TUQvN1NuOTkzeUxzcFR0MEZrUDc3QWNmclVVRzFGK2duY0JuWHRMeDNTbW45?=
 =?utf-8?B?MllZS3RKTUNvU2FjRThydnFxUFJxNHovYVl5eG5UZWtNaW52NU9udDA1OEVh?=
 =?utf-8?B?RWZTTjBreHZPVjRZZ3hjT2ZQTitQNllDcGxMV1d2bWpHdG1uWEZwMzY0bFY0?=
 =?utf-8?B?SG9BVjRRZklEeXlWYzNoMEp3QVd0clBZSUVuTnppbG1oM3hteXBrRDFQVDkw?=
 =?utf-8?B?Q3dRK2VaNXhZWmd2eGFSY3BpTytjY1BOOEZ0aWphZTJES21XYXRWeHZjdEtr?=
 =?utf-8?B?dlQvZ085UVFrenpmaXBKelBvVlFNSjlocXFiV1pnRkYxTzczSjZqaFhoVUph?=
 =?utf-8?Q?uZRmGzY0kXfc9T8bwwXe1GKe7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec2c2c-b9ff-4477-9566-08dbdf663a44
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 07:50:36.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBT0Bb3LkEuq8GNYF9NaeUIio4iE/5QGcW0LZ8+erKMuk29rOlVaijTRl0yJYifztu5Bo5arFeeSY/Qsu+MZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 11:47 AM, Sumit Garg wrote:
> Add a separate documentation directory for TEE subsystem since it is a
> standalone subsystem which already offers devices consumed by multiple
> different subsystem drivers.
> 
> Split overall TEE subsystem documentation modularly where:
> - The userspace API has been moved to Documentation/userspace-api/tee.rst.
> - The driver API has been moved to Documentation/driver-api/tee.rst.
> - The first module covers the overview of TEE subsystem.
> - The further modules are dedicated to different TEE implementations like:
>   - OP-TEE
>   - AMD-TEE
>   - and so on for future TEE implementation support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 

I have checked AMD-TEE driver documentation portion of this patch. Looks fine to me.

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

> Changes in v2:
> - Move userspace API to Documentation/userspace-api/tee.rst.
> - Move driver API to Documentation/driver-api/tee.rst.
> 
>  Documentation/driver-api/index.rst    |   1 +
>  Documentation/driver-api/tee.rst      |  66 +++++
>  Documentation/staging/index.rst       |   1 -
>  Documentation/staging/tee.rst         | 364 --------------------------
>  Documentation/subsystem-apis.rst      |   1 +
>  Documentation/tee/amd-tee.rst         |  90 +++++++
>  Documentation/tee/index.rst           |  19 ++
>  Documentation/tee/op-tee.rst          | 166 ++++++++++++
>  Documentation/tee/tee.rst             |  22 ++
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/tee.rst   |  39 +++
>  MAINTAINERS                           |   4 +-
>  12 files changed, 408 insertions(+), 366 deletions(-)
>  create mode 100644 Documentation/driver-api/tee.rst
>  delete mode 100644 Documentation/staging/tee.rst
>  create mode 100644 Documentation/tee/amd-tee.rst
>  create mode 100644 Documentation/tee/index.rst
>  create mode 100644 Documentation/tee/op-tee.rst
>  create mode 100644 Documentation/tee/tee.rst
>  create mode 100644 Documentation/userspace-api/tee.rst
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 1e16a40da3ba..b4214d98d7b5 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -114,6 +114,7 @@ available subsections can be seen below.
>     zorro
>     hte/index
>     wmi
> +   tee
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/driver-api/tee.rst b/Documentation/driver-api/tee.rst
> new file mode 100644
> index 000000000000..5eaeb8103988
> --- /dev/null
> +++ b/Documentation/driver-api/tee.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +TEE (Trusted Execution Environment) driver API
> +===============================================
> +
> +Kernel provides a TEE bus infrastructure where a Trusted Application is
> +represented as a device identified via Universally Unique Identifier (UUID) and
> +client drivers register a table of supported device UUIDs.
> +
> +TEE bus infrastructure registers following APIs:
> +
> +match():
> +  iterates over the client driver UUID table to find a corresponding
> +  match for device UUID. If a match is found, then this particular device is
> +  probed via corresponding probe API registered by the client driver. This
> +  process happens whenever a device or a client driver is registered with TEE
> +  bus.
> +
> +uevent():
> +  notifies user-space (udev) whenever a new device is registered on
> +  TEE bus for auto-loading of modularized client drivers.
> +
> +TEE bus device enumeration is specific to underlying TEE implementation, so it
> +is left open for TEE drivers to provide corresponding implementation.
> +
> +Then TEE client driver can talk to a matched Trusted Application using APIs
> +listed in include/linux/tee_drv.h.
> +
> +TEE client driver example
> +-------------------------
> +
> +Suppose a TEE client driver needs to communicate with a Trusted Application
> +having UUID: ``ac6a4085-0e82-4c33-bf98-8eb8e118b6c2``, so driver registration
> +snippet would look like::
> +
> +	static const struct tee_client_device_id client_id_table[] = {
> +		{UUID_INIT(0xac6a4085, 0x0e82, 0x4c33,
> +			   0xbf, 0x98, 0x8e, 0xb8, 0xe1, 0x18, 0xb6, 0xc2)},
> +		{}
> +	};
> +
> +	MODULE_DEVICE_TABLE(tee, client_id_table);
> +
> +	static struct tee_client_driver client_driver = {
> +		.id_table	= client_id_table,
> +		.driver		= {
> +			.name		= DRIVER_NAME,
> +			.bus		= &tee_bus_type,
> +			.probe		= client_probe,
> +			.remove		= client_remove,
> +		},
> +	};
> +
> +	static int __init client_init(void)
> +	{
> +		return driver_register(&client_driver.driver);
> +	}
> +
> +	static void __exit client_exit(void)
> +	{
> +		driver_unregister(&client_driver.driver);
> +	}
> +
> +	module_init(client_init);
> +	module_exit(client_exit);
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
> index ded8254bc0d7..71592f3ce89b 100644
> --- a/Documentation/staging/index.rst
> +++ b/Documentation/staging/index.rst
> @@ -12,5 +12,4 @@ Unsorted Documentation
>     rpmsg
>     speculation
>     static-keys
> -   tee
>     xz
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> deleted file mode 100644
> index 22baa077a3b9..000000000000
> --- a/Documentation/staging/tee.rst
> +++ /dev/null
> @@ -1,364 +0,0 @@
> -=============
> -TEE subsystem
> -=============
> -
> -This document describes the TEE subsystem in Linux.
> -
> -A TEE (Trusted Execution Environment) is a trusted OS running in some
> -secure environment, for example, TrustZone on ARM CPUs, or a separate
> -secure co-processor etc. A TEE driver handles the details needed to
> -communicate with the TEE.
> -
> -This subsystem deals with:
> -
> -- Registration of TEE drivers
> -
> -- Managing shared memory between Linux and the TEE
> -
> -- Providing a generic API to the TEE
> -
> -The TEE interface
> -=================
> -
> -include/uapi/linux/tee.h defines the generic interface to a TEE.
> -
> -User space (the client) connects to the driver by opening /dev/tee[0-9]* or
> -/dev/teepriv[0-9]*.
> -
> -- TEE_IOC_SHM_ALLOC allocates shared memory and returns a file descriptor
> -  which user space can mmap. When user space doesn't need the file
> -  descriptor any more, it should be closed. When shared memory isn't needed
> -  any longer it should be unmapped with munmap() to allow the reuse of
> -  memory.
> -
> -- TEE_IOC_VERSION lets user space know which TEE this driver handles and
> -  its capabilities.
> -
> -- TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.
> -
> -- TEE_IOC_INVOKE invokes a function in a Trusted Application.
> -
> -- TEE_IOC_CANCEL may cancel an ongoing TEE_IOC_OPEN_SESSION or TEE_IOC_INVOKE.
> -
> -- TEE_IOC_CLOSE_SESSION closes a session to a Trusted Application.
> -
> -There are two classes of clients, normal clients and supplicants. The latter is
> -a helper process for the TEE to access resources in Linux, for example file
> -system access. A normal client opens /dev/tee[0-9]* and a supplicant opens
> -/dev/teepriv[0-9].
> -
> -Much of the communication between clients and the TEE is opaque to the
> -driver. The main job for the driver is to receive requests from the
> -clients, forward them to the TEE and send back the results. In the case of
> -supplicants the communication goes in the other direction, the TEE sends
> -requests to the supplicant which then sends back the result.
> -
> -The TEE kernel interface
> -========================
> -
> -Kernel provides a TEE bus infrastructure where a Trusted Application is
> -represented as a device identified via Universally Unique Identifier (UUID) and
> -client drivers register a table of supported device UUIDs.
> -
> -TEE bus infrastructure registers following APIs:
> -
> -match():
> -  iterates over the client driver UUID table to find a corresponding
> -  match for device UUID. If a match is found, then this particular device is
> -  probed via corresponding probe API registered by the client driver. This
> -  process happens whenever a device or a client driver is registered with TEE
> -  bus.
> -
> -uevent():
> -  notifies user-space (udev) whenever a new device is registered on
> -  TEE bus for auto-loading of modularized client drivers.
> -
> -TEE bus device enumeration is specific to underlying TEE implementation, so it
> -is left open for TEE drivers to provide corresponding implementation.
> -
> -Then TEE client driver can talk to a matched Trusted Application using APIs
> -listed in include/linux/tee_drv.h.
> -
> -TEE client driver example
> --------------------------
> -
> -Suppose a TEE client driver needs to communicate with a Trusted Application
> -having UUID: ``ac6a4085-0e82-4c33-bf98-8eb8e118b6c2``, so driver registration
> -snippet would look like::
> -
> -	static const struct tee_client_device_id client_id_table[] = {
> -		{UUID_INIT(0xac6a4085, 0x0e82, 0x4c33,
> -			   0xbf, 0x98, 0x8e, 0xb8, 0xe1, 0x18, 0xb6, 0xc2)},
> -		{}
> -	};
> -
> -	MODULE_DEVICE_TABLE(tee, client_id_table);
> -
> -	static struct tee_client_driver client_driver = {
> -		.id_table	= client_id_table,
> -		.driver		= {
> -			.name		= DRIVER_NAME,
> -			.bus		= &tee_bus_type,
> -			.probe		= client_probe,
> -			.remove		= client_remove,
> -		},
> -	};
> -
> -	static int __init client_init(void)
> -	{
> -		return driver_register(&client_driver.driver);
> -	}
> -
> -	static void __exit client_exit(void)
> -	{
> -		driver_unregister(&client_driver.driver);
> -	}
> -
> -	module_init(client_init);
> -	module_exit(client_exit);
> -
> -OP-TEE driver
> -=============
> -
> -The OP-TEE driver handles OP-TEE [1] based TEEs. Currently it is only the ARM
> -TrustZone based OP-TEE solution that is supported.
> -
> -Lowest level of communication with OP-TEE builds on ARM SMC Calling
> -Convention (SMCCC) [2], which is the foundation for OP-TEE's SMC interface
> -[3] used internally by the driver. Stacked on top of that is OP-TEE Message
> -Protocol [4].
> -
> -OP-TEE SMC interface provides the basic functions required by SMCCC and some
> -additional functions specific for OP-TEE. The most interesting functions are:
> -
> -- OPTEE_SMC_FUNCID_CALLS_UID (part of SMCCC) returns the version information
> -  which is then returned by TEE_IOC_VERSION
> -
> -- OPTEE_SMC_CALL_GET_OS_UUID returns the particular OP-TEE implementation, used
> -  to tell, for instance, a TrustZone OP-TEE apart from an OP-TEE running on a
> -  separate secure co-processor.
> -
> -- OPTEE_SMC_CALL_WITH_ARG drives the OP-TEE message protocol
> -
> -- OPTEE_SMC_GET_SHM_CONFIG lets the driver and OP-TEE agree on which memory
> -  range to used for shared memory between Linux and OP-TEE.
> -
> -The GlobalPlatform TEE Client API [5] is implemented on top of the generic
> -TEE API.
> -
> -Picture of the relationship between the different components in the
> -OP-TEE architecture::
> -
> -      User space                  Kernel                   Secure world
> -      ~~~~~~~~~~                  ~~~~~~                   ~~~~~~~~~~~~
> -   +--------+                                             +-------------+
> -   | Client |                                             | Trusted     |
> -   +--------+                                             | Application |
> -      /\                                                  +-------------+
> -      || +----------+                                           /\
> -      || |tee-      |                                           ||
> -      || |supplicant|                                           \/
> -      || +----------+                                     +-------------+
> -      \/      /\                                          | TEE Internal|
> -   +-------+  ||                                          | API         |
> -   + TEE   |  ||            +--------+--------+           +-------------+
> -   | Client|  ||            | TEE    | OP-TEE |           | OP-TEE      |
> -   | API   |  \/            | subsys | driver |           | Trusted OS  |
> -   +-------+----------------+----+-------+----+-----------+-------------+
> -   |      Generic TEE API        |       |     OP-TEE MSG               |
> -   |      IOCTL (TEE_IOC_*)      |       |     SMCCC (OPTEE_SMC_CALL_*) |
> -   +-----------------------------+       +------------------------------+
> -
> -RPC (Remote Procedure Call) are requests from secure world to kernel driver
> -or tee-supplicant. An RPC is identified by a special range of SMCCC return
> -values from OPTEE_SMC_CALL_WITH_ARG. RPC messages which are intended for the
> -kernel are handled by the kernel driver. Other RPC messages will be forwarded to
> -tee-supplicant without further involvement of the driver, except switching
> -shared memory buffer representation.
> -
> -OP-TEE device enumeration
> --------------------------
> -
> -OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> -order to support device enumeration. In other words, OP-TEE driver invokes this
> -application to retrieve a list of Trusted Applications which can be registered
> -as devices on the TEE bus.
> -
> -OP-TEE notifications
> ---------------------
> -
> -There are two kinds of notifications that secure world can use to make
> -normal world aware of some event.
> -
> -1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> -   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> -2. Asynchronous notifications delivered with a combination of a non-secure
> -   edge-triggered interrupt and a fast call from the non-secure interrupt
> -   handler.
> -
> -Synchronous notifications are limited by depending on RPC for delivery,
> -this is only usable when secure world is entered with a yielding call via
> -``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> -world interrupt handlers.
> -
> -An asynchronous notification is delivered via a non-secure edge-triggered
> -interrupt to an interrupt handler registered in the OP-TEE driver. The
> -actual notification value are retrieved with the fast call
> -``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
> -multiple notifications.
> -
> -One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> -special meaning. When this value is received it means that normal world is
> -supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> -call is done from the thread assisting the interrupt handler. This is a
> -building block for OP-TEE OS in secure world to implement the top half and
> -bottom half style of device drivers.
> -
> -OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> -----------------------------------------
> -
> -The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
> -BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
> -it from the firmware before the kernel boots. This also requires enabling the
> -corresponding option in Trusted Firmware for Arm. The Trusted Firmware for Arm
> -documentation [8] explains the security threat associated with enabling this as
> -well as mitigations at the firmware and platform level.
> -
> -There are additional attack vectors/mitigations for the kernel that should be
> -addressed when using this option.
> -
> -1. Boot chain security.
> -
> -   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
> -     the system.
> -
> -   * Mitigation: There must be boot chain security that verifies the kernel and
> -     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> -     modifying it in the rootfs.
> -
> -2. Alternate boot modes.
> -
> -   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
> -     OP-TEE driver isn't loaded, leaving the SMC hole open.
> -
> -   * Mitigation: If there are alternate methods of booting the device, such as a
> -     recovery mode, it should be ensured that the same mitigations are applied
> -     in that mode.
> -
> -3. Attacks prior to SMC invocation.
> -
> -   * Attack vector: Code that is executed prior to issuing the SMC call to load
> -     OP-TEE can be exploited to then load an alternate OS image.
> -
> -   * Mitigation: The OP-TEE driver must be loaded before any potential attack
> -     vectors are opened up. This should include mounting of any modifiable
> -     filesystems, opening of network ports or communicating with external
> -     devices (e.g. USB).
> -
> -4. Blocking SMC call to load OP-TEE.
> -
> -   * Attack vector: Prevent the driver from being probed, so the SMC call to
> -     load OP-TEE isn't executed when desired, leaving it open to being executed
> -     later and loading a modified OS.
> -
> -   * Mitigation: It is recommended to build the OP-TEE driver as builtin driver
> -     rather than as a module to prevent exploits that may cause the module to
> -     not be loaded.
> -
> -AMD-TEE driver
> -==============
> -
> -The AMD-TEE driver handles the communication with AMD's TEE environment. The
> -TEE environment is provided by AMD Secure Processor.
> -
> -The AMD Secure Processor (formerly called Platform Security Processor or PSP)
> -is a dedicated processor that features ARM TrustZone technology, along with a
> -software-based Trusted Execution Environment (TEE) designed to enable
> -third-party Trusted Applications. This feature is currently enabled only for
> -APUs.
> -
> -The following picture shows a high level overview of AMD-TEE::
> -
> -                                             |
> -    x86                                      |
> -                                             |
> - User space            (Kernel space)        |    AMD Secure Processor (PSP)
> - ~~~~~~~~~~            ~~~~~~~~~~~~~~        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~
> -                                             |
> - +--------+                                  |       +-------------+
> - | Client |                                  |       | Trusted     |
> - +--------+                                  |       | Application |
> -     /\                                      |       +-------------+
> -     ||                                      |             /\
> -     ||                                      |             ||
> -     ||                                      |             \/
> -     ||                                      |         +----------+
> -     ||                                      |         |   TEE    |
> -     ||                                      |         | Internal |
> -     \/                                      |         |   API    |
> - +---------+           +-----------+---------+         +----------+
> - | TEE     |           | TEE       | AMD-TEE |         | AMD-TEE  |
> - | Client  |           | subsystem | driver  |         | Trusted  |
> - | API     |           |           |         |         |   OS     |
> - +---------+-----------+----+------+---------+---------+----------+
> - |   Generic TEE API        |      | ASP     |      Mailbox       |
> - |   IOCTL (TEE_IOC_*)      |      | driver  | Register Protocol  |
> - +--------------------------+      +---------+--------------------+
> -
> -At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
> -CPU to PSP mailbox register to submit commands to the PSP. The format of the
> -command buffer is opaque to the ASP driver. It's role is to submit commands to
> -the secure processor and return results to AMD-TEE driver. The interface
> -between AMD-TEE driver and AMD Secure Processor driver can be found in [6].
> -
> -The AMD-TEE driver packages the command buffer payload for processing in TEE.
> -The command buffer format for the different TEE commands can be found in [7].
> -
> -The TEE commands supported by AMD-TEE Trusted OS are:
> -
> -* TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
> -                                TEE environment.
> -* TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
> -* TEE_CMD_ID_OPEN_SESSION     - opens a session with a loaded TA.
> -* TEE_CMD_ID_CLOSE_SESSION    - closes session with loaded TA
> -* TEE_CMD_ID_INVOKE_CMD       - invokes a command with loaded TA
> -* TEE_CMD_ID_MAP_SHARED_MEM   - maps shared memory
> -* TEE_CMD_ID_UNMAP_SHARED_MEM - unmaps shared memory
> -
> -AMD-TEE Trusted OS is the firmware running on AMD Secure Processor.
> -
> -The AMD-TEE driver registers itself with TEE subsystem and implements the
> -following driver function callbacks:
> -
> -* get_version - returns the driver implementation id and capability.
> -* open - sets up the driver context data structure.
> -* release - frees up driver resources.
> -* open_session - loads the TA binary and opens session with loaded TA.
> -* close_session -  closes session with loaded TA and unloads it.
> -* invoke_func - invokes a command with loaded TA.
> -
> -cancel_req driver callback is not supported by AMD-TEE.
> -
> -The GlobalPlatform TEE Client API [5] can be used by the user space (client) to
> -talk to AMD's TEE. AMD's TEE provides a secure environment for loading, opening
> -a session, invoking commands and closing session with TA.
> -
> -References
> -==========
> -
> -[1] https://github.com/OP-TEE/optee_os
> -
> -[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> -
> -[3] drivers/tee/optee/optee_smc.h
> -
> -[4] drivers/tee/optee/optee_msg.h
> -
> -[5] http://www.globalplatform.org/specificationsdevice.asp look for
> -    "TEE Client API Specification v1.0" and click download.
> -
> -[6] include/linux/psp-tee.h
> -
> -[7] drivers/tee/amdtee/amdtee_if.h
> -
> -[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 90a0535a932a..1666f11de8df 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -86,3 +86,4 @@ Storage interfaces
>     misc-devices/index
>     peci/index
>     wmi/index
> +   tee/index
> diff --git a/Documentation/tee/amd-tee.rst b/Documentation/tee/amd-tee.rst
> new file mode 100644
> index 000000000000..51500fde7038
> --- /dev/null
> +++ b/Documentation/tee/amd-tee.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================================
> +AMD-TEE (AMD's Trusted Execution Environment)
> +=============================================
> +
> +The AMD-TEE driver handles the communication with AMD's TEE environment. The
> +TEE environment is provided by AMD Secure Processor.
> +
> +The AMD Secure Processor (formerly called Platform Security Processor or PSP)
> +is a dedicated processor that features ARM TrustZone technology, along with a
> +software-based Trusted Execution Environment (TEE) designed to enable
> +third-party Trusted Applications. This feature is currently enabled only for
> +APUs.
> +
> +The following picture shows a high level overview of AMD-TEE::
> +
> +                                             |
> +    x86                                      |
> +                                             |
> + User space            (Kernel space)        |    AMD Secure Processor (PSP)
> + ~~~~~~~~~~            ~~~~~~~~~~~~~~        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~
> +                                             |
> + +--------+                                  |       +-------------+
> + | Client |                                  |       | Trusted     |
> + +--------+                                  |       | Application |
> +     /\                                      |       +-------------+
> +     ||                                      |             /\
> +     ||                                      |             ||
> +     ||                                      |             \/
> +     ||                                      |         +----------+
> +     ||                                      |         |   TEE    |
> +     ||                                      |         | Internal |
> +     \/                                      |         |   API    |
> + +---------+           +-----------+---------+         +----------+
> + | TEE     |           | TEE       | AMD-TEE |         | AMD-TEE  |
> + | Client  |           | subsystem | driver  |         | Trusted  |
> + | API     |           |           |         |         |   OS     |
> + +---------+-----------+----+------+---------+---------+----------+
> + |   Generic TEE API        |      | ASP     |      Mailbox       |
> + |   IOCTL (TEE_IOC_*)      |      | driver  | Register Protocol  |
> + +--------------------------+      +---------+--------------------+
> +
> +At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
> +CPU to PSP mailbox register to submit commands to the PSP. The format of the
> +command buffer is opaque to the ASP driver. It's role is to submit commands to
> +the secure processor and return results to AMD-TEE driver. The interface
> +between AMD-TEE driver and AMD Secure Processor driver can be found in [1].
> +
> +The AMD-TEE driver packages the command buffer payload for processing in TEE.
> +The command buffer format for the different TEE commands can be found in [2].
> +
> +The TEE commands supported by AMD-TEE Trusted OS are:
> +
> +* TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
> +                                TEE environment.
> +* TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
> +* TEE_CMD_ID_OPEN_SESSION     - opens a session with a loaded TA.
> +* TEE_CMD_ID_CLOSE_SESSION    - closes session with loaded TA
> +* TEE_CMD_ID_INVOKE_CMD       - invokes a command with loaded TA
> +* TEE_CMD_ID_MAP_SHARED_MEM   - maps shared memory
> +* TEE_CMD_ID_UNMAP_SHARED_MEM - unmaps shared memory
> +
> +AMD-TEE Trusted OS is the firmware running on AMD Secure Processor.
> +
> +The AMD-TEE driver registers itself with TEE subsystem and implements the
> +following driver function callbacks:
> +
> +* get_version - returns the driver implementation id and capability.
> +* open - sets up the driver context data structure.
> +* release - frees up driver resources.
> +* open_session - loads the TA binary and opens session with loaded TA.
> +* close_session -  closes session with loaded TA and unloads it.
> +* invoke_func - invokes a command with loaded TA.
> +
> +cancel_req driver callback is not supported by AMD-TEE.
> +
> +The GlobalPlatform TEE Client API [3] can be used by the user space (client) to
> +talk to AMD's TEE. AMD's TEE provides a secure environment for loading, opening
> +a session, invoking commands and closing session with TA.
> +
> +References
> +==========
> +
> +[1] include/linux/psp-tee.h
> +
> +[2] drivers/tee/amdtee/amdtee_if.h
> +
> +[3] http://www.globalplatform.org/specificationsdevice.asp look for
> +    "TEE Client API Specification v1.0" and click download.
> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
> new file mode 100644
> index 000000000000..a23bd08847e5
> --- /dev/null
> +++ b/Documentation/tee/index.rst
> @@ -0,0 +1,19 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +TEE Subsystem
> +=============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   tee
> +   op-tee
> +   amd-tee
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/tee/op-tee.rst b/Documentation/tee/op-tee.rst
> new file mode 100644
> index 000000000000..b0ac097d5547
> --- /dev/null
> +++ b/Documentation/tee/op-tee.rst
> @@ -0,0 +1,166 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================================
> +OP-TEE (Open Portable Trusted Execution Environment)
> +====================================================
> +
> +The OP-TEE driver handles OP-TEE [1] based TEEs. Currently it is only the ARM
> +TrustZone based OP-TEE solution that is supported.
> +
> +Lowest level of communication with OP-TEE builds on ARM SMC Calling
> +Convention (SMCCC) [2], which is the foundation for OP-TEE's SMC interface
> +[3] used internally by the driver. Stacked on top of that is OP-TEE Message
> +Protocol [4].
> +
> +OP-TEE SMC interface provides the basic functions required by SMCCC and some
> +additional functions specific for OP-TEE. The most interesting functions are:
> +
> +- OPTEE_SMC_FUNCID_CALLS_UID (part of SMCCC) returns the version information
> +  which is then returned by TEE_IOC_VERSION
> +
> +- OPTEE_SMC_CALL_GET_OS_UUID returns the particular OP-TEE implementation, used
> +  to tell, for instance, a TrustZone OP-TEE apart from an OP-TEE running on a
> +  separate secure co-processor.
> +
> +- OPTEE_SMC_CALL_WITH_ARG drives the OP-TEE message protocol
> +
> +- OPTEE_SMC_GET_SHM_CONFIG lets the driver and OP-TEE agree on which memory
> +  range to used for shared memory between Linux and OP-TEE.
> +
> +The GlobalPlatform TEE Client API [5] is implemented on top of the generic
> +TEE API.
> +
> +Picture of the relationship between the different components in the
> +OP-TEE architecture::
> +
> +      User space                  Kernel                   Secure world
> +      ~~~~~~~~~~                  ~~~~~~                   ~~~~~~~~~~~~
> +   +--------+                                             +-------------+
> +   | Client |                                             | Trusted     |
> +   +--------+                                             | Application |
> +      /\                                                  +-------------+
> +      || +----------+                                           /\
> +      || |tee-      |                                           ||
> +      || |supplicant|                                           \/
> +      || +----------+                                     +-------------+
> +      \/      /\                                          | TEE Internal|
> +   +-------+  ||                                          | API         |
> +   + TEE   |  ||            +--------+--------+           +-------------+
> +   | Client|  ||            | TEE    | OP-TEE |           | OP-TEE      |
> +   | API   |  \/            | subsys | driver |           | Trusted OS  |
> +   +-------+----------------+----+-------+----+-----------+-------------+
> +   |      Generic TEE API        |       |     OP-TEE MSG               |
> +   |      IOCTL (TEE_IOC_*)      |       |     SMCCC (OPTEE_SMC_CALL_*) |
> +   +-----------------------------+       +------------------------------+
> +
> +RPC (Remote Procedure Call) are requests from secure world to kernel driver
> +or tee-supplicant. An RPC is identified by a special range of SMCCC return
> +values from OPTEE_SMC_CALL_WITH_ARG. RPC messages which are intended for the
> +kernel are handled by the kernel driver. Other RPC messages will be forwarded to
> +tee-supplicant without further involvement of the driver, except switching
> +shared memory buffer representation.
> +
> +OP-TEE device enumeration
> +-------------------------
> +
> +OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> +order to support device enumeration. In other words, OP-TEE driver invokes this
> +application to retrieve a list of Trusted Applications which can be registered
> +as devices on the TEE bus.
> +
> +OP-TEE notifications
> +--------------------
> +
> +There are two kinds of notifications that secure world can use to make
> +normal world aware of some event.
> +
> +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> +2. Asynchronous notifications delivered with a combination of a non-secure
> +   edge-triggered interrupt and a fast call from the non-secure interrupt
> +   handler.
> +
> +Synchronous notifications are limited by depending on RPC for delivery,
> +this is only usable when secure world is entered with a yielding call via
> +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> +world interrupt handlers.
> +
> +An asynchronous notification is delivered via a non-secure edge-triggered
> +interrupt to an interrupt handler registered in the OP-TEE driver. The
> +actual notification value are retrieved with the fast call
> +``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
> +multiple notifications.
> +
> +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> +special meaning. When this value is received it means that normal world is
> +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> +call is done from the thread assisting the interrupt handler. This is a
> +building block for OP-TEE OS in secure world to implement the top half and
> +bottom half style of device drivers.
> +
> +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> +----------------------------------------
> +
> +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
> +BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
> +it from the firmware before the kernel boots. This also requires enabling the
> +corresponding option in Trusted Firmware for Arm. The Trusted Firmware for Arm
> +documentation [6] explains the security threat associated with enabling this as
> +well as mitigations at the firmware and platform level.
> +
> +There are additional attack vectors/mitigations for the kernel that should be
> +addressed when using this option.
> +
> +1. Boot chain security.
> +
> +   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
> +     the system.
> +
> +   * Mitigation: There must be boot chain security that verifies the kernel and
> +     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> +     modifying it in the rootfs.
> +
> +2. Alternate boot modes.
> +
> +   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
> +     OP-TEE driver isn't loaded, leaving the SMC hole open.
> +
> +   * Mitigation: If there are alternate methods of booting the device, such as a
> +     recovery mode, it should be ensured that the same mitigations are applied
> +     in that mode.
> +
> +3. Attacks prior to SMC invocation.
> +
> +   * Attack vector: Code that is executed prior to issuing the SMC call to load
> +     OP-TEE can be exploited to then load an alternate OS image.
> +
> +   * Mitigation: The OP-TEE driver must be loaded before any potential attack
> +     vectors are opened up. This should include mounting of any modifiable
> +     filesystems, opening of network ports or communicating with external
> +     devices (e.g. USB).
> +
> +4. Blocking SMC call to load OP-TEE.
> +
> +   * Attack vector: Prevent the driver from being probed, so the SMC call to
> +     load OP-TEE isn't executed when desired, leaving it open to being executed
> +     later and loading a modified OS.
> +
> +   * Mitigation: It is recommended to build the OP-TEE driver as builtin driver
> +     rather than as a module to prevent exploits that may cause the module to
> +     not be loaded.
> +
> +References
> +==========
> +
> +[1] https://github.com/OP-TEE/optee_os
> +
> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> +
> +[3] drivers/tee/optee/optee_smc.h
> +
> +[4] drivers/tee/optee/optee_msg.h
> +
> +[5] http://www.globalplatform.org/specificationsdevice.asp look for
> +    "TEE Client API Specification v1.0" and click download.
> +
> +[6] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
> diff --git a/Documentation/tee/tee.rst b/Documentation/tee/tee.rst
> new file mode 100644
> index 000000000000..fd9f8c4ff63d
> --- /dev/null
> +++ b/Documentation/tee/tee.rst
> @@ -0,0 +1,22 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +TEE (Trusted Execution Environment)
> +===================================
> +
> +This document describes the TEE subsystem in Linux.
> +
> +Overview
> +========
> +
> +A TEE is a trusted OS running in some secure environment, for example,
> +TrustZone on ARM CPUs, or a separate secure co-processor etc. A TEE driver
> +handles the details needed to communicate with the TEE.
> +
> +This subsystem deals with:
> +
> +- Registration of TEE drivers
> +
> +- Managing shared memory between Linux and the TEE
> +
> +- Providing a generic API to the TEE
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 72a65db0c498..24ed39735dd3 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ place where this information is gathered.
>     sysfs-platform_profile
>     vduse
>     futex2
> +   tee
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/userspace-api/tee.rst b/Documentation/userspace-api/tee.rst
> new file mode 100644
> index 000000000000..e2368dbc3451
> --- /dev/null
> +++ b/Documentation/userspace-api/tee.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. tee:
> +
> +==================================================
> +TEE (Trusted Execution Environment) Userspace API
> +==================================================
> +
> +include/uapi/linux/tee.h defines the generic interface to a TEE.
> +
> +User space (the client) connects to the driver by opening /dev/tee[0-9]* or
> +/dev/teepriv[0-9]*.
> +
> +- TEE_IOC_SHM_ALLOC allocates shared memory and returns a file descriptor
> +  which user space can mmap. When user space doesn't need the file
> +  descriptor any more, it should be closed. When shared memory isn't needed
> +  any longer it should be unmapped with munmap() to allow the reuse of
> +  memory.
> +
> +- TEE_IOC_VERSION lets user space know which TEE this driver handles and
> +  its capabilities.
> +
> +- TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.
> +
> +- TEE_IOC_INVOKE invokes a function in a Trusted Application.
> +
> +- TEE_IOC_CANCEL may cancel an ongoing TEE_IOC_OPEN_SESSION or TEE_IOC_INVOKE.
> +
> +- TEE_IOC_CLOSE_SESSION closes a session to a Trusted Application.
> +
> +There are two classes of clients, normal clients and supplicants. The latter is
> +a helper process for the TEE to access resources in Linux, for example file
> +system access. A normal client opens /dev/tee[0-9]* and a supplicant opens
> +/dev/teepriv[0-9].
> +
> +Much of the communication between clients and the TEE is opaque to the
> +driver. The main job for the driver is to receive requests from the
> +clients, forward them to the TEE and send back the results. In the case of
> +supplicants the communication goes in the other direction, the TEE sends
> +requests to the supplicant which then sends back the result.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..f20d5fb19ebc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21130,7 +21130,9 @@ M:	Jens Wiklander <jens.wiklander@linaro.org>
>  R:	Sumit Garg <sumit.garg@linaro.org>
>  L:	op-tee@lists.trustedfirmware.org
>  S:	Maintained
> -F:	Documentation/staging/tee.rst
> +F:	Documentation/driver-api/tee.rst
> +F:	Documentation/tee/
> +F:	Documentation/userspace-api/tee.rst
>  F:	drivers/tee/
>  F:	include/linux/tee_drv.h
>  F:	include/uapi/linux/tee.h
