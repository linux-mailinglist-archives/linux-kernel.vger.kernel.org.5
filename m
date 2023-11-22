Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDADB7F4F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjKVSSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:18:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C110C;
        Wed, 22 Nov 2023 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700677116; x=1732213116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=svTDrfhedEEO4cS0JxYCtXk8st2z98h4kZKY2KNo7V4=;
  b=WPwRLjPtkKLuwQXddGSTNzPuYEDbcMUtPIFHUDl2Ioglp+uM5X1yYv84
   hNq+oHBl4Kc05gcdY2zicdpkWyyd9OlPVVeHJ17WU9/q5AJdQR9nBCww7
   mfBq6PMXEqxcBXSYRhgXnknOyJ+9nD+JenULOGSVazjN5ubAtCWu48rWc
   gafMMPq3pqPPHL5hUUWccNMQwZaz678u61WmJgQVyDZP8aX7SO2Is4Mg+
   Pi93J8Q2citnhv3Vv7pAF0cu+hnQNkdKVu3rCAyBYkM6PysxocGhrbpjn
   gtn8dVB0cOI+sBiCcKCZgxu9Au55VQNevxdheG+oIsXw9Y2IgRj1VQuh6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423209508"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="423209508"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:14:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="760383292"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="760383292"
Received: from unknown (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:00:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:00:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:00:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2BlqVKSzSetQr/Z8LEbUMG8rgxoRfNOwvU7tA9q9YF/H3trBk0DZd/h7z7fgoU0han6TahRo2W+sKd0VDTccDIRB7VXQrJh9F7E52qOXpaHAYbwC5/OMHdJ+hLPJ9tv9AlA8Ghg0X8HBYGtXbyt9FUXbWa2rG8qXhgXVYiHpnvc6A/Bt7uY26c14HsTMzbrBMNrezZIdDpiJvfm2vE3pQvUFL6rEZ2slHzatYsVQHN2NYWbJYDAn5TkOohiR6c2solDYDK9WcT2e1VR4nxblocg3mun3kFyzX+D0qcD979bQagko/RF3EsNEEdY3Rqh2XY+QXbFCG1agk0g9n9pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPVanqrzgo1b4Znoo4RVkcMQ3ATyqa1SVIXuOlNdHx8=;
 b=iuI4zihdrgRwxBYplGhwopsfqP/59ZPMlEUq/kIR0/PNrmkCoqse5vTLsAURmoU7SLL6b3tw4mqVL8CiMC/Cn/faEm9hsL8U99TsUAk7qwHnwJ1+dBCY1YBLFU4ycHctOgJDHUWo+WWvZg7G8q1mfu5AsTIZrH5+2/lhEnZQUVZtGIn9Fl5+Y8DGdYHQWlDCyO6aQEhzleYUK2N2OYpwuzZNIMp/BC34jUnsnHNLGPgysuQ5dXJ2QfgRCfohJtffTx+blrMTLyXLwjs1O6kGFdgoA/lgWpZi0aClrCo8cVP2CO8XAZ2MpxARl7LMZDQQjuPoCUM/r6r5gSb+4wKF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 10:00:03 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 10:00:03 +0000
Date:   Wed, 22 Nov 2023 10:59:53 +0100
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Looi Hong Aun" <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: Add support for
 HW-accelerated VLAN stripping
Message-ID: <ZV3RGbALTGA+R9FZ@lzaremba-mobl.ger.corp.intel.com>
References: <20231121053842.719531-1-yi.fang.gan@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231121053842.719531-1-yi.fang.gan@intel.com>
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbcbebe-5890-4f19-45e9-08dbeb41cbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJgQ5pEnVI11jfG3tCyAkgv7NtkQiSReyfVZHpkylBDPGhTpLX0UEUQ9dpOOSIvJfvRNUJv6HPQRGW+6nfSqWXagmo4Jnq2pg2sEVd/HXLeDl7B+8ypJ7JB/mOZ2B41dFqAasfyHJuxJPelAMIm3j1RXtdb277hj9Ni9Vf0siAZQQpAatE/NUsajZ9cCjwmfAScuG/C/iPD2kq2SjMk/hAlJ5yga3NGzS+t8B6cAzY9lUMqXg89p6pcnXTahX3AKXySzLeoljNtzm6OZFFotomITK2yhEvArqU9HXj+Q6jYC5IFsydZNNVoQb+4dDEBzBwac+9etSRSpFm3x7OtdgP4RdGCbwwTTO3qZwaidbvCKbrR6dI/Axd4obaUl4M6nd5G48tV4KRjxEMVNUqCcd+8SnyCZ5aI5LjO8XvZbCz6CpcT1E3Id6VbgEzVk1dtHOqpqlKufEKPHxiUd1aK0gTNiXWy97RC9TEU/DAdxGvkkQtzz3yfgwC5qhejaclEDT4RYWRn4O42XmjPQChWjLT7fuhpPknmZungJ6GhYIYgoj+It7/vnmyrZdKox0k/racOMLhc/a5HUi9N+zaoD/twxZ9GGdc8IaTAiCqESVDoub+v+IflbnUbtpuK8qHibiR4GB8qlZOyzuXAfAIhQTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(30864003)(6666004)(86362001)(2906002)(7416002)(5660300002)(83380400001)(44832011)(8676002)(6636002)(66946007)(54906003)(66476007)(66556008)(6486002)(6506007)(478600001)(316002)(107886003)(6512007)(26005)(8936002)(38100700002)(4326008)(82960400001)(6862004)(168613001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/qwDT62DG8+gYpo4uG/zEjm1hbDxc2v/eTLeGMSzZl5zm3806JpnIwhG3vq1?=
 =?us-ascii?Q?Jt1GYsp00e6P+Kx4m9S7qPfMBc/vlIGtEVV4d/qHcMoppKe16NyJ1wwzXw2a?=
 =?us-ascii?Q?wHqtEiWYIb3M0jHzNT3t3UphmyndfzL5Mzv5pjsMHDoGPyq4bL/Pw200iVxE?=
 =?us-ascii?Q?rRHTEVw2A9C61edYF83ldKjrhTnoawW/imA/EjyjsZjCc8IV6N6PwenDChmr?=
 =?us-ascii?Q?uCMsQT0CreS7fjSMcVicE0Wbqnv4SDvGX1ZNV0fHsho9rawNLLKGBWLc558i?=
 =?us-ascii?Q?Ga/K1GVGWQY6qWNUykbkPtOtsBu/hpQDCDDlKzIy0AO13iKq/TF7R7rtxi4y?=
 =?us-ascii?Q?0lVZcdhW0n6PiZYEf+YcAgI4EI7MGG+rBGyMZvAiSzEilpQ6mbipbJ9F6pR5?=
 =?us-ascii?Q?i0TkbwjQ+umDR8WehwD00WF7s5txoXzdhcXRCZHnoDf7Vqu48FVM7dbOS2ZY?=
 =?us-ascii?Q?sXa1jaafQX4a5tmNAOt9WbfzJ+0P29gUk7CGycVSQoacol27w/PZ7QVFqTZ7?=
 =?us-ascii?Q?NiB8tbI29j2V3e/nr4Zhk3MjafDhJlakwunL+/kc1f3HeqePA7fe3V1gOXHg?=
 =?us-ascii?Q?qHlwV3tgCBQz/6P1dnQxmwhjClgt+1PTbTpgsmWxdaKM0VlwYOmr6J7CU0Xr?=
 =?us-ascii?Q?B7cjMQUE92MWZy8syV/2k7TE1sjO71kIajnqxZeCcBuvLUatA440HDbUb1Oc?=
 =?us-ascii?Q?IFDNfJql69KfCwkxK5WhI5kQdBH+oVhm1rjryWcIBpa/2odQ6ksHO+CqMRa4?=
 =?us-ascii?Q?Mafs5Ie6RqID3SD4ruB3Z9K9DvX4wnRQJQz+ptlP7/ze39HdMB7j1ttP6XLv?=
 =?us-ascii?Q?zTMeyT5tnRwvgUbs6SqGlBuv6CGQId8+NAlNs3mt6wxDuMnncSoq0qII0zem?=
 =?us-ascii?Q?5YYTscwJUYkCBhRv4EnY6PGxyHc6NjcoCSfHFwQZqqIDw9Y42m0HfB4o08G4?=
 =?us-ascii?Q?TWXKwN/oqk/QTT6tJJPgLjBZSZWUjk1ppcnQtlUotxPuOMVTfy0LPDC0tEFD?=
 =?us-ascii?Q?ZdHzmfAy1OAsxYdXv9t6A0ayIyJm2PDiwrH7ezLeM4V3oVx1eSZW4W/eoqkH?=
 =?us-ascii?Q?OtgfaUnOZ4cURNV/jMYYAB5fcSeJasbbO7AmFl10XpYWoi9/HQjxziuctT2a?=
 =?us-ascii?Q?aeyK07O7bxgRKBn7tIagOb9JF0nJDiCk8tEJEFydVgMdSFXzo+e7HJA7oSxc?=
 =?us-ascii?Q?dkruU4g9Ky+3LBCFUIQekK/JLqab53OkZB6K2847b/s7sWBDqwBq8PAn5SKu?=
 =?us-ascii?Q?7hs5sXuRmiMjGK2enqRSkYJxWA3sr97+pr1gsdDFWgchglrNWdO8P/tPfT56?=
 =?us-ascii?Q?ihLuh2s8B0sMnh68RkKGN3i9vbPDJ183L+pCSZ8ew0ZZU8KV9ahFxn0krjS5?=
 =?us-ascii?Q?fJth/SdnMgyjYaxNMJh+XHGbU/YPLWFFbdE8QWA/ZcRwRkBUazLMSc8pW0vm?=
 =?us-ascii?Q?D9HsqK/eTUJCfE72dVP9/5f/kDGAfNRnFq2jwnUrWHh1h/ztc0iKg9KZVtpd?=
 =?us-ascii?Q?2LQkrIAsP5H6s1cMHp0NQlqbaFOlNZLH5FDRaHD5mQWtVCN4V7KjmMHviQsU?=
 =?us-ascii?Q?hiqfNs/2CFubVEnXa2uJeQqrugyDsl5bIRkAw0ldIYFdjgaMuBNzzlVQRIl2?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbcbebe-5890-4f19-45e9-08dbeb41cbae
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:00:02.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcEk2hq7wlxfCCwuQC5CSkBsjxGIsU3s0e1Dd+I1bn4LjStqcgRbdYZyzEo8txitRA6qlih0BzthRkT3akH9wVZpDuvMA/QuSVnBa+3laLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:38:42PM +0800, Gan Yi Fang wrote:
> From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
> 
> Current implementation supports driver level VLAN tag stripping only.
> The features is always on if CONFIG_VLAN_8021Q is enabled in kernel
> config and is not user configurable.
> 
> This patch add support to MAC level VLAN tag stripping and can be
> configured through ethtool. If the rx-vlan-offload is off, the VLAN tag
> will be stripped by driver. If the rx-vlan-offload is on, the VLAN tag
> will be stripped by MAC.

if rxvlan is off, tag should not be stripped at all. Code itself follows this 
rule - stmmac_rx_vlan() checks features, but the commit message is confusing. 

> 
> Command: ethtool -K <interface> rx-vlan-offload off | on
> 
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
> ---

No info, what has changed since v1.

>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 35 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 13 +++++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    | 15 ++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++--
>  5 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index e3f650e88f82..6b935922054d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -580,6 +580,7 @@ struct mac_device_info {
>  	u32 vlan_filter[32];
>  	bool vlan_fail_q_en;
>  	u8 vlan_fail_q;
> +	bool hw_vlan_en;
>  };
>  
>  struct stmmac_rx_routing {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index c6ff1fa0e04d..5f35faf90963 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -1134,6 +1134,35 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
>  	return 0;
>  }
>  
> +static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
> +			      struct dma_desc *rx_desc, struct sk_buff *skb)
> +{
> +	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> +		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
> +
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> +	}
> +}
> +
> +static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
> +
> +	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
> +
> +	if (hw->hw_vlan_en)
> +		/* Always strip VLAN on Receive */
> +		value |= GMAC_VLAN_TAG_STRIP_ALL;
> +	else
> +		/* Do not strip VLAN on Receive */
> +		value |= GMAC_VLAN_TAG_STRIP_NONE;
> +
> +	/* Enable outer VLAN Tag in Rx DMA descriptor */
> +	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
> +	writel(value, ioaddr + GMAC_VLAN_TAG);
> +}
> +
>  const struct stmmac_ops dwmac4_ops = {
>  	.core_init = dwmac4_core_init,
>  	.phylink_get_caps = dwmac4_phylink_get_caps,
> @@ -1175,6 +1204,8 @@ const struct stmmac_ops dwmac4_ops = {
>  	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
>  	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
>  	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
> +	.rx_hw_vlan = dwmac4_rx_hw_vlan,
> +	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
>  };
>  
>  const struct stmmac_ops dwmac410_ops = {
> @@ -1224,6 +1255,8 @@ const struct stmmac_ops dwmac410_ops = {
>  	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
>  	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
>  	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
> +	.rx_hw_vlan = dwmac4_rx_hw_vlan,
> +	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
>  };
>  
>  const struct stmmac_ops dwmac510_ops = {
> @@ -1277,6 +1310,8 @@ const struct stmmac_ops dwmac510_ops = {
>  	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
>  	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
>  	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
> +	.rx_hw_vlan = dwmac4_rx_hw_vlan,
> +	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
>  };
>  
>  static u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 89a14084c611..1c5802e0d7f4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -198,6 +198,17 @@ static int dwmac4_get_tx_ls(struct dma_desc *p)
>  		>> TDES3_LAST_DESCRIPTOR_SHIFT;
>  }
>  
> +static u16 dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
> +{
> +	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
> +}
> +
> +static bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p)
> +{
> +	return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
> +		(le32_to_cpu(p->des3) & RDES3_RDES0_VALID));
> +}
> +
>  static int dwmac4_wrback_get_rx_frame_len(struct dma_desc *p, int rx_coe)
>  {
>  	return (le32_to_cpu(p->des3) & RDES3_PACKET_SIZE_MASK);
> @@ -551,6 +562,8 @@ const struct stmmac_desc_ops dwmac4_desc_ops = {
>  	.set_tx_owner = dwmac4_set_tx_owner,
>  	.set_rx_owner = dwmac4_set_rx_owner,
>  	.get_tx_ls = dwmac4_get_tx_ls,
> +	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
> +	.get_rx_vlan_valid = dwmac4_wrback_get_rx_vlan_valid,
>  	.get_rx_frame_len = dwmac4_wrback_get_rx_frame_len,
>  	.enable_tx_timestamp = dwmac4_rd_enable_tx_timestamp,
>  	.get_tx_timestamp_status = dwmac4_wrback_get_tx_timestamp_status,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index b95d3e137813..1d424c9bf037 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -56,6 +56,10 @@ struct stmmac_desc_ops {
>  	void (*set_tx_ic)(struct dma_desc *p);
>  	/* Last tx segment reports the transmit status */
>  	int (*get_tx_ls)(struct dma_desc *p);
> +	/* Get the tag of the descriptor */
> +	u16 (*get_rx_vlan_tci)(struct dma_desc *p);
> +	/* Get the valid status of descriptor */
> +	bool (*get_rx_vlan_valid)(struct dma_desc *p);
>  	/* Return the transmit status looking at the TDES1 */
>  	int (*tx_status)(struct stmmac_extra_stats *x,
>  			 struct dma_desc *p, void __iomem *ioaddr);
> @@ -117,6 +121,10 @@ struct stmmac_desc_ops {
>  	stmmac_do_void_callback(__priv, desc, set_tx_ic, __args)
>  #define stmmac_get_tx_ls(__priv, __args...) \
>  	stmmac_do_callback(__priv, desc, get_tx_ls, __args)
> +#define stmmac_get_rx_vlan_tci(__priv, __args...) \
> +	stmmac_do_callback(__priv, desc, get_rx_vlan_tci, __args)
> +#define stmmac_get_rx_vlan_valid(__priv, __args...) \
> +	stmmac_do_callback(__priv, desc, get_rx_vlan_valid, __args)
>  #define stmmac_tx_status(__priv, __args...) \
>  	stmmac_do_callback(__priv, desc, tx_status, __args)
>  #define stmmac_get_tx_len(__priv, __args...) \
> @@ -388,6 +396,9 @@ struct stmmac_ops {
>  	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
>  				 __le16 perfect_match, bool is_double);
>  	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
> +	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
> +			   struct sk_buff *skb);
> +	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
>  	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
>  				   struct mac_device_info *hw,
>  				   __be16 proto, u16 vid);
> @@ -497,6 +508,10 @@ struct stmmac_ops {
>  	stmmac_do_void_callback(__priv, mac, update_vlan_hash, __args)
>  #define stmmac_enable_vlan(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, enable_vlan, __args)
> +#define stmmac_rx_hw_vlan(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, rx_hw_vlan, __args)
> +#define stmmac_set_hw_vlan_mode(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, mac, set_hw_vlan_mode, __args)
>  #define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
>  	stmmac_do_callback(__priv, mac, add_hw_vlan_rx_fltr, __args)
>  #define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2afb2bd25977..0323d5ac20f5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3469,6 +3469,8 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  	/* Start the ball rolling... */
>  	stmmac_start_all_dma(priv);
>  
> +	stmmac_set_hw_vlan_mode(priv, priv->hw);
> +
>  	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_start_wq(priv);
>  
> @@ -4993,7 +4995,12 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  	}
>  
>  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> -	stmmac_rx_vlan(priv->dev, skb);
> +	if (priv->hw->hw_vlan_en)
> +		/* MAC level stripping. */
> +		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> +	else
> +		/* Driver level stripping. */
> +		stmmac_rx_vlan(priv->dev, skb);
>  	skb->protocol = eth_type_trans(skb, priv->dev);
>  
>  	if (unlikely(!coe))
> @@ -5509,7 +5516,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		/* Got entire packet into SKB. Finish it. */
>  
>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
> -		stmmac_rx_vlan(priv->dev, skb);
> +
> +		if (priv->hw->hw_vlan_en)
> +			/* MAC level stripping. */
> +			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> +		else
> +			/* Driver level stripping. */
> +			stmmac_rx_vlan(priv->dev, skb);
> +
>  		skb->protocol = eth_type_trans(skb, priv->dev);
>  
>  		if (unlikely(!coe))
> @@ -5818,6 +5832,13 @@ static int stmmac_set_features(struct net_device *netdev,
>  			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
>  	}
>  
> +	if (features & NETIF_F_HW_VLAN_CTAG_RX)
> +		priv->hw->hw_vlan_en = true;
> +	else
> +		priv->hw->hw_vlan_en = false;
> +
> +	stmmac_set_hw_vlan_mode(priv, priv->hw);
> +
>  	return 0;
>  }
>  
> @@ -7516,6 +7537,9 @@ int stmmac_dvr_probe(struct device *device,
>  #ifdef STMMAC_VLAN_TAG_USED
>  	/* Both mac100 and gmac support receive VLAN tag detection */
>  	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> +	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
> +	priv->hw->hw_vlan_en = true;
> +
>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
> -- 
> 2.34.1
> 
> 
