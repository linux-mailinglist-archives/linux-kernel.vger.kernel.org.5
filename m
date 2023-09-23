Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56D7AC4B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjIWTOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIWTOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:14:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF6193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:14:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f6763767dso227457b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695496478; x=1696101278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VhOCWF+ynd7copH4f2yVtc2i5yJp0tKjP7DBJWHccA=;
        b=XxDmdafF5SqkVHtM6DYnVQfXJilGRFyMvcBgZrPmAnkYzBqZuyNew+I5oPaaN/rWfL
         i/Mm/+B9nSXR//u0GhkATeJdDVG4zZzLf+YKOsfBZHnoEK0Hfb82dIMdOvaCFab0XPbU
         DNlHxH5XHoYejfO+bBjWqGJgk5YqE5HZ/tGW1gHD4lynwwT8EOM9tKxw24ZVo6Q6n183
         tGm90SJRDJdDYTPxwpjLVDF7d8q2yMVFc+spf9/ZmqRRuy0Dom1NtWWJJB3sH0tuwiOn
         lE3bHNBYgaAC/UuTCywvurL5ye4VNMQDqrXQBLkkOPRqDIWzDzDnBtw2BzpY3koVttDV
         x/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695496478; x=1696101278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VhOCWF+ynd7copH4f2yVtc2i5yJp0tKjP7DBJWHccA=;
        b=S3twMO4KsmEZgjMKNWxgDAekMaiV/68enks/pcm0CDV//rG0KF3AgH4C2OaAsBT6nd
         lUbU6SmgXXf0MNgUBw36cC0qjmqc0hfHuwrFWs7R9uB4pqkHUEhlKpMlKVXi2Loksw0t
         dApIuHcPuM2doCOqg5wvVs34WwKk3fMKS1llhQNiZ0JoKIj8uwi2xBYXvjKI9FiRjXLZ
         otA1DNVMRV13nlYWAXn8KOi1ap+zWje8HPewY3DoGtD7Riu94XQBX+py7ZOp8ACrL2qs
         EITPUZ6Ygveix2tDZDUWdrjXyq/XYq/fIl7YRzVeJXrahUJB60lit4veT9J02hlffjme
         nUcg==
X-Gm-Message-State: AOJu0Yx0SGYXcgHwqi7sE6tzyZRiXIgG8wt0tLV0kgNFbex/mVBhI4yA
        n1HbNVNfG5UZ02AC6UuD0+9dbqZ+Ra/1+rDr0nHZyQ==
X-Google-Smtp-Source: AGHT+IEXrA6dbcuQVgJj6jiFnJaGVpMmWaaRY9SNum7koxm9FFIHsiBiEqOprk+GF7Q5FQ/v6O7buksQm9OGfKYzgUY=
X-Received: by 2002:a05:690c:2b0a:b0:59f:535b:52a8 with SMTP id
 em10-20020a05690c2b0a00b0059f535b52a8mr1489573ywb.23.1695496477936; Sat, 23
 Sep 2023 12:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230922084303.4164046-1-quic_gokulsri@quicinc.com> <20230922084303.4164046-4-quic_gokulsri@quicinc.com>
In-Reply-To: <20230922084303.4164046-4-quic_gokulsri@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:14:27 +0300
Message-ID: <CAA8EJppX==xq8Z9MCS4ZwveV0-WKbvEC3Wv1NzGvXXV=2q5DzQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: ipq5018: enable the CPUFreq support
To:     Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 11:44, Gokul Sriram Palanisamy
<quic_gokulsri@quicinc.com> wrote:
>
> Add the APCS, A53 PLL, cpu-opp-table nodes to set
> the CPU frequency at 800MHz (idle) or 1.008GHz.
>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
