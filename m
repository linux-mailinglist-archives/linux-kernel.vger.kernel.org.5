Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95067C7DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjJMGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:42:46 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FABC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=do1ejETpZeeA7uGrvhUBwMkbFjN6NkVLG5rCWNrdvKM=;
  b=su3F6wnUJWweb9YxR6sJpwVg0vJKYcBbVbhBmhb/sCfcAgB1pMc7OaDU
   ScI2nVoCz0lWorgcK9x8sxMvH2/kYBXCne9Q2jWhCgi2FG3mlrpuTxOTs
   YF2eEVDcXn8YMDG9kMmZUtHFjmPYhR4x7B8plq7XhMeglWRS4BTk5BCbY
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,221,1694728800"; 
   d="scan'208";a="131020345"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 08:42:42 +0200
Date:   Fri, 13 Oct 2023 08:42:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Match alignment with open parenthesis
In-Reply-To: <20231013060123.13400-1-soumya.negi97@gmail.com>
Message-ID: <51deee17-33a5-d46c-1211-ca9186a4fe4@inria.fr>
References: <20231013060123.13400-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This and the next patch need to be in a series because they touch the same
file.

julia

On Thu, 12 Oct 2023, Soumya Negi wrote:

> Fix CHECK: Alignment should match open parenthesis
> Issue found by checkpatch.pl
>
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 32b2e817ff04..4e5cac76db58 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
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
