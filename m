Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A27F2D75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjKUMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjKUMnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:43:43 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A36C1737;
        Tue, 21 Nov 2023 04:43:24 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1efad296d42so3152592fac.2;
        Tue, 21 Nov 2023 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700570603; x=1701175403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWs/sIT+1KSg47YeqTn9W143kVUGwRJkzIfl+F6CuZM=;
        b=RhfKh+HHXYXSZqJgwn39ncpxWd6E5RXOgOrz8xxkVvZA8eQbeza4Yju+ONBvzKil4E
         348khJFaVUIeijxqdJ2V+wCp8WyfVYtfm6d5Mh3fue4EU5JdllB8UBuwxaP5vaCJF/Oe
         NXHTahyH+cFAkQVkMY6+sfoJkE9GUqAO/POt6BqM4J1w56r+zyjXWZff/I02IEMS/Yb6
         jggE6kTUQIkr8RPE0kaSI2pK3DK8HJww/uwzO02Puo4fZzqX9jjXjgknsArwTwTcTBEf
         YsNxK91baPNoIKUkI9SVtjrauFzzSkCkLgy1uF1sYrlhhC3j+seXueuaHagWqy56BFFW
         wgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700570603; x=1701175403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWs/sIT+1KSg47YeqTn9W143kVUGwRJkzIfl+F6CuZM=;
        b=hzDVQ4XvVv6FI7IWqQY8rVuoxM1iMhll28UdT/bhw90h1dV6n8nvL9WfKkMGqKtxzv
         fgJz9B02RaAanhZ0xkkcRfGGJWJ1MS6THwxSWwz7wtEElQdIaXJIgXWeDs0UPGNDOpsj
         XnPmw2vidbT/2gp5xzbwBMv8bVQBDArU40HysDD/x2pweX/ez+fFSnv/9B8I+mZls0FC
         9Uov7/3Nu2AVRrSi2DFp5dV4wc4HLniiOCQJzVTFbxqzOB3m0BHB7gf96jwNrg7kt0v0
         2sFUjWfOvSCkeNJ8UmXg+0D5eF/E58cWKkJ21rbuHxNpwQdF9S9HnCdoXSc46WXWgw7I
         rf8A==
X-Gm-Message-State: AOJu0Yyq7ljDXB/3T5q3PocarCbEQFXZd03Tg2WBI8IxITwSlO1pwX3s
        EX5f6kgFvQLd3X39gCdsmCtcRhNyFi0k2tjNs+s=
X-Google-Smtp-Source: AGHT+IFN+njx0aJFbK2px0pJCmVmGIliVkNyf/j6VA8XPL9BCOjdyohbS4GG4rsgxmttbgcqfn9SsA0QGM4CGzB2c/U=
X-Received: by 2002:a05:6870:6ec9:b0:1f5:b4c0:d03 with SMTP id
 qv9-20020a0568706ec900b001f5b4c00d03mr10791330oab.59.1700570603692; Tue, 21
 Nov 2023 04:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com>
 <513bc341-25b8-5a57-d760-861a3e88a4a1@linaro.org> <CAMhs-H8A0p=nFSnU9pRn=rTC_=CH6jXFQdYgZdimFNq9+dVqSw@mail.gmail.com>
 <ZVxlRE0tcAv1iaoA@alpha.franken.de>
In-Reply-To: <ZVxlRE0tcAv1iaoA@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Nov 2023 13:43:12 +0100
Message-ID: <CAMhs-H8bs89SFWPVOEJFT6B+zYh2Anf=DqCJXNaq=Tjiq5X5Ow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        linux-mips@vger.kernel.org, john@phrozen.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:02=E2=80=AFAM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Nov 20, 2023 at 08:59:25PM +0100, Sergio Paracuellos wrote:
> > On Wed, Oct 25, 2023 at 2:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> > >
> > > On 22/10/23 11:06, Sergio Paracuellos wrote:
> > > > Its been a while since I am making contributions to this architectu=
re.
> > > > Hence add myself as maintainer.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > > Hi John, if you are not ok with this please let me know. In other c=
ase
> > > > please ack this patch. I can add myself as Reviewer if you prefer t=
o
> > > > maintain alone this.
> > > >
> > > > Thanks in advance for your time!
> > > >
> > > > Best regards,
> > > >      Sergio Paracuellos
> > > >
> > > >   MAINTAINERS | 1 +
> > > >   1 file changed, 1 insertion(+)
> > >
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > >
> >
> > Thomas, can you take this patch through the mips tree?
>
> sure

Thanks!

Best regards,
    Sergio Paracuellos

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
