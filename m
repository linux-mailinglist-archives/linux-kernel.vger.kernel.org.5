Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292F788287
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjHYInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjHYInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:43:01 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD18268A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:42:27 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58fae4a5285so8510947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692952936; x=1693557736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paPaNBgdy8fC81NTESXp1GcybAQpiRbyhR1Y6LYNTlA=;
        b=UEwtWD8cjlTAVSHsFw5Zp4/mr0/l3+aZwHQuhmEFr7b6685U7R7GnTDdnV21BNSKlT
         EhkZn2ver6+pmnGz4oy7F9+4/nibRpgQZEx9oK3Vvczbf3oCDPx2mKTLDt22bak8ZIFj
         4WYMa6BeMkgdZNWcONmE4Vdaz4Hhl60K0Z0J6wQul4rzgCR5LJ7mq/F2mXP9WHWWYmOl
         2Wzd9iha3q/8dnndQN0TPTkscWnfPYCQiR2GM8f5TbfM6U9Q+wVE+rhwclLNVEn9gpmN
         MXkRNgPlTm34skRZJ2YhfjIcBTgnhmKlvoaXS59Fb5v+6ua/FqwqqJcEdhVj9uCywD9n
         ya7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952936; x=1693557736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paPaNBgdy8fC81NTESXp1GcybAQpiRbyhR1Y6LYNTlA=;
        b=Pf+a2xLg4YUctFjyHdgw4mxfgOHDTy+0u0i5MptgvW2NpofOA+DYkKky+yLlwTF6DN
         WwkB5neDGr6pOya1nR9+2hW7+rAMKZ7DAFjMhY/OOPzaPWbG2hAUVWtbL1C5N3j2aIsa
         NWT2WE4/Z8clck/xASHnYwYHxA5bR913/tOYhcVb5y6HO/jWjoDmwOybzM7I5BaN+n71
         U0i3/JxbqHydmRJ1ZPxdY13CEw5zzfqrpffh/bGXvbE8XiSzzI9jDJMfwObOJEJl4Pub
         7Vizp1TDCPqoauDvLcoWmoFb0fqvpviFD5NRH7p1W8DO3Ct+Xc+2bcfseI72vbyEIyfP
         +vwg==
X-Gm-Message-State: AOJu0YzRKZgED7s0Cnnl+MrJ+YjiQ/sruBa5mw9Dwvew4JJri8WTy3jE
        2/0oEtkeWqgFq1Q3XLcxKKWNI/cd4CRRRK30JlpGdw==
X-Google-Smtp-Source: AGHT+IFUJlU5/qBTUdIhAJDXncihHOCmd0RSL/+XkaajLB1RBuxUUa4sOsQ56q6Awg6wjBB56OfCUhU8LLtIvuaGiUE=
X-Received: by 2002:a25:b309:0:b0:cc6:26f7:f0ea with SMTP id
 l9-20020a25b309000000b00cc626f7f0eamr16232194ybj.27.1692952936378; Fri, 25
 Aug 2023 01:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 10:42:05 +0200
Message-ID: <CACRpkdaP1_57rYv0C4gf=1XQxtCC=BvxzeU15b0uY+uTFhMCQA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 25, 2023 at 7:39=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:

> Commit d890cfc25fe9 ("rtc: ds2404: Convert to GPIO descriptors") removes
> the rtc-ds2404.h platform data and with that, there is no file remaining
> matching the pattern 'include/linux/platform_data/rtc-*'. Hence,
> ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a brok=
en
> reference.
>
> Remove the obsolete file pattern in the REAL TIME CLOCK (RTC) SUBSYSTEM.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Linus, please ack.

Excellent attention to detail here Lukas,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
