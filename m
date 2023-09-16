Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CC7A2F6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjIPLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbjIPLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:07:59 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608581A3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:07:53 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57124ee486dso1730854eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694862472; x=1695467272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSYQJUSJlmKe70RcgZjhNkiltubw1MczNjvblZNnLvg=;
        b=TC0jctz/pgCqqQ3RJO7DheIeRD+3SdtNyvh4Tp5cg8Yb4SB3i6Kuo23/cOigk8j85W
         NxE2/UZY/MaE52QNbALmbDSIXgeGUAzeiALwBMaQK4eGNklxKCrc7NNvF5qozOtk95yo
         K320DOwCAK9cmPQjDa0BTSqSdXMEL7pa9OuE5MsGgfAQDXMiFf+cEp+b8+Wi8c5YuFpr
         ysCn+352TIqRifdL+QcOSx4JffCOWaVO7hKBhRRDinhBOosH3V0Yf776NxV/1RiHjIpF
         xoZmVcpHo4gX9pl6t7s0pbhV5LYkEdh1KAuWBYOkB0BPjWnb0buyEhtgSgTKW6/L+Efa
         4uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694862472; x=1695467272;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSYQJUSJlmKe70RcgZjhNkiltubw1MczNjvblZNnLvg=;
        b=Wyg+QdAbKKWIdLtDg02+DoySXwI4qn7hW8F5lc+p+7QG+wiKb16FYtMN5njZZLxzg4
         FcEJ1IP81yjJn9dH18+fJO+6D/dHlV16wIoezJ4ShwmWty2w7rm2ZmQYic7ARm3Hbc2+
         PfZImhaKW0PKmKHWraIGPTLdLalJTStFiJNyj8jUhiaqJ0O75ur5CWGDHowXJlAuKe5N
         LB9GeiLqh3H9PmUCUQGD73qYgXKxo/0r8tZb0JW+4NKFe6V7crtX1lZQ83uh2rPUBQuL
         +XJ/g8SaSpmiM3vQfaqaHLiMPbVoJjsMMRJ00vXuVR2HYTDgviu74gKXsjS/Rz95sR+b
         Eysw==
X-Gm-Message-State: AOJu0Yx/tJ4lysTBwpAuSyqJwLMakVCIvi5V76cpVB0z6c15OWGiZYez
        9VjfkIaD0h+UcMJ22vnKpAa0UmflCrORoA/+a+c=
X-Google-Smtp-Source: AGHT+IGl8HPzrdaBPxONWCA9g0jYBdNdUrKpyLUSYm1yP2c3RQ2iXVO38VgjOBsxZw6THE2+kfqdL7NYS0m/ZtkAhEU=
X-Received: by 2002:a05:6870:56a3:b0:1d1:40a6:e83d with SMTP id
 p35-20020a05687056a300b001d140a6e83dmr4646694oao.50.1694862472536; Sat, 16
 Sep 2023 04:07:52 -0700 (PDT)
MIME-Version: 1.0
From:   Karim Manaouil <k.manaouil@gmail.com>
Date:   Sat, 16 Sep 2023 12:08:52 +0100
Message-ID: <CADsNLn1feXXt3RBN5JPxW0oLSOuVeBqRb-LSYvX8MBEjT6_YYQ@mail.gmail.com>
Subject: [Question] Where can I find numa/core patches (autonuma from Peter
 and Ingo)?
To:     mingo@kernel.org
Cc:     peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and Peter,

I am studying the evolution of automatic NUMA balancing and I'm looking
for the patches for your numa/core implementation.

I was able to find the tree for AutoNUMA from Andrea.
I was able to find the tree from Mel Gorman's implementation.

But I could not find the numa/core (maybe also called unified numa)
tree from you and peter.

For example, this email [1] contains some patches for v18 of
numa/core, but they build
on top of the patches for v17. I could not find the latter.

In this NUMA comparison you sent [2], you mentioned Unified NUMA tree.
I can't find this one either.

Do you guys know where I can find the patches/git trees or the mail
threads for numa/core (or unified NUMA)?

Cheers
Karim

[1] https://lkml.org/lkml/2012/11/30/488
[2] https://lkml.org/lkml/2012/12/7/331
