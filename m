Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E147EEEE9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjKQJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:41:51 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD41D4F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:41:48 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so1724307276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700214107; x=1700818907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GKbU1pmqk9ezv/pS4QlNqR0Q6EVoRSle9QHrp/jGlg=;
        b=y4QPMIGMqmoYh0hy8jlA0b//M9GBQIKiSqnHJsLS6droKS2jUyxrJ42B55WMtVBkHS
         DTthVKWAAEIbnR9ty+ukquiK8GaRao5NGQ4at7ORe8VKwUDHt2pFqeZ8Zg0lrjjcpWns
         IKMzWCt856UVXZtnO4bJa0C9me/3g0f7D7YapJLG3Yw7C2vPHsrOgTpqOlMbYMqZgNCS
         j95lf4qVNQ2PsLlPLkmi6nib7aE2qKD3gsNIFPLoKPXY/4S3AC6+P31uzlGkQundE/y8
         UCiGdMP+TqkDLmYkSc7SFWH/Qko36CqHw+8X/7hqoJIu76mir0qgtovrcXXUm1ok8FDR
         O1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214107; x=1700818907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GKbU1pmqk9ezv/pS4QlNqR0Q6EVoRSle9QHrp/jGlg=;
        b=Y9dr8TJYLqQqLkXRrD6lrMmkyuuB87pPWo58bdfctZ6EJML/M9D3xXoxkrz0r63dyY
         FaOhV8oPSxMzsgRCCI68W70nQsO7VDU4NkHEhCr1W1P0xOh5gjjoTVXC4fDBPR7ZNqaY
         on3o+OlvyUPJwrri3SV8A1TrDjKnTYhkUFT7sctnD2dC4slTZw9vDQUli/MUrHlBsI10
         q7RN1W3O/eu7ZOZIQEvscltXSOZZPpAOO1vHUSbRoAd9CruDqMDMecHOjgBaeeUJ7MUZ
         zhL23hSs0ps/A8zykJyk+7+NR5v1Y1x1msV3JMPi5swDfJdqfUt5Km0hOA/AjiDlyHqh
         b3XA==
X-Gm-Message-State: AOJu0Yyac23/TiCktz7Q9QxatgB2O/P4eXzHyj76mkpY8AqmmhCGAi1h
        uUgcDp+jpD5sBY10s5ZdP5fUJsBwmBsiFgNhfjRNYA==
X-Google-Smtp-Source: AGHT+IGCP9QVnIOT2ZwFVpCIH9TdmzbEkkXBwatcoCkJWkH8/33ArI5X8qfumCKGOVK6mDD9npCZM6y3elKdW9s6bqM=
X-Received: by 2002:a05:6902:1503:b0:d9c:aa29:6180 with SMTP id
 q3-20020a056902150300b00d9caa296180mr21870680ybu.46.1700214107344; Fri, 17
 Nov 2023 01:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com> <20231117080737.606687-4-quic_rohiagar@quicinc.com>
In-Reply-To: <20231117080737.606687-4-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:41:36 +0200
Message-ID: <CAA8EJprO=W-wkwTV3x8HRHtvuDhfKXLfWj5MQJPS4cqKkngJ7g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: sdx75-idp: Enable USB3 and PHY support
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 10:07, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Enable the support for USB3 controller, QMP PHY and HS PHY
> on SDX75 IDP.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>




--
With best wishes
Dmitry
