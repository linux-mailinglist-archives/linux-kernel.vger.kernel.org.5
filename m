Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2077D553
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjHOVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjHOVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:40:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF51BE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692135652; x=1723671652;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O0ywbRjMAYTx9diD4MT2qvw6z3kLd1P28yv+Ht1InME=;
  b=MjaZSZDYpwTSG7WY+kVlJ5KkEtOevBkQYAdKflwovpT26vF418iZXkzs
   bvCFBW7+II8c1/6i9/pWgTPKzrMqb15Z5rV8u2bmT2Tb8VH7vI2BOFKph
   o95+WsKY0U+ezrPBQ2QAUIHf72KI7ZOIo2N9d5GO7/7up2q8AJtJjM6Hy
   OQafwzm5SPatv96+1OJ1VppdZW/tQKzxGdEoqFlkj2rAF4ZLXLpWvKz4w
   oC9zusApltthDI5QWLsbKsqiLr42MB1CeWKRqhX4HQEmAktJ323B9SRhl
   CeHuuei6Ff1D+KAhEJnao+lyNPo7OAfT1ys8UhRCDAVnz6Lb42sMUwCLk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376116606"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="376116606"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="823987992"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="823987992"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2023 14:40:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:40:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:40:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 14:40:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 14:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj+tx2phAqoj875Jj902mXSIp1by6WiLYR9Z8L0wtAQZMdi/rLGofYT7ABxtBt3RegQOEvm9xD1WZlXZfJ92ia5/1y6vynNxJCqIl7rIpITUGN77kadZjwsC7wmbV+gSegGZG3LOm7tQFQJ0S/8ZsR+EYtOhNTQpRI3ln92MsgVCOt4RzpkpZI+EmvTpDE1IIqJgG7s0xZradQUJZCiHVgbzMYTeHdPFfoIFJJfv+XcKLJUw2vpO4hvwqZdoZ4B8BBM9lHPiF8UnbV9YD/QK7ewdUb+MYGZUZirEjWFT8Elilhr+1kgMzSjoV5aa80QQeevgjNeewsuJgn1qgR6aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC3jCEFWZ9ow2bzNIfbQ4T4BAgovGD3hovx36Xi+fNg=;
 b=RwAlwFbRcLi8UaWfJhaOVtRzcMis6u/MHgJuzxOwSZLAcicaYIOiaJZgNl2A1FDhzUmiZS5dohDPgYX8h8tYsBHF8C3/SB25EPaiu7d2i3Pntl0JWHMHxqFGDaVXiAYEVzYpwNm/arB60TI7SqV0/iI+TGQbouzb+wK/Qh6LXoBXCN52ozG+WzjsHoqJGTC4X+KjE/s6zxsFb2sIOVO7KhQoidHkGDed9Ho45cWE7R52Y2opiOzO02g6Tw7kq39nDgcQw6l485AR7EKhEMal8RQ6j+VFQfVHboBhScI8TIZecnJWUTbsgB0oEpTrnfgcRAEGjntsV5TIcw65VcTn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:40:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 21:40:41 +0000
Date:   Tue, 15 Aug 2023 14:40:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Borislav Petkov <bp@alien8.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <64dbf0d629d90_47b572942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
 <064cdef7-d90b-9fa6-fc04-30637c992f60@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <064cdef7-d90b-9fa6-fc04-30637c992f60@amd.com>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: da2fae98-c0d5-4978-4edd-08db9dd84623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDkP/QNkbTwfmAcGKF5B14e8zBxvRL1eE/XKPETLbKIUd9YNz2ZfwkWTxILOGfrMrXw+t1H4UWeMZTq6yA4ZgHL4/HQx+12jXmcKleVVmB+WG4t4J23IIoMub06bU094iMLOOVTmfiQPyCvrnqJtOyF1CrXVqBNn6f+947TX1ZYIUBPd2zdgi9NrR5lCg3+XfTiD8kErRTlGwirMtC53Nw1Ddi4eWQbuhDfJ8lv9Dja9LPb1KIEibTfCDtOc6UB2ZnkrhcNBf9aw6CsI0SE3yx06rQz+qiEYMYhC3wt7Msp780vejp2ZAVo3VeFl30R4FMMUfovc619ROYVZaxbFll5nNd9iM9uQhXOgjyPRT5xYiHZB+bWol/krB7c8fERXLeZMiQMKkkBJnZdkx7WgVs+9q9ev7YDHCYuR7BzlNa2zQD2bIf4UVLiiaAzjOgz1/rDxS9vjsGYr8wmJ2zNfBC2d6lYu0GM/Du6EqNs+eRkTIrGA7+Glm1E39ppL9bFytBgh3Jv8ktQ6Btc9ine3Q6mVUAVq7fDjDsuFqAbmJCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(1800799009)(186009)(451199024)(2906002)(8936002)(8676002)(4326008)(6512007)(6486002)(966005)(478600001)(86362001)(83380400001)(110136005)(54906003)(6506007)(66476007)(66556008)(5660300002)(41300700001)(316002)(66946007)(82960400001)(38100700002)(6666004)(26005)(9686003)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NTu+3qi1acHs2IQYA3lJHuO6bgBLO1VG36MCJjHpcVWlZIC1ZkA1ZZmnG9E?=
 =?us-ascii?Q?+kid5Bay1m9HcXybauP7MbhrqydoCetKO4IylYFBcKK2BBzG32qZruUpXGcp?=
 =?us-ascii?Q?qtqKBae+EoCCjF+3fA80IhWCQdOVSmLApVxaXX3Gb3NtJFUSV7zqy58a0uMi?=
 =?us-ascii?Q?m2KMbhqRAqBVPb5rYH8g0yUg2EHbcZwV3l8bp24Gc9SbekQGt75Ep2y88xL5?=
 =?us-ascii?Q?f/cP30uSG2QxMb56SZrDDwg9DWqiBOsdO6Zrt9FadxFpG/lm04ER/rRrUWGP?=
 =?us-ascii?Q?yzIeVPXk6MZ2D94kygogPTWYR30T3Au6Jn6ySEXmI5amPUlHidZA5ddyAHkZ?=
 =?us-ascii?Q?5ZJLcRuQ7ESx13WqGhic/sJKzsQXDBsS0xHDQ5bWNn3e+WqOq/+WcNVTD7Ec?=
 =?us-ascii?Q?4GePVGirbOzXTV2wzzV7Fp1CNcVlset1Y/s4ArbFqa7SjS51P1EjGVxs27fI?=
 =?us-ascii?Q?V8JUtBsNDAUan6Tg8dxpuCzHqUliZxShr/9w5sWSkjeugXhcDg0G/JjiQjhV?=
 =?us-ascii?Q?sQESC3SlXzbmNOFOV4LQW5CNbWyWarJY0q22ztKALUsngjbP78VcQan98t7l?=
 =?us-ascii?Q?gNkhUAlgWIqL+DqOb1h809oqlKBhwqEtXUyC4X8Jd4/34JnVhn+Pz1w66z9v?=
 =?us-ascii?Q?wcQG4PkM8O4zA4Uzw9efCT962cMQcIFyYVCQwdTVyaz5nck05CfcyZ4TTdiI?=
 =?us-ascii?Q?Xx0F1y2XGv+pZDKaV4XLEbiGA+qStdPrsMdP80suH6wVVkrVKb9lHh1P+hnu?=
 =?us-ascii?Q?IWJMZ12gR9A0EXGdCTrSZqxtKxMiuISpdnAThy5Rs7LArnxbVrYk2W2cHvfc?=
 =?us-ascii?Q?ge4Q3NLCbhkFIGco/Sm7EJaYFPtpX8yZCgAbQbavHoQ1M8bugbaxC0+eYNkt?=
 =?us-ascii?Q?jens5FerhsuTG0nFElS3cvZ2AfxNm35oMFrQc4cMz/3djpkmcsAoYtaExBu0?=
 =?us-ascii?Q?Aiqqc5rz4TVqu3vq9wn5HtIpW9gbB2IR9Q8jDlDceS5l56GoauipOhUzuT6E?=
 =?us-ascii?Q?rawWZ5KIWRpHhGZd8mpZovJI6YFJ70uyyE4t1wPoYD1vnzSi6MyweBPK0eHo?=
 =?us-ascii?Q?9/6JakxDw6cDbFdI6/XNpgH4L/Gc5AQy9GeqqDhF1l4Mh2R2JbcDDCubxOs/?=
 =?us-ascii?Q?gPlKqWbVk2bAOGM5sV/eogeSZ7uLsrzGuSnYgw33llhPTL44E/9Zey2DQV/y?=
 =?us-ascii?Q?Ls5PUfASDokNXU+L1y0y+e8JtOUz22Ss634hLmbpZBtEJhNSGjtTWYDfpqsb?=
 =?us-ascii?Q?AY5oQpRi38WaIY3+LR3iBNyBdFpn8KDrpBo5EVcty8tH73yCc2WV5gQbXgxS?=
 =?us-ascii?Q?7fKwQ+Ho1RXLwIHDpjkLoPkZI/dXSleiGxU3EJ9+HHPG8D4ZxuLi16YKF81E?=
 =?us-ascii?Q?XuIG+qL7iOXCsE6f+GO2UvE5mvEyDwicNayph21f2OGExpzeo/zxAroArRwT?=
 =?us-ascii?Q?g53bjLcyHHGpE/GFx4hov8tbpBNjhlLURvyhkmNRFHYyS5sG+aiZUBDHGpyu?=
 =?us-ascii?Q?HMtENaciXKzTuMILyl9sIBXd29LOediC632Q+k1kvxNjc7DDdNrIUYHhHbnE?=
 =?us-ascii?Q?c3PliRgnAVuKCnVs8vzEqToHtk08EZyaC0QV1xbVT5cqs/QDWdTAIbDVfrXP?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da2fae98-c0d5-4978-4edd-08db9dd84623
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:40:41.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /U4rW3n9ZPAP7L2FTt3Tl/1cPwFEYi6yfBQAAdFworrtgt156dunj5aRrtwxkO+8HrfVvOH5DLjZ6CfCsnf6xcV0ZoXTnyG3y1+IwjvFUdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
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

Tom Lendacky wrote:
> On 8/14/23 02:43, Dan Williams wrote:
> > The sevguest driver was a first mover in the confidential computing
> > space. As a first mover that afforded some leeway to build the driver
> > without concern for common infrastructure.
> > 
> > Now that sevguest is no longer a singleton [1] the common operation of
> > building and transmitting attestation report blobs can / should be made
> > common. In this model the so called "TSM-provider" implementations can
> > share a common envelope ABI even if the contents of that envelope remain
> > vendor-specific. When / if the industry agrees on an attestation record
> > format, that definition can also fit in the same ABI. In the meantime
> > the kernel's maintenance burden is reduced and collaboration on the
> > commons is increased.
> > 
> > Convert sevguest to use CONFIG_TSM_REPORTS to retrieve the blobs that
> > the SNP_{GET,GET_EXT}_REPORT ioctls produce. An example flow for
> > retrieving the SNP_GET_REPORT blob via the TSM interface utility,
> > assuming no nonce and VMPL==2:
> > 
> >      echo 2 > /sys/class/tsm/tsm0/privlevel
> >      dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
> >      hexdump -C /sys/class/tsm/tsm0/outblob
> > 
> > ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> > format to "extended":
> > 
> >      echo 2 > /sys/class/tsm/tsm0/privlevel
> >      echo extended > /sys/class/tsm/tsm0/format
> >      dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
> >      hexdump -C /sys/class/tsm/tsm0/outblob
> > 
> > The old ioctls can be lazily deprecated, the main motivation of this
> > effort is to stop the proliferation of new ioctls, and to increase
> > cross-vendor colloboration.
> > 
> > Note, only compile-tested.
> 
> I just got back from vacation, so I'll apply and test as soon as I get a 

Appreciate it! Hold off on testing until v3 though since Peter
highlighted I am misusing no_free_ptr(), Jeremi pointed out that
sev-guest locking is being violated, and configfs may need to be
deployed for this to future proof the ABI for future use cases.

> chance.
> 
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/virt/coco/sev-guest/Kconfig     |    1
> >   drivers/virt/coco/sev-guest/sev-guest.c |   81 +++++++++++++++++++++++++++++++
> >   2 files changed, 82 insertions(+)
> > 
> > diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> > index da2d7ca531f0..1cffc72c41cb 100644
> > --- a/drivers/virt/coco/sev-guest/Kconfig
> > +++ b/drivers/virt/coco/sev-guest/Kconfig
> > @@ -5,6 +5,7 @@ config SEV_GUEST
> >   	select CRYPTO
> >   	select CRYPTO_AEAD2
> >   	select CRYPTO_GCM
> > +	select TSM_REPORTS
> >   	help
> >   	  SEV-SNP firmware provides the guest a mechanism to communicate with
> >   	  the PSP without risk from a malicious hypervisor who wishes to read,
> > diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> > index f48c4764a7a2..5941081502e8 100644
> > --- a/drivers/virt/coco/sev-guest/sev-guest.c
> > +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/miscdevice.h>
> >   #include <linux/set_memory.h>
> >   #include <linux/fs.h>
> > +#include <linux/tsm.h>
> >   #include <crypto/aead.h>
> >   #include <linux/scatterlist.h>
> >   #include <linux/psp-sev.h>
> > @@ -769,6 +770,78 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
> >   	return key;
> >   }
> >   
> > +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
> > +			  size_t *outblob_len)
> > +{
> > +	struct snp_guest_dev *snp_dev = dev_get_drvdata(dev);
> > +	const int report_size = SZ_16K;
> 
> The response buffer from the PSP is limited to 4K, so the report size can 
> be SZ_4K.

Oh, ok, what about the extended case?

> 
> > +	const int ext_size = SZ_16K;
> > +	int ret, size;
> > +
> > +	if (desc->inblob_len != 64)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (desc->outblob_format == TSM_FORMAT_EXTENDED)
> > +		size = report_size + ext_size;
> > +	else
> > +		size = report_size;
> > +
> > +	u8 *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> > +
> > +	if (desc->outblob_format == TSM_FORMAT_EXTENDED) {
> > +		struct snp_ext_report_req ext_req = {
> > +			.data = { .vmpl = desc->privlevel },
> > +			.certs_address = (__u64)buf + report_size,
> > +			.certs_len = ext_size,
> > +		};
> > +		memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
> > +
> > +		struct snp_guest_request_ioctl input = {
> > +			.msg_version = 1,
> > +			.req_data = (__u64)&ext_req,
> > +			.resp_data = (__u64)buf,
> > +		};
> 
> Won't the compiler complain about this declaration being after the memcpy()?

The memcpy is into @ext_req, @input is just referencing @ext_req.

> 
> > +
> > +		ret = get_ext_report(snp_dev, &input, SNP_KARG);
> > +	} else {
> > +		struct snp_report_req req = {
> > +			.vmpl = desc->privlevel,
> > +		};
> > +		memcpy(&req.user_data, desc->inblob, desc->inblob_len);
> > +
> > +		struct snp_guest_request_ioctl input = {
> > +			.msg_version = 1,
> > +			.req_data = (__u64) &req,
> > +			.resp_data = (__u64) buf,
> > +		};
> 
> Ditto here.
> 

I think its ok, but let me know if you think I am missing something.
Thanks for taking a look!
