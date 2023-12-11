Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A371980C78C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjLKLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKLAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:00:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E239A;
        Mon, 11 Dec 2023 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702292429; x=1733828429;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K2ZRRE7Thip/Geu7ekUKU80Z+uYC8shCVOa2AGk3EYA=;
  b=U5nxltGuCBMu4JjoCi0OeYxRB3rNm205kJngMw8osuKz9huei59Ngog5
   t9l6z2FMUWH+dbEINSt1afYQm4xOk5P1wmHnwQk4vooNSFRgDxe1598M6
   CuFyiojQLsxl3PtPCpfSL62ztJJqxSZBBbYUv3YSzKk5xsnhUliW+unxJ
   v9C6sIyAB6TVN5FGLnl7UoNR3juoekiCOU/TTa2vwEmI3TdVaoEkkRkmf
   gajgrO7zSUbYyPkIaJpkCZGix27B775YVbUmP6mBFkB+h1ZvXowNIg5BF
   dVprYNs1xqZo2Giy+yLv0tQ+3QaaAEq1rXhifAnU77qzp7tSMp0bfZK2M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="458940569"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="458940569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="14387023"
Received: from lmckeon-mobl.ger.corp.intel.com (HELO iboscu-mobl2.ger.corp.intel.com) ([10.252.48.111])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 03:00:24 -0800
Date:   Mon, 11 Dec 2023 13:00:22 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LinoSanfilippo@gmx.de, Lukas Wunner <lukas@wunner.de>,
        p.rosenberger@kunbus.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 5/7] serial: core, imx: do not set RS485 enabled if
 it is not supported
In-Reply-To: <20231209125836.16294-6-l.sanfilippo@kunbus.com>
Message-ID: <ffdaf03b-65af-731f-992-3e90ca6fca@linux.intel.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com> <20231209125836.16294-6-l.sanfilippo@kunbus.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1041274839-1702292428=:1867"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1041274839-1702292428=:1867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Lino Sanfilippo wrote:

> If the imx driver cannot support RS485 it sets the ports rs485_supported
> structure to NULL.

No, an embedded struct inside struct uart_port cannot be set to NULL, 
it's always there.

Looking into the code, that setting of rs485_supported from imx_no_rs485 
is actually superfluous as it should be already cleared to zeros on alloc.

> But it still calls uart_get_rs485_mode() which may set
> the RS485_ENABLED flag nevertheless.
> 
> This may lead to an attempt to configure RS485 even if it is not supported
> when the flag is evaluated in uart_configure_port() at port startup.
> 
> Avoid this by bailing out of uart_get_rs485_mode() if the RS485_ENABLED
> flag is not supported by the caller.
> 
> With this fix a check for RTS availability is now obsolete in the imx
> driver, since it can not evaluate to true any more. Remove this check, too.
> 
> Fixes: 00d7a00e2a6f ("serial: imx: Fill in rs485_supported")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

-- 
 i.

--8323329-1041274839-1702292428=:1867--
