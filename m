Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65CC77A537
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjHMGyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjHMGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D410FB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19710621A4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DCEC433C7;
        Sun, 13 Aug 2023 06:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691909656;
        bh=ag/sonhJHQ4OPOZJFKO88rQ6YYnY3PpOaN5Nh+0WmGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzE8a1KOCP6pMjMRGtrWfTxHnbaba5UMOMHQNQHAW72wUQsPVImKPR5Bv7AHufvUy
         xzRhFTWogAQS2a+tQbwfKQGL6zB4owLz0dNZ82ZqrngOPLDm5wz/I2YT+qv2BE/lRB
         3drFfzm+KBvFVIQQtqhMPwTJRn3q3Wlkt6qB+oB8=
Date:   Sun, 13 Aug 2023 08:54:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Staging: rtl8192e: Rename variable pBa in
 function rx_ts_delete_ba()
Message-ID: <2023081344-graveyard-frivolous-7d98@gregkh>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
 <20230813065035.95157-2-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813065035.95157-2-tdavies@darkphysics.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:50:30PM -0700, Tree Davies wrote:
> Rename variable pBa in function rx_ts_delete_ba() to rx_ts
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v2:Resending in smaller patch series
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 0e3372868f97..1eff30533f47 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -41,9 +41,9 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
>  	return bSendDELBA;
>  }
>  
> -static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *pRxTs)
> +static u8 rx_ts_delete_ba(struct rtllib_device *ieee, struct rx_ts_record *rx_ts)
>  {
> -	struct ba_record *pBa = &pRxTs->rx_admitted_ba_record;
> +	struct ba_record *pBa = &rx_ts->rx_admitted_ba_record;

I think your description is wrong here, you are not renaming the pBa
variable.

thanks,

greg k-h
