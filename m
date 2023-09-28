Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712777B27B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjI1Vrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1Vrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:47:51 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41EA199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:47:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f6767a15dso372917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695937668; x=1696542468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEMGs1vgz/6gbs1d5dp2hfUQXzmFRliUSNIHCRqfXkY=;
        b=xENC8+J50BNWsfKzEEQoEpZTdIeI6RtfZovqo82XF7hv9ktSxz9eUc0I/qXVHC1iaY
         Fn8UY1wd9b/ymzcnvaKvE7HuVMdZM2GfmbizzhM+VUYWOUk361F7vzM8GA3espUWGJLq
         +5JxUhns6EO6PzTPzNVGjwkom8aJEg1g8InEBsg3/IPwz0WtBm8h4YnJYIG92D968CIy
         EtrrQ/yieRPQvPxOhpgCe/keqhfsY7+dBWhrW/uVFG250GP7sON7g3bJVIaNzImDtoKI
         y8jNjylNjX6rS9KX1pu8zg8heEuQ9x0RxH8u4YjXWllBWpS1w99ftcijHhfNGypERbCJ
         +w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937668; x=1696542468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEMGs1vgz/6gbs1d5dp2hfUQXzmFRliUSNIHCRqfXkY=;
        b=g1qJ4Njqyoi0ehv8fJ1voi0k5TLtKBy/clhDNj5FKl1jDJMhczGADZCuEpbUXX4vcv
         d/r1RFLgxxOa8n94FWRa5ib4dNIE1L8DaI+Bp/O2QycoTL5WEI+gfnhQ3UQaeA1JMoPU
         GOy2ZI9Tq9HEa5zitreA3gJdFT9yxliGzCahMGnpQr4dFIPq4c4+4oWMn8qt0HfW8BwU
         ct8TA/dLSvJD2DkAsACvrc3hsmCYRbZPbgYZmY4xhNYnShLgcoDDQRu00jyiCN3E6M4o
         Gn2F7i2lFFy6YZq9Mqjz+vu0j/6uh40fHuzl1NKkoBMNIaeFzg9THJ5jJZ+TyXxNkpkw
         FCww==
X-Gm-Message-State: AOJu0YzDC7KzMjku5VNmPkCx7wG9NQ3J0mqXlASKujohvkrl4fhsou06
        mxSZ1XQ2oIajHGjChIDXY23FZnk51HcB7CnKxizfDg==
X-Google-Smtp-Source: AGHT+IHyP8J/6Rmx6r1ZNaVyrqMkNMrbYuIY2xH56GVEGPTsv/gf0R7/crKLTYV4ka7wcvWF8IpCR3fLEPBoRV0lfRU=
X-Received: by 2002:a25:ae96:0:b0:d86:5cb8:29e0 with SMTP id
 b22-20020a25ae96000000b00d865cb829e0mr2073234ybj.6.1695937668156; Thu, 28 Sep
 2023 14:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230920085639.152441-1-brgl@bgdev.pl> <CACRpkdYtbGqmMqN7FNhjYJGG+e0jWQmozf9kpNHiUBJvd2c=7Q@mail.gmail.com>
 <CAMRc=McrXEQbwcsK3yrfROujezjMd1L4EcJj7GNTCE5L6zD1gw@mail.gmail.com>
 <CACRpkdYNA1rkG5wJ0+rAT9g4EyzfbN5VP2a9vuMMk_RD6bMLFA@mail.gmail.com>
 <CAMRc=MeaAG5w_JzgSNs-EC5HY=2izC4W1FHZ54trEW_PvA8Yfg@mail.gmail.com>
 <CAMRc=McuKNg5r7m6OPtwYc3er7i6JB2JN=H6QVJU_G9BVtnuAA@mail.gmail.com> <CAMRc=Md6=UNVt-HygYoaqwXXDdjrqsPvbyOrQcThjHOWAzLQ9w@mail.gmail.com>
In-Reply-To: <CAMRc=Md6=UNVt-HygYoaqwXXDdjrqsPvbyOrQcThjHOWAzLQ9w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 23:47:37 +0200
Message-ID: <CACRpkdbbkw=Dp054c5TLFuXaVK9q3+hco9cxrjW+M0hnSZrNdQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: extend the critical sections of lookup tables
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 9:01=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> If there are no objections, I'd like to queue it this week.

Go ahead.

Kernel looks better after this patch than before =3D> queue it

Yours,
Linus Walleij
