Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58BE79C871
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjILHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjILHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:44:37 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50874E73;
        Tue, 12 Sep 2023 00:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694504673;
  x=1726040673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GZ7AlKkGk4VuQgUFVxzBmP/3+9s6PD/Z+F2CzF22Vw0=;
  b=i+EmgPwkFqWR7TU00gyzaSbK5yk1u5TJFEf6g+M89mFz/z6mHqdHpMOM
   78CMB7DsbizFyBrM53Idh28QvmO8w6aDf4dwEEgvpiWx+c9qJgeEULZ2L
   N6KVCUnkDRNrjv6Qmzgc/UwSo+gkOGn+kQ/83opDEw0pZi+y1JTEz2k76
   rOD/FDLGbqO++/BJhs6ljZ1a5T+HG6k5SdmFyznP28oF5y+PWBFPlWIfC
   544h2IuCPCQ26krLtlnD5DHW8yXeHl9bbelCQp8sdAPw3UOec9MUuEKxZ
   QvCjpwlWDr8V9CmosGZ3w35GrZVSX73/fXda2BhgQFLz5blZ3j/X3lrEZ
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxXnc5jRxKMGUbuyrzZ2oXNiO+q7P/4I6nWuru9PZlhyzl4krFxzemZp3LpwWtKhGhUnC9SHBNSaJaEb2VfqoXVQxj3JlDQfUIf41AfJ3kZuG1TFaR0uM84YTaVj3bzreyMfuDJxD9y3RVnfpDtKfbRPBC8Ymo/9waiNRYvmhAqWGtIsfdhtjn71af3y2gdkEsTxVYYuiOIKiuCVu1OFXzLtcd1OP0WhLF7gxZ6M1tQknRrr3bIy+HhZYt5fO8zhl4LAGxY0LJu76YWn3CW8CQorX62lRL8jXNj2Z6Ssw5AmpYX8Tkv7yi9e/Dd/BTOEnExYggUmLlK+ugTnmRM19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ7AlKkGk4VuQgUFVxzBmP/3+9s6PD/Z+F2CzF22Vw0=;
 b=F0Rju5AoCMkAMWygVfebdyhomGTWozbZHU1tjRNEu8HWbpGgNf3qwCGLvhPQrmqfIY4OtfAmfRYWkXy6lQjvS/Fq3I9qEZj2uwqys2sX/x2PHMfnu75e6T+ZBY3j/k+jdiKXSSSSgGujhje0v4WJkYHFlwhr+WV8HcGZZ/Lub1jRtBKuxpLwq9zBW1grQ/T7EFYOa2mDAmubMXjTZoEfdT0qfUL91McoFfggmklQztN98cIeSd+pMXoOD3UhewcWMuqX98s7zIFPZnF3puHbUL7qZLNqndk1PNP26xv/Bu3wvT+V04TOclH4SVKdhWxldK34LGZ5QQC18suWspcJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ7AlKkGk4VuQgUFVxzBmP/3+9s6PD/Z+F2CzF22Vw0=;
 b=OmrV37beGjwy6ooYKMsXPfZITC6H3C++JVEJj4HdgIviX+mzOH5hzQCBhr7nyqvi/dYKFXCWBhv26OgTnWEFmKSmuyuiq4PIa2FlsSSkPd6+yOaB3sJc0FoUYZhw3I6wdhTQyGlAqxfBojLOaC4cALHjDDeqeclfFIMxyH838e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <42522712-b739-3db4-9111-a4b378a65809@axis.com>
Date:   Tue, 12 Sep 2023 09:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] qmi_wwan: Add rawip module param
Content-Language: sv-FI
To:     =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230912-qmiraw-v1-1-21bc812fa0cf@axis.com>
 <87a5tramab.fsf@miraculix.mork.no>
From:   Stefan x Nilsson <stefan.x.nilsson@axis.com>
In-Reply-To: <87a5tramab.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To DB5PR02MB10072.eurprd02.prod.outlook.com
 (2603:10a6:10:48b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10072:EE_|DU0PR02MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8dc042-de61-43b5-5120-08dbb36417fc
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZrPk0UNshAQwSEUBBvjJKhN8qPAlynKIZo2pKsB0Ei3Y4ann/+H+CGPy1CtWj6ctNxDXLGXIOA6rHZDttj09nBDiNwwd0oHzOk9gxNWMYIUeML4YThqCDZsgHrxs3OVGsS4TfEymji3Gw9Bat233Y7H1gvioQQAiRHM9W3zPhNJfZZiW3Re4Myi+BMevZgKfM7VEKNZ/j7mX+q6/eKRZv9USS0X7vXKA7r1K+zPo8nZ/IcZ48M5a6V6W3bZzr9J2ECe7U5HnBroq4OQknB7tKtgT3Cmvx83QYgNytRS4hBSpf81hVmH8CWHWYiVGu6E/5k0O6zH2zgFDNZTV437Fpja1WEPXLKzssTCscI1KVia/rx6JDxBrzVVcqzqm2R4I+W2F3FrF7CUrzLb/0LhAKso882Prmbp0/0PncsPXnoTtk0lfnigW/rfisjVMQ205Z7D2YzZ/OmAY/58yfrsbjrlbk+axObj2gonELZHYa3MT0lOueTxC0E3pBtHYN4dFXdcsxtGOj2SV2zHSjZqoUn/KCyslFF6AnFWYi8oaJ38kdLjYtVSn+SnIZ/LSy2wi1eeBMNG+dlSOM68itEHYmiBVh9CfmaOLP9d467goStkjpZOuBpCQviHCIsg8JqSd7CgepQAkZCTripz1AjlVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10072.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(31696002)(478600001)(86362001)(2616005)(26005)(53546011)(36756003)(6486002)(6506007)(6512007)(107886003)(83380400001)(38100700002)(66574015)(4326008)(41300700001)(8676002)(8936002)(6916009)(66946007)(66476007)(66556008)(5660300002)(316002)(31686004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZNczBvUGJ6K1BuWGRYTHdmaGdhSVJISWpZN1R4ZUVEQzNxS0tjeGpqSk9p?=
 =?utf-8?B?dnZnamVNSHRFanB3eTAxQ1lzdGxDSG1iZlYxbklTOTIyWFlpZGlWTVpXeXdT?=
 =?utf-8?B?QjJxblVkbGFUelExalNBUUFLUEszVC9EaFZyb1hteFRLNTdobk1ueUxMdFhZ?=
 =?utf-8?B?WS9JL1RkSWFTTzhLckpNUlBjOHJSdXY2b2VTczN0cnIvdXNpZEZKVHl1Y0Zn?=
 =?utf-8?B?YXJHR3ZEdXpUQU5jZE5aMFdpZFVrOEpxR3o2aHNWSmRJVU1zYll4L091REhY?=
 =?utf-8?B?MDhyVzZ2d3lOa1JKL0pnWDVWL2MyM1RSaXljZ2ZIenY1c3htaHpBQWVtT2Ni?=
 =?utf-8?B?QTc5ZnJueFRDU2dsL014K1M0R2NBZGo2T1psRFJ2WHo0TVBGZDZnb1ZoN3R5?=
 =?utf-8?B?cGhPc0tMSTJIUW80cm8rKzJ1bGlPV1lDRE5WRy9VWWdhdnJrT3l5YlJ2MFVu?=
 =?utf-8?B?WGVmRlJPYkVYUGs0eG5Kc1lwelJTaVVMY2VDb3pQdnNsV1k4c1JmRDREbWo2?=
 =?utf-8?B?ZTBVYnlWdk8yRCtCRmJPYTR1Z0ZnS3dYZGFha080RW51MUYwNlZDY05pUUx0?=
 =?utf-8?B?TTlFSFVMYXZrMG5sNmVMTUtYUWF2N0ZoN1NZaVdpSms4R1VwMXI2d0IwR0Vn?=
 =?utf-8?B?TXhTQVNHWjE1Rm42c2QraUd5djdpank0Qk5rYVJ2TWRDVW5CZ3pOaDhkMlF4?=
 =?utf-8?B?NUhBSm5RWmRUY1hYL3V4L3R5Nm1Hdm91QTVSZlZFYkxtSE1DaHlLamYvanFD?=
 =?utf-8?B?WTlCbXl4VUFyYXU2Y1E5WUJudWV0T2p3LzJzTlp5alJzakNlWjFRQktYSS9s?=
 =?utf-8?B?RW1KdXViekh1Qzg4L1RsWkJSeUw3MnFESGRPOXpLMGR1NVJSLzIxSUM4cURZ?=
 =?utf-8?B?NzJKVHY4ejZqTTVTeDNkZm9CMm5QV0d5RSsralAzY3IrN1dGckxLRk1GY0d0?=
 =?utf-8?B?UTlkMnZ1WDhTeFpuUTFqTVJxcjljVjluY0FWUXZBVks4d2tmMHlWOE9xRzFw?=
 =?utf-8?B?YWRJRkVISEVVTVpoanBsazdndXFvdVc4S2swZXRwclY5SDRFdDRaeGZDNWFU?=
 =?utf-8?B?cEZmMWpJMC9sQVp5bkFOTWUzQ21qWjRkNGhOR3ZUZW5TcURwbHFOZGpWOHpX?=
 =?utf-8?B?OGhWUW9EeEJkS1dYaHBseGkvQmt2bEFDYWJKYW50TGJLSmR6S05VTmpvZDdN?=
 =?utf-8?B?NC93ck1MTWRiSm9vVWhKZUtUcHlHMmxWSEpDYWVHTGRMZ1lTUFp3Nzd4RDBz?=
 =?utf-8?B?My9kVTNDbDRXbTdhMFRuOXRML3NFa0I0bk1EVzJYYys1RHN5dVZZMEdiTmZC?=
 =?utf-8?B?V3diUXB2RnV5cU9sQVZOWHltUDkzOG5UZjhLWUZDb3VOejZIR09lZERxZnIv?=
 =?utf-8?B?S1hZS3A1OWMwcEM4WnpUNTQ3S1pkQUJ6cFFLbEdSSWxVcWNEQzFNeGxYSm9I?=
 =?utf-8?B?MGliNVgwbzNDZDhnZDF4eFhuZ09oN25WcFNEUVVuamNxSUd2bGpoU01Qb2Nx?=
 =?utf-8?B?dTJCZnpkWFpFWDB1eTRQMUYwWXk4akpicldac0lueHBKUzhhd0RMT1QwWkxp?=
 =?utf-8?B?cE9lTHVQRlZEWmlBT2Q5WExoc3BYb1JyYjBRTXNTR0EwT1RiM09xa29Zek1G?=
 =?utf-8?B?MU16Z1l1S2wyQko3M0hmbzBEK0cvNHRxQ3RSa3N3bE43eU1YTHF3N0FWbXdo?=
 =?utf-8?B?bEliQU90RkxFeWY0WFZwSDBDTWZheE9FOEVnd1lualQra09oZG5HTE9uMHpB?=
 =?utf-8?B?WW5KTHRVck5haHRkdlVTMngxUlgxSko4amNqckdzNVVZa01ydW1JOXVMS0xC?=
 =?utf-8?B?WkpBRXd3UzhxUGZzWUViZFRCQzd3MW5xaUNvdU5laElZRklROFQ5bms2ZFp2?=
 =?utf-8?B?SkRvKzIzbVhsWlVsZnJEbE1LR0lkSVc2angxNmNDMFlLMzVMc1JDTVBHNjcv?=
 =?utf-8?B?eDR1MHduOWRpVFEyc0M0am8zVDVseGRrTDdCSklHVU5LSFBPZkVOK2svZmY1?=
 =?utf-8?B?MlpHOGNWTSt3SkN3ZnM5QS9hM0V1UmtPSDMvNHROWTc4eEFkS1lUUDJRUjc5?=
 =?utf-8?B?VU1TM3FML1RPaEtFMjNxWmJiUUYwUGVUT3o0eVQ1TU9wM3hBbmhFVkJXc2c3?=
 =?utf-8?Q?67z/cPVVPvC8UBmiKDeX1RKg3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8dc042-de61-43b5-5120-08dbb36417fc
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10072.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 07:44:28.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdec9SfJuucQ9pk7qDovwOarjpQQI9EHOFQBNaHb6PQesqZTUmYsZtZuBYO3zCSQLm6NgjnX5ADcWa2oMeJccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB7923
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 09:22, Bjørn Mork wrote:
> Stefan x Nilsson <stefan.x.nilsson@axis.com> writes:
> 
>> Certain QMI modems will start communicating in rawip mode after
>> bootup, and will not work properly if communication starts off in
>> ethernet mode. So add a module parameter, rawip_as_default, that
>> can be used to load the qmi driver in rawip mode.
>>
>> The advantage compared to changing rawip at a later point using
>> sysfs is that the os will not detect the device and start talking
>> to it while the driver is still in incorrect mode.
>>
>> Signed-off-by: Stefan x Nilsson <stefan.x.nilsson@axis.com>
>> ---
>>   drivers/net/usb/qmi_wwan.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
>> index 344af3c5c836..968c60ececf8 100644
>> --- a/drivers/net/usb/qmi_wwan.c
>> +++ b/drivers/net/usb/qmi_wwan.c
>> @@ -46,6 +46,10 @@
>>    * commands on a serial interface
>>    */
>>   
>> +/* Module parameters */
>> +static bool rawip_as_default;
>> +module_param(rawip_as_default, bool, 0644);
>> +
>>   /* driver specific data */
>>   struct qmi_wwan_state {
>>   	struct usb_driver *subdriver;
>> @@ -843,6 +847,13 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
>>   	}
>>   	dev->net->netdev_ops = &qmi_wwan_netdev_ops;
>>   	dev->net->sysfs_groups[0] = &qmi_wwan_sysfs_attr_group;
>> +
>> +	/* Set the driver into rawip mode if requested by module param */
>> +	if (rawip_as_default) {
>> +		info->flags |= QMI_WWAN_FLAG_RAWIP;
>> +		qmi_wwan_netdev_setup(dev->net);
>> +	}
>> +
>>   err:
>>   	return status;
>>   }
>>
> 
> NAK
> 
> There is no reason to start communicating with the device before
> changing the framing, using the existing sysfs interface.
> 
> This seems to be a workaround for some userspace bug.  I don't think we
> yet another userspace knob for that.  And certainly not one that applies
> to every device.
> 
> 
> 
> Bjørn

Right, got the message and I see your point. Thanks for the review.

Would a quirk on the affected modem be an better/acceptable solution?

Best Regards
Stefan x Nilsson
