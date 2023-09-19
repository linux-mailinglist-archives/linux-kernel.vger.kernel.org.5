Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D947A5F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjISKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:07:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CAD9E;
        Tue, 19 Sep 2023 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695118037; x=1726654037;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AQcW/KWKtoR/JMee+ZhoHaBD4GeCe/e3QgG2nFX/3y4=;
  b=ZCuK3xRzq3sd0qIsEhTnPi4wcBnynWE4TPtFIcJ2EaVkZqBKEsgjrlOV
   /CF9VKLdcfqUorhKseBqmSwCfbffzZrPbuuS0rMgBqKHaMq2ZP1A7/5B9
   +YoGAAHc7jq3aq9xKl7I2M0s6Wflry93cQEOSVRlueSIk4rNpCUZvcLYV
   scTg11nVYAWvWYLTBuQQzRBzP41UNNGHRnl9L+usCRpPuKCwOUYlYZ6sY
   CTY+ID6VIsp+MOUObMwtigjFOI/bltq0H2Gi+aCs3M45NQQCCMqsasDS2
   f1FED6aVy7hPbWNcinNocyL4TN8Wshb4GQY8So7pR3xcHAOeckTeEQlPy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="382654096"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="382654096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836383570"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="836383570"
Received: from laichele-mobl1.ger.corp.intel.com ([10.252.38.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 03:07:14 -0700
Date:   Tue, 19 Sep 2023 13:07:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] tty: fix kernel-doc for functions in tty.h
In-Reply-To: <20230919085156.1578-10-jirislaby@kernel.org>
Message-ID: <6033668f-71cc-b21-a034-a1ff31d7279@linux.intel.com>
References: <20230919085156.1578-1-jirislaby@kernel.org> <20230919085156.1578-10-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Jiri Slaby (SUSE) wrote:

> tty_kref_get() is already included in Documentation, but is not properly
> formatted. Fix this.
> 
> tty_get_baud_rate() is neither properly formatted, nor is included. Fix
> both.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  Documentation/driver-api/tty/tty_ioctl.rst |  3 +++
>  include/linux/tty.h                        | 21 +++++++++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/driver-api/tty/tty_ioctl.rst b/Documentation/driver-api/tty/tty_ioctl.rst
> index 9b0be79fc15e..3ff1ac5e07f1 100644
> --- a/Documentation/driver-api/tty/tty_ioctl.rst
> +++ b/Documentation/driver-api/tty/tty_ioctl.rst
> @@ -5,3 +5,6 @@ TTY IOCTL Helpers
>  =================
>  
>  .. kernel-doc:: drivers/tty/tty_ioctl.c
> +
> +.. kernel-doc:: include/linux/tty.h
> +   :identifiers: tty_get_baud_rate
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 59d675f345e9..4b6340ac2af2 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -390,14 +390,12 @@ int vcs_init(void);
>  extern const struct class tty_class;
>  
>  /**
> - *	tty_kref_get		-	get a tty reference
> - *	@tty: tty device
> + * tty_kref_get - get a tty reference
> + * @tty: tty device
>   *
> - *	Return a new reference to a tty object. The caller must hold
> - *	sufficient locks/counts to ensure that their existing reference cannot
> - *	go away
> + * Returns: a new reference to a tty object. The caller must hold sufficient
> + * locks/counts to ensure that their existing reference cannot go away

Shouldn't this have also Locking: entry instead of hiding the details into 
Return?

>   */
> -
>  static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
>  {
>  	if (tty)
> @@ -435,14 +433,13 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
>  		speed_t obaud);
>  
>  /**
> - *	tty_get_baud_rate	-	get tty bit rates
> - *	@tty: tty to query
> + * tty_get_baud_rate - get tty bit rates
> + * @tty: tty to query
>   *
> - *	Returns the baud rate as an integer for this terminal. The
> - *	termios lock must be held by the caller and the terminal bit
> - *	flags may be updated.
> + * Returns: the baud rate as an integer for this terminal. The termios lock
> + * must be held by the caller and the terminal bit flags may be updated.
>   *
> - *	Locking: none
> + * Locking: none

Eh, the paragraph above says, "The termios lock must be held by the 
caller" so this "Locking: none" seems pretty bogus.

>   */
>  static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
>  {
> 

-- 
 i.

