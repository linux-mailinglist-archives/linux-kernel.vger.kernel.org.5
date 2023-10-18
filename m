Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B27CDC80
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjJRM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjJRM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:59:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF6A3;
        Wed, 18 Oct 2023 05:59:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso11734615e9.0;
        Wed, 18 Oct 2023 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633973; x=1698238773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3l7KU10yNphdl5Vv+iDYUL4LqhI9vTGfAIrzdvNXoIs=;
        b=bXqsgMPy0hjWDRpJ1FisdfP+n2/hFvLWGQxQkWs+Xmjga3qZGpMdH3sYCnZKJ70+lS
         aTQvaLIRvUKuWCyGkhed7mV3nhJSLEjKqxR7c8dN72XMdQK7qUVJAVERDs7lWIc7hjwm
         q8VS1mfs7nkIBiBW7a3oevFFWgNMqdeE/3iQzIrQwAPa6QGwZzpMVJNufq3JbOe7ZRe2
         RdiCrS+jexJdwV+nmst8tpaZlqemvH8a0Oe1D3whpR3+W5BJFwzXLh5gQMebY90rDlxU
         qrimKvXAhRcgEerSxJ5ByROEb+bPRXLZDGut4PgUk0T5fDhxIG75IeLf3miFP9s/xetp
         oI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633973; x=1698238773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l7KU10yNphdl5Vv+iDYUL4LqhI9vTGfAIrzdvNXoIs=;
        b=kmjk8Gs4UOraFKQXyMnvdZBqeio1ySO18INpdb1LhLV/Kjl8kHkxvAYMk1f302xHAL
         XBDBnxxOmMZZvGXK/p/EVJ7Mi7WMsyJ5ofYOVWdRyYjnx7rbCM7S+Q3DBpQT9txAzgN1
         yfLmHvRXnwHISXNoKppgAj0RXePs4/eUNCQVWos+QgIEEUyE7a+9OpmVSSuioR2a1mdc
         EgHjJB0qah0PvVFlRgkOUDz4dtgrp8o2KqB3EzJo3Hb4ymygOaJv7A2lmsKHDGdPCMQQ
         e8T0hfrHGZdiwl59F8za2Uu5J1rR4oDgfeXqiVovaqPY4ndEYiKOFGfvZ2YTvnHNvTqe
         Fysw==
X-Gm-Message-State: AOJu0YyUMxhfq82nkxeM9oN/ei6htJK7rdzrBPjzBUXC3IjIQKLkHOn2
        uZZcpPO+fub2LEmokwwXFQ==
X-Google-Smtp-Source: AGHT+IGorfdQKSOrVoY8L4UO3dsA6xUqICePH8OqA+pJtZnZPwhyw7zG0ELzN/8lhptrPKgSqkTmrg==
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe0 with SMTP id l34-20020a05600c1d2200b0040841b47fe0mr134123wms.6.1697633972472;
        Wed, 18 Oct 2023 05:59:32 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.0.137])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b0040651505684sm1640297wmo.29.2023.10.18.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:59:32 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:59:27 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <ZS/Wr9ShnEe3umeY@dorcaslitunya-virtual-machine>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
 <4b7129ae-27f9-7ff4-845-9c327aff488c@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7129ae-27f9-7ff4-845-9c327aff488c@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:06:41PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 18 Oct 2023, Dorcas AnonoLitunya wrote:
> 
> > Modifies the return type of program_mode_registers()
> > to void from int as the return value is being ignored in
> > all subsequent function calls.
> >
> > This improves code readability and maintainability.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index 83ace6cc9583..e15039238232 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -73,8 +73,8 @@ display_control_adjust_sm750le(struct mode_parameter *mode_param,
> >  }
> >
> >  /* only timing related registers will be  programed */
> > -static int program_mode_registers(struct mode_parameter *mode_param,
> > -				  struct pll_value *pll)
> > +static void program_mode_registers(struct mode_parameter *mode_param,
> > +				   struct pll_value *pll)
> >  {
> >  	int ret = 0;
> >  	int cnt = 0;
> > @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
> >  	} else {
> >  		ret = -1;
> 
> Is it still useful to have ret = -1?  Maybe the ret variable is not useful
> at all any more, but one would have to check the parts of the function
> that aren't shown.
>
I agree Julia. I will remove the setting part for ret = -1 but keep the
ret variable just in case it is being used by parts of the function not
shown. Thanks for the feedback.

Dorcas
> julia
> 
> >  	}
> > -	return ret;
> >  }
> >
> >  int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
> > --
> > 2.42.0.345.gaab89be2eb
> >
> >
