Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7577649A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjHIP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHIP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:59:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966B1FD8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:59:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso3300466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691596779; x=1692201579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKgMv/zwB6Y77QMgXunD2xiaajtdokS/KsQJJ/MXzU4=;
        b=OmBebYbe7hv/gEeawP8PcRY/on45Yjtob4z+tFNFAxSTxM74jgchB58wPNTdDxitDr
         Z8EtPWG++LumdreGGgQDO0SV+UTULp5L81gPus7scKWW6u+fqTfDF7OGGiHrhjY2NdKt
         nAtli2KRF24vM9+9RMXES5hDWhb3i2CD6/CT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596779; x=1692201579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKgMv/zwB6Y77QMgXunD2xiaajtdokS/KsQJJ/MXzU4=;
        b=awXkYJvTNlPl0XJ6EzEMCpsaE8wMBIQlSHtujzCMkD9B8K+7WjRdz4qldEnFDn/2Mq
         UO+yBOZIsKG2IylXAcYJ5FZ4LqtEzFPMdggD10vhMnSb6RlCR/NG//ySbSf+ukiVMBqG
         Ehz0OQP+bcYezNOSrv3mVlq0nvB7ypHCLO7RFtBXjNYO5B6s8wHl+tCLsj3k7SMkh2Pb
         pnJWZRga09iJW/5KHY90dUPmQjkPqpee0mHiaF90tcwyc9hM6hHslwklzVxBDMES1HrB
         GuU9mwnSXSpNuxDmpuUzieTEIAFyLSgqY8EDX5eCajRm2GGVANRqKJitFd3eQ3OxOWjo
         C9eg==
X-Gm-Message-State: AOJu0YwyY0mHZ/wd6q6JK0CABV0LJZ6TMJFVKIFqthT3MRMmANoRuBlG
        yG9Ion3s2s4C9qorPc6aLtCCaONUMK502CH+9ytAuRsv
X-Google-Smtp-Source: AGHT+IHjmPnX27zU9pjsBZjYBynIIiN1WHVoqAnG6zKKEo+/dshfN0k3/YS5gC+vzNiE5k2ctEfOxQ==
X-Received: by 2002:a17:906:53d1:b0:99c:7134:4f95 with SMTP id p17-20020a17090653d100b0099c71344f95mr2321557ejo.32.1691596778863;
        Wed, 09 Aug 2023 08:59:38 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id l22-20020a170906079600b009934b1eb577sm8241026ejc.77.2023.08.09.08.59.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:59:38 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-991c786369cso3296266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:59:37 -0700 (PDT)
X-Received: by 2002:a17:906:5350:b0:992:d013:1131 with SMTP id
 j16-20020a170906535000b00992d0131131mr2505461ejo.52.1691596777526; Wed, 09
 Aug 2023 08:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de> <87a5v0e0mv.wl-tiwai@suse.de>
In-Reply-To: <87a5v0e0mv.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 08:59:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
Message-ID: <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 07:44, Takashi Iwai <tiwai@suse.de> wrote:
>
> The remaining question is whether the use of sockptr_t for other
> subsystems as a generic pointer is a recommended / acceptable move...

Very much not recommended. sockptr_t is horrible too, but it was (part
of) what made it possible to fix an even worse horrible historical
mistake (ie getting rid of set_fs()).

So I detest sockptr_t. It's garbage. At the very minimum it should
have had the length associated with it, not passed separately.

But it's garbage exactly because it allowed for conversion of some
much much horrid legacy code with fairly minimal impact.

New code does *not* have that excuse.

DO NOT MIX USER AND KERNEL POINTERS. And don't add interfaces that
think such mixing is ok. Pointers should be statically clearly of one
type or the other, and never lied about.

Or you go all the way, and do that whole iterator thing, and make it
very clear that you're doing something truly generic that can be
passed fairly widely along across subsystem boundaries.

             Linus
