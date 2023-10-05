Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC077BA8B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjJESJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJESI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:08:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2753910C;
        Thu,  5 Oct 2023 11:08:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1114936b3a.1;
        Thu, 05 Oct 2023 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696529297; x=1697134097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfEzaAYRoCM2oEhK3EPu0Hj+aznJeUYqKLfmZ+hOYv8=;
        b=WsHaJihvvvT5MNHC+joG1dLs1P1KfBpmv4qOEAh6/rJM83ZYOJMS/maGRAp0mG3IBL
         dLIb08JAyKIcY/f0DN87khZoyEo1+uoaWP9zpCh1pfg5RhGuO4TrBBH9h+hGS5NxPmsu
         r53z7wRwpazmCfIMaAwh2TVZ9rdnDIaDXT8rjzg7SYCHv5YZrKVEXEnmfu2rx4YGztkN
         Hz9Va55ZtFzWCzj0tg49KeEFIzynflyXseMaX5kBEhOYgfm2E3lAEl1839oHu8fvUafb
         4yhpiqMJQMniAMnE8Tk0LJ4QoaSVMehPzIjkdzwcWt9cjTvUTmJ/ao1ZjE1sbUpjc/ea
         Og+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529297; x=1697134097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfEzaAYRoCM2oEhK3EPu0Hj+aznJeUYqKLfmZ+hOYv8=;
        b=xLLrFl9UogEvemoJQOUWCmNqtBeqeJ/KbQyqzTm8cUIYIyYxTbQ1gxWTMoMAxSYfVa
         6rlXv5Tt/SH/XLSSQULpga1BIQsF+PB+urZUuwOYCSPoLZbtXP1HNosLAh/JWtuaY9Aa
         RU7V5HlRFwHmvw8KwAK/YWbWVNN3+Ax7uibwMCJJg3yr1FNZwXvqw/psMprO3kJ/5gAB
         6xwJV0+sA7sbk3gAs8y1XJyxSLAmZoVPSWJlE/XL2O3OTpgB+w3Pi5doZeYZI1ijK3lf
         x1AKpUr9bs0QTy7Jvpyq1GkNNlvOaBj4GOxGlyFbtyB1RdvLdn1A2gDqBloMMQcrXEUB
         SzTg==
X-Gm-Message-State: AOJu0Yy+iCxp6jldsSwTVO3+x+7ARvl27vnFCZW6b74TfOzub+r9JxbY
        vQSx3xWmogcs0K2ruOzJW4wQO6TPcSf7cKcbOufmSSAN
X-Google-Smtp-Source: AGHT+IFOG+VTMW5ABa9pOxr064JFqjVAEmKuoVs/Erlx9kb8Kl9x4XYI32ZOw4/gAlXpDkbzvX4OakRvWMT0o+RJRfw=
X-Received: by 2002:a05:6a00:10c1:b0:690:c2b3:e4c5 with SMTP id
 d1-20020a056a0010c100b00690c2b3e4c5mr6733619pfu.4.1696529297534; Thu, 05 Oct
 2023 11:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me> <20231002185053.GB402943@wp.pl>
 <CAEXpi5StYwujiTaH2_5PE9Hg_cgzAEtBuFxfgVxEJvbqRNv_4A@mail.gmail.com> <20231004182826.GA411448@wp.pl>
In-Reply-To: <20231004182826.GA411448@wp.pl>
From:   enc0der <enc0der@gmail.com>
Date:   Thu, 5 Oct 2023 14:08:06 -0400
Message-ID: <CAEXpi5Qw8g2-=FPiSrmh4va22dg6jP8bT2bAcR5WnPUKMD5byA@mail.gmail.com>
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
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

On Wed, Oct 4, 2023 at 2:28=E2=80=AFPM Stanislaw Gruszka <stf_xl@wp.pl> wro=
te:

> Here is the issue. We send the frames with spin_lock taken, in such
> case no sleep (i.e. schedule() call) is allowed. Some function from
> tegra/nvhost is actually sleeping, hence the bug.
>
> As already pointed Thorsten, those tegra_/nvhost_ are proprietary functio=
ns,
> which are not included in the upstream linux kernel, so we can not fix th=
em.
>
> However I can advice you to detach those from crypto_aead_encrypt,
> this should be doable. At worst your will need to  recompile your
> kernel with those crypto offload engines disabled, but perhaps
> this can be configured dynamically.

Thank you Stanislaw and everyone else for your help, super
appreciated.  I will bring this back to Nvidia as this makes sense to
me the problem is in their upstream changes.  I suspect the person who
was trying to help me just wasn't familiar with all their own changes.

> Regards
> Stanislaw
