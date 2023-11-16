Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB037EDAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbjKPEXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbjKPEXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:23:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF3197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:23:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5094727fa67so519475e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700108608; x=1700713408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0aRwczQ6tXJ0ICX2vno9uyodkFr2+icyRVyCD2VH6Q=;
        b=Cx9hTOzUrb/TT36UChtkk1oqdDIjH0nTmjY+T4kQpryzH0iRIjhYlvfGX0s0WmJYZ4
         H078TxywQycWvioIuAo61OtXOAGTwQnWX6XYgvqspT394guFcluLL7s5SlXkExOzRKa7
         v68rqVYBPHdgZN4nTXs5EfxdnIPDMZlTXQNImQWy9AkfGIyOXePaTT0fSoBJdgbybfnD
         qHyD9z4QqbfMsO+0/sT9t6stHGyFaMOWWw9Qt3zNxRjJAKHYLIdypgld9chza3DAVz5J
         8sKMGEACO4GDLI+F6HU0eabUctYhEkas4bV8Yj6wRMvH8aMvU4Jqp9lgqSWrM8DCDUXK
         aAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700108608; x=1700713408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0aRwczQ6tXJ0ICX2vno9uyodkFr2+icyRVyCD2VH6Q=;
        b=NrsQ4l769bagtyvsHoZt5F88FD5+MF5N8FZZ6DenuUhg2Ph+UY3kHOXcmliMuKqf58
         yPmw8M8ssSMFoC4JNFc4lL+0wIsD6jiCU6Q63vAaBUAkpBySzk5iEOJ+6PGe+R6RJ3RX
         ZJ115rWaQR9JCKV/dmiMFyEvE1V5ocXaKUdoABkCAldJXIcRR6SbUrRuJoayYtCR3jNu
         9BOumEnOf1aukHmd3hQhqdUEPEKuXauo6prfJgHouOTP4MVsOB51JQH4SYoGB1ANN+YO
         QSQlmKaWa3sbZQaw3kJ2I/tp/bozcz7sVnCpgi2wi27tWkAthVkG7Yq5eyXKjYIYAhAa
         wSgA==
X-Gm-Message-State: AOJu0Yz1SyU4EXc+ngnDvfD68WVjV0mfbqqUBPF0YyKC1+AEt/f7Eypx
        9/aujSWxkIGAlldROOTtiB9J84ZSTKT8vJw3Zw4PRg==
X-Google-Smtp-Source: AGHT+IFV9dF39WtBwrc6I+AKNmbZNIWJVcMdtcfciM5wJckqUfPts+vsDyQehbBFStQ2v0COe4qgTLSGhLtzadfnKrg=
X-Received: by 2002:ac2:4e10:0:b0:503:905:c5a3 with SMTP id
 e16-20020ac24e10000000b005030905c5a3mr1029096lfr.35.1700108608561; Wed, 15
 Nov 2023 20:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com>
 <CAJD7tkbkPZ-Fiyz_4CKNQmufCpWSF330xK3bc7aHNML_cPi2sA@mail.gmail.com>
 <CACSyD1Nav7+zppx3BZS8vU5uF3AaBin0XOKCdtdQ1d6sA4wu9w@mail.gmail.com> <CAJD7tkZHwg_u7UhzugVmmH6-FNORb+D+5SyMX6cGefp93uZr_Q@mail.gmail.com>
In-Reply-To: <CAJD7tkZHwg_u7UhzugVmmH6-FNORb+D+5SyMX6cGefp93uZr_Q@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 16 Nov 2023 12:23:17 +0800
Message-ID: <CACSyD1MKWj9t=q7aWfiqZUT96sVO=9bHJ5SR2kvBGO6t88jgNA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 12:10=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> It can be enabled at runtime, or enabled by default by using
> CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON.
>

Yes, I see it in the doc. Thanks.

>
>
> The reason I added it behind runtime and config knobs is to preserve
> the existing behavior in case someone depends on it. At Google, we
> have been using exclusive loads for a long time. If other users of
> zswap agree to make this the default behavior or make it the only way
> to do zswap loads I don't have a problem with it.
>

Got it.  Thanks for your feedback.
