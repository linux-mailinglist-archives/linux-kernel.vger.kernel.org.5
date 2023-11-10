Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36B7E7673
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbjKJBP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:15:24 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEA3C07;
        Thu,  9 Nov 2023 17:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE2HQV4pHm6T1KOHrISUlMyPM3+bpGcCJvRyi6ExdNIRmAe9wioMFOaEcUbSZW7xw9nOJ8vbl7cWQR2ayrY/lv7x7i1v4KDnVqxGS/lJZuzURJqGmmCNoPQLfYS6WspvAMqD4O8EgEjppOkIZE/NH1Xr17+2hG0EqsIN+WKjHOQB8AZr5x3zX8ruMwR+tFnj70unDWD6msRxHo3gL9ButSUE2SWQPO6tZ5cgAFtZifXRSU4Pm2AsJb1+L/+DxYna8N0hHe60lMU1dweeLsVuIdF1rudbbhfrnvvFGUrtKrauUTT8pYl2pS+e0ZGjtWVktKZAwMn0fNsBlTolu6sxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az2bdw+C/1UrCwSY30NMlk/VtSCOQbTmYVlHWstRJ64=;
 b=fgfOzi+/Srd+ACsdKVKNegDCDsfIdsiKu/vVWtnM/QlmEn231SrU0fkOrrDkqwscRkjtOrdGc8uVCy2SD48/rtdLdmwWHHC0W6aRx2bhzDxqUN3dVjrFNFsUybPQLFl106QE9CdeAIjQn3t2rPE5VLGPh2Ng76AODijnM9CQ/Q2heF9Q3rYvLFxsa6+fBkk61Ha1oBJOIuVP8qHVDGFJwJUU0N92olin+t8TGu/6sloQgRZTbM/wR6bXRlubECS4AFz0HO7f8Fq/C3WvrYRjtj++S6W7QTQfTByniPTcB2RP+J4v5Ii9yl+D0YISnNhH4Dxh4errth+NYl5IGRf/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az2bdw+C/1UrCwSY30NMlk/VtSCOQbTmYVlHWstRJ64=;
 b=qtsq9+SiKEX29we/SZaF3ezfEFWPFttuG88zVVBxBQ3F+2AHjU0CooAcuB1F3ilGd0YROc29PtteY7CpIuokSnPLf+eCv84LUFIll1JJU/ZvPU8nCOiKcXrn4Sx9vd88/CAzgsIUFydT+5qUoN3xCoMv/2sHCcCFTL4bU6WS4jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Fri, 10 Nov
 2023 01:15:20 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 01:15:19 +0000
Message-ID: <50372d43-f89e-4969-a609-d8e1ff2afdf6@amd.com>
Date:   Fri, 10 Nov 2023 09:15:11 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com
Subject: Re: [PATCH] hwmon: Add a new macro sensor_sysfs_attr
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Ma Jun <Jun.Ma2@amd.com>,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231109051429.2250774-1-Jun.Ma2@amd.com>
 <0ae6bcc2-a30d-4840-a21a-0de0b394c309@roeck-us.net>
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <0ae6bcc2-a30d-4840-a21a-0de0b394c309@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e8f1d6-d744-417b-0243-08dbe18a815a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjAbJnWMqHrgB829FOZbhIAYNf587MDhq5HiagGRNxliyA4hFesMfhTEcBA/pjix4lw5Iq8r7n10NhbBfeJiuLGHOPDNh53Bgv8NUa0TR4FcByDSWNwtKcLmjWUJxeyBMKqkKDOJaMhylG04kEP4OufkAYXcsiDFLcGfZjm9XSA3aODUipzxwR0UDBUc3saEdG450wBsrgYVAixTbWItFDUzfZ3VwTl4/h2eS5v5H5OKjyzyAgf53LaFDmL1TM0aeW39n/57ELpBU9JHyS13wY2NQTRtYLyLEr826f2H3I4GjmJWr8rELohgW2nr8sIfEBi2SnfhuBGW6nZ4atluNRq+0X04udLtVd6O0cfBQesoWw9yOrzift3e2JvT7TMG6fAceNudYMoq9W4VcusqZDB0TXoMxRStE0Mixd6VD5bm0L9D30Nn+oqA8M+mS+Zjp3taqwhPvrtknjzsjXsvQKDLekem7fXl4bte5JU+d2be6VSoVq0uUjxjQHjtymxuGW/LjH8BjBDSPUIfEJC4X1MmWWn5R8WTA62pp7nqOokYh6sVW6W65APr6mf/ZWMY0A1KSPNRxlrw2/KKaI/yAa8jnrh5GFZLWdc8O3k5kgkBrb6JrfIicqE4TAjn9dR4DCwyXL+a6/k6WXj+jITwzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(41300700001)(8936002)(36756003)(2906002)(8676002)(4326008)(38100700002)(31696002)(5660300002)(6486002)(53546011)(66556008)(6512007)(66476007)(31686004)(66946007)(26005)(2616005)(110136005)(6666004)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjI3aGJKVXdGdHpsT2lUL1Q2NFZ2Vjd3eUh6V3laMnhSb3VJRnhNRUg1STJq?=
 =?utf-8?B?Y25LRkZ2TGI2citaR1FtaVlhZmZ2MDVNTjJzUmFlM01mdXF4QmlXWUVaUEFY?=
 =?utf-8?B?WU5QS0wwZ05FWURUVTQ5WmVlT3Z6eWVXcXI4NHpHVHVpV0xRN29WM0VjeXRR?=
 =?utf-8?B?TGs4NWFINHhDNlczRXpwbkx5djF0eFpibVlIME5XRG4zM1lZZzA1ZEc3WGFV?=
 =?utf-8?B?QU84eU9jMUNIRjBpNXdJbURjWGdZY29kd1FQWkVxTXNmaWhuQlZjSmRUZS9x?=
 =?utf-8?B?Si9ISGdadTlJbGNXamI5TFlneHZtTjR3bXE2anVPakROMFA4ZWtmTXQzUkV6?=
 =?utf-8?B?MkljS2JHWENYVUNRTlJJMGN4cWVBdkN3TkhZV0tRbU5SSVZKaVRxZmoveVZj?=
 =?utf-8?B?VW83S2p2amdKbFoyNGNqUk5aM29Oc0Q1M090OG82WVRVaWUwNXc4VC9oeng1?=
 =?utf-8?B?NnJidWlEWFlvMTZNQmRTRnNTNHZucExCb3cySm80UWRUMjVpeFFMOFYxSVh3?=
 =?utf-8?B?WG5tRHNoVlBBUWl3aVhhRXVCMUpWNE42VUdnNkZnMjViVDg0TDJIeGdPRG0r?=
 =?utf-8?B?L3BmTEdZb1h6N2tNVWN6bFZ6SW9DdXFzNmVNNkJxY2hWdDVzaUh1ZmM1NlBu?=
 =?utf-8?B?d2VXdmhBcnhBZmlSRldONDNUSWJqR1N0R2lqeXI5MENmWlEwNllIS2JNR29X?=
 =?utf-8?B?QmJTTTR6UExyREZNZng4U0c1cyt5Sit4ME8wd3VNWFI0QWtJayswNGFWMVU5?=
 =?utf-8?B?aGdiWmtiTW0zNlgzeGExamg2bU9EejhVaVZPOHBjMk9oZmFGUmVPSzdsb2Vn?=
 =?utf-8?B?WHJ0UjBaUlRYWm5SQnZXVE43KzRsdnJwN3p3STZQa2tPUXNlaGw2dUNZcDRz?=
 =?utf-8?B?alltcW1Hc2tVU2ZxZWNwVW00N1lCSnluZ3BTZU5ITkZIT2E1SWlQQVoyWFN3?=
 =?utf-8?B?ZnRxbUpuMWw1ZENHUnlpMEJWaDJzby83MHNiekNnWkhmNS9UQWR5OE84bGpk?=
 =?utf-8?B?Z3AyUW9QRmE5KzNUTUtDb2tsOERES3lFM2FJZ211S0k2YlVGM3RKSGxJVllh?=
 =?utf-8?B?Rk1kNURvRkwxM0pLKy9lNHdiU0s5Q05xQkdONUV6bmppTjA0TzE5Njh2VUFO?=
 =?utf-8?B?UGx2NWRPaDVHbjluOHhGa2RTNGdjaGJFdmJEWURxM29IbTJuM055RkFOWVYw?=
 =?utf-8?B?Z1E1WGdlQVJKdDU2RjVHQkU4RGk3MGZzU1c5b3JobzBHMG1PWFQzMUhEOHRt?=
 =?utf-8?B?amV6STNiOEpmaE9ONnlqS0NKYzNNbzBSWmxRMWVtbndRUzZ0ZW5lT3NOa2hH?=
 =?utf-8?B?RW1PRnhocjl5TWVYL0plbE9EN3pHSEsxZmZ1cFdOK1hiZW83V0pVNis2aURX?=
 =?utf-8?B?b3YxVjl1VmlZK2JPM0pWZ1RhYWQ2Yzl2dHU2MjJJa3VzT0xYN2lTV0dFekp0?=
 =?utf-8?B?RmpGbXBRcjRNV2FkMUxPR1hZdHZxalFZNnRvNnNhelhHWk5qcnVHTWFFcVd3?=
 =?utf-8?B?Skg1a2Mwc3VjUlB6akl3WGVjS2hxVXd5MDEwMlRQNmlJUnNiMmNvc0V5ZjA3?=
 =?utf-8?B?TWI2cEZ3SEszdlpZclVaV1lwOC9rMURmOWJZWEFwNXk5dUJJamNLV3N3UlNr?=
 =?utf-8?B?cWora3hYYWlaSStMd2JYVlhxMzRDU0FqalExVVNWWHlqSS90dHYvUklqSGNi?=
 =?utf-8?B?bTZRSmMydHpJWE10ZkRwQVRYREtEMUxtaEhVcXQ2Nld4eXVaNGlhQ2RuaHE0?=
 =?utf-8?B?NW5KVVpxMlRLUmZVTW1QaDN4dGtkeHlHZGNxeG9YeTk5M0xKRGd5dzlZT1gw?=
 =?utf-8?B?c3ExbHM0UWsrbmtBN0o2M3c3M2tRSVhlYzkyaHBEcml5b0ljRkk1aWxRODcw?=
 =?utf-8?B?NTJ6aWpCa0kxdmxuOVVSdWZxRXYzaEJFWTA1c3FNaExVMEF0UDd0NCtFWUVo?=
 =?utf-8?B?VUg1Zy85eERKcmYrdkU1REVMWDJ3eHFZT29jRG9WbjA0c3VTRi9sdGxDbENa?=
 =?utf-8?B?K01VMWRubzY1akVLdFBXemI4bDZzYnl3ZHhJMklJT21yS0dzbGV1UlBWYnpJ?=
 =?utf-8?B?S0Yvc3ZuL09RcDlHWnQyNkJGUk9zQVoyY09sNmhnb1dNa2FjRkEzb2JFdUdk?=
 =?utf-8?Q?7FpPEeYs3KPe08x4Lc97owPRG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e8f1d6-d744-417b-0243-08dbe18a815a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 01:15:19.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kiqqg9TGwfefoRWeLRI2ZOXEjAgYVgOnZjNlqAae/gc/46eNnLidpjFQJskQCuuT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 11/9/2023 1:28 PM, Guenter Roeck wrote:
> On 11/8/23 21:14, Ma Jun wrote:
>> The attribute definiations like &sensor_dev_attr_xx_xx.dev_attr.attr
>> are widely used in drivers. So add a new macro sensor_sysfs_attr t
>> to make it easier to understand and use.
>>
>> For example, user can use the sensor_sysfs_attr(xx_xx) instead of
>> &sensor_dev_attr_xx_xx.dev_attr.attr
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   include/linux/hwmon-sysfs.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
>> index d896713359cd..7feae637e3b5 100644
>> --- a/include/linux/hwmon-sysfs.h
>> +++ b/include/linux/hwmon-sysfs.h
>> @@ -14,6 +14,10 @@ struct sensor_device_attribute{
>>   	struct device_attribute dev_attr;
>>   	int index;
>>   };
>> +
>> +#define to_sensor_sysfs_attr(_name) \
>> +	(&sensor_dev_attr_##_name.dev_attr.attr)
>> +
>>   #define to_sensor_dev_attr(_dev_attr) \
>>   	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
>>   
> 
> No. This would just invite people to submit patches converting existing code
> to use this new macro. Instead of providing macros to support deprecated APIs,
> convert drivers to use an API which is not deprecated. This would for the

Which API is not deprecated do you mean?

Regards,
Ma Jun

> most part avoid the need for including hwmon-sysfs.h in the first place and
> at the same time reduce driver code size significantly.


> 
> Guenter
> 
