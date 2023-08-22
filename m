Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630F8784260
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjHVNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjHVNuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB518B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70A465708
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C35C433C9;
        Tue, 22 Aug 2023 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692712210;
        bh=mG6DXlXlMRPptfmTnxoYooQNKEhtfzz0atYYStvqRB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnpCwjuhNzcnP1gJuJEANGaPW8k2JZeXA6x5JfL+BafuNNupg0nhqvnTFr6d28zZD
         3ErRk2mRknR8Tmil02SGqVVx4U6LFCRd+tD4n75o3WC0wm+rRdaVp1UBxj9DYyeX4E
         tnV4umEySVSuVBky5FPelj9aWtGdn77scfoiksm0=
Date:   Tue, 22 Aug 2023 15:50:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, anjan@momi.ca,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] Staging: rtl8192e: Rename variable pRxTs in
 function rx_ts_delete_ba()
Message-ID: <2023082245-undergrad-sly-4f27@gregkh>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
 <20230820004744.278022-2-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820004744.278022-2-tdavies@darkphysics.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 05:47:29PM -0700, Tree Davies wrote:
> Rename variable pRxTs in function rx_ts_delete_ba() to ts
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v3:Resend as 16 patch series - no longer throttled by email provider, fix commit msg
> v2:Resending in smaller patch series
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> index 0e3372868f97..da29163f3022 100644
> --- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
> @@ -41,9 +41,9 @@ static u8 tx_ts_delete_ba(struct rtllib_device *ieee, struct tx_ts_record *pTxTs
>  	return bSendDELBA;
>  }

This patch series is named very strange.  Some commits have "v3", some
have "v2" and some none at all.

A patchset itself is versioned, I can't keep track of which commit in
the series is newer than which, sorry.  What would you do if you saw
this email thread in your inbox to review?  :)

Can you resend the whole thing, as a v4 series, with the Tested-by tag
added to the patches?

thanks,

greg k-h
