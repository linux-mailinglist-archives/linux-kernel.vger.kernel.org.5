Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20A7742AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjHHRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjHHRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E2AD158
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4BB5623D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 04:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDCAC433C8;
        Tue,  8 Aug 2023 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691469190;
        bh=aVU8DNBygGUkAgJG5ohqB3i06dXOaJN6KaaWsGZkqqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/2DJAWXTNTx/vK1DWSGRVqp+svgeR1oHQKYIiqvLBGm0fa9jPwoitYvw13rK1TAQ
         Umv38JjLMF/X+Aix0CUN9Xm7lMZBLHye7zyGCeP4Nqkgxaf6yeHvJbCjuydhZH32eu
         J/xpVY977iqkq5WhB33aJS9+EOjg5wjPzNqOkfis=
Date:   Tue, 8 Aug 2023 06:33:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: vme_user: fix alignment of open parenthesis
 and deleted trailing spaces
Message-ID: <2023080840-passenger-sierra-55ef@gregkh>
References: <ZNFXMrtqSWvZv+rl@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNFXMrtqSWvZv+rl@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:42:26PM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Alignment should match open parenthesis
> and deleted the trailing whitespaces as reported by
> checkpatch to adhere to the Linux kernel coding-style
> guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> ---
> 
> Changes in v2:
> - Fixed changelog, noted by Greg KH
> 
>  drivers/staging/vme_user/vme.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 977c81e2f3c7..741593d75a63 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -563,7 +563,7 @@ EXPORT_SYMBOL(vme_master_request);
>   *         returned.
>   */
>  int vme_master_set(struct vme_resource *resource, int enabled,
> -		   unsigned long long vme_base, unsigned long long size, 
> +		   unsigned long long vme_base, unsigned long long size,
>  		   u32 aspace, u32 cycle, u32 dwidth)

I think the confusion here is that my tree does NOT look like your tree
at all right now.  If I try to apply this patch, I get:

	checking file drivers/staging/vme_user/vme.c
	Hunk #1 FAILED at 563.
	Hunk #2 FAILED at 614.
	Hunk #3 FAILED at 1045.
	Hunk #4 FAILED at 1841.
	4 out of 4 hunks FAILED

So please, rebase your tree against my staging.git on git.kernel.org
tree, the staging-next branch, and then resend the patches from that.

thanks,

greg k-h
