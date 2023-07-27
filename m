Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42327649C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjG0IDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjG0ICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:02:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7C2726
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33FE2618D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C2DC433C8;
        Thu, 27 Jul 2023 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690444768;
        bh=EJxDPwh0/PNszmN4znypIhQGAzTgBhpEPGaM4IrGkBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdV8uUhc0xeL3o0BrqNB09vi9qESykQw7WYos1sk4ys832ySsi9ujNXmP9SEG3sFT
         BvBI19j4w+gieeavhGjeDEsDXx2zw7vPCciALo6aCoilajQDHIsWF4EitImOCeq58J
         b5Pw9r+CI7PqVhiTmRWD4TO6kGLLIS5pSyxdKTDk=
Date:   Thu, 27 Jul 2023 09:59:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8192e: Rename function IsHTHalfNmodeAPs
 to is_ht_half_nmode_aps
Message-ID: <2023072737-resort-dwelled-8cb9@gregkh>
References: <ZJp93mCd9ogrGZbx@tacos.darkphysics>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJp93mCd9ogrGZbx@tacos.darkphysics>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:12:46PM -0700, Tree Davies wrote:
> Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_aps in order to
> fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v3: Fix email parch as v2 info was placed above the ---
> v2: Rename is_ht_half_nmode_a_ps -> is_ht_half_nmode_aps
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>  drivers/staging/rtl8192e/rtllib.h         | 2 +-
>  drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index f9fa3f2bb728..d09342dde61d 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -139,7 +139,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
>  	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
>  }
>  
> -bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
> +bool is_ht_half_nmode_aps(struct rtllib_device *ieee)

As this is a global symbol, can you please prefix it with the driver
name so that the global symbol table looks semi-sane?

Perhaps rtllib_is_ht_half_nmode_aps()?

thanks,

greg k-h
