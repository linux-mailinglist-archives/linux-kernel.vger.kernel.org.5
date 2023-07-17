Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52815756857
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGQPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGQPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:52:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3286910D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuGpDViJyfzmP9G6QTiFk3M91v5YzuExE3CHYaMpUw8DnIDhIWq7RUrM7ZGbkO/opJWq1549VKCmqW5hriYcxkDZOETFAb4qMw3tn6gvHQ1tW2u71iAgpOTl1Gry01pM7btEsqKg7MwpoS8YBAjP3Jivj5SoLnVAZSbY3/juhkh1VwObbl3PFLywbH0Hb+k0uBG2nsEBZ8uXwz7yoJoSg/sryHsFzNJBuX/UShpxHApnoS34/nhwwe2vikJXYNFQOGBxt/HlAvkscyHL8ZhQhmYIIYyICQW/5fzzr5JKbGypb+ZTlON6ufJqHKiI/eVWQqdergaclPYTlaBBl9RNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg84SSzdAUCINwXm+Oi++PB5HVNgpszTJnyWh2QhSCE=;
 b=Q47efJfyMZCw6ZEOv8ao/NBNaZtzhBl4QWicZbj7BPnPSSabfs7jkKAaVqkm4fxOHzGSzOP/YL/YjLNKd2puSzuupTfxqqhx9eCVrOUEB0dXWKxC4pJZJXy42CV8JVHxdLCqutn/HBhJARhesyaY9DDW1/hTNV7214KdXW1EAfcgJlRn5c12Ds/seJTQcjp8aLq4auTvaRTTYz6128m+qmiBsRDFqDJE6r2xdWVXaXlzl9cn8djUiFrbS6jtAKUHCpUm1wauOESp7G+7xmiPuW5DxZ0I9Z36beG7yo0UzBJR3JwDSy0rfnXtkjDmcGE0kDxF+0hgqAQp5pw0uLFlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg84SSzdAUCINwXm+Oi++PB5HVNgpszTJnyWh2QhSCE=;
 b=etUfDmqj3ZMfRo1VMLY0w4UdCQjrgaRKhqFJjGf2bzkJM2TiNvqQgx+R6lNDJhSV3SNA8PE0OupYFG7sn907YQVuD5iOGNLKx3rNTdz9GVMS4ocXilkUiI9qMPqfmgFV/l//zdptZX3ErOd6UNEJigBm5W+RIPf2F6qvCO7ewdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by BL0PR04MB6481.namprd04.prod.outlook.com (2603:10b6:208:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 15:52:31 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::c738:ef27:97ab:fa11]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::c738:ef27:97ab:fa11%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:52:30 +0000
Message-ID: <9bac379c-c482-e52b-f7bb-33ed4ef49b40@ni.com>
Date:   Mon, 17 Jul 2023 10:52:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES
 define
To:     Rodolfo Giometti <giometti@enneenne.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230630071826.105501-1-giometti@enneenne.com>
 <20230630071826.105501-2-giometti@enneenne.com>
 <2023063017-traverse-accustom-97f4@gregkh>
 <56e461b4-2cd8-ec89-86b2-68544826cf73@enneenne.com>
 <2023063015-immerse-broadside-3dab@gregkh>
 <ca137a28-28a3-f563-52e9-4ee0ef1daa9f@enneenne.com>
 <2023070327-gangway-comic-6e15@gregkh>
 <a743ab0a-fd45-2cd1-2546-44cf4547266f@enneenne.com>
Content-Language: en-US
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <a743ab0a-fd45-2cd1-2546-44cf4547266f@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::29) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|BL0PR04MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: a288b758-37c2-454e-177f-08db86ddd408
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUFDVa/ryAIUpgsibjVl5OJ/BhlsRQBZrXM87zaC/3lGSIvsrzjJIfM9zYmUmEvkWOSZgYHBmAGnN22zE68WgZjbBmkR1BOQLkUC5FiqqW4UFEKSaS0IEz+jkn70vZABOu2a/MU9AZoPmlD1Qa+eXdkMa82g6uYtkxeeXOafPPLAGt0jiztRtBMzB+j19u7eHQLm4AFH+g8PxHRvN2cWcjMVLY+3JQeiwF2/wuwIIqjfDsnFsf/oUTodaFfqY/MUdLFKvFbMV+aYp7g+IHCzlZM5z9OgCkw3UvvX5WVD9npaZf2/ag3M/xjlRD57AlKx8HiOL44zsPcnA2XVStHV86GAMylQTO0tGObtdLJhW3zysIVNSfQ+Ypei7sQY7PvYuhLv4YNLc/KpX6wz4Ce4+yRzTkQ+/BzU487ZrQiOH27832prGd3JUmkOmTxxv8PQ0YnWwPpadoAx0sQ3fWAj+hwVN9e2BbI/2EoT/7bGHAjeueEBJ9S434044Xq5gFBrwx+Hq0u7+bD3Tt2hDkQN+n3ZpIuwn8llggQEEdz+NpfXjB5IWg/QVwzvSH9/a5wcdZdC+AEAabA3Knx7jomuMYsCuRLACe3qiCPyBWpHVXwzR6VpqYrbC3w8Mb/xM4OV8cteFYQBEntYD94SDxsPtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(136003)(346002)(376002)(451199021)(44832011)(478600001)(66556008)(5660300002)(66946007)(66476007)(4326008)(316002)(8676002)(8936002)(2906002)(41300700001)(110136005)(31686004)(6512007)(6506007)(53546011)(6486002)(26005)(38100700002)(186003)(2616005)(83380400001)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVUrWHllbFZ0SGQ5TlA4UmppMTlzRUlIOWIzVytZbHhlVUZkMXBHVlhGc2Ey?=
 =?utf-8?B?WXBBVkh2cGpIV3lkdDF1cmhVOFJta2w0Q2MzeXFRSnpQOVFxdURXdEdKRkVU?=
 =?utf-8?B?bFZLY0N1VE1DTkhRYnpOYWNsTkp5VHBocDBxU2NoMjE2aXRUR2t0TkpzRWxo?=
 =?utf-8?B?bHFwVERtWXhnU2FlSnNLNXA3b2ZlN2JBQTZ5TFBWYzhzZWpmdzVodmlJSVBx?=
 =?utf-8?B?OUZBQkdvSml5V3IvTjhLakcvNk96NUpndlZHOG8vbk1YTXc2aysyMSt6K3Mr?=
 =?utf-8?B?V015MEcwcGF1b3pabTJpeUZvY1VaWjlzZ2xaQWlnV00yQ0ZWeXd1UVVTbWMz?=
 =?utf-8?B?ZkJKZUtpSnNmTU5NKytVanRUWkh1cDU4NnlYRGF0M3puLzVJYUlyUUVHejVU?=
 =?utf-8?B?TitEY2NuR09yZU56WkZ4dzlnMU1naU94S0JFVW1UZHZtdzJGMW40Y0ZNa3BG?=
 =?utf-8?B?SXVPL0RXTkdBM3NrZXZsTUh0TUFva3NmVnkzbktWWTdsVEtpOVl3bTVTQ2JC?=
 =?utf-8?B?ME1CS0U1OTl4Sy9tQXZwTjA1ckgvemNSaWozMVJOVVdHWkFNU2pzNGlFdElE?=
 =?utf-8?B?M1NCV3V1YjR6K2x1RzFqdTZ3YUxnMEdIOXhXVktZUGpUR29zWG04V2JwRGR5?=
 =?utf-8?B?NlI4OHRwNXBXUFJvMW16VGJlSlhjQlE1RVB0UDRLWkhUTndRa29TY1NlcWhk?=
 =?utf-8?B?Tm1jckNoYm5xSWpBQnNaWW1BR3VmZHZtZmpNSE9hTS9CV3BOVDJ1aGhyL3N5?=
 =?utf-8?B?NmhCQzBCVGllZXJRL1JWaXVaTW5DUi9Ya0JmSk5yWVpPOXcxY041anRsSWlH?=
 =?utf-8?B?S3ZXVFJPZWdyc3dCYkZ5MS94c3FtdmFTbkkzRFpodmMva1Ywam9odFM1bDI2?=
 =?utf-8?B?dGtsWVhlWUJ0WDZFS2w1c3g3Sm5RZjJDREJBYkR0Qjc0RXEvRDRSaDIxaWkz?=
 =?utf-8?B?UDZYZmFuY3B1S0plaEd6RFBNbFR2Zm95TG9VNGdRaHZRM25IRFZ6cUNKUm03?=
 =?utf-8?B?U290RUp5R2tlU1lRcjNtL01LYnk3alkvQkJYNENnZ3JWSWpPV0U0MXRpKyt0?=
 =?utf-8?B?OFVVS1JicWZtRzQ4NDZjRG5ON0IxdWxFNnNjcDVGZ2J1eE5tdVA5VVBIcitE?=
 =?utf-8?B?VHZCbnRxMGdBMFdQL1FYT2ZyYTJ5VEpISmNtNmRSMUdiTGtoRk9taWJKNXJI?=
 =?utf-8?B?R2NNV3o3V1pJVzdQMlBMb3RlZzY1VWlJVXptRlJkaldqcEx4TGhCajUyMCtJ?=
 =?utf-8?B?OVJKQVBGRWYyRUR0TEd3dVVydm9wNXM1R2JCNzJFMFluMjM3aTNacitwVjNq?=
 =?utf-8?B?aDBxNGVBeVNGcFNDZ0hKWnVzMlROcTdPUkN2MUdnS1VOdENSV1JtaDE0VXpy?=
 =?utf-8?B?YkgySGR1Z3FIb1FQcHdHSU9senNuZVd6U21mRUtsWkYwNnlYa0xtdC9rOC9Y?=
 =?utf-8?B?MUxONDkzTG9yelo5eUhvQjZxN3NOU2xwdUw5aXViTmxmT2s2ZStibTBlZm9G?=
 =?utf-8?B?cWlPTURPQzJLdTRBR3NQcktjSkI2bFQxWUc1UkVVNVgxSUxjNGxXYVZLMWlT?=
 =?utf-8?B?TWNpVFNKKzhyalZteTdxd1pBVEFkQkxSTTJyVnJzMytvMEFhZ2ZvVE4rTndS?=
 =?utf-8?B?cEE4Z1lBNDQ3Y3J4NWNxejN3OURBQWl2eCtrbXV4bEc2blZQVVgrZHRWMFdG?=
 =?utf-8?B?RWljV25jREN5cWFnV2w0MTE3UEw3WDlORmVId1hiZmRvMTFIaEhCNmZvYU5i?=
 =?utf-8?B?WmtrNE0wQVk3cytUTWxINmtMeUoyMk1GNUh1UTkyUytIVFBpZDMwTkdnT0o4?=
 =?utf-8?B?amtXMmJNZ2Y0RXFycmovaUo3TWVyakhhQjNpQzRzNHBXZElaOTVVWlNSZXJN?=
 =?utf-8?B?cGJITWo2MkVVZEVsL09yY1o0dXZNOTBic3htNmpCT2c5emx3bW5xYmZDU0Q0?=
 =?utf-8?B?YlpqbUhKUERabTNVanVzL29pZU5WNVQ3SFo4cERtdERrL3pwTGE2Mi8wZ3RZ?=
 =?utf-8?B?UjJ4WUxnTU9wdWp6QnJXR3EvUkFYOEJkM09wczZVempZblY3cjkrL05DRTEx?=
 =?utf-8?B?Qnk2QjExWjNjUmlJSXBIWkFWYnBzanV1M010K2xnaHJnTEdHckI4VGg2K3Zr?=
 =?utf-8?B?VzZGU2lWRmo5T1N0d0ZnS29FRUFEM2dXZm9ySjFFVlpHbzNiQjB0cFYrQVZ2?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a288b758-37c2-454e-177f-08db86ddd408
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:52:30.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCA72++F54b9AwdgtLXeeytd8a1GSO1u0yknLf73jTpSvh7zkc+QSFzm5QL1yn/B7wHcmckeDVzyQFmdZX23sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6481
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 09:47, Rodolfo Giometti wrote:
> On 03/07/23 15:38, Greg Kroah-Hartman wrote:
>> On Fri, Jun 30, 2023 at 03:29:50PM +0200, Rodolfo Giometti wrote:
>>> On 30/06/23 14:53, Greg Kroah-Hartman wrote:
>>>> On Fri, Jun 30, 2023 at 09:50:33AM +0200, Rodolfo Giometti wrote:
>>>>> On 30/06/23 09:31, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
>>>>>>> Userspace PPS clients should not known about how many PPS sources can
>>>>>>> be defined within the system (nor the rfc2783 say so), so we can
>>>>>>> safely drop this define since is not used anymore in the kernel too.
>>>>>>>
>>>>>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>>>>>> ---
>>>>>>>     drivers/pps/pps.c        | 6 +++---
>>>>>>>     include/uapi/linux/pps.h | 1 -
>>>>>>>     2 files changed, 3 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>>>>>> index 5d19baae6a38..1a6131608036 100644
>>>>>>> --- a/drivers/pps/pps.c
>>>>>>> +++ b/drivers/pps/pps.c
>>>>>>> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>>>>>>>          * Get new ID for the new PPS source.  After idr_alloc() calling
>>>>>>>          * the new source will be freely available into the kernel.
>>>>>>>          */
>>>>>>> -    err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
>>>>>>> +    err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>>>>>>>         if (err < 0) {
>>>>>>>             if (err == -ENOSPC) {
>>>>>>>                 pr_err("%s: too many PPS sources in the system\n",
>>>>>>> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>>>>>>>     static void __exit pps_exit(void)
>>>>>>>     {
>>>>>>>         class_destroy(pps_class);
>>>>>>> -    unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
>>>>>>> +    unregister_chrdev_region(pps_devt, MINORMASK);
>>>>>>>     }
>>>>>>>     static int __init pps_init(void)
>>>>>>> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>>>>>>>         }
>>>>>>>         pps_class->dev_groups = pps_groups;
>>>>>>> -    err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
>>>>>>> +    err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>>>>>>>         if (err < 0) {
>>>>>>>             pr_err("failed to allocate char device region\n");
>>>>>>>             goto remove_class;
>>>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>>>> index 90f2e86020ba..8a4096f18af1 100644
>>>>>>> --- a/include/uapi/linux/pps.h
>>>>>>> +++ b/include/uapi/linux/pps.h
>>>>>>> @@ -26,7 +26,6 @@
>>>>>>>     #include <linux/types.h>
>>>>>>>     #define PPS_VERSION        "5.3.6"
>>>>>>> -#define PPS_MAX_SOURCES        MINORMASK
>>>>>>
>>>>>> Why change this in patch 1, and then delete this here?
>>>>>>
>>>>>> That makes no sense.
>>>>>
>>>>> I did it in two steps to be clear that the first step is about a better
>>>>> redefinition of the PPS_MAX_SOURCES define, while the second step is about
>>>>> the fact it's now that define is useless.
>>>>
>>>> Better to just convert everything in patch one, and then in patch 2
>>>> delete the .h #define.  That way, when userspace breaks, you can revert
>>>> just the last patch :)
>>>
>>> I'm puzzled since I did as you say... patch 1/2 increases PPS_MAX_SOURCES
>>> value while patch 2/2 drops PPS_MAX_SOURCES define.
>>
>> Ah, I thought patch 1/2 renamed it.
> 
> No, patch 1/2 just safely increases PPS_MAX_SOURCES value as other drivers does.
> 
>> But why increase it if you are removing it?
> 
> As I said I splitted the modification in two steps just to highlight that the first step is a better redefinition of PPS_MAX_SOURCES, while the second step drops it since it's useless for userspace. As you noticed this last step is not trivial since it may breaks some userspace programs, but it's also true that RFC2783 doesn't define it, so well written userspace programs should not use that define and then they should not break at all. :)
> 
>>>>>> And if this is exported to userspace, removing it should break things,
>>>>>> right?  If not, why was it there in the first place?
>>>>>
>>>>> In reality such define is not stated within the PPS RFC2783, so userspace
>>>>> programs whose relies on such define are broken.
>>>>
>>>> RFC's do not document Linux kernel apis.
>>>
>>> It's true, but well written PPS clients should relay only on PPS API which
>>> in turn doesn't states that define. :P
>>
>> Are you sure?  Have you audited the clients?  if so, please document
>> that in the changelog text.
> 
> OK, I'm going to re-write the changelog text adding this information.
> 
>>>> So if any userspace code breaks, you have to put this back, sorry.
>>>
>>> If you think that patch 2 is not good, no problem, just drop it, but please
>>> just consider applying patch 1, since increasing PPS_MAX_SOURCES value is
>>> good.
>>
>> You can't change a uapi value either without breaking things :(
> 
> I see, but in this case what do you suggest to do? Keeping 1/2 and dropping 2/2?

I'm confused here. Is the problem just that the uapi value cannot be dropped (since it is part of uapi) and only patch 1 can be applied?
Or is it that the uapi value cannot be dropped OR changed so neither patch can be applied? If the latter, how would one go about raising a value like this to allow a higher limit without causing issues for existing uapi users?

Regards,
Charlie Johnston
