Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955177BDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjHNQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjHNQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:23:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2558A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692030185; x=1723566185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7bpy/cs7Z1eV9p4tOArJK/+2/ngqLUfEldw+NVeiFCc=;
  b=eA4E3zVXpAVr2oT7bnwJO9Ou9bY30esky1X/K+Rh2P+kXhy+bP9lbIbL
   wVhn4mXbRJtfAexBa2B9mjHYb6hah7EGNFqrTWPNTiLjF4/0P62XlhzDa
   teZJ/YzlwReyAlYvYL2jf4NSpI66ejX4Rlpvia56TkQNnMLGSqtpMDQgW
   nk2lL7QuqasFFGnVeJoB/DYPvd81V1Yh3bG22TZlcEOjHkOn0kdfv1YHd
   85HdWWd/Rs5jotHVZJrK2ycQKb7voZo2rIz/E7gKX0+rszn1Xnv4AvB8i
   pBmkXA35mPy1exCqqGFLOhvD81/8Tn3Bx2JhH1YSy7AYDlJi6mpVYAnxk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="435963816"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="435963816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 09:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="803509772"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="803509772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2023 09:23:04 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 09:23:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 09:23:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 09:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTiAfDsc1Ntn8bh/BikatOQQBH6sUiIPoEaAzTANlxmRmb6zquMIXh5VE5HCD0/JlbCx1n9NC+qtqrosMC85/vfJJAVdL3JVDHNS5RSXf+g0lt9a1bt9Wq+ZSgviEYQ4MHTVoMIEbnj4PVWpR+nTiUi/ccnkVKt523P0pQ9LDKSNba4KLBxGv3uHe4e1GNX0ga/WiraNBPAQNkI4nhtPn1ZczvKTjq7LEIIdAcjnRd5T6A9bwoJj29MML1/AuQpFPewP4zaZgYU9PU0q8Y787VymJcaXYGpSe+NO/RmE4hGi3DzGS6/WmwIY01r99ByXr9fw3q1QGjOthyxZ4Fm4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbyBN+Tb0LVEZGyuSU8IqJw3UwNAUfIdo6uNn8Z/W14=;
 b=af0yElxzEdk+DunPApI+hikjJMZcR7yHgKsHtCXI9N4gmVhoUCYxK1LDEjZ6gXg4g2lNGrNXE0G3MScks1gkWnYSMGvewIwjXptaEKIwYzgWVYd9CNeFQkHBc5r1FLXhtQJEbKcLWGwcsbL92+2XwADSQUpsI0oVa6ZvSVeeyaoVsiTUfNE2Yu/cVVllYPBg73Z91ABb2hUR3nmpErUJBrTgMUiPzKDLkiIlUNdJqsF26Spt0c29sHh6kv7KiWA8Xrn0wF9UFZGRCRvIxVg3XJLSBoIagP5OQPtG6kAIh8nUBgcS95CHEtYTJdny1olTd59tAm4e/zPmIwGAZY/x3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 16:23:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:23:02 +0000
Date:   Mon, 14 Aug 2023 09:22:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] virt: sevguest: Add TSM_REPORTS support for
 SNP_{GET, GET_EXT}_REPORT
Message-ID: <64da54e35d473_2138e2945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199901829.1782217.16990408177897780160.stgit@dwillia2-xfh.jf.intel.com>
 <38891bc8-3550-403c-88d7-2e4058bbe20c@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38891bc8-3550-403c-88d7-2e4058bbe20c@linux.microsoft.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e5283b-2b02-4157-7029-08db9ce2bb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yXl5N+e0V/k68smDGg3BvNOQRvvT4Lb5DkVKGpyaVDjtjbY5etoHpoIMNHqg4rUHVvN3RNuNMN+yBAKRPxsJBG7fug+DhdpB9/02qlkj+ZVutZ2eSJupufjzIxgAn239hRtDhFw1EadMAZYRglpukRctVJw8ZAwUcuWiMBheglB70pBPYulzOhua3S1ginWkZ5BUx5eRGMpuEwib4sVJXlJcQbK6JgCNG3f/47gppF8PlxkVgUVsTTctBc5lsRX0ot5kV4huyu8qcSyVcO4B3VguMKqmB4TsG18jwd+Fkz65rcgtJX2jGbXYppnIyQOykprtCBXH1RmJEOmBL57ryc8eyEOH36zj2jrEmyUEqcqy4fgi1PQDxH+vUYIzCepTIe4+MX9UsyIvJNajG8S8EuvTtGkBaVo7UohKMY4lDMZ10LLB4dkCtUYL5BJ80S17bJD5xQobMYSvu8NGJpAZ6LxIYOREm+haJvVqVdBKhteH4E7gMzVtqnxkobnyh4OUyGWBdLjCQKq9bR6PcpoPd2qSdFJ9Wxp6wn1MRJY2mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(1800799006)(186006)(451199021)(9686003)(6486002)(6512007)(966005)(6666004)(38100700002)(82960400001)(83380400001)(86362001)(53546011)(26005)(6506007)(2906002)(54906003)(110136005)(478600001)(8676002)(41300700001)(5660300002)(8936002)(66556008)(66946007)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdR2P2JAKjcCBH2M9awo5fGtRd3E/vrJ8n6GF7/yZ6vdRUVldHCITqR2KWv3?=
 =?us-ascii?Q?IEXICaP7QJZB6lmo3C7rTYYoHPLSC9pmWaKAqsPYDpNOXV/KRraIK6QsE1Zi?=
 =?us-ascii?Q?PUI2h+jFYjsyNn4F1XRrJAA9Dwi/5LM9SoMFOZTKDlKFOjxiJy8e5ZkwJy5/?=
 =?us-ascii?Q?6JoWyaPe4w9nkwnWlzeFyMMOkxqJ85Xmf5kHjJjPJ4QplHycoclyXt8WHYsL?=
 =?us-ascii?Q?xAWoHgrwgWER15IjlrAQTRLy06TdTqCkGj8VwSgpPAO1+wrU01sb4ZEP4d+a?=
 =?us-ascii?Q?SWy2CUfrQs2tXdMkeutSwjE59B6hbZa0MCYPFoQX0spz+OqOQkYcxDVN6hW2?=
 =?us-ascii?Q?Su8UPX7QLaieq7BlsPXWPmabJ5SXReAoBbxA88O16vmqubp8dLcaSUYtafGR?=
 =?us-ascii?Q?4argKDu1g010Jwff7+ybmIONA/oWj0AVfao4ZeRXh6stEzwlau5B8pAsUe/L?=
 =?us-ascii?Q?iCAQYEu4Gi0eM4c59zQPHVIzWbmFizzzUtUQ1NJOGGVwM50bsXTtxXfIMXoI?=
 =?us-ascii?Q?PqCMwd/MRCNXjAdKt5fpo1bsAftBQ9tLOl0zX4CZQZ7sufNDcCF7OHnOoypw?=
 =?us-ascii?Q?u2GUQW9hp5LrMsN2vWnRZK9AnE+hs0fkAGZ7N8unjLekEq48GArceYj2un2f?=
 =?us-ascii?Q?30SKvLBlPfuJBffdimJuj23e+P5i/p4XGwAKrkMJzyEQHpNe6ckgLV8j4+DD?=
 =?us-ascii?Q?XnyVJ4dX5pjkV2RktcdGxotOvN/d/kWt7nWyOhpEC9F3SZHLKBb/EF+H4rA7?=
 =?us-ascii?Q?7qcV0A5nf9n2nzpcZdXDprvCfHA13zs6nVV79cUTBmStmMOsd+g7S7fsGPyq?=
 =?us-ascii?Q?Qrr1s2UPfDnhSi0gCvKRmio5+8nKYe56irE75M1nDyjVaj1bSfXy3M5cmx/9?=
 =?us-ascii?Q?Zcc/AE47DfVEmrnO/ipWyVIC8W74hHGB4MF1dH8q1GtpUG3HO0qliNXb6xZS?=
 =?us-ascii?Q?maHxr95vNIg242oYjlUDpyIE4I3Mmw8Kab84IWUVX4cY1pwmwalbm6wHpZPQ?=
 =?us-ascii?Q?zIE9A+c5gLsoTeDmF718kv7chLFNAiEDTUtthesjJ9VAsxWniA47GmPvK2ac?=
 =?us-ascii?Q?FpoKF2nLPp76KHGruD/z+OjFZfl3YLD0Ivjn9fJUsdwpwmHypQgziGnoenUD?=
 =?us-ascii?Q?8zI0iZH7ZfzRNNBL9LJt9IZgGlRK8wB4yHfw6V6Agjl7IqYGa7YjBa+TXLw6?=
 =?us-ascii?Q?TDVGhLAl/tng4E/IN/Gzbznu/bJZJqxW1C3F9mLf1eOnHdp3Bjw/8pgApyGH?=
 =?us-ascii?Q?AfzDNOKozUCU1E6+YfYDb0Y25DpOfY0coaQWqBpGl4cr7k8Lysi/xVuDWyCD?=
 =?us-ascii?Q?euIh0hdcF3Y+DnjJfeJlp1rJMakNOFiowiUbF8z4+xu0k/xp5dvFiItNDAc+?=
 =?us-ascii?Q?rR9haZX2aOHBuKJ9tpGPLBcpdyLF77iHBNTJ0WzgQeJjGguMJVicY/KzyofM?=
 =?us-ascii?Q?UKPsztXnFViocaE9esFYGxvFu/bhDGL4r6prcEL1h0vUrpiDMxfjnYLqjGlP?=
 =?us-ascii?Q?xW3XgQmrGNImX194GLjfbDsy19+2WJ8KDO9EpUqSxcOfiaxYOeDF+qde/tuF?=
 =?us-ascii?Q?JtSavVWeF5NYodCBW6fvZAgEs7kjVQR9kk39HCeXXH4zAkSE5tSNTyaaQKr+?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e5283b-2b02-4157-7029-08db9ce2bb32
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 16:23:02.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9m52nw5ERvKu+gsGXPuHE+xGUZe48/tRb3+r0ebMAqJvVDrkRNcsyI8q3kt6TGnZlRKqjnR9acrKpNSaNu+/0OZ35X4pKe6O3XpMeqRhZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
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

Jeremi Piotrowski wrote:
> On 8/14/2023 9:43 AM, Dan Williams wrote:
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
> >     echo 2 > /sys/class/tsm/tsm0/privlevel
> >     dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
> >     hexdump -C /sys/class/tsm/tsm0/outblob
> > 
> > ...while the SNP_GET_EXT_REPORT flow needs to additionally set the
> > format to "extended":
> > 
> >     echo 2 > /sys/class/tsm/tsm0/privlevel
> >     echo extended > /sys/class/tsm/tsm0/format
> >     dd if=/dev/urandom bs=64 count=1 | xxd -p -c 0 > /sys/class/tsm/tsm0/inhex
> >     hexdump -C /sys/class/tsm/tsm0/outblob
> > 
> > The old ioctls can be lazily deprecated, the main motivation of this
> > effort is to stop the proliferation of new ioctls, and to increase
> > cross-vendor colloboration.
> > 
> > Note, only compile-tested.
> > 
> > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Dionna Glaze <dionnaglaze@google.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/virt/coco/sev-guest/Kconfig     |    1 
> >  drivers/virt/coco/sev-guest/sev-guest.c |   81 +++++++++++++++++++++++++++++++
> >  2 files changed, 82 insertions(+)
> > 
> > diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> > index da2d7ca531f0..1cffc72c41cb 100644
> > --- a/drivers/virt/coco/sev-guest/Kconfig
> > +++ b/drivers/virt/coco/sev-guest/Kconfig
> > @@ -5,6 +5,7 @@ config SEV_GUEST
> >  	select CRYPTO
> >  	select CRYPTO_AEAD2
> >  	select CRYPTO_GCM
> > +	select TSM_REPORTS
> >  	help
> >  	  SEV-SNP firmware provides the guest a mechanism to communicate with
> >  	  the PSP without risk from a malicious hypervisor who wishes to read,
> > diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> > index f48c4764a7a2..5941081502e8 100644
> > --- a/drivers/virt/coco/sev-guest/sev-guest.c
> > +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/miscdevice.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/fs.h>
> > +#include <linux/tsm.h>
> >  #include <crypto/aead.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/psp-sev.h>
> > @@ -769,6 +770,78 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
> >  	return key;
> >  }
> >  
> > +static u8 *sev_report_new(struct device *dev, const struct tsm_desc *desc,
> > +			  size_t *outblob_len)
> 
> get_report and get_ext_report both have a:
> 
>     lockdep_assert_held(&snp_cmd_mutex);
> 
> so you'd need to take that lock somewhere here.

Got it, and in general this needs testing from someone with actual
hardware.
