Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C31767261
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjG1QuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjG1QuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:50:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C295596
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so2962906a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690562880; x=1691167680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXivkmaRJs+XMYPK4BBCMFXANZtvFmw3am2SilMPoO8=;
        b=cS8shLyikv6FLY4hFKDx0QepsuJCInBdKVLTlUHn780c5gaavcB2AVr/QAq+CEociz
         0OJ3F3KzBcPPfbHniDPFpgchqRfIwyM5TcGY+1EICKYTA45AGK2MfVrOeuqD8gBNVr+N
         WK1DKfztbh2f62lzncvY3zHwvbAYMS92FuPBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562880; x=1691167680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXivkmaRJs+XMYPK4BBCMFXANZtvFmw3am2SilMPoO8=;
        b=j9y7ZdbF1UeF8hbGrXo453VlziqvKMxB82rXSlViVQyKZfRUDUlSVPqpJZmEGua3eP
         EnegFtSsI2xp9Gkk2dPx7+v56xixce2zY9ff4U7lgUosySbEsVFp4BEg54LmmwYu+u+5
         iZ4A6B1R/rXBDIHMsUK9VApga382EF8c3zrlT6Jk+7X2zzN6nvxB4XgrqPTzJuzRP5I8
         jQ4w7/T1eu2TLGAOwKTu8qeRcJRhmKaYizxKl0002dH15GjpjOAjPY66jBNgktVKUJ4/
         oppgoYpvFiVJyZdHkR+khF5nQg2a9mqRY+6dXMW9wKlxw78ka62qrvFGTY+hfNVY4ogB
         K+QA==
X-Gm-Message-State: ABy/qLaS+QOugenzm9YnawZDtyiYoJP0dKpzQZtymUInJh+b2ncrU0jC
        QC7Cj6ePAAX5fGW7EP+jjLWCYuUSsMH08zcYIgMlCNDU
X-Google-Smtp-Source: APBJJlFgqGJpbz576m+RVF0NTvmEUcMG/2VShzdU1NN3/tuQohd2om7wuyLfSA2hlmFVJkUsTWaEgw==
X-Received: by 2002:aa7:da41:0:b0:51e:3d13:4a12 with SMTP id w1-20020aa7da41000000b0051e3d134a12mr2237972eds.34.1690562880203;
        Fri, 28 Jul 2023 09:48:00 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b005224d15d3dfsm1992104edv.87.2023.07.28.09.47.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:47:59 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so2962892a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:47:59 -0700 (PDT)
X-Received: by 2002:a05:6402:1602:b0:522:2711:871 with SMTP id
 f2-20020a056402160200b0052227110871mr2090932edv.1.1690562879171; Fri, 28 Jul
 2023 09:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230728105512.2258393-1-rppt@kernel.org>
In-Reply-To: <20230728105512.2258393-1-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 09:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivhj2bMGMjEFxEZJjG-X_X8o0VxqU-8XuNXo-a=wfwGg@mail.gmail.com>
Message-ID: <CAHk-=wivhj2bMGMjEFxEZJjG-X_X8o0VxqU-8XuNXo-a=wfwGg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm,memblock: reset memblock.reserved to system
 init state to prevent UAF"
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 03:55, Mike Rapoport <rppt@kernel.org> wrote:
>
> Linus, do you prefer a pull request or to pick it right away?

I took it.

                Linus
