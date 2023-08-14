Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AB77B399
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjHNIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjHNIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:12:46 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC3CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:12:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-645181e1eaeso11804446d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692000764; x=1692605564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfpF5kDm63EBt5ohGs7vmL86MuVrwlglo2VI7V8Vaeo=;
        b=Rb1hz4RUcSRxa/c30bH0h1m8uWZUyIHQfpuvPoYg7v/f842qrxHfk9hTUbS9AG2pIa
         e0Z05bnMPdtrkVWwaaUtwMoJP+hNL6nrIVj1te0KsomEkfdYBW2xjYbQrGTnq2E7W2nF
         tTj0vV1uSbKSBMbeb5EXy7K8xakggtgTYxqGU6Q0TWb+T6Q2SeKOMvXCvDxx3Ylyn96B
         89gSCsX5NCQixbDkl5gsa5q5XKBYZfstrrSdPEomZ2JqUkJ0t5qAzHkKt0uOWRdWpQMq
         kAHQqKiov7V++3IkB++9gxGf95f5A5tNVeVWhCj4QglkdYaCMnMaNVXeHAXsoCgP79ZI
         1YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000764; x=1692605564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfpF5kDm63EBt5ohGs7vmL86MuVrwlglo2VI7V8Vaeo=;
        b=NIExTB4QKnBp9JIc01vcNK6PAS81PcWmU5AGUMB/GcfcFrxGjWjMm76hKcRp5WhNlj
         963RFZOF9Tpfk8OeKAyKhZlBg7jn/158IecBusz4R8c5yoF7ijvayeJ6MY3VsoKMNeuJ
         Ao/wlWziEyeMLSbri2vkNeyPRedYcRJSjd0yR6yat7sygAqIB2gcS1Rd21gM9hrSyvbc
         zLeZeoYDMY0ooDYK3iLLpa18jztxDlwoIWhlg3YjyMB3aalVB4w04wihKNFGUWKwTmSG
         MFhXEwejRufEfDzCYXsKmcMerovc1WzAnQeWkHhRp0aS+qoL9pKXDuRSLHknSwX2vR2E
         C7xQ==
X-Gm-Message-State: AOJu0YzSZ0dxonjDykzHdGYWfM98Yb1OTnAzQSf4TELwuBA1y0J+R2OO
        TlLqnt6Nzfm68ewwSUCoT8OcpTf5viyV0E02ObicDQ==
X-Google-Smtp-Source: AGHT+IFEDDJKw6ZhwBUIBGO4ImSwSFqPJO6+AilymT5ZB0LA6prep/8KRuxI+PIzicRe0EosSX2MBaZZlXfEqu6iNzI=
X-Received: by 2002:a0c:b2cf:0:b0:641:2c51:7726 with SMTP id
 d15-20020a0cb2cf000000b006412c517726mr8622313qvf.37.1692000764598; Mon, 14
 Aug 2023 01:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230809135042.2443350-1-nick.hu@sifive.com> <2023081143-flannels-verbally-9d0f@gregkh>
 <CAKddAkA9TZs2vVCzBWtfgo3gYJsrMMmsDMtA22iEMM3ok9TgPA@mail.gmail.com> <2023081432-level-prelaw-3794@gregkh>
In-Reply-To: <2023081432-level-prelaw-3794@gregkh>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Mon, 14 Aug 2023 16:12:33 +0800
Message-ID: <CAKddAkDdr9ymDkyYJBznkPcePmfLN5MpRMYYYArZx+2FoAiX1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Add Sifive uart suspend and resume
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zong.li@sifive.com, jirislaby@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Aug 14, 2023 at 2:02=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Aug 14, 2023 at 01:55:58PM +0800, Nick Hu wrote:
> > Hi Greg
> >
> > On Sat, Aug 12, 2023 at 3:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Wed, Aug 09, 2023 at 09:50:41PM +0800, Nick Hu wrote:
> > > > Add Sifive uart suspend and resume functions for system suspend.
> > > >
> > > > Changes in v2:
> > > > - Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
> > > > - Remove the unnecessary check
> > > >
> > > > Nick Hu (1):
> > > >   serial: sifive: Add suspend and resume operations
> > > >
> > > >  drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Does not apply to my tree :(
> > Is there any reason that it doesn't apply to your tree?
> > Which tree should I go?
>
> Which tree did you make it against?  It doesn't apply due to conflicts.
> Perhaps either regenerate it against the tty-next branch of the tty.git
> tree, or linux-next?
>
> thanks,
>
> greg k-h
I'm using the mainline linux kernel.
Thanks for the information.
I can reproduce it in tty-next branch of the tty.git!
I'll fix it in v3.

Regards,
Nick
