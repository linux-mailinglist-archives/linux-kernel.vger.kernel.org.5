Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82E78A7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjH1IZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjH1IYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:24:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA952A9;
        Mon, 28 Aug 2023 01:24:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso1437036a91.0;
        Mon, 28 Aug 2023 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693211090; x=1693815890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9pJAr454rayHBAXFAjSdv3co7r+pS6oC0hrTuJIa6E=;
        b=eY2asSzzsQ06/so0010x36+boQ3snxsY+ZhSEEJMUPdRKigzKMOHnD3JkjdxFgLJCr
         Z/bUrl+yxCPBB+ijb2WKjbcADhY5TIZp8+rFSs5M/NOzSrLxxm3BC3oktivF+s8BTD15
         kODf45MmZgqRTEzGyppstnpBSDD1XWjLCfH0pkVOEw/m+8eL9sKYkd+tclBemVCtbaUV
         /Aa9bVsxY2yserL06GqRxhcUSullxJwOXLL2w0RiwDvAQ2Zblnux5PN2MvBuUBmPAhjy
         0zExMXiD3nDyzmTvdXr1QjJJhK6G3Hl++0dqhSZuCpuKExawyYEehlq4Hi4nQb377nTK
         wt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693211090; x=1693815890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9pJAr454rayHBAXFAjSdv3co7r+pS6oC0hrTuJIa6E=;
        b=ZKStPgbKW9Bf+4TupQFFEpp0A+AbnM3mcA8/HvweJ8eIDdvll38/21UtjxZs7UCKUo
         bhoOjLJ0vMyYfq7OvPWSflzSPzqZt0nKDG413c5vmHsOnKf+lLObzMx9b0lW90E2Rfml
         yjpsvjkGEXicnPg0KltI6pSra0TAmqYTKjrN+/QhsyN7MMU9C2UJB4Pxzx4VLQvlVAdZ
         2iOumukU4YqB9oh+j7kIM4eE/4Es5IswsxfaltOb/tblGOe89TwVNITzLOxpBxP7LZyW
         0z3QXasedlTzVEpgJUt696TP9x0mU6/amPVgmQWogNz7pc+q3DpGEsoobsCNUTL+2XFf
         22eQ==
X-Gm-Message-State: AOJu0Yxp4084sKdM+vCkfcFnRe0mZhUH3fEn/j1ip+bdH9r7CUGh1vj1
        SeFus3W6xyGrCP8GNN1VYQ1K52hIDooEobkibmo=
X-Google-Smtp-Source: AGHT+IHPq1bU+a3PvaxjpcNWce89Da2D3WiRaqN32RXecja2hVeevqs83PNitatCwNlfrKSg/wvMUlteRN4XLAzvNek=
X-Received: by 2002:a17:90a:ca16:b0:263:fc45:4091 with SMTP id
 x22-20020a17090aca1600b00263fc454091mr18481089pjt.15.1693211090110; Mon, 28
 Aug 2023 01:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230828071829.64366-1-anshulusr@gmail.com> <2023082827-craftily-citric-06fa@gregkh>
In-Reply-To: <2023082827-craftily-citric-06fa@gregkh>
From:   Anshul <anshulusr@gmail.com>
Date:   Mon, 28 Aug 2023 13:54:41 +0530
Message-ID: <CAPwwkU7+zHo2jpt+ovJDE1ca=K8AKyowyA5Z9pOFAy6iifVEwA@mail.gmail.com>
Subject: Re: [PATCH] fixed formatting issues
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.

I believe that splitting the patch is not necessary in this instance since
the changes are localized and trivial to reason about.

> - You did not write a descriptive Subject: for the patch, allowing
>   everyone, to know what this patch is all about.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.

As per the feedback, the updated patch has incorporated the changes.

> - It looks like you did not use your "real" name for the patch on either
>   the Signed-off-by: line, or the From: line (both of which have to
>   match).  Please read the kernel file,
>   Documentation/process/submitting-patches.rst for how to do this
>   correctly.

I have verified that the Signed-off-by: line and the From: line contain the
same content.

Thanks for the feedback,

Anshul
