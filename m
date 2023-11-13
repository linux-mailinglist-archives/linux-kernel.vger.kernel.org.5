Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC367E9E62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjKMOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjKMOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:16:15 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F7E10FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:16:10 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5bf812041a6so47988267b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699884970; x=1700489770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsObpwiNRRoDaNBTqnKKwKCtx88JHZeh51II3/PGBnI=;
        b=WpKDgd+uVI58OVzn3e8kkvCc2MG0lGpmQSwcahu7Eyf3MnRjB+FPG9MYSg5xLXU26a
         FT/fjGlunh0ABlb0pd6vjuXUgQm53kPl9/5xlW824g+WPAdMe30vajXMbbvuCXI1/59h
         M4fADNOddQFkhn3THqo+4YyJTN8pCtiuhRXgrQYjFKEDeIl2PwHStx8M6L0td5kvpRhv
         AoQvb13Nqpapq2ZFvm97ERRlm2KcekWL3tgIupr4x9t4qe5XNV0T1q1XO58VjL1EAfBX
         w76PEUCZWtESIJRrlIX7EL9GURRhxbA2PfMK8HRFZLnZUOK8Y+2Jqi912yvtH7qAXqoV
         lE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699884970; x=1700489770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsObpwiNRRoDaNBTqnKKwKCtx88JHZeh51II3/PGBnI=;
        b=vJs+g4UeJNgJOVU+tmUwJ4hnxqS3y53AV2gSZG8bJuYW32M5uCTVtXeJNGJ8UZYLn3
         KSf628uKSGsw9XItqhQeHtzdhBseibX2xQmnEfV32s08KPobeuFvjm6M+GalpwJBxJyI
         Wo18CeyDBkkSm9AdVhossAgrh3SZXFAUEHEOlzGkjfDoWNxUZga2DeEJJMLwaoCEbaot
         GsHUirzE/xPpO8cuZqBRKxequmGlks1JwspJN3VlDTa7FYbVbwWEhrulaHvuvsd8nr1y
         7I0n6rrr/5XU/BmVX4Xd6iNFqIVgmoqU7wSJQBmS/Op1f0xJ6scHqx5TZddBtR4gXTyC
         oVxw==
X-Gm-Message-State: AOJu0YxoUJDfJmD7sDkHJr/J0Be9reSebbDK4odwgVXZfdFo8qPmvD7T
        fMokA00DAiYWkREIjd2m9mAGUfownujwPmUjwEY64Q==
X-Google-Smtp-Source: AGHT+IEfo3yjlThVT/1VbEzaAtk/giSVbUC9q6aHRoszCrkPGNGtNlWOQLaQkv5lYlgVl+3GIUdM37qvyenBOQnoLpA=
X-Received: by 2002:a81:8085:0:b0:5a7:e4fe:ea3 with SMTP id
 q127-20020a818085000000b005a7e4fe0ea3mr6865035ywf.22.1699884969990; Mon, 13
 Nov 2023 06:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20231031015119.29756-1-larry.lai@yunjingtech.com> <20231031015119.29756-3-larry.lai@yunjingtech.com>
In-Reply-To: <20231031015119.29756-3-larry.lai@yunjingtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 15:15:58 +0100
Message-ID: <CACRpkdbPWxQMz_1gG1He5QN65BActhyea_KBv2cyQ_VQxc6Feg@mail.gmail.com>
Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
To:     "larry.lai" <larry.lai@yunjingtech.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee@kernel.org, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry, Andy,

On Tue, Oct 31, 2023 at 2:51=E2=80=AFAM larry.lai <larry.lai@yunjingtech.co=
m> wrote:

> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control) through an on-board FPGA.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
(...)
> +#include "core.h"
> +#include "intel/pinctrl-intel.h"

As mentioned this is using the intel core pin control driver infrastructure
so I want Andy's ACK on this before I merge it.

Yours,
Linus Walleij
