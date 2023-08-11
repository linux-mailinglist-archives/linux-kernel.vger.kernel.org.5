Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F94778923
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHKIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKIqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:46:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515842D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:46:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a76cbd4bbfso1596210b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1691743578; x=1692348378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKtJlKIudcy7aKKHmKppipYFtVVkWK8lZUiluohc5xs=;
        b=V1dIl57VkIS3nFpjQpFIs6MA0l32uD7MvRbvj0xJRthWbdZUaBzqc2+FvOINTzDwV8
         cYL+LClC2c/U+22UYqKLD5Gp5WzohISuB3eGJvg2k62a6NNur8f2RIhax4tqNq6HT3hd
         nFScR9BhGhsRSv9LPy+NtRID8mz6fvVBJ16ZdBdoyteygigPFPtS5GRh++asG3mD9yd+
         dt7JJw3aHxKoTYHvLee7GisG48XTnz58rdpjLR/3N5GDR7vueYzm9/JyOZ2YS88VZhTf
         X9ffJp7HoDvaB7hyy7nptOIH7DW1fFsJ6L03BfuG7EAJRFm8Mru+qefJEBmM83xvkwGN
         v+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691743578; x=1692348378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKtJlKIudcy7aKKHmKppipYFtVVkWK8lZUiluohc5xs=;
        b=Aj0NSLX4QSHyI21ioL9CJ3BkK2QkkjatR9/ycdBEVV0kwRYbXNIpIuGsF5BN57PoNi
         RjsgCfCKW058ViNQIIwfux+qPeGBttGXysZz/pZt/8Ii6xcOZWtv0ywgFDJinh/QlkS2
         niRsQWFGKdHTiA4mpy/wb6RNw5PtA5ZRjt4Bwx1QDPegJVEgpXNzmprpktjEvvD6JYv5
         hRMXHXfxJlXJtus/vzJJP9rhZHeW5A3FOXRLTxyM92TsHXLGSXJRlWgy19ahNjljHg+0
         /N+UmhYNpV2R12pAhRZQouHrj5fgWKtml0vTkGxoU9VoDl75Gi0u0hsE5Mu5EcD9iBWm
         qtMg==
X-Gm-Message-State: AOJu0YygFJ03A5EcYhs3q4aAMqLo1bt/E64QQwSlgMf3/xDYwODM8Eqz
        pkSVchtaVBT25toJILjVMjZtVxFZBlQF1gsOhEaPOg==
X-Google-Smtp-Source: AGHT+IF4kwiHVZ+e3oWoKQhT6vWvqXLEgnfBCFRqv0uUjOIWSXMnFW8ahdTpF7sGGp7nhgz8GdihxQFibxdlJFhxoMw=
X-Received: by 2002:a05:6358:2791:b0:134:d4b6:1c47 with SMTP id
 l17-20020a056358279100b00134d4b61c47mr1577466rwb.22.1691743578593; Fri, 11
 Aug 2023 01:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230810132904.367418-1-robert.marko@sartura.hr> <900276ca-a682-4be0-a3dd-1794a3e62224@linaro.org>
In-Reply-To: <900276ca-a682-4be0-a3dd-1794a3e62224@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 11 Aug 2023 10:46:07 +0200
Message-ID: <CA+HBbNFGrF7gCKGuQuYRb6iZnzxV+=Gvde5DVi16vUnFfs1ZMA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 7:56=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 10.08.2023 15:28, Robert Marko wrote:
> > Using GCC_DCD_XO_CLK as the XO clock for SDHCI controller is not correc=
t,
> > it seems that I somehow made a mistake of passing it instead of the fix=
ed
> > XO clock.
> >
> > Fixes: 04b3b72b5b8f ("ARM: dts: qcom: ipq4019: Add SDHCI controller nod=
e")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> Is this another IPQ without RPM?

Yes, AFAIK there is no RPM on this one.

>
> If so, this patch looks good, but please take the liberty to make clocks
> and clock-names one-per-line :)

Will do in v2.

Regards,
Robert
>
> Konrad



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
