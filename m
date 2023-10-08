Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94B17BCBAF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjJHCNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjJHCNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:13:35 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E98BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:13:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59f55c276c3so42589557b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696731214; x=1697336014; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G3HEwMN8wJykQ1F/Gq5CdsdfPgK1Mar6fjfy0CS0bo=;
        b=TwLglArRqHckz47HV3NTSAzmBLk+qrSxdq3uLII+d2HZ7/9dhkZw0WiJCuB0OMhifo
         /6JiPoH7ouj04fzQPZfCLRTLSAPewY+TzCXqvlP1TlS1gjPWpovGLOZ+pvxntwFAjG9i
         uLKe6VM14taD/r3r8PP59DzQjhFWWamgbH/ukDEsyNDtJPDPQOx/AHwRYHzYDt+X1GHB
         mhUXtqMwecPFwgKovEp79YZa05/3jaG61qqcoCqhtBUA3Of499kEGLPqiseszVVZpRGA
         XDEQvssXoHpWSLmV962dGhPhIUS8DXzpGyKiPzGNxdxgvGap/QC/DsbjdTC/hYStiK6I
         IWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696731214; x=1697336014;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1G3HEwMN8wJykQ1F/Gq5CdsdfPgK1Mar6fjfy0CS0bo=;
        b=pYixUd0WYhObq8pUocbL/0FR2bcPbsHeKoJXdb9xA0yg4ztaVGGKkwF6Q/U2t+xiv/
         exOE6MKD/JrB0qdqopKww6mj3Erp60XLk3CoE0QsSV8KAmtoyk3IGhP/903KhqhSiug8
         w7jq8E06IrHpCERzktLf6uywm+1bA8haAdEs6b/yHCpHmIQNCCRFV2pULmYk1XNTW5bK
         C5nMrUkIU4/2J98Llq2ktWF7CVmiYm5AF/3iHvYuCnnxYc5rBV8tqodCX5m/vUB7xEq5
         YoOKGWYa2CUehzw6UunzZdvrV9em3nQWkocId1euYMUFIRsWG0vDhx0sxb3HUTEVATGp
         WU7A==
X-Gm-Message-State: AOJu0YzphqDAoj+B6nhjuRtlVfM4QDybWl99aKGOS47aClvZirUGC+RH
        gkNro/+CywpM0YzofXcOfYYiKMLfS5JtoYDEI6O+M2J+
X-Google-Smtp-Source: AGHT+IGfEU0gfelgssEBProloBp/sg8LqhxAolgQa0d+cuONC3lsnnQqBsCbP3I8P8eFY/e8UBkhn+Jn/6SOi5w5YD8=
X-Received: by 2002:a81:dd0d:0:b0:59b:ec85:54ee with SMTP id
 e13-20020a81dd0d000000b0059bec8554eemr13452442ywn.39.1696731214106; Sat, 07
 Oct 2023 19:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696729776.git.opensource206@gmail.com>
In-Reply-To: <cover.1696729776.git.opensource206@gmail.com>
From:   opensource india <opensource206@gmail.com>
Date:   Sun, 8 Oct 2023 07:43:21 +0530
Message-ID: <CAKPKb8-rhLt3u2-8utmPLqSkLHQ0mMoP3MaHN6GSYGCsCF4bkQ@mail.gmail.com>
Subject: Re: [PATCH
To:     Pavan Bobba <pavanbobba206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore all of the below patches. I will send it again. this is
a test mail i sent to my own id..but by mistake i sent to all of you

On Sun, Oct 8, 2023 at 7:41=E2=80=AFAM Pavan Bobba <opensource206@gmail.com=
> wrote:
>
> *** BLURB HERE ***
>
> Pavan Bobba (3):
>   staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
>   staging: vt6655: Type encoding info dropped from variable name
>     "byBBVGACurrent"
>   staging: vt6655: Type encoding info dropped from variable name
>     "byBBVGANew"
>
>  drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
>  drivers/staging/vt6655/channel.c     |  6 ++---
>  drivers/staging/vt6655/device.h      |  6 ++---
>  drivers/staging/vt6655/device_main.c | 24 ++++++++---------
>  4 files changed, 38 insertions(+), 38 deletions(-)
>
> --
> 2.34.1
>
