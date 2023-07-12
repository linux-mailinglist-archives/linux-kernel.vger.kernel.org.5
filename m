Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76362750FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGLRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjGLReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:34:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E701FE1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso116605081fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689183267; x=1691775267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT8r/UmjyiV4Mg80v9aMCsPu5X2SzHMkE39zee8yF1M=;
        b=CoRZfqI5+Ojs2K4mfukJbVoE0BjZCTjMaSlrU8mQ4EdO+67NSTRtK3xWH0nHC43nXp
         euuL+t/OQcAVBrHuUVXlBo4vtldRc1UymEwMS/vNlljCo+9HMl0fOlVLPsZg+WcCZQmR
         IyAuwzgWdqV1l6+din2C5Pm1J8LR51nDtOe0xvMxlSvTiCjGDKqiBL4rf9C1L8EypJAz
         LBlEq0RCpgaOC7nPxJFQlkOxrw7f8+uVCHk0G3OpyOkPwOJ38lH0PKrj611s1A4cFXlE
         3WySIS/LsYEub/OKfEtzmeL76FA7wBLOX4hmM8ciOEsT+EHjuefK4ncqq2s5TEAlTwtG
         hTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183267; x=1691775267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HT8r/UmjyiV4Mg80v9aMCsPu5X2SzHMkE39zee8yF1M=;
        b=TFbTXRFQpwFiXjZNMSqu0mQBNV5uY+G3Rm7zxWmhDr8rU/YUE8IdiGJQWpUSA9bqju
         S25hw5bt9o38ayGN1ul1TuqjeL2GQVMFe15SV7Ycpa0/UhJsLUxsHUqVdZrSGV4LejWN
         gQXLtZAFFxj1Q0NtqOEbRRGvjfL0qu13SkUmZLb9/iRLDpEtryyebw0u1QpBeCpLMwYJ
         TsoZSCl74VNoDW+PlfoC8rnZvlWJrOpJZ/2oWZm8l/JLmEd6eT0NtlvVgOCPJ2BU4Y1+
         /GNIHjkz7W36mNthsOKFUGv5X+DLLgn6HHQ2L+snUE75HX/OEaesWAnpO1b+tXe9kTot
         KJlw==
X-Gm-Message-State: ABy/qLbd7inpnOOMLixevkqr/GnIt9uuT+cFJB8VmwakzWMDxx5/SC4/
        uQiVuSp5p+R7SXefbZDmf/eVfry4s7bRf72EPuLRuw==
X-Google-Smtp-Source: APBJJlGKRtWIKYFd9l6dVbzYKtlr4dgG9la2quqkLfXgUoiM7QU4QOmqaXf35MMSaKUb+r8Mo83FFJrwM91ICm+w4uI=
X-Received: by 2002:a2e:b045:0:b0:2b6:e618:b597 with SMTP id
 d5-20020a2eb045000000b002b6e618b597mr19138758ljl.28.1689183267182; Wed, 12
 Jul 2023 10:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230706081554.1616839-1-alex@shruggie.ro> <8c188fbd-eaa4-4063-9153-d7b8c2772f8b@lunn.ch>
In-Reply-To: <8c188fbd-eaa4-4063-9153-d7b8c2772f8b@lunn.ch>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Wed, 12 Jul 2023 20:34:15 +0300
Message-ID: <CAH3L5Qrbrq0eAV762tQr_WWOS7G2Lxk3Yvz8egK=0FZNBE3NfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: phy: mscc: add support for CLKOUT ctrl reg for
 VSC8531 and similar
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, marius.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 9:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Jul 06, 2023 at 11:15:53AM +0300, Alexandru Ardelean wrote:
> > The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
> > have a CLKOUT pin on the chip that can be controlled by register (13G i=
n
> > the General Purpose Registers page) that can be configured to output a
> > frequency of 25, 50 or 125 Mhz.
> >
> > This is useful when wanting to provide a clock source for the MAC in so=
me
> > board designs.
> >
> > Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
>
> Please take a look at
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> The patch subject should indicate which tree this is for,
> net-next.

ack
will mark it as such on V2


>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew
