Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3B75953C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGSMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGSMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:37:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05A1A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 05:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrBWMLPlbeoRq3HLPJiyfYFMR1LUenIQsdBlkux8FeXZ+mGoEXfH2t4osZreyREizbZySYaanbJWc/yArqYXNnzARrp3cGBtrTw7Ty+uoHdPaXoJoXtye1lgvBqdFSASp88EzOY22aC3J9/Mo2E7f7cy0Wa8P35KfJPnWK1uDUVEWjZuT2jJm1TqoROoapkNeWgpMpXdZWrhoxpaRu9wN4MoxNaNV33YdfaHXIV0gqwco+F27tG5n26qNKjXshtx3Vf2Zz8de0oYPBpTi32Ji/vmy7wsqQuOtNedKYny5Ntcfs8Tkkl5rlclZPZL2JnweNEOIMkUyjueBW1dBrUlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQGHNh9DvWsYN6vGkgLKbMv4uRKIR1EvgPS9Lygaeiw=;
 b=OHWejxiY28vZ4/pPdU7kf3E1o0tdPyBM/Qu2zVdY4Kk98Taw8Qq97c1MvRXE1Ptj4W8vX2VRjU9h8hHKAtKB4hi68uzPXB3SCvtw2aXGpNle10pxtBoHr+8U1kEvqLVYoysG2qp3g0s8Ct7/V0AV1VJAaB/EQJ3H1TLkAVohlo57JK7In88/IKZ+QZ/hJUeFlu1KyDQD2f1TTzIl9RPv++CIsbfM635oNvVtW/smGTj21tXH00Y0HSZgTqowp+Cq20khmt2a+XgpLpGB79kk/3qXrmVGq5O2BcDvvm/6XcEHynaX3ZHDHRoEky6TkF04t62u19J6i7S3NeA680t/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQGHNh9DvWsYN6vGkgLKbMv4uRKIR1EvgPS9Lygaeiw=;
 b=15NqxAO+ro3NxUsT6rqkNvFtdDF/adg8IfYJINLmvUl8wnz4d8FEL1O2mzFJahRpxENONlogSmiRsQ6JT+PS5EZzBCLIKNU3BIxxiAxErG+gUt3GC83O40Vv18cm0U7AOOeD2Awm+5+XwHxwFcheYND4zJb7vACMphppTYkfn4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 12:36:54 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 12:36:54 +0000
Message-ID: <f5b7216c-8e6f-16c4-6902-dc8a04997fb9@amd.com>
Date:   Wed, 19 Jul 2023 18:06:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cdx: add support for bus mastering
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, git@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230718100651.18317-1-nipun.gupta@amd.com>
 <2023071817-floss-visibly-396a@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023071817-floss-visibly-396a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe6864e-ab70-4e5e-dd20-08db8854d555
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHQ5lkuiPlX99Rw+AGhlLBFuCj+o0ePoLngJ+6oyEw8RPPB0NyHvJ+EI5jPL4XPUc2Yg2R87M56vT6iePpG8jRe7lxkuV14K+SV6EoqzYSUEXV9ROmqCle5FHRweBVgNYwN2F5mBVvTS07LIttDKHhyX0t6Qxx42L8Y/IYmOV7QovBngV7nGQ1QdC8oe0UgUTrn0BbEjTZtJ02zBpYxrcNICzvj3SA9gGzjKYtrPej6VvLmOIpqvHMwa0LCTPCf3A46F4nGD99ry3btNhW+TAny5hYx0CPaeN6LC86Oz3FdkbnJbOA4WsToiywatW08DG9ZxfKrIw0oFcjKz2vqtQc5SPUHJqqSr/Jeh9A6nJLzmMv5y5ZUK8gH+TSTZdxGHBvsb+tAkV6Pg0+662+mBWK3/amMajV8FWW/iA9pEEaKRa23M6VNSQ96/C3PejtrIiGugAgpo9yZchUgbeER+1x2XKQi8yRL4KJpkPTNgRcQx0dQPJXMlU1oawh2rZi2vOXfM4VPN2BWFmJC1FMtfHNyXrALOnVSvUcRmw9wqcsRxCcRBH9W9PFOY4KtnL7a/9gQC6ALvU/iup0ceRv+ycJ76F1sIiXogegecr2bUKvfC1fLE5z0Cj5yEqzsynnJagvbjOi3GCFPz/hOrKiFr2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(31686004)(2906002)(6486002)(6666004)(478600001)(66476007)(8936002)(36756003)(41300700001)(316002)(66946007)(6916009)(4326008)(66556008)(186003)(83380400001)(38100700002)(2616005)(86362001)(5660300002)(6512007)(26005)(53546011)(31696002)(8676002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUFDU1cvVkVVVEw4MDBUemorTTVNd1FlOVRyemlLMklzQUhNeURSTE1wa0Ji?=
 =?utf-8?B?bGtTSzlyZHBjN2srTGtkNTJmZHFkbkJIdTVuZDErT2JJVVkwL3VqWFJDK0NB?=
 =?utf-8?B?OVVqckxLeEFIMVNiVGFkaVcvV1hpaWpOR3JvOXZNYmxHSHF6c1p2TXNMTHBS?=
 =?utf-8?B?dERmbkl3d1o5djF0MVNoZDl1SEFwZGxCUWsvK0doOExBQlNOU210TURsamZX?=
 =?utf-8?B?UFhrRklQbmpxc3BLYWt1Q1dJb0NJUXhLZ3dSeENhTjNTQ21DRHpZVXFqSnl0?=
 =?utf-8?B?QXJDTUxBQTRaVlhVQjl2NGdzVTQ2Z3FaUVRqejZJeFRTSXVnWG8rSDVjSXF4?=
 =?utf-8?B?N3RzMWdxaVBOY0RjN0tBYjZ4ZGtzbzlONFhkbFJQL2JqRlNUS3BPenNTOFFj?=
 =?utf-8?B?MmpyUEU4eCtkVkZNZW13K25VaEJWbG5OdjdGUGZmZkEvNUQrTXNIM0tad0I4?=
 =?utf-8?B?QmZCNE5yeE5DdktXZmtqTGJPcTJRanpSWVFmbkxyOUpBZjdxRmlORzB1Skg5?=
 =?utf-8?B?ZE9qVHlzMVR4NkhYNFpRdGpUdFIwTWVQZWlsNlBlTVh0MnIySGM1aXBBR1Bk?=
 =?utf-8?B?QnBZWDJMQ2ZhQ0RFMkg5R2Q0ejl5cEZuM2VXdlpWZHJpTlp0VVVrVTg2S05n?=
 =?utf-8?B?SkFnSGtCdTIreEhEYytyV1VRN3kxT3ExaXN0SkprMUNJa2dxbUtsYU9ieWxC?=
 =?utf-8?B?VlBrMWhSWDA5NUdWVXlKelZhY2lEbzVTaXgyMzlDYkpndXlCZkVuMWFyR1F5?=
 =?utf-8?B?M3d6akZaZGlnLzZCS3dVSU5wcmJCeExWdmVuYXNFZ1ArbTZLZUpSZ2s0OEVo?=
 =?utf-8?B?YVUzbEVYTm1ZS0VYamZIVmRmdG1ya25MNVF0N0xiR1FGcExrbU9lTExXY3Rj?=
 =?utf-8?B?eWNyYi82YzVQYlpja2E0ZE5LRThXekpSdFJKUHIxVm1taDA0RWMyc1R6LzNH?=
 =?utf-8?B?b3hIMTRnbjhLdHA4Nm8wa2VmRDdGVTR2MlQ1UEcrMGo0ZkwybzkwSWtScGpS?=
 =?utf-8?B?eFJIZXhSdC9nQTdwd0k2Uksyb1RkMEg5NUJQNDRwdlhaNHVHZEdWbUZCRjJI?=
 =?utf-8?B?dFNYVGs4R3BobXo3c3grWGMvbWl4Y0pyU0haNjd5Y0Z3YlNHc3lmM3JHdXh0?=
 =?utf-8?B?a3VVRFdhWjRzZ25aOCtJT2wvZFJZQlMxdTJVMFozL2hxbG1qbjZRc0RnaFB1?=
 =?utf-8?B?VVB6NTMxOUxSTHdybmdBSm9mZlZESmNuQTY1TXdHUldGZEsyM1BNbDlSRktx?=
 =?utf-8?B?WURMQTBwM3BQMGY3aVFQbnNhL1UvVVlDaUZXbTBseHEwUFZEcnZDSSt4eHBJ?=
 =?utf-8?B?NkdjUFBjaHk1U2xnOGtUYmVLbTBFb0RPdUk5YVFhNVpWZHpqSkhlWjF3Y1hD?=
 =?utf-8?B?WlRGQ3F1Vi9QalludjhzcTlwVE9jcDR0VHVJL0gvejQxZzZMamM1RnZTT09L?=
 =?utf-8?B?Q3dhUEhYdXE4WjBic2pCbXE3NTg4MUlKVHVrWDVjTWsxQWNpdm04V3QrVkFW?=
 =?utf-8?B?aVl6OTc2VEN1UDloY0hIUGVweU1KTmZvWE45bGZzT3NrQTRaV1E1WWROWU1Y?=
 =?utf-8?B?czdhV0NENHNCRUhDNDNEUklQNWNCc0pqaFJSeVZpNEsxNkx2TlNWZ3ZXMDVN?=
 =?utf-8?B?MzV0S1dpYTVscU93UHhWMHhDWXlTa2dBeVBucGJkUEREOS9XQjJXZGJ0VFNK?=
 =?utf-8?B?dkp3bzk1KzRzbk56ZFI4VzQybFZqQkxyNytmN0RLT0J4K0NXUnpLb2kwZitV?=
 =?utf-8?B?aUIvaUdPVmlWejQxL1k1TVJXczBjVVZ5SGdnM0l6bFpoaEQ2RS9nSG5malpC?=
 =?utf-8?B?VjZNcHdUMHQrMlYxR3g5WENZeE85Qi9NNFdJdmFycVJxOUFRSmx6ZkowRSsw?=
 =?utf-8?B?a1AwMWFmUTJDZW1XR2pFaGUwQTF4QVdqcUZKM2VSVDRxRG1jZmJWWnpzTXhl?=
 =?utf-8?B?cFZZTXdmSERzNUVKV3FKRVpNZWg3WHhoVlA2a3hkRERQU2tUd1JZaDRXY3ZV?=
 =?utf-8?B?QmMvVmVJdWVudlM5SW5tbjZ5NlpEREFtY0lwOW9BT0pVU3p1T3NHVmM2UStq?=
 =?utf-8?B?OW1wYlZtVkxFaFloMGhpYlpSemtPYzVrbnlIWnRVTk9sQ0xKOHhDR3B2R0hk?=
 =?utf-8?Q?PVr+xzG11zM0stoSAT8yXDGTl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe6864e-ab70-4e5e-dd20-08db8854d555
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 12:36:54.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWk2uqRQxq2jfZZCU5vJfILdstg7Jr8us9rVqJaOZIw9z0VAQZw5yHj72GRVFjZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 7:16 PM, Greg KH wrote:
> On Tue, Jul 18, 2023 at 03:36:51PM +0530, Nipun Gupta wrote:
>> Introduce cdx_set_master() and cdx_clear_master() APIs
>> to support enable and disable of bus mastering. Drivers
>> need to use these APIs to enable/disable DMAs from the
>> CDX devices.
> 
> You do have a full 72 columns, why not use that?

sure, will update accordingly.

> 
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>> ---
>>   drivers/cdx/cdx.c                       | 32 ++++++++++++++
>>   drivers/cdx/controller/cdx_controller.c |  4 ++
>>   drivers/cdx/controller/mcdi_functions.c | 57 +++++++++++++++++++++++++
>>   drivers/cdx/controller/mcdi_functions.h | 13 ++++++
>>   include/linux/cdx/cdx_bus.h             | 16 +++++++
>>   5 files changed, 122 insertions(+)
>>
>> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
>> index d2cad4c670a0..efb24672b7d9 100644
>> --- a/drivers/cdx/cdx.c
>> +++ b/drivers/cdx/cdx.c
>> @@ -182,6 +182,38 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
>>   	return NULL;
>>   }
>>   
>> +int cdx_set_master(struct cdx_device *cdx_dev)
>> +{
>> +	struct cdx_controller *cdx = cdx_dev->cdx;
>> +	struct cdx_device_config dev_config;
>> +	int ret;
>> +
>> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
>> +	dev_config.bme = true;
> 
> What is "bme"?

This is bus master enable. I will add a comment on the structure definition.

> 
> And are you sure that the config can be on the stack?

Yes, as this information is used by the controller and a new created 
command is sent to the Firmware/Hardware.

> 
>> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
>> +				      cdx_dev->dev_num, &dev_config);
> 
> Will dev_configure always be there?

This is expected to be there, but will add a check for further assurance.

> 
>> +	if (ret)
>> +		dev_err(&cdx_dev->dev, "device master enable failed\n");
> 
> Why error out here, shouldn't the call have printed something if it
> wanted to?

Agree, will remove

> 
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdx_set_master);
>> +
>> +void cdx_clear_master(struct cdx_device *cdx_dev)
>> +{
>> +	struct cdx_controller *cdx = cdx_dev->cdx;
>> +	struct cdx_device_config dev_config;
>> +	int ret;
>> +
>> +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
>> +	dev_config.bme = false;
>> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
>> +				      cdx_dev->dev_num, &dev_config);
>> +	if (ret)
>> +		dev_err(&cdx_dev->dev, "device master disable failed\n");
> 
> Same question as above.

sure will remove

> 
>> +}
>> +EXPORT_SYMBOL_GPL(cdx_clear_master);
>> +
>>   /**
>>    * cdx_bus_match - device to driver matching callback
>>    * @dev: the cdx device to match against
>> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
>> index dc52f95f8978..ba670f0427d3 100644
>> --- a/drivers/cdx/controller/cdx_controller.c
>> +++ b/drivers/cdx/controller/cdx_controller.c
>> @@ -55,6 +55,10 @@ static int cdx_configure_device(struct cdx_controller *cdx,
>>   	case CDX_DEV_RESET_CONF:
>>   		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
>>   		break;
>> +	case CDX_DEV_BUS_MASTER_CONF:
>> +		ret = cdx_mcdi_bus_master_enable(cdx->priv, bus_num, dev_num,
>> +						 dev_config->bme);
>> +		break;
>>   	default:
>>   		ret = -EINVAL;
>>   	}
>> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
>> index 0158f26533dd..c4c00f376006 100644
>> --- a/drivers/cdx/controller/mcdi_functions.c
>> +++ b/drivers/cdx/controller/mcdi_functions.c
>> @@ -137,3 +137,60 @@ int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
>>   
>>   	return ret;
>>   }
>> +
>> +static int cdx_mcdi_ctrl_flag_get(struct cdx_mcdi *cdx, u8 bus_num,
>> +				  u8 dev_num, u32 *flags)
>> +{
>> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN);
>> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN);
> 
> How big are these buffers?

The defines are as follows in mc_cdx_pcol.h:
#define MC_CMD_CDX_DEVICE_CONTROL_GET_IN_LEN                   8
#define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN                  4

where MCDI_DECLARE_BUF leads to creation of a variable of data structure:
/* A doubleword (i.e. 4 byte) datatype - little-endian in HW */
struct cdx_dword {
         __le32 cdx_u32;
};

so inbuf is of 32 bytes (8 * 4) and outbuf is 16 bytes (4 * 4).

> 
>> +	size_t outlen;
>> +	int ret;
>> +
>> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_BUS, bus_num);
>> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_GET_IN_DEVICE, dev_num);
>> +	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_GET, inbuf,
>> +			   sizeof(inbuf), outbuf, sizeof(outbuf), &outlen);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (outlen != MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_LEN)
>> +		return -EIO;
>> +
>> +	*flags = MCDI_DWORD(outbuf, CDX_DEVICE_CONTROL_GET_OUT_FLAGS);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cdx_mcdi_ctrl_flag_set(struct cdx_mcdi *cdx, u8 bus_num,
>> +				  u8 dev_num, bool enable, int lbn)
>> +{
>> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_CONTROL_SET_IN_LEN);
>> +	int ret, en;
>> +	u32 flags;
>> +
>> +	/*
>> +	 * Get flags and then set/reset BUS_MASTER_BIT according to
>> +	 * the input params.
>> +	 */
>> +	ret = cdx_mcdi_ctrl_flag_get(cdx, bus_num, dev_num, &flags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	en = enable ? 1 : 0;
> 
> if/then/else?

okay. will update

> 
> 
>> +	flags = (flags & (u32)(~(BIT(lbn)))) | (en << lbn);
>> +
>> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_BUS, bus_num);
>> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_DEVICE, dev_num);
>> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_CONTROL_SET_IN_FLAGS, flags);
>> +	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_CONTROL_SET, inbuf,
>> +			   sizeof(inbuf), NULL, 0, NULL);
>> +
>> +	return ret;
>> +}
>> +
>> +int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
>> +			       u8 dev_num, bool enable)
>> +{
>> +	return cdx_mcdi_ctrl_flag_set(cdx, bus_num, dev_num, enable,
>> +			MC_CMD_CDX_DEVICE_CONTROL_SET_IN_BUS_MASTER_ENABLE_LBN);
>> +}
>> diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
>> index 7440ace5539a..a448d6581eb4 100644
>> --- a/drivers/cdx/controller/mcdi_functions.h
>> +++ b/drivers/cdx/controller/mcdi_functions.h
>> @@ -58,4 +58,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>>   int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
>>   			  u8 bus_num, u8 dev_num);
>>   
>> +/**
>> + * cdx_mcdi_bus_master_enable - Set/Reset bus mastering for cdx device
>> + *				represented by bus_num:dev_num
>> + * @cdx: pointer to MCDI interface.
>> + * @bus_num: Bus number.
>> + * @dev_num: Device number.
>> + * @enable: Enable bus mastering if set, disable otherwise.
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +int cdx_mcdi_bus_master_enable(struct cdx_mcdi *cdx, u8 bus_num,
>> +			       u8 dev_num, bool enable);
>> +
>>   #endif /* CDX_MCDI_FUNCTIONS_H */
>> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
>> index bead71b7bc73..acb4e40bd20e 100644
>> --- a/include/linux/cdx/cdx_bus.h
>> +++ b/include/linux/cdx/cdx_bus.h
>> @@ -21,11 +21,13 @@
>>   struct cdx_controller;
>>   
>>   enum {
>> +	CDX_DEV_BUS_MASTER_CONF,
>>   	CDX_DEV_RESET_CONF,
>>   };
>>   
>>   struct cdx_device_config {
>>   	u8 type;
>> +	bool bme;
> 
> What does "bme" mean?

This is bus master enable bit. Will add comment.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
