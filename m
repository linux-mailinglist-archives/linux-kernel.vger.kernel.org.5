Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5512B7BCF5D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbjJHRSW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 Oct 2023 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjJHRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:18:21 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379FA6;
        Sun,  8 Oct 2023 10:18:20 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a1ec43870cso46605637b3.0;
        Sun, 08 Oct 2023 10:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696785499; x=1697390299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXz1WAscNlXtreSjX4AVrNaeR1jQa7xTI02en+Fku0k=;
        b=MIeFV2UyWpP/CyV27AalUD1KHuQUQK7VV1JNGlzv8B7tJzozeCcBJm3ZT1IoJHcJ+Z
         9cnZL8o6Npwh4+P+p0r6C6NYZv6ZWVRCGHkn+cZl3CaHPCwlvC6XdbcWJOIbAphRbE5w
         7EyI0x+c/971PUkRNu4bFta2adWCfVxsM6drE/gR+HXIGJzkpwD6r15JXuRJqziaRpy6
         cs9GyU8XmhO9Apzj5OzSu4bXmQDhV8HCWsyo6w2XwxrmtSnYhtjeW4Uc26oXN9S27U1k
         JZJXu5Qg498jdCoYDNpvxc2LWkYsaoiLhfT1sD+gADosMcZNoaULTwhCLVY190CMon+f
         eg0g==
X-Gm-Message-State: AOJu0YxGmRy8T3XiGBXdj7HFercU9KLzVItwAjQ8eL2LpKwT6yZHlPXb
        tSclK2F6EYLbJW9SZRtpDD6OSx8Ixo006g==
X-Google-Smtp-Source: AGHT+IE78dOpilgHkHrHLFheYJDxeTNdftneOBRzDJOTZOR7+p2WpYAcDOTxsQ7zEYdugyaKJGVfAw==
X-Received: by 2002:a81:7b54:0:b0:595:e1b:b978 with SMTP id w81-20020a817b54000000b005950e1bb978mr14689697ywc.21.1696785499289;
        Sun, 08 Oct 2023 10:18:19 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r63-20020a0dcf42000000b0058e37788bf7sm2962674ywd.72.2023.10.08.10.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 10:18:18 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a4e29928c3so46512387b3.1;
        Sun, 08 Oct 2023 10:18:18 -0700 (PDT)
X-Received: by 2002:a0d:db08:0:b0:59f:57ca:6e05 with SMTP id
 d8-20020a0ddb08000000b0059f57ca6e05mr13994780ywe.5.1696785498600; Sun, 08 Oct
 2023 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231007-topic-test_tag-v1-1-513cd9e577ed@linaro.org> <8734ymvbds.fsf@meer.lwn.net>
In-Reply-To: <8734ymvbds.fsf@meer.lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 8 Oct 2023 19:18:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVf+bVj8at_GsHhRzHuDFbYGMmutOofMz1Ekv3TTxP4Qg@mail.gmail.com>
Message-ID: <CAMuHMdVf+bVj8at_GsHhRzHuDFbYGMmutOofMz1Ekv3TTxP4Qg@mail.gmail.com>
Subject: Re: [PATCH] docs: submitting-patches: Introduce Test: tag
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Submitting Co-Author <sub@coauthor.example.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 2:57 PM Jonathan Corbet <corbet@lwn.net> wrote:
> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
>
> > Currently, we blindly trust the submitters that they both compiled their
> > code at all, tested it on a relevant device, and have done so in a manner
> > that made sense for a given changeset.
> >
> > If at least two of these three things were always true, the review
> > workflow would be much more exciting.
> >
> > Introduce a new Test: tag to help submitters express the way the patch
> > was tested, making it easier to understand for reviewers and maintainers
> > whether it was tested, and if so, whether that test was sufficient.
> >
> > I originally found something like this on Google's Android kernel repos
> > and loved the concept.
> >
> > Test: make htmldocs and manual examination
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  Documentation/process/submitting-patches.rst | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
>
> Do we really want to do this?  To me, it almost seems like it codifies
> the idea that sending *untested* patches is OK as long as you leave out
> the tag.

Exactly. We are already receiving too many untested patches.

> Others may disagree, but I don't think we need yet another tag for this.
> Testing of patches before sending them should be the norm; if special

+1

> notes about testing are needed, they can go in or below the changelog,
> as appropriate.

+1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
