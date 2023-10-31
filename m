Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4827DCC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbjJaLoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJaLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:44:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A0DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVOm5CMYUtULIilKhiBXtCiS18JrN1tmjgcn+sOvBEN845NBEQ7aEzWylk7iXo2lwmmaPc0ZXmRID92rCcdn3LEoS/+dtUmyx0yrSXh+aHczR6mS8N9cclvz2Hh7rmzcAkWkTCinh/iKicQmgPnfuHXxUPpX1f4wQuPp7CbG3yYS7/McEp2nVyWmDXkhwjgfEBL76GsXq8t2ozp5npfvCfw+xA2dnp5bSlt695IRrQC9FuygcAV1kU5bXAgWwioz6TmaITYOy0tadSO2Y7xZsHVRlpdJmRp2Cy97HqiR3CjGwN7zMMmBBv/UyJbVtGKomWR4Z0PQsxvj2W8+YaAj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2F+yBO0TgYmg4YoutFGuscnPuV5xDm4X8AISfKSV0s=;
 b=Iw03EiTHzkJgy7dIjt4wDme7B3gXXk358N5dCmLdEGxCJVL5ikV7oAYDOeyey3qzxrHkHAWj83utmkuJgRNqPBh17yFHmaF0P5JdyL21Cpwym2xi7Xo3qgkl809MqcNE9IQtYIWLKW6bvDFtOW+sCsXGvhzYGZRt53q9vULon1i6F6AvKwXSoZw3wvUiZ+UK95V9GhGEdtSb4UKYVvH/oFXzU5AUUdi3oAwtVX5mLpYe5qamVCJQprAvMwN1XUnK4sqT7mGQh49PJxAFzXDis4lIZmVgvTWoogeJsjFJK2kcpYc27UMADijxqrfMiGS19QFCHzRn8cWpfW10MD7ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2F+yBO0TgYmg4YoutFGuscnPuV5xDm4X8AISfKSV0s=;
 b=oQgtjaDTDQonZJmGBLbTwmXQv8zkO/C0faVIj/tKTY+lVIKmuA4Q53mVgs9S6Kd3mnqh90ajyIvjKk0SNJIH3/9IOgCE6tCzB5cWbi4z9K0u5EQAjT6Bu/eTyYl20KGhfEnYTUu1M6ngE1u7aTvrKge5HwAgtAjw32lHDARLJhG8kSD5tNZzBYxx7qWy7Syih6IaDwYwcqT8IRrE7E7zYWsT/q6t8rLmn5aaFi26qhSCqeXxyYroX48oofjDg60QnEAllidk8OE+srS9aZcInYyHKkqhn9UAlzRDHKVbLB9NTDUoCeX7rudFVN1nVmGjEjtnRPPCV+qGxcizwBEVzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3710.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 11:44:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 11:44:46 +0000
Message-ID: <1418e74e-175f-4b04-90d7-8bec2987c207@siemens.com>
Date:   Tue, 31 Oct 2023 12:44:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tee: optee: Fix supplicant based device
 enumeration
Content-Language: en-US
To:     Jerome Forissier <jerome.forissier@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org
Cc:     arnd@linaro.org, ardb@kernel.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        diogo.ivo@siemens.com
References: <20231030155901.80673-1-sumit.garg@linaro.org>
 <20231030155901.80673-2-sumit.garg@linaro.org>
 <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a54b6109-5a38-4d72-a197-00fee0162860@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6501e57e-2580-4b04-68b6-08dbda06c824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpNXrcYF1uCQ3RdBMgMTYrfG8B989DSn5AK9C3ao3pyx2iagAs+Dp5K54GJzgQg6Q1DMHuHUY3rLYhWM0Sz6ECkIkCODtAnzlNkCyJX+1OBmVXXuhXHJjxx80LEZddkaGCrKWtR6whPPJ76+TTwD9vyUI+9+ute7eawB8UH5ZWhoQxILXz8l0F5RKHZHk2S7WEAuSrIgyEKWXbKniGmNs/KZ6aaT/BBJ8ET7mSBSw96H3hVKOuxWpKnuqpYEUn2+6hn3dgqEMVFpYOZLjazU1R8fm/9dGDJH4D/HVhweCEvdX4omeGZm86LGnIwkj+SO7C5wUJropo5dKGBsJyMKlGV4gvDqrC6dgOIFT5x7T1R/QHDxFwWiXhUF4qVihAKRFgcRY7p57suoaEA4pGkxUnYzaJF1libUvo6FpeK4FrKCFK9DgtzP44u3s5sPgYU57zzxWIHt0VwNTIK0ZnicaVmjo32288lCVJ70e51//2NKi2BfiqtzduM1Dccff2/GjY8qddMfldqAt+XgCnd/ETaZt3Fh2OHoHJO3KyOwnrjO7LumRpelvfr3HYsNcdEv22CQblS9ndHWf6QDLV8yE9xDpYXz+Ok75hhzx+PXdcGT2fCISDyqQcAbWgxcGdgr5gUMzPPSx5KUPCjtyoDgx77t76x2+9adSC1Ih7IcOE49F2BXrJixgyHuQ3WklQwh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(26005)(6512007)(38100700002)(31696002)(86362001)(36756003)(82960400001)(5660300002)(7416002)(83380400001)(2906002)(478600001)(6506007)(53546011)(107886003)(44832011)(66556008)(66476007)(8676002)(966005)(6486002)(8936002)(2616005)(316002)(4326008)(110136005)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExtdGdkMHVQVXQwZjFkMmtJb1MrbDRWYkE3RTUrV2dMRWUrS3Vibi9NR2hQ?=
 =?utf-8?B?c2JCZkhBSVdKdGh0bkJLVkI2Y2sxNGRWVCttNGFxOW1WZDFkQUlEQVpXam90?=
 =?utf-8?B?N3BaRnhDc1FCUHFRLzhRTjRCMTJ5WmdSZ1RuOXp4eTA4KzV0WjEyams2SjRl?=
 =?utf-8?B?ZGl3cW1wRGdKb0FtSGxyOERmVFdmMlZ3SkdHUlRJNERENU0vaXp1ZlkrZW9N?=
 =?utf-8?B?bmRlMXNEUTNJWVUvUTgzYW04NlN3czdQOG52dXAxWjFhOWVjemhIK0xYZHpM?=
 =?utf-8?B?REllY1R4ejduUTE3bVJGOCtQQ2MraXFiNXNNWUlCQ3FGZXh6R2RzNTJ6VUUx?=
 =?utf-8?B?Ymd3QnUwQTJwY1hYOEJjMjNiZjV1azhZbG9JVnBnV3MvS0puN01FUFl0Q0JU?=
 =?utf-8?B?Y0xqcUpvNHo4L3VKTG8vb1pObVVkVVNDUGRIeTFNL0lTQ1d5NE9hTmg1ckVa?=
 =?utf-8?B?VDM5RjN2R1ZIMzlCYUxhQUF4STl4OXBtVk5EczZ0cFRWK0VTZmVidjc1Z2Ny?=
 =?utf-8?B?VFJSYXhCMDJ6WGp0V3RZY1FheDNFdGx5M1FPbTZRdjR0azJDck9NeFBuemVZ?=
 =?utf-8?B?U2luV3I4TjV0R21ETDhpNXZncWxSbFJHUldTNmUrSEhlZ1Y0bkh4blpFTjF0?=
 =?utf-8?B?M3ZiaHFWN0ZUeXI3eml6NnV3UXMwSnBVV2NSZU9CdHEwcUN1ampWUDJDK0xk?=
 =?utf-8?B?UjZuQkY2ZStIaUttclBPS2Y4OUl5QVAyNFJkSjEzbFpNV3IwdEdoKzdVd3Rs?=
 =?utf-8?B?YktIYTYzVzIzSHBKOHl3Z2NZM2RUVGNkRDg1ZmFLZXpxOTRuQStRZDh5TUFG?=
 =?utf-8?B?OXhUTlFiMjZ4Q09DLzR0Q2o2enRtU0pVaHltSHRZS1NYNkVzNjB3Q0dBT05k?=
 =?utf-8?B?QUxSbG12WU03V3ZGT1Mxc0xvaGJTcXEzOEJzb2xOWTdvaGdPZU5lbXVmNFNQ?=
 =?utf-8?B?MnArdngvbEdHQlZEaWhUQ2F0UDFoTzVZaTNkaktQbjhiMU1sL0xvaDJ4WTNm?=
 =?utf-8?B?bmxaWlRuNzBkYU8rVzNwaHZSY0t6UkZjVHNobi9KS2x2RzdFcnIyTXE2R2RS?=
 =?utf-8?B?WGVqNGlGRkZYdlNhOUc3SGRVZ2FKYTArQTF0MFlmT0tySHJxQitVZzN5WlhM?=
 =?utf-8?B?MjNOb1VNTUxpSXBPUzF3bk1UTm1iQlBiTlRjTVZZK1RYQ0o4dDFMTGFkelJU?=
 =?utf-8?B?b2xUeDJqSTc2ejFoa2Ewd3RrNmo1VldONEJ2NlA2b3NnSndIK2w3UTQyOG9C?=
 =?utf-8?B?eEs3STZWcVg4TmxQUHpJN0J2UTRLRUlPcmk0bHZjZjZsV2JESzhKUC90M3lv?=
 =?utf-8?B?QmpXUnZUMStPeUFRbDBjQ3Q2THdjZmJtdk5uK0drbExITWhpT09VNkhDT2xx?=
 =?utf-8?B?bUtYTjlRMkNSYWltRFFNVm5aMGVBWFVlVnVxRUlqdS9IaTZGTDZzUXFGbWZn?=
 =?utf-8?B?MHZtRVZTQjJTdVB4Y1dxL1R1YmY4Z2g1YUROZlU0OU1NVFlYOUQzdFVzbGhx?=
 =?utf-8?B?ZStSOWsyYVcycTFWbkVJNnV2K2h0QTdJdGQ1SXlNMXZXTis4VzJrR3RCU3Rz?=
 =?utf-8?B?aG1CSG12c2UxUE1ZRFJtWDh0SHo0MjArQ0JGNXRvNlJoUFRJWG9TNmJCZWJl?=
 =?utf-8?B?ZFVzT1g1VnZCZEh5d2JqbkpKSFpmc1pKcFNCa0s2T1J5dHNlU3pCbGVBVGlD?=
 =?utf-8?B?WmlueVdnN3dTSm1Td3NydDdPbFkzeEREV2YrM1pyRnhmR1lGdHpyaTg4NW5w?=
 =?utf-8?B?UFBLSlQzUEI2cXc1Nmk2ZXlGVjFFY1dmeVlTN2dCbmZXWkRnSkR4RU4vOTla?=
 =?utf-8?B?T2l2MEN5eWdYejFuV3EwejZpcnF2dXlQNzNrMGtsNklmVllsVnZ1cW1NUHdD?=
 =?utf-8?B?OHM3bllzQk1LTzNPSWFJSkY0bTJZS0YzaHE3SmI1b2xkMkZQQVA3Z1VjamJp?=
 =?utf-8?B?eUpLVGRwTmF6SXl5YUpxMDBqVitTODdOL2RGTStUUElSYTBjUWg2ZlNTd1Vp?=
 =?utf-8?B?ZDBzaHJqY0QvU1BLUTRmTFFCVm9VbzQzdE1VWnoyd3N2RTRvclFSMkJNazFL?=
 =?utf-8?B?aHQwcWpJOFVLTHgwOHNUY3lYTUZxcVFlNVJSVWY3M1ZObXY0SWRIVmdEY2pN?=
 =?utf-8?B?V2FkcitldzRPem5YS3hHWjRHTkoxaU5MRE56Nk45aTRaRkRyWmNqM2VSUzlT?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6501e57e-2580-4b04-68b6-08dbda06c824
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 11:44:46.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd3tGeHJ1GIAs83Ojwvkp13yrUdyftKdxZSHvk2LTaacU7ZSXTJrNx1oESIlkPfX53sn9mzHY7VCZJzCdbbaCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3710
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.23 12:04, Jerome Forissier wrote:
> 
> 
> On 10/30/23 16:59, Sumit Garg wrote:
>> Currently supplicant dependent optee device enumeration only registers
>> devices whenever tee-supplicant is invoked for the first time. But it
>> forgets to remove devices when tee-supplicant daemon stops running and
>> closes its context gracefully. This leads to following error for fTPM
>> driver during reboot/shutdown:
>>
>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>>
>> Fix this by separating supplicant dependent devices so that the
>> user-space service can detach supplicant devices before closing the
>> supplicant.
>>
>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Link: https://github.com/OP-TEE/optee_os/issues/6094
>> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
>> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Tested-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/tee/optee/device.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
>> index 64f0e047c23d..78fc0a15c463 100644
>> --- a/drivers/tee/optee/device.c
>> +++ b/drivers/tee/optee/device.c
>> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>>  	kfree(optee_device);
>>  }
>>  
>> -static int optee_register_device(const uuid_t *device_uuid)
>> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>>  {
>>  	struct tee_client_device *optee_device = NULL;
>> +	const char *dev_name_fmt = NULL;
>>  	int rc;
>>  
>>  	optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
>> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>>  
>>  	optee_device->dev.bus = &tee_bus_type;
>>  	optee_device->dev.release = optee_release_device;
>> -	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
>> +
>> +	if (func == PTA_CMD_GET_DEVICES_SUPP)
>> +		dev_name_fmt = "optee-ta-supp-%pUb";
>> +	else
>> +		dev_name_fmt = "optee-ta-%pUb";
> 
> That's an ABI change, isn't it?

Oh, here did this come from! Yes, I recently had to adjust some systemd
service due to carrying this patch but looking for the change only in 
upstream:

https://github.com/ilbers/isar/commit/83644ddf694e51f11793e6107e4aaf68dc0043a5

Jan

> 
>> +
>> +	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
>>  		kfree(optee_device);
>>  		return -ENOMEM;
>>  	}
>> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
>>  	num_devices = shm_size / sizeof(uuid_t);
>>  
>>  	for (idx = 0; idx < num_devices; idx++) {
>> -		rc = optee_register_device(&device_uuid[idx]);
>> +		rc = optee_register_device(&device_uuid[idx], func);
>>  		if (rc)
>>  			goto out_shm;
>>  	}
> 

-- 
Siemens AG, Technology
Linux Expert Center

