Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490B80A171
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjLHKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:49:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A93115
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:49:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso6520a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702032594; x=1702637394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3ICmYU4vtByBj+ZOAeC38kXJDhlJqpO3Ji47gj7LUU=;
        b=oHdHL+EcaALLHM9gAbj3yE1JWxJMVYcqZI80gPo2PqtCWrWeRcgDpt9knkF7OcUq8y
         B0/MfEONtWFD3cqHSLbdm7RqqNcG6czi82Wxd8wmSn/XeD3sya4AvoaucdJ/dMngmduG
         Lr3SpHNJSyfDeuqfs3FQoTP8dHknDCM26LhlEUSqVjc12qMfiJnzQbwHvucawX8AKlTb
         S0XPzLrchJ/+pDs0rVyeQKKOeEfhwLLNBrtLQPpHJ+HBitdaKej5Ssx3Ed4zM5AJGrS+
         Nj/UEBBKoYoplgcA6JxJqoEd/LOVhH0hAZeaPKnpNvrKTCahFtrxGdpRzFli7eB+gJ3S
         iWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032594; x=1702637394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3ICmYU4vtByBj+ZOAeC38kXJDhlJqpO3Ji47gj7LUU=;
        b=VAIy3R2U+zV9btK4cjO1n0aMrw6l2fbIFqfn9DgNAK0AuqFf2VSFIqcyXAs0X2oFyS
         D9t7r08Xk/F7tUJmjN+kW0QwLtc44wdbYtM7otq3W2oX64IlSfLy+u505RRXsFsbwxfX
         AtrX4n9OyxsEAvWrS6wMcL4XpDfqYg+xPIfsS9K5VVhpxzKWObVULYrWfCIMZmKTYJHK
         rHiiO2lGo4rq4zQBGmWw2QpGq0aSnUQvx88/jbTbTOvRnEUGlsZK2i4f1IwMLROLlnZU
         Ljvnz/fiv9YcoTxpWHyaF0w4TwQH+8zskA/sxafItCGgB8m7E3yuLmPzlY3fQxDH2hSc
         rpIw==
X-Gm-Message-State: AOJu0Yxd0ruSVrc/r+A+lOTfepYSXEbqKuR0/afgADnJH2Z+dDog9FK2
        bb4VNzULS3NQ25pqB/HfREf3EdhABS/HISK5LIBRQQ==
X-Google-Smtp-Source: AGHT+IFJgvPxeKl+froO/n1xOLoH9c4jeQ7frZ9rnypL/gsx3xc0licEqthQwCs4B2IITcdsRQfKl5Yh550YZOykElg=
X-Received: by 2002:a50:d7ca:0:b0:54a:ee8b:7a8c with SMTP id
 m10-20020a50d7ca000000b0054aee8b7a8cmr45593edj.0.1702032594082; Fri, 08 Dec
 2023 02:49:54 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com> <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Dec 2023 11:49:40 +0100
Message-ID: <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
Subject: Re: Bug report connect to VM with Vagrant
To:     Shachar Kagan <skagan@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>,
        Topaz Uliel <topazu@nvidia.com>,
        Shirly Ohnona <shirlyo@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:03=E2=80=AFPM Shachar Kagan <skagan@nvidia.com> wr=
ote:
>
>
> >> On Thu, Nov 30, 2023 at 2:55=E2=80=AFPM Shachar Kagan <skagan@nvidia.c=
om> wrote:
> >>
> >> Hi Eric,
> >>
> >> I have an issue that bisection pointed at this patch:
> >> commit 0a8de364ff7a14558e9676f424283148110384d6
> >> tcp: no longer abort SYN_SENT when receiving some ICMP
> >>
> >
> > Please provide tcpdump/pcap captures.
> >
> >  It is hard to say what is going on just by looking at some application=
 logs.
> >
>
> I managed to capture the tcpdump of =E2=80=98Vagrant up=E2=80=99 step ove=
r old kernel and new kernel where this step fails. Both captures are attach=
ed.
> The tcpdump is filtered by given IP of the nested VM.

Hi Shachar

I do not see any ICMP messages in these files, can you get them ?

Feel free to continue this exchange privately, no need to send MB
email to various lists.

Thanks.
