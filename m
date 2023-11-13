Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C407E9DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKMNub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:50:30 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424CFD4D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:50:27 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5afbdbf3a19so51018357b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699883426; x=1700488226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XpqZBrmzhIxQHZe4Z2kGptUvFXh+Fzs3fll/Ehi74k=;
        b=Lt2/ewbByVxhjHp3mnVuNBOWvDiJe05gtia1NiTTKMawB95jOgUDxHQK5+AC10TxAK
         Mf4lL+xTqjrPl8sUuCNNXL8IbeBnaODOZFbotEr6tw4O/p7LKOj4HwfXHyhIDYe+x3V9
         ggCWonZKmpZDCR4nQRP2bMcx3tSWHmmWO9Vx37Hnxqvm3lMSiC2sou7SfQj+7ncHVl4U
         G0w8VCy0N9/51ouVp61QcjQkTU6eSXJtOhDZewecPw9d1SsAXekhIWgKrbkJOO1ISwPS
         fF/FWeSPxVDH2gMCSMYPZ7vgn/KDH34sH95NcuRpHI48rPkFC6Ui0gr8G0vC/8I8vlrn
         xffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699883426; x=1700488226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XpqZBrmzhIxQHZe4Z2kGptUvFXh+Fzs3fll/Ehi74k=;
        b=vRrW/x54IdbgJ52j30IFLEWEfHRrfB9Fkvs5TYAzCsVwvr3ZjP/Bdt3dPNkaRTjXbd
         T/qtVCGvjl563eKx2B//t1Jcg1bP0Mv/3ilk5EK0ZpPewyUoVoFQw0bZYoUA3AD6Ga99
         u2KVDzaQexSIIzl3AAvXbUaa9it6/JDL4Chl4xFJyjlCIMfmMBPeUH3+NQ6eGdrIkxex
         xyWFXOvm5wunz2lbd79FkXC4JhoHsEkvDxK0wQw7D8ETdSsfFeVG9GuqtiF7jiHtFB4c
         fK0mr+z+MmyJY76+vhsdtMFh+mXMHNCJy+eoraxvgpNvCTgie4IL4jioGaE1UtuAUwEx
         da+A==
X-Gm-Message-State: AOJu0YxbE7uDMPSTshtWFyd4R2kJgaJJIAulcmXQ/xObDjjoXh0kbR0U
        vHPXeCk2k0apgeb3nJmBLnye8mSku3vd0m51tt5/yw==
X-Google-Smtp-Source: AGHT+IFarUwhs2XDViHk17NHkYuv+lnEMn0mJh0GEylRpU9AvpwYrjP2mMg8FfOr2np0Ga+Kpf67nCtk7qKvkLe4PmY=
X-Received: by 2002:a0d:ebc9:0:b0:5a8:dbb1:f73b with SMTP id
 u192-20020a0debc9000000b005a8dbb1f73bmr7536343ywe.14.1699883426199; Mon, 13
 Nov 2023 05:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20230908055146.18347-1-Linhua.xu@unisoc.com> <20230908055146.18347-3-Linhua.xu@unisoc.com>
In-Reply-To: <20230908055146.18347-3-Linhua.xu@unisoc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Nov 2023 14:50:15 +0100
Message-ID: <CACRpkdYkAcHvvTNj1=n_ds0u=gdaa7Ln=t8dw8jJjO+hSb6HGA@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] pinctrl: sprd: Fix the incorrect mask and shift definition
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
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

On Fri, Sep 8, 2023 at 7:52=E2=80=AFAM Linhua Xu <Linhua.xu@unisoc.com> wro=
te:

> From: Linhua Xu <Linhua.Xu@unisoc.com>
>
> Pull-up and pull-down are mutually exclusive. When setting one of them,
> the bit of the other needs to be clear. Now, there are cases where pull-u=
p
> and pull-down are set at the same time in the code, thus fix them.
>
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>

I'm uncertain what to do with this patch because it fixes something
while there are unaddressed review comments, I think we need
some more discussion here?

Yours,
Linus Walleij
