Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222417EF3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjKQNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:40:37 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658BD5D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:40:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so12114a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700228429; x=1700833229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbIdPz9RxKQrSbi01FLY0JWxLd7QT7QIjlLlTRp9Ecc=;
        b=xR0UUElRBfJ3icepXtDnsMSpm4/qIvn7QIj0wrt6UP5smFqQfAaZSKDWkmgUaWRoC1
         L+GfM9el6Py21gpiW4MVU4CCgmDRzYPfRHrsI1jD5NdlYhOY0A3AmRWcj7MT4zwuZ7eP
         mvfU7KUIpba4t3zaklPeOwE935cZIS3k/L+qjrFW1dDKHsbMJiEHBCyfzQnp2x/t5Hlw
         LYHFxpocdt5gnMxpBzuUHup/mEKnPyzCwdCvMIrnie5flaWoq8paDkMDMc04Njhsdrut
         FwJgDkB/g1rbXjdQZWz2vMVuY9IoC/AmmolUXyOUmed1xQmpy4sAR3aTneKZDa+B5IWE
         PFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700228429; x=1700833229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbIdPz9RxKQrSbi01FLY0JWxLd7QT7QIjlLlTRp9Ecc=;
        b=p+RQflh3NsBv09owh5DU1Xsdpl7jhaXR7ABYfX58Dsv1jlTaRH2WqNK997Dm69NI0i
         kosAnBSdx1zGVmh++QfQyk2tObRO11l1wg094U6eZmY1FMe5Xkxl66qyGtdZENVqRdyC
         znQIAFGGRWGoVNm2Xp2me2ZuE7JmU1PTZ+fs4F6jSpUHEASFHIthRBPBWYU6fP/T62K8
         Iubs2HX5jALoWLIW796XihJ74vGaauZKNo6V7sqQI/n+t1cQNy3AICw6UdbTYe+aKy6b
         iehZlmZcTcHgjoFTGjTr5gFom7CaWti+CFyjTEc6KcEt+K4Yns1e77/m8VO6HzDv7wuS
         p+BA==
X-Gm-Message-State: AOJu0YwfkJLs16Q71luMIFMEi67OGnljqDWgNAC9Z2tyZjupSj249L+c
        xvaQzENibjhlJ0pNHs79ezQjFxheRwrLfx9Eu6ytIQ==
X-Google-Smtp-Source: AGHT+IEupSlEu1yzsALFByjjXXmELNtFN4kBR/UiW3iIGKQMhu6Tj74chMJP4rSMVBj9CeSBaNOjE6wgrikuuGVIfOw=
X-Received: by 2002:a05:6402:3886:b0:543:fb17:1a8 with SMTP id
 fd6-20020a056402388600b00543fb1701a8mr113570edb.3.1700228429224; Fri, 17 Nov
 2023 05:40:29 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iJnjp8YYYLqtfAGg6PU9iiSrKbMU43wgDkuEVqX8kSCmA@mail.gmail.com>
 <20231117104311.1273-1-haifeng.xu@shopee.com> <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
 <76411980-e06d-43d8-8f63-b9a032e21b43@shopee.com>
In-Reply-To: <76411980-e06d-43d8-8f63-b9a032e21b43@shopee.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Nov 2023 14:40:15 +0100
Message-ID: <CANn89i+y1xzAH+m8W_nSyNXkTsJJOpf5NaF=_bEUA4YAAsTp0A@mail.gmail.com>
Subject: Re: [PATCH v2] bonding: use a read-write lock in bonding_show_bonds()
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 2:15=E2=80=AFPM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
>
> dev_change_name=EF=BC=88=EF=BC=89is either used in  dev_ifsioc(case: SIOC=
SIFNAME) or used in do_setlink(), so
> could these net devices which need to change name be related to bond=EF=
=BC=9F I am not quite sure.

You can change a netdev name with

ip link set dev OLDNAME name NEWNAME

This is generic.
