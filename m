Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DCA775EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjHIMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHIMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEE1BF0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46A0636C7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD23C433C8;
        Wed,  9 Aug 2023 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691583621;
        bh=qkd5uVTEEPS8zjHnXRACa23VVQLyxESeRtfjdn1FCf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVOMtPVAXbbpGMJ9HCdTTuSg6N7NfPF3/Tv5UonXmWUx7Zzr8aLJRzS5bb4bg1ia2
         deq3rrAYlGfAuMtR2Jk8TVs66tK82eSlnTQ9Qe6WDZumwcB3oT9vvTukdgns8kAtjz
         80YwCm9N7uazPhXe+qoJ8lC7yHMwcvxL4KXm46Pk=
Date:   Wed, 9 Aug 2023 14:20:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <2023080918-opulently-eclipse-7555@gregkh>
References: <ZM4PWL55pMQiYIX6@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM4PWL55pMQiYIX6@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 02:29:04PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by snake case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  v1 -> v2: 1.character '_' added in the array name "byvt3253b0_rfmde"
>            2. typo in the subject line "small case" corrected with the
> 	      proper word "snake case"
> 
>  drivers/staging/vt6655/baseband.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> index 0e135af8316b..8b913c64845c 100644
> --- a/drivers/staging/vt6655/baseband.c
> +++ b/drivers/staging/vt6655/baseband.c
> @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
>  };
>  
>  #define CB_VT3253B0_INIT_FOR_RFMD 256
> -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> +static const unsigned char byvt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {

The "by" here means "byte", a horrible naming scheme that was popular in
the 1990's when C compilers would not check the types of variables.  No
need for that here, this should just be "vt3253b0_rfmd", right?

thanks,

greg k-h
