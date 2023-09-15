Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776B37A1AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjIOJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjIOJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:16 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B12120;
        Fri, 15 Sep 2023 02:40:28 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-450711d9bf1so996360137.1;
        Fri, 15 Sep 2023 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770827; x=1695375627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SQwjS7ofEY3BmnB6XlSScnPY+TTFSiJdRbqLvDODLk=;
        b=nNF2ZYwDJ/c3jOJLvqa6uwKF9sa/LZLVxADlhyFP4JmG+2eXv9uP8ywEWnoYvkbkDb
         YTlM4g1rmNpre7c06vvkjoKdU1RG/Q2tZlMKk0awFTXJN5clBoW9NBxuR21DD86AJtEH
         EaTFvKy4uMkfhyp1RKIObCFhFU4W33rlW2TMDGwcnAZL88ttTcjuJrI8kiCq06hyrhaS
         Ow0Y2UMwlgQLlCtr52pyOsLKop+mplO1u9lLWndL70v1FKiQCul+xIdEmG9mYVvP4RV/
         XQTm0OL33TYAhk/y95LDrw5FWO7pPkflts2lOzyAPlfgto0v/yqu00z9EqhtT5zvd8tI
         xk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770827; x=1695375627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SQwjS7ofEY3BmnB6XlSScnPY+TTFSiJdRbqLvDODLk=;
        b=KDmMUzXacCbeDYAXd9i66E3GnY9ypBxs0Smk52wkGUyevE96lXzPOIrvB404HS2/oR
         aQfLGYzhQLaBZzsCz6MqimAvghR9vwvUTE4tpHjj1EgBLuwtHl1d7LcgFsTS1FRej+YD
         wGVSUbdJs+fOgzCf/389fY5IJilr7J+Cr7snZb3hLlXO5YCXbF7fnD2yMYDi5svlLb4C
         fgf007UPcvnwBi+tjzdRVJUyrzMue/D9YjVX8fQvg5vaSVaCsoep9jTIqcxosFXODRKX
         4lbUisK96qAX4J4+wIUfwjJtRD3ygfmxuioz/zC+eFUWANaFVqE6AERvlRzTJDkS/iti
         +qqQ==
X-Gm-Message-State: AOJu0Yx2rkcDCR/sE0ijt2ipCH0LkQ+5MLNP+TZ+czXnidEF1RcY5GIT
        j1ixllOdvWQUkMtjAqGXDgPH2ywBB5SnZSvkPkY=
X-Google-Smtp-Source: AGHT+IF6F+KK+xxY8wShikRd1yZi0PTbzDh1EUfn99R9HK1S6FkpzKMbRma/EdRdraYf08DCkiqmvGlQyNPf4qdzn0c=
X-Received: by 2002:a67:fb07:0:b0:44e:8ef9:3369 with SMTP id
 d7-20020a67fb07000000b0044e8ef93369mr1252411vsr.0.1694770827130; Fri, 15 Sep
 2023 02:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230908095330.12075-1-victorshihgli@gmail.com>
 <20230908095330.12075-6-victorshihgli@gmail.com> <CAPDyKFoCj=XGaCXzEGj4FbuNF=ds_XwHgF5FHqix4e4Pn68g1A@mail.gmail.com>
In-Reply-To: <CAPDyKFoCj=XGaCXzEGj4FbuNF=ds_XwHgF5FHqix4e4Pn68g1A@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 15 Sep 2023 17:40:14 +0800
Message-ID: <CAK00qKChhvbyLQ2sT1xYxffcHjCriapU1ya2vZ3EixURnGTQMA@mail.gmail.com>
Subject: Re: [PATCH V11 05/23] mmc: core: Add definitions for SD UHS-II cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Thu, Sep 14, 2023 at 11:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Fri, 8 Sept 2023 at 11:53, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add UHS-II specific data structures for commands and defines for
> > registers, as described in Part 1 UHS-II Addendum Version 1.01.
> >
> > UHS-II related definitions are listed below:
> >   1. UHS-II card capability: sd_uhs2_caps{}
> >   2. UHS-II configuration: sd_uhs2_config{}
> >   3. UHS-II register I/O address and register field definitions: sd_uhs=
2.h
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
>
> [...]
>
> >
> >  enum sd_uhs2_operation {
> > @@ -358,6 +381,7 @@ struct mmc_host {
> >         u32                     max_current_330;
> >         u32                     max_current_300;
> >         u32                     max_current_180;
> > +       u32                     max_current_180_vdd2; /* UHS2 vdd2 max =
curt. */
>
> Looks unused in the series, please drop it.
>
> [...]
>
> Kind regards
> Uffe

Hi, Ulf

     I will update this  in the V12 version.

Thanks, Victor Shih
