Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7678CFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjH2Wzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbjH2WzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:55:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9941BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:55:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58d31f142eeso57222937b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693349717; x=1693954517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2u9eHDv6zDt3qUvTnUboq/0Gycap8bgV3JrR3CLm4A=;
        b=vmCggSWYqNs33Ommfe5p2G0zTmW8QoKNPqiVCwUuehauyBoR3FuTVJPeNYN7D4VV7J
         AeYzKBmFpWZQBVExsJB70MRLPe7HciZeyUNn3TJTwe4e7ahIvKpFci9cN2X8oj4OmcKp
         MC6nbVAPsR+17qp0rz2VmkaVTdPpJvSG33cOLdZlNFcRD455UYUj1i8D6SMf9NrAlwAL
         a8VMSy72/oIoBtUF91H6OCa2OHjXFlbskSiX5hbv7bDA4vENViLKEgoXc4PUgM2abjID
         JUVfSIVWvXvlXa2miKL+ytOSRpu1OfgwrXsz9T+vBpKoFnC/9XuPMcnO5kMF5ud6zpmY
         Uisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349717; x=1693954517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2u9eHDv6zDt3qUvTnUboq/0Gycap8bgV3JrR3CLm4A=;
        b=BvaBlIy9YAeR+i5ziYai50rbxoEiTtsw89x7PkH2GxfuVBlDUjjESusyybBokOCPoK
         9g2BzUqIabmTMZErxJYikcB3wO75a0d64gp3lpUcCAOFsr9EydE4W8t294/WIWdLTD7r
         hm21116adjXttOakTyjwYmt6GLvtUb9uHtnAwgZu1K4CPIgMuv8chVZnAlbgVJnL9fMM
         6Qo8dYPWNFPA9hWuU0iYx+Fi7+RC+0eEQQLSIraI+4Fmbv7NzDAkw1H2nnCQI9G91lY0
         n+ojVq9+FUlIisXgW0T/Ht+gwbHMuOKxeBIsQuM70BuwiW3IPVb2zqTN9foa+KcpqdVQ
         81Mg==
X-Gm-Message-State: AOJu0YzLTUZEpRtIgJ+Da4MwyGddbHhdAvTB96EULyzFMo//NL2LVFkn
        P7MS+Mn+6TF2F9AtbD0mkoNnziry9oxqAVvpvjciNQ==
X-Google-Smtp-Source: AGHT+IEt0MMLud4idsEPRLw/80VIhj8FyRh7c3KwWk9LHJjlW0wSm8WxhXhKRgacxYdzVrpfoBOrSBPNWsQp/+9hN28=
X-Received: by 2002:a25:2d0a:0:b0:d0b:5b6:4629 with SMTP id
 t10-20020a252d0a000000b00d0b05b64629mr545287ybt.46.1693349717248; Tue, 29 Aug
 2023 15:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org> <20230829-topic-8550_usbphy-v1-2-599ddbfa094a@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v1-2-599ddbfa094a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 01:55:06 +0300
Message-ID: <CAA8EJprJCQo-YwwhYYE54kzbu8nsw54Qca35gq833=y5YvGtLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-combo: initialize PCS_USB registers
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 23:59, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Currently, PCS_USB registers that have their initialization data in a
> pcs_usb_tbl table are never initialized. Fix that.
>
> Fixes: fc64623637da ("phy: qcom-qmp-combo,usb: add support for separate PCS_USB region")
> Reported-by: Adrien Thierry <athierry@redhat.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
