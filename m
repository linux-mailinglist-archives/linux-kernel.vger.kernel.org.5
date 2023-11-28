Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23F67FC1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbjK1PGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346561AbjK1PGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:06:00 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BDD45
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:06:07 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db498e1132bso2849718276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183966; x=1701788766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNbBrvCLKy2IUxXzcxy/eNfeZ8Ee6bkTl+4EYxHiBPg=;
        b=ax9MSrK9c8D3Gs3u2D2tPc7kgq2HKa1MSUYM1dIs0qL5eEaU2L3RaKB7g+FshL4EsM
         Okce6hiKkH8z/B2hnENOSlQgtk+5XkXO85ocSbkphEacQRb8ip/jAOoQLq3TR13eGtFl
         W/Pe6VGyTsmGYE+DyczJMog0e1BLBcY5eLOMtwcUjCWElwCCeutSY7xrZtp0+4vlUGSS
         Fhw7S/9OsBsUOU6O0fbgXCZ6BY9G4XNwbu7wGKtBXdTZ//avYWyz1dL3ECbsNgIoYV1p
         BFN8ZEj5SFjwnNEo5H4FaqF/BInUeGSKrblWZm7OWikwN0LsrLM0pHZpyW+D+BOBxWWO
         WEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183966; x=1701788766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNbBrvCLKy2IUxXzcxy/eNfeZ8Ee6bkTl+4EYxHiBPg=;
        b=qKEOSkZ2XM0idc1HMg1qvVqOKDjApzuh213eLe31BX4hOjY1cK0U+xuoFXZPH92ok2
         DVdxQ7mVmgHr4ydJP+TZbvzfnSeE4RIe1AbvIvTUIqCMC9VkGS/NkmzAMBn4S7KMjUzq
         LbaOf51d0Zr6JQzFm51kuiV6434gN2WfHT8U6IRDQmtY3dreS/ltRVCyVU5WHBo7bZ4N
         ybcVHWg9vyY90eeebjMPcYDlDjlcYjP3U0vVchrMwSsKmSMH3jV38JbeZwlO0py4+UHy
         /ZijirErBxtjxDXBmoQYm8gLPyxJ+BVd2IzF9vCtQZXy6x2UkoLwN1e5Rsb18G/zW2+q
         BN1Q==
X-Gm-Message-State: AOJu0YxgfTheK2zp8fqayMA6Z4eTCw1aYxxSGDjkk4a5+N3D7wQOmLHF
        sKnpLzeYVONRAc10jE1JwJwM4dZsPhdU9Qw1kcJH1Q==
X-Google-Smtp-Source: AGHT+IFZT4O2LrhNLGFJpzCHtpipXj8NKAcJA1v6/JsDAJjncGLcFq3ZGlfCKBQKFJHnSFWAB6RlUTuIMphvsoDsPlU=
X-Received: by 2002:a25:3795:0:b0:db3:a317:3e9d with SMTP id
 e143-20020a253795000000b00db3a3173e9dmr15023586yba.61.1701183966065; Tue, 28
 Nov 2023 07:06:06 -0800 (PST)
MIME-Version: 1.0
References: <20231127193716.63143-1-brgl@bgdev.pl> <20231127193716.63143-2-brgl@bgdev.pl>
 <CACRpkdYG5FbOLDLM+WGEbX-42mjkALU-HfAgdLLhHSq+K1gnaw@mail.gmail.com> <CAMRc=MdSO_Zp2wqyZQvqadDoUdZVi09vE2fo3oZF3161W-+Qhw@mail.gmail.com>
In-Reply-To: <CAMRc=MdSO_Zp2wqyZQvqadDoUdZVi09vE2fo3oZF3161W-+Qhw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 16:05:54 +0100
Message-ID: <CACRpkdb49rYZoXG5oDLvoDZ90BgpubpC7jRp=7L5qsk=ipPqyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: use a mutex to protect the list of GPIO devices
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 3:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> We don't need to lock the GPIO device or chip separately - the
> descriptor structs will stay alive as long as there's a live reference
> to the GPIO device. GPIO device will have an SRCU cookie for
> protecting API calls against removal of the chip.
>
> To summarize: one mutex for the GPIO device list, one lock per GPIO
> descriptor and SRCU protection of the GPIO device's chip.
>
> Does it make sense?

Absolutely, standing by to review, it's gonna look awesome!

Linus
