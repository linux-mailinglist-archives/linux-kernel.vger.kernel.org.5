Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0298094F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjLGV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjLGV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:57:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AAD122;
        Thu,  7 Dec 2023 13:57:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1f0616a15bso125561866b.2;
        Thu, 07 Dec 2023 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701986254; x=1702591054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1UBPKwUkAU+wrKbpjbMF7X3FH5KwgZqLzR/JtIscjY=;
        b=bpWXPe6lJsMhRC/P3uZcEkNboF6VGbfA6/c9wvShblv4DQCIYAHaSlXc332R6hp9vK
         WZRSNIKBTtWKwZcztaRLfSyweHiohun94hzGvwo5KpOOoZ/StcG4Ev2SQcZI61G51MQl
         YdwTbMvCnPtiHAr3mA7vyBVVv7djZxIZ/Cut61laXvF0hUrAjwdYIo4RtkPM48DrrdWM
         SZmGV1f8g4lsfe+Yi+8bgDkbcqchEY4AEsZtSnIBgtxJDxJ8M3RPgnTSJXyajKgfqUZz
         GjqKpMAt3f0/Kk7aDcMcPgAyA10ZofSOfPVkCiWuCA6xq5ZoYdUcbNTnMYELbW6cfd4D
         Yc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986254; x=1702591054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1UBPKwUkAU+wrKbpjbMF7X3FH5KwgZqLzR/JtIscjY=;
        b=wA83vsEWZV77E0u2dpAkPekFjMsgPXveFabJZiOZbx5uct21wAcjLn4XopaA3qsEOv
         3hhg2Ik0Y8F1CA4j/kIrspKB4Bee0zF75QeUIOs/PN+XiN6D/fqGAjpz893hsp4X52Gq
         hZstfQUEEDwD0Ner/XswFYXGYl2lMGaq2YWkIvZ7WGFj02NwuMtxhcwhuyxyUgNFrPEx
         eKgFn32F+tGMvQLdFqrVIMY4E4g9tgTHNJz4oBus+UKgzuzxxx0GrB71AdWXveYbaKca
         5ZwXHbJk6W3KeehA70SI79bDu7X5ilk93jqu67apQr8n846pT2tEoevWyNIIrcrqI7p/
         UGTg==
X-Gm-Message-State: AOJu0YyQSmnJkA+IF+vpcSQ1k5rVjltazHedtlo3durri+v6umUGHmVs
        98bw0AcSGgwWpiI1Yg3gsxBcLvSfu9JNHNXo460=
X-Google-Smtp-Source: AGHT+IH9pQ0kFIBWnVfD34zZ6fGAqbnvAM0QYuLJ/wbuApqcs59iOKHO+XR0uOCqrX4RrCDTseHCa2NN+Lq+rQcGOw0=
X-Received: by 2002:a17:906:2201:b0:a19:a19b:78a5 with SMTP id
 s1-20020a170906220100b00a19a19b78a5mr2307052ejs.104.1701986254278; Thu, 07
 Dec 2023 13:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20231208084758.67fbd198@canb.auug.org.au>
In-Reply-To: <20231208084758.67fbd198@canb.auug.org.au>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Dec 2023 13:57:21 -0800
Message-ID: <CAEf4BzZJPir0e47D==r9NB=fNyT2vSSGhUFyfYfAkmeJVKnP6Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrei Matei <andreimatei1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Thu, Dec 7, 2023 at 1:48=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Commit
>
>   ec32ca301faa ("bpf: Add verifier regression test for previous patch")
>
> is missing a Signed-off-by from its author.

My bad for not noticing this, I'll fix it and force-push, sorry.

>
> --
> Cheers,
> Stephen Rothwell
