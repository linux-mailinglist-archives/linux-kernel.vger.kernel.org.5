Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4845803181
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjLDL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:29:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C05A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:29:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c0e37cfafso3082975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701689344; x=1702294144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qpcl1LzmxT9f5tQeRRwg71cpVw9T4IVTGE6Uh/UwRg=;
        b=hZMmZlnqdtoiyGrpK7tyO2jAb9fhCQ6wd6JVMKH10e5fn9xikeX2emtBc/bUwU1nZs
         5arfsBnwytfNYtfRPhpnb4Kh6zhEaywM+jbmEtUwXFaWQC5+uLeotJXEbZdD6bTu5YyP
         pDMHj3j+X8m+mzMM2SA7pMoupIH+qIZhMEV0CHvYHtrg5b0UnAK4pS4jJmBwbhSZfgDt
         3Vw+9f2Ww9Vz+VyVZwVjIQMoVCt0wNvlnJBXC8poAr+cbeGdRpTr4orr5Y/xYouqHDhy
         fNFogl5F6L//DT/bvx/wSPU6w893rgTVPeTTaJfCjQTZuxvKudxqka1fNGQyqIIt/RIm
         Mwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701689344; x=1702294144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qpcl1LzmxT9f5tQeRRwg71cpVw9T4IVTGE6Uh/UwRg=;
        b=lNLW9Iy5A3GjQRab/TEjhCY90NvNfs0BIYCNu0LbCnUefsgxQY9LDHIgIs69jIh3Ey
         GetVvRURHoNp9BqqpnmZ4qT7NJlxZuk2sJCsU+VPd5XOItKkRwzbnumSzAvKfKyu8nnV
         dAL0b7yGv9WgTuPJid+LGPMWSwvi/UMXW82x+SoMzDQtqvu++FEItNLeMosq3j3ic14g
         BhWeSoyYA2VhChuNeaDPBd6ZO2d+r9qpcJWUjDMkGJNUkahgsFYAL0a2ng2eCqssVEle
         2vpdTN6hX6oXX+ECNwUi7BjyCk2tTj5YRNMLRZ6ygSoFBcGJwm3a4wiloG+mOdOk/rmF
         d3hg==
X-Gm-Message-State: AOJu0YwayMYrKSLTC3fdzhCg7oLcgo2y02asIiAVpS0mNwD14M7fZA4X
        3RIeWkkW+ADRaVFAzWv+YeG6qA==
X-Google-Smtp-Source: AGHT+IFIeHl8tQ97S00ErYokGEb3QRC/5rN0sbxkKGXJpjkxYbsKvilp4T38N4X/ri9J+zArVgE5Yw==
X-Received: by 2002:a05:600c:3ba9:b0:408:37aa:4766 with SMTP id n41-20020a05600c3ba900b0040837aa4766mr2516553wms.5.1701689344331;
        Mon, 04 Dec 2023 03:29:04 -0800 (PST)
Received: from linaro.org ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0040b3e79bad3sm14655959wmq.40.2023.12.04.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 03:29:03 -0800 (PST)
Date:   Mon, 4 Dec 2023 13:29:02 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] phy: qcom-qmp: qserdes-txrx: Add some more v6.20
 register offsets
Message-ID: <ZW23/jPxofGw9GnY@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org>
 <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-2-d9340d362664@linaro.org>
 <CAA8EJpr2HhiXEbp0QsN-qB+L4WQWiV3o2yCc-f5oqdhdKZGL9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr2HhiXEbp0QsN-qB+L4WQWiV3o2yCc-f5oqdhdKZGL9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-22 12:12:00, Dmitry Baryshkov wrote:
> On Wed, 22 Nov 2023 at 12:04, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > Add some missing v6.20 registers offsets that are needed by the new
> > Snapdragon X Elite (X1E80100) platform.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > index 5385a8b60970..7402a94d1be8 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
> > @@ -14,11 +14,14 @@
> >  #define QSERDES_V6_20_TX_LANE_MODE_3                           0x80
> >
> >  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2                   0x08
> > +#define QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2                   0x18
> >  #define QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3                   0x0c
> 
> As a side note, this should be probably 0x1c. Could you please verify
> it and send a fix?
> 

Double checked. The values are correct. So I'll just put the
SO_GAIN_RATE_2 below FO_GAIN_RATE_3.

> >  #define QSERDES_V6_20_RX_UCDR_PI_CONTROLS                      0x20
> >  #define QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3         0x34
> >  #define QSERDES_V6_20_RX_IVCM_CAL_CTRL2                                0x9c
> >  #define QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET                   0xa0
> > +#define QSERDES_V6_20_RX_DFE_1                                 0xac
> > +#define QSERDES_V6_20_RX_DFE_2                                 0xb0
> >  #define QSERDES_V6_20_RX_DFE_3                                 0xb4
> >  #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL                       0xe8
> >  #define QSERDES_V6_20_RX_GM_CAL                                        0x10c
> > @@ -41,5 +44,6 @@
> >  #define QSERDES_V6_20_RX_MODE_RATE3_B4                         0x220
> >  #define QSERDES_V6_20_RX_MODE_RATE3_B5                         0x224
> >  #define QSERDES_V6_20_RX_MODE_RATE3_B6                         0x228
> > +#define QSERDES_V6_20_RX_BKUP_CTRL1                            0x22c
> >
> >  #endif
> >
> > --
> > 2.34.1
> >
> >
> 
> 
> -- 
> With best wishes
> Dmitry
