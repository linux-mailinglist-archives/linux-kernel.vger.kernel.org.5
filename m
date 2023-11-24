Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8787F7045
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbjKXJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:44:02 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA30D71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:44:08 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cd81e76164so11221297b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819048; x=1701423848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8U6oK0q2++i/sXs1uKCpqaJWvWB9Mdi5xB6RzEIJfc=;
        b=MVNOEcM9G0eEAXPXzLCdXukXdinFnlny0Mxgjbbf1swP99lTMhtRcktFhnnIqQTzgL
         bAPySAAjZc6GyPEyUndZZAhaDszbigxus8UHFGpZ0Ov2y81xmP1b2D8K+avvXRf04JY7
         cPS+xSFnlK4u9ir37JOwGG9dcPjOprYAdrJfnpihqJfrisxcnvVxYnwepFAG1dnLDSvy
         yj+dYPC4cHOgyURMHSrn5vv7AmDQ0bc82ZhtADRXJXp2KlWO42qE7/qrWz69UTLppde1
         BhWIBrQLD3Dw3OV55qNCHTFfXY0RqWGR/ui0RaffQ+120DACblH0nzi5CYul/i8K6uED
         CV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819048; x=1701423848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8U6oK0q2++i/sXs1uKCpqaJWvWB9Mdi5xB6RzEIJfc=;
        b=OdM5/MkAZFx5H3u7bvmM6oDyWWBcOt/tBG6i3qPFKFSl7ls5avprgXUZdQdc/y7nxf
         6hidkeybRN3tnZ/mdWKBi/wfrd8eVamLf/sCHL8ud7KCvcMautE1tAFvfgWLSTtNu9bD
         z1H6pepn7RQPxHY/R/NbEIuFg6AhJk2qyrGJKDS0xvBgRRpMcaEnSdIDLHjGxdw6EuFN
         cjeactIllhcqP647bdekvk3jw/SWHPcqTsEWRm0yLS6clrCvM1wnuofecoLgL9l6ABd6
         3zjhpqiKqiBkAKg7mzgG3O3XVPdrfS6rER4TiJqj1bf2wDHtShsY422ekPsHYhi0WOPG
         3MDw==
X-Gm-Message-State: AOJu0Yz5c+cYGOUpVMQaBvFRLRbEFvW3YpT5moWSrfpPS4SBz3omsbFo
        cAVcxUYb8S6rm1AjSben4cladIFB7G0lXwGJexGi0g==
X-Google-Smtp-Source: AGHT+IGeuqMgtlqATuFeCx8iGbYWfLHMNuuqRCfht/XD+q5njaSfDP6xaMBZmj8/3Vrj0we0rCYnOvhSgUaQ0XkV8Ik=
X-Received: by 2002:a81:4981:0:b0:5a7:c8a9:79e8 with SMTP id
 w123-20020a814981000000b005a7c8a979e8mr2071750ywa.4.1700819048052; Fri, 24
 Nov 2023 01:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20231117093921.31968-1-quic_sibis@quicinc.com>
In-Reply-To: <20231117093921.31968-1-quic_sibis@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 10:43:57 +0100
Message-ID: <CACRpkdbi+H123TPe9yvGGo68o_uAxVZyiSHcJDxB7c8TSMZ-zg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] pinctrl: qcom: Introduce Pinctrl/GPIO for X1E80100
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:39=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.co=
m> wrote:

> This series adds pinctrl/gpio support for the Qualcomm X1E80100 platform,
> aka Snapdragon X Elite.
>
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC ha=
d
> the part number sc8380xp which is now updated to the new part number x1e8=
0100
> based on the new branding scheme and refers to the exact same SoC.

Patches applied!

Yours,
Linus Walleij
