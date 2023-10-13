Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810097C7EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjJMHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJMHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:48:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193CCE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:48:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9fa869a63so2634645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697183298; x=1697788098; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl7fgJaWj5cTBuYX4JkcZ4GOPxj+pu0zJjF36kB0W04=;
        b=VYQMYCbcP2Qex8QVkaQ7W5/Ixyj9unEuCEvVBn0mesxNZHIW7e/SjoHvSQ1j5KY0ex
         WqdUUbq3cEiKR7sQNsGKsnzVGIBdKUopjgkQx9W3npq8yzAleyKd5Hwinbcz9MYP/9Ui
         XdQsJgyndukeUo0r7xKc33qm9Enx5Wf7fZv2Lm29XD+zijFsrTn/N7TEa4HTwWLvuGWd
         JHAIbQBR9kgoSBdoRTnfqVGChBBkpDrbN9YDxSGk+TjDX7oV7Pg55TTG7xSrbLo+Q74h
         YS8lcPHnI74hSr2C7BNd/tU589AAARoWHKBUhE4ltS8YduW8VBOfUbAP6M+PmmekCbf7
         bYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183298; x=1697788098;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl7fgJaWj5cTBuYX4JkcZ4GOPxj+pu0zJjF36kB0W04=;
        b=B/DD0FKUXHBWbg4co3Edp2WzkhGnh2CTRjEyIg+IjmgVl7j3Y93BG5lyc3QkTb4BRO
         t0OnYyF4V2KBBWvC3ZJaPnmrUrAwqMZR4dXYxgMlQdHtfxdIgynOQWkM2SQnnMRqUSsC
         EemT0o1P/d7xR9UqLoZcUsArdwJw0JYZ8q5uP/AYJijKAbSqdt/U/soCNlZ5cyip6vNG
         K76vkvjy0fVFsylOtdiomnrwgYcuYcKV4ssg6zKZWHzTqv8rBV14vhf8+Tl0qZtfMOYt
         33HkWnCKCs1GTGeVU3ltM/RBgKfvMpXreKxfX9+Rb1f4JAtD8FDR0F+d4JBIeWUqRVnN
         8C3g==
X-Gm-Message-State: AOJu0Yzfsv9Dwlhn06uujgs/lI2XDIkJGRGU0Kt0O2ZagpIBHQ1UDAyi
        JUFOdEFoKYmfqB7xUjQvCoWDHxNEJ9b+8w==
X-Google-Smtp-Source: AGHT+IGgrzD3/aqCAFAU3YdoAscnsRYQc/k0/7wXMAUFxVOP1TY9rj16GMYNHv75lxVgWqwyQXWCcA==
X-Received: by 2002:a17:902:ceca:b0:1c5:9c73:c91c with SMTP id d10-20020a170902ceca00b001c59c73c91cmr28520232plg.48.1697183298112;
        Fri, 13 Oct 2023 00:48:18 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id jh22-20020a170903329600b001c9d968563csm3229234plb.79.2023.10.13.00.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:48:17 -0700 (PDT)
Date:   Fri, 13 Oct 2023 00:48:17 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Match alignment with open parenthesis
Message-ID: <20231013074817.GC13814@Negi>
References: <20231013060123.13400-1-soumya.negi97@gmail.com>
 <51deee17-33a5-d46c-1211-ca9186a4fe4@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51deee17-33a5-d46c-1211-ca9186a4fe4@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:42:42AM +0200, Julia Lawall wrote:
> This and the next patch need to be in a series because they touch the same
> file.
> 
> julia

Noted. Sending them as set.

> On Thu, 12 Oct 2023, Soumya Negi wrote:
> 
> > Fix CHECK: Alignment should match open parenthesis
> > Issue found by checkpatch.pl
> >
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > index 32b2e817ff04..4e5cac76db58 100644
> > --- a/drivers/staging/gdm724x/gdm_tty.c
> > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > @@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
> >  	int ret;
> >
> >  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> > -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> > -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> > +					      TTY_DRIVER_DYNAMIC_DEV);
> >  		if (IS_ERR(tty_driver))
> >  			return PTR_ERR(tty_driver);
> >
> > --
> > 2.42.0
> >
> >
> >
