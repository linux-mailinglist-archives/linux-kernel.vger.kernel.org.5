Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E537F198E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjKTRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjKTRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:16:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34303BE;
        Mon, 20 Nov 2023 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700500573; x=1732036573;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/ChevFhs/66mzNQ4S+/3K1QgdV95MoStheImYSXBb1A=;
  b=KHPp8CpDkeaEEt7d6pELaTzmWuMEf8Sor/Pq/NTEOr2xnEdskkRMRtMN
   HL6pJ5BpETNH0U/uGHRrWziL4LCNEvAJqjOB1v0lsejforlWWxfdtjMeV
   ciPQtpFNtcB+DlbsXd36bz/tkMFMa3WVxscIoUm4J4WRCV/at387GCDnL
   ZRatXucVoCM7q8s+/1ZhaZpOET/8Xi4VKnD+p+q8D4XKN63EPCSnkvsDx
   lnrm2E+YLwzRg8A74l3/pfn26Q1TgxOuN+T112Gor8QFBMUueqoHV+ADZ
   Dw1ylfroOv3ghtbZeHWFozKT59UyGgM3Kn0cNstlKvlmDOP5o2Rm2M+wi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395590595"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="395590595"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="769971902"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="769971902"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 09:15:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:15:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:15:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 09:15:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 09:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrJ45S7Glkb1tC405suYsIC173kM8uP2CBMtMdLuPhSf1aXlC7eAdyhHhI6D9lr9TSW3Jw05IhnsdpH/Gm24O4j4NDbZnegA3XAg9hr7Z1ZYDHuzTbHrisyIn4SV8UHrjkVmDTkWT5BCX6HQHOGZtoQfar5bZuUb5jHj1XeK/HHlTq8/K/rokJ6bzZOCTat8h29xQ2sClHxw2WZk7s7Mv9pMaysYLfTHdr1qESz9TFYqiBdabw/ei0Xp7/WG4+SuTepTto+gATnUSmjjyxE6TEl2GqJLQooIZ509o6Zaoac/PNsKlTbFYTOSLBcQz4W/WX0688XHTcTvVHHNJWxz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yKqfaa+Wur3Ni4/aIw6fxdVsShUkgam79TASVlgUNY=;
 b=kv+njQ5s4d/qDTJ4CMXn2knxyccHqaNMneljtbKx9Z9xDJs8o2LTJaOIddZ9asYN3Vhw4K6c7G3YlRmbGOw9ag+Y/Y0SCCoEg0+IP0M0GkJG3pp000Wno9PznielSF3tZrjTZZbguMt4Sl9FbQCiqQo4NhkMMOcayTQprytVgWO8dUW0MhBeLuHfNQkW7Vf9Z7vfa5cI1Kaqa9+ohKNZuICr+NJ+iYboUeRLanmH4aVnI9QKFt4C/J3QeNU5k1U3bQIS3KTt6HW0cPJaq/fmIMEaJqzuIa8z/dU1ZO3UPzXA+IBHSCy6OEcRIvfA8Qjl3cYi5MEmzWfgvp2Wdy/Nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:15:53 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7002.028; Mon, 20 Nov 2023
 17:15:53 +0000
Date:   Mon, 20 Nov 2023 18:15:43 +0100
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
Message-ID: <ZVuUP797C4PLzJsP@lzaremba-mobl.ger.corp.intel.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231120131540.9442-1-ansuelsmth@gmail.com>
X-ClientProxiedBy: FR5P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB4784:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1f201e-4b6a-4099-60d8-08dbe9ec59b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYhy7UW+BlVyjJV62L3cRyhiPRP+PfVxy7nZyyn2qFxIvnr2SH2p6OM8fLkCt0am2jIeind2Dt7ks/RQ46p9z9QktNrG9RJXK0gS+6OPBzdL7INKI+TGjqCPGEwutqBLw5W0UuUiT7A5UZQGyagPSv1KHUpQ/XeIQAt2EF7/h71iXGmwt602dMoL1vacDXB7HL5vP4Xct88QgH50irHsknthiOZKZf3jPhYk2dL0r8Mc1Bkj9xN78x4nuMrRc08Ig6y3aQe+q9up66SIiDcd4eE7CKaMrO5MbTxo+gpsL6kwY+etloenwhfAkfCbJxtWWzepll5STOEmngrMeAIQpQe3LDeyhF548xWkXo+o52oRxP27Tk6K+ZD5bR8CzFQ+rHcK2+JkfjCBK2+3D/EGzi1vkQ5ShSQsedBk0crnTXYS5AS9pZBNbQuzaEm1RqJPC51RG9qeCkOnQLFJh09Hea9zvaudfc2+3kZCMDJUVKPMBLZD+j8cWeCRZHcdbm+JHC+X6pwZZASrZLIUy4LwG2H3Xe5faicTgmfR5efBafyjdp0HoZgmET4paTo3CW1a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(44832011)(5660300002)(7416002)(2906002)(86362001)(6506007)(6512007)(26005)(82960400001)(83380400001)(6486002)(478600001)(6666004)(38100700002)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(54906003)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWbDJHgAg4nWAimQNMMBxcsGj1OjhLQBZAKD1PPfPl8wWCUArPon9bIdRxfu?=
 =?us-ascii?Q?Q5UYM0ML+a5EnY02HlKvU0sXE+EWMMMlDz9dVRguiK/2UfUBQl4kjoFk5Go2?=
 =?us-ascii?Q?VxWfuIaDo/c6IGt82FipB4lwSs1IHZtpP2fToHwDzhgd8kXhfz0+HTBf2Y8U?=
 =?us-ascii?Q?ip0JfwRSSaPuygfxUhoTR8YA5LQsAv8TagZcjmAKksz4afMS7mp9L0mTY8AO?=
 =?us-ascii?Q?AuP+Z6IKIPlbMYFznmUMJh2Rvf/wKGbgM/raSOuhy10V+JaZGikOvrXi5ADr?=
 =?us-ascii?Q?t9OEqTKkb46kR60UH78bLVNkElAyUfGdveg4H4ICcGUHToNAa658gKIWsv6f?=
 =?us-ascii?Q?d7x6+jaJz3x+YZVOd8hCRdyaldh0ho60DIg6+m8T6qpTlEtmou1DmJ+AADYg?=
 =?us-ascii?Q?X3EkJnlEex7I5kKF3v4WSTtyv0jgDgI+ppkfks9ruWHrGWNcmdUA1InW5tz1?=
 =?us-ascii?Q?/DHSAJo9NLSqHuHqCAeIVBcyubXIg3WpL/0gd0QwnOeTvwtwwtw07ko3+kZb?=
 =?us-ascii?Q?uqNCGU+fmOFgISPP4KOZciwBczNQk8J2JxlQhp5Sno5IjrpDn8hhbdr3PsRC?=
 =?us-ascii?Q?c9mLF8OUGL6D7Ro6eod4/mnIhZDBHrntHnkv3LcQTcdWz6hmfwTy9RIwwEaN?=
 =?us-ascii?Q?mHt32m8Wv3Npnd7hK9m3vvpbwgv0gG2V1Xm73WxyecCmBnwD0lhbBjIgj+de?=
 =?us-ascii?Q?99BPRbrav5ZlJ96Iv/wELSvYuiQLZ0N9HyoysZP1ncybdpOfAIcdbVgUWapV?=
 =?us-ascii?Q?kx8mx0Pv4BVumWwOH4GaKQDgJ4MvpP9j7Q6d0Zwy3dnQHOZBdmW002pez7t1?=
 =?us-ascii?Q?f7iQWpd5E6AJ+kAg3sWL1Y4LIb5uYXwWMhTtEKzUGFCh0W4Q/HovaQ7XCK/t?=
 =?us-ascii?Q?qlZUgj1IqnWpQd2bahBMEGaRTo/E1kj1cR5JQb/8UQEVXQPKQMMwqsv9Oh1t?=
 =?us-ascii?Q?6BbudH0wk/r32WJTDbgsdC3TxjgRsSICh0Cz9EniL7cbm/JWG/nu+wkyr7Yc?=
 =?us-ascii?Q?Kr69aCoC3QWRrkc1yQH6TqYaOYaCWhCf4OIvH02A5vUG+b0ITXDo96dktXZh?=
 =?us-ascii?Q?Cwfr4SfeVJWxk+jfjyp9h7DG1gUsgNqzSPQWgr8qE1TFAXceGwCErk1aroez?=
 =?us-ascii?Q?xPixuKgom9ixKeqXrTnO1GmoM/uQdCHDtkRn/IuDYlaqp+wP4AnOJCmwIk5l?=
 =?us-ascii?Q?azOYXNd/JIz5PTvvSk7sbbCxbt+FqNTQix67Hmak/a9rjzgfIKECY45DkZmB?=
 =?us-ascii?Q?dOqa2IMVFFh6xwsIHzmqLU0qpoFcZMGrGTaS1pu02iVlIB/XkKcjEqcDps98?=
 =?us-ascii?Q?FrI4BtgO8LzSxgT8dI1VjP9Nd2MJc5Pw4jiB0Ddl2BN/B/bTbtu/sh6KA/Uv?=
 =?us-ascii?Q?J2kEnAKwua0HZNxdC0SwpsN89LMhwG57J7L4byn8/I5dqcaxkhCaUGkQxJS5?=
 =?us-ascii?Q?Zo8duitT29WjMeDKaRvDms0SYGlXsQJguIjALIz+AO5WntnmsEhJXE9vkymV?=
 =?us-ascii?Q?lvd55/v8fNT9riSA1x0CKQzWdH8FbFHyobadN/APehVA4zXZLEJyf3lufHOI?=
 =?us-ascii?Q?l/EoyprS6+qlaTwrUa2lKdU+toIkUB7jDYZ85Rho+4l/QZnolPYgB7Asx9Mz?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1f201e-4b6a-4099-60d8-08dbe9ec59b0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:15:53.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py/uQep/9yOa9y+In6E8C+78K/hKsFHk2LMxtlT557XBOCzqFLMU3NsyPvhcXkUHKmwER5aXMnoQxwYsr7InrssUCs2hFfK84gOi0GrSaaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 02:15:40PM +0100, Christian Marangi wrote:
> soft_reset call for phy_init_hw had multiple revision across the years
> and the implementation goes back to 2014. Originally was a simple call
> to write the generic PHY reset BIT, it was then moved to a dedicated
> function. It was then added the option for PHY driver to define their
> own special way to reset the PHY. Till this change, checking for ret was
> correct as it was always filled by either the generic reset or the
> custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> phy: Stop with excessive soft reset"), as the generic reset call to PHY
> was dropped but the ret check was never made entirely optional and
> dependent whether soft_reset was defined for the PHY driver or not.
> 
> Luckly nothing was ever added before the soft_reset call so the ret
> check (in the case where a PHY didn't had soft_reset defined) although
> wrong, never caused problems as ret was init 0 at the start of
> phy_init_hw.
> 
> To prevent any kind of problem and to make the function cleaner and more
> robust, correctly move the ret check if the soft_reset section making it
> optional and needed only with the function defined.
> 
> Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/phy_device.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2ce74593d6e4..478126f6b5bc 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1235,14 +1235,13 @@ int phy_init_hw(struct phy_device *phydev)
>  
>  	if (phydev->drv->soft_reset) {
>  		ret = phydev->drv->soft_reset(phydev);
> +		if (ret < 0)
> +			return ret;
> +
>  		/* see comment in genphy_soft_reset for an explanation */
> -		if (!ret)
> -			phydev->suspended = 0;
> +		phydev->suspended = 0;

Are you sure 'suspended' should not be cleared, if soft_reset fails?

>  	}
>  
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = phy_scan_fixups(phydev);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.40.1
> 
> 
