Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67C67E115E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjKDW1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjKDW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:27:12 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E5D7D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 15:27:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso3779429276.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699136829; x=1699741629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzIrycxZG1tOQv2mvfB/UubZm3MyTqIZcEqXJO3t4Ec=;
        b=CJBFig9GD0ALEp1NpOLTmxfnht2V3/fxUel6BJNHeoib7U0tlNoVVvWL3kX4AZ2JJ1
         1t+b4duQGagjlO0IpcTjne11GDRUZ9HOKzsBQBtwekP6wG7XN+Mlt2Ji8eyaEQgjSipk
         DFdCHHJHJBEX/cz66+Q2a3TIzVesQBH84Tql/JrK2bVIhYDURdo7pIi7WlWV8Rdg5fBR
         ICi09XkjlNoSFzND/J0GKTj449hBANB+9Wrsz1pszugHM/KWO35NmAFQTINXrwU0G+tk
         T2Hk4UOOo9TIDm1JPs9C4jr6iWZ2HnZCZA+ca4YrmT59XGlDCaAA+3EDTMKbei1V7lMo
         OPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699136829; x=1699741629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzIrycxZG1tOQv2mvfB/UubZm3MyTqIZcEqXJO3t4Ec=;
        b=IEwALY2q2FuP4fiV7XYK/I9USUhX9RdFMhXGR+YXXvMHN4aRrotqhcsXVsM4fB6sEB
         yw7SDjQhdfssFMT3ocOHBcP1u3vCjaNLJdteDz1lDLBVWycMESQNZEfcOpXnz54dIwUs
         iTuzYo+4+iwHNVza0od+7n46OzUWFVSq/5wj/mbNku59O6D5vXZi695w81qYqPaAQKcs
         FyWwFm8AHTVkNpyUw/gLWuxmvan4AqRdaAFQYv5d7m6WBNJd4tjIgcvkv04tznqKeV1W
         czipbV7kvTYBpzb1AZiSXkrs9DWwaBjUsiK6HY6gMCTEn5vv/okZNcBCkgy0EsEiFw1r
         +F8g==
X-Gm-Message-State: AOJu0YwrDS6IIRXEgxegXlWjDY9ZeQKNooMIWkc10SC461tPxbKQ5Ji0
        KLkgSr9JSQ7d0CqaOT+sfyQjpClgB1JjcsQis5Bqgg==
X-Google-Smtp-Source: AGHT+IE8SiCwR3UCj9kGbkTIuetyg/dQsn69e3ZmJEbcMU/feHbnfsxVpaHYwy5vgVuTDkxUDgOpXiGPjQaLYj7b6KY=
X-Received: by 2002:a25:7689:0:b0:da0:3a37:61d5 with SMTP id
 r131-20020a257689000000b00da03a3761d5mr5905636ybc.4.1699136829002; Sat, 04
 Nov 2023 15:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com> <20231103195310.948327-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231103195310.948327-4-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Nov 2023 23:26:58 +0100
Message-ID: <CACRpkdYKYF7VMcMbiaXHrPjsvYCUjaUNPJXMdrEAWH5U377f2A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] leds: trigger: gpio: Convert to DEVICE_ATTR_RW()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of custom wrapper, use DEVICE_ATTR_RW() directly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
