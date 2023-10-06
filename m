Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD37BB522
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjJFK1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjJFK1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:27:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7309F;
        Fri,  6 Oct 2023 03:27:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2773f2e599cso1416990a91.1;
        Fri, 06 Oct 2023 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696588069; x=1697192869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lySe1hMe8uGNZO8PPWsTJao8eRENoz2n4qp0tx6fqRg=;
        b=ZW7CKuJtK2Xs1PoiEO8xCgRm6BC39EqXTciRmOqtsBtaHVvKPOsATJoara4P+SaGcK
         M+cT9tlYhb0p0Q+DtckuZORDBIEdUHmZPJWa9rlAjQaHwUNy9UseZbHZba/fGuE75qV2
         VevkSm3jvfYE8rRCN/H1Zpmq3aX3q/cHLJ5CNRVF8aM9AFetqN/qMYXYWWXneWzMN0X0
         SUnG5fGMzjub941qfkU7KpfE/+Dx/voi+t32yC5hsbN6lc7y6iFOhRCRwvkAq+xDahqI
         1+PLyn0ouMNVGsGKFx2A4gEYm59jFBxlHZ09T6QVLde8CcwdjkXof+7fZeczZiysJaM7
         xS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588069; x=1697192869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lySe1hMe8uGNZO8PPWsTJao8eRENoz2n4qp0tx6fqRg=;
        b=k9sYd8lVDVfPYkZTHQsJDDSDbzP/NjHaPRjur2Fm+PFtBJoUR4TgzZ5iZrnpszRBtY
         tLVGyV48RNrQtUim/mvEs2SMY7Qt9tbe9UNoehGoYWPtEcF5y6eP6m4rhTLItHArTqzw
         2CtVihqIKcCJD2zv0RML82jXNIOa0nvqK7Tm79cCPgGc0nX1rcVBtAVWWPEQYvR9iGss
         e6tQadyXe67ECQnlg0sQwNMc6dZylRc8egmI+bnGG2t2NS11JcRliemuXwHL97RWyIiH
         QWurEVJAwPFg63wE/nzIjWRbqMqPaD0AVfCppBLx0DnUq+cm0JLJdGbM3x+m5za5a1YR
         /YTA==
X-Gm-Message-State: AOJu0YydMRu8T9UE5NOZBNqHx1u3YlIzEA6+dhiiZfbpdgpzfqNWxHRf
        H2SP6oiC2XJ3sAYXL9vp/EfrTwRrk1ZqgTSGqhQ=
X-Google-Smtp-Source: AGHT+IH6SXgFj0kmejgotdy2ONeMvmaauQTRhUwpyQJu2H3/YxhXrZu30hvf8PM6m0+CdwnGziyGnGt2LCRWHQBqFKs=
X-Received: by 2002:a17:90b:1801:b0:268:314f:8f35 with SMTP id
 lw1-20020a17090b180100b00268314f8f35mr7307299pjb.6.1696588068971; Fri, 06 Oct
 2023 03:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230928151631.149333-1-jcmvbkbc@gmail.com> <20230928151631.149333-6-jcmvbkbc@gmail.com>
 <2023100326-crushing-septic-4856@gregkh> <CAMo8BfJgpP-=tNEChcyR3z6i_QeJ9Ywq7EOjjC5i7Uq4OrgXNA@mail.gmail.com>
 <2023100544-rendering-identify-e0ad@gregkh> <CAMo8Bf+wS+qiX2mMZm0i8dt7xkDO8RvroP8RF=78zxgFj-zwaA@mail.gmail.com>
 <2023100625-water-molehill-4a8f@gregkh>
In-Reply-To: <2023100625-water-molehill-4a8f@gregkh>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 6 Oct 2023 03:27:37 -0700
Message-ID: <CAMo8BfLfBEQVTyBXw=K2wsgGF+ZUfJhffX4ax8kX+k_DPSOKYg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 2:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> If you only want your code being used in Linux, then stick with
> "GPL-2.0".  If you want your code to be able to be copied into other
> GPLv3 licensed code bodies (like Hurd and others), then license it as
> "GPL-2.0-or-later".  Your call.

Thanks. From that point of view I prefer GPL-2.0-or-later.

> > > Yes, but not all do.  If you don't need to do anything special, it ca=
n
> > > just claim to be a normal device, we've had threads about this on the
> > > list before.  If you don't need to determine in userspace from the tt=
y
> > > connection what device it is, just use the default one instead.
> >
> > Ok, it looks like having
> >
> > #define PORT_ESP32ACM (-1)
> >
> > in the driver source should be ok? I've tested that it works.
>
> Hah, I like that hack.  But why not just use PORT_UNKNOWN?

A lot of functionality doesn't work with PORT_UNKNOWN, e.g.
console or modem control.
I've got the idea of using -1 from this email:
https://lore.kernel.org/linux-serial/502240f7-2cac-4fe6-9e27-f9861db3666d@a=
pp.fastmail.com/

--=20
Thanks.
-- Max
