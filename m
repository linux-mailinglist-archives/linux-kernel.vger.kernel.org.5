Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B17F74BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKXNUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjKXNUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:20:12 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873110FE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:20:18 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db35caa1749so1697232276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700832018; x=1701436818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duwkvZHrBkTaBuc8LOMphh5Uy/87rU9msacGlhDLoFw=;
        b=LwZ1dc09aQrh9Yf2fNtFfuaYH/YIP9rA4/XT12K0+39JaMepF6sQfaUxllhH7EPRMQ
         U5uXHiM6YqyL0Ze+niVd0R8pfOVeDMhXeUHjhTraSGkFnV7foXhE1042thfu/npo7DAl
         2we+fgEHJXbCOq3zW3rf7VpFLd+WwM+3zMd9ahgf6JKeA14jAxoe2w1yw5DBbfUjWwT7
         3Gdfe6HwA4mfQRp9KwhzglzxzRBDMX6PypfjkIpQ9cH51oh8u4Mw9d4SBACUSahQ8HnC
         qPa1KC/dl7fFOzeEUcez5I/HX2dQRAT6ly1ILu9hvNIuzNi2cz4vxwu8fEVpvKWIQs8t
         yPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700832018; x=1701436818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duwkvZHrBkTaBuc8LOMphh5Uy/87rU9msacGlhDLoFw=;
        b=rCcZStryeVyqtnkmSGWYbR9Ee9T34wnsruMOFKG6UHrQFdkbGD4NqiObexj3lNePAH
         nhi8YS0POlSWsv5C7Y0j2Oz6lzE5O4Tiek50l/8cySWsFUmSKBwqhdI17Z2u6xV0rgIO
         tqOwC/MF7cAI3J+HVpP7L1PO6Z5JOAMrecJqA2jnlNDBPKEsctxfomS0NPMZzeK8fEH6
         IyOjrc7cdwDqEjS4Wm4/i5oyUabLgVUpffE529T653I/cEJmzxJ65/e8eIPgotUcf1vV
         /wDQEops2pFz8xiawjKop5NzWEODnu/gXSTjphGa4KxtG2C9Xb+MdFhi9KJdtuvko3rv
         Hrfg==
X-Gm-Message-State: AOJu0YxenAHeMxg1pmiHME8dTMxsSEmP9EnmGqejkCnp5JMY+AFMoRNs
        9rK5maf6VW5syB8kftl5rH04kd+SrXyubwMkSxeuZQ==
X-Google-Smtp-Source: AGHT+IGTMWDoubenznwguJuKisn/kdH02n6RmrB+3SpiznhGgPENvFvkg5/wCeChRLDXvMftBTinfn7BhYh8JQE6sQE=
X-Received: by 2002:a0d:ead1:0:b0:5cb:464c:ad23 with SMTP id
 t200-20020a0dead1000000b005cb464cad23mr2791623ywe.42.1700832017875; Fri, 24
 Nov 2023 05:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20231124121305.1954-1-quic_kbajaj@quicinc.com> <20231124121305.1954-4-quic_kbajaj@quicinc.com>
In-Reply-To: <20231124121305.1954-4-quic_kbajaj@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 24 Nov 2023 15:20:07 +0200
Message-ID: <CAA8EJpruXcpLX=c9o27rqHuh3u_ktqp_a+PN=DcCbq8sWW612w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add base qcs6490-rb3gen2 board dts
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naina Mehta <quic_nainmeht@quicinc.com>
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

On Fri, 24 Nov 2023 at 14:14, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:

[skipped]

> +&wifi {
> +       memory-region = <&wlan_fw_mem>;

qcom,ath11k-calibration-variant = "Thundercomm_RB3gen2"

Also please cc ath11k mailing list on your next submission.

-- 
With best wishes
Dmitry
