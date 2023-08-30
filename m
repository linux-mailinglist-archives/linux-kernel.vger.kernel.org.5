Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388B378DF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbjH3TUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245477AbjH3PRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:17:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE641A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:17:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500cfb168c6so440687e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693408624; x=1694013424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Lq1UEtVYfmaVSMBjGqn/DzODksXNcJpAcn5BFpVcs=;
        b=FrL8PZoOTKhvBQCb/ps0/nguEEcD1PSLXsKLPMluaW6y/mmsB7kdyiKibPdCT10hmr
         TqSK8DPhdyWIELIyKf2bmYapyVrGX6aQ2uvfas68BIGbLbzH1rq/1HPN9veKjlO+nCz5
         79R9i2dpYEqaOfFeKmYb8CXxNlOEbbeDE/NyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408624; x=1694013424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2Lq1UEtVYfmaVSMBjGqn/DzODksXNcJpAcn5BFpVcs=;
        b=Htb8RxWK2VAY7TZlxQIqZM/W1T4dLdWEb5NBYlaTVFXRJTnob4vRwO7sD7iCP0FNXA
         nd03KELXKTjLQ/F/clyOUlwk2OCDibT7MpfQiaF7NIi18/DNziGQTJrDjt+3TXyOcsew
         T+7iSHC3FxRrAiiE5sauKrVDCqZsCbYK+JbXWy2I3skC3lqu+LK49Hm3Jms1MEhjBHMi
         tp1Btt0TkPfCxbPhhdAlaP4UHy4SaQEMnfg2lofHmJTAbMFzUPxAue0T5ocgiPXHZcA3
         KqKNBT0jV6LY8QELqgd+c7bDfpv0J2lUgnd5Ty1wdo5ZqyEyPDW7A9Oh+9zBj46vNFki
         sJpg==
X-Gm-Message-State: AOJu0YzRNdukt7fPvpYiPWqWstWBicKankUoVgYkuIUstBsUJhM6hkbf
        AHoA9rkJShzKwHRxASXdWF7NzifDEarortr8fSwmtXoO
X-Google-Smtp-Source: AGHT+IENI90AbZiz7XYMgTMAKH89YSRaNZinsTh+12Unv6ovMoi60kbNoD61iSGqPSe9FtVNUUvshg==
X-Received: by 2002:ac2:4650:0:b0:500:b5db:990b with SMTP id s16-20020ac24650000000b00500b5db990bmr1798843lfo.47.1693408624451;
        Wed, 30 Aug 2023 08:17:04 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 18-20020ac24852000000b0050089b26ea1sm2404703lfy.276.2023.08.30.08.17.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:17:04 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so87713421fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:17:03 -0700 (PDT)
X-Received: by 2002:a2e:7e09:0:b0:2b6:cdfb:d06a with SMTP id
 z9-20020a2e7e09000000b002b6cdfbd06amr2210430ljc.22.1693408623545; Wed, 30 Aug
 2023 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZO4NUZ+k4Q4zPu6X@infradead.org> <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
 <ZO7iy/Ei+wZK0I/d@infradead.org>
In-Reply-To: <ZO7iy/Ei+wZK0I/d@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 08:16:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwuJckhd76veFTJeDefktAdbpWrZh-U+AGb+NN3B_XLg@mail.gmail.com>
Message-ID: <CAHk-=wiwuJckhd76veFTJeDefktAdbpWrZh-U+AGb+NN3B_XLg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Yajun Deng <yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 23:33, Christoph Hellwig <hch@infradead.org> wrote:
>
> It actually does..

Ahh, bah, mea culpa. That's what I get for having mindlessly looked at
the config part (which was, in my defense, about 90% of it), and
missed the one-liner that actually moved the call from the arm64 init
to the dma init.

But yes, please do look out for making things 'default y' - even if
that 'y' is then a bit indirect.

          Linus
