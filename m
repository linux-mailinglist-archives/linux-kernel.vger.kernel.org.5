Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9EA7D871B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJZQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:58:45 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2A187;
        Thu, 26 Oct 2023 09:58:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b4145e887bso625389b6e.3;
        Thu, 26 Oct 2023 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698339522; x=1698944322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2My7dzj7Sa0rgTJc/yeT+l3xQqlYTaObutNlMsCM2Jk=;
        b=MnFU/W3vk7jj3RVRK1fLMfji3Dde0bSWQVYdbL9Un1JAhWVkOi38adM9PJ5HWe0bAN
         mkp2kPFmhLaYBsU1TVchsj5z6Q0sDru4qyLXCYPWbMhRduW28KN9uUYQypCWW6ZyffdT
         U6hic/0pCB/8ajML6u2TwPoK598yrjbiDeLe/9iaXiuSTC340gf5VSWRXHk8BVJb5Ury
         d3BMjgi0/S7eP3+4Sm6PwoA9VLPe4pl+Z0M9sOIfYV/ZzOs/q7CAo/Upm6bQrrB9c5yw
         5qHLyBiX4j+dljsmMr62HlwXHiYFA9POS5jtk/t03HDqAPeAn2TbsNjcbyRixcPkrg0n
         f/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698339522; x=1698944322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2My7dzj7Sa0rgTJc/yeT+l3xQqlYTaObutNlMsCM2Jk=;
        b=eaCoRc8UAuGSragxdAUfORnVsP1Vi/+ohvDkE1EbtlHduXtYQEEbvKw2O8ipcWAllD
         2PBUQTWMzoTzRsIdnQ0MYMC62uRKUIPXROqspRt788CEcaJmPHJ0/ZNVUZj8vHUY9I1X
         dk43Sa/1x6M6aqMfDPjg1vF28RTgUx8HfuKw4vSJu03TXz11MfodbuMRXPkiS3PJupsX
         P0j22AMXIeEIdUSHq6+u3Y2Nlj3LzrKxTZ1GPyCmQeJ5zBPOrfRspM2h2EFN9tPec0M+
         v5P3XnuYnVm8H3nwGGFOLdC1FYScEKQ/Lpy4sJ3D5Yj4uJLSWkbsJxIxQCRSMtnOuJtV
         b7kQ==
X-Gm-Message-State: AOJu0YzJxSuDaAE6ffWZOnZNnhGLF16+zI0HKDDjZKTcQhoY1cYstym/
        bZV5VdDoQGqQgcUU+uX7wgm2/oD1JjRqV1l+HcE=
X-Google-Smtp-Source: AGHT+IHYIEtTPq49J47m7L+kP4zWLW1jW3174fCj7Z5xpN8ntf/ECHptkhk8TAFzmkQ0ZcFZSrtrZcJRSuTa9xWZ1g0=
X-Received: by 2002:a05:6808:4d3:b0:3a7:2524:6d3b with SMTP id
 a19-20020a05680804d300b003a725246d3bmr18779047oie.12.1698339522590; Thu, 26
 Oct 2023 09:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231024201157.748254-1-alessandro.carminati@gmail.com>
 <5776666.DvuYhMxLoT@pwmachine> <CAPp5cGToUaPCr3Fp2PUQ1yQJ8ci+wTVqgTCEs2OxvR+yTr2oOQ@mail.gmail.com>
 <2162048.irdbgypaU6@pwmachine>
In-Reply-To: <2162048.irdbgypaU6@pwmachine>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Thu, 26 Oct 2023 18:58:06 +0200
Message-ID: <CAPp5cGQsm9jJw5dktGbM1EpvU1wi1c+Bt2r+Lj=Wn_pBkt6oSw@mail.gmail.com>
Subject: Re: [PATCH v6] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Francis,


Il giorno gio 26 ott 2023 alle ore 18:01 Francis Laniel
<flaniel@linux.microsoft.com> ha scritto:
>
> Hi!
>
>
> Le mercredi 25 octobre 2023, 21:33:43 EEST Alessandro Carminati a =C3=A9c=
rit :
> > Hi Francis,
> > Thanks a lot for your feedback!
>
> You are welcome!
>
> > Il giorno mer 25 ott 2023 alle ore 15:21 Francis Laniel
> >
> > /* SNIP */
> > > > debug >=3D DebugLevel.INFO.value:
> > > Shouldn't this rather test nmdata?
> >
> > Not sure to understand this feedback.
>
> Sorry, this was not clear.
> Rather than testing vmlinux_file, shouldn't you test nmdata_file?
Now I see your point.
If the assumption is that scripts/kas_alias.py is triggered by
scripts/link-vmlinux.sh I dare to say that it makes no difference.
But, since the purpose of this work is to manipulate the nmdata_file, using
it is probably fitting more the use case.
>
>
> Best regards.
>
>
Thank you for the precious suggestions.
Regards
Alessandro
