Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1F75C93E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGUOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGUOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:10:44 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9172D47
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:10:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54CF4C0007;
        Fri, 21 Jul 2023 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689948635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGdCdXItdOZQeU45kFrZwcBzzffnx3e+cCUIm+CzmFk=;
        b=bc2qEHAFKehlFEzbQvoCKk0jAT8vTAr/mfvl52KcVRPthXMmtDfUMs6qurm5Z34yY5VM5w
        RtCY4uLKft0vgI5HqODPoEkxVZST/N5F03nawHfuuVu1b+WjB1nl/fHWfYynvNN0OSt6/5
        JHKQP7qBMfhDnbKm5Wg7bmCwezvzBS0joR3hquVKmg3U9h44H0nGbnBQ1aDeHlGm9jNUBK
        kgpwx0ROYLchbReN4GMG1DzGGqLlpleDIiUG/ZtcBsDaheFmLd/ymJTuWDiKmkKv9OhiVB
        94hHzvAYppgd0YybIeqwYggzAwsJsQMvYOJsWaX33DGEWBk5weeQnFAen3ygeA==
Date:   Fri, 21 Jul 2023 16:10:33 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] minmax: Fix header inclusions
Message-ID: <20230721161033.55bc133c@bootlin.com>
In-Reply-To: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
References: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, 21 Jul 2023 16:39:32 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> BUILD_BUG_ON*() are defined in build_bug.h.
> It also provides __UNIQUE_ID() that is defined
> in the compiler.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/minmax.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 798c6963909f..049480235e53 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MINMAX_H
>  #define _LINUX_MINMAX_H
>  
> +#include <linux/build_bug.h>
>  #include <linux/const.h>
>  
>  /*

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
