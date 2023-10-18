Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1B7CD634
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJRISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjJRISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:18:22 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB8C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:18:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so7646412276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697617099; x=1698221899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaEmtppYZAhMsYDBHeyk5qHJOFganXNI4hJEHgjEbgc=;
        b=xiFrIP6fjZCSXHuVPOgbEzSqeYUB+FMSEL4NRfS3k2N3TeUnHL3edBbvuS0YtdTTnL
         l59zCNthfddQ/eXB8mq4AZmtREcp9+iNd15A4D+ofPxsKlZr7jxzHkd1xKwcnB5j7YCR
         UNSbEZW9pvsVdV1PLJprETk8dDh8GGdLuMvdwQ8TwN/JrjZwn9HJAajPZtv6N5tEbsGB
         pjP8dQ8hrDXRK4yTM3rZhWA4YIIophv6ZGypz/4Y+VY6fqziCcmAegx0GhgC4mMOiaBj
         qM5c8OTDFZ/QjAGF7UPODPsi7XQn6XBPfBMkBkHCJrWUBMft7QvrxoH2U9m+OK/kZhzI
         ltPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697617099; x=1698221899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaEmtppYZAhMsYDBHeyk5qHJOFganXNI4hJEHgjEbgc=;
        b=vyeCDTnDFMT9+55dRgL8hiS5g4OFF8mDclO+QA954VjQcMH3TcapxwdwqD+4+1MKAw
         pwve+dXlig+1SBWzfuje6r1Rwh3+ctNuSZcVYbU7+qjE/EZ7ja8VHhDiHQkn8hA5leX8
         U0n9FdAPJvRrksvNVyFpaW1yKECmotTPOxCjGdeeed02+PbhpXlBGKUCjOIRTSbbXKXK
         m6TLc5WleVUY7/A6ARjwN5IMxTWUVkDjhsG9q5UysV4BtT7t0miXNbbIef5EItpIg5aR
         OJMz0Z361cAvIytdMimP96D0s/7y171vBKUBGv7deJbZpE0iYnIIWWJ4sQASvitR6yy9
         9lgA==
X-Gm-Message-State: AOJu0YxK9pV/bxKeRQkQASCKFyFHsqc9D3Gw4g1gi2MnIQDQKn7XjmOI
        hfKoYblS7CiMHYeQPNHbJ8Aj1vd7aKB1gPpmMKH5TeXV9Hv909NF
X-Google-Smtp-Source: AGHT+IHS+aRA61sStPYBODFMrmmJRiulx2KlXd75EfRcMgJwP5MT9v5x1H3ytS7hzs2Li0IIu8G73H57gxRh3paxT6s=
X-Received: by 2002:a25:db07:0:b0:d9b:5428:d601 with SMTP id
 g7-20020a25db07000000b00d9b5428d601mr4246998ybf.21.1697617098878; Wed, 18 Oct
 2023 01:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-3-ychuang570808@gmail.com> <7800b2d6-33c4-4c4f-8d0c-c11ff0e47535@linaro.org>
 <17a80031-98bf-48bf-8cea-c0ca4400f142@gmail.com> <254837e5-a0fa-4796-8928-277db4b98bf1@linaro.org>
In-Reply-To: <254837e5-a0fa-4796-8928-277db4b98bf1@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 10:18:07 +0200
Message-ID: <CACRpkdaiihOex19SavWwC+S8o5qp=F=XMNm9+UXh=q2nVbOFkA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin control
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 9:52=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> > I noticed that 'xlnx,zynq-pinctrl.yaml' and 'xlnx,zynq-pinctrl.yaml' us=
e
> > 'power source' to specify the output voltage.  Should I follow their
> > approach or define a vendor-specific one?
>
> Maybe Rob or Linus have here some recommendation, but I would suggest to
> go either with rtd1319d-pinctrl.yaml approach or add a generic property
> to pincfg-node expressed in real units like "io-microvolt".
>
> Rob, Linus, any ideas for generic property replacing register-specific
> power-source?

The existing power-source is generally used to select between (usually
two) different chip-internal power rails, such as 1.8V and 3.3V.
The format is a driver-specific enumerator.

We *could* just patch the documentation for power-source to
say that microvolts is the preferred format but legacy users may
be using a custom enumerator.

io-microvolt seems like a more long-term viable option if a wider
range of voltages are to be supported so I'm happy with that if the
DT folks think it's nicer. However notice that the power-source
property is already being hard-coded into things such as SCMI
and ACPI so it's not like it will ever be replaced by io-microvolt
and phased out as far as Linux is concerned. Not the next 50
years at least.

Yours,
Linus Walleij
