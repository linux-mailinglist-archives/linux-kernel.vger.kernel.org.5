Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203477A55C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHMG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjHMGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:55:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42D1722
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E076B617B5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4DCC433C7;
        Sun, 13 Aug 2023 06:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691909724;
        bh=5i2AjKPSHieuDcXs+EsWdltqAbUtkA5hW8kNs2g2JLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTlgbwwtq6S3Eu32iYXR9T6cPizV17b3hLzoGSLLLCuakiXo8fPJO1+wo/0OcFpKu
         MyVM5oNsoIDBFlpTExY4LbO6wK6MNKtNVeX9sO0RRHEb2hUi93+TvWzLQL6mdJABaV
         dercvC5z75W0Yxb9NIiYnzxFUIi+7Bjo5S19Mm5I=
Date:   Sun, 13 Aug 2023 08:55:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Staging: rtl8192e: Rename variable pTS in
 function rtllib_rx_ADDBAReq()
Message-ID: <2023081315-grandma-fifth-1e9c@gregkh>
References: <20230813065035.95157-1-tdavies@darkphysics.net>
 <20230813065035.95157-3-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813065035.95157-3-tdavies@darkphysics.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:50:31PM -0700, Tree Davies wrote:
> Rename variable pTS in function rtllib_rx_ADDBAReq() to rx_ts
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v2:Resending in smaller patch series
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 1eff30533f47..2748ab59545c 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -220,7 +220,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
>  	union ba_param_set *pBaParamSet = NULL;
>  	u16 *pBaTimeoutVal = NULL;
>  	union sequence_control *pBaStartSeqCtrl = NULL;
> -	struct rx_ts_record *pTS = NULL;
> +	struct rx_ts_record *rx_ts = NULL;

This should just be called "ts" as that's what it is being used for, as
the original name says.

I've stopped reviewing the series here, please go through and make sure
all of your renames make logical sense as that is important when reading
the code in the future.

thanks,

greg k-h
