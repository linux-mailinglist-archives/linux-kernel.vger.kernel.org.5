Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79202807004
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378389AbjLFMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbjLFMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:41:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CD12F;
        Wed,  6 Dec 2023 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701866516; x=1733402516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JIA4MRWvRqIvY/d9J3zDIp0iTO2lkiZ206f6tRTLaz0=;
  b=kqUWZKXWgJh29SIhrQEnTw8A5nRX5v5Y7H44b0WuaADkRTt8cmLFA+GJ
   fAMEFfmhIw3JQmBawpb84ynF2EExtqVg9xU4vhwQyec5AKksA3gU+sbTw
   XcyYVGY+xsXo4Mc5hW5bH2GSM93f/zSV/Loh7HeaakEiuX+3+CZEmHQTR
   cCPIKYD/vWOWaiaKHiwyJsj1J4ogQedYqfFlBxC6Aax3Ol7XbHYUVi9/c
   goi3SDc+TbfdqdcN4GlNEoBvh/KMlr7BJD3cRu4mmWzcx6M5lmh9/DY6o
   YvwePs466k/tZGMGLAFEz4iHx9iY+s4Ygkk1M+AruSD6srP4EnooNp6VY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1149395"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1149395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 04:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771289483"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="771289483"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 04:41:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 04:41:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 04:41:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 04:41:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaDdHWMIH1cp4AM1DUElolAek58FmIPHp6V+/OVRn1dh/4ZRevS/a2IElV0OVcSBaWZQvGRl0JHNcuVSLAfkP5Ol2t2+N912mtWJ7Af14mLOLwCqEpXbMRQ/G54dD+FfGRsW3fTvomrpPbzbXtqfJN/63FZKURaUh9rehBC5Lk81pXjVd5I99WUrUNJFKFWoyg1ZnovyftjWH3Htka+xM/CazmEfNIFR0c5WlweG9c3OMheSxINtl55rXWOXk8F8iOUfuO9G1CoYQ9c1NwaHg4IiW4dQH7HWm9bnDRfTFg5BsZZ+zoKSZYUwyNz9jHHqBpyJAD6nO6qXGEj4ZBWVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeggSnmFShKdRLNzdvrfBRJaqE7lCFIb/eIVhJz9Gug=;
 b=a9iH2AJ+I3tj+UMbWlwvbVGPdmvDW6n4/kT7u2t6GedZg7MulCKA0AozkClpb47w5iiC8JJQ3pWUAl2ZgWp19btWzZ4wkkJuL92YaMirwCDmbn3kFBzGPxJL4ipMW65Y0GOiPfN3pAZi2J8OmyUSFxB6QDqeR8liaZOOiuIeSlf9fm//grE4pr8sCGhiq5plo+z8UUIYsq5RX+vyoIKjm0PEL3/aub7GAifLRiAvaVkB/LDHwxmK3f5nDHh5eJWQZd5gghHLPSYKVZv6rPb1N7vapS46FLatBf7VcFJo8uuRBBQ2qgs11ZXsWFA20c35K2FuoYZEoup9iJOGxxXMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 12:41:47 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 12:41:47 +0000
Message-ID: <2a0f3c2a-71fe-4c79-8827-e53088bf3761@intel.com>
Date:   Wed, 6 Dec 2023 13:40:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>
CC:     <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <jeffrey.t.kirsher@intel.com>,
        <shannon.nelson@amd.com>, <kunwu.chan@hotmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@kernel.org>
References: <20231205095844.2532859-1-chentao@kylinos.cn>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231205095844.2532859-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e03a9c3-6fde-4716-fd19-08dbf658b54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+7SGRrBBmWg/ggrm7X4Bp93vAFYpPGHZJqhG0f1Af3REu6eUqZIqQs1MdE7jnZa2pJeo/X7xSB/BhE1BXY5LBG0RsDtdFuvbqK4uoor3uFJAWrSSnuKa+Dkz0PNU/rO2TJnPGm8ZzeTDEzMEUpgJh7J6zeZ+UD+wFpX2HXKzKDUKZF4LnRWBTYbMBRiD2Vgaf7AffCHYX9UEoXu3utH6w2R5na0ZuUoP4XWEZSxCnLdftn8KoC4nXF6wg7Hau3iLZsM50kyMyQ0fP9eiL9OxQp/OyQglKxxTGCY6vaFDCDOIapGoHQS5ivHcUQyIFpvTtrP5NWoB3fKsX+hOqm5T7i9c6HhjSF/8Mra5lbbj+pwWed6Ehv7x9TNhfwpVcK2DOovCGEXdgUYyAZaBD+eusS0pHgUJLTe2Mu4weGdlqgOGwFmbHEBjVmmUF24U78ktT8cHpCPaKUT6fW7Hx7uQHjfkXKHJQeBEIIauhFWfHw2fbtyQgXtJfAbSUcNYliZ3VuuqMBOqz5CfLzwllZdagTNImoK3HK7ErMCxvJHr76ma5M+YtuNY3F5iFsRhMsNs0XDes/bXUZEqyNhxEGADjYfUXsvkV8pukKMptyYOkMpeBpi1vu0gAH9D9T7OWzWlE51my6+k77GCJ7CBg85Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(82960400001)(36756003)(38100700002)(31696002)(86362001)(6666004)(83380400001)(5660300002)(7416002)(66476007)(6506007)(6512007)(66556008)(8676002)(8936002)(6486002)(4326008)(66946007)(6916009)(316002)(41300700001)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEllYncxZ05RNEhJbStoNjVmQ0VybDFiU1UyMU1QMko4dGg5T0tnc0EzcW9W?=
 =?utf-8?B?aURGOGhSQXJRMld2aXA0QmVoTGtEdjU5bTNkcmJvdFd1elErdWpZaFcvQUl1?=
 =?utf-8?B?UVRTS3p3eWFtdllSUmJscjN3TFR2Z0RRVlQ0QkgrNXhWKy9wNGlhV3IrdzZr?=
 =?utf-8?B?djMyekMweGE4cmNkSzdld0w2REwwT0t1WktqUHNqdzY3eGhTZUp6U0dBYmdP?=
 =?utf-8?B?ODRWZEw3L1lOK0pHbFhMSjl6TStPTnB1Vks4RkdUcGx6WXJDaFgyR0wvMDR1?=
 =?utf-8?B?a3VDNytBRGVVUDlQT3ZnVEl5WmY0MzI5WGdRL3d5WkZxb2I4Ni9vR1QwdkZC?=
 =?utf-8?B?S3JzYjYrUG1ta3lGQ0tOUGhPTStQazZxM0JMU3l5cFVPYld5VWJiUlVLNkto?=
 =?utf-8?B?R1pDcjhRZ2ZMYTlNeHBDMjlRb2s5SVlhZUJ5ODZBbE9FOGhLZDNOZmJEWWZS?=
 =?utf-8?B?TDdwK1BlREhSV29wbWdqaW9EV0loNll3OTA5WCtsaHZnWWhucloreHNFelZn?=
 =?utf-8?B?MTJSYzlhZjBLQTZuTGM1VndGUyt0ZCtDb1JUOFFiNTZ3ZERMKzBrdndLbkxH?=
 =?utf-8?B?MXpBZXBJcExYcGFLTjFvZEtGeWw4TUpzZVdrU3VHd2JjeW0xWXVnSnFXU1Zp?=
 =?utf-8?B?UU1YeGd1b1JZOHV3ZjZLSWZoaHJJZkRqNWthZlJuTG9TUmFDOENPZk5XOElN?=
 =?utf-8?B?NkcwaGFzQUI5cXZkOWd1ZWpDVzdRU1loaWhWTis0VisrM0hYNHVnSDRVUUc0?=
 =?utf-8?B?azZGSW0yVXNUYmpkNVdxRGhhOUJGb0ZLd2MwM1RDUVBtaW1UdkRNT214bko4?=
 =?utf-8?B?QVRvUGNyaThZQ3lNTFhFREF1bmloUTMvVWwxSDU3amxqSGUxdGtsM0dQV3pW?=
 =?utf-8?B?TTlLd2JxR3pQKzExNzVOdXUycWFWZ1M2OHNlbmxETmYzejFOQWt5RDg5N0xO?=
 =?utf-8?B?MzJCYk5pVUpWcksxVTBETFBHdGJwNGJhdk1EZDh1amw4akR2VTRlcFdhdndz?=
 =?utf-8?B?MFFCdTluOXFXQzhjcHVpdXYzNzNnTTNaSlNOR2VMWkU4U21nWlgzVkZkYlcx?=
 =?utf-8?B?cG9xSTB3ZzNpUU0vVWFxZkxNblFlaE9abnFOQ2ZUTEdOYktwMUo4cEc5LzAw?=
 =?utf-8?B?Z2tPbU11SUxTRnRmNTNaV0lNcittcXhVcVlxSExyWENlS3VwV09Qam5KbEQ4?=
 =?utf-8?B?ek82M0hDRHVjQ0tzVW1OMDI5djhFU3crZW9RNkVzK3BhZ0hTeEpJYjdvRzFV?=
 =?utf-8?B?ZXlFUzV2eHFRWjNoZmpzZTM2ZFpCZ09yTmVvWHdsQkRPSGxRcGZ1VEhveisx?=
 =?utf-8?B?ZGM5enIza3poTllnY0Z2aHV2QjZoMmJJLzRrbnhJdUNURXdleXVya1JRbzhq?=
 =?utf-8?B?WlgxT1czNHRvVVhBenJiSmFVU1FIMmdMMlhwN2Y3ZlFMOXhCY0dxTVFwU0d6?=
 =?utf-8?B?aVM3YXE2MXdPbmhTVk9xNDhNUGJZSTdSd21xblNWblBjNnI4WnFLbmMzL1dS?=
 =?utf-8?B?YkFXcGJJUUFTc2dqbkk4eE9jM2RaLzA1VmNNNDMxWDBlN1I1RlFrQWEva2N1?=
 =?utf-8?B?aDZuK2ZkcTR3a01sT0d1VEkxa0ZMdWtYUVh6K1BUaEpZc2VhdzhZSnJ5WFNa?=
 =?utf-8?B?ZzNQSXJ2dnM1dDZuZHhrY3NQelU2WmM2UEgweWVzcGx6WXF3MEFZc0RTUXlr?=
 =?utf-8?B?QUhNT0ZOK056U09TRDhNeTM3RFlKN25pN0dSdGpRZEdBV3ozU2RJY2VGZk11?=
 =?utf-8?B?RkRTazNOb2ZVWTE4QW50blZnWnh5YTdKQ3BidDlGYnNLWFU3SGtWdXY5TWo3?=
 =?utf-8?B?clBZN2U3SDZaYmNIVmEwV1JkNThrUkpxaG9TU3FrREpJYXVSdnM1UXhERCtS?=
 =?utf-8?B?c1pPNFlFSEJ0cjFZbENpUjdseHdCMklranNZaUkxVm94OWsvOEcwU0tEMkU2?=
 =?utf-8?B?eUZOVmEyWkw0SkU3YlJJSS9qK1pXL1ZaeFhVMlN6MFNiZnZvVFoxOFFPOThl?=
 =?utf-8?B?UTF2YmhCYVZ4Vi90b2VuSFEvYWNXSVB2VXdMbUd1VGVzaFVRUXN0cDNWR0RJ?=
 =?utf-8?B?MVlCTlJNK0srVXZHcFFZZzBuRGFzSk00ZHVaVHlRUGpzSUJqd2FobHczUzgw?=
 =?utf-8?B?d01NbG8yUTR4M1d3VUdReTk0T01XTzBKMVRkZHltb0oxTTdWbW04RUVBOGcr?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e03a9c3-6fde-4716-fd19-08dbf658b54e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:41:46.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufn/FARhyFmLevttqrC2W7WjakehojcDtvTNf//FKu5Fb3TgFipK9Y8W+YdJ4vxcBSEL4Buo1MpvvDGnUEZbj/ftgJYa/X8qxnB9XD3f6o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunwu Chan <chentao@kylinos.cn>
Date: Tue, 5 Dec 2023 17:58:44 +0800

> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256.
> 
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Your Signed-off-by must be the last tag in the block.
Perhaps the maintainer could fix it when taking, so that you wouldn't
need to send a new version only due to that.

> ---
> v2
>    - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
> v3
>    - Use kasprintf to improve readability and maintainability
> v4
>    - Fix memory leak in error path
> ---
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 88240571721a..78a7200211b2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -72,29 +72,31 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
>  {
>  	struct i40e_pf *pf = filp->private_data;
>  	int bytes_not_copied;
> -	int buf_size = 256;
>  	char *buf;
>  	int len;
>  
>  	/* don't allow partial reads */
>  	if (*ppos != 0)
>  		return 0;
> -	if (count < buf_size)
> -		return -ENOSPC;
>  
> -	buf = kzalloc(buf_size, GFP_KERNEL);
> +	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
> +			pf->vsi[pf->lan_vsi]->netdev->name,
> +			i40e_dbg_command_buf);
>  	if (!buf)
>  		return -ENOSPC;
>  
> -	len = snprintf(buf, buf_size, "%s: %s\n",
> -		       pf->vsi[pf->lan_vsi]->netdev->name,
> -		       i40e_dbg_command_buf);
> +	len = strlen(buf) + 1;
> +	if (count < len)
> +		bytes_not_copied = -ENOSPC;
> +	else if (copy_to_user(buffer, buf, len))
> +		bytes_not_copied = -EFAULT;
> +	else
> +		bytes_not_copied = 0;
>  
> -	bytes_not_copied = copy_to_user(buffer, buf, len);
>  	kfree(buf);
>  
>  	if (bytes_not_copied)
> -		return -EFAULT;
> +		return bytes_not_copied;
>  
>  	*ppos = len;
>  	return len;

For the code:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
