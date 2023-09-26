Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0A7AE702
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjIZHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjIZHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 03:38:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8AB92;
        Tue, 26 Sep 2023 00:38:32 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b0e623189so19459536d6.1;
        Tue, 26 Sep 2023 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695713912; x=1696318712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/27Fg5u72g9kvgafrBJAucjZrohxNI5dpw0DZZayMMA=;
        b=VHvRx+AyXuNpp1KN3oi66AuitFW1PDwbLk00fl/o5fuv4uIM9pSeah2j3a2rT48O2U
         G9V6kcfl5kQ3P58fxAUqZrxatfVuhaXbBLfhtMbD/vvnJaUlnjaQYv1TT/g8XaLc3VuI
         84fDhK+UbdvUOp/P3ylcUzXNj805bnfHd8LFPsfZ8fDg8NxS6b5BV3hqO1mqzUM1/n0+
         M5y75joNP1bKCBcQBouQS9pSspzDWZEGV/uSwWIlbOaKFgK5xr++9uM3Wk/uyg4EV5ei
         v4cj2p8foQxiYRoZg5qADJrCs5UUP3k5dh9oajrTOroJ5yRGjQHN4WtEx5f4ncaunl93
         26dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695713912; x=1696318712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/27Fg5u72g9kvgafrBJAucjZrohxNI5dpw0DZZayMMA=;
        b=k+WxVo3DcV0qrlDGk3WVKBcesBy91HfyXaNM5LMKastxPTo/1IzIcWFlXcZbS8s08N
         PkDfn6wIX+FBeD3qXqo2G0g30pXKjqLYl30ep2mGCu2AgAm0RFqQ1VHDbLrcCT6MHoZP
         qUTiyaCXE5tXiHRE2bNW3Td7MUjwS66zPbw43ivZal96B1xGrAj/nnvV/nZrVJEQ5Cd0
         PMhMhuk7aEm6mT1QcJJC3Wg1G6KnjlRER1oWcEulHsRS4lMddLtHsS4J/l52A3Rbeg6i
         PByogvlow5uCSKxVCI+uJWnuHJvICANGDOoUBfg8b/EFcJAXQ3TXJxx4NgUU+4ykiH9Y
         NX6Q==
X-Gm-Message-State: AOJu0Yz1o1inVQ5z7/4TXm+ID0+xbaNZyM2291aWPVksdauzK9pfJN7Y
        f7qopVdNZcB/TXfaONT+U+BhByUsxCM55KltfVA=
X-Google-Smtp-Source: AGHT+IH5GGWDwUTM2/VMHJHk6heCTbLLWR+CtE7yZz/A0eO0teEhx/fcpYu4iA90waY1nizPw8gcqa3tPVDjn/N3gYg=
X-Received: by 2002:a0c:aa93:0:b0:653:583d:d400 with SMTP id
 f19-20020a0caa93000000b00653583dd400mr8098108qvb.52.1695713911865; Tue, 26
 Sep 2023 00:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
 <bcdc4623-a37e-455b-8f10-c539e2b04554@codethink.co.uk> <CAJM55Z_o7Z8HhaUjrSqjxy1cPjud9Q3GrdqjgFThToxxOCrkgw@mail.gmail.com>
In-Reply-To: <CAJM55Z_o7Z8HhaUjrSqjxy1cPjud9Q3GrdqjgFThToxxOCrkgw@mail.gmail.com>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Tue, 26 Sep 2023 15:38:19 +0800
Message-ID: <CAHAQgRCtWY5pDroDNcWSXpsPaHY1=0L9u_BjB8iWaOY44BkYdQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] serial: 8250_dw: Add Sophgo SG2042 support
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        haijiao.liu@sophgo.com
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

Emil Renner Berthing <emil.renner.berthing@canonical.com> =E4=BA=8E2023=E5=
=B9=B49=E6=9C=8822=E6=97=A5=E5=91=A8=E4=BA=94 18:40=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Ben Dooks wrote:
> > On 20/09/2023 07:40, Chen Wang wrote:
> > > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > >
> > > Add quirk to skip setting the input clock rate for the uarts on the
> > > Sophgo SG2042 SoC similar to the StarFive JH7100.
> >
> > I'd love an actual explanation of why this is necessary here.
>
> Makes sense. For the JH7100 the commit message is:
>
>   On the StarFive JH7100 RISC-V SoC the UART core clocks can't be set to
>   exactly 16 * 115200Hz and many other common bitrates. Trying this will
>   only result in a higher input clock, but low enough that the UART's
>   internal divisor can't come close enough to the baud rate target.
>   So rather than try to set the input clock it's better to skip the
>   clk_set_rate call and rely solely on the UART's internal divisor.
>
> @Chen Wang is this also true for the SG2042?
>
> /Emil

Emil & Ben,
After double-checking with Sophgo engineers and doing more
investigation, we think the original changes(quirk to skip setting the
input clock) on UART may not  be required. Due to currently, the
target of this patchset is just to enable a minimal system and no
clock relateding changes are included yet. I will first remove this
quirk change on UART and use the fixed frequence - 500M - and reply
solely on the UART's internal divisor to work. We will re-evaluate
this quirk change in next patchset when we involve clock related
stuff.
Looping Haijiao, engineer from Sophgo, who is working on clock on sg2042.

Regards,
Chen
