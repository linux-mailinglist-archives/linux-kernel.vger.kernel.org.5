Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C362E803218
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjLDMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjLDMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:02:29 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA81727
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:00:34 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db549f869a3so2743279276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701691218; x=1702296018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxQa10ALTFJrtePQUNooIdnJ7/2/V51IMg2dt+kkdtw=;
        b=brI0cGXIL63tH86anAjLts3RtkeNWs23+psHbkch+iAUeoPRN1bkKeugZU4nZTvA+i
         6KNyziCuukcJnB+yIAyYmzdgEEVTcZYvO5fL5XxkXgOgK+5vPB+8DlmPE/BxiQRGo6js
         7f5/6oxEXbz7SlKWX6z9XgylrQk5DLjUqkz/qhDoCPe03n9fNo8FmASKlWEHpOiY32V9
         37PZFxK1SThouTOdcYC8c5nvVAMhflN0IaVyCut9m8qI+oBRsrOGPDZwAweljv7O4bvB
         mlvHNn4H5ZWa20tPHObkF5ngSLIAxkP2DfnQvDEExDB/ixQnzVeEe0cucuM0YubKroYQ
         urKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691218; x=1702296018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxQa10ALTFJrtePQUNooIdnJ7/2/V51IMg2dt+kkdtw=;
        b=WchLLCq4ppvex/CdbM2u7stMdAk6ExeBfunxQYXocCKj08kWQEcKGnpReH1HPYfEg9
         tSEsRb9tu/QGZu1V72Mt6XsRw9DLcLoEpZ7vgMHRetUf14/iFILjCfhhayr8Z71bNxIB
         CIvKa4MWlWnpwiZU7TxzJj7HYgMQVWhlVeR9K7G5tzuFXgq0z+jxxHmtf/nihfqtUKT3
         eUugb9Z0AlT1Jyn5Wwb/eNI5p302MlQibxS7knp3jwXr1JKYMVj6E/lslW1TdMp+/y6M
         3bRTRhm58X6uxt+9K1EvidCDhIolQcP1fcA/DvFVHAudcA52Isi7FHszZnC7NC/XLUcO
         SY9w==
X-Gm-Message-State: AOJu0YzVTMV1cv0gOIU+thxIoQ6v2A9gRcYjerOrvqUAElhc0Qb37mGl
        2iD1q5vIp7BCsBZnzBR79F9CTzT0+s7MusYv/8lDfw==
X-Google-Smtp-Source: AGHT+IGtx7FZUsk81dL3/t2g6cd3rE+aZFVev88VqUsqsQ+gPdRNsR1xz4Vo1+2JrRUIQSocaOyRYdJiyBQUguClOwM=
X-Received: by 2002:a05:690c:dd0:b0:5d7:1941:aa1 with SMTP id
 db16-20020a05690c0dd000b005d719410aa1mr2935063ywb.60.1701691218139; Mon, 04
 Dec 2023 04:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
 <CAA8EJpr2HhiXEbp0QsN-qB+L4WQWiV3o2yCc-f5oqdhdKZGL9A@mail.gmail.com> <ZW23/jPxofGw9GnY@linaro.org>
In-Reply-To: <ZW23/jPxofGw9GnY@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 14:00:07 +0200
Message-ID: <CAA8EJponcVngT5X3+C1nuCd+fX4xMUFYdGoxT+Mdit+BpjEG=w@mail.gmail.com>
Subject: Re: [PATCH 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 13:29, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 23-11-22 12:12:00, Dmitry Baryshkov wrote:
> > On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Add some missing v6.20 registers offsets that are needed by the new
> > > Snapdragon X Elite (X1E80100) platform.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > > index 5385a8b60970..7402a94d1be8 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > > @@ -14,11 +14,14 @@
> > >  #define QSERDES_V6_20_TX_LANE_MODE_3                           0x80
> > >
> > >  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2                   0x08
> > > +#define QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2                   0x18
> > >  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3                   0x0c
> >
> > As a side note, this should be probably 0x1c. Could you please verify
> > it and send a fix?
> >
>
> Double checked. The values are correct. So I'll just put the
> SO_GAIN_RATE_2 below FO_GAIN_RATE_3.

SGTM

>
> > >  #define QSERDES_V6_20_RX_UCDR_PI_CONTROLS                      0x20
> > >  #define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3         0x34
> > >  #define QSERDES_V6_20_RX_IVCM_CAL_CTRL2                                0x9c
> > >  #define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET                   0xa0
> > > +#define QSERDES_V6_20_RX_DFE_1                                 0xac
> > > +#define QSERDES_V6_20_RX_DFE_2                                 0xb0
> > >  #define QSERDES_V6_20_RX_DFE_3                                 0xb4
> > >  #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL                       0xe8
> > >  #define QSERDES_V6_20_RX_GM_CAL                                        0x10c
> > > @@ -41,5 +44,6 @@
> > >  #define QSERDES_V6_20_RX_MODE_RATE3_B4                         0x220
> > >  #define QSERDES_V6_20_RX_MODE_RATE3_B5                         0x224
> > >  #define QSERDES_V6_20_RX_MODE_RATE3_B6                         0x228
> > > +#define QSERDES_V6_20_RX_BKUP_CTRL1                            0x22c
> > >
> > >  #endif
> > >
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
