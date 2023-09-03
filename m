Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F34D790B6C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjICJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjICJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 05:54:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E51F1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:54:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so345401a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693734884; x=1694339684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSZnlEu/1rZ58eHSJVj+WQ7718jJFMdsyl5ARuTMrGw=;
        b=ZPgeZrXkm3aDQOdmyrms7perENU26aE1OAOgzKG/9fRR/GuKr9SUWhtqx4cYgAZIBr
         cP0CkVdW7yrACKAi17lEDoEE5GaLd4wREUtoChwdnoajYVlWXGthyP/wx2uB2deD57Ax
         SACRKseelwwLEW3w2LiftaczF3yV0N5HdvNMazsgWYSKwgXFa+UyfFRZnhXuKQcJocEP
         5XJATFdUvr2IeOOEb7y/1CyYwAxpCDyHd5MWUH9m+huVG0vDS/n2ioFvyiYK8HO8E07G
         1DMsDQdBfxe4jjBxL+dIDPcNpus7MhBHT/Z9jCLrWpd9VOMkp9u8wIpx/iWOuEjOsSXm
         167A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693734884; x=1694339684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSZnlEu/1rZ58eHSJVj+WQ7718jJFMdsyl5ARuTMrGw=;
        b=Y05RXbJdrvX8HNZkoJAzw7VAMJ2brQXQNNbcRpxMjitmrzXlqCuzLXSI6rLOd81UkQ
         tLNNz7Zjh5km4EDsfomsnh/o1IJTWgPjsWSzkKb7pkR7ag25zxu4b33J6lAv4MJ9cyvG
         aUphXYn5ysKkEsFjcrICg7TRQ2hyMKbAaR6CNtLytUXKUB7Sridl92fCBTmatTlQNZsl
         8cUTfbhsoxxiSAO1BRrz8Gjx9FNSG357Arbmwpfi3XW30g3LQjde8hDRdLUbPIdX8Ecd
         glQcC2GnsFaHOH6kkm+butdqUqNDKnBcCiKBkEAYwJ5RnsIIE4zlWgphXowFQ+zHWsaT
         GrHQ==
X-Gm-Message-State: AOJu0Yz0Yhlr0x2aZCJZRzHnJjesJrpbu/XonCEd7FosF0MholFIyYni
        VqNEkoduEG+sIRDSEAKDCR6+w8Flg0DyJU0DSDs=
X-Google-Smtp-Source: AGHT+IFLSgzbrRKCnF9RL63/5b8qz1Rz5YWHK+jFN02iQnHY6JEc6/Tjg+6d/Pvn3J8BBIqmfwsV3/N1+6hGB8fSfvo=
X-Received: by 2002:a17:90a:db4c:b0:268:5c3b:6f37 with SMTP id
 u12-20020a17090adb4c00b002685c3b6f37mr6657137pjx.0.1693734883661; Sun, 03 Sep
 2023 02:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230903082253.562042-1-bergh.jonathan@gmail.com>
 <2023090324-recopy-unisexual-db41@gregkh> <CA+MPq=VjvQSmY_coVxrmisXavgaZa78ram-SH2pHvOZ=AvaqRQ@mail.gmail.com>
 <2023090349-fresh-empirical-425d@gregkh>
In-Reply-To: <2023090349-fresh-empirical-425d@gregkh>
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
Date:   Sun, 3 Sep 2023 11:54:32 +0200
Message-ID: <CA+MPq=U87cDJt1r8HCrw4LoM4PwtBRuP+z77=CcqG1HAKJZ=NQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: Fixed some formatting warnings in the vme_user driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks mate, appreciate that. I'll check it out and give it
another whirl (assuming the rest of the talk is still valid ... and
you guys still want these sorts of patches!)
Cheers
JB


On Sun, Sep 3, 2023 at 11:40=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Sep 03, 2023 at 11:17:41AM +0200, Jonathan Bergh wrote:
> > Hi Greg,
> > I hope you are well. I got this response from your bot!
> > I pretty much followed your FOSDEM instructions for *first kernel
> > patches* so i thought I was doing it right.
>
> That's a really old talk, things have changed a bit since then :)
>
> > Based on the video of your talk, is more required in the SUBJECT and
> > BODY for such a (basic) change? It seemed the above was pretty much
> > inline with the terseness / examples you showed in your presentation.
> > Hopefully thats the case.
>
> Yes, you need a better changelog and subject line.  Read the link that
> the bot referred you to and look at all of the examples commits that
> have been accepted for the files that you modified to give you an idea
> of what is needed.
>
> thanks,
>
> greg k-h
