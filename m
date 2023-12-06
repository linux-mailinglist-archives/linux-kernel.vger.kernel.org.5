Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5210807108
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378602AbjLFNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378587AbjLFNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:42:40 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707AAC7;
        Wed,  6 Dec 2023 05:42:47 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b8958b32a2so4220841b6e.2;
        Wed, 06 Dec 2023 05:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870166; x=1702474966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLzpQ4fOC8RLmPkow4CQkCwl/Mdnw93sW11GlybnYgs=;
        b=ZH4AezgBVO9Cg+oP++6voEmQ5G67m7jKi7sUbRFbAf/BJABErhbodQYu0LOGidapUX
         wNP2/FdaP+/muzCAdhzMADkjOH006IbE+dGDpMp8y7gkFaygUc4Le1P4xx86beqY3hz3
         Q75pSVKPtsrxlKEjNn3bvd0aKe03yVUpOE5V7hfVtzfCctWNdU3l2+f64mTDdzcEeS0Z
         ESwrmqveYKrZUVOnCpXQk6TBAGobJuxHLHsxS/bHU708tUAn0/7DNliIymdGeULpmPRO
         duB0jTysqO2WoXdZY0+5BDKTs1zil8fqAgT/JzJdLLtQQ0fAnrjLMAluUakOHHhb7v3k
         Yniw==
X-Gm-Message-State: AOJu0YykRCxkFm5NdaH/KI10B9fGtXhzYQRg5+E21MkXpao05P5EUyd5
        bhouG0UO6OU9l1Bk6sPotQ==
X-Google-Smtp-Source: AGHT+IE7PnaaolCnZdgfvQMGg6RBkpYWak6PaCEiL9P2gMCYQYxnLE6AEQWyIP3OQXfLn3puL5Lwpw==
X-Received: by 2002:a05:6808:1410:b0:3b8:63aa:826f with SMTP id w16-20020a056808141000b003b863aa826fmr1470443oiv.25.1701870166732;
        Wed, 06 Dec 2023 05:42:46 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o27-20020a05680803db00b003b8388ffaffsm2544248oie.41.2023.12.06.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:42:46 -0800 (PST)
Received: (nullmailer pid 1999706 invoked by uid 1000);
        Wed, 06 Dec 2023 13:42:45 -0000
Date:   Wed, 6 Dec 2023 07:42:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Allow
 #power-domain-cells
Message-ID: <170187016332.1999400.6374393677018050947.robh@kernel.org>
References: <20231129-topic-mpmbindingspd-v2-1-acbe909ceee1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-topic-mpmbindingspd-v2-1-acbe909ceee1@linaro.org>
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


On Wed, 29 Nov 2023 20:12:31 +0100, Konrad Dybcio wrote:
> MPM provides a single genpd. Allow #power-domain-cells = <0>.
> 
> Fixes: 54fc9851c0e0 ("dt-bindings: interrupt-controller: Add Qualcomm MPM support")
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes since v1:
> - Add this property to the example
> - Pick up tags
> 
> Link to v1: https://lore.kernel.org/linux-arm-msm/20230308011705.291337-1-konrad.dybcio@linaro.org/#t
> 
> Marc/Krzysztof, can we still pick this up for 6.7?
> It's been stale for quite a while..
> ---
>  Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!

