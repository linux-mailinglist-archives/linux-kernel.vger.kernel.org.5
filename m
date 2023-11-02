Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6747DEE82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKBI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjKBI6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28612C;
        Thu,  2 Nov 2023 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698915479; x=1730451479;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jjxDBOZdJc4vHbqVwB8kXxP8ncE4BsjrCVo2DpkDzms=;
  b=lIgkbUYSFj9FAPckRaongu6sXEha3+hs+15XbxZqKsu7g39LAAkoJagq
   yQVy3bHeJNm5g2Me+2F2Wyo5wRo6ypW017jaBuzoRHoTiAx61lRalV7pT
   DBp0Wxb3JqrG0ISHKwoigpKLSsH2QLL+5YOFNHXfcLwUqX8OHAExVXbd0
   ZF5ntqBuaMkErSMimq7kWYjILcJ2Wgbd8kvr17TGTXJU/gDcLxvAZxjlf
   O4wxmVTQA63ysRCptzMIP3bCgfLDqiMTh6ZLL3wRXjQ7YwPEB7dSuKDzo
   OyRhYcujoljqsqZO0Wq2J7EJs7EIdAWhD4NHA8dLTXecGP+dE6eM8oelY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="373709795"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="373709795"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008404181"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1008404181"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 01:57:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 01:57:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 01:57:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 01:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJua0yzd0ZXDU7EYzVZGPS1dpW2bS55Lgzfhii8i8A0u79mtW7E+QZGphe2nLpKrE5LugWjQAvD4CHqedNAw49TUWcE4J61gEaojD0uxQ8ToAstDTF8mxtCKch0w3TFwIzXemO9kPuMLZqSywdjKhf9dX3R4RqhfDgas5eDHkHRE+wpY5x9AqwHp/3BlfJeuTY6Cm1HiJiiGQ9pwo53BTGP+Wsl9DUW5AiqkAvkZCiT4NWapvYUlTTQbfpQtlvNKkJAxXbZ8Q0OvLXmen8x1/4/p1x/RFrIggVSpbfs/4K2VnYAjGP7VnT3FzDZZ8drx4yYMZYg1S4F4yh7WiOcGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fto+A8RqjyHg5kbgDqcfPF2RfgokuvJFS5VzD9yGZ6I=;
 b=NO70sPeIJmw8eyKE9ZRVTmSNkTKi8kCksxNx35cIRiQJdMy2UgPrcB9H47niPaxLZ8mqCYbkqATKAAFZAFEmkiXhHXHp1J6x82wyEpbx1rzik+SAQo+Wyc7CHBxvA0FUV2ofsdI/bkhDlaUuAalNHdaWq9bArisH/hQV7fw6slGWC5ENm87vnXhNiqyJFqLrADjNJeUOl8WFyQmO8+w/Anakh7l0SEBR/BXBJPnAbBc3ZNs0CDcwfqQ6VpA3LVL6ABSTJrhHLmYCH+AcwlEpaixCq2MycatpIuGCT/82Nmcdn9uyr6ek2sRVJZhfMtvCa01INmPZCRsLO3veRdOGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Thu, 2 Nov
 2023 08:57:55 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb%5]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 08:57:54 +0000
Message-ID: <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>
Date:   Thu, 2 Nov 2023 09:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] rfkill: return ENOTTY on invalid ioctl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 8012d642-2ce1-4d03-5443-08dbdb81cc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+fv+F3YaLxqa75ZDIo7mhJcaIhgoMgM0FxMZ5BSDEyoDI5auoru9w9So13GZ/o9pmIrX2pHKrEk5Pn5ZbO9zZC8whY5e8PnTj78kBwbEGS54CN2TNUb17DUSTKEanLSABjyluRhdibMR++9R4NW6eYegiQGc3+VVlsn1n36by6bex+wV0QTNh8hMIIdStqWfAwdW4bHfPCEXMY9vs2PE1vM28cq8wfvGgy0D1KX4Lv3C2Ii7F9Li2OF3gu2D1PaZRhg3HLVvHc57L10GMS6SMmD7+2r2mwOQuqHTDfpMZmAxaSY0vYoMw6ZN+621TZeBmRIOjs475ySNF7vhGfRNyFcs2vFSxX+w48BMRm5vcNfB8CDULSnXEFEbNyrp07JTVTDg9DVmOu0uIVeeTqxFgI2ddAnPyDuY0r9KPFC/+PWZgEmQSUP/4bIVVHyo3IOwXAQ7iDeKyphClGlG+EuddWdKsLxerBsju+ecavxtL7kfW11a2GfaFf5KmYnZz1Np0ShobKwvdvUi4MBuogATOQO2LXqrN73+C31QWSOP6eGw4hNZqRdBmZxkpbuntmKCGnmz/fhGm9oWqR/P/3OtvvIem7CERavQtShqIb+Ywf+qnx+i3mnI0CjMp74N95fXJ+PM+GDA9AZavRWjVEf1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(36756003)(83380400001)(26005)(5660300002)(66574015)(6506007)(6666004)(53546011)(2616005)(82960400001)(8936002)(41300700001)(8676002)(66556008)(316002)(66476007)(31686004)(66946007)(478600001)(86362001)(31696002)(38100700002)(110136005)(2906002)(6486002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9tdEh3NXlianl6Z0xPV0V6bXBabEI4TFRLWDgvL2dTNjRSMGh2eHJjM0Vx?=
 =?utf-8?B?Y01uNGNJWGxKeFdtdEZaQThNNlZRWjFhRy9zczhLUEdZV0Q1ZjZIVFMzaklE?=
 =?utf-8?B?YnQyVmI5UWltd2xmZE9JOXNsSXdiV0ttMDdEaFBZN2IzODBhc2lXWnAwQ0dK?=
 =?utf-8?B?VWxHQUkrWUVuTUVVY1I4L3k2RkR3c24xYy9Wbm5OZmtXdFU0bE0vUC83MWJP?=
 =?utf-8?B?dnZaamE1aVhSYWZNejJkaTR5UE1DS2dCWGRaNnVQaFIyVkNCY1h6QWRQK2Zu?=
 =?utf-8?B?UDdPaUFadW5mSTNaZ1I5MnFNSllqK3RObDR5bnk2QUI5Sklxb0xGR25RYjVp?=
 =?utf-8?B?ZE11QmxxRFQ1TDJheFRTeXoxNGJiT2xRN0ZocDhrZk5uS1R4Z2ZiK2QrNjZm?=
 =?utf-8?B?VFcyNElsdTlRREFTbnJqNzNJNnd6SlhyTGhUbThTNkY2RUw2QkVvZ0VTd0Fu?=
 =?utf-8?B?TjQ2T0tkVFJTUEJXS2NjTzZkUEQ1WmpxblRrb1hYeWxQNjMyUmpldTVBeWhS?=
 =?utf-8?B?azBBWk9JeVd5ZmNObWJHZnhETUFTNkJXVTZ0eWtCZzd5NmZtMFNYVDNBelZ6?=
 =?utf-8?B?RTY2VS8zNkxWeUp5allZcjJCbHRFeEZBU205SVhmT1pvT1Y4a1FMRHlCdjNN?=
 =?utf-8?B?SWdhMmhvSVNqV0RpcGhpZTQyUTJEMCtMcVNQanVxTjgwbUVCRFBDODFvZE9B?=
 =?utf-8?B?eFRSU1ovTmtRMmRyU2F3R05OM3ozRVQ4UlR4cW1MMVY2ZGZPYjdSdUNSdVZN?=
 =?utf-8?B?bmsxVXRoWm5iTUtNNEdMVkx4aW5LaWZTRXpobkVwdjFXMExqRUptLzRRVytM?=
 =?utf-8?B?SEFVK1orQjIzR0dHMHZScGlFR3llYjlRYVIreDRoVXVMcENGK0ZJYmNjNEd6?=
 =?utf-8?B?aDV5QWNzZlVkdjZiMHNJS0N5S1hGZ2ErZjZURUY1dHdkdnVIeXgyOU8rbWFu?=
 =?utf-8?B?U055MkxJeHBZeFVnY1g4czQ0UFVWVzB5bzhueXc1RjN4MWVrVEd1Z2hpYkww?=
 =?utf-8?B?ZUpRQW1oWVY4YW5PT3JDWXI2NE1rMjdUVUpSOFBhWERjdDUvWVVXRmlkZCtj?=
 =?utf-8?B?dUlYaHN1VVgwU3c5NDB0eDArbWxGWll0WDFtYnk0SlhUejUrcFQwQ25LelBa?=
 =?utf-8?B?dnpjZ0hPcjVmSzZUWTloeWxmRWlpdERRdFhJcTNEd21VTUVYM1FvMGw3dVNm?=
 =?utf-8?B?QUVVQjJCbXNFYURBRXpTNGpERU9sKzhVb3pJNExTUGtsOU1xQSsrVXRkVGxS?=
 =?utf-8?B?KzIyd1hBL2cwbW9nTEJ6L1krLy8vQm00cU5hNktEY1czUFEwQjFxR2t4blRk?=
 =?utf-8?B?eWdUMk1maUZvVnJ5MGlSbms0Q0k4eTRMcG5qTitwM3pnd2RLZ0d5UjJBNW5U?=
 =?utf-8?B?Nnh6WW94U3d1eEhwMmNkSnpmNGQ4Z2o3Vmo3aHZCZk5MRHVPdlNlTVlxcUVh?=
 =?utf-8?B?MmdkejVCQzJtNThOV0Q1ZTkvb3FMejVnR296TG5tOWtQdVQ5NEVSMVl6TDdJ?=
 =?utf-8?B?UzZ3dGFwYm0yR3d6R3FLWTU2QXprYTZpTmNnV0x3Mks1MTBoU1RkdHR2c2Vt?=
 =?utf-8?B?RUlZMDMvcmxzN0ZNUWZvT0xpUWtoOGlOYU1uMTJRU0lMWHZoK3FKeTUxb0lH?=
 =?utf-8?B?dkx3MnZSUkxlTElzZVZaQW5TeC9vVnJJTkNrTmtFc3VGbUd3R3BrS2QyS1o2?=
 =?utf-8?B?bGFXYTdrM3RnZjJDWXJJRHlVNHE3TTJYYU5KZXNlREdQdkRCcm1ZVXY1ejJv?=
 =?utf-8?B?a0FjUzR4NEhENTNBMG9NdzJFZGdPRklTcWZvRjhSSEdydFhYQnZYYVMybUFv?=
 =?utf-8?B?cGZnek5USjBxYzY0MTZFbjdrRHFVMG5qQm9kR25CYTlLaTd0ZlhVYk5QR0Nh?=
 =?utf-8?B?RktMbnZtVGxVd215azN5RjAxdVRRSWx4dWlGeFY5UGtWeHk2ak5qQUdtdzdn?=
 =?utf-8?B?cWxoZnFmODdncU0rU3BwOGF0eTVGVnowcG1FUGU4MXUwT3dzRFVCRW83MklM?=
 =?utf-8?B?TFJEWTVGRHlKdTBRcXVuUmk3R25wSks2dEhNUDdqMDhyMklMdVVVMEJsVkh3?=
 =?utf-8?B?STY2T0tGSWhOTEdvTEFUZVFxUkpFMDJVSElGNmQ1Vm9mRjNwTnFhNVJBVkc1?=
 =?utf-8?B?N29PTGMwU2dJVmpBMi85cytPZ1p3Q0tvNUt3Wmw0OWdMc2FRUkdteUxoMnBL?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8012d642-2ce1-4d03-5443-08dbdb81cc39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:57:54.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RBZmaA6WiZcPldds3mNZaRXb6yjXxMZTd5HLDKV2GFjqwZpDlFNG8X0JWmOX9yf5jiUSpM6fM6MIpOidlYbJM5rmoCW5WRH60IGobN1ux8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 20:41, Thomas Weißschuh wrote:
> For unknown ioctls the correct error is
> ENOTTY "Inappropriate ioctl for device".

For sure!

I would like to learn more of why this is not an UAPI breaking change?

> 
> ENOSYS as returned before should only be used to indicate that a syscall
> is not available at all.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   net/rfkill/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> index 14cc8fe8584b..c3feb4f49d09 100644
> --- a/net/rfkill/core.c
> +++ b/net/rfkill/core.c
> @@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
>   			     unsigned long arg)
>   {
>   	struct rfkill_data *data = file->private_data;
> -	int ret = -ENOSYS;
> +	int ret = -ENOTTY;
>   	u32 size;
>   
>   	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
> -		return -ENOSYS;
> +		return -ENOTTY;
>   
>   	mutex_lock(&data->mtx);
>   	switch (_IOC_NR(cmd)) {
> 
> ---
> base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
> change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1
> 
> Best regards,

