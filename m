Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718C97BAEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJEWis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjJEWir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:38:47 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C407D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:38:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3af86819ba9so938942b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696545525; x=1697150325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCvaeX0CsYspblE1+MkdIoTCFcfiCufJXgkcxqp2cOI=;
        b=T+dSRjNDAqjyNc9LC+1nxTaNhjpn7Bl2UlHySWTrUWH8/CdAKaa7H4oI0pStp+9IfW
         5EfqZYcZDZTHhggN7byGFcN9IykKHFAWlxlCYxYWsT1N5ha52/OrTiOSfATofYwvrsrm
         ef19CvBwcN3Xgq1/ZCKTUDTnNx7mS+NNzN3ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545525; x=1697150325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCvaeX0CsYspblE1+MkdIoTCFcfiCufJXgkcxqp2cOI=;
        b=lcOXnd78Z8XUZGAvbwsDEppin5hLjGAmqvPvLAeGl3P/QKvAiMTWyXfAm852H8RdFw
         IUkyBIQ9b8VtbSWxu4SOXswV4/1asMI3z5q4hC7DYo3o0B2y8NJfvK/fpoMWbuKlHE7a
         OV0NLvtNoTtPescswsw5QbLvfmSuRUEw6xezz3j0Wd0Zl0fw/owtiVBtiF9Sv2S6NMAB
         AUyLodr+y4wPzONBZgynGUC3tWPbW7KCrCMC+74SnVkgASerzh4zu+TyfI454M9UllHq
         hEtx/y3PrkT8zExC2BOYeNwXGY32cQ/BUYIHWRSYhAl6ZK04oOWmk40rJWWpFi9r/Wwo
         tgPw==
X-Gm-Message-State: AOJu0YzRMslO3oOI/7Tvo7J5Mvv6J6+tQ71Av1bNKXuo4n6RcVXXPNw8
        xTKwytobuvXuhGUUU2xvmVnudQ==
X-Google-Smtp-Source: AGHT+IFQMXs5moBfjlFoe1sQrtvG11uI/l0FcV/F9HrUl4XBxcLiN8EVE2FuJfy8YnL0Y52eJZCnbA==
X-Received: by 2002:a05:6808:d54:b0:3af:b467:88b4 with SMTP id w20-20020a0568080d5400b003afb46788b4mr5803947oik.35.1696545525651;
        Thu, 05 Oct 2023 15:38:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v9-20020a63b649000000b00577bc070c6bsm1715923pgt.68.2023.10.05.15.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:38:45 -0700 (PDT)
Date:   Thu, 5 Oct 2023 15:38:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Kiyanovski, Arthur" <akiyano@amazon.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Arinzon, David" <darinzon@amazon.com>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Bshara, Saeed" <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202310051537.7C5CEE6E@keescook>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
 <fe65f57f91f342c7a173891b84cda37b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe65f57f91f342c7a173891b84cda37b@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 10:25:08PM +0000, Kiyanovski, Arthur wrote:
> > -----Original Message-----
> > From: Justin Stitt <justinstitt@google.com>
> > Sent: Thursday, October 5, 2023 3:56 AM
> > To: Agroskin, Shay <shayagr@amazon.com>; Kiyanovski, Arthur
> > <akiyano@amazon.com>; Arinzon, David <darinzon@amazon.com>; Dagan,
> > Noam <ndagan@amazon.com>; Bshara, Saeed <saeedb@amazon.com>; David
> > S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > hardening@vger.kernel.org; Justin Stitt <justinstitt@google.com>
> > Subject: [EXTERNAL] [PATCH] net: ena: replace deprecated strncpy with strscpy
> > 
> > CAUTION: This email originated from outside of the organization. Do not click
> > links or open attachments unless you can confirm the sender and know the
> > content is safe.
> > 
> > 
> > 
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1] and as
> > such we should prefer more robust and less ambiguous string interfaces.
> > 
> > NUL-padding is not necessary as host_info is initialized to `ena_dev-
> > >host_attr.host_info` which is ultimately zero-initialized via
> > alloc_etherdev_mq().
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it guarantees NUL-
> > termination on the destination buffer without unnecessarily NUL-padding.
> > 
> > Link:
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-
> > nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> > [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index f955bde10cf9..3118a617c9b6 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -3276,8 +3276,8 @@ static void ena_config_host_info(struct
> > ena_com_dev *ena_dev, struct pci_dev *pd
> >         strscpy(host_info->kernel_ver_str, utsname()->version,
> >                 sizeof(host_info->kernel_ver_str) - 1);
> >         host_info->os_dist = 0;
> > -       strncpy(host_info->os_dist_str, utsname()->release,
> > -               sizeof(host_info->os_dist_str) - 1);
> > +       strscpy(host_info->os_dist_str, utsname()->release,
> > +               sizeof(host_info->os_dist_str));
> >         host_info->driver_version =
> >                 (DRV_MODULE_GEN_MAJOR) |
> >                 (DRV_MODULE_GEN_MINOR <<
> > ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |
> > 
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-
> > 6c4804466aa7
> > 
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> > 
> 
> Thanks for submitting this change.
> 
> The change looks good but the sentence "NUL-padding is not necessary as
> host_info is initialized to `ena_dev->host_attr.host_info` which is ultimately
> zero-initialized via alloc_etherdev_mq()." is inaccurate. 
> 
> host_info allocation is done in ena_com_allocate_host_info() via 
> dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().
> 
> I looked at both the documentation of dma_alloc_coherent() in 
> https://www.kernel.org/doc/Documentation/DMA-API.txt
> as well as the code itself, and (maybe I'm wrong but) I didn't see 100%
> guarantees the that the memory is zero-initialized.
> 
> However zero initialization of the destination doesn't matter in this case,
> because strscpy() guarantees a NULL termination.

If this is in DMA memory, should the string buffer be %NUL-padded? (Or
is it consumed strictly as a %NUL-terminated string?)

-Kees

-- 
Kees Cook
