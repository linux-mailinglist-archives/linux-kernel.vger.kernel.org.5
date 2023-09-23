Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849357ABF0E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjIWI6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIWI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:57:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692D194
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:57:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D37C433C9;
        Sat, 23 Sep 2023 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459472;
        bh=lkZTTPkhqLfjkprWT4Ia6kfXgvK3+U2RT5SryrW5fU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNzDdi2ADZy/5iSMNEcMTw6rPJDQxwZ1X0gpCVWzWc0zGB0T1WV5/GusCdWkQLcdU
         XUnM+6j6Piv3G8J6rmB5QiFtH0juwUwqGasjKeOF1gd+EYg7jak8AHnPnU5V7n1+Od
         xxyBZhDS9xQb6vntJcYMIvJnE15ktDV3+CQtX6XWABq3sJcKy1ncSM6IMWcUQKTCJg
         QoT0LWMMWz4tTZGgC7XiojTHDRDzxF9OOWBI5ADB3i4HVmlxBqtvO4juFDoVcZrI0+
         PGowALpXhR8mJ2rUeR4RVt9BU3xXNj1JXedl+FDXQImOecyzSF0IGpMsQRike1Zq+l
         55vUUeYL3O13A==
Date:   Sat, 23 Sep 2023 10:58:55 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: svc: Annotate struct svc_i3c_xfer with __counted_by
Message-ID: <ZQ8ZTwbg56QgmRTd@work>
References: <20230922175023.work.239-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175023.work.239-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:50:23AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct svc_i3c_xfer.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Conor Culhane <conor.culhane@silvaco.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 8f8295acdadb..32eca2d6caf0 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -143,7 +143,7 @@ struct svc_i3c_xfer {
>  	int ret;
>  	unsigned int type;
>  	unsigned int ncmds;
> -	struct svc_i3c_cmd cmds[];
> +	struct svc_i3c_cmd cmds[] __counted_by(ncmds);
>  };
>  
>  struct svc_i3c_regs_save {
> -- 
> 2.34.1
> 
> 
