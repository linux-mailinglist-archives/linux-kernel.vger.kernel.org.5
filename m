Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C237A72C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjITG2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITG22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:28:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B89F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:28:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E47DC433C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695191302;
        bh=dWTtYLiXevvROWNf44v5vlbKB2jrmNZUUhZpwh3HA0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MKQZlOKjyaqitmYeIrmw0T7gUCuFi6a4Ec/Jp1gilVzK96z9/R6qbqc3UoxuTSXZc
         wICa+IsOiOWYGGOt4u7jTsTQ1pnudOq8Pr35xxs78Q7HYsuDmwUhH07QvAph8bcwPS
         SdvMAUG/+UDlG9QMu+nXvPFqW+DtSwhnHtOwN2aSo7n4/VMr9CskwknWmKy2Cbu7JH
         CLUOoRPnBv4WDbl5L05WgNkRv0pwNbCobYK/t+Z29jJSonYDNc9bMKhZ5DCjsnILdJ
         SM9Gq1gT4ibxvZSn/XOXo6EeSoJTpPZlF1rhBSRRsRUAodWFsmQTly617v1spbiABu
         JYEeH+xlhRboQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-502e6d632b6so10132851e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:28:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmKxzgVYy1y/r7SYyu6noiOXIZY+Ih0/IceuHgqzjNtHzZFN6K
        8PerQK41M1DRHC8hr3peayY/OJTpR/KqbZWdJp4=
X-Google-Smtp-Source: AGHT+IG9jdqZMTkppptA+UP6abajo9eKEWATWuIrrr0su0ZAMr5pDuEa2WJrGhmF3aDIu3f9n4KvTVs0Pa6QyK+NR9A=
X-Received: by 2002:a19:2d15:0:b0:500:acf1:b432 with SMTP id
 k21-20020a192d15000000b00500acf1b432mr1279251lfj.63.1695191300666; Tue, 19
 Sep 2023 23:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <1695114428-20308-1-git-send-email-yangtiezhu@loongson.cn> <7aa1e5a0-c161-08d6-a2fc-0d4f65148b01@loongson.cn>
In-Reply-To: <7aa1e5a0-c161-08d6-a2fc-0d4f65148b01@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 20 Sep 2023 14:28:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74iDp3Sv8CaJAoS1yEUYsQFkNRVABSNYz23zXAqnCrfw@mail.gmail.com>
Message-ID: <CAAhV-H74iDp3Sv8CaJAoS1yEUYsQFkNRVABSNYz23zXAqnCrfw@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: Remove dead code in relocate_new_kernel
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Tue, Sep 19, 2023 at 5:24=E2=80=AFPM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> Not need my tag. Youling found that before, and simply talked about it
> to me.
>
> Thanks.
>
>
> On 2023-09-19 17:07, Tiezhu Yang wrote:
> > The initial aim is to silence the following objtool warning:
> >
> > arch/loongarch/kernel/relocate_kernel.o: warning: objtool: relocate_new=
_kernel+0x74: unreachable instruction
> >
> > There are two adjacent "b" instructions, the second one is unreachable,
> > it is dead code, just remove it.
> >
> > Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> > Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> > Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >   arch/loongarch/kernel/relocate_kernel.S | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/k=
ernel/relocate_kernel.S
> > index d132525..f49f6b0 100644
> > --- a/arch/loongarch/kernel/relocate_kernel.S
> > +++ b/arch/loongarch/kernel/relocate_kernel.S
> > @@ -72,7 +72,6 @@ copy_word:
> >       LONG_ADDI       s5, s5, -1
> >       beqz            s5, process_entry
> >       b               copy_word
> > -     b               process_entry
> >
> >   done:
> >       ibar            0
>
>
