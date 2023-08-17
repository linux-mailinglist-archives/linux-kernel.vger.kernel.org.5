Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2119177F0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbjHQHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348344AbjHQHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:00:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F622102
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:00:28 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d35a9d7a5bdso6906493276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692255627; x=1692860427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr/xLuRqHPiIp7tvo55AtM5IbQFVYhSzAqbDSIpKDYQ=;
        b=E0aIGzws7LZnOQoMDIQLZ5QQCvwK3FIktoBLHnRyargWuUNjpbXKtSPYb07sIMv8cC
         GffDGGFgQUn+C9SidEWqAkqEtKIKWluKX00Bgl/pVhWjxRxNy2Tma1x4gNAtqfpUaoV0
         jZzMwpQG9049n2/8xzs92awHZRPpTLMqZ1yyn1yCCowLj5e+IkKsQrLRyRZhbVwk/7z5
         6fhUkccil7QxApuBpEKZzGTmyCil2BKjUsbKAh3VYpWvISuSDijkQX/tFI9bxgWDvk22
         bn56iwM2O6LUL4AFib+GRk4TO73PF805B3fYvI2tPz9GZpMWIxg0YKVbOMzPxOuxXuPW
         +yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692255627; x=1692860427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr/xLuRqHPiIp7tvo55AtM5IbQFVYhSzAqbDSIpKDYQ=;
        b=ZuRMVOWSbQNcGHeRWOl4277GEHijwUPgDkWUhXsnkK5nkTChUb2354u0KEHlBS5C5X
         S82e7424gHWSmh9l72OgmijSD33SeN0elTcJfpyI+H4cOtxlevd+PLX/rhY6PGQj6y/S
         u2CmT6gn6MX4B2qlJZMtPkUIcfPKfouyS1LCRYE2VCWUmwKbT8crOHKQaI2IfFXuBdgN
         pqfkFCw2ZONdCbOga2bYLU3WgtMAeBzwtSJ9MhrjyQ5c6RGD6fV/oEQhCQHfSV+ESFbo
         a4j//BD7Ua8oBnQabpoLeNpR9X5byGy0Q5aaONwfFeBJcndoIf6uGu1K+C6URokgNlcy
         NQ8Q==
X-Gm-Message-State: AOJu0Yx77keL/Y3SWCCRsC1ZBmqqcd7ZziD1IW3gKH/uUfU6754CXGMN
        sohcXt+5k5nFjtDq6dKT1M15eIMiCgGiiWwQIJOA+Q==
X-Google-Smtp-Source: AGHT+IFA7jqQ3lKHYZ3TPhUsP6rkndiWbfY2uwFAshtkh2s4HzLjAg6woMvQ1l73WBWdTHuAIZfkrok2wV75tpUlxzQ=
X-Received: by 2002:a25:dc87:0:b0:d62:a199:fb18 with SMTP id
 y129-20020a25dc87000000b00d62a199fb18mr4535478ybe.60.1692255627601; Thu, 17
 Aug 2023 00:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230816122032.15548-1-brgl@bgdev.pl> <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
 <ZN2k7gemanIpbyFh@sol>
In-Reply-To: <ZN2k7gemanIpbyFh@sol>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Aug 2023 09:00:16 +0200
Message-ID: <CACRpkdaTn+Hj6_tiS1GGvwfcyeH5UGD6Q0K0pDpaV1Dk+WVRvA@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes down
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 6:41=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:

> My preference would be for a separate nb for the chip removal to keep
> those two classes of events distinct.

That's a good point. Bart do you think you can rework it as such?

Yours,
Linus Walleij
