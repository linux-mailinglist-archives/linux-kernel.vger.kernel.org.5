Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB247BFE62
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjJJNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjJJNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:48:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B8A125
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:48:48 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f82ad1e09so71142837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945727; x=1697550527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awE6efcM38jnk5pss6ok2os1ERWX17UeRfoc3ts5j1U=;
        b=a4VMKn7CtaJkRMTJPP2bl4sVPwjm1HspHXtJ6vzJj/ksqNlK8IraTtEmtFHfPphUaL
         oTEkhgnaRMhs3AE1aKVne12cZ3XaYx6omzZZ+gj0VaY0NxAbyblmWJwr4LumMHXuQdam
         XejE5R73Ky/zo7L2IKZ9TXxjkyBSKdfTJCgdBKtl8r/7F02zICIrRsUt/bzKokAAIJPn
         X0ZiyNB1PPVShffqKJSwZtr7JbiwFNpJf3EXf1vDkkYMY+GyZaY8GUGpPkvcvPmIiIZT
         x1YV83B8s6uREV/xC/5LEZ9vwDqEExRN5b7t6vzzDAYXbOGQp0EtPZiSjZ28fwGb7N07
         zy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945727; x=1697550527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awE6efcM38jnk5pss6ok2os1ERWX17UeRfoc3ts5j1U=;
        b=SJkm2v/5KbeLGWkiONf9XxLpw+9PcQqQQJxuTbRHWMBMxUNYwGIWxWHOOP/B8vWdVc
         Ic0FM5eNY2FgAhfuI2lVkrxkVv3ElT54EBfL6Ywxw4nFx+YN5cG6aWEHhgpkJi3e6GiT
         PSql04B3xZCjGUtGwX00fOw/d0W+RUPlX0WHNI+5/wQbkEov5ndqD988IHmUKpmQAABf
         D+5p7daCWnB0UaeHnABphdS7RKJq2PTM++syLkynR5znfiZD7X1Gg+fwWMQLG2VXI15j
         9JxWeq368qYorCab5VrB6PsE/LWmHLqJjHUEjsJ5ea4wqGmmEELQL0popF/SRa6rISHV
         k9xw==
X-Gm-Message-State: AOJu0YxKv0e8Gs3+yoHHjqvlAFxT4R2PskBrDHzu8b1GtoVC4E8WTy7e
        Je+NvaydH3owIpks+aTlyDhRh2vQPyz0VYLHmABVJA==
X-Google-Smtp-Source: AGHT+IFKtXQ7bowPMrDeuE2Rh0fL5KWLiYWWmyhnmgM1tPzY9nRlUoBS+z1BtLRNVgWPQl2RE7/tMM4693wyr8IBlk8=
X-Received: by 2002:a0d:d856:0:b0:59f:687c:fb39 with SMTP id
 a83-20020a0dd856000000b0059f687cfb39mr21626344ywe.14.1696945727397; Tue, 10
 Oct 2023 06:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:48:36 +0200
Message-ID: <CACRpkdYxjZd+_7jdSg3e1MfE4zcdAJAAYfGPToRZ5cygdffePQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: Convert to platform remove callback
 returning void (take #2)
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 6:25=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Uwe Kleine-K=C3=B6nig (3):
>   pinctrl: qcom/lpi: Convert to platform remove callback returning void
>   pinctrl: qcom/msm: Convert to platform remove callback returning void
>   pinctrl: sprd-sc9860: Convert to platform remove callback returning
>     void

All patches applied!

Yours,
Linus Walleij
