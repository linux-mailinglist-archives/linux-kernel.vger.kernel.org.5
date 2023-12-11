Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B480DFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjLKXrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjLKXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:47:05 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973FECF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:47:11 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5de93b677f4so32364707b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702338431; x=1702943231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ArXTC/xeZqxu6gWS7eaFl9W6mwBJ0u0LhdXscG2ZEs=;
        b=OVvOwT1J2lzSsdsNN3owuRtlNuxnPtmYu+d/jvO7GuLOA+g77Dcz1XGjdtb9gI1NY7
         MD9ELQgpKVLo1y7n55OKuWMw2LsZU1PTNOxb3HI2y+lY3ARRVwlFlD5w8h1yPKpDPmHZ
         syFSAroyNsMyW27GGBCskTlrgOV+gDmiFSBi6vle+gR8Yv6Ibl+wV0h6arLkXQMWGvci
         yQE2yGVpId6vNXvwigz8uFaCYprLu2RqnT0f2kSs10EoR7y7uHnL9HkLqyxU4C0b2rLx
         J4AnS5ifoHLWyvci561BmDe7gfHibkHBo6rBD58/4gh5F5/lthNmaVE1jsn+qjtt48aL
         pqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338431; x=1702943231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ArXTC/xeZqxu6gWS7eaFl9W6mwBJ0u0LhdXscG2ZEs=;
        b=laZa1KDCjvqfPadHnm6LKXNyo0BV05fUk55MkEKdDcsuLOBD0oYLBF3P1XDH5IKVWX
         K7ecUGO7uSEt35zPui2nbwzXKfLdcT4FS6qCBvjNJ/Ym41yxDoDf4Dk3x6c8m7SIXyEv
         MOBQtY30i1GFSt7+iF2SrUdeOewdb3ELil7C8QnQiKsv/vb0kFlStABDF4nP6b8eKZtM
         xdKhBcCF9iMHaRxYEVgQGwJdX8WIcAfhnhXHfS0znnpvLsN1Zb4+qYpm7c5+6n5syN62
         TxIArmVZGU2XdWwiUd6r1m1WPpdPbh9SNlamLzOjHW0c5XmxUbgY53P9Bgy3dYIkX2u8
         ohbg==
X-Gm-Message-State: AOJu0YzsBFtVOWbjFI1d2FOtE9+KnVQtRf+NenkytrPfFJr5TXNRYLPq
        XQbjCNB19K3lxgVw/4h3MArosWiJ196lu0+H838Vjg==
X-Google-Smtp-Source: AGHT+IFK9uYJuRbHGv1SXFtZuTcuj72PKdDKu3s4DZM7a8oXOLoxkotONFx2SVn2whlKcO3Jb1pkCctyu0Vb136hGn8=
X-Received: by 2002:a0d:e652:0:b0:5d8:21f9:4efc with SMTP id
 p79-20020a0de652000000b005d821f94efcmr4077957ywe.14.1702338430812; Mon, 11
 Dec 2023 15:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20231208083650.25015-1-brgl@bgdev.pl>
In-Reply-To: <20231208083650.25015-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Dec 2023 00:46:59 +0100
Message-ID: <CACRpkdb1FAnTupSASYgBTm4mWizz1Z0Pi6QBnXeQxxzsPZHzYA@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: immutable branch between the GPIO and pinctrl
 trees for v6.8-rc1
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 9:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Linus, Andy,
>
> Please pull the following changes into your trees for the next merge wind=
ow.
> These are the patches providing a safer alternative for gpiochip_is_reque=
sted()
> before we rework the locking in GPIOLIB.

I pulled this into the pin control devel branch.

Yours,
Linus Walleij
