Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC09B78CDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbjH2Uwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbjH2UwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:52:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5D1BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:52:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500c63c9625so1421530e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693342340; x=1693947140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DftQ93nqotPz28alN/CC69GCyP7nXLVsXb4dk8iQrnw=;
        b=bWJrR0O6QWGcTZJCBFk2UD8D7x43lJtvbvBxTVqfR1rLSB8yzSfBUBxQPFwlTOtu4z
         jVY1mhrVXiYS5MqiFojPE/hi6hQOI+R5Nh6AsQFnOUjMVKmgB5d0/xEjMbASlIxQMA/k
         9nYaDIcvFgDqJIR6MOw5jSQtueOq8SCqtW2rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342340; x=1693947140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DftQ93nqotPz28alN/CC69GCyP7nXLVsXb4dk8iQrnw=;
        b=kno2cXWhXk1EuJSZrM91ANmuJLP5jh2VOR3vKnxnPjNo+2go1vJkzjYtSGdoyCm5wM
         Bgzt47KQkwMx8reMydn31cWwEqocB0nNhf2pf/Z1LpItfXAK35CN28wjLzPW66YOOE5m
         LsxW9h8NBDI9WIr3Q0LcmdZ6aEeyCeLIzttSKKU8QyRSBu/7K5Or7zs4WogEPa4/U55D
         eHUXiAC00toE0p8ZqUx3dPrjG7MzwuvhxQpKyVW50btui8Kvzb8qRhRl28ZIhngd4hiY
         TuCO0IWbjLMHF0BOQtF7bAW0ZdcZlO+g0CubOGPWlLYHIcltSLq3pgqsj7o4HURhB4P4
         211A==
X-Gm-Message-State: AOJu0Yxs1mqrEsRTSBxu2yYeRiIj2wqncnhNwrtQ2KND7caOYxHGZvnE
        2YQ02pXpN2hWp152VZUHTnsgjEGxZ/jCLuuKRp/hLA==
X-Google-Smtp-Source: AGHT+IFYZHnCilTMWTY5QAnl/jgXuuhjLpz4c7oDK1ApTrZOBWlda16ygp+pWxIcjhPzFELtu0nlA20+cBmKb06fOxw=
X-Received: by 2002:a05:6512:758:b0:500:c2e0:64dd with SMTP id
 c24-20020a056512075800b00500c2e064ddmr35083lfs.50.1693342340371; Tue, 29 Aug
 2023 13:52:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Aug 2023 15:52:19 -0500
MIME-Version: 1.0
In-Reply-To: <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com> <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Aug 2023 15:52:19 -0500
Message-ID: <CAE-0n51gcN+3Ng7+bz21eS_6JomnVDzZMuWyzZVB25paj29j4g@mail.gmail.com>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
To:     Doug Anderson <dianders@chromium.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Micha=C5=82 Miros=C5=82aw (2023-08-28 13:26:54)
> Indeed they are quite similar. I did remove a bit more code than that,
> though: in this case there is no early success return before the loop.
>
> Instead of saying:
>
> lock A
> lock B
> if ok return
> if that failed, loop:
>   unlock A
>   lock B harder
>   lock A
>   if ok return
>   swap A <-> B
>   lock B
>
> Now it's:
>
> lock A
> loop forever:
>   lock B
>   if ok, return
>   unlock A
>   swap them
>   lock A harder
>
> With the same condition 'A held' at the start of an iteration.
>

Removing duplicate code is great! I'm primarily concerned with
readability. The terms 'A' and 'B' doesn't make it easy for me. Can you
maintain the 'held' and 'contended' names for the variables?

That would be

 lock 'held'
 loop forever:
   lock 'contended'
   if ok, return
   unlock 'held'
   swap them
   lock 'held' harder

per the psuedo-code.
