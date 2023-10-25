Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DFC7D724A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJYRce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:32:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147E2138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:32:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2b1af09c5so3521158b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698255150; x=1698859950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2HVv1I+VHPYBmP2qyskHC3BNYGeZwM5VQdpXShNy2UU=;
        b=zf5ACJgYBf0QnYXanrqJVYm+tkFt0XvZ82DuSfzFskWcUAIwsbM26e7W46k/ob7Cr8
         jZ3wHVjD1KQtZj8S8IFhXBmNQMFG3BNwCgA3b7a5IWDASv0rVTFhO9ooqrYmLP/k9Ecf
         kJ8hdMWlMXAq3E8NaGzUAVtGGMUmWqFWpeY1ww7pC6uSBQzCocpDInmLLMFabq7mPxy8
         wCvxhG9G/1ELH86czQTeM7fqQQFMuCw78zXB9gWyIkay0k7XfqSZ3scfoKx14ddjLzJp
         VgglAiuaKrlKogBp2g1BF+v8MIW9mm22zEPvLZoVV5LbRG1WvDqeU0u7vNG0MGPAB/HL
         1WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255150; x=1698859950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HVv1I+VHPYBmP2qyskHC3BNYGeZwM5VQdpXShNy2UU=;
        b=ZFUMZCUdgjLrg2dIpejteVgi01m9Ikc9aYlFZTfxHu7tH3q5d06XLen6T5MxscLzJr
         4FhbR5Z46F+vWAMnOc7fXRnpw02yXhFbExyz2Lcw3+5OarLroaxoyiHwR4MuxMcbM1SN
         Bt1ie8ATvevN6b7q6KJ0VD7Sog0FenAXBAiKP5CeIW7IRby2U5B1VWq5HhQyaSQZwzuA
         MGdqYomBwaGaQwRkn3LyO++8gOS6QeQUcp6Nmp3o8GN3xJ2axVYsCmrfUAqCUnk2jkRC
         KoDaKzHDgo65WfieR/gKBZGh4dC0lQD9T+FJ20ZDZHXcjRZ8DnwczlJFrT+q7Zzpz4Kr
         PLvw==
X-Gm-Message-State: AOJu0YyLXewEfSw1gvk6rEOViFe9a6zFbTPyuC27Mgw6b/ssEUArsCOs
        V2D/QXGNLKVmnr3tFJxTfxF22uCwlsUj0xW+VoI5TfdFboajuv9aWzI=
X-Google-Smtp-Source: AGHT+IHK3QW/LQO8x2wSrRAP38zFqCKcXAPmcxtAPrlTRDXOL59OgKdxwhV3/4We8G2bhIYvPQK38ep1jZnF3JLZbxA=
X-Received: by 2002:a05:6808:bc1:b0:3a9:cfb5:462a with SMTP id
 o1-20020a0568080bc100b003a9cfb5462amr17552310oik.36.1698255150350; Wed, 25
 Oct 2023 10:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231025135550.13162-1-quic_sibis@quicinc.com> <20231025135550.13162-3-quic_sibis@quicinc.com>
In-Reply-To: <20231025135550.13162-3-quic_sibis@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 20:32:19 +0300
Message-ID: <CAA8EJpoRMW95hGrDCMAjVeC5Q-xvZovEr53A2UpXLppujDTFOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: qcom-rpmh: Add regulators support for PMC8380
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
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

On Wed, 25 Oct 2023 at 16:57, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>
> Add support from RPMH regulators found in PMC8380 for SC8380XP platform.
>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>  drivers/regulator/qcom-rpmh-regulator.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

-- 
With best wishes
Dmitry
