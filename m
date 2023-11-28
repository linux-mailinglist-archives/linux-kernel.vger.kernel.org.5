Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81B7FC559
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjK1U0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1U0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:26:51 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0C19AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:26:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so74225831fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701203214; x=1701808014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e/cA2xc7eDKmbypo6Z8SLywnOUPp9h8bqqyEEbG2Ow=;
        b=F/hoZsMShCa4kqpUalbfw1ECS7gOY7sksIHg5XG6JQquJ095bDWWM1dTnt+NO5Y0M+
         CljMyLu3Z4mNaSTtQ+2HPKu8aGSiYxOmu5IO6iUaIBnjgBPaE4MIjTm1hbdb3gk0r50L
         W23OvsvzjM6TfG5QxtqDYl03qbSm5NjTCcnhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203214; x=1701808014;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e/cA2xc7eDKmbypo6Z8SLywnOUPp9h8bqqyEEbG2Ow=;
        b=eKekH5971IgRaycwhSsHN3aoIth9rcg6ppnHjXDaXPemBb7Ld0qvICaeD2BgVbOZ09
         BBSXddjXL0+xXINwIIWpLU7/igGvxYeGnOp58JTDI4Rvix+eaIE5HGLyZhKjnaUp7LMK
         RdNQVfAzTGPRlpKOMInQdl3xUB2K/FhUdSa+UEYoUKvds2YQASDFfgUQvVBr0QrriTCS
         CGLcaq6N5BwaFHBIcXd3XhosHCFc4P3NdS6/g/6jyz8o4Iy/Y5VOXAtXsGTXHwm1BMpC
         SRIO6KyBIeamjol8lbYZYDe1/+c4TLX156pcXeBxOB4nIwspuFUwgfLdiQmGFwO4rnDA
         hEAA==
X-Gm-Message-State: AOJu0Yy0kdNV2XAl53xhYDaQ7B3m5YVClMmHOwQsTeeZxSWBgVDSIjtr
        bBdiK9AW+4nfWJrHzzfnVkQpa5c+6bk6/+VC0HIU8w==
X-Google-Smtp-Source: AGHT+IHPo1Uzv9EVtilCouzElyVLqdgaW4ild4G1hYIMDOJYzDiORoqPIa0lrdy3P4ThtYYFo/T7JY6HIy/vgT0G6QA=
X-Received: by 2002:a2e:b523:0:b0:2c9:8f6b:3d9a with SMTP id
 z3-20020a2eb523000000b002c98f6b3d9amr9371511ljm.16.1701203214015; Tue, 28 Nov
 2023 12:26:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Nov 2023 12:26:53 -0800
MIME-Version: 1.0
In-Reply-To: <0ea669ad-9a33-40e0-b4df-aa2b2a1b92de@linaro.org>
References: <20231128002052.2520402-1-swboyd@chromium.org> <0ea669ad-9a33-40e0-b4df-aa2b2a1b92de@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 28 Nov 2023 12:26:53 -0800
Message-ID: <CAE-0n50My=0FZ044b2beaB2cHpC6MxYtsEKsVou=80yO2iERYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom: Fix html link
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-11-27 23:46:53)
> On 28/11/2023 01:20, Stephen Boyd wrote:
> > This link got broken by commit e790a4ce5290 ("arm: docs: Move Arm
> > documentation to Documentation/arch/") when the doc moved from arm/ to
> > arch/arm/. Fix the link so that it can continue to be followed.
> >
> > Fixes: e790a4ce5290 ("arm: docs: Move Arm documentation to Documentation/arch/")
> > Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>
> > Cc: Yanteng Si <siyanteng@loongson.cn>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> This should go via Qcom, but you did not Cc msm mailing list.
>

Ok. I was hoping to go through DT tree but am also fine sending it
through qcom.
