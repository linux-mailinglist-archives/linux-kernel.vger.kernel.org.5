Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C27B37C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjI2QTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjI2QTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:19:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C475BE;
        Fri, 29 Sep 2023 09:19:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf55a81eeaso109160315ad.0;
        Fri, 29 Sep 2023 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696004369; x=1696609169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0WpEnE1imZext9giY2eZ5FF+qNPYPUI0MpRn4yWIGAk=;
        b=MLrzUTd0m1BclwwlSVdg0ZJQlKtXk0A3jBmrtWnSNSxy/66RVhhzoVIE8FjlFsmdd1
         PdjV6VvFQGQRx78aWCjg/G1sLcEMqCVlxOkjuubn1KSPAyfjnIZVpYiDXJYHmHefcLYJ
         tstMERcW1ymnF2B2pPrpZbJylf5EekWAsXCCGM1muFM0S5hZNBip3XpHljw25tmi4HzW
         FhkszsG3QfbRBbTfQARcWMkm9Mch9abF0uduNHfeol82H92T14ijcDxMdOmIWVtbspHw
         MVZSwo20gXunh1JdXIHK0enbWnBYwX8ZLD3NQYWOAPeXPXCEkRIalEi912mr2HIOMFL8
         s52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004369; x=1696609169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WpEnE1imZext9giY2eZ5FF+qNPYPUI0MpRn4yWIGAk=;
        b=IP4bL8BDAqyiqPTuDlXJyHxi88eJrgdhctryWKIgHSHaRWZ8ANbuUXMBTMiixEJUfA
         oTg42D4OfoEn1cRq4OWX/U55QZoSNsr8rVXk5asE6N1uKs/t1NyhTi43k96fCnh4+oRO
         OSS6DwKgdzlcaDIguzaHToYmwvhCYHY9yT5jQfLpm01nHkHLFYfeKioHooGZceXQ2Z7S
         CwiISFWf+IvO7euAPETrLCx0kfeHox6KH0FwwdE40l66Jz2uy0PbiyCRGTE1Pa6DP37m
         FaMbT1JjFdg2nO+WBwFOTISMH4htHxvZfjuHsp8g4uXiAe9hfb1kkN3Qoeptq9HyXnYf
         ptJA==
X-Gm-Message-State: AOJu0Yy0ijGcMItv6f/8tEtgmLC73EZxXq9WPiR4EDkGy+iQC+Pklnd3
        YJHurBRYSFAKhTQAm2Q8nyhGSpCjeEs+C36r/Wg=
X-Google-Smtp-Source: AGHT+IHCv69Ph+uWHMuegkaLLFRXFuCTE8PBWtTLTkK4H7h4cibsl+mkE6QssdnHToH8zvgYzjBvy/5gZoMtOv4AWsM=
X-Received: by 2002:a17:90a:a78b:b0:26d:1eec:1fc4 with SMTP id
 f11-20020a17090aa78b00b0026d1eec1fc4mr4345004pjq.19.1696004369498; Fri, 29
 Sep 2023 09:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230928210525.1265958-1-robimarko@gmail.com> <20230928210525.1265958-4-robimarko@gmail.com>
 <fac9c693-5d50-428d-9ea6-83ebec7239c3@linaro.org>
In-Reply-To: <fac9c693-5d50-428d-9ea6-83ebec7239c3@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 29 Sep 2023 18:19:18 +0200
Message-ID: <CAOX2RU66J6XY_jJsBi+9djo6d8nmRmMsFbrBGeT7dCJe+MPh=g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sept 2023 at 15:57, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 28.09.2023 23:04, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> >
> > Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> > Use opp-supported-hw binding to correctly enable and disable the
> > frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> > 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> > 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> When resending somebody else's patches, you need to add your own
> sign-off at the end.

Yes, I spotted it only after sending and it did not make sense to
resend immediately it.
Will be part of v5 that has DT bindings sorted out.

Regards,
Robert
>
> Konrad
