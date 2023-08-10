Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381777711C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHJHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:14:14 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7183210C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691651649; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j4iF7159JBK0Qxy+Zq2tnvVcKJvETauSU9xd37uteFitN+UkgYyKOOqFmmjOK2nemm
    gmlzdZv/64GKvU+YAbYJkzSPQTSqBM8+Lj4JJeGy2f65QakPHhbjPlzmNmOUQzQ1o0hc
    5emODtN1nXVCfBv8b3s0cnRMtweuTL8RAYFqDOn4+lN6leBaxO+9kJLlvq986nRLGA4H
    2U5c+tAa+I5Dp1/TtM7fHKyQSZa6aBRwZgufETgzC2j0yTlsGL3O9h/GsCag60O0/5of
    0uXK60hVMln+Xcb2yNbdRHzjmofWtNaabJuhjv6Xe+sPRP4TIpzjrVUMhlxh81Jh2H1K
    szng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691651649;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dSXNIfeUu6tEetm+yGqUwYCnWcvobbztyheAV6JgLVc=;
    b=fahcJ0yI+6oQA+pvxgLpioWUzTyHz8mcWZKu2rU1nuzFTTxUJJ6tyvbHFT2VzEA4US
    9NWsBmluNatjHhZt3dNOPz0m97HGapidpm3aNaynd/aR/NbNhhthsYDYTG7txXpzRiGU
    hse+lRhVnO9HCbJla1mkhR/GjXXieyceG+OecXvBiUcfza+aSSq7GOPj1VjIM+glXkVE
    KxoEVgGam22HkG3+UrG4zQ7+/t9bIZMI9bTEi82Ec0GIebZjlw2qVBPpFgIxLERfiwYA
    DtZYoWTSiUeiJkoi4gumPiIGE7DuGUcF9ZMMdZCnCBMGSLjXr3vRtyuOhqrulVg5rTlE
    p+zQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691651648;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dSXNIfeUu6tEetm+yGqUwYCnWcvobbztyheAV6JgLVc=;
    b=hguuSdyKzKP2jUaQkBqtRgVUcZpVoKTaUMujJgvRpG6pjNIFeQMt+smur3a7J/p8+6
    oAJNFWrFXpHjtlNcyGIfqq4h4HCoQtUweoAW5vibzsY0ecZCwQHuSMFBxzMS/cpX97ha
    rXNJ7GDBoNV0ox4np6xfJB3O7XaFCkZz0qX+BCXfCe4Sy7U6ZM8tYhe4Ivn8i4kxVDJC
    Vkj2mXVx1t+MfTWjXnbD6LIciuOkGRqByausml27ODFxT7hgjMPHfFmKBXtz2FfJ372t
    Ns8aiYSryDwHy5c8Wibtnz6Kp6hZu030BgZkkmcAWFpwrjgMSBbFejGYRRUPxHPqydLs
    9Yrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691651648;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=dSXNIfeUu6tEetm+yGqUwYCnWcvobbztyheAV6JgLVc=;
    b=c7buaa7bNriFdiCwe8iCz6S5t8Z1Js/t1e82EL9hFRxKi4oGfG6o0bznWsIUaP6BZa
    6RLQvif8lXiA+JNZVDDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z7A7E8pRE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Aug 2023 09:14:08 +0200 (CEST)
Date:   Thu, 10 Aug 2023 09:14:03 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] pinctrl: qcom: msm8998: Fix MPM mappings
Message-ID: <ZNSOO47C5N88FpUz@gerhold.net>
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
 <20230809-topic-mpm_mappings-v1-1-5e17dd76b3c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-topic-mpm_mappings-v1-1-5e17dd76b3c8@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:38:54PM +0200, Konrad Dybcio wrote:
> Commit 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
> added a map of pins <-> wakeirqs. The values in each tuple were swapped
> and the last one was missing. Fix that.
> 
> Fixes: 29f6e7e379fd ("pinctrl: qcom: msm8998: Add MPM pin mappings")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm8998.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8998.c b/drivers/pinctrl/qcom/pinctrl-msm8998.c
> index b7cbf32b3125..08d6e555652a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm8998.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm8998.c
> @@ -1496,15 +1496,16 @@ static const struct msm_pingroup msm8998_groups[] = {
>  };
>  
>  static const struct msm_gpio_wakeirq_map msm8998_mpm_map[] = {
> -	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 11, 6 }, { 22, 8 }, { 24, 9 }, { 26, 10 },
> -	{ 34, 11 }, { 36, 12 }, { 37, 13 }, { 38, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 },
> -	{ 50, 18 }, { 53, 19 }, { 54, 20 }, { 56, 21 }, { 57, 22 }, { 58, 23 }, { 59, 24 },
> -	{ 60, 25 }, { 61, 26 }, { 62, 27 }, { 63, 28 }, { 64, 29 }, { 66, 7 }, { 71, 30 },
> -	{ 73, 31 }, { 77, 32 }, { 78, 33 }, { 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 },
> -	{ 91, 38 }, { 92, 39 }, { 95, 40 }, { 97, 41 }, { 101, 42 }, { 104, 43 }, { 106, 44 },
> -	{ 108, 45 }, { 110, 48 }, { 112, 46 }, { 113, 47 }, { 115, 51 }, { 116, 54 }, { 117, 55 },
> -	{ 118, 56 }, { 119, 57 }, { 120, 58 }, { 121, 59 }, { 122, 60 }, { 123, 61 }, { 124, 62 },
> -	{ 125, 63 }, { 126, 64 }, { 127, 50 }, { 129, 65 }, { 131, 66 }, { 132, 67 }, { 133, 68 },
> +	{ 3, 1 }, { 4, 5 }, { 5, 9 }, { 6, 11 }, { 8, 22 }, { 9, 24 }, { 10, 26 },
> +	{ 11, 34 }, { 12, 36 }, { 13, 37 }, { 14, 38 }, { 15, 40 }, { 16, 42 }, { 17, 46 },
> +	{ 18, 50 }, { 19, 53 }, { 20, 54 }, { 21, 56 }, { 22, 57 }, { 23, 58 }, { 24, 59 },
> +	{ 25, 60 }, { 26, 61 }, { 27, 62 }, { 28, 63 }, { 29, 64 }, { 7, 66 }, { 30, 71 },
> +	{ 31, 73 }, { 32, 77 }, { 33, 78 }, { 34, 79 }, { 35, 80 }, { 36, 82 }, { 37, 86 },
> +	{ 38, 91 }, { 39, 92 }, { 40, 95 }, { 41, 97 }, { 42, 101 }, { 43, 104 }, { 44, 106 },
> +	{ 45, 108 }, { 48, 110 }, { 46, 112 }, { 47, 113 }, { 51, 115 }, { 54, 116 }, { 55, 117 },
> +	{ 56, 118 }, { 57, 119 }, { 58, 120 }, { 59, 121 }, { 60, 122 }, { 61, 123 }, { 62, 124 },
> +	{ 63, 125 }, { 64, 126 }, { 50, 127 }, { 65, 129 }, { 66, 131 }, { 67, 132 }, { 68, 133 },
> +	{ 69, 145 },
>  };

Are you sure this is correct?

/**
 * struct msm_gpio_wakeirq_map - Map of GPIOs and their wakeup pins
 * @gpio:          The GPIOs that are wakeup capable
 * @wakeirq:       The interrupt at the always-on interrupt controller
 */
struct msm_gpio_wakeirq_map {
	unsigned int gpio;
	unsigned int wakeirq;
};

MSM8998 has 150 GPIOs and 96 MPM IRQs. The tuple { 69, 145 } can't be
right because 145 is not a valid MPM pin. It's a valid GPIO though so
the original order was correct. Maybe replace "Fixes:" with "Breaks:"? :D

Thanks,
Stephan
