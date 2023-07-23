Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6252175E417
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGWRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:44:57 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF6180;
        Sun, 23 Jul 2023 10:44:56 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583f99641adso1150037b3.2;
        Sun, 23 Jul 2023 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690134296; x=1690739096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPdCSD5AmFVFEdD2cqqk2qtaqyfuU2DEBfQJVgjKFB0=;
        b=N9vsVovBzUqMiszcLD94N3fd+7uZVZRdtAETQZ4Dox4iiDvnWlpim1WJZC/vQGW2uh
         9oLG5MAiXLXMjUbOBxjnHj4CFq2APH690SkqLWIfwh3+k5yKjMnZ3Run2dfB/EsPUIkF
         1Pkr91u7+hiHQYK57px1fw81a0T2LeL8z52uh1MUdpN878OsZ9F8+MYqnFRo+hH+A3u0
         PhxY2N1P1UAkTH3VsQ6CDOGImMjbhUp8TmH+cwQquBdPBWqVIPFe8ZvfuO0WLbgfXrb5
         0Ow87GBBOsIBFNvDFv18jwnnflSXHu+YA+wu7N3jAs8itxB1gykdRFDc1BpJJK6uLH8b
         TQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690134296; x=1690739096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPdCSD5AmFVFEdD2cqqk2qtaqyfuU2DEBfQJVgjKFB0=;
        b=fTAKtAecT7jgOFh333owFxXcYPonGV2ahhp3m+N56tdsTdpSrMIEOqNZvMzxi4adhf
         vGaKIBgGNsYWwOgZGNlU/lF0atKlLeEIRQGEI7Xq/8/zLRj1SXpnGvQaoWLkWVd6SgH/
         +hzUxAvvNm5JfTlqgNs+j8o2LF9dhNRcK6C7RvmhbdBnIymjjWRJQZaEl/p+akrQbp/v
         GacRI4uo8MUeMM4g9sBe35nMXLUOHV4ZhEh5sNp1cF24wwBis+IdSjcB4bD8Ol7QWVtf
         T5Hje9W4y/Rn9BFpxt8yyqs6lyJlfUt7GVSWJUK4lzwYDbyoJ0WNPQS513gHfNGrgZgg
         qivw==
X-Gm-Message-State: ABy/qLaU59zOqXwy2WS74E6F0X6iIdC26sfKR80e/rELzzlV1XcztyWB
        JfMHT7BKZujfWvEReQBgCJ4nGspPYUBR7m2zCzY=
X-Google-Smtp-Source: APBJJlFSX7H7gt9TFDUi3uuo8jI+fP82XT4JuAUkLCOV3bUxhx+tBBiHLYKTPs1zPM4F93IG7mfUgkSRLc0WJtJVvYc=
X-Received: by 2002:a0d:d98f:0:b0:583:78b7:53f1 with SMTP id
 b137-20020a0dd98f000000b0058378b753f1mr4096965ywe.7.1690134295743; Sun, 23
 Jul 2023 10:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230701102538.5359-1-franziska.naepelt@googlemail.com>
 <5ad04b3a-7c77-cadb-13b4-509a086cf04d@web.de> <2023070123-unburned-worsening-0713@gregkh>
 <CAAUT3iNqwgtFJz2Q1bRN+MsSna26KC1FJc3jchu=8B09A2SkvQ@mail.gmail.com> <4b9fdaa7-bdcf-ef41-0d54-ba41520cde4c@web.de>
In-Reply-To: <4b9fdaa7-bdcf-ef41-0d54-ba41520cde4c@web.de>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Sun, 23 Jul 2023 19:44:44 +0200
Message-ID: <CAAUT3iPUaNRUyvqP1O97M0AmKri7Ghc06ku4TS6vcHQ=Sb4ycg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] staging: rtl8723bs: Fix space issues
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Emily Peri <eperi1024@gmail.com>,
        Guo Zihua <guozihua@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am So., 23. Juli 2023 um 08:19 Uhr schrieb Markus Elfring
<Markus.Elfring@web.de>:
>
> > Am I supposed to adjust something here?
>
> There are possibilities remaining to handle recurring communication difficulties
> in more constructive ways for some hints.
>
>
> > As far as I understood, I can ignore the comments from Markus, correct?
>
> Would the provided technical information be taken better into account
> if it would be presented by any other contributors?

That's not my point, I appreciate feedback from anybody, absolutely no question
on that. I'm just struggling to know what I'm supposed to do when the maintainer
is saying somebody's comments are not helpful.
In another thread I was told I should mainly follow the maintainers comments in
case of different opinions.

Franziska
