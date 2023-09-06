Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8977946B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbjIFWz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjIFWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:55:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0881D19A9;
        Wed,  6 Sep 2023 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694040955; x=1725576955;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TmyC26gM+6F8P/f/0+1pt+Qk7mjeJo8xgvPTubar2xI=;
  b=BG+Tr86p0S6Uu4lRiu2JWqIL+HRClJOuyNIVigZJ/oJcm+WGAy8j9b9G
   4UOB21oogLqIKA2YAMjvBJx4yXmJVxWNfxLxBh4Z/yiTg55eXOIdkf9b9
   x2ovXa62tfqMcthR12LCJanL4vw+A4hG0aTFNLOrmbItYvhDFvo0Hdumi
   b/G1CIL7IghjQyZLoEikaMwRkvctugiEz2rcojWEOVOxUMruZ2IAa2n7I
   DHma86ykGVeC7fAtUMx7JTwXWwyJeM/h4E3ZpyaiMFILr/h8dySGm9mG9
   iznxZ99zj4EmHxWG3OdA7t82f89y2QgOOdvUM+LvsJ9pFtj+6W7ac/Jgx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362237571"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="362237571"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="884923479"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="884923479"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 15:55:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 15:55:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 15:55:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 15:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO953M0SfO0aG3VfyFX9D+XwdUtkFwsUQ2Z2hmjMFI9aMj3x/gp6/lec38AFzvRN6EBMy0bhG5RM+q4S4dC/U+wgZyWiCkDNWmodwVkG+U8/lyChaxjZTYuVwqbFhxZDFZA1vpPlGp8qSBY+hN5SlDI4mGKyqFr+hsu3augvj4RSawjnVh5V5jbrJpretUM2Fr6zUSwi7l+er0N1kvtUQu5qUeRCv3+xEUUwII2AtOB4x2KG8H5VFbsJbjPUGWO/bEhJay05oQ01zgla9XmsHjmM+sM9j+EPNVaYF6ix3Y6RrfP9iBQ1oRz4BhIAEy8Yk43IAG6auCBazalIs2JUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giPvGiIBHGiTyzFqlUuu8N26AT91SCWDWjo3aKUP4p4=;
 b=XWiNp9DRVBQYGQtZ28kw3pzS1Jd9bOERStYlDVl1PBF1eFsX2ysQ8ps/p8LFeiU0FlIXIu6CJgEDKeHzl5ODELhI3Z5jBLuUJcWQfyA4Fz+kooCbK7+FBvWW2xVWQeKzi7gt/19lFmWM5bYF2iRGtSEhIjPDsv1/gkqE03+yV7Ixm0htBQl+1+IaTSRlnxVdC0hJ1hjU8TIrsGc6+Gbu+5vwT5xXhuh9WuoMqVJMEFVc1tHuqNV1rLqYQWIAtAQdEkHWjA+El9LdrMzjGqbRnzpStlFeKV48SYT2A1lNclLotEkG0BjQ8B8nuhVY+SKoG4UpXUID19+IqSd7Hmi4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 22:55:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 22:55:48 +0000
Date:   Thu, 7 Sep 2023 00:55:36 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <sasha.neftin@intel.com>,
        Ferenc Fejes <ferenc.fejes@ericsson.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v1] igc: Fix infinite initialization loop with
 early XDP redirect
Message-ID: <ZPkDaLo4ubFRpPg3@boxer>
References: <20230905213753.697461-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230905213753.697461-1-vinicius.gomes@intel.com>
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV3PR11MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3c105e-73b2-4282-69e3-08dbaf2c6981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGxdw/67clwvAp1eX22q6FB+GqydQsqaXnFxnVJ8Owns455kK012eQ4CR4d1d2cAHNS2LiZvsssQwncGXlcCMf65JWAXXNIufi3Uxf8+k6uXnAbLYVKgfEEGFLQeK5oi37X6dU4HPTCYn0p6cD2pxdAZuyTHVKW0Io90TtHffPAv0DuLISdt7KxlgdqW8I42IreHkdrl2WGqIxlFsVGzQXp6b3U7vVbZsQoy4dAH8jVzHoGwp3LsvVwzFungq88WU57GimSqGDjDlRf6Q/JO/cjfl1WdApYsV3GYqS3RN/c8tZ7/7SR16GPoz3WD0/Sq15yzK2FpATRjH1WKksGU+fpUSDKbVgxjJuYCVDhlAp9HFaMPHbmDMXfrBpPfLTxvZ0ibkDR+3y7s1rLI9IELCM7D90+PDOQzMyl2cDf/EZv/WkzcdBLv+D9J+stbnmMOZdvTHKzkMUaGzwn453lDnriIC26hXEWlsgHiX64tUKOk1pTqLZuA2WqZz0y4UqSdR9W8fn/0lLpqQzIAz4OV1lpMdaJcYH9zbQXbhtD44gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(82960400001)(38100700002)(26005)(6486002)(6506007)(9686003)(6512007)(33716001)(83380400001)(86362001)(44832011)(5660300002)(966005)(41300700001)(6636002)(54906003)(66556008)(316002)(66946007)(66476007)(6862004)(4326008)(8676002)(8936002)(6666004)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+E5giDZS6U3N8HWETZn2M1tWHdXKzc029l3kFNk2dUZBWcmnJUGi8K5ocAQ?=
 =?us-ascii?Q?owSsmVTEoW6j+GYK2zphbMgIjS8k2XQPGGmhHAh3VWaddkt4ngAv7mLFlTlN?=
 =?us-ascii?Q?8LaWgq86s16Zvo9lvPAOY/+dgqPINb+U0ksYfmXOGc/ttSnArrXxXTBo6hpV?=
 =?us-ascii?Q?RSHy51xhhNeUH2GPAq1pPUXh/lSRD6a6rTBZf0/zBBhJMFYDXhlQYOrbpMAt?=
 =?us-ascii?Q?aaech9TcHFclizSBd8s2BBo4htoUDspCi4DrDuycg57EdURnYPrThtezjYGB?=
 =?us-ascii?Q?QLnPursuRJ8miNcVmWhXwzdwoXIcekEXqvJdK4KpWf3clFqrZZgg58i3PCy8?=
 =?us-ascii?Q?1Mbd/ot1VABfao+Enk5O9W2r/vp+TCD5fRhL1xRm5pPm9QIfsPps6Z/zkteM?=
 =?us-ascii?Q?F5K989BFVddhjgydm1l9zG6hAZXCiTMCIBR2raPJ8gl6PjckWmQRf+8s1vIv?=
 =?us-ascii?Q?+g9hjsS/OvxmE+sIVmmvIdgNYwW37BAOVNU5JDB+L2sStQLxT7F7YlBIuviJ?=
 =?us-ascii?Q?5naEMHz3fag0f9QODZwiKHxVZah3Yen8Ko2pH2hnubeZ/qnA/ekSOoBkdw92?=
 =?us-ascii?Q?1mlOTMfM3W2yB7WTEphvk6VQBpKdEsWpKSqnwE/b192TOZvknNh1KzXgrFYQ?=
 =?us-ascii?Q?VhodzD/kb06SrR6rOAw1EIMbwUvLrqqlR/dAizcYJYL+gj6ho9O73cBSwvee?=
 =?us-ascii?Q?cqKiyvZYfMnR8XOfGuU+7KZiWYjPVMVHTeZAac6fQ9u5lUPef5+xiF8fRAAg?=
 =?us-ascii?Q?muENw+p9Ti4puJiV6enVLeTFAeuYJwtQZfzB90cbmQX2loc6lWkxLuq1Gcek?=
 =?us-ascii?Q?c1HE8R343Q5kLkMprwYk+sM+4D2TbvQ0fYuaNR4C37uAWAFXcHvlB+VZZNSg?=
 =?us-ascii?Q?JwIR8t/iyW4vb2Y1C0yy8i7jk5P48pOJtKuf0ehrEfNkbzQ/UFQ1qqdKKCq1?=
 =?us-ascii?Q?rTe2hkgCmxEAxPgUfTj7HO/FyNh08jZG6EDn140ANtWV0RK+W0rsOLa44UFp?=
 =?us-ascii?Q?mhmIKVN8ybKd6b3iw7DsGOebE3hNFIO5NuDOB1U+tIsM4aFLN10Xdu1560K9?=
 =?us-ascii?Q?fvAe+Z3a9mZU2fkEVmoM7DJNzjJ7m3r7oQWCZ9aIPxWHXr6J7KKmZsKpnal4?=
 =?us-ascii?Q?tzAtM5mcDAZN/NEBvGcHOx+LVYR9yuqyGU8XOw7+1yVoDLGMZN4tQ6oKl8Rv?=
 =?us-ascii?Q?qLFLzZYZzO0TP4J6BIvd70a/rEe23i8rXjL+4KhCuEU7uY84hsqX5Y6rl4BT?=
 =?us-ascii?Q?f3b8nm/9D3c59iqjGn3/lGmNa+8lM8hONAN9slv0KIppeQas/n/jQTUPiEB5?=
 =?us-ascii?Q?6vnssNW9y9TtQI8Fzv1NXKBt11tlltxdAsQSUgHbK2JPO3QONZcA4mICswOF?=
 =?us-ascii?Q?wRIue33FGKEoxZqN97T/vd2Kk8XQLsVaKI2+opq1oPkKkx3TfU0tNVbV0Mqe?=
 =?us-ascii?Q?B9IvaXzYFxbjBojyWll5tIwMB3VDpCJD83h7TyIzuWeLedkSLYLFBI83qKoz?=
 =?us-ascii?Q?1MsYCxA7PKcG9djqfsku1zsjmS8VLHMp2UYxXdKQexPeXzEUq9G2EfxriZFI?=
 =?us-ascii?Q?2tDVdyfNFQRtIL1hDm1IH+Qx2NcH7MqFvOvHCVthUJN9AxJtsEcWVCFJq3Lv?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3c105e-73b2-4282-69e3-08dbaf2c6981
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 22:55:48.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+1n/Ne5fYRH51CHAp4RzEZLC0hcp+f1lU6Hsods8WCuzoyLLpJ+Qkq7ZqCD4dmYwjeH667N6n6HETLSepZa4Cb8RxnovWv6Ye99ZWY3hu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:37:52PM -0700, Vinicius Costa Gomes wrote:
> When a XDP redirect happens before the link is ready, that

When exactly link was 'ready' in your setup? You said it was enough to
launch traffic towards igc iface before running xdp-bench. Was the iface
down or up or?

> transmission will not finish and will timeout, causing an adapter
> reset. If the redirects do not stop, the adapter will not stop
> resetting.

Please highlight that this driver shares tx resources with netstack. I
believe the source of this bug is that the watchdog is responsible to call
netif_carrier_on() from a workqueue which happens to be scheduled *after*
clearing __IGC_DOWN in igc_up().

> 
> Wait for the driver to signal that there's a carrier before allowing
> transmissions to proceed.
> 
> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
> Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
> Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 293b45717683..98de34d0ce07 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6491,7 +6491,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
>  	struct igc_ring *ring;
>  	int i, drops;
>  
> -	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
> +	if (unlikely(!netif_carrier_ok(dev)))
>  		return -ENETDOWN;

I thought about keeping the bit check as well but given what i wrote above
it is probably redundant, so:

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

>  
>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> -- 
> 2.41.0
> 
