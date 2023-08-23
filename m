Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB4785457
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjHWJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjHWJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:34:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114D1FCF;
        Wed, 23 Aug 2023 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692782636; x=1724318636;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/5XyP2WcjHmCwNu0nbRO0pMt1L9y8UD3r/lj+NvQoyY=;
  b=FyT/ojqJw+fufZ7xoKv5ZYVfEd1qKHUczQdv6u/B7vbSTejUiKJZw/qK
   GpS0guggRo3mL2Az5waBa8EGvV2ONgM13LdHZlU9ul68DVXqjzQm20FiF
   8TkLfPP3oUGlrgC1Ww81SLEgPv9p0TXZQBbRvZoUvTqOAFjHoV5np35J2
   BSXchmqGAWBArNJT5ikwsWhRuw54tWWpoVMd7ZnFi4COF9PgVQYcki/OG
   d26qeZHb+smlcaMNaesS59cN+oaCZViLYy/Ztg/TJz7qOF5rF+Flc97Wg
   PfI7pSRgdKvUcKxTDRDHMvR28Py3A3JJHTV6YqlSuD/B5WJm3vROIsHQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="353665253"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="353665253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 02:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860258912"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860258912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2023 02:23:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 02:23:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 02:23:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 02:23:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOeypRa9PiJ9gb8pXychIdpfK826yqoiZt1FaRabEUdWLFACgka7nvdYTiE6+BKTDYsTerPl3v945HrRDSaet353x6wO/RGd0XI9gy5wOKY8Iz72E/xO9X5K+BUeIggGl6i2TUg98TJnbpxkbK0RElj4zhLkgxgzIHxD50dHrP+Ke/LvXP2Dez9AoveLdeBE4j9Uq3rSEQsOwDFO057gCMoRz9VvXazXhd8AELDn5qk0iv8VYIIzA+5UiihgdTRQ3m8gFg4lAxG9dzZav5NXNZ8Az/DXoNmo2Ndc1vHVufmdufWtQx9SjR/3igakIdWXyhvhEXuOnowuLA+yrSY+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FrHmqaajWUmE1UgE+P/sIjpWr7vzddEU2sTxWPbH50=;
 b=DS3EVvlQs6x3/TrjImBhYxSBJyPPD1/hvA6v+HTmsLD2XkQNkzFjp5Y++qAZSdf34lhfvncEdxqZlbecDdkVUtp0T7eB5lASS7VPU7YS7F07SBoSDQG1+zIAJ2stvWq/oSIJfSXoVbmq9Csim8DlCVC03daMgAyH0xusLWr2t1q4prp7nMpi7s3j1fNUL9QJNXyajlKeX0j5piRtxFIjS90Qoq5Bci5Bn8FISMwpwLxiE7F0jbVEz/9cPDe1T4FFIYjyKbzVg9WapUJ6po0/hnz7zdr2ZTE1tDxSz/zUWRKvN7TCWL7UxrSd5azDGfr9coGcJZPkUG9rqomWbiwYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 09:23:53 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::38b4:292a:6bad:7775%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 09:23:53 +0000
Date:   Wed, 23 Aug 2023 17:18:39 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Chenzhou Feng <chenzhoux.feng@intel.com>,
        <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix the exclusive get block device in
 test_resume mode
Message-ID: <ZOXO7/8XlvgoHx34@xpf.sh.intel.com>
References: <20230823161329.7348-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230823161329.7348-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a7a636-131e-43fb-b7d4-08dba3baaaf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytimFQEDj2XbohjUUgO2n/P2wzlRljIYxn9s+BgjEBDbyscDz4PMNDapTGkvQVbRQqDQpSrnJy86R9VACxjbEo66G2kQadp1qFdMdf3yNOOOMB34T4WozOnaT/FrvP8UYtgx3gZdFT05mmfrwSYygJLT0SGQK/9uAjxrH+r2AmmBPGE6HxHwHky6NUrVm6XTJ2KHCSF1rgT4BCT5txCemQ5YNkfxiJb9zAMdXhG8ZGiYeLPmb+cW065CLWQNmUgGOQIToYUlH41wuh90+j2f3tKA/sE12y/Nr/m9Cz09p4AYdS3HUwaUPLgsyo9G79M8cPBDYn9X1K8VmuN6ddeckQkPJPOZCCLMLDYG4l5KdS1xGqTBmws5i6zfFSFLx9EIvZuUOyjzv/kEnnle6BPnAnOnmP/8g4E7sY/qeacFSH/K1rkOXqjeGEAs1jyRs2MOYVtgw51+PA0OIru/UG444oZNW8mT1vq8ILwfimfMiegk1CWWrdwVLK99E2ZU4WaFqIVzbj11x4qHiRNUpxIt0RZ+ooDG2ass2yzooNRiSRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199024)(186009)(1800799009)(966005)(86362001)(478600001)(6862004)(8936002)(8676002)(82960400001)(38100700002)(4326008)(2906002)(26005)(83380400001)(6512007)(44832011)(5660300002)(6506007)(66476007)(6666004)(6636002)(66946007)(53546011)(316002)(6486002)(66556008)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HBjGmuD6INd1jdqFQ4i0Q6WCf73pYUqqJ7nbZk849klpLDftvzBz9CYPFci?=
 =?us-ascii?Q?TQbLEjw6+YjwAx4UTm+CT9my5FQ1H60NFdpe8KRX0/yD4qfvQ04J0KS/Ve5R?=
 =?us-ascii?Q?Ehsn3io4+b6GipWOoJf+SxA9EcNKyffngSKsHDh3ZKjARMGHdbi2BTRVc1xP?=
 =?us-ascii?Q?ID/I+V1fNwezq3TdeNoYZYhB6FIxI394Pqw6NQiaYg7uYYLq3g+nkbA6crv4?=
 =?us-ascii?Q?EOPn8H+KMU7wnm/fz/1kGJ0ORC9Y5VVXlRrPh5KBluw3eD34ZmGv9C+LsBMO?=
 =?us-ascii?Q?EeOoOe5/r4LT18HiJwRv7R4Ryq6a7eIjRs1ySYaisjHEWZlk4iWeUrAtj0tR?=
 =?us-ascii?Q?ka/jC0qMRdYBNSVr095EaSaxwLeFdZZ2fwKEf8wHVnq0k0WcxXpIVQyug4n7?=
 =?us-ascii?Q?ONtqtKGK+34J/+xkSbPy5JWxADhuXxgjSlSmuC87lJi9H+QTK1APvLCnlHw+?=
 =?us-ascii?Q?p+K+HYk5Ka3RJ+ceVswkLkkOFu5Yt0AdGT6KHrRuqrFvCCc30tpzhm91pchP?=
 =?us-ascii?Q?MLbrAMJ3RV4i811D7w5JfDxMXQ8aafnH4IXIDsmDWKEOfCfYjfLxpO5OOkhl?=
 =?us-ascii?Q?tW12eoA4IZ6+MaxryZGyqapjQemE+xDrVhppNF74tViqlsxCvo8rPGchK8JN?=
 =?us-ascii?Q?i3hLrPH8jbD4NjcFtSiw3IB6uwp33Ef07Flb1Wv33j9mnf0vEqWt8cwSL3jx?=
 =?us-ascii?Q?hfFKTs6/mF/pksJyAt0knzB8P61ktH+/mOVFmgzFyQQ60ok3t2eC8zraW/5r?=
 =?us-ascii?Q?avQDtu/vzV8z1dpA7Vo5FE6liXQLCni7I8N7KSFu0GRpNLBgzL8xAbh+1fj3?=
 =?us-ascii?Q?ZZogHvAWp9V2MaXX05TKY57X+kdNQ2JJ4r3X2SlF1XfEv1X9GVm6NWD/irXB?=
 =?us-ascii?Q?DyxDfvIqsSiaBarSDjE24eNjscS7HkgQSNbeMF69IOzqZET9dty4f7ag+MDN?=
 =?us-ascii?Q?gEhYPik4Vgw0jAsHh8QAyUDHzJ+VoXeh71eRDKK5PTRMchFA1vLHZe3OLf2q?=
 =?us-ascii?Q?V4A6vXAwiuzRX66ZRQrLURY4I3L9lEl0KFB23AuSt0s0WOZohNJ/mlfAnude?=
 =?us-ascii?Q?vantUm+IZe9XVoBmhOFmNbVItCsI/HKTSdLiMH4rNSenntvhUrnuVjjc0J+6?=
 =?us-ascii?Q?O82BLHWMpn+t6WkuooDCEgaCdoQcyyILrHJxR2opLRj4B3u5qk84kfMibsHF?=
 =?us-ascii?Q?KBVSSCUg9sC+qhQKbfuobhwusrPFOtKeLclaYmvImemHPa820SWvGw+azcJ5?=
 =?us-ascii?Q?pEIQdeSjLOQvZhWpUz/h2zxv3j0Fjpx3LnAMNV0ians8ljajPwH4uKMfl5rH?=
 =?us-ascii?Q?OGhWEUNhQ5qtfEmwGmh+Lu3XQTMcxz7YgkjcB6n2GzXaAQkzIzfCJ+gvWdc0?=
 =?us-ascii?Q?cVOm7zJuFmov6ZVJc1uea/tlqGiMRBmKqEyyGaGZRgkwysoMZXJCjr7gBhlU?=
 =?us-ascii?Q?m6htaKxxNdbX8nP8r6+bgCcLoEHkkx5qL8RAl3ZpOw+d6vnJqAa/+qpB61Pa?=
 =?us-ascii?Q?FsCB6AFLGx3GAAAJxtRdkPPN3toIS314B1+7aUBLyCh/nCtNapAKyj0pMgmq?=
 =?us-ascii?Q?zjfc3Fja6Q6wmLKW6ApSpv2BgX+5FD4ZP1jH0f2t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a7a636-131e-43fb-b7d4-08dba3baaaf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 09:23:53.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u425lGuTJS5vi1pVvdeE+GYOQ051f/tgD/aTgPv8Gnlyui+Lob78e9g/qwVxldY7t2tR0rCBIwvmBcUU/xPvMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-24 at 00:13:29 +0800, Chen Yu wrote:
> commit 5904de0d735b ("PM: hibernate: Do not get block device exclusively
> in test_resume mode") fixes a hibernation issue under test_resume mode.
> That commit is supposed to open the block device in non-exclusive mode
> when in test_resume. However the code did the opposite, which is against
> its description.
> 
> Fix this by really disabling exclusive mode under test_resume.
> 
> Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000761f5f0603324129@google.com/
> Fixes: 5904de0d735b ("PM: hibernate: Do not get block device exclusively in test_resume mode")
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f6ebcd00c410..c12b34dd529c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1518,7 +1518,7 @@ static void *swsusp_holder;
>  
>  int swsusp_check(bool snapshot_test)
>  {
> -	void *holder = snapshot_test ? &swsusp_holder : NULL;
> +	void *holder = snapshot_test ? NULL : &swsusp_holder;
>  	int error;
>  
>  	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
> @@ -1573,7 +1573,7 @@ void swsusp_close(bool snapshot_test)
>  		return;
>  	}
>  
> -	blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
> +	blkdev_put(hib_resume_bdev, snapshot_test ? NULL : &swsusp_holder);
>  }

Reported-by: Pengfei Xu <pengfei.xu@intel.com>

This issue was reported in an Intel internal ticket by private syzkaller on
25/May/2023.
Thanks for consideration if possible.

Best Regards,
Thanks!

>  
>  /**
> -- 
> 2.25.1
> 
