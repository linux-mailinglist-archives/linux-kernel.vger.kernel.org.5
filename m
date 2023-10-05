Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3717BA519
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbjJEQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjJEQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:17 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0E6EB8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:44:43 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d0ae5ec2fso281299e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696488282; x=1697093082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqnjKMUKrx/t6mWFTrezoF1LGQFygXyorM18s6YzVXM=;
        b=IXk5xmoR+3sTVr5AyNQYWERIN7e1fkg0hbA5wTYSQ+hdhla37sA+cRHmwLpoRvjib+
         E9maEjikmCXjrpKMXjQi71cnk2HIQI/0Be2aPmVWfrs6xq8b5WbPMJsAhS3PQTBOFjFL
         uGs0V+fDybQSwMnQc1JqWqUsp7v3cYfCpdFjZz4IxZoxax1D7QbbLNbZNJCYaRVadAvH
         m1GjuLe3msEzuCUXD0YgyJJj4uRqtqRG6RTCfrC3/mGDEoRc3CBqOMbfC8rEXNi9c0O6
         aeN1vlgcnbtGplApL3ccMZ1TL9tawk7ng/j3uM950ft7smBvHia4QMCfui8ibGYly4uO
         3kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696488282; x=1697093082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqnjKMUKrx/t6mWFTrezoF1LGQFygXyorM18s6YzVXM=;
        b=BLS91g6LFalAsbbWN2zYGy61cvXPjUL+zQZtDUGH6YHKA/atuFkK19M6G9I9Ued2I+
         eMug4WfWG0aAmFuATEksHv5X/MNF+r3/DSMQVN2nOVHyeIrb0yqJnESiVsdF+1y7I2aa
         rSDSFE7gyGCSKbKA35AhdYpyi/amwQ2z26ppSPQAGA0Nc8tyn5ZV63b0sEfPRKtVa6Z6
         9MGYHTaWOl9JRHltzju0hVd6bDVydSrPFE2aedpkz7hk8hb+lNLxpu5sLyBFoFqSpDUh
         KK30rkcvkuPJUdWHAC05QbCBuZK57oYPxwfxh1k28UPEuUT3sJbPsPGoqU4xewed+zhY
         Nm0g==
X-Gm-Message-State: AOJu0YwK3dAZZ6FSkpsmvEyAJ+OBe1EvvwELlGNvibL052UxOderQ5nA
        KGW9XPnsv9ymFWocbpyH0eSDKwASrteNwYh50O9qDQ==
X-Google-Smtp-Source: AGHT+IGfyc3OZPDhNlEsdyCWOE/Iaq3dMSrNeZ78S5Kz6VqB4GKON095y2qYBtIwND/y7AKZiG3S7QOovgfAqiaZ6tM=
X-Received: by 2002:a1f:cb42:0:b0:48d:b7c:56c8 with SMTP id
 b63-20020a1fcb42000000b0048d0b7c56c8mr4379398vkg.0.1696488282544; Wed, 04 Oct
 2023 23:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231004185732.98621-1-brgl@bgdev.pl> <25ba48de-2ab6-4a4e-a290-891398710931@gmail.com>
In-Reply-To: <25ba48de-2ab6-4a4e-a290-891398710931@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Oct 2023 08:44:31 +0200
Message-ID: <CAMRc=McHD7F1vdy7Pe0ORBU23fKFs4iKgN8zzD9ezxTSebFihw@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: qseecom: add missing include guards
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 9:10=E2=80=AFPM Maximilian Luz <luzmaximilian@gmail.=
com> wrote:
>
> On 10/4/23 20:57, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The qseecom header does not contain ifdef guards against multiple
> > inclusion. Add them.
> >
> > Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secu=
re Execution Environment SCM interface")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Oh, thanks for spotting and fixing that.
>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
>
> PS: I haven't forgotten about your SHM Bridge patches. Testing those is
> now next up on my kernel TODO list. Unfortunately, it might take a
> couple more days until I can get around to do it properly.

Thanks, you may as well wait for v3 as it'll be reworked significantly
again due to some new information I got.

Bart

>
> > ---
> >   include/linux/firmware/qcom/qcom_qseecom.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux=
/firmware/qcom/qcom_qseecom.h
> > index b531547e1dc9..5c28298a98be 100644
> > --- a/include/linux/firmware/qcom/qcom_qseecom.h
> > +++ b/include/linux/firmware/qcom/qcom_qseecom.h
> > @@ -5,6 +5,10 @@
> >    *
> >    * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
> >    */
> > +
> > +#ifndef __QCOM_QSEECOM_H
> > +#define __QCOM_QSEECOM_H
> > +
> >   #include <linux/auxiliary_bus.h>
> >   #include <linux/types.h>
> >
> > @@ -44,3 +48,5 @@ static inline int qcom_qseecom_app_send(struct qseeco=
m_client *client, void *req
> >   {
> >       return qcom_scm_qseecom_app_send(client->app_id, req, req_size, r=
sp, rsp_size);
> >   }
> > +
> > +#endif /* __QCOM_QSEECOM_H */
