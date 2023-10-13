Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90107C8ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjJMVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjJMVNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:13:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2210BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:13:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-694ed84c981so2081908b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697231608; x=1697836408; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDEgyyosUqx6vs14HxrP/8FKw5FzUfuw525zCcTrL5Y=;
        b=JuYrE0TMTsuOzdszl1wFQNc1MqohiGYNCR+cJ4CC94ysFboavTS7Z10NGUkRETN2XQ
         WHywCGXjkvE04zh0k/K6P/oOQKBArUClWPSj/xgNAq3RasCtS6mVW5CCz6fqkBg0Tm0y
         kFjspjuLq4PAm7JAZ7QqONSXHrlrQ8cxvYcg5WVBBsKTIJxI+jb2g2E0y1WBfa9UfxWJ
         uHsP4Uaymoslg/7ZzafnBF/TGNFeaoBJ2PoOD/fbfOxrGYrDiu3MIr2G2P6VXAUSkXAD
         Mr+ypDYpp+/t5nihMHMqnUWykcxE2CezfcmSnk2UhNsJCV6YZowUAKCuuMg7mrWUcXJU
         6FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231608; x=1697836408;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDEgyyosUqx6vs14HxrP/8FKw5FzUfuw525zCcTrL5Y=;
        b=Vgexn6N6ye6ELzU+vxlt9EXRHmgkxhteZP4CP0zvfmwtQ2eX83zEaC7/eFXJwrdc35
         yocwQnH4yFM/A8hwldQ7t/2BlA3cmZXsgvUDYKk6qy5+RA9oT6i62zpsu84KCvSrZ0ZN
         ZC0l1gIf80E7KX/D6NFxj8ac75HFmqY3iybaXQd9aJNxwu0XDZA1hz8BTcSNBi5+HUMd
         OG68SwxXWrrya70KtCt0wVIcW04ftBe25cYGd2D/vt3hPc4FMeVDyze7k5/J+bH6bLwh
         VDSKxWr9+rxlhqGp0UpRQLLEBe39wNZ85V+bPj6wW1c9XKZ7T7DXZh2vAtCu5bXXkO06
         ErYQ==
X-Gm-Message-State: AOJu0YxxnHzJygZ9QNT0U0YHflBc8SxTxXs8T0I8Tk4MWmpcShUBBej8
        GIioobkv7HQQbWWUJe2LOz4zPGnkaDVvDg==
X-Google-Smtp-Source: AGHT+IFhA3DtOVEKxx2Dik09MQrxURa0EuN5QE/3vbqXzk/tVtFx+lp2Qk/0lJ0G8IkwjwMLtDvLRg==
X-Received: by 2002:a05:6a00:2406:b0:693:3963:847a with SMTP id z6-20020a056a00240600b006933963847amr26806679pfh.30.1697231607705;
        Fri, 13 Oct 2023 14:13:27 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b006878cc942f1sm13928771pfn.54.2023.10.13.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:13:27 -0700 (PDT)
Date:   Fri, 13 Oct 2023 14:13:26 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: gdm724x: Match alignment with open parenthesis
Message-ID: <20231013211326.GB25352@Negi>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
 <a0a7274f-eba6-4f72-9569-ec4c4fff3a1a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a7274f-eba6-4f72-9569-ec4c4fff3a1a@kadam.mountain>
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

On Fri, Oct 13, 2023 at 11:57:40AM +0300, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 01:26:34AM -0700, Soumya Negi wrote:
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
> 
> I prefered the original code.  It was more readable.
> 
> regards,
> dan carpenter
Hi Dan,

Noted. I'm curious what happens when some of the patches in a patchset
are acceptable and some are not. Is everything disregarded by
maintainers or are the good patches cherry-picked from the set?

Thanks,
Soumya

