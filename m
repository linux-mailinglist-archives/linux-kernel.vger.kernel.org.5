Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808C7EEF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345788AbjKQJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjKQJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:47:20 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD9835B5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:44:12 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5ac376d311aso19352017b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700214251; x=1700819051; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJJ5ScMsDcQgAdEUE/qgp1NsHcLxH6RM2U6e9L4V7DE=;
        b=ug+Q1LnVZ+cZa0gknR0QOpbNHCyYNe7mWC1897/nbkCisd2W8bFz1Vp2ZeGglrIohv
         jXXX6BNSj7eKDujAmcMZL4HT1tF+xWrH85cSfB6gQ+No/Yg+TCuVz41G2IF7b3s+hhcS
         Ta7ThiDublARmrIAiAw3ch9gy81FpPVvglq8ETuMOwUCLZvj4Ho1BOEEW2uDdXgndUxJ
         99jWaTi0+4lT4Gd08kCzY0EVJQeJyIDfttrbcG5Oo3OJhS259+ExWY2bVrH2ndoSBItC
         R27pVT153T0ZFFDkFs7KoD6VRKASDEEI5FxXoUYIWVj5YsPk4g73kdspw0/8MMtSLZpt
         uXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700214251; x=1700819051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJJ5ScMsDcQgAdEUE/qgp1NsHcLxH6RM2U6e9L4V7DE=;
        b=lKVNBAn/KN1nhXJyEshtwpaRjNXRQLPvUVAi2Z5wCMv0RibCHaqUh1r4Kh9v9RQQgg
         9NzPdxnAPFpv1GaKoabgnss9SrTFvsMj1LwTMgkFeDGkuj+zhsBHZU4nfV3Qu9/hS71o
         F/eY/j6pj4OIA7E13zxVCeUVo58yE7xH2iJWJ5fNbTEKTx6PJSULAD+2Baa7RX4NNVPS
         gLTaYhZJ6NuvmiZwVw9fS5wMcKoUKn3OmveOwXRczSGEq21TO4HH4R+72TlqcZz+fKTA
         rGiji7g37pu15ypGqoWEFnMHfwwcqJwYaYuOPV6dkjsmcCsSmu3Tc9OKlp/wNHv2wS+y
         jCug==
X-Gm-Message-State: AOJu0YxNvcz6quWkj/pIQt9gufxu8aU7F2SLLoOxaDx+wTmwcEImaUTp
        SWRAl1MDCMyP+UuRH5cDhN8EmVzRx6pV/MZdlCyusw==
X-Google-Smtp-Source: AGHT+IFUNpTmKSRr3Ltfd7PV89xQ+VNo2TeLFWGiJMKGFczxIeg5nFKWILVTxQR5+WRdwuuKxlAQDTVgd++EucffyKc=
X-Received: by 2002:a0d:f347:0:b0:5a7:d997:cc7b with SMTP id
 c68-20020a0df347000000b005a7d997cc7bmr20438268ywf.23.1700214251291; Fri, 17
 Nov 2023 01:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com> <20231117080737.606687-3-quic_rohiagar@quicinc.com>
In-Reply-To: <20231117080737.606687-3-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:44:00 +0200
Message-ID: <CAA8EJpp0ZLUMpvbDDczfagWsgZyHR_bBOZvK-kAA0NKg1JVMTw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: Add USB3 and PHY support on SDX75
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

On Fri, 17 Nov 2023 at 10:08, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> HS PHY on SDX75.
>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 118 ++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
