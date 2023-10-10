Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E707C2E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjJJTvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjJJTvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:51:31 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070B94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:51:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7be61fe74so14460897b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696967489; x=1697572289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t/gb0HX/wguZBehJ5edd61GQW9F6FisjpeCFW72vEs=;
        b=D5XtSMeXbmeae1DUwD0ohuJzaEE1w/skR4ngNwV2PfvtZL5hnVBR90UKzxAiQZ988e
         sj1D9LpxikgFTp7OMDGxcVM/b3Ku7oXMv8xfErTqX85QIq3ZfPeOZzt2N0cXFY1OdXK7
         6GVSLQ9esRI2tHfwoWLxKW0qTHua+dcy5ILVNr3ClO23oxDxhjG/OlpyU+RbMPJFwt9a
         +XJKxRV4ytVviTilxX66QQJdO9ikggHyH6xHloWKH6DZ4KBMNrPifZbwQEvY49iIInEs
         Wywllt/DmCGBZLGHLk/SppXOElDSUxXQfXepPBVUZbMBNZMLbb0jUmwnU0mwcMP41XxG
         qlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967489; x=1697572289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0t/gb0HX/wguZBehJ5edd61GQW9F6FisjpeCFW72vEs=;
        b=CUK6FUrSjc36/uXXNOS2mtILKFCvqLW5IvUmGBvNuSwF4M8Y5ZodLHiwKZV4ZwPS60
         z74WD1KNEY2PySkD3QahDFQt9aWPGLTISeA57xiW5bxZECqjrOjQHnydLDkVsTZy2w0x
         AOQvpkDCxm6ATP+HI+PIWh14iGcx2btbSCST81p9tAvwEItnYAbqznkrhqdRu40GCj6s
         LfcU79SnzuOS7fChACjWkw1eHXIKW4cVCzUt5Cw/uyDmodACvXYHweTnaOOOFonXK+LL
         wH+1eHkQ3rzB8Ra6kcu44Khd1edwHcJgdoZVn4pKHYpL3f74y5dkO2EWs3AFMngOqwmU
         nJqw==
X-Gm-Message-State: AOJu0YyufbMKdtzKlD4GMKAP2YSE3/BrvnlIpSil19dDtiH5ZS3O0j8q
        B8POgZEsET7Qea+/EMHgFDKIDnllrkmSnYVj5wD4Mg==
X-Google-Smtp-Source: AGHT+IEhCcAsDeMJoiEQZQ5RWxC0/XydGDUmR603fyri6YQ94GyZBsLD7Fzb80ytacETl1giUcWrYOVUQ45SVjw5mw8=
X-Received: by 2002:a81:b40c:0:b0:592:2a17:9d88 with SMTP id
 h12-20020a81b40c000000b005922a179d88mr21125891ywi.47.1696967489365; Tue, 10
 Oct 2023 12:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com> <20230924143710.7c6edc4a@jic23-huawei>
 <CAM+2EuJ8o5X2ucph8gic2=03bbLQmUCX=j3SFLrqD4Y6rwXs9A@mail.gmail.com>
 <20230930170530.0b8f185c@jic23-huawei> <CAM+2EuKzBVbTF2SrpYEYfzap1wrONboFV-QuTU9Fz7sVjqJLeA@mail.gmail.com>
 <20231010100002.0163d681@jic23-huawei> <CACRpkdY+K90mN1Q1tf38FLRgEsz3q8dK9SJYSQVwGe=PL3FaUQ@mail.gmail.com>
 <20231010154216.6032a1c2@jic23-huawei>
In-Reply-To: <20231010154216.6032a1c2@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 21:51:17 +0200
Message-ID: <CACRpkdY4yJKmc_Sbr=4sJ0WseCEEBOQ7wKj4fBUMG2_cx-Xxbw@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> We kind of lost the question along the way.  Wasn't so much about whether
> there was a generic binding but more about whether it is worth providing
> separate controls for the two IRQ pins?  Or just assume no one is crazy
> enough to play that level of mix and match.

Ugh no, that's upfront design for a nonexistent use case.

- First, to even consider open drain the designer need to be really
  short of IRQ lines/rails, and, despite knowing it's a bad idea, decide
  to share this line between several peripherals, even though it will
  require I2C traffic to just determine which one even fired the IRQ.

- Second, be interested in using two IRQs to distinguish between
  different events? When we just faced the situation that we had
  too few IRQ lines so we need to start sharing them with open
  drain...?

It's not gonna happen.

Stay with just drive-open-drain; and configure them all as that if
that property is set.

Yours,
Linus Walleij
