Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9B07FDA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjK2O6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjK2O6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:58:41 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35881A3;
        Wed, 29 Nov 2023 06:58:48 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b843fea0dfso3900458b6e.3;
        Wed, 29 Nov 2023 06:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269927; x=1701874727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om8QH0PgH6JybOzR4agW39ICVCA3hclLDw5NauxCXtE=;
        b=E8fa01i4+bCx9eNPeg/8VKnLnO4NlrdbNy4FqndnldSJ69C5ZbGiEk4RoZ3SJvVQ5D
         9y3FDnpYHr+oPaYZ+O9B5uZk0B/mlprV92zZ+RSDWok8wLcwi5xQFAsgcWXfbYSlpoKG
         FxczfgNKBWEqorjRCrXSCaRl6ppYRhWcQHIs4Uq/LRatZYFV3Vu8dR19rKES9NpBmWMK
         3vaJQ4UUV4fvQDBudoOxEy5Ph+1fxCoda70LXu0u/6MBh7z8JP1GTo0DvA/J5f1vswfG
         KGbPuDqMkx63QlZWgrfcD6weFC3/S9p/OG59HqfzExYU3cVDbJeKg3O6bPwMdcDYDGtr
         Eawg==
X-Gm-Message-State: AOJu0Yyi7VczYE8oAVKDnrlR74j0HhhpGtpoIupgfa0AYak7x+LKq9Gn
        7POZG+FAHTJzAFOwwBFZaQ==
X-Google-Smtp-Source: AGHT+IFaDKlAMO0TTBe2DgTuEmwhSM1mq/2uExerm3hYow5K6ag6Zf/td6nyVFVGAKaudl9+l3aL7g==
X-Received: by 2002:a05:6808:34c:b0:3a7:1e86:e83f with SMTP id j12-20020a056808034c00b003a71e86e83fmr19018621oie.51.1701269927374;
        Wed, 29 Nov 2023 06:58:47 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m23-20020a056808025700b003b29c2f50f0sm2248202oie.18.2023.11.29.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:58:46 -0800 (PST)
Received: (nullmailer pid 2464542 invoked by uid 1000);
        Wed, 29 Nov 2023 14:58:45 -0000
Date:   Wed, 29 Nov 2023 08:58:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: qcom,msm-uartdm: Vote for
 shared resources
Message-ID: <20231129145845.GA2459716-robh@kernel.org>
References: <20231128-serial-msm-dvfs-v1-0-4f290d20a4be@kernkonzept.com>
 <20231128-serial-msm-dvfs-v1-1-4f290d20a4be@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-serial-msm-dvfs-v1-1-4f290d20a4be@kernkonzept.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:43:32AM +0100, Stephan Gerhold wrote:
> Document power-domains, operating-points-v2 and interconnects to allow
> making performance state votes for certain clock frequencies of the UART
> DM controller. The interconnect path to DRAM is needed when UART DM is
> used together with a DMA engine.
> 
> Voting for these shared resources is necessary to guarantee performance
> with power management enabled. Otherwise these resources might run at
> minimal performance state which is not sufficient for certain UART
> baud rates.

I find the subject a bit strange because voting is a QCom term/concept 
and somewhat outside the scope of the binding. The justification is 
really just that the h/w has these resources. In any case,

Reviewed-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  .../devicetree/bindings/serial/qcom,msm-uartdm.yaml         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
