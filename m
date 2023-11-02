Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659447DF493
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376723AbjKBOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:06:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B99130;
        Thu,  2 Nov 2023 07:06:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CD1C433CC;
        Thu,  2 Nov 2023 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698933986;
        bh=X/ZY4Bj6WJ9v4AGzNjhqnzv83KfYS95NURO/+eNLBCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzbjZG8dwwDnBgh55HwU9w+H48Mv+oZFE2j3o7U0B9Kj9OOZCxGXQLA8vAJBAVXpa
         mif0o8J9aAKvsKFjTkUtZoJv8Jpo616JePz6oT+egX/8CdfBHfij1j6YeVy/C2x1gW
         BleWXSk4oRRneb84tQG+SnywFeTxSt5nVBADYQ9U=
Date:   Thu, 2 Nov 2023 15:06:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@ger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        linux-spdx@vger.kernel.org, Richard Fontana <rfontana@redhat.com>
Subject: Re: [PATCH RFC 1/4] LICENSES: Add SIL Open Font License 1.1
Message-ID: <2023110222-renewed-monologue-008e@gregkh>
References: <20231102120053.30630-1-bagasdotme@gmail.com>
 <20231102120053.30630-2-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102120053.30630-2-bagasdotme@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 07:00:43PM +0700, Bagas Sanjaya wrote:
> Add the license text along with appropriate tags for reference and
> tooling. The text is taken from the text as distributed in Google
> Fonts's zip files.
> 
> As the license itself may or may note be compatible with GPLv2,
> let's take on the err side and require combining it with
> GPL-compatible licenses when using the license.
> 
> Cc: linux-spdx@vger.kernel.org
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  LICENSES/dual/OFL-1.1 | 107 ++++++++++++++++++++++++++++++++++++++++++

You add this license, but then never actually reference it in the later
changes, so it's going to be very confusing as to why it is here.  Any
way to add it to the font files themselves so our checker tools can
handle this properly?

And, it's not going to work as a dual-license, you can't just suddenly
dual-license those font files, right?

>  1 file changed, 107 insertions(+)
>  create mode 100644 LICENSES/dual/OFL-1.1
> 
> diff --git a/LICENSES/dual/OFL-1.1 b/LICENSES/dual/OFL-1.1
> new file mode 100644
> index 00000000000000..00b8db08bd0e54
> --- /dev/null
> +++ b/LICENSES/dual/OFL-1.1
> @@ -0,0 +1,107 @@
> +Valid-License-Identifier: OFL-1.1
> +SPDX-URL: https://spdx.org/licenses/OFL-1.1
> +Usage-Guide:
> +  Do NOT use this license for code, but it's acceptable for fonts (where the
> +  license is specifically written for them). It's best to use it together
> +  with a GPL2 compatible license using "OR", as OFL-1.1 texts processed by
> +  the kernel's build system might combine it with content taken from more
> +  restrictive licenses.
> +  To use the SIL Open Font License 1.1, put the following SPDX tag/value pair
> +  into a comment according to the placement guidelines in the licensing rules
> +  documentation:
> +    SPDX-License-Identifier: OFL-1.1

Where did this Usage-Guide from?

thanks,

greg k-h
