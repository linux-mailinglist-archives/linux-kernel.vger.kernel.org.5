Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5E7D4CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjJXJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjJXJmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:42:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942F1998;
        Tue, 24 Oct 2023 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698140506; x=1729676506;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tVQ+svt2jXvzExnt2d/wwyQCA0p17A4isUzWQkmRUDo=;
  b=BtWA1/4rO/G+LzpzYAMCz7LLmnJk/nxSfWoyB/2to9Y2V81aJBMlidue
   ZFMnZpViAGgW/Uu5qdxxPZsEo/aMb0JSavwOB0AW6KPH5UhdHLmNW6BhZ
   2EQpldx0ijK9GJ4m2yMsoSS+jZ3oc1qvl5a7sJABKDdZV83L9+/P5XYgD
   aYYex9tt00BIth47PPBNmH2do9Tm0o776K8Dxk4a1+bE0P5FpspsOgucA
   wlXKi252JUO/15nK0KQ8dh4UtFRW4UFqfnppfOGtysZUNoaSxd1+IcWY/
   LiARgdWzTFx430wk+3hqTKI3O4kb6QMpOqKDKms3dCe3fQTqCcTL4WgcV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386831913"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386831913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751942077"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="751942077"
Received: from nkraljev-mobl.ger.corp.intel.com ([10.249.41.91])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:41:44 -0700
Date:   Tue, 24 Oct 2023 12:41:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Cameron Williams <cang1@live.co.uk>
cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 05/11] tty: 8250: Add support for Intashield IS-100
In-Reply-To: <DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
Message-ID: <201af1d6-b82b-5588-017-5d8a9050c458@linux.intel.com>
References: <BBPatchesV4> <20231020160412.118550-1-cang1@live.co.uk> <DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023, Cameron Williams wrote:

> Add support for the Intashield IS-100 1 port serial card.
> 
> Cc: stable@vger.kernel.org

Why is this cc stable? I think it should be dropped.

-- 
 i.

> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> ---
> v3 - v4:
> Add Cc: tag.
> 
> v2 - v3:
> Re-submit patch series using git send-email to make threading work.
> 
> v1 - v2:
> This is a resubmission series for the patch series below. That series
> was lots of changes sent to lots of maintainers, this series is just for
> the tty/serial/8250 subsystem.
> 
> [1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> [2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> [3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> [4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
> 
>  drivers/tty/serial/8250/8250_pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 1c46b65789c9..b0a632415d8e 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -4913,6 +4913,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  		0, 0,
>  		pbn_b1_bt_1_115200 },
>  
> +	/*
> +	 * IntaShield IS-100
> +	 */
> +	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_b2_1_115200 },
>  	/*
>  	 * IntaShield IS-200
>  	 */
> 
