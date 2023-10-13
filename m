Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DC7C7CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjJMFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:20:14 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89434B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6QGfj2S9zbKi77d+/HQwTmX4NBs+5xRSZN1jv25g9q4=;
  b=kRKFs9tBS1G7ewDnh4cMC9udGLWK1GsGjetMZiYupRG6yHrgMJpaMd+L
   ZBfQaGtFsPJs4McR3Yj9c4PdBkm3xUzY6F9ESLhfrJY4QxlMf70lyM0SR
   rBccl5q6OCGTsYu25Xhj56D18GFGn2U/0Wxt6yyhYnhoagWBrHqKPt14q
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,221,1694728800"; 
   d="scan'208";a="68587634"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 07:20:10 +0200
Date:   Fri, 13 Oct 2023 07:20:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Fix coding style checkpatch warnings
In-Reply-To: <20231013051502.9578-1-soumya.negi97@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2310130719530.3269@hadrien>
References: <20231013051502.9578-1-soumya.negi97@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Oct 2023, Soumya Negi wrote:

> Add blank line after declaration & match alignment with open parenthesis.
> Issue found by checkpatch.pl

This seems like two completely unrelated issues.

julia

>
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 32b2e817ff04..0c61eaff6122 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
>
>  	while (remain) {
>  		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
> +
>  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
>  					(void *)(buf + sent_len),
>  					sending_len,
> @@ -271,8 +272,8 @@ int register_lte_tty_driver(void)
>  	int ret;
>
>  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> +					      TTY_DRIVER_DYNAMIC_DEV);
>  		if (IS_ERR(tty_driver))
>  			return PTR_ERR(tty_driver);
>
> --
> 2.42.0
>
>
>
