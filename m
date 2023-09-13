Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1879F100
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjIMSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIMSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:18:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968919B6;
        Wed, 13 Sep 2023 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694629112; x=1726165112;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iBXG867cjB56Ne90toOmOXJPThICel2VrSp4AJYtSsM=;
  b=B57W/IRuA5nJXq0MENMrTlmP8bA/VO9YjzU+MuxuuYcEzcb+Lmhvk6yP
   6fJtPjKJFKjuC3nSFEB6jjQ0BTg7/4epRVDTNq90T7gQLHRxXi/PSfE9r
   ysuWrR1HWztVp71XYo5yaH6lk7wfHUXyL/W+c1nsgFAs0+FJoF53E5G9q
   YR6KibQ2IY1dglnVM+zz90Cvj4dLD7cJuITIoJAMiYAKjyuiJzMWeD4YP
   /UDXPzIwYS767LAgFcvPvU7nFWL9SeefJNmSQEuBYJdOPKoe7UPguyPF1
   EELPqshnW5ueuFraiAggBaYBzkAtCQ4PzHsqYcL5HPAacFI6V97M6yXgK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382556756"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="382556756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="737621756"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="737621756"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 11:17:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:17:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 11:17:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 11:17:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 11:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kn/jwGYi2RTIaJrLGNx6VY4kMeh7NPnailHac1cGQOetGkVr9wjPzZ2Zd0THaJet2a4cInmWkQGV/tTaWQqK92T+hjwDoR6wv8N9UGfZ3R1mZt9RiyMFcm9UF73o+cmpNIekoIjjaLQ0nHhId2iftPRJfJbEYwg5kjDEUfOfd2QLB1fpsjUIPZDXj2CFL4uZFAhGyYjC5Zzwk5Ox627S664uxdRK5Coj2wTuWh8zzjjw5iuBB0lOghLrcORooaZkkVQN3tMZXXOZhSIJ3QGm43b81sdU303KF3sckOLpekbg9/rvnaR2buCnkiNNk6QCeSJlxdUxxoPLXjwpadPHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du1Qe7pUCwaLy7Fo1DAOyH20x5gqIHo54mRArZxdvdA=;
 b=RBIPPUehXvEcr/rcKgRHZTrsrmxi6JU++CBIOmuScqU7taWd+rjzegDGTwhpUJocmwYl7q8zhBpazjSdEmfI2zTrOTgeYuIHRauUmGJxoZoiN0ELXIANfkjesE1l6cMQN6LMEU3KpzmjLT18InBDIwsJg2O6VXhplcweXx5YzDbZqjbWTQmimydcSvk89FtxwfrFb9COjo+6bwtPrx2rqHScJy5lsSTSnaXtID1KcZmRFvpxeWpw77cd2j4Z9arYD+MzrUnBw5TtaBDV4oZa3AVbU3xOcpEfOs2UE/jK7A9IEIGdi4hFLp1+mJZuMYc0cH90KyBM6iTaDvbEG5nuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 18:17:44 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 18:17:44 +0000
Date:   Wed, 13 Sep 2023 11:17:40 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/mbox: Fix CEL logic for poison and security commands
Message-ID: <6501fcc4e2c9_31df4629421@iweiny-mobl.notmuch>
References: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
 <6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::48) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6b17fa-2663-4e60-1f78-08dbb485b973
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4QgUhDUR3+aYLJxN63wqo9ajdbRj4A27d04YcSSyVVnMy8qG0YmEFDDuCmwbwhfP2LNRviE0+hAUOE782J4X+LZeeMkSamgB79r+0T8Pm3I92RksoElYz14L61CHsi+lNdoPfSLp0gZ16wgZxg5PzssM1XShzihaFwwLw/5TXdM870uFk/TrYf5DuGoAnIEZOpOyQqpn8Y93FUCUy+YupqE0QMOgNT0PbjCNU+7Y9BMEIHAWnvM7zDywsQB9cz1B5tyUQ1E5hTsioBPM/QNN5Dhl9Pdx0yCEfasvXuIGJ6LKVBa1Jg4ryDr7kBpfKE0xj+/vMuvtM9daiRw5YdssgKzKTuIeHu2S6qW1D0QZTjCVO443/gjord/iaO9bzRc44elaqtbdeWXs26/CGCJKr2NssNejv6PJUavTQjfOi0DpybZ8G+s9JPTUWylOFh3Rmg1BWD65pZB53Pa1TfHehGOYEm283IoTMnpQZreWxxEojuCOnoDp6Sq2QnFn5ZWIVwLYsL8X9qf+h6AJwVY4CzX2/+kMwqm+vX+BjJbXCAs0zcrNL0xp6EJzzQFTvQ8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(1800799009)(186009)(451199024)(5660300002)(66476007)(66556008)(110136005)(2906002)(82960400001)(15650500001)(83380400001)(6486002)(66946007)(6636002)(9686003)(107886003)(4326008)(478600001)(26005)(44832011)(6512007)(6666004)(316002)(41300700001)(8676002)(8936002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YD8WVNNTCIkXE6nrwChJD+jPYaYxja13ZJ059UL5ZB9/wD/ufMhsv2Cc9qY2?=
 =?us-ascii?Q?aZ9v45qi0OwqlyFz6jEy4P31tGDnzOHSzV+4W2p8DuQ1RUlii/euHE5NoX8c?=
 =?us-ascii?Q?Jpfl9kSQooMwuD2/fLFUKrvYOMCsLS+Pidz06Jtsv8iN6yVj7rlcN0NWAEfv?=
 =?us-ascii?Q?hK7V6cx95XODWXjzjZ+0DSn+Mpk+OGiAxR11FxLSGcX0jmCbY4+TEoMJQU5n?=
 =?us-ascii?Q?AdZqDLQtSiF050He/Lks2QruVN6cl7tAPSExbPO+Admozqcqf/8aAcKt0ZW/?=
 =?us-ascii?Q?R/UfBaTFKX52DQxSpSaFmr20uo4DWMCQRT0pFxnm2Pm8jsxUPTRD5tpI0nzT?=
 =?us-ascii?Q?OTsnhPkCLimaMmLMGJODkSkSyPpPeChvXX9DpaWBosYaxt70/g7dSbOhvEUY?=
 =?us-ascii?Q?B0/FuLanEczNvgHliZamhtt9eTaVogwqjZsPjr7xgcfAT966ALt/GAynsuoz?=
 =?us-ascii?Q?hqOruKRzcDFKDPbLMC7psiBh49uuTQy9EnyOgGHqnfUWb3bGLrWzPGAB+ZLh?=
 =?us-ascii?Q?Es9ThUV1dQIeE7LB7TqqX7cgPJd1rkBIdtl5gASpRf0Xh+toa196YrFs5qx8?=
 =?us-ascii?Q?kidVEOdjgYRXKWRz5y/pMZt8xY6A8O2Hqkl2CW/GXqMWt8BTKXqSdlnjGPbr?=
 =?us-ascii?Q?mv97FxzIK1vtvNOjnDn3+fGNGI4J6LzyXfXOYPleZUra5BBrs7UGMREbMxGp?=
 =?us-ascii?Q?dQvtHAZsZkSXvxkZH3DwViUm+UEvybTOhxpo4FANURD5mMB9tzDvQZFa2S9I?=
 =?us-ascii?Q?qa4E3oghQV1uNFuHazBVmQo2lGMvL+aiusDnw5S93hmepZI80WR2zgQ3cz2a?=
 =?us-ascii?Q?1124EbjNLmyBB/Y2+i+bA0PkUALXKS1UOQEGk55UQ0GkDbnnqTI9TRPbRlOQ?=
 =?us-ascii?Q?u7XM80bTe0YcMMmmQYcsxsMo3G1/oTvGI8SvUUdoUSj7WQaRUM8W/FHGfOYq?=
 =?us-ascii?Q?LvujylwYwznDfVZGP6dJK5Nl/HffRU34uTLgdp6eLvDXcvaUOlI5WBkebgmh?=
 =?us-ascii?Q?q7t1NnwbjDNGxF+OMde9exhtTAAb8K7BEt1zJsu4YPOGsyWHnGvReerI1Euo?=
 =?us-ascii?Q?lifswS8Vgvk5DbbZSUc+T/+7VDKcfmW8UwO5oWQmm5mipzIfV9BYiSTAZw4a?=
 =?us-ascii?Q?SAiOkK0/JP7iZGFMpaDtCSK3Y7hrgRm//0+154v0k2k7nA8RMsrQw2aawdgy?=
 =?us-ascii?Q?wPVPjiIga6UEygCIBullV/TXz3jvIBc9wmnc0FZBu3cQJcCmAGTwRRlcMiZI?=
 =?us-ascii?Q?HU3Xg/QWUlldx7MoZdzXAEx+3dv6mO06OLQ5RQFweIzPZ86sV9sHtyu1pGfy?=
 =?us-ascii?Q?+6gQF+506IKSnhopLNQuEkQGJ4Q3H0YgJ7YUymbPN2QbZ/BFPWMOp7Le9nMJ?=
 =?us-ascii?Q?8NZ1+k0SwqDN2rSyzxVYeqYhiLBHrQjKatlHadZaJVyWrOQtCw+m4doDKQtk?=
 =?us-ascii?Q?GegjdpBkaY12truZqjR61t5y7VACZOnhSA6Z/rg92+q+WtLWTnhHLJVEDOth?=
 =?us-ascii?Q?3o+5JalItadFsZlvStGJxU2qqM3h5Q/QbRlxt2vYcoLbv2nd07m06a07uEWv?=
 =?us-ascii?Q?71V+B16GJm8kAY9Ww/TVWbawW+G3Bf+VFWTM97rJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6b17fa-2663-4e60-1f78-08dbb485b973
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 18:17:43.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv1kSy4YUVYrECqmasMXx77SKuAXaOVl5430fxEkCRcuQeTNecy+4IwEJIGZ8d3e/n6oFIDzzoaVaJpnJvqP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7677
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > The following debug output was observed while testing CXL
> > 
> > cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver
> > 
> > opcode 0x4300 (Get Poison) is supported by the driver and the mock
> > device supports it.  The logic should be checking that the opcode is
> > both not poison and not security.
> > 
> > Fix the logic to allow poison and security commands.
> > 
> > Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index ca60bb8114f2..b315bdab9197 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> >  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> >  
> > -		if (!cmd && (!cxl_is_poison_command(opcode) ||
> > -			     !cxl_is_security_command(opcode))) {
> > +		if (!cmd && !cxl_is_poison_command(opcode) &&
> > +		    !cxl_is_security_command(opcode)) {
> 
> Given that this is going to be a recurring pattern to add optional
> command support, I am not a fan of continuing to expand this boolean
> algebra eye exam.
> 
> How about the following to only do the validation check and enabling in
> one place:

I like it.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..4df4f614f490 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -715,24 +715,25 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	for (i = 0; i < cel_entries; i++) {
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> +		int enabled = 0;
>  
> -		if (!cmd && (!cxl_is_poison_command(opcode) ||
> -			     !cxl_is_security_command(opcode))) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> -			continue;
> -		}
> -
> -		if (cmd)
> +		if (cmd) {
>  			set_bit(cmd->info.id, mds->enabled_cmds);
> +			enabled++;
> +		}
>  
> -		if (cxl_is_poison_command(opcode))
> +		if (cxl_is_poison_command(opcode)) {
>  			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
> +			enabled++;
> +		}
>  
> -		if (cxl_is_security_command(opcode))
> +		if (cxl_is_security_command(opcode)) {
>  			cxl_set_security_cmd_enabled(&mds->security, opcode);
> +			enabled++;
> +		}
>  
> -		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
> +		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> +			enabled ? "enabled" : "unsupported by driver");
>  	}
>  }
>  


