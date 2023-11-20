Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9317F0FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjKTKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B591B95;
        Mon, 20 Nov 2023 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700474652; x=1732010652;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Q5vDujUu2jQVmhCwOqd7SDr4yeZ+2NBNFFCi8xPFKlY=;
  b=bV3q0rqqbbrJyWKTKCN4gB1BcaBkK4a7w895lz4PvF8dalrT0iTcIzJw
   qPcEhISWJNjScj30pEoyrtyyoMF0vEhS7JEywIMZHsN0gNcDUsY5EJzCg
   XcI1JYiXCx1ZboofA/L6FnQ2QCBzbXZPk5ouFZspumVcL9Rfelh7RHM8u
   D8yG2Bb39psp8leC0dlpemtIC9jYfLfBKFn7p0ZC6DaN6hhbeC0CPcqq7
   WC0AhF27fbkqyOhF53tlu4l41hkJZ/geUrJXhBxXKCpe/54I2SZcVfY5a
   0ioJTIvC0Vp6Rg0+CL8TKYICPgn/DCc07Muq7P9HsIy5ATXdZgT7AyCcP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455914983"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="455914983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="889872771"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="889872771"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:59:06 -0800
Date:   Mon, 20 Nov 2023 11:59:04 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] rtlwifi: rtl8821ae: Reverse PM capability exists
 check
In-Reply-To: <20231117224407.GA95935@bhelgaas>
Message-ID: <34385eee-b08c-8ff9-db47-75c3d2be681@linux.intel.com>
References: <20231117224407.GA95935@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1927733487-1700473754=:2032"
Content-ID: <2366eb98-2abd-5792-be3d-ea2e2c2d16fb@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1927733487-1700473754=:2032
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9fa8dab0-fcc-f0b0-f269-af6933aa9b6@linux.intel.com>

On Fri, 17 Nov 2023, Bjorn Helgaas wrote:

> On Fri, Nov 17, 2023 at 11:44:22AM +0200, Ilpo Järvinen wrote:
> > Check if PM capability does not exists and return early which follows
> > the usual error handling pattern.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 45 ++++++++++---------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> > index 6ae37d61a2a2..53cfeed0b030 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
> > @@ -2305,30 +2305,31 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
> >  		}
> >  	} while (cnt++ < 200);
> >  
> > -	if (cap_id == 0x01) {
> > -		/* Get the PM CSR (Control/Status Register),
> > -		 * The PME_Status is located at PM Capatibility offset 5, bit 7
> > -		 */
> > -		pci_read_config_byte(rtlpci->pdev, cap_pointer + 5, &pmcs_reg);
> > -
> > -		if (pmcs_reg & BIT(7)) {
> > -			/* Clear PME_Status with write */
> > -			pci_write_config_byte(rtlpci->pdev, cap_pointer + 5,
> > -					      pmcs_reg);
> > -			/* Read it back to check */
> > -			pci_read_config_byte(rtlpci->pdev, cap_pointer + 5,
> > -					     &pmcs_reg);
> > -			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
> > -				"Clear PME status 0x%2x to 0x%2x\n",
> > -				cap_pointer + 5, pmcs_reg);
> > -		} else {
> > -			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
> > -				"PME status(0x%2x) = 0x%2x\n",
> > -				cap_pointer + 5, pmcs_reg);
> > -		}
> > -	} else {
> > +	if (cap_id != 0x01) {
> >  		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
> >  			"Cannot find PME Capability\n");
> > +		return;
> > +	}
> > +
> > +	/* Get the PM CSR (Control/Status Register),
> > +	 * The PME_Status is located at PM Capatibility offset 5, bit 7

> But this is PCI_PM_CTRL and PCI_PM_CTRL_PME_STATUS (with a word read),
> right?  No need for a comment then.
> 
> I don't know why the driver needs to do this, but I'm skeptical.  The
> only other drivers that look at PCI_PM_CTRL_PME_STATUS themselves are
> bnx2x and ksz884xp (ksz884x.c), so this is highly suspicious.

I hope you are not asking from me because I'm just the poor guy who tries 
to cleanup this mess. ;-) ...So all I can do is shrug and say, I 
unfortunately don't know the answer.

Hopefully somebody more familiar with the devices could chime in.


-- 
 i.
--8323329-1927733487-1700473754=:2032--
