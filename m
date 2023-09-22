Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38697AB10A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjIVLjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:39:17 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293F192;
        Fri, 22 Sep 2023 04:39:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-773b4a711bcso126318785a.0;
        Fri, 22 Sep 2023 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382751; x=1695987551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tm7XbhqrREfex0ytvkwvNzO/WSxEY4k2Px8GYpsFrQ=;
        b=i4+3Sx8j5u1gD45kh29h1OtPVEh45mp5v4n8Skb7c/V26nIutBDlmFEN4c8a1eugzh
         yKNkkbl6n4rwYE0910mPIbgNud8quddmYQIYa58h0+IM6OO2vz8qOT7VPh73sDYxlnW4
         xth4PZY37Sd9xSK5woRiZseiEpq9sHMJjZw7t5qblKbmurXA+KPJp/nmlj5Hv1xGYIA+
         rvsCHe89N+jGQ6tFmyE8L+QB3CmtOJl714AavwMrFBpsufJUBxhojdzv7SQieDKa3Ma7
         rPD+ASyBG0n70h5+b+V4mpTOwhbA8MRpeoZ90ZyQX4yKJCXq7QflDKTo2MaFvEfc6mFb
         LRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382751; x=1695987551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tm7XbhqrREfex0ytvkwvNzO/WSxEY4k2Px8GYpsFrQ=;
        b=fWs8FNBAuUMG1x4ynWc9U6I5lZu3Z3gkOEnOWkb8oEEk4r/8et+/NMYMnU6+iUZuYI
         XLlD0p8dmPb0UiZpGS4urq4rVdH1vAUc9kfFot9isIn8GPG8bUwSOzsw/PouhdPtB1sM
         WNrh6XtAr5zi9NfgPhfNpC28WbtqIUUiDKa8YpFoOPc283nkb371nE63Lbz9FB4MX+Om
         XmKqguL5L6eFs27M5lwA0aXsN6mHrRMy/JXALkUdmlZ39HljIG1/2B/DoT3MS5y48+E/
         bUSlMlsTn46cgjSTdwD/+C8PiaAGOMQ3Jn4ttwvlqGY275aEsSHgIYk/EsZYfmGxpWHL
         lIlA==
X-Gm-Message-State: AOJu0YxaNwLZ6eAfKBbZnWMx+La9WStVvdz7UST/NJKZJU40TQSsFYwA
        zctXRQTWiogxlL3JKB1Rmqi1hC1LflgcHXlucTg=
X-Google-Smtp-Source: AGHT+IFUD+NAk7EJFLAY4i8dlt8iE7k/F5MqrBgkE1rslaS0JQAk9KmeJa4tIqMTftJPGvv5PxMYCxA/MjVi8bpCpAU=
X-Received: by 2002:a0c:cb10:0:b0:64f:3699:90cd with SMTP id
 o16-20020a0ccb10000000b0064f369990cdmr7318620qvk.42.1695382750882; Fri, 22
 Sep 2023 04:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
 <bcdc4623-a37e-455b-8f10-c539e2b04554@codethink.co.uk> <CAJM55Z_o7Z8HhaUjrSqjxy1cPjud9Q3GrdqjgFThToxxOCrkgw@mail.gmail.com>
In-Reply-To: <CAJM55Z_o7Z8HhaUjrSqjxy1cPjud9Q3GrdqjgFThToxxOCrkgw@mail.gmail.com>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Fri, 22 Sep 2023 19:39:00 +0800
Message-ID: <CAHAQgRCiAvvowhv095cm5X4aDUhJSr7j92a84KJto40Cj4wd-w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] serial: 8250_dw: Add Sophgo SG2042 support
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
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

Regards,

unicornx

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
I need to double-confirm this with sophgo engineers. Because they are
off work now, I will probably get back to you later next week.
