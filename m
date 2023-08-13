Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F577A609
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHMK4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHMK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:56:42 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F1170D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 03:56:44 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d62b9bd5b03so3343246276.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691924203; x=1692529003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnCAXcHQ5YbbgyoTwMdYIMHDBrk3F+4fVGdkjI2OoZM=;
        b=iOuIxXiPcej0r67OfAA+KmyeRoR8tl1Qzg8AzJ+Q6x9HfQB9l/fmQ3m0RIawpKYpXI
         Fn+XK/OhY67bvUOpfo/L66cS1zHhXwod5sVb+GnOiMtbK1qXZ5l4QWLFxk464KaxWNls
         Rvm6cKFKFzjvRMXs2q774ImxcLW6otu+bVydg6MpW6Sd/fkE/AaKhbVXowUQyk1oWFA5
         ZoT0T9qJRLKbH1ED9KINRrajkDSFaowxHUTuwoV7LpqMpRNjjLNjkmmdnHMqzK74kzei
         QGf3Zr1v8fA0ZAOBqVp1tC0I9n7SUSCyozN/zv5rXTbdhpHddZQuL+XulTKa5EK0mL/p
         Cg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924203; x=1692529003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnCAXcHQ5YbbgyoTwMdYIMHDBrk3F+4fVGdkjI2OoZM=;
        b=SXfYhtF6JpM+Fbl+k+c9iJBeCMe+qMyrF0ydYGKf8auWgzhB5blE+PRKLCct+Cz9a3
         xQ5ee+BoZFiSGxbZdtHljfBMEXBM+EYuzbvOyhdnoEQIJVZ9VBuyyu2bl+CKR9wORcj6
         J9r4t0Z1+dnYCXoxUtkN74uSg9J0WhDbWYWE6PCZW6j4vtjnuJBgrlJxmjJOr+dQES7r
         hOLRJ5+dZ+8pivKKk/O0dlWGNyiOHS3wbxZ7ddV5JtTw2PyM0MPN5GikDzDQUCc6R5TT
         1umYUVbldk7Ndo5jcIPBYhkyu/kpLQM/cugJBXBRz/QTqKdGYDzVkPI3PNwOxoZH0xg1
         JzWQ==
X-Gm-Message-State: AOJu0YyQy56NH4KVP7zfr7UylUHzz6G6jdgKzpnuPoZh/uxiUHFFkj1M
        3mK5W1Z5mOJ/XlmJncq1zW9njyPpIuFIRgvsTWXOzA==
X-Google-Smtp-Source: AGHT+IFB1bUAZwI2DUr/FWaK8qZnieSurYZeAHm5xX+MszEu4nGhXFgKs4+dBfm5GfEVDJZKeulaCwIjwDWANu1uE6E=
X-Received: by 2002:a25:dad7:0:b0:d62:ba45:539f with SMTP id
 n206-20020a25dad7000000b00d62ba45539fmr6989446ybf.43.1691924203356; Sun, 13
 Aug 2023 03:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-1-0c384e8b5737@gmail.com> <244d165a-1e53-401e-be36-6bb3f4f260ae@linaro.org>
In-Reply-To: <244d165a-1e53-401e-be36-6bb3f4f260ae@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 13 Aug 2023 13:56:32 +0300
Message-ID: <CAA8EJpqiaEamZ6u9D_Sn-bgn8qdpqsQ2EMt7Tb9hKr5kNO2JFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: pmic_glink: enable UCSI for SM8350
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     wuxilin123@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 at 14:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 5.08.2023 19:03, Xilin Wu via B4 Relay wrote:
> > From: Xilin Wu <wuxilin123@gmail.com>
> >
> > UCSI is supported on SM8350. Allow it to enable USB role switch and
> > altmode notifications on SM8350.
> >
> > Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> > ---
> I can confirm this is also required for my SM8350 Xperia 1 III.

Last time I checked it, UCSI was broken on the SM8350 HDK. Trying to
enable it caused pmic_glink to stop working after some port
operations.

-- 
With best wishes
Dmitry
