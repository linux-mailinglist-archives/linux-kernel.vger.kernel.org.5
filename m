Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8669D7F293D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjKUJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjKUJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:48:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7CBCB;
        Tue, 21 Nov 2023 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560128; x=1732096128;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cH0R5P0WbTeznkzXyw0TAlPVaLM1ksbhnHCkyuwy1wo=;
  b=Z3Qqb8vXr3YC01HmV0Vse91yRNx6LaPHhEKsxD4S5btuOJ9TFFiEjILV
   JcUU3HtCfnqBlG18kf2nELzKALMBB1Ct/pX2V8DA3H37tcUB0EPH3W91o
   EtFlPagXNM8CoM/JPawYPPXkgGpIGo+tZan9WCv32WPG8SzMJ7InpKJdG
   KKekiVdh5vhCmEYk4IgJfqo7J0qZGMGaRmJdYusKX04RW7ZPcDEUmkfzr
   VREuki1iNepLVTd47cyjMVCEG4Zm4Zq7oq4Oc23W/ZjTxhbRHU97Np4vS
   WQ1t7JutVk2HysjbrwbWbxyqy/4gU6aJj0u5j69CzngW0Jf0LOx8bodYT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395731701"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="395731701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795741498"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795741498"
Received: from sbouradx-mobl.ger.corp.intel.com ([10.252.58.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 01:48:46 -0800
Date:   Tue, 21 Nov 2023 11:48:44 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/17] tty: move locking docs out of Returns for functions
 in tty.h
In-Reply-To: <20231121092258.9334-5-jirislaby@kernel.org>
Message-ID: <e74f4dfb-55f2-f997-6a70-a1b7edd11016@linux.intel.com>
References: <20231121092258.9334-1-jirislaby@kernel.org> <20231121092258.9334-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-803243020-1700560127=:1688"
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

--8323329-803243020-1700560127=:1688
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Nov 2023, Jiri Slaby (SUSE) wrote:

> Both tty_kref_get() and tty_get_baud_rate() note about locking in their
> Return kernel-doc clause. Extract this info into a separate "Locking"
> paragraph -- the same as we do for other tty functions.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  include/linux/tty.h | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 4b6340ac2af2..7625fc98fef3 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -393,8 +393,10 @@ extern const struct class tty_class;
>   * tty_kref_get - get a tty reference
>   * @tty: tty device
>   *
> - * Returns: a new reference to a tty object. The caller must hold sufficient
> - * locks/counts to ensure that their existing reference cannot go away
> + * Returns: a new reference to a tty object
> + *
> + * Locking: The caller must hold sufficient locks/counts to ensure that their
> + * existing reference cannot go away.

Just noting this is a bit vaguely worded (but so is the original).

>   */
>  static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
>  {
> @@ -436,10 +438,10 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
>   * tty_get_baud_rate - get tty bit rates
>   * @tty: tty to query
>   *
> - * Returns: the baud rate as an integer for this terminal. The termios lock
> - * must be held by the caller and the terminal bit flags may be updated.
> + * Returns: the baud rate as an integer for this terminal
>   *
> - * Locking: none
> + * Locking: The termios lock must be held by the caller and the terminal bit
> + * flags may be updated.

I don't think the second part about the flags really belongs here, I'd 
keep it the description.

Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-803243020-1700560127=:1688--
