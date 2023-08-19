Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66644781B8D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjHTAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHTAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:58 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB431A7B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:57:06 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d73c595b558so2049732276.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692475025; x=1693079825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2OkEPIeAYw4ohf/KsWCW0AQVl/gXM5eBzhAQKoLWJ0=;
        b=n8WPHBDhIFNkRXn/dAFApuzd2532BKyIpitzlE89jLglaAQjJM4xBuVBEM7fxmu8qd
         wJPZYAPwTjEww2B8/SIyXumANMpCbaMmQgt2khFvwdbhEyi6NjJhiBUFFZsD8/MmWsvL
         kdSp73+CK0MewrCjmDdKcBpwDYo+8o4z2Kl8duP6Vrtqn2DaQ9f5e21VEaV6Nh+EkVem
         4Ky0iP2mbWO1wMcigweZPK9UsfPeTowZTUxo4VF58I9CVzfkrQFmYwTzg97YNlmNuCcd
         iJ7RaelsdRxYHVTGaaiutjFKk1Zk+zVqlgHyRDD51QVGUphMorq1cETyfnmBfC/8O+Ui
         EJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692475025; x=1693079825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2OkEPIeAYw4ohf/KsWCW0AQVl/gXM5eBzhAQKoLWJ0=;
        b=Qr2+L2dMJO3wpCS2k2BibnQI6vUlrupkpt3Ap/dVHOkboD+AVE/yRifVd5p43JzvGu
         2rYvGmXnluhsw9xSRwVVGhay7Tt8YwFU7tGN43CdH0g+/FcXrWt8+Y9mmCLrh4EtbLBD
         d/6vYhyWrUfqxTRF7BtDM65w4G8IgHt0LZog0IPcDee0J9e11b48EvW+NyaCTforhv4n
         7drKjl6wLv4gI9PuEYLGpT1a5W4FtJnAJG6ejx/GT8OAu+IVRzesuZ9ii29e9SbGk2LO
         xuHX+RkjfA7T2zlenQeyISgpb41d6CJJ4s2h2wVTer14bAeWrPNKSpn0V5n2KXWGX2V+
         lxLw==
X-Gm-Message-State: AOJu0YxT2lcAoSM1Pak6pkFCMtt39OC6cKHTNUC+BNOYrlYpFAXyx9F/
        AdrHFGedER0ZrmrYHn3ZUt2CiltKEtOu34JQMGM=
X-Google-Smtp-Source: AGHT+IETogeXJpAz7y9HeMQ29JEdVKxSYC9tJiKSGe0q2Q6mItI9wORoPN1AmANcEHuVyWEw4TKXlJsmc9ITgbew60Y=
X-Received: by 2002:a25:a28e:0:b0:d6b:6b53:d1aa with SMTP id
 c14-20020a25a28e000000b00d6b6b53d1aamr2974236ybi.35.1692475025412; Sat, 19
 Aug 2023 12:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230706185100.84322-1-hugo@hugovil.com> <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
 <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com> <7eb2d50baf269310e51854f700936e94@lemonage.de>
 <86wmysknde.fsf@davidreaver.com> <CANiq72nO04+2BcwBe_P0uD8pXJtTMG3djAFAj5Ucez6VvT4g7g@mail.gmail.com>
 <20230722140743.fe710f4f12c344f07d879c88@hugovil.com> <EC4DEACC-70E6-4E98-9A56-780F3E4079BA@posteo.de>
In-Reply-To: <EC4DEACC-70E6-4E98-9A56-780F3E4079BA@posteo.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Aug 2023 21:56:54 +0200
Message-ID: <CANiq72ku41N1-BJOODctCjo=2BrVds7nWy-YCVxwHpp7xhk0zg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear display command
To:     Christian Meusel <christian.meusel@posteo.de>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>, me@davidreaver.com,
        =?UTF-8?Q?Lars_P=C3=B6schel?= <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 5:22=E2=80=AFPM Christian Meusel
<christian.meusel@posteo.de> wrote:
>
> I finally managed to test this patch with our hardware and I'm seeing the=
 same expected behavior as beforehand.
>
> When executing David's test sequence with a EH002004A [1], I'm getting ga=
rbled contents when shifting with '\x1b[LR'. But this also happens with the=
 version of the driver we're currently using, does not look related to this=
 patch and might be an issue with our display model.

Thanks Christian & David for testing it!

In that case, Christian, I am applying the patch. If someone else
detects the same problem before the merge window (and it does not
happen without the patch), please let us know.

Cheers,
Miguel
