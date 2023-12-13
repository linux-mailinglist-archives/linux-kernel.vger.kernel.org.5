Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F98110A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378394AbjLML6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjLML6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:58:19 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA55B0;
        Wed, 13 Dec 2023 03:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqT2RufPvll+uukasx0gIhATP5NBIlaDYip6VzYDTgwiIbG2tOKfCnYcCzRLc3l7SYhN/Zc6nj9GF4tSZwwxqW3Ojk4GLpYX2Gdp1QAZKbr46DHjP0AakuWIxbYG4jdMZULeK6V2etaZhXr10Kcxs/8f+RsK/zD+6aY9jZkSm4lZ8ztsC+1XpJuCqwli1wAl8cqFymPSSZsUAv3KpwRRwXarhQJhCMDQLfKOK3IbngLTjgWQU16mYa5kNQK4xbvtVSxkYdw205PRhLd0Iv4TRRmXkVUb0lchUyfVeLagTPhJpRs0MhwqhbDLHKxFfm5Iqev/7hq9ADXqRww2jPiiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8ydXiPb8e4RmXEarlvDoxQ1avnitacvQpnJwjAnDps=;
 b=jNGHoLZ1Ly0r/X04WSvjRhyjzFRkFiIHgJJHio6pBUEibUI8ZBMQt/4eVotp9Y00+ZGoIgh+9OZ+uHlM766LHh9ciV2Bkh8YEGrp5hMApXInPN3bcZtwQ1ZGDzjDpcdZDRwq3knbTlgLBfOxN4O14hCPvL0t9Y+XqN7Xuov1geUfsq/LdVNy28u+cU/EdNX6WWIuUnhITIWg96wUl/9Orscke/xVXHt3LvQQAN2Rbbs7GUboQksMVk2qKSpQHPQDV/aI1yVLCVEFPOa8guE5N2INDLBibzKy2Zgbuw7yhMA5aiV5KebLELLiphOZ6CRIVEL1YCJVhkA1Bgm4hVdDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ydXiPb8e4RmXEarlvDoxQ1avnitacvQpnJwjAnDps=;
 b=SSkqpBQVxfDS+Jasd2VXzJmjm+rZxx+6R3qgFxNqrRGHV9jclrRivGB0s8EDghtCI4MAP/12ry/9DNMgrnVhJIg+NZZNWKCrje2cAoprw7dJqJRsrOYo/B5S1KPOmQAWI8d3SZc0b7iazf4X/Siqt82yEPgPjrmyyOwhA5hDC5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 11:58:21 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 11:58:21 +0000
Message-ID: <e1b45051-54c8-1d26-9366-dba2c2d621a8@amd.com>
Date:   Wed, 13 Dec 2023 17:28:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-2-Sanath.S@amd.com>
 <20231213055941.GJ1074920@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20231213055941.GJ1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 9950bef8-2b1b-4518-fb01-08dbfbd2cd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvRkEh8SGrHH5tL5JxpydgRjpRL/dYMJT+j8acB9MoAl1iYlJxkmvPgG2sEGepFvu6yNCYB/Qwoz3CpCWUnyKXINPzE7ockExv0ZynbjTx3lzzoM1XeV7RxN9z0ASBRd4h4FB/VyAfSK5NIrnG3tH2zTqDRhTwUyUVEFRF4m+hHEOTLTkzQUF9kmtIPj8OA3fyG1hZjI0fxAJh7JHiGvGKf9G1SPjuS0a+s5dFQr7hD7rWAzWL+J8KHbtdmOlX3utYtpGyTmkpfpBAj7mM8t1WaWAUoAoMPaOd/U1UZgXkmUWGkCZGxfUUcMx52QJVbPw4L4QZHjcQrnwUXmOjyK31qBhCWlkHjXDFopXfTeo+1wRVtoeOa4vHv53a9coonz7UwPTYHYlLqI4zu1AAt27nwCNnz7ZZul2v15paGl3mPrRU6ILYjpPQaDzBeKsAIu255zzReO2nuxynZNiA5zSqUZhKsz+oggth9Jd+iNzcml04Imz9B3eUKGDgFMjF/lxUNH6LMkhRhEehX5v3eJxebQjcpk6ncaFUFJSAqXDeJChbtrosmwTLremgPKGk/B/CdAjVFJJbQZhjC0N49O73AcpSY8LIf/2FiBeio7PRbZ8RD7OW7iZzczH6fO6Q8kfFyEyu+YWIRthsXNvhguFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(66574015)(83380400001)(53546011)(6506007)(2616005)(6512007)(38100700002)(5660300002)(8676002)(4326008)(8936002)(41300700001)(2906002)(6486002)(478600001)(6666004)(110136005)(316002)(6636002)(66556008)(66476007)(66946007)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllQSWJ3bGZoaU5NSk5CT0pzaFV3T2hCTGpWaEdnWHJJaTFaTzRCMXJJMWRZ?=
 =?utf-8?B?c3RCTjFleHB0b3dYbmNpNmdMQ09vcG5NRmpsRzdrTTdHNnp5c0ZFTHpqZk9C?=
 =?utf-8?B?Q2o4UDlRVTBMRkpzdVo0S0crM05xUVQyREhDeEd0dnN0R2Uxc09LcVA3YVpZ?=
 =?utf-8?B?L1hGMHBJV1J5aUdnT3A3YVZGWElqMjRzYWVmV3ZLUDI4SGtNZWNsV3VGcUo5?=
 =?utf-8?B?RC82SzlPeWZZZVYzL1JDWWJVTmE1R05ZZFU0Y09xcmFYelRRb2lJT29HNncv?=
 =?utf-8?B?dUVMSlc0RlVQa2VTbXhCSzJNZHZYTWJWUXVoZmRhMVVIa1hHa0VqWVlBZk90?=
 =?utf-8?B?bWZTUmZtTHVTL2c5TURZalJSM1M0dng2Z1RNSnB0UHBZWHdlUUh5T2kvQUhx?=
 =?utf-8?B?SlloVVlEVWpZM0oxUjBxZWEvajBhRlVXMGFkYkpIUVdzOXh1bDVFVXdUYXo4?=
 =?utf-8?B?b1FKTW9mK2U2bEh4N0VyWFNaWTJ4Qnk0NkI2YnRtZ1hiM082RklkUFpzb0V1?=
 =?utf-8?B?YzJNYmxKczhoRUtXazRhQWNqRDh1aTBWL0pvOWNRR2RQdWtoMG9oTG1FVFdK?=
 =?utf-8?B?aGNMRTdHQ3ArZS9zQVpLaGF1VzNNZmNmYlEyTHkwOHhjbWNlRUc4eU5oV21P?=
 =?utf-8?B?TEVRMS9pYUxaUkdBRXZsb2hjYW5FODQydjlRdWNIbFBrYlZqWGEyN1B0b09i?=
 =?utf-8?B?azFIbEZyamVWRVZ5Y2c1S2tIeVRORFZsRENGa0xYdEJNdHQ5TkgxMlQ5VTZy?=
 =?utf-8?B?Vk5SSmEwcmtSSU4rVzBUa3pWbWhpVmJBZU1zd2Zsb1hTS3E1ZVBxVm4xcmRo?=
 =?utf-8?B?RU55S3FVZVFuZlRrbEtqSGdqR0xHM2tQVFFVRTFlWk5NWmlmUXdnTHUvU1JZ?=
 =?utf-8?B?MG5GWmlWNFNTbWE1VVhtYnpTOHF5YlNpdy9keUlUUFBGSE92YkdvZXRVaU02?=
 =?utf-8?B?TW5QTXV1QVRuSlZRM1grcWtGZ1FheTNCeXlDb2pFS1FkOGcyb2wwWlZaTmVn?=
 =?utf-8?B?RzhzenRQaE9YbSt1TTJYOTZRV1BnLzFSOGlxcTBMbXduZUg4azVyNkF0T2J1?=
 =?utf-8?B?KzduRmxFOUVBcmluWENLS1UrYXBDa3N3UlRFN2g5OWF0OVVROGh4MjNDQ0RP?=
 =?utf-8?B?bzdQUE5KYTlERkJHV21lWWNYL1FiQkhTT2dXVHREUjducklwTllHVlB6cDNs?=
 =?utf-8?B?d0pUSlhLNVF4aDEzeVQ1N1NBYitxTVkyREJ2RWd1Z1V3REI4aHVhRmdHdE1v?=
 =?utf-8?B?M2hyOFFlNGhSQXlGL01JUU0xcmxBL3JYemQ2QjF4UGhYMDZkWVlmdXFrSElE?=
 =?utf-8?B?MmJlY0cxMWRPa2VGYmRlSnY5V3VxQWJkcjdIcGh6cS9yZ2x4b05ObVhIZDh4?=
 =?utf-8?B?Sm93bDE4Zng2N0RYVW03d01Jd0xNbTU2azlkbWY5WkwwLys3SW8wanJkYnhw?=
 =?utf-8?B?NlBMOEU4MEdEN0RQdkxSWk1MZ0daZlVZaUorODlTSmJvMmNONjBDaFZyU0M4?=
 =?utf-8?B?WjZUcTZ6dWhQU0NvTWhWNENkVUhoTlkycWUremtGeUVLL2FoaXVMcmtIZ0Nk?=
 =?utf-8?B?ZkdpNmppcGR5NnNac21VZFBVVzB0MmNtSHpsdExPQmttQUhOazlBbXVjUnEv?=
 =?utf-8?B?bG5JRlM5TXJTU09xV25adGtRTjhodkNRdW83WDRzY0FadkpUWnp4NzBpNFQv?=
 =?utf-8?B?cnlGVHR0VGlwMWhudkVqMFpvM3VlLzg3ZUJ4bWc3c1pVTHpySnlHVTF3WkhG?=
 =?utf-8?B?LzZrRmVTNnZWNEpzU1RuK25hUmlHUDNZSTRJd1dQMWJFOVJ6UDFLUmFwNWli?=
 =?utf-8?B?Z3A1TWhrSWlDWWdPMThZVC8yUk9Pd25vMk5qZCtSUXUxVDgvTWx1RXg1SmJq?=
 =?utf-8?B?NEJtdFlBT0Z6RGdOVVlFd3pDZTBycnBrUlFCZXgzQ3VIZExpYS83M0NLL2pm?=
 =?utf-8?B?MDVOSGUxc3B1UmpXYnhiM2JBL0FaM1FzbHdUY3ZrMm1pVlhSNXJyTk5vaGxE?=
 =?utf-8?B?MTBrWUJaVDN1TnJLcTEwcXNHalpjUjB6MWpDOHA2SUNjaDc3QnFDMElBRjBC?=
 =?utf-8?B?MXVXbDJaMHFPRnVBNVJ2OUdGUDdZM1Vpa3puMFJFdEZOWENhVml1MnoyUXBT?=
 =?utf-8?Q?7HSfZHyI3oGhBlyH4Dxl4KabW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9950bef8-2b1b-4518-fb01-08dbfbd2cd75
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 11:58:21.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W8z4k7DoFjSZMMaMRtaLbM67dHk9EQJywSpWknLrahKXyM0XiK0nUmN2uQ2rRnSwvsLm8FwBgJWPHLlrdpLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/2023 11:29 AM, Mika Westerberg wrote:
> On Wed, Dec 13, 2023 at 12:46:34AM +0530, Sanath S wrote:
>> Introduce the tb_switch_reset_ports() function that resets the
>> downstream ports of a given switch. This helps us reset the USB4
>> links created by boot firmware during the init sequence.
>>
>> Introduce the tb_port_reset() helper function that resets the
>> given port.
>>
>> Introduce the usb4_port_reset() function that performs the DPR
>> of a given port. This function follows the CM guide specification 7.3
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> ---
>>   drivers/thunderbolt/switch.c  | 35 +++++++++++++++++++++++++++++++
>>   drivers/thunderbolt/tb.h      |  2 ++
>>   drivers/thunderbolt/tb_regs.h |  1 +
>>   drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 77 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>> index 44e9b09de47a..ef7ed92fd48e 100644
>> --- a/drivers/thunderbolt/switch.c
>> +++ b/drivers/thunderbolt/switch.c
>> @@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * tb_port_reset() - Reset downstream port
>> + * @port: Port to reset
>> + *
>> + * Helps to reconfigure the USB4 link by resetting the downstream port.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
>> + */
>> +static int tb_port_reset(struct tb_port *port)
>> +{
>> +	return usb4_port_reset(port);
>> +}
>> +
>>   static int __tb_port_enable(struct tb_port *port, bool enable)
>>   {
>>   	int ret;
>> @@ -1547,6 +1560,28 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>>   	       regs->__unknown1, regs->__unknown4);
>>   }
>>   
>> +/**
>> + * tb_switch_reset_ports() - Reset downstream ports of switch.
> Drop the '.'
Ack.
>> + * @sw: Switch whose ports need to be reset.
>> + *
>> + * This is applicable only for USB4 routers.
>> + * tb_switch_is_usb4() needs to be called before calling this
>> + * function.
> This should fit into 2 lines:
>
> 	* This is applicable only for USB4 routers. tb_switch_is_usb4()
> 	* needs to be called before calling this function.
Ack.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
> Specifically returns %-EOPNOTSUPP if the router does not support this
> (e.g is not USB4 router).
>
>> + */
>> +int tb_switch_reset_ports(struct tb_switch *sw)
>> +{
>> +	struct tb_port *port;
>> +	int ret = -EOPNOTSUPP;
> Reverse christmas tree:
>
> 	int ret = -EOPNOTSUPP;
> 	struct tb_port *port;
Ack.
>> +
>> +	tb_switch_for_each_port(sw, port) {
>> +		if (tb_port_is_null(port) && port->cap_usb4)
>> +			return tb_port_reset(port);
> Now you run this only once for the first lane adapter it finds.
>
> How much you actually tested this patch series? :(

I've tested this patch on multiple TBT4 docks like OWC, Kenningston and 
Lenovo on
reboot/suspend-resume/hotplug scenarios.

> Since we are already in -rc5 it is unlikely that behavioral changes like
> this will go to the next release (v6.8-rc1), so you have all that time
> to make sure your patches work as expected.
Agreed. Since this is a behavioral change it needs more testing and 
refinement on how
we can reset the switch and its ports.
>> +	}
>> +	return ret;
>> +}
>> +
>>   /**
>>    * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>>    * @sw: Switch to reset
>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>> index e299e53473ae..f2687ec4ac53 100644
>> --- a/drivers/thunderbolt/tb.h
>> +++ b/drivers/thunderbolt/tb.h
>> @@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
>>   void tb_switch_suspend(struct tb_switch *sw, bool runtime);
>>   int tb_switch_resume(struct tb_switch *sw);
>>   int tb_switch_reset(struct tb_switch *sw);
>> +int tb_switch_reset_ports(struct tb_switch *sw);
>>   int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>>   			   u32 value, int timeout_msec);
>>   void tb_sw_set_unplugged(struct tb_switch *sw);
>> @@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
>>   int usb4_switch_add_ports(struct tb_switch *sw);
>>   void usb4_switch_remove_ports(struct tb_switch *sw);
>>   
>> +int usb4_port_reset(struct tb_port *port);
>>   int usb4_port_unlock(struct tb_port *port);
>>   int usb4_port_hotplug_enable(struct tb_port *port);
>>   int usb4_port_configure(struct tb_port *port);
>> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
>> index 87e4795275fe..d49530bc0d53 100644
>> --- a/drivers/thunderbolt/tb_regs.h
>> +++ b/drivers/thunderbolt/tb_regs.h
>> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>>   #define PORT_CS_18_CSA				BIT(22)
>>   #define PORT_CS_18_TIP				BIT(24)
>>   #define PORT_CS_19				0x13
>> +#define PORT_CS_19_DPR				BIT(0)
>>   #define PORT_CS_19_PC				BIT(3)
>>   #define PORT_CS_19_PID				BIT(4)
>>   #define PORT_CS_19_WOC				BIT(16)
>> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
>> index 4277733d0021..c8a4bf33ed1c 100644
>> --- a/drivers/thunderbolt/usb4.c
>> +++ b/drivers/thunderbolt/usb4.c
>> @@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
>>   	}
>>   }
>>   
>> +/**
>> + * usb4_port_reset() - Reset USB4 downsteam port
>> + * @port: USB4 port to reset.
>> + *
>> + * Helps to reconfigure USB4 link by resetting downstream port.
>> + *
>> + * Return: Returns 0 on success or an error code on failure.
>> + */
>> +int usb4_port_reset(struct tb_port *port)
>> +{
>> +	u32 val = 0;
> This initialization is actually not needed.
Ack.
>
>> +	int ret;
>> +
>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = val | PORT_CS_19_DPR;
> val |= PORT_CS_19_DPR;
>
> Same as you do below with &= ~..
Ack.
>
>> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Wait for 10ms after requesting downstream port reset */
>> +	usleep_range(10000, 15000);
>> +
>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +	if (ret)
>> +		return ret;
> Do you really need to read it back from the hardware here?

I don't think it's necessary. But I added this just to be safe if 
performing DPR has
made changes to other CS_19 bits.

>> +
>> +	val &= ~PORT_CS_19_DPR;
>> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
>> +			port->cap_usb4 + PORT_CS_19, 1);
>> +
>> +	return ret;
> This can be simply
>
> 	return tb_port_write(port, &val, TB_CFG_PORT,
> 			     port->cap_usb4 + PORT_CS_19, 1);
Ack.
>> +}
>> +
>>   /**
>>    * usb4_port_unlock() - Unlock USB4 downstream port
>>    * @port: USB4 port to unlock
>> -- 
>> 2.34.1
