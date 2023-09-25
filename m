Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6C7ACF0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjIYEUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjIYEUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:20:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD392
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695615596; x=1727151596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qCzqCdn9R3V6VOfEBHjAnMo+n7Kab76VIiVovLTchKs=;
  b=FxZ8T7giHe/NLCHjHUsy7ZGxLhoOKjtE/mBB5thSYsvBJ30Bq75LVbOi
   oiLGRrSDHtX6edkcTsiYFtYZngWh7AVYZSvzhPwttbU/WahF+QJ+h17sG
   DmUl48udlXnzQrohIYWOAEO93HiLwrHFPrhgYulvm0RVfO0oh74nWYpgn
   MY4+8SYwaJbv8DmiFJMDqIDvxdFZrzY/ODklQSzEwmOZnTBcEu2xBap3S
   Dsve4LN2HmW6IjENZa92MJaZPRO328mXZYk9Td88glkJ+/SDMuPc8onlW
   gJ+zVuj+KKBDHRHCOzZV7xprxJZjxRWQG03LNfq33CjYKGCDt2NTyfe7Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378432205"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="378432205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 21:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="751528923"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="751528923"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 21:19:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 21:19:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 21:19:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 21:19:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 21:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO/TCK4LOLitMCbNqmdFjVFDWwIoaiKFSNf5QG88Hh5dNbPuUZm7RDnIe+Hx9wj+4+uskOZSGdElp2nC2ryvjZYXNEXFyypvzJ5HuDnnY1E/LYteMIukbVwcBwMZUCF7+re/hD02gSFJTM4nlSkxPXlCYAsgzabO/6mKIRLqomI4PlJA/5faWdCq/j0szvKsDVG63bhNMdJ3xnPc4DTNDvBrVm1T1gtw7BwUGQ44rUH6cqVN+90wuSOgKzafFUf7voqhp4jo7hoBgtdYilf0V2tt4PVYd+xHKMPGI/vXGLwVV4w8hgDZZue9nIIl7s9HC34rihRnsye9PyXOhBxehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8jFalvKs5hYyZ8hrXvclYhwvjPq1FIUcUXuAevQzy0=;
 b=VJYD1AoyR5qaQzERpS8GyicMRulX5mAHzrX6PcLnF8fjOx8lX9vwxsEvrMzd6WDoUkvJCp5SqrLpcxvUifIPE+5tjGiC1ehr5ieARwPdkMpybr32ABwja2K25cjgGuXdEvbwgdYALeG1AAhiZvI8zANZwMHb4o04EwOPl6Q8ka2YbYrzYrAH+Tg1zO4taGNqd6jcYGv6VeqU945q2o4xE+IV2Z/wivTVH3agxj91h1CvgW0LuruQIY5Ebd7Asupw7LBRYELt2lXbrOQNnUpNBIAeQil+6pZDsL/ugHvkqwmU1F1Ida9BjnT6Vq9iCTJ0po1elPgvmM9Mlp0XOGaD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:19:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::99cc:830:3ea5:d42b]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::99cc:830:3ea5:d42b%3]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 04:19:53 +0000
Date:   Mon, 25 Sep 2023 04:18:46 +0000
From:   Matthew Brost <matthew.brost@intel.com>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
CC:     <mgreer@animalcreek.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <airlied@gmail.com>,
        <intel-gfx@lists.freedesktop.org>
Subject: Re: ERR_PTR(0) in a couple of places
Message-ID: <ZREKJpfMx7ZEcw3n@DUT025-TGLU.fm.intel.com>
References: <ZQ+Fo9WKyGphwI8R@gallifrey>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQ+Fo9WKyGphwI8R@gallifrey>
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: a5414240-b2f0-43ae-f6a6-08dbbd7eaa85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yi4oqrYugtp2HzcHuDBLvry78KSfEhFpB3gc9EnnMZv9dAyrHagEjD1WkSF9YtrqgTakNy8IGguoIgj2Uaj2Zyl2K0YX3b+U9XjnVBXqMC3ARrkJt55MNcvyJfv+XaXYirxKPmjeii19GV+GTX3Q2UCFVPTVTHuJYrjC7HjTFgju390GCstPFpIICxfm/IX03lMLQK9Iw4ef/0kkVhhJ1CGz2JY/n9NnKzUThMEGIClPfSxEGYzhaazntT24A0lK2kiFAmpI0OLKC7Oc4ww1IAgEA85WGvv1SQS2M4nDeJWyF9ViWww6Ayd3FByeOIVb1ZPn2Wy3gR5N6nbjgLYG/Kwu5ncR6YZQSruS4mdAGsPEy6xCD0cJk+5JietLzA6WeU+JoEpyzbV529alt45u4tYAcYxG6iy7UIesX9YLssF7K24/F/mE28d2Vn04c7pmDxyZ//u8kF26T11alGDt6o+/8W5zg+YwBaVdQosu3RZn7mPMQhzBAQKHxQ7ErBb42otBSZOXxNGT9HOayOFPQ8ZZ31iQwmy1W7fbIh8m7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(86362001)(6506007)(6486002)(6666004)(26005)(5660300002)(966005)(6512007)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(44832011)(4326008)(8676002)(8936002)(478600001)(2906002)(82960400001)(38100700002)(83380400001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGYXFpTUTign0w0+ye8jF5T01mL4ANfoNleAh/o5jvOiqrWrT+r2eOW60BLU?=
 =?us-ascii?Q?tCE1Ekddy1za0Lvs224fYDxJ+LaQ1kQinsy6pkj/61stRacPtvLIcEV0uLfp?=
 =?us-ascii?Q?LTWjd3IC1gIDJwiVX+9QygON0axMe8dZvTLjQhDATwis3XpO53lYeL0ovMRy?=
 =?us-ascii?Q?WkJQUNoy8q6W/OJDAKd3E6M7zoomZJNIfNEq/ZYi8ejPQefnuzkWCG6+sZlu?=
 =?us-ascii?Q?SaQRPG5QshIodAriK2tBYpm/8UIXN8WXpgvRxGQNvsWTmfmYMlFudrvKvRBY?=
 =?us-ascii?Q?RaZttdSBoCYe4MP0mc8oiUFRC5GcxpjQQuIcGw3x3SBj1fSZFgC55l8xJq6g?=
 =?us-ascii?Q?fO3B92ocDPKVpW3b2tmIX5xsmX9We6ajiUaG0nRzzQMGlFh0KTk7GihS5B/y?=
 =?us-ascii?Q?3eXaleoCJPJQniG/lPa1jyFMeQy1rujjMxNmfPbbALZ07XGSUfOXvSSOvgAy?=
 =?us-ascii?Q?GbYvpyISSq60rsWWBlJNSnT+pKvS1ZFpOQ8vJR6WNqyZwZmLFSmQfu7dQ12I?=
 =?us-ascii?Q?FdMlkEYTT5e9rqPIffi86fs5MQNyvlOP0CxwATDuTw8d3D0/vko3oiQgh0xy?=
 =?us-ascii?Q?iXUIC5hIqjtLgq5HWVyCjR7v1DUB0+TxLCEBdpsfhVnK/SFD1O15GzqbCVcz?=
 =?us-ascii?Q?VvrsEWwQRS6gBbk8hbqRxbkqgLhBST20+ZI/sSgHzWghhDudvtGCqX2jSvEi?=
 =?us-ascii?Q?KqVP24sold3Mhpr5xAe5Osw3its8zEG9xCWMOfq2j7h0silbIYENnpv5+IsR?=
 =?us-ascii?Q?OnjoJezN4uK1qgdvWKLi5GxYJHrpnY34VCfvWOj+RQ58Vj9FgYsVas+cmgUA?=
 =?us-ascii?Q?IsW+at47F6ysEHpRcsD8JlOBpwkCtPLugoSoT12xG1q8S76ypVba0gXAN1MT?=
 =?us-ascii?Q?ICF1M1+8z1kcZmQpz7cOd8px7VQFUgGOWc1LcqOUH9U1zVOiaBRg1vYlUuq3?=
 =?us-ascii?Q?pMf5jcZ2RJbbiF4ODJHePuhZhbmeOpA3CwXvexOrk6D9tlwZF+PTeQYSpjba?=
 =?us-ascii?Q?sIsbJDZo05IiJZdy0SxJcJ9o0jPr9dLbKaTgW7zhArVBwJ1wHx+KOqeBtv5H?=
 =?us-ascii?Q?NpVgVZ2ddJRYD5vDRKxy46hNR92haFmbHISGzeXOvhb1k27pJR00ZkJ2R7w0?=
 =?us-ascii?Q?t64Sg6WllnRZ7pYJO1Vj/sZRzBTu0ZNOJsLRJnivqSNoJG5rMOmk78pDrAfh?=
 =?us-ascii?Q?MAuVzud0m7nkP79MMfSi4dzw42aetTFSoUNBSfTIxARMJWsMCDrN+3PJc+Ai?=
 =?us-ascii?Q?Imt9JUkfhozEsZ1Txmtwq7Uqjdg9VnuzhMPZqdnlBtp5V32Q+N3t7jG5hk/P?=
 =?us-ascii?Q?0rgtsP/hZGCehmhxt2HL+Iw1k/BHNrXswB9oAV41J0YqGZ8ormTkouMtSkKd?=
 =?us-ascii?Q?pb0rwvBMhTHUSXHdOaB2F8kI6sCIrcDo38rr7+yBz6EJNmmbKTqeA0tWbNLz?=
 =?us-ascii?Q?Ab85jElp+c2pDU1GMZZXp1yWY37uerzcSP7EzZ2BVTQ1EsES1DcM29wNVJlR?=
 =?us-ascii?Q?0LLb1aK7jbDsxJ5sXy1t62G63KGM72QAV1wiVtvhIagK7hbfKjflJ+sWMnUr?=
 =?us-ascii?Q?7n2JOfzzIv36hJqO8X7ncz2dC3zTAW20UfuRAbP9XOBnbuoT4PE3H+MRSxOY?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5414240-b2f0-43ae-f6a6-08dbbd7eaa85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:19:53.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E/9dgRke6MLkcvei4rwjYT0oDCS04hMcQ2r1aGqtVB1lsKIeq0JNWi21cJDzhPPddq0KsVHmsTg/CoKYQT7eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 12:41:07AM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I randomly noticed there are a couple of places in the kernel that
> do
>    ERR_PTR(0);
> 
> and thought that was odd - shouldn't those just be NULL's ?
> 
> 1) i915
>   drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c : 47
> 
>     if (i <= 1)
>       return ERR_PTR(0);

Yes, s/ERR_PTR(0)/ERR_PTR(NULL)/

Matt

> 
>   from f9d72092cb490 
> 
> 2) trf7970a
>   drivers/nfc/trf7970a.c : 896
> 
>       trf->ignore_timeout =
>          !cancel_delayed_work(&trf->timeout_work);
>       trf->rx_skb = ERR_PTR(0);
>       trf7970a_send_upstream(trf);
> 
>    from 1961843ceeca0
> 
> Dave
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
