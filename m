Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87857754E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHIIQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHIIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:16:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11210F6;
        Wed,  9 Aug 2023 01:16:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583fe10bb3cso75193267b3.2;
        Wed, 09 Aug 2023 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691568997; x=1692173797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IEuzWykTMtItBBOAFGOiv2XbuELxF8lm+BVPreJJuo=;
        b=q97l8KGdYR6vSPeBPn5HJ6Iy8BCXsLr6xdF/EBnHsEZs587lM7np7eptBi/4MP+arH
         dlL0+wk8KZutec0aS8NZtcHyslmnniF9L9hkAV533WLVuAx5Nagv78KzaTlcdBeBWEmK
         vPAmfcJSizIpzA8mzol/5pZiJXMLr0k+RUwSddXcdtX0ozFnC3e24YsEbf6TVWuUWhc0
         9xojO8cV1bR3zOK44Tjo50S7kV9Xe1AHAgFSFomGZOarl04kXqZMNSeeOd0TxTkN0dYq
         N8PcyyQYn0DVdrYkbRYw85AbQkKNWYfjc+yhXg9QiBXeEBxA1yej+mAdVHpUxRPPi5A8
         QJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568997; x=1692173797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IEuzWykTMtItBBOAFGOiv2XbuELxF8lm+BVPreJJuo=;
        b=ENxtKAaipNuYbZ99BGczOo/VsZ6vy37HDw92BW2qnAYB0heIEZfZUqfQmhhe0oV8+h
         I0kzhEZNff6XRDrvrm/Qp5ivEQt9mcUzgBWVpXYuh7tSUEqZV/CJdT77V5POcHL6OmC2
         Gz70A+wEb2iq3Ot8e7Lp7GLrMSjGG+S/1nKmMKWvdyIA3cNb/dV/Uzc9uwkoCbPPqlG8
         snHa9XrTozLVeahWl2j60TS1lN/jtK/Jf+yr0ymjmtKEnVYDycIucbcjPJZJUEuSw21U
         tAtsxuhseALGTSQJyQgucL8bCEcqSHHaXTemnxwRK8QqzPQdunHyBvfxEjNAbN6FNw3M
         5n1g==
X-Gm-Message-State: AOJu0YzatRH/h6F2U1N2LvJgTvHkKEAAct6UAv0xelov7UzQz3twFT/j
        698erL1SabrDnnz8pJlx3hs0Ds4a81/ZQ6KS0j0=
X-Google-Smtp-Source: AGHT+IHS0MXJBfpz/y6yTU3fPASv7s5C/fpHPIcAx3s3X69HAorv6O8k4CBnsZhYTv6+C1NjXVpQpvXRTloJJZLEKjc=
X-Received: by 2002:a81:82c3:0:b0:586:b686:8234 with SMTP id
 s186-20020a8182c3000000b00586b6868234mr3054576ywf.8.1691568997495; Wed, 09
 Aug 2023 01:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <97224321-c839-c0a7-52dd-3fb6e52fc15e@gmail.com>
In-Reply-To: <97224321-c839-c0a7-52dd-3fb6e52fc15e@gmail.com>
From:   TatriX <tatrics@gmail.com>
Date:   Wed, 9 Aug 2023 10:16:26 +0200
Message-ID: <CAG7LdX7DwNs4AenJgAkdUMa_09s_25jUE0O=4=0BR+Y9KU93GA@mail.gmail.com>
Subject: Re: Bluetooth LE scan doesn't show device name
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> TatriX: Can you also attach dmesg output to your Bugzilla report?

Shall I include full dmesg output for both kernels?
I have a laptop where I keep 5.9.12 and a desktop machine, where I use
latest stable from the Arch repo.

When it comes to compilation issues, I'm experiencing the same
symptoms as described here:
https://unix.stackexchange.com/questions/709671/linux-kernel-5-15-54-compilation-errors-with-gcc-12-1
I'll have to investigate how to downgrade gcc before I can do the bisection.
