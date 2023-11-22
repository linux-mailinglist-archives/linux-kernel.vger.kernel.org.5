Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC87F4348
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjKVKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:11:04 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1E93
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:11:01 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cc03661b70so5495207b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700647860; x=1701252660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PsCyThm4g6sI5epAQyEGxjAV4aR3jzwAzhrpvksWUpc=;
        b=Ih3Q7htXKVRZWORsl2uinMvltKr4kKGHrGrGfi1j72FbIFdKwvZlVN9M4Ns324cOGs
         o1xjKrt3Do7GDSyv7iZw7uCFt1Uqz9/8eQZgawB5Q94GPopiI4JZUJ0h5umGlNj39KbM
         8X0X6kyDwp6/BJJcjSSRgq5RILZs2oT9casio3qywwaU3RoHSYpz3nwunSCwdI9rzFPS
         1j15NivNaiGOYfogcY7fPOmdgsuxcjeY0Pe1fwodHyXGop/NRvPNuO8wlVQfMq0Uu1aX
         fAjY4xOR/y7SZfAvJVbsd3t/kIIi2oq/zIldzu/TJCBuOIhdzyjXN22B58ra7KAPspzG
         /9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647860; x=1701252660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsCyThm4g6sI5epAQyEGxjAV4aR3jzwAzhrpvksWUpc=;
        b=U7K0JfvWZuAVqcQV8x5Iyo5J36IyUx+sDkVAvqTDffk4hTM/orzuxrROtwA1aUtO/D
         FkN8XSPF5usrMnUDTi4Xsf7OovZkKyo4TumK3NsvaMhLdlsojvMzoGhEvcl5UZv7atHA
         8a8FZlszCpYkDfhA92lNR3hLP3lk9bF6j8lJqqE2aPiyfwTI5eL0JTbaRE2rSpMqb4s0
         rZPLf6geW/00oTwj01jYiyNEgiD+EyBSc+IXGjklA+wyER2szAoNMeEp+I7ggWPna3wj
         qXUiocpxNEUTqlPqwtLl3CcAGuFksl42EbjETgy/GOLcSAWwTy74KSlvJijdHu0l7R+u
         8F5Q==
X-Gm-Message-State: AOJu0YyjRY7OMaTBQHiiyXnrHzB4ycqv+GllU512O/++QVIbEXvsLe53
        o9P/rpzfXEIeKJFhEZck8w1TZb8ZA6dhYzbpDIsN4Q==
X-Google-Smtp-Source: AGHT+IEqAhkglUSA/Dn8loksX8eQaBVIwCLF6JA54T6lxkJY9gpJDdPmDPFJVBiFwwTK3wpD2FY5pWOJcJSnNjPLaN0=
X-Received: by 2002:a81:c74d:0:b0:5cb:65b8:7cdd with SMTP id
 i13-20020a81c74d000000b005cb65b87cddmr4070036ywl.1.1700647860502; Wed, 22 Nov
 2023 02:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-1-d9340d362664@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-1-d9340d362664@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 12:10:49 +0200
Message-ID: <CAA8EJpouV1EfZDz828xa9bJO=3Q5sDNWwhhC4tdCsXrTNNSSxw@mail.gmail.com>
Subject: Re: [PATCH 1/7] phy: qcom-qmp: qserdes-com: Add some more v6 register offsets
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add some missing V6 registers offsets that are needed by the new
> Snapdragon X Elite (X1E80100) platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v6.h  | 5 +++++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6.h | 1 +
>  2 files changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

--
With best wishes
Dmitry
