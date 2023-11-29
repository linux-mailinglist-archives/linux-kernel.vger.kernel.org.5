Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03D77FDBED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbjK2Psd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbjK2Psa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:48:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9706D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:48:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso586396e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701272915; x=1701877715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92OxtxZwSGpeWAn1meN2/QJvS3h/Q5dejm51Ey+HMAY=;
        b=NBj+2ZUQ76cR6Qhj08bKhy3zQYXWrsPSnt+JtT8KH3qaHhnYm98Dh64V9ggeb4QUrm
         jtlvjxyv+GtaYl+71WIaaen4BMydZgsdw4Z2w2NBO4RTVBJp7DQQUeiPq/bAG4Lu7Ofw
         mQ5rmgQmk441DetuDmzFHbQT8Te7//aOPS+jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272915; x=1701877715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92OxtxZwSGpeWAn1meN2/QJvS3h/Q5dejm51Ey+HMAY=;
        b=n14eCSAFGEz0pAN5ZbJ5sWf7EQUD4fG8hpHGFKZq+p3m1fNv2aVyUg9RJc4Rh8VwCG
         2EBSBDiLkE6CDt9es/nza4lNh+Glx38hWWRolLO6FiGPTGzt7H4JtkW9Fz6VEVaI3EoY
         62kWl5Jkiigq8sBJnVvd4xkx0Tec0PO4WM9a8FPBOdK/girlbl5qeZOqawBwDq5vmXMb
         MlzS31WyP/QkX+0EbCOlASHVAHipaminJFKyleOzbebGKEukfX57n4VC4IqSPwRiouP2
         m2ssgSJdIFivtmpsJBV15wjoD6wNnicjuidHyJYIWt4E+OySzv2sOCda8Y+gymbU1YMd
         pgsw==
X-Gm-Message-State: AOJu0Yx9rza+SvPM96ow31d0vnhtsmrL+p3kLD9fqW7saebvQA+KzoT0
        A1JGLa+8ANDYKxvVY1BFlSvvMG7s8NGPl3Gv8BTOcVS4
X-Google-Smtp-Source: AGHT+IHX4cCm/D8FnFHuoe5T+gQ2Hd34o8INyMSGOOxRBmfuYpCIiWM8KCWhNvnC7kuGv8yMKkfGrg==
X-Received: by 2002:a2e:83c2:0:b0:2c9:c142:8e55 with SMTP id s2-20020a2e83c2000000b002c9c1428e55mr1080047ljh.36.1701272914847;
        Wed, 29 Nov 2023 07:48:34 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e2f11000000b002c9ab8665dbsm591499ljv.90.2023.11.29.07.48.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:48:34 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso586342e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:48:34 -0800 (PST)
X-Received: by 2002:a05:6512:1096:b0:50b:aab6:da2f with SMTP id
 j22-20020a056512109600b0050baab6da2fmr11186168lfg.10.1701272913996; Wed, 29
 Nov 2023 07:48:33 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb8dwq7OYUFuyjJCv7VN9mH1zEmibcOwgFip0wDv5H1gA@mail.gmail.com>
In-Reply-To: <CACRpkdb8dwq7OYUFuyjJCv7VN9mH1zEmibcOwgFip0wDv5H1gA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Nov 2023 07:48:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZj3WZezdj8wq6thUeRfzua2y2QsrnoPG9dqfmk-=rcw@mail.gmail.com>
Message-ID: <CAHk-=whZj3WZezdj8wq6thUeRfzua2y2QsrnoPG9dqfmk-=rcw@mail.gmail.com>
Subject: Re: [GIT PULL] Pin control fixes for v6.7 minus one patch
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maria Yu <quic_aiquny@quicinc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 at 07:18, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Here is an updated tag on a branch where the only change
> is to drop the locking READ_ONCE() patch until we know
> more about what is going on here.

Bah. I already pulled the previous one and pushed out before reading
more emails and noticing you had so quickly re-done it.

So the READ_ONCE() workaround is there now, but I hope there will be a
future patch that explains (and fixes) whatever made the value change
from underneath that code.

          Linus
