Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBD7F074F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjKSQFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSQFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:05:48 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E646F9;
        Sun, 19 Nov 2023 08:05:45 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-586940ee5a5so1915431eaf.0;
        Sun, 19 Nov 2023 08:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700409944; x=1701014744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeBJzVCJkIuNqsd17pLyOwOcZ+Sp47V6E23Yzb93dhc=;
        b=OVKIawKyY7tU3ZT/i4aIhnm6VArNzVPsegVXbbvX0ZU5UDxrkpWzNt0FKjKW1clqeY
         cc7hUudQCVZQT91fOF09UwX86ZZEO14G8X5xdCRHvBect3zsR5JYVg8uC28EVuJWygI6
         bD/CnOWcFqAyv0ndxrAuAneJGlbXd8pk1lIGa87CrZ+kDS4g5K3zW/9WbSbQ7uIzEPeV
         gbbim6hBlsRJKISQiyyD29Jf9hD9Iwdk+qpWomqpbL/fRXKqN3XrN71u7+hhdoaHtgko
         DQaq9l8izynfN/vWfk+Yx1cs520l2oWVi0MjXx29cLVhEgl+82yAK0hXbQVW7qFnq5P2
         HWdA==
X-Gm-Message-State: AOJu0YxrILb3bE6E6ds9GZThNqbi7AReVLaapF/2xCM5mrOX3pIkNGCa
        zMoGO4Nck2YFyEU+BuvD5w==
X-Google-Smtp-Source: AGHT+IGDy5/g5uqVytrExGghY6xmLlHEVnU/APft6O2sD3XnC7qd89vLcVO2/zgGenRKDEZ3eNDdfg==
X-Received: by 2002:a05:6820:541:b0:582:99ae:ca4c with SMTP id n1-20020a056820054100b0058299aeca4cmr6176083ooj.8.1700409944644;
        Sun, 19 Nov 2023 08:05:44 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id r15-20020a4aad0f000000b0057bb326cad4sm1071204oon.33.2023.11.19.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:05:43 -0800 (PST)
Received: (nullmailer pid 269333 invoked by uid 1000);
        Sun, 19 Nov 2023 16:05:41 -0000
Date:   Sun, 19 Nov 2023 10:05:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     JunYi Zhao <junyi.zhao@amlogic.com>, devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Message-ID: <170040994064.269288.960284011884896046.robh@kernel.org>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117125919.1696980-3-jbrunet@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 13:59:12 +0100, Jerome Brunet wrote:
> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
> 
> The previous clock bindings for these SoCs described the driver and not the
> HW itself. The clock provided was used to set the parent of the input clock
> mux among the possible parents hard-coded in the driver.
> 
> The new bindings allows to describe the actual clock inputs of the PWM in
> DT, like most bindings do, instead of relying of hard-coded data.
> 
> The new bindings make the old one deprecated.
> 
> There is enough experience on this HW to know that the PWM is exactly the
> same all the supported SoCs. There is no need for a per-SoC compatible.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

