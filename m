Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E07C02F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJJRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjJJRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:49:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853797;
        Tue, 10 Oct 2023 10:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCda953KH1JLHE44sdrU6kKv+mC9WM+Zo9nAEXyPWNRnyuQhoitDSLH8qhmXITqQmfQnglONvcW+5JMzvvph+vkRIhNGl4ila+nBNpn0wIlTXy8VhYxU8VSwOaDRwyQ6Yj9V3N7GDOqGbbP9+C3iAAj8pi4+7BdglfQR7JmZ6mDNm6vsJjgjvF3XGF4M1mHd4msUOJXgJYWa/tvaopkeeOv9VYemxPOyHxUVHolOlvuga7aC52TJJlasefiw+dG9MEWV9npmuud0QiCBIfPw8qqhb2Ich+3ZcjZ90Bfg1vxvhKxhgwMCcJbm82XQt9iVaIKQa/u9XrQA2uOVjtPC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9eHmzKwZQC4/dawstKDpJEGiIN61NspVidYnb6JZ1M=;
 b=SkXC/YNLQCmI3QSiqWSMWHo+RFJ/2Z41IHBVCeM75TPKHh4o2TjPx/MRaGoXzTNXwh3ERzirUWKG33jknR/qJ5WI5fCzvvl0fetJ0D+Sx6tpO6JSOrwlHRB+Mdk+IF8l/FcvU77/T37iNlV1YSwXuJM/B0Xs07yNbzvQfHuS8nlp2d2myeQcxgDkSRIb6D3b1HzhHZMuTcdCdxU/iVJ/10iGh/3CGf+NYCMdk0lLpQnYdp6En3ADBFHETaHb51zHyTnu2YNzYNKzYROpBvq4R6t8lyOZxml+vSJhtG6HYS645umhRw6V15zV3oRC4CFAxI74VhJsYX9sKku29DbuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9eHmzKwZQC4/dawstKDpJEGiIN61NspVidYnb6JZ1M=;
 b=mdWlUNQFY3eIgmeD840x9Mn/f35+fJgNoLAe1IEy9vuGcnn33fWAqaj+x8piiEi4JABKdo/FlpQJxgl7eAzoUxacQ0NU8P9/xi44zSttsftgKGMrGmmokeVCMwMlp/kUNYl725zcsLirTXdVQw9nBeeDIzhjz/X/S4HjODASoxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 17:49:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 17:49:38 +0000
Message-ID: <1e8c1db9-5d52-4b39-8bdf-7d7d70ed1157@amd.com>
Date:   Tue, 10 Oct 2023 12:49:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: typec: ucsi: Use GET_CAPABILITY attributes data
 to set power supply scope
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     wsa@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        Richard.Gong@amd.com, kai.heng.feng@canonical.com,
        sebastian.reichel@collabora.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20231009184643.129986-1-mario.limonciello@amd.com>
 <ZSUOcdtWQ/AlAH+c@kuha.fi.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZSUOcdtWQ/AlAH+c@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a56abc-77a8-4818-e13f-08dbc9b945be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYvOQ9Fhl5LFiC04IL6G8JlhhvMSUAnRJ226dIiipG7GbztAanwaUCMtgQjLGhd9qJul6/FuA1WT5F6cVeJ3FGvd777kIvI2EltKj9hF0NqV4azCNjYzr4SZzVDFTKN3lfvENJmNiXq05LBjh+lJexBByMG8R2Xm475OLzqKUBNXqd+ou6CJjPwj6Sr96TPAS9woblww5jElazqQTcvGLQw8q+T0cFhlTPCJZs+bG/qg0qZRUCTPdTjSSb1kEsZz0aiEBXMNfp9xNeHXNCmedydOiSRcS0uFc0khh6NORByq17PGdg/Ktn510CV0p5zyeb2urI+9c5Dx58CIIf7RMpGTGY3XRMKfHujPizRafV7DNYWU0RUJedOY+VQJBPfmL6sGNLgH4GMp6AHdcViL2DX4ooD1dnudJ4Eyy7kNn/F/vW08SfIjB5WLnYgHqLmjL1OcuWMRpE8Ght8UzizXMIkG6avLOnNzpZlGh2swnI6gwCsuS7PU/lGtikvPrAUDEpg2miYiWOlU7LuUuVXckuJCfI8Jw5sdXg1vo2Mpcv3+t6bo5Du5Yfq9GNZ4Sdbz/XL4l4gblISd9aCqUIwsfc49ItqJI+3NzPNV/c31Hla7zk6MKX1kMrhn2oP7uN6hUQmhLURTdA0xwYlydiY4fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(53546011)(26005)(2616005)(8676002)(8936002)(6512007)(2906002)(478600001)(4326008)(6506007)(44832011)(66946007)(66556008)(66476007)(966005)(316002)(41300700001)(6486002)(6916009)(31696002)(38100700002)(86362001)(36756003)(31686004)(83380400001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNxREI2Z3IxWDhZMjRUdCsraXpLbEcyV2o5RlVTd0I2Tkd4ODlOZmFIVFZj?=
 =?utf-8?B?cjZ2alZxamd5d2JMSTM0U1Jsb2lhMFRYdlFDZkNhMHpEOVlsaWtoUWlPdWp6?=
 =?utf-8?B?eU9SZkZtK1RwTG0rVFR1cG44RTJtS2pKNnF5WGNSM0NONWZ4VHJ6aEpIaVNL?=
 =?utf-8?B?czBSSUVxeVp0eDlPM1NlcHBCdUhEdVd0RWl0WXlTL2RCdm5TZHRwdXRzVXVD?=
 =?utf-8?B?Qksrci92VWliRFN6TXB4V0hBdjJUNVE2U21rRHdSWXZEaTI4dDJEWktyc1Nz?=
 =?utf-8?B?eDBYRWhQNzBuNUJ3TlZXQXdqelFTWEh4L1FOSnJjb3Z0ekhxM0lGMFdkMEhC?=
 =?utf-8?B?d1pZK3pkOUg0Vk5DVjhLUFU3bnl4MEdEWjI1MlNGVy83bjJBSWFFZjlWbW5N?=
 =?utf-8?B?UFRiWVR1OGVtOVpnSzBNWWZ1VkhFYjc2Y2syellTb1BrRzhKMzY0M1FxZWY5?=
 =?utf-8?B?SUVIWlhjN08xVUd4NE9lMUNLR3ByMERFVU9QZ1FFV3JxWHhrVVR6ako3Y1dP?=
 =?utf-8?B?Z3dySURBQXlKUFcrSTBOYmRPSnJvK0Z4RTBmSXVkbEhrUEg5Z0s5d1pPZ0gw?=
 =?utf-8?B?UzBweU1jd2h4bFd1WER5Vkhpbi85S0dzdnM1UUtIVkdhN3lhUmd1a1k5YjZk?=
 =?utf-8?B?dWs5ZXRialpNTGM1OS9jaDNWT1JITHFKLzVLR2VHZHZjNWZ4dzJIU29tR01U?=
 =?utf-8?B?R1dBb1MyNmZzcU5PNVgxZDdqd05sMnZvWmxDaGxydnZOZWo4K1FtbmErTW5a?=
 =?utf-8?B?L0twcnhEa1hWRjZjMENCbGNBclBnY2xLN2g5L3Q2K2xlaXdNcTF2RnNZbDgz?=
 =?utf-8?B?V1VzSkpXRkE4VkgrYXg5czBFN2JWNjNna3FOSnUrMUJwZklkM3JFYVJFWUhT?=
 =?utf-8?B?bWZaY3AzR1Q4eVM4NjVZeWhmTUtaL1lGZ2plUGF0Y1NKaXIrSmhYeG1kMVk4?=
 =?utf-8?B?NXE3N2ZVUjY3NHh1UFZtTEx0L2VRREVuY1pCSE5ZdzNTN3JBTHFTd0lyRjBr?=
 =?utf-8?B?LzQ3SlZBWStMeEhyZTN2OXFPUXVoeWdYbTYrQzY0VUVPelhCdnhFdzVUcENj?=
 =?utf-8?B?UzlLRyt0cEFzdGtrS2l3TnFBQ1lGZE5WU2JrTjBMYTRldGNnbDlIQld5Snlp?=
 =?utf-8?B?bm9McVFoUXIxS3RwOGJDRnVNTFZkVXRHV0wwY3gzMEtSb2VuenVuSlNsUlgx?=
 =?utf-8?B?NUVET0N6elZCUW1IalU5NFE5dy91SVdiWTVrK2ZkcmdKbHd1ODdodjdjVmNu?=
 =?utf-8?B?SWNMZy9haWdxalM5WkdkY25aQlA3MVNDZ1JlYXprekR5cUlpaDEwYkdUUTBs?=
 =?utf-8?B?ZFlsaVJqYTJWZTVNNjZVdUpHSUNMNVM2MVA3UHpXY08yZXJjTmFrK0ZuWVlX?=
 =?utf-8?B?T2RrVms1c2tQRTU4UkwvdTVPb1V2RGJXbXF3d0lFYXh4N0Y0azBKMzViMUJX?=
 =?utf-8?B?R2p3dzNKZ0pMcVJqYThhTno4MGJlZzBZU0VJL2VCd3ZTN1IrcjlDdWZIK3Yv?=
 =?utf-8?B?aDVwYS9USnlZN21NcS80SnNhMjVXT290Y055RG80WUVzbU9haFRXNHUycEsx?=
 =?utf-8?B?YkJsaHQweXFjWXRwZWRDQ3gzNXY0dGxPaXJxUHBwRjhWQVpxS1JGeVJnQnU1?=
 =?utf-8?B?cHdxQTlvdkcyVzRWOUl2ZjJzeWt6MHNzVTRBMmRERHQvWWZSSCs1bDB1ZDcv?=
 =?utf-8?B?MmQ4SDBod2M1c2NseEhOLzlCV2s5SHBucThOQnhTWFFzekw2aUpreUc4YjdQ?=
 =?utf-8?B?d3hXMFl6S3crRXJHVGk4Z2h4TDZNUnRtUVIzRlBkeTVQdWpNYm4waklMZ3hW?=
 =?utf-8?B?a3FPYjJpTDhCakRpYmtTRTdDSnFOd2hZbGloTzRydk1yY2RxQXhoS2hreFRO?=
 =?utf-8?B?M3ArZWh3UndqSCtkK0w1TkFUazZoQzVZaTN4c0dGaE9BdjJCSDR2eGttRFk3?=
 =?utf-8?B?Qk95dExYVVE1dllxZWp5QU5HdDJXRXVwUjFKRmlwTFk3U2M4OG1haThEU29R?=
 =?utf-8?B?S0ZoZjFTcUd6WXFEU1hlRFhxaGdFMU9saDNGM2E0UWV4SkJwZXdnRjRtVkZh?=
 =?utf-8?B?MG9lT096SGI3bUlpMUc1TkQ1WUVPb0xIODNnVE1Mc3NhQVY1Wk5JdTNhUzFG?=
 =?utf-8?Q?w7gPcPWwIJljpJpn/GSnxLB2S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a56abc-77a8-4818-e13f-08dbc9b945be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:49:38.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4FPHQ8wYBrfs+pIY7Xoyo1cT1d0OfrztkM+gaSeUGy4I2udHt3shHAuy6EXGV/rzCYUEKtCG2bx8py6HMGzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 03:42, Heikki Krogerus wrote:
> On Mon, Oct 09, 2023 at 01:46:43PM -0500, Mario Limonciello wrote:
>> On some OEM systems, adding a W7900 dGPU triggers RAS errors and hangs
>> at a black screen on startup.  This issue occurs only if `ucsi_acpi` has
>> loaded before `amdgpu` has loaded.  The reason for this failure is that
>> `amdgpu` uses power_supply_is_system_supplied() to determine if running
>> on AC or DC power at startup. If this value is reported incorrectly the
>> dGPU will also be programmed incorrectly and trigger errors.
>>
>> power_supply_is_system_supplied() reports the wrong value because UCSI
>> power supplies provided as part of the system don't properly report the
>> scope as "DEVICE" scope (not powering the system).
>>
>> In order to fix this issue check the capabilities reported from the UCSI
>> power supply to ensure that it supports charging a battery and that it can
>> be powered by AC.  Mark the scope accordingly.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
>> Link: https://www.intel.com/content/www/us/en/products/docs/io/universal-serial-bus/usb-type-c-ucsi-spec.html p28
>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

Greg, this behavior is pretty awful with the hang at bootup on these OEM 
systems, do you think this can come into one of the 6.6-rcX or should it 
wait until 6.7?

> 
>> ---
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>>
>> Cc: Richard Gong <Richard.Gong@amd.com>
>>
>> v2->v3:
>>   * Pick up tag
>>   * Add missing stable tag
>>   * Drop patch 2, we'll just avoid upstreaming it.
>> ---
>>   drivers/usb/typec/ucsi/psy.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
>> index 384b42267f1f..b35c6e07911e 100644
>> --- a/drivers/usb/typec/ucsi/psy.c
>> +++ b/drivers/usb/typec/ucsi/psy.c
>> @@ -37,6 +37,15 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
>>   	struct device *dev = con->ucsi->dev;
>>   
>>   	device_property_read_u8(dev, "scope", &scope);
>> +	if (scope == POWER_SUPPLY_SCOPE_UNKNOWN) {
>> +		u32 mask = UCSI_CAP_ATTR_POWER_AC_SUPPLY |
>> +			   UCSI_CAP_ATTR_BATTERY_CHARGING;
>> +
>> +		if (con->ucsi->cap.attributes & mask)
>> +			scope = POWER_SUPPLY_SCOPE_SYSTEM;
>> +		else
>> +			scope = POWER_SUPPLY_SCOPE_DEVICE;
>> +	}
>>   	val->intval = scope;
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
> 

