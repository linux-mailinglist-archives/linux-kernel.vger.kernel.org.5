Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80C80167A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441837AbjLAWgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441889AbjLAWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:35:43 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31512A;
        Fri,  1 Dec 2023 14:35:50 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b83fc26e4cso685716b6e.2;
        Fri, 01 Dec 2023 14:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470149; x=1702074949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGJasswkYdLHXOGy4+u7HLtGB7BHJzBO85hkhTW3CI8=;
        b=uUUAHPQpzd72gmKwGGB66rYxIA0lC8Cgd9oCDiCAHB/4ARpoUswJ3uTnEP3Ijh3oWc
         2xOM1UngNyjA8Bfq1+wuMYmdnUehYsOqGlQLvYDPwT4h9FA6xvMqXk98rUO3fAqKcKoR
         Km6BXPzUQaPKNc1bhuyvGrk+V5Tc5r/ViweSA//mtr7TgOo7wBGnK0+isR0WqFDkih83
         aXsJ/ceenhrHCWMrhh1o0NxmC6Q5fV2Mm7X8eD11BANIwDSI1oXyqOLvYK9MjlFd9EKo
         7MzWYo2svueBKnytGyiaBRvWb3o2cjbo8WZuN3Fyv2QWaujTVw1R+di50DniR0gvbEht
         z5MQ==
X-Gm-Message-State: AOJu0YwL2syo3DLcsdqXO4BGwPLloMuD+Q60lcYR/6Q6LXIyBr9WbTkb
        3Dg5qsg8nQggVmHjrTrzrA==
X-Google-Smtp-Source: AGHT+IGbdVZ9bp4Z5dQmi9MZinY+gldCiCs2w/YbnUTBcNdYwZH+IDEP4Ai4qUVO/zvCFjJX2lS4MA==
X-Received: by 2002:a05:6808:1a81:b0:3b8:a591:73e3 with SMTP id bm1-20020a0568081a8100b003b8a59173e3mr234485oib.42.1701470149476;
        Fri, 01 Dec 2023 14:35:49 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fa16-20020a0568082a5000b003b89a0f70f9sm704002oib.19.2023.12.01.14.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:35:48 -0800 (PST)
Received: (nullmailer pid 2616442 invoked by uid 1000);
        Fri, 01 Dec 2023 22:35:47 -0000
Date:   Fri, 1 Dec 2023 16:35:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
Message-ID: <20231201223547.GA2615359-robh@kernel.org>
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:10:41PM +0100, Krzysztof Kozlowski wrote:
> The dtschema treats now properties with '-pascal' suffix as standard one
> and already defines $ref for them, thus the $ref should be dropped from
> the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> dtschema change was merged:
> https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4ec46304d6d6cc655c3e635
> but not yet released as new dtschema version.
> 
> This change should be applied once new dtschema version is released or
> Rob says otherwise.

I've made a release, so go ahead and apply this.

Acked-by: Rob Herring <robh@kernel.org>
