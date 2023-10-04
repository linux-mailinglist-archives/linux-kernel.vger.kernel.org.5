Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812757B783A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbjJDGyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjJDGyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:54:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0500C1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:54:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so363859b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696402479; x=1697007279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YbF45exUihM3V8J++Yr9N+b7S0JorXYJc7FhvfdAn8=;
        b=AmDVBf/H8f8WKjyGbYytQvbe+rQ6zHNCMm5GWG3fXJPZkRZgFEjGvzupjU/7oU25JO
         rSho2wrUtFNZb4COW18b4FzArv1oYz+UoPKmTgKXcQ78oNeoSlIQ4BkkzHRsN0qSWQom
         t8sjWgiCgcY8/qS9FJfeA3y1+qRTJLJX7Ioq7oOp9X87u4gd906PXWd9WJwkXmxMPLIm
         vk43XxftF82lIvqkXTui+/M5uQb9X9K16DBO18m8XlnbUDc67Uc31SRmg8pd9XI5P1Fz
         K5t6kHu0IsbmOyvAsUQEVyYtfH6XntMNQEanqzDoCAnfqalOQ9pmHF13NpViLhMvqIdg
         cwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402479; x=1697007279;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YbF45exUihM3V8J++Yr9N+b7S0JorXYJc7FhvfdAn8=;
        b=wkv4H+4mV+0h95+dU3nBZoJOmth8Inuz5uiZhg/ngcA34fsh7ICEVSh38T4OVyUWf1
         EU7uXwMTRQUbZlyREVjGcwJxI6arQHNvABmhOfayrqVyQ/OB76SJTvo1GXz9a0reEEtA
         m8rhubXq2UAwrjBe3XBVhlbEonlJm3WjSK3bNPd8HmP2YUSb3NCqE3IsWfbfl0oKLI5U
         zw1kaLfUo7QtFEmsN9I1d1KTTCC+pzV74Vzu3l4bpT8o1Tfcg8pRjRd1MgbqrhoL7UEb
         PjJtq1X6oo++1gQgqwUw9LmWhOMm8BwuLOklji4ZsKMhCLiHDYjoJroBzY/Gim+Pa5fJ
         ZPOg==
X-Gm-Message-State: AOJu0YxuAOvGJzzoARkwjm+Cxjpr1CSt9hbbD64R8nfoeP1kZGgYvjjm
        iw32qJ4dE+SB4igUjls4OZl1xg==
X-Google-Smtp-Source: AGHT+IEDXNokAKn8nzCNvCbNOIUSolppsI+K2w+sGFIw9BHV5d5Ibkooq38MxAM5oAiTWM73Hlc0Tw==
X-Received: by 2002:a17:903:244d:b0:1c5:cd01:d846 with SMTP id l13-20020a170903244d00b001c5cd01d846mr1709840pls.3.1696402479192;
        Tue, 03 Oct 2023 23:54:39 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:81c4:ac5:bfc9:67a3])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709029b8500b001b54d064a4bsm2815058plp.259.2023.10.03.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:54:38 -0700 (PDT)
Date:   Wed, 4 Oct 2023 15:54:33 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [RFC 1/4] pinctrl: define PIN_CONFIG_INPUT
Message-ID: <ZR0MKfr+xPT1Nyg8@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-2-takahiro.akashi@linaro.org>
 <CACRpkdZsQN5V0Nt46dQmUiQo-co81Z_TrzWW_9CPJEbF+X-vnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZsQN5V0Nt46dQmUiQo-co81Z_TrzWW_9CPJEbF+X-vnw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:49:10PM +0200, Linus Walleij wrote:
> Hi Takahiro,
> 
> On Mon, Oct 2, 2023 at 4:17???AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> 
> > This allows for enabling SCMI pinctrl based GPIO driver to obtain
> > an input gpio pin.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> (...)
> > + * @PIN_CONFIG_INPUT: This will obtain a value on an input pin. The returned
> > + *     argument indicates the value.
> 
> We need to specify that this is the inverse of @PIN_CONFIG_OUTPUT,
> that setting a line into *input mode* requires the use of
> @PIN_CONFIG_INPUT_ENABLE, so the config can never be set
> but should return an error on set, and that the argument returned is 1 for
> logic high and 0 for logic low.

I will add more as you suggest.

-Takahiro Akashi


> Otherwise I think this is fine!
> 
> Yours,
> Linus Walleij
