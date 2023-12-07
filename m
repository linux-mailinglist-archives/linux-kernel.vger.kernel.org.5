Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042458087A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379234AbjLGMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:23:19 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA22B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:23:25 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cd81e76164so6538657b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701951804; x=1702556604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsow7R42bQ9UqU+3gHiABlqbyNHgme2JlA6feobUee8=;
        b=X6R1feD3NmBl6hch0z/pumU3NF6YLeGO5SzKZO4oA1h2vkUtL3KTaugyjWbxy0VmoB
         l2mz/ZOcFnpRAXezNodmw4z7nEeMOBVLb5vGR+ps1LDS1Yo99ChfLOgrK1bEzhxRXXC/
         E+seKQoedMToKtTgcF//xdJbbtxF93vJBaF4sHoh0X5gnsBjMTVpy3T4L+AubHv5dLIG
         ngkf/zx35oVNomz+fowGLmhnIlJfuPAa/p0iDPOoTIn9suJI/Mdbu1jJ3ReB3i7Cs/xl
         v9KBe0HFxIkBF2NwO83EbuSwuejwR+VWXyI4xVuA7olrTyW5+lLxwi9GvkTVhchF360C
         +7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951804; x=1702556604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zsow7R42bQ9UqU+3gHiABlqbyNHgme2JlA6feobUee8=;
        b=BoYz1OnEZPzVfsGWTF9HAz0oyq+RcvluNMzmNhALQhYB7WYP98Yx8H0mLnIU8/7XXw
         gASCIUQfClwPfdvim5UxmwfAhkbSHm0ggq8W3yYg48Tt1lZpBgseYtwUAWJBs0YzS7VR
         AS1H6EqbyrnPzlkeBKIAiBa2awZhyml+XGBO+xuMIkc1j7Gea3ZUbEcbQCYrFviSmfCQ
         jAvAaxW/ACow5CHm6DYTQR9z5b+j0HUCRiMuSgDlqqXLsmPTDcmjowgvlhdVV/6Kbgg2
         Xg+uLe65XobsZLcTyolFZMpwK8yu4BdikYgjO9cFX1+aHByXQOjF9lJ5qZGmCX3Beeb3
         8X4A==
X-Gm-Message-State: AOJu0YxbxzDBd9DQlQEPaiQ325SLm1eMMir1ddvcrs0U4fW25e/Y4D/X
        3COGZpck2cevG9lU3OC2+yYOobHoBTSOcPn9mCLqHA==
X-Google-Smtp-Source: AGHT+IFNoH29WEDXVoVkuFnOOvxiZfSITNbl6Pf075Eno11hrzpebhkcZjVIB++Oz8CQvurJ4Q/6cJw2CGk8SNkd9P4=
X-Received: by 2002:a81:ad19:0:b0:5d7:1940:dd60 with SMTP id
 l25-20020a81ad19000000b005d71940dd60mr2152488ywh.54.1701951804590; Thu, 07
 Dec 2023 04:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-0-dfd1c375ef61@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-4-dfd1c375ef61@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v3-4-dfd1c375ef61@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 14:23:13 +0200
Message-ID: <CAA8EJprJzmBKDkmnViD5o8z=SXS4Y873hTSe6NJGKwoEdG7X4A@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 14:19, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The X1E80100 platform bumps the HW version of QMP phy to v7 for USB.
> Add the new PCS USB specific offsets in a dedicated header file.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
