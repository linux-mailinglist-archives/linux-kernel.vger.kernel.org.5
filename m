Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3F7F2860
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKUJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:09:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071BE7;
        Tue, 21 Nov 2023 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700557752; x=1732093752;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Gu2rWbtTneVddlCpLGGQibvw++6trzQ6opsh3aKz5lM=;
  b=GaYuMhWSndQQwHEFW48W1RO7hGV8JzRgA1NONghuLHe19IyAtnLlWfib
   /OJQvlr+ud4FkwYQblt+oz+E3cBEXewdRc4WBW1v/1xqcesao3QzjckW0
   bfh4IOq5iq/vCvEZD/LWmJxUL5ZCazI6hghoNXQrOA1ka+LzWz8a3EziY
   VUNQtItagt6KA7pc3YF7QoMrRi2i0ySoS/L5XE6pbFfAqbNZTObqwePc4
   P6035DjJP7IcBGY/IxkahzwBALOZb3mH0lntsZzThSbP3s/cogmt16ZKu
   H/0kPBMsCFJ168o/GVsyufHlaELVFk8G44mj1qvIgh9mp+exrqLxJI3AC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422897402"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="422897402"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742990169"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="742990169"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 01:09:11 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 01:09:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 01:09:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 01:09:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOF77FspZxxzlFs0tGjds6EZiDOL/Fk4eySn+uHLSWPPmekxU1Ft/g0NlLgGXzEEmYYLR5lD6eZ7ZL0E8p/blX6ETw1GA0ZOT+zgNZq2UV4M5RjuzvDxwYcJnImCCq/VVhP6QHbhs9ddPtmoByH5z3RzRlsJpXxppKHP3XH0UmR2dCaO2WEIzEzeboxbEQtripYciqDRwdLWVmDmtYDRqNg7ETVGYYbDwtjmICjX2n57CFHKLry8grxERKg2ssZWgiLZPdct9UBOaja6M8B2tE/f+oW5EoQait3Xk+vIWHNXS2ReNjQuDwWIQcgJBg9Y8NADH9bFDHIRNBZt2oFtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30x1jjcxglg7N8BZACAFNZu6EzOHpDGrVBYgKbh1TX8=;
 b=dIXmcjM0FS/ObZ2se+JR+BjEg8m/yV1p1eC7PZZLHWP9tDC7DQ/XlxJ1o97eZn3wyeej/g04khx9eYu0BMV90MUCzqi0aTDuK28X6Lr8tJaBVodDzqPFHF9/kpIth23ya1Pva7E+R5VBvctgTzdgL7/HNBMmgKAfF1+Spht9/BxYUmVcGULOhqcRC9cXOfSgaqYnUYulZv6uSg2pljCMSpDeyEGQPauPcTdx+vQ7GaRO3Fu05QREeJrbo+rfFNFmpuG1ELIRKEkuljnJDjx/A6Z97vGtwFZfRM2xOGeQYdHy/QGv7t95F7XGnhC24EwbD9IX4+8eBgaSb7gUG8P/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 09:09:08 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:09:08 +0000
Date:   Tue, 21 Nov 2023 10:09:01 +0100
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
Message-ID: <ZVxzrWAWO2m4dV7g@lzaremba-mobl.ger.corp.intel.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
 <ZVuUP797C4PLzJsP@lzaremba-mobl.ger.corp.intel.com>
 <655bb796.050a0220.750ad.21a4@mx.google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <655bb796.050a0220.750ad.21a4@mx.google.com>
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c74502-0e66-456b-a45f-08dbea7184d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60FxZ3B3wJASkWT04WlZmkQwUIkcRKmejbRYvVHt2puFh49l5mCaPp/Hd1z4Eo0zktSExcWBKC6aHtBD5m+bR1pFMIm9C7KSYbZuAw5///qbzhGd/gHnlPJjeb9un35noSASqn7tH195qHAELSFTDjMVHTLzlui5K139UCs9Gaiwvbxv/QLZnKdZegjh4DDJHwzd1Xf1hoDvNut27vx93jrce9d+7wKPxUehs1YKov6Jn1nN6jPqIue+jfAsDjxxPZLrNhc0BiXnFW89HTTq2Q0cRQJdSa7Gj6VpFEzfSh7+TX7Wh5KDWQ9rgN+p5oinG1WoAL3zW3jcq9vZ/PlKHxxwXE6FCKd08WVfBSyeS1YJ2VZ+gv8ARgDOKeZwEkyhVS8DmYilWuTsUywtt6vQ/EYYst4d73gUmxTrLiWrUWFuH4dLRV8fTsAkKhbtFKwbtdz0r8OoM4VeHkXFyafhTdVvoB/ksE7BrkUjZ5M0UB7nheIR7r6YOxWfQ1DU/WT1c8nf6v7TjDp+P8VgdrIMvr08CrQCAJ/cf0OJGRfM+PIs6cqZWvpE2Dnfz8NkHIZq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(7416002)(44832011)(41300700001)(4326008)(8936002)(8676002)(66946007)(6916009)(66556008)(54906003)(66476007)(316002)(86362001)(26005)(6486002)(6512007)(6666004)(6506007)(478600001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?siH7dFIYo6sQaIMp60Wxh1zexdigR3wjNhPI+eVoIepCzo+Cz3ED12TuI+3r?=
 =?us-ascii?Q?2ObLcSk6KLc04ZURu4potUg6NTJ23LprR+s34K27bi+4daYhNUNtmdpL1j2l?=
 =?us-ascii?Q?NSI/Jpz8NkecCujCVS2RuW0j/l94xESmz3RDnslrOJv+CpyrfyjeF42rj9od?=
 =?us-ascii?Q?3ONjHpGv83Q8exn0dL80MPi+YyGnR4EQkVfXrSSS9vwLGx10MIW/65rROG+s?=
 =?us-ascii?Q?amp+IXxxFnpKRJUr9rv7hZ4EwI2YpbORrqNkxOE1/EusWaNfvZ42f5vfwrU+?=
 =?us-ascii?Q?NKR7b/qzSeioeJeNcTJUF22oW+rAcUCv4u9BsGoHAb+Qaeg5PGDLuusT7WY5?=
 =?us-ascii?Q?1obtLABZkCsP4KfjkNujhmB2SL45mj7EGAgh+E+JhK7QdcFdxuXNULMy0Y+c?=
 =?us-ascii?Q?45vcLUO8JKZNPFEP94OFNORA7HbR9sCv9xYOHvisC8fj27w8rxn968TliqI2?=
 =?us-ascii?Q?4lwSLzC6CaJMwvFbc74brAlR/ZYVjicMzWd7ue2qcYqF8fU8+npFO6tera8h?=
 =?us-ascii?Q?JHVO7U4V3BqxGvlZ512QT6u7ebCyt63NdF7nEnADXxreBR6r5yKNRYQaWHAR?=
 =?us-ascii?Q?5q3F+F29gXLP/RP0rV+7ZQ6w2+1ugkbBqw75/1Khz5egtptAoKgeSaCcoRE2?=
 =?us-ascii?Q?VmcCxc6JyTHjMFBAHT7RhIHpUyj13i3gtnE5D8Msw5w1LmNHX8YXU2Yuf0VP?=
 =?us-ascii?Q?+cGLMLEQfaiUs1hvmmNTDQTjyH2U+uR1BEyQqluGHXckasWDJ5eJJNwXQG03?=
 =?us-ascii?Q?Xhvbc8HHck8LTFK6lAQ0Q2620R35TansNr/TloOyTzo1MaE7ytyWfqgO/qMw?=
 =?us-ascii?Q?g4t5hb9+warW8H4p4pvF78vD7V0G3gIN86iy2/gCEeUJZmTchFJFVRk8gzbO?=
 =?us-ascii?Q?uYuJEj/+NxSBOhnng+o7a2C49bq0zXQxUb2Y8tzT09fQ+svSFfieuiC9fkNS?=
 =?us-ascii?Q?k7EAurqjImvQSyNOyBrcEfIvPIe26FJIlHhqBoPLbz3jHe0ISfRGkw2igae0?=
 =?us-ascii?Q?lpprNaVeidSUkC11ivbSdIEWlyy19ak3wvOEbk9nRlzKQTt1FT9YTtb72rNT?=
 =?us-ascii?Q?5S8UMGg1foJM7XPI/fgFBhvQpXAJYqm3xf60KEPTPp3LycNwRJKvls6IN9MZ?=
 =?us-ascii?Q?fzy1RzcmzVlbKfINJx+eoCtw5NyTyeD2d3b3DGHjgixXjR2SaczAoVsziOOh?=
 =?us-ascii?Q?L/cTURPn3LSvfhSjF6ih1Q3shXoSlKs+qLNooHHde4Y95S6ktVEUDEklaG8d?=
 =?us-ascii?Q?lx6krkrA0+vM7ELHwyf819qwCNvlWh+/n9r3M5mCMlRXHZRMebi/HJAjH8OL?=
 =?us-ascii?Q?PklyDtyUAnv0BSNsdesF03Xbpn+1Drkgo1Xl93AqRvt49yc5uTMdPPQn4m2r?=
 =?us-ascii?Q?AMi2wrYGZD0oyy4vpzzQijvL/4eyJSh1KVALcscK3+XEzQiA/WFzx1IyCfvv?=
 =?us-ascii?Q?fXXQsV+lr4QOcx1VgHpZJbX483LV5p9hM2I7s8l6I7fsJjVp+fIWYLlop+FO?=
 =?us-ascii?Q?uc13nm3JtIRlaWilUZt3KVZHbjYSDC58ojepMRCi2qvaspoVMSTebjhXxQ17?=
 =?us-ascii?Q?DQrZVW0WPllly7gVBLCMcaiOv3TNapP5Uw7+GLiRYyXgL3uzEM1AyfNn99Rh?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c74502-0e66-456b-a45f-08dbea7184d9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:09:08.4998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh05Acx79BekeI+DIYSXryFKZlZAzGY7rAO9HiHR+u3yoChCRuOAZOTK8TFtKJ+1Z4aQ9WazoHb0BX/J9mbGtiKgdZX02YGdeE7oiu40t3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:49:28PM +0100, Christian Marangi wrote:
> On Mon, Nov 20, 2023 at 06:15:43PM +0100, Larysa Zaremba wrote:
> > On Mon, Nov 20, 2023 at 02:15:40PM +0100, Christian Marangi wrote:
> > > soft_reset call for phy_init_hw had multiple revision across the years
> > > and the implementation goes back to 2014. Originally was a simple call
> > > to write the generic PHY reset BIT, it was then moved to a dedicated
> > > function. It was then added the option for PHY driver to define their
> > > own special way to reset the PHY. Till this change, checking for ret was
> > > correct as it was always filled by either the generic reset or the
> > > custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> > > phy: Stop with excessive soft reset"), as the generic reset call to PHY
> > > was dropped but the ret check was never made entirely optional and
> > > dependent whether soft_reset was defined for the PHY driver or not.
> > > 
> > > Luckly nothing was ever added before the soft_reset call so the ret
> > > check (in the case where a PHY didn't had soft_reset defined) although
> > > wrong, never caused problems as ret was init 0 at the start of
> > > phy_init_hw.
> > > 
> > > To prevent any kind of problem and to make the function cleaner and more
> > > robust, correctly move the ret check if the soft_reset section making it
> > > optional and needed only with the function defined.
> > > 
> > > Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/net/phy/phy_device.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > > index 2ce74593d6e4..478126f6b5bc 100644
> > > --- a/drivers/net/phy/phy_device.c
> > > +++ b/drivers/net/phy/phy_device.c
> > > @@ -1235,14 +1235,13 @@ int phy_init_hw(struct phy_device *phydev)
> > >  
> > >  	if (phydev->drv->soft_reset) {
> > >  		ret = phydev->drv->soft_reset(phydev);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > >  		/* see comment in genphy_soft_reset for an explanation */
> > > -		if (!ret)
> > > -			phydev->suspended = 0;
> > > +		phydev->suspended = 0;
> > 
> > Are you sure 'suspended' should not be cleared, if soft_reset fails?
> > 
> > >  	}
> 
> Idea is not change current implementation... And before this, suspended
> was cleared only with reset not failing.
> 

Ah, OK. I should not do reviews that late.
If the change is purely cosmetic though, I think Fixes tag does not apply here.

Other than that:

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

But I am also not certain, if maintainers would take such small of a change.

> > >  
> > > -	if (ret < 0)
> > > -		return ret;
> > > -
> > >  	ret = phy_scan_fixups(phydev);
> > >  	if (ret < 0)
> > >  		return ret;
> > > -- 
> > > 2.40.1
> > > 
> > > 
> 
> -- 
> 	Ansuel
> 
