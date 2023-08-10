Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39101777A05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjHJOA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjHJOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:00:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431EEA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:00:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c93638322so197707566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691676022; x=1692280822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdmJj2QqDHMxtiF3eCBrt5esrxE5kxx10fSadyM3MuE=;
        b=GytVXAxB4ulLq1I2C/87Mh5s5PQbr9OQsTpV2ET6NYMjvZBigTzaD0DGpAo3C63SFn
         Et31qS/FSOMsPCrOfrIwjupwyiX9I0MfkD2JbFf2Wbi4JtgZvf68HTnxuQN3yu/RznDc
         q4GWUq6RJnIi8vWgKC/3yJJehXKMX0w+l1deh18ggm063CLB/4DfXEQAfOKzMMq0W1/D
         /ujN7AoXDwE1jNJT0Exx3aPcvy9FXVLBxe4txpCxpRsd07+osdHF6+gkjIhLx5S/nqDi
         qJeie0MD2YSQYsWAsZMUAylL47TWu7jNEINLqGq9giGMj0UTJEyBlKwyy9L9B4GBOY6v
         hrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676022; x=1692280822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdmJj2QqDHMxtiF3eCBrt5esrxE5kxx10fSadyM3MuE=;
        b=QwSh5MchzCxJlG2qO+mIxPgIyuBg63CSuOXNg9f6uH1qYiq6PzlMtUC71Oa4nVgPBn
         kanXBBuyjpcGaLjoX/WCdVyZim/wUJyDSQBG0AU+KHkoVinHlkJjiJx7vDI3ZYhflypT
         d60BBLsV25iAplOzPJNRIM9G9DTnI5eB7vqNEGoDnUhoXKR+fP7js11uDLyR0gO/x3j7
         Qkc3h/JS6SrwJBDpOxJDP3xzWx9M26Ev4IDFwIVYDG2+JJS4hh2N4tmM7bRgysZE/dgQ
         GQ1GRC5asAcK/EVlcrjv/7uab5OnEnCYTImyaphQtVZsxNAnaolr8EBfv1VYCc4yazfG
         E4Tg==
X-Gm-Message-State: AOJu0YwV3DqOwpA8C+xNpje59pqiEDawaoB1Mv0S7Kaa5Dh8ehj60wDm
        8KLv2U+6v4ZIG61CMsrmn3d26hBS+tTwztSUiHY=
X-Google-Smtp-Source: AGHT+IF5ZBTO7QiWw4xTvVd+B3q3ehY9+Ycy1W6mKGBOOj4I7HzYIHeq5Bbj2xmbkE4AAauc0kdHbiBjIYJV9jGZXm8=
X-Received: by 2002:a17:906:2ce:b0:992:2f67:cd34 with SMTP id
 14-20020a17090602ce00b009922f67cd34mr2852930ejk.22.1691676021456; Thu, 10 Aug
 2023 07:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230805035739.376502-1-szp2017@gmail.com> <2023080933-customs-undercoat-ba4d@gregkh>
In-Reply-To: <2023080933-customs-undercoat-ba4d@gregkh>
From:   Leo Sun <szp2017@gmail.com>
Date:   Thu, 10 Aug 2023 22:00:18 +0800
Message-ID: <CA+_ZtsLVD_aL1Hf1b7EFsGTp5hw+jnGDDCeMhiqg2zg9u8xB1g@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: Change camel case variables to snake case
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     forest@alittletooquiet.net, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=89 20:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 05, 2023 at 11:57:39AM +0800, Mingzai Sun wrote:
> > Change camel case to snake case.
> > Issue found by checkpatch.
> >
> > Signed-off-by: Mingzai Sun <szp2017@gmail.com>
> > ---
> >  drivers/staging/vt6655/srom.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/sro=
m.c
> > index ee5ca4db74dc..812964ab68c5 100644
> > --- a/drivers/staging/vt6655/srom.c
> > +++ b/drivers/staging/vt6655/srom.c
> > @@ -49,7 +49,7 @@
> >   * Parameters:
> >   *  In:
> >   *      iobase          - I/O base address
> > - *      byContntOffset  - address of EEPROM
> > + *      by_contnt_offset  - address of EEPROM
>
> Why did you keep the unneeded "by" prefix?
>
> thanks,
>
> greg k-h

OK, I will remove the "by" prefix in the second patch.
