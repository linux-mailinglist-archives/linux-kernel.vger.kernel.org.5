Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7177D774B33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjHHUnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjHHUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:42:37 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041AE11CF8;
        Tue,  8 Aug 2023 13:17:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id EF65A20127;
        Tue,  8 Aug 2023 22:17:13 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TP2rFcRwTC_Y; Tue,  8 Aug 2023 22:17:13 +0200 (CEST)
Received: from begin (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 9E9482011A;
        Tue,  8 Aug 2023 22:17:12 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qTT8i-0021rK-0T;
        Tue, 08 Aug 2023 22:17:12 +0200
Date:   Tue, 8 Aug 2023 22:17:12 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
Message-ID: <20230808201712.efl6vbtsuy57b64d@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230808201115.23993-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808201115.23993-1-gnoack3000@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Günther Noack, le mar. 08 août 2023 22:11:12 +0200, a ecrit:
> Clarifies that the LEGACY_TIOCSTI setting is safe to turn off even
> when running BRLTTY, as it was introduced in commit 690c8b804ad2
> ("TIOCSTI: always enable for CAP_SYS_ADMIN").
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/tty/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 341abaed4ce..069de553127 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -164,6 +164,9 @@ config LEGACY_TIOCSTI
>  	  userspace depends on this functionality to continue operating
>  	  normally.
>  
> +	  Processes which run with CAP_SYS_ADMIN, such as BRLTTY, can
> +	  use TIOCSTI even when this is set to N.
> +
>  	  This functionality can be changed at runtime with the
>  	  dev.tty.legacy_tiocsti sysctl. This configuration option sets
>  	  the default value of the sysctl.
> -- 
> 2.41.0
> 
