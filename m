Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9C7DED71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbjKBHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjKBHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:36:28 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EB912C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:36:23 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a92782615dso7992697b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698910582; x=1699515382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02u/Cspi365LCx8HCd9FoPltB+qzXC3rZzncvR1kE0U=;
        b=uHUO+98b41tsNsBxdgCssSk91V7EqJfuiDcMUWf0qst9NzA5+3JxSYcHdTefvMQQSY
         PhEd/CKQMZ2lmdjD3ntwQU1mo6LC8UN08nrs3W9vc/bwwrikluxYPbeiSERGHOX/k/4j
         r8VRGWWx7eJhdMUUJ857YR0k6pH33bIGhHTfta5GJqTYv9hBRC//V7NqWn5KQ5hGZ64T
         0fBGG5NyJQwXXZwipPx6cEsrCVo93/L1J5NQPrYNOM42g+cE2nmFbWMXZUS3Q2T/Ds7o
         8tXOMpbAp43BzMVryPezxeRlY/uYUXANudjRQSmM2FS+DgXgie0hOeV5PPm30o6nAClZ
         Zoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910582; x=1699515382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02u/Cspi365LCx8HCd9FoPltB+qzXC3rZzncvR1kE0U=;
        b=sAw/fZdr0QQv6z/bXu6aRI7vPU3fI1orI3DW6NvpP4e94QONvxYDXtKhn6VX5av3nB
         GbMNGmlV9vpWY2LTd1+l0S7ps/PfSrXhSbMyJt60ZNB6Uhy29Nq/2auuk2Bd5zgdDfRO
         +57RZCyRN1vZY9L9zyAdSPJTXOWJjocNzNmBiKxHYtv/lmFEkyv7BcBQnGhjZLyrlbus
         DgowR3EV8syFVv6IsEoDC2xOUT12amNm+L91xJW/Lt5YiIF902/y5+KuVfclkm/b80iu
         ub1V0E8n0phBuXQS2xfEcjIjFGzpvKO2S6xP06T6fM0rmYjiShnx23qzJXdgTZKUF9HQ
         JS5Q==
X-Gm-Message-State: AOJu0YysH+g3SeJDm46Mn6qyL+JEBKsGJSss3SKuFsHMNaiObZcpk4JP
        TbHlXOgpK8QAfRzW8Hbcbg0zF1O4KCZy2Xv58QcNxQ==
X-Google-Smtp-Source: AGHT+IHcCjbjYppSjP6Dm3lf3ZtNlK+vHOYrwcD8HkVUNTog60tOSFAWYJQ/h5fN/5eg1eQ9CgJ0QQrxj+dDfj+ee1Q=
X-Received: by 2002:a81:6c57:0:b0:5ae:732b:ec1c with SMTP id
 h84-20020a816c57000000b005ae732bec1cmr15987159ywc.31.1698910582265; Thu, 02
 Nov 2023 00:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 08:36:11 +0100
Message-ID: <CACRpkdb3wLAZfU+_E0r5Rr_HD-bdFpf7K6bMD6dqiK1Ryv7NAQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength assignment
 to a switch-case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 4:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.
(...)
> +               case 1: /* Set default strength value in case none is giv=
en */

So where does this 1 come from in the end? That's the piece I
am missing in this explanation. Somewhere, someone decided
to pass 1 to indicate "pull to default resistance".

Is it coming from ACPI firmware?

Then a comment such as "the firmware author chose to pass 1
for default pull" should be added to the constant definition in the
code.

Other than that it looks good!

Yours,
Linus Walleij
