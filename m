Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C287D4CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjJXJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjJXJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:42:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB08DA;
        Tue, 24 Oct 2023 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698140552; x=1729676552;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZABBBqBXwzWKXycM2zBL7WM0xuzkZT14L0Y1O1JUiu0=;
  b=kI+v3vrd2JizyRWN+D1PX5RCqBjlItssx1Xn67S7DU/ZiUvc+mzqER6M
   Vg886J3VZ6xPl72DqDrJKp+kv32bOBIpkXZmEzE4+RCkfddbZSj0Lt7ca
   o1g0p4QMrFnzBc5BB6GTAWvFww0gSn+4rP7DGcvv8exj1d9ApTauccaXe
   ESGld1okZpYF5aw6u6EDi1rYEr43h0PHeASMyAA2o218qpJBDuv851HPo
   VBJrmKVUKEE/YRApDay1yJXQpbX1L2l29iBAjm/pyHPT0MzNXyAl27Fr8
   3OGcRno2GCMtxBIKvmW1hmRBJCSZrpDlTuzSXYdL5ixhdPes//eW0IYlp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="367249296"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="367249296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="875013389"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875013389"
Received: from nkraljev-mobl.ger.corp.intel.com ([10.249.41.91])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:42:30 -0700
Date:   Tue, 24 Oct 2023 12:42:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Cameron Williams <cang1@live.co.uk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 06/11] tty: 8250: Fix port count of PX-257
In-Reply-To: <DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
Message-ID: <f21a942c-5f1e-3c1a-945c-358632edb188@linux.intel.com>
References: <BBPatchesV4> <20231020160412.118550-1-cang1@live.co.uk> <DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
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

> The port count of the PX-257 Rev3 is actually 2, not 4.
> 
> Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>

Please arrange your series such that the patches with Fixes are first, 
not in the middle of your series.

-- 
 i.

> ---
> For stable: This patch is only applicable to 5.15 LTS and up, other LTS
> kernels dont have PX card support.
> 
> v3 - v4:
> Split patch v3 part 5 into multiple Fixes patches and an Additions patch.
> Add Fixes: and Cc: tag.
> 
> v2 - v3:
> Alter commit message a little to make the additions/fixes cleaner
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
>  drivers/tty/serial/8250/8250_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index b0a632415d8e..59074a709254 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5180,7 +5180,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
>  		PCI_ANY_ID, PCI_ANY_ID,
>  		0, 0,
> -		pbn_oxsemi_4_15625000 },
> +		pbn_oxsemi_2_15625000 },
>  	/*
>  	 * Brainboxes PX-260/PX-701
>  	 */
> 
