Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5B7879EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbjHXVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbjHXVJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:09:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378091BCC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:09:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d749f57cb22so285649276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692911389; x=1693516189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtCHx9zPK6zwMY5vtPWIoAhjTmD5KaknZKp2N1NqgXQ=;
        b=j6uo3nuGKtquPq4iURD0rcp8CgfxySjKSEkM8iYkJUVrC0iyBBDFFJPkbupl858r6n
         Q40w9julvt1TsVhZnrdTOvDQf1pBE+i2RYORPSKhx147r2Wc+xXU51IdWa18CMMSVmic
         QvbGcuyyZLWylaCSBQkbr8AHLIXteARg3SzhNstBuRnnNIrzv4tDJJiyG02lymQjPYxz
         B9O+YDZwZcXOrsH5SXh7QyeFaosU8RQjbhryouOOT1lbQHj2hjqLo27f7X3PbR/DWoOQ
         S4K8HPxFCDRRnj8KjztBqo152Ob/0XODa/wj5hTNEXOlL/5+423orFHr1/qD7KxQZz4U
         9XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692911389; x=1693516189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtCHx9zPK6zwMY5vtPWIoAhjTmD5KaknZKp2N1NqgXQ=;
        b=MKUAGOIKOS37JOOmYWh9ytENEwDLaeQkSX5fJokR9KWGlT80MxDLXdoA+ldeXAdftD
         ebQum8TAiOc5qIrsAhjG/21EMwDbp+IfnGlzsMhRee/kC8/FH+GyNFKIkTM5DkRbY5Xr
         ChItbY40+EnOWqOI9FpBs8uMkt6rhaR+GkCs+76KKU/Fr7/0U0hV9ksl+y8NzaEd2Jy4
         DuA/lB1ne+2wK4Kktj3QBcB0G+td7pwmfPXHuTGfCQReFBpw671/w4qhamB1Z7QCz+7E
         zGm5a+C4sPRskXuBuejNF7Kb9Oud5WShV4Py7HajeNVuRrfOP2Y6gj4ffyHe0T0JevNS
         cJUw==
X-Gm-Message-State: AOJu0YzhK57HQcqrTAnxStlFai9WCx0BkmRs27mG+SQggFmZPgitYDwR
        93yZ7Y4VjZv4XmUvsyMLiBqtlTucT9xCale1lKfKpg==
X-Google-Smtp-Source: AGHT+IFBNwfXc6Q8dKOfaF3XdMl1uH14PrH7g2ybyyi+xAuTtdq/sQ4I/312AzDtI1jht7dE4Ls5XvUL9uwo3s3T/XM=
X-Received: by 2002:a5b:b4a:0:b0:d06:2494:ef77 with SMTP id
 b10-20020a5b0b4a000000b00d062494ef77mr17451876ybr.16.1692911389466; Thu, 24
 Aug 2023 14:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230824173410.550126-1-quic_ajipan@quicinc.com> <20230824173410.550126-3-quic_ajipan@quicinc.com>
In-Reply-To: <20230824173410.550126-3-quic_ajipan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 25 Aug 2023 00:09:38 +0300
Message-ID: <CAA8EJpr4yUL9QAhiPLdTX3sO7nxK4ispN=cS7WXRcCEkcmUx7A@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: qcom: rpmh: Add RPMH clocks support for SM4450
To:     Ajit Pandey <quic_ajipan@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 24 Aug 2023 at 20:35, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> Add support for RPMH clocks for SM4450 platform.
>
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
