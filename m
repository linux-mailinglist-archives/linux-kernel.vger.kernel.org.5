Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D780C1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjLKHQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjLKHQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:16:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976DD8;
        Sun, 10 Dec 2023 23:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702278976; x=1733814976;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zO3K8E/OOkR/AQg5KBO19PFwyGNL8OiAa0PuHF5StvY=;
  b=WIIgRwN03X/lEwbvOOQB5BAwSVGJDn/2m7p+Q9YnpdS4WVt6yHt6aHSC
   I69r3vvTDPeLUKcjJ2Wy9IoCL6+MBTpOfnr1Y0sH5oURD5IIPsBeENZKa
   mq7ZnBGPaga94lIRGFuUar1dFbX8VT8DyAi5MsO37qWMC8umvdYlbu1me
   xrSo3RfL+GFvPzSZHxEWHqI1APaSEX5/7lHycpEfsNGkb+S6SAbtCZqL1
   g7d/jzVWUk/x5pjk7EEIkcGoWe9cWKxZDbTb4pUpvG65M8+0I9Gk6kk8j
   O8eMM9HkqlOJR7uE9Bro49OkinH8EZYtzqE88/96yaa62igl7R4f71AWZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1472954"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1472954"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 23:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772937127"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="772937127"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 23:16:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:16:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 23:16:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 23:16:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 23:16:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXb+ZhE2IgiesV8XMfFHNwsCW247K6jsBHUxadmjzhKi9SnQ1NeeuXEiAB7IoBrKiwHhH6SwMJgax1Ct/KKtfxukGokbUr7S6aGMZ8ax0pz8wElGg0TiBQ48ra5xcUSnT1TxuuTz+REM53ZypvutIxgjZ728x12UM+mUMWRyF5mnq6eZHrzDNMspMQvel9Y7g49+kqXWbNXi2pdxyIy/TNrxkSMs7D4es+t74OJ75VxxilFoC/tXDPR5SZT6bvleLWS29HOfwmwHGmEb+LKi/1bLm7P/Ocej5FD+dBwbe0hm3AUtKkTarnUek/LGA56H5KERT5FBC0VyTQ19n4EN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdqkkC/5mm3t+WKRqhgw0Mm20+h0qLDOsvZ29jFp7Dw=;
 b=SrRy5A7DRKagjU0SGZC0RPj+zqgF4VZtzBduhJGKyMCGMt7Uf6CP/zwa1AzdlbsFhluiYM+1OdFFCYXSn6d9P2lm/fRwGyHkvktwjr2sIEDuXxoy/AU6Mzk7528eMC5jRJHsrdiis9DilkV1bQY2iqtS8u4TQVTNelImvWnOqrYHJ+GX+g0iWFV+eitnHGo/qDGYROLyQYD9FrfmeRpQlDsqAdEer+Ot34/SvTChetslMcmwIQqfKIczFKB4iY23b93t834IgfIWnNDBAm1XAS/XK6KmSElewu/TCoEWsl8PasgmkFStvWXG24wVeIL1LrLZMxWu+R+3v703aSNLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 07:16:03 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 07:16:03 +0000
Message-ID: <447d130a-e1ac-02f6-e168-b04bfa9c6004@intel.com>
Date:   Mon, 11 Dec 2023 08:15:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ice: Fix some null pointer dereference issues in
 ice_ptp.c
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <jacob.e.keller@intel.com>,
        <karol.kolacinski@intel.com>
CC:     <michal.michalik@intel.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211062649.247148-1-chentao@kylinos.cn>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231211062649.247148-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY5PR11MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a468e1-a888-45a5-d729-08dbfa1908b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjOGi7BgzCkoM1O9kmuQiJO/ulMhPOfKyBpl5/oyYIMNv1MqCuuPl4VlnkiG8/ZuGw0Q03ImJ1+JWvTMB2YVLOVeaNU/feHuZy6DzNHTHFpjhdp8RhSrxFUIT2TQFaG1VVW0e9X3gCVf8ICRgUQVPYcL2GSZSWT73g4WRSx/1vhAo94QVcmZtLKmkmkySi/0T8Q8FM6k04HFRctn3R4//06Nwnp5I9WR66zh2MaRQSy+TdZoPsI1J+PJt3/9YgPrTdICzGcSkezTLHMNiR5ndErGw6w4dPd8ByFCixO+8s59Ze6oK7RjzaTI5ikNVavOx0AMRMZBcLR75xw/+d6TJyexsh30X9cLvbU2JK9noUwC8L+ug1/FxPP7B2jO7FQdb/sYo+luOT5aes4tdgdToNmWl4aoKd9nAh2JzJaabUhx3KlBxd9HxdG0ihzsKznf+sLDArgPtEOHSLemALNPDmclUkHVnSQi+n/QRIU5em0LLMn82e1PqOS455p2zTFKcNN5Xx//WOrCd69P0Bs1GZEOXve3/bnEPhnYiiLZM8JFFp+NsgAKBaJqs50wOZVvgCx0eMu1UibwdoRNWHD5Hu+VUUaZ19LGtPAUyku8CPZEL1Gnx962z9+bTXXRm6yTjSjSp7FVAafP2MBL2CuaT/PDevwLacr0RJrr2npN/z91D35abygWV3tBxWiXjNYhBv8jqEOf1DadO8YTWpIy7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230173577357003)(230922051799003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(31686004)(45080400002)(26005)(478600001)(2616005)(6512007)(53546011)(6666004)(6506007)(921008)(82960400001)(38100700002)(31696002)(86362001)(36756003)(41300700001)(5660300002)(66556008)(66946007)(66476007)(2906002)(7416002)(6486002)(83380400001)(4326008)(8936002)(966005)(8676002)(316002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJuWnRWdnRhNmRUSXVmenVyaUhmeS9DalNFWnFHeVB1V05sYWtKSHhTTjBO?=
 =?utf-8?B?YUxpbkhMR1QrQnNiVG1LenF6djBlejg1QVVvVklYKzRMKzNyUllEaHFudy9G?=
 =?utf-8?B?ZlhjMkIrbTJmT2JQdmVBTmR0ZVVYV0IxRFg5cHEvbCtSa2FmSjJZTzU0dmhi?=
 =?utf-8?B?NUh1OWo3bHFUVlQxUS9ld1U4bXdBazVJVVhhYTdtcDc2eGE5bVJWVGphQUVT?=
 =?utf-8?B?d2h0YzQ3Ni9Ga29lekx4dDNHV1E0STVJQ2tJVm5sY0lsSmxCSWFLZTJ5ZEtx?=
 =?utf-8?B?YVp2QmhMeWZOd3BOVXZES2dlSHVYajJSd0JLTzhKVDEyODhrWVhvUjE3b01N?=
 =?utf-8?B?R2VyaHRlWSs0WUkwSHhVUi94RWF3MGs4SFE2bTlGbW5MT3B5Z3lXV2dDcTdk?=
 =?utf-8?B?VHlvbXpjS1BwODBLOXRydEhZaG5yL291SEpTYlpKdDlvanBKTTF6ZTNuRUV6?=
 =?utf-8?B?YWVYNnBDWEtyTW5TTHhZTW0wUksxM0d2RlpmTzFwQVFxb3V4ZDFpTHBzYlRN?=
 =?utf-8?B?MkJSbUZIYUFCZW13YzhmWkVnK3Zpb2NpdHQxRHFLODVjb3lkUnIvUFVuU3hF?=
 =?utf-8?B?Q3AxdE1zSXNxV21xN1dKVDdtZFo0YUt0QS9BT2JFbDM3VmpHRmovcUFKYVIv?=
 =?utf-8?B?TXJ3Vnk0WkltR2Iyd3dYMVhLTW9xWEdCc3M0MkVQcWJDODFZdDExTFZkSkI2?=
 =?utf-8?B?eHRpelU2M2IwZGFVNUFPS0FlazhZOWVMMlJRK2tNS3V3bE9qbGNaVHRrZUFq?=
 =?utf-8?B?bEh2anFtWWtpTy9KY2hNdFdrSVNSd05HZWFOMmZNbUlpTEhpOWtVcmZnNXNJ?=
 =?utf-8?B?OWg4SUdzR2hBQTZIMDk2SVgxajkyNktPRnNGTlRJK2h6ZDA2M2lIQ0xaNlBT?=
 =?utf-8?B?ajU0ZW1yZEJMOHNnSjJKcnZFWEtjKzVxVWQwNmdCc3RBV1dvYU4rZVR0UkFK?=
 =?utf-8?B?OFdOQkZ1SEQybC82U0V2SW9IRDluR201aGw2V3VsM0FrR1kxb0g4eXlXWnZP?=
 =?utf-8?B?TlJUeHczWHlxOHRpSWdPa21Uckh0NGgvTi9JanVra0hrNUV4NzNUTzFKeEJC?=
 =?utf-8?B?QXpWZW5sYmJWTTE4OEROZUZscUFzUXIwZmVVc2s1WW5rMFZIOVAzbEtId3hM?=
 =?utf-8?B?RHZ1eFRXV1lyclcvSlFJM0ZPN0gvRnhQODgxOEJ0ZFR3L205M2JBbDZ5cWpa?=
 =?utf-8?B?NVBMQ2JPQ01Ya21zTGxqaHNmV1RZenhRZVVteDFRWDZzTkZ0MkFCNWNCVEtj?=
 =?utf-8?B?SVF1Lzdpb3Fucy9sWmNIcHpBTlhzSGFIelBBU2VLTlZtd1E0RVE5VXp3Y3py?=
 =?utf-8?B?TDlJWVovR1F5bTRWS01qQkNkVjdmZ2k4Y2tiOVBlSW1UMytMeXMvRXc2cFBF?=
 =?utf-8?B?aElDbkk2ekNHbFlBTzBCRkJkS2NZZXkxYUFyenVTZjdjVW51VXdYeTF2MTdn?=
 =?utf-8?B?ek1qTmFmYjBwOU0yU2VNZi9TcVZ1aWUybzVmYm01ODdPaDRyaVpGc2oyV3cw?=
 =?utf-8?B?VmswWmNkWWIvYUhzQmpyanVTTWRlODZ6bWtPWFJkdkhUSTZVZ0lQNXVQU0ln?=
 =?utf-8?B?cXV6SDhpaW5UOGY4QVNNTXRHbXFMbEFpUjJ2ZTNQK21QaUk1T3hBV3N4anY0?=
 =?utf-8?B?RktNcGJoZlB3TGJMRUlLeTcvdVZDTG1MdHJ4b241QnJBdGVseTlZeU1obko1?=
 =?utf-8?B?YW5OdWE0YXMzd2ZzZ0p5NExCV09XUHRrU2VKbHNSb3VsZlZ0MC94cUhvR1hx?=
 =?utf-8?B?VHZuaTJscmpoWW4xQmkyUUhhbzNWdjcrSnpHLzFPSmV1MTdFZ3VnUDJqdmU3?=
 =?utf-8?B?U1BGWmNOc1FpcHhMNUk0WDU4Q1NNRForUUFxTWRKRjJvZkZ3T1czZFB0VE5T?=
 =?utf-8?B?NDFXS3h3d0JTK2xMOVJIZGFEU2dpMDgvRkJKK25DaTNLaVVzUnd6dDRMY3g0?=
 =?utf-8?B?dFNuNUxralYraUpmb3FsMzV2bDBVWG85cHI4dWhOdW9qektIS21NYS9oK0pI?=
 =?utf-8?B?SVB5WW5RUVdOeDRRSHprUnFQMkMxTHd2bXFFZU4zTE9LakJ5M2ZwTHF4S1RV?=
 =?utf-8?B?V3RlZ0k1SkVXQXlCVm1xd0swOWRKbUlqNmpXKzd4NFJMSm9Bd3ZIZEx2dE0v?=
 =?utf-8?B?cjdFNGpWQjc5SWRwdFE3ek5QbVdFbUZ5blBpMzFpUDEzWS9lUXdKQnFsSEtl?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a468e1-a888-45a5-d729-08dbfa1908b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 07:16:03.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUKcL4vcUEIKvnQJU3/JYNWOPeGaCrJhHnr8MIzGvhC5oERxJaVdcxjMl/xovb/W6A02kz5bSy7B079Upe1/QSSBx06mjIPIsmwHlV0ztrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 07:26, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

I would suggest adding "iwl-net" as a target here

> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1eddcbe89b0c..59794ce4f243 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2668,6 +2668,8 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
>   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>   			      ice_get_ptp_src_clock_index(&pf->hw));
> +	if (!name)
> +		return -ENOMEM;
>   
>   	aux_driver->name = name;
>   	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
> @@ -2929,6 +2931,10 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
>   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>   			      ice_get_ptp_src_clock_index(&pf->hw));
> +	if (!name) {
> +		dev_err(dev, "Failed to allocate memory\n");

Kuba @ [1]:
no warnings on allocation failures, there will be a splat for GFP_KERNEL
(checkpatch should catch this)

[1] https://lore.kernel.org/netdev/20231206195304.6226771d@kernel.org/T/

so just "return -ENOMEM" would be sufficient

> +		return -ENOMEM;
> +	}
>   
>   	aux_dev->name = name;
>   	aux_dev->id = id;

I didn't checked but having same code in two places raises questions.
Are you overwriting old name here, or our code is just self similar?
