Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE17B0018
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjI0J2m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjI0J2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:28:41 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3BE6;
        Wed, 27 Sep 2023 02:28:39 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a200028437so7787237b3.1;
        Wed, 27 Sep 2023 02:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806919; x=1696411719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbZCD6ltUso31jdZjCWvFNyLqtiYopd8rfOZZMwIaq8=;
        b=Dho1zW87oKjVDlM/8FIlVGnTb21X7Hd2i80vEdFRjGi6SVQhE/QNIQVrUKqbegiZIo
         qd5EB+QBHzAwXIk/mhXn83C4JiuUouCW4e53+bofududvzSb81eYVHOZW+b7hnMFnnSu
         +Dg38ag0i4XQpVLuxwDdl0Zua62fzH0y9Gs5TvPA17aYFqEr3Ka9wvkAje+SaWq9Ji9U
         PHugdFmIznZR7CnExbc1fKlWpOVROcpkXbuYQl+/ufJmqq2FAShJ5fM9iThSrHUngWz2
         2KfWowMoqcVktRciYJ1QkUsCzV0SPyfE+cHEDnuzU9UTwnxDedIUJjBZw1MYOUtTvPz+
         7IpQ==
X-Gm-Message-State: AOJu0Yw80Yu1773w7kD0u8WpO08r4g7v1uADtBxZoErTNMfLeYIuleQG
        2xfub+hGRfAKDOR1W5Cqflc3Wi4JJ2QuSg==
X-Google-Smtp-Source: AGHT+IGz1I/BN/UCd21CejdXQ/W1wEeP7cTdDHTnzgeZfCmyS4DqVgXEzgCPHeNfxx8shyvQ4Bk33Q==
X-Received: by 2002:a0d:f884:0:b0:592:9235:4bcc with SMTP id i126-20020a0df884000000b0059292354bccmr1566619ywf.50.1695806918772;
        Wed, 27 Sep 2023 02:28:38 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id h68-20020a0df747000000b0059adc0c4392sm3558596ywf.140.2023.09.27.02.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:28:38 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f7cc71e2eso77116117b3.0;
        Wed, 27 Sep 2023 02:28:38 -0700 (PDT)
X-Received: by 2002:a81:4f0b:0:b0:59b:fb30:9862 with SMTP id
 d11-20020a814f0b000000b0059bfb309862mr1716025ywb.3.1695806917927; Wed, 27 Sep
 2023 02:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
 <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
 <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com> <CAPDyKFqgsHYz1hfOQ=KniNJj+u7ZSMoxS03Rixj1n2AOUdSVaQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqgsHYz1hfOQ=KniNJj+u7ZSMoxS03Rixj1n2AOUdSVaQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 11:28:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+ovx_Vbp1FQbvHESYrv3kHx5FvkjSb0V8dq857x5e9w@mail.gmail.com>
Message-ID: <CAMuHMdW+ovx_Vbp1FQbvHESYrv3kHx5FvkjSb0V8dq857x5e9w@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast
 warning
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Tue, Sep 26, 2023 at 1:22 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 18 Sept 2023 at 11:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Aug 30, 2023 at 10:24 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Tue, Aug 15, 2023 at 12:11 AM Justin Stitt <justinstitt@google.com> wrote:
> > > > When building with clang 18 I see the following warning:
> > > > |      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast to smaller integer
> > > > |               type 'enum pd_types' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > > > |        193 |                 add_special_pd(np, (enum pd_types)id->data);
> > > >
> > > > This is due to the fact that `id->data` is a void* and `enum pd_types`
> > > > has the size of an integer. This cast from pointer-width to int-width
> > > > causes truncation and possible data loss. Instead, cast to `uintptr_t`
> > > > which has the same width as void*.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > scripts/checkpatch.pl:
> > >
> > >     WARNING: Reported-by: should be immediately followed by Closes:
> > > with a URL to the report
> > >
> > > Hence changing the Link: tag to a Closes: tag.
> > >
> > > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > > ---
> > > > Note: It should be noted that there is likely no data loss occurring in
> > > > this case since the enum only has a few fields. The narrowing cast from
> > > > pointer to int will not lose any data.
> > >
> > > Indeed, the theoretical narrowing could only happen on a 64-bit
> > > platform, while this driver is only used on arm32.
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > i.e. will queue in renesas-devel for v6.7.
> >
> > As the Generic PM Domain providers were moved to drivers/pmdomain/
> > in v6.6-rc2, and now have their own maintainer, I have moved this
> > commit from renesas-drivers-for-v6.7 to renesas-pmdomain-for-v6.7[1],
> > with s/soc/pmdomain/ in the oneline-summary.
> >
> > Ulf: if you prefer, you can still take this patch directly.
> > Else I will send a PR after rc3 and/or rc5, like I do with my other
> > renesas-<foo>-for-<version> branches.
> > Thanks!
>
> Apologize for the delay, been traveling lately. Anyway, I can
> certainly pick up the patch and carry it for v6.7. Just let me know,
> if/when you have dropped the patch from your tree.

Thanks, dropped.

P.S. And now I notice it was never part of linux-next, due to an
     oversight in my scripting. Fixed that, too ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
