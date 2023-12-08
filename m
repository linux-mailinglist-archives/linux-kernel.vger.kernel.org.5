Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580DA80A19B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573518AbjLHK5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjLHK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:56:59 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2277D123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:57:01 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c55625fb66so325990241.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702033020; x=1702637820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+tNF5EsLXtyupWrlqEM7GZhKXuVewT3D28kbGFjV8w=;
        b=Y2tJ4e2tlrGPZRnqUhpiGNU+vzGXv3PMC3ha3ht0Ew2CmRmPr/MaeAj+o8Fh+1DsQd
         hHMo54b/E7lVMANuSnrHs+U0pTMdPEX8IyKDncgf4DLRtMHI2qLhaZZPmiQ6lk3nOT6o
         YHZfSW3O7SZff2ZYP6njdwRBHrTEieA2/1/wm3K6Ukof9R1EfKqrQjk1tTktandJkDzz
         u3YQn6CoeRWcYJJkDxcUCmRm3Ja82nk00L4bjGw7ha3vBXz+wnqFB1/zmmleydi2FcAf
         Xf4T7irEMxmZgoASclO5/0rYH85+b39ruzNgO7NwIYTWKSZK3ebiLkrBmOlFmEHqJM7T
         Np4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033020; x=1702637820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+tNF5EsLXtyupWrlqEM7GZhKXuVewT3D28kbGFjV8w=;
        b=AP1akGepPgCr4/GV9Lr0mWvC2ou7tHO1o0myu+ZRNWBT5kv9faKgnANdX7Kt8X/YqS
         MX6l1uiV4FoV82uVnYm1S1pJynb96U+I9gWVvJPiUNvJH6Ko/GG8lnylL63Wy2A55SHa
         mTAIqsVoRtc3p77mj2ow60OGsrv4JVRM44l5AdXnUx5SlPqNp6qP4UqKcqORqw/HaF83
         bqp6CrLVro78GQ3so47EJqTjTzdw9Zm/WZjZfWUzoDzS9KMGAv+lqfLRdI+YhUQ+E105
         hiZsvJB0qLDpzIv6H4hm1EprC4dYnzVIQy7sJ+NEGpKrejm+GAKmsiwVx9QOiQA9RJZ2
         tumg==
X-Gm-Message-State: AOJu0Yzel3QerqW6HvEv0f9DQtztbcAYJXF2n6csDHTXnjdvNec6S0O1
        OJpWuJbOBHlqyiyfBAvfdFRyXLwMmn594hXzyyGzzQ==
X-Google-Smtp-Source: AGHT+IEHD69JWoUnKQJPk7pnx/qHAJ4Dktm3e1iN43C4RmpJQic+HDzpJ6NL7KbY/jmHKvSxaz5IEp79PAKEAlPjqrc=
X-Received: by 2002:a67:f146:0:b0:464:8a97:d58 with SMTP id
 t6-20020a67f146000000b004648a970d58mr2917911vsm.5.1702033020245; Fri, 08 Dec
 2023 02:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20231208090936.27769-1-brgl@bgdev.pl> <20231208103222.GB3008@thinkpad>
In-Reply-To: <20231208103222.GB3008@thinkpad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Dec 2023 11:56:49 +0100
Message-ID: <CAMRc=MfR4hVAaJmYCyVYg=4bux7KrRE=fkwiZztD5opEY4VDjw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/3] Bluetooth: power-on QCA6390 correctly
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:32=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Dec 08, 2023 at 10:09:33AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Resending with all maintainers in CC.
> >
> > Patch 1 is just a typo fix as we're already touching this bindings. The
> > second patch adds more regulator definitions and enforces them for the
> > QCA6390 model. The final patch enables the power sequence for the BT
> > module of QCA6390 in the hci_qca driver.
> >
>
> Is bluetooth fully functional without handling WLAN specific resources li=
ke
> regulators, enable GPIO? When I checked last time, the chip requires both
> Bluetooth and WLAN resources to become fully operational.
>

WLAN-specific regulators for PCIe are enabled anyway but the WLAN
enable GPIO is low and the relevant pin function is not even
configured. I can confirm Bluetooth is functional.

I too thought we'd need a common power-sequence here but Abel pointed
out that neither RB5 nor X13s require it, it's only needed in later
models.

Bart

> - Mani
>
> > v1 -> v2:
> > - squashed the two bluetooth patches into one
> > - changed the naming convention for the RFA regulators to follow the
> >   existing ones
> > - added dt-bindings patches
> >
> > Bartosz Golaszewski (3):
> >   dt-bindings: net: bluetooth: qualcomm: fix a typo
> >   dt-bindings: net: bluetooth: qualcomm: add regulators for QCA6390
> >   Bluetooth: qca: run the power-on/off sequence for QCA6390 too
> >
> >  .../net/bluetooth/qualcomm-bluetooth.yaml     | 26 ++++++++++++++++++-
> >  drivers/bluetooth/hci_qca.c                   | 14 +++++++++-
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> >
> > --
> > 2.40.1
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
