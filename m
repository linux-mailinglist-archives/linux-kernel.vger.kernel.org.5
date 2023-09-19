Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31947A5C91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjISIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:31:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DFE6;
        Tue, 19 Sep 2023 01:31:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE0C433C8;
        Tue, 19 Sep 2023 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695112281;
        bh=5ZQxCL05xgbLE+Hqu9vgbWaedv9zDSuUhLTMmtFM1uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2a5mY6//2a+36b6b3fKJ6tdg/hf75MoC6RGeUzk+NcaezDnH0wGRO02zk1ru2sDtC
         m1cuoSDmJW/dWsgxlvB1KJZvYBD/ULW2jXVFwQkdYjCTTHsleWNHLcgy0hNHMsQ1Dk
         GpPmONhtiufiCCx9Si0NM1mukcA1qxnJjDU6tJqs=
Date:   Tue, 19 Sep 2023 10:03:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ALSA: docs: Add Marian M2 driver documentation
Message-ID: <2023091924-snowfield-armchair-47d3@gregkh>
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:10:43PM +0400, Ivan Orlov wrote:
> Add documentation for the new MARIAN Seraph M2 sound card. It covers
> current development status, available controls of the card and
> information about the integrated loopback.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2:
> - Remove redundant documentation fix from the next patch in the series
> 
>  Documentation/sound/cards/index.rst     |   1 +
>  Documentation/sound/cards/marian-m2.rst | 104 ++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/sound/cards/marian-m2.rst
> 
> diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
> index e68bbb13c384..e873592d8d00 100644
> --- a/Documentation/sound/cards/index.rst
> +++ b/Documentation/sound/cards/index.rst
> @@ -19,3 +19,4 @@ Card-Specific Information
>     serial-u16550
>     img-spdif-in
>     pcmtest
> +   marian-m2
> diff --git a/Documentation/sound/cards/marian-m2.rst b/Documentation/sound/cards/marian-m2.rst
> new file mode 100644
> index 000000000000..bf12445e20d7
> --- /dev/null
> +++ b/Documentation/sound/cards/marian-m2.rst
> @@ -0,0 +1,104 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +MARIAN Seraph M2 Driver
> +=======================
> +
> +Sep 18, 2023
> +
> +Ivan Orlov <ivan.orlov0322@gmail.com>
> +
> +STATE OF DEVELOPMENT
> +====================
> +
> +This driver is based on the driver written by Florian Faber in 2012, which seemed to work fine.
> +However, the initial code contained multiple issues, which had to be solved before sending the
> +driver upstream.

Minor nit, shouldn't these lines be wrapped a bit shorter as it's a text
file?  80 columns?  The other files in this directory seem to all do
that so maybe do the same here as well?

thanks,

greg k-h
