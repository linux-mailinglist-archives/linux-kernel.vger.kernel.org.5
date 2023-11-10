Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FC7E7FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjKJR5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjKJRzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC339775
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:43:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e62b14c9eeso115826566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699627390; x=1700232190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gobI40BPKK+96YpOKnQSTXJZCsxZiafQGj1gJsPnJSs=;
        b=ReeLltEy2ujSVJCfGNqCzCoTg7HY7rFFmoleB4g4qIx4G8nq1H3h9ck93mMFq3QGin
         LZ8MR0SihhAHxZWeb6UBzmIBXz+/5XP78HT8kliAzN2Yet0nqv0wgcVmkMJaCUZgzJA1
         qRd6wY8nvUQq6xDrUyE+3jz222MLK4ZR6v2Eag9+7LwkQabQhXB+mPloWXkizq9kH4Mm
         rPEv60dmtj5PA+5+0PK+axtISXFoPkuJf4nVeDGujM/+Ehp9lDz2n6lnaTYkYn0TBgBa
         /LCl2q+edAqsiJ7MiAnP0coEmOCWFqPAer8flH3BXQ53ckgbV/yGnZGHkBoWyM4cQXHh
         VAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627390; x=1700232190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gobI40BPKK+96YpOKnQSTXJZCsxZiafQGj1gJsPnJSs=;
        b=jvaCNwJSpQoJwE7ZDCRVGXonVsNrmUlred76FmSHvKIjh2qFmmZtBNLZW2dZay1ba/
         I6AbaIWlv4XS/ndx7eLmj+WcQgMFjLkd+0ciFB1LGQ1+W+GGlzuj6R/o+O3lNQ+7r1ya
         ANEPlAXYvWV48JeCJQFrhjbM2aAGBiRZCxjQVI7HmbE45s2bIyKwO8Ixn4H+tSiej2FE
         oNOGWzch35i5i1u1JQcyttnNnbcbTtu/UJRMfJ3zMo5JRzsgM1W+q2ogwLF3hJ0LG3vQ
         f3WPXtiEab2VyYxvVQUKpP1tLkMx5RjOLkMqslBGj0Eear6ZBnfXWN5GtrbFcx0aUEr7
         +zjQ==
X-Gm-Message-State: AOJu0Yx0BNLvXRMvmzi0Be1r4rRxRw7LYbseoTyeeujrXPHha8IhYoaq
        64OqdYSAFcWFS8eddL67vjR9kzGvuJD2yHSq4bkXIg==
X-Google-Smtp-Source: AGHT+IG5XrEFOjydF0/48AablD1bWhoB+SxENpryj3/dCn49GuCQ2BcmRtFttvt8r8S+EtFSK2by6UsymintHZPdiPs=
X-Received: by 2002:a17:907:a44:b0:9e0:eb06:2047 with SMTP id
 be4-20020a1709070a4400b009e0eb062047mr8033584ejc.34.1699627390623; Fri, 10
 Nov 2023 06:43:10 -0800 (PST)
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian> <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
 <ZU4CLCk1APrD3Yzi@nanopsycho>
In-Reply-To: <ZU4CLCk1APrD3Yzi@nanopsycho>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 10 Nov 2023 08:42:59 -0600
Message-ID: <CAO3-PbpdayZGWMwEyDYi3b47OEACQRzdy38YdOJiDq0ee55iBg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Weongyo Jeong <weongyo.linux@gmail.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <jesper@cloudflare.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 4:13=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 10, 2023 at 10:30:49AM CET, edumazet@google.com wrote:
> >On Fri, Nov 10, 2023 at 6:49=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wr=
ote:
>
> [..]
>
> >1) Note that net-next is currently closed.
>
> I wonder, can't some bot be easily set up to warn about
> this automatically?
>

It's funny that I actually got notified about an individual recipient
mailbox being full.. Side channel :)
