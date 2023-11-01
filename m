Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82377DE33E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjKAPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjKAPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:24:51 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0D10F;
        Wed,  1 Nov 2023 08:24:48 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3add37de892so3544087b6e.1;
        Wed, 01 Nov 2023 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852288; x=1699457088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZK+aPtB2ShxNmmgyWDDoyiKDIyKkBTaaDzubNkBmA4=;
        b=JZGYVckG3B5GUnIGraYE1+L35oiFyTvoEwZBYa7VBMP669+mGvHDbIt3LhntWYlvZT
         EaE2Ffz7/1QUyoEUn9mXxOG84m+a1q5mciT/fpOPmJ0j8ilpjU0gPwEt6fxwFGfr/9bb
         bPL2TgdSQAZ8Ui2s4MA98+kFsOb7VBALJ9Jy9DTnZvE6lC5RprXW4Iml1IyBTnifZfdI
         O7HdZ6CtubnEOFq1SqNCjNLX0+0G+oPyIfqLM3ZI9uSIUFe8HolNCXPMT7FGU+PsuYbZ
         Mjjd0m0iOys5eimwfxnQnzHciszKzATWF0FQ6+ZFpxQVVik4pj+5TLCwgdcKhUZjvVJ4
         lf9w==
X-Gm-Message-State: AOJu0YzSQR+c2iiz4n4bKA/QXTSjl++8m9s5J0L5c0IrKbKT7+2ptIUx
        m5pxkn4Q4o1i5i1U+3vkIA==
X-Google-Smtp-Source: AGHT+IH8w3z0r/si0urHr1WhtjUbI6x8y1IzUM3+AoC5nRFvnQm5K5Dp7Pv57kb7o3a7czy3Zgb+xw==
X-Received: by 2002:a05:6870:59f:b0:1e9:8e4f:30dd with SMTP id m31-20020a056870059f00b001e98e4f30ddmr17014778oap.6.1698852287916;
        Wed, 01 Nov 2023 08:24:47 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id od37-20020a05687176e500b001db36673d92sm267318oac.41.2023.11.01.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:24:47 -0700 (PDT)
Received: (nullmailer pid 314135 invoked by uid 1000);
        Wed, 01 Nov 2023 15:24:46 -0000
Date:   Wed, 1 Nov 2023 10:24:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: $ref reboot-mode in
 syscon-reboot-mode
Message-ID: <169885228581.314078.734374815542634865.robh@kernel.org>
References: <20231031-ref-reboot-mode-v1-1-18dde4faf7e8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-ref-reboot-mode-v1-1-18dde4faf7e8@quicinc.com>
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


On Tue, 31 Oct 2023 11:27:00 -0700, Elliot Berman wrote:
> syscon-reboot-mode.yaml should $ref: reboot-mode.yaml, but instead
> rewrites the properties. Update so it $refs instead.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

