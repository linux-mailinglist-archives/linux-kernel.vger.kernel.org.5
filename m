Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283E4778C13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjHKK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHKK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:29:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070DDC;
        Fri, 11 Aug 2023 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691749746; x=1723285746;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1cuNBVAHm1eCW8DM16u/EOGsWYmWOHNYNDUo0LaepRQ=;
  b=QEqaV9xjcgjdYS5Z5NcrsdsYrg6UzKrFhdTAkjBNq1bKPTmTibDeyUOs
   DXK1JEWQxW5ybtNpxPwS92YmdKTGsXP4F+g+0cL8M9CcSJjtABBn54jbT
   o9Nszfe7agb2m7RGfSCbObCPkIM210umbbJq4Dh6PRvwS/F35OYZeJhE3
   3EYw0hfc9Hi/czYaD9Q3ZGhONze/VaamqGLOrnC83N4C91EOceqJuK1EY
   bNy2454kYmnZL3dwfl1Fkd1QM5l7xHnG6d4Qi4Uvyh709xIFfuWwqpCci
   d2u1/SL0kglnLeKjBoGxEMxteplLr5sItTdWDjKe9Xl9i8EVIVQlDQwNi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351250401"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="351250401"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822620171"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="822620171"
Received: from aberko-mobl1.ger.corp.intel.com ([10.252.51.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 03:28:59 -0700
Date:   Fri, 11 Aug 2023 13:28:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 16/36] tty: use u8 for chars
In-Reply-To: <20230810091510.13006-17-jirislaby@kernel.org>
Message-ID: <27366cad-30b2-e326-8d8f-c6fe17cf4899@linux.intel.com>
References: <20230810091510.13006-1-jirislaby@kernel.org> <20230810091510.13006-17-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:

> This makes all those 'unsigned char's an explicit 'u8'. This is part of
> the continuing unification of chars and flags to be consistent u8.
> 
> This approaches tty_port_default_receive_buf(). Flags to be next.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: William Hubbs <w.d.hubbs@gmail.com>
> Cc: Chris Brannon <chris@the-brannons.com>
> Cc: Kirk Reiser <kirk@reisers.ca>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Max Staudt <max@enpas.org>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  drivers/accessibility/speakup/spk_ttyio.c |  5 ++--
>  drivers/input/serio/serport.c             |  5 ++--
>  drivers/misc/ti-st/st_core.c              |  2 +-
>  drivers/net/can/can327.c                  |  2 +-
>  drivers/net/can/slcan/slcan-core.c        |  5 ++--
>  drivers/net/hamradio/6pack.c              |  4 ++--
>  drivers/net/hamradio/mkiss.c              |  2 +-
>  drivers/net/mctp/mctp-serial.c            |  3 +--
>  drivers/net/ppp/ppp_async.c               |  8 +++----
>  drivers/net/ppp/ppp_synctty.c             | 11 ++++-----
>  drivers/net/slip/slip.c                   |  2 +-
>  drivers/tty/n_gsm.c                       |  2 +-
>  drivers/tty/n_hdlc.c                      |  2 +-
>  drivers/tty/n_tty.c                       | 28 +++++++++++------------
>  drivers/tty/tty.h                         |  2 +-
>  drivers/tty/tty_buffer.c                  | 21 ++++++++---------
>  include/linux/tty_buffer.h                |  4 ++--
>  include/linux/tty_flip.h                  | 22 ++++++++----------
>  include/linux/tty_ldisc.h                 | 18 +++++++--------
>  sound/soc/codecs/cx20442.c                |  4 ++--
>  sound/soc/ti/ams-delta.c                  |  2 +-
>  21 files changed, 73 insertions(+), 81 deletions(-)

> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> index 6ceb2789e6c8..6f2966b15093 100644
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -22,9 +22,9 @@ struct tty_buffer {
>  	unsigned long data[];
>  };
>  
> -static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
> +static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
>  {
> -	return ((unsigned char *)b->data) + ofs;
> +	return ((u8 *)b->data) + ofs;
>  }

Any particular reason why b->data is left unsigned long?

-- 
 i.

