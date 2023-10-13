Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAE7C7D11
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjJMFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjJMFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:35:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5550CBC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:35:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c5bf7871dcso14063135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697175307; x=1697780107; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJVW+9qlD6LlVYZG3xkLmkd4SS3hgrGhJE+KlBem0rs=;
        b=PSYTZTt6FnN0cC46tazUzoELFhOFpmmocEnczCXLyPV/ZN4HvDMYvRY4653CKpbja6
         TCMoy3c+FjJVKDWvOHJhat5ogA/afRnESyRISpKSqIDZ0NlzYxoCbOxi24IvJWPs+Iji
         oGK9mLDCyKs3TvS1Cc1VsImH4uYcs/IlxP5PpjcZMs3ySJ+t25s2x7pSW5rM9C0qumZU
         fU5ZZ5asYuv9YaFjz0lB8DO05jeM00yh7uWIDsKhMKzI1TLqQnaebGOLKI7WqUhIR7B3
         +0le3sw7+TFLV4hnQJMr5DUugudVjhEaEKr5vkl/Bqt56DVMl0gtsWh0hVErlNd1req5
         DtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697175307; x=1697780107;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJVW+9qlD6LlVYZG3xkLmkd4SS3hgrGhJE+KlBem0rs=;
        b=pBtefiynSF8XE7U/5pj4HiKRUNrNfzsqqaZmRRjDWOQC154sXbz+vaeCME/v3feTdh
         vrKkSF29ayNsY9cXArtR/k0d3hqhlEnOudRyUyWRZRZE2dP9MHnVgy1JVOnJquV4DgTg
         K9B6oejhFUOHEHWMa8aGgCyAMKbx6N1IheLk0VEpdgqQ7Dr85WHIFAxbIXW+5nnRoU+p
         O0QjEzpux+lio0ECAzSU8jvx9YoEHrCwcYq7trDAcn0u9phKHqjCtb/+nu3L9Kebp7Qi
         TB1lvvvAIc/Vtx+tgrMHVck0AXHbpHA5dUOKnlIlOaOUA3Aa5UPzZgTg4XJuHaSSuhMd
         qjNA==
X-Gm-Message-State: AOJu0Yw35BKY8ydQFzPzFcM8l7RoDCX6VBhX9eI1OBpOWymV7MtCZCPO
        sAuCeYFKETYbIZ4wkpqa6qTctroVNNxlIQ==
X-Google-Smtp-Source: AGHT+IEhxvGGfl1wAAY20wYN9SKLkf29rpj0YSgFN0GKLO0zYrRn0u2nYMEj54+HRm2sVaSEdFXz6g==
X-Received: by 2002:a17:902:e54a:b0:1c6:2d13:5b74 with SMTP id n10-20020a170902e54a00b001c62d135b74mr27473901plf.55.1697175307345;
        Thu, 12 Oct 2023 22:35:07 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b001c0a414695dsm2937504plb.62.2023.10.12.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:35:06 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:35:06 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Fix coding style checkpatch warnings
Message-ID: <20231013053506.GA9482@Negi>
References: <20231013051502.9578-1-soumya.negi97@gmail.com>
 <alpine.DEB.2.22.394.2310130719530.3269@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310130719530.3269@hadrien>
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

On Fri, Oct 13, 2023 at 07:20:08AM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 12 Oct 2023, Soumya Negi wrote:
> 
> > Add blank line after declaration & match alignment with open parenthesis.
> > Issue found by checkpatch.pl
> 
> This seems like two completely unrelated issues.
> 
> julia

Hi Julia,

I got it. Will send two separate patches for each type of code cleanup.

- Soumya

> >
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/staging/gdm724x/gdm_tty.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> > index 32b2e817ff04..0c61eaff6122 100644
> > --- a/drivers/staging/gdm724x/gdm_tty.c
> > +++ b/drivers/staging/gdm724x/gdm_tty.c
> > @@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
> >
> >  	while (remain) {
> >  		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
> > +
> >  		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
> >  					(void *)(buf + sent_len),
> >  					sending_len,
> > @@ -271,8 +272,8 @@ int register_lte_tty_driver(void)
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
