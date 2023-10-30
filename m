Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B767DBCDB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJ3Ppx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjJ3Ppv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:45:51 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFBD9;
        Mon, 30 Oct 2023 08:45:46 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-581de3e691dso2688054eaf.3;
        Mon, 30 Oct 2023 08:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680746; x=1699285546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N68YKwFVNkchwKNnXPKqL9DNOsP+ZPGa6gPr6ZEexZw=;
        b=WwypaZROYi0b5hPJcnRPxBV/Sm9hdMHh+KXk/iyflIIpbVIFnRwlwbsHU1dF/0uHMk
         cVGEjlQ3zNro8bLq/xaQGPa2VTc0PvJ+o7ZDy03mSK29p5JDjMz60VBljK/9MO3K3bm+
         MZ73fYaWNHihyp/rkydpsoyUvAUK9/rUKybc7OzUs1IeME0s39I72z7KcgWBy63BidHa
         DVoDZVoTOihcD5PdI4wMO7ylMzDjqwWHvnnEnD1eBVqm4pqmvTWAjwPYlE1+e0oyBdbs
         Tt5wi4lrDrHqrNKA5qc0W7DTxPGJeiWmCsYIElqtpoS7glSH49eKlHObzYyN5rnhfUFU
         JtJA==
X-Gm-Message-State: AOJu0Yy/e2CyDikIr5Y6eHwC/jl2bduOO76KghSikh2C3h2UbF/LeMlB
        30AotDys4Amzj6u3VGwqjGCyDAvONA==
X-Google-Smtp-Source: AGHT+IFFYAiiDeIL0wT9nmQI6GlHDM300JrKXV+TNAOEvtdhBG4R8qjLrNRZ3gYgCUml9QgWCANqnQ==
X-Received: by 2002:a4a:e28a:0:b0:581:ed9a:4fde with SMTP id k10-20020a4ae28a000000b00581ed9a4fdemr10139189oot.1.1698680746210;
        Mon, 30 Oct 2023 08:45:46 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id x4-20020a4aaf44000000b005658aed310bsm1767770oon.15.2023.10.30.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:45:45 -0700 (PDT)
Received: (nullmailer pid 1235360 invoked by uid 1000);
        Mon, 30 Oct 2023 15:45:44 -0000
Date:   Mon, 30 Oct 2023 10:45:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/5] regulator: dt-bindings: Allow system-critical
 marking for fixed-regulator
Message-ID: <169868074320.1235121.1883656522511039021.robh@kernel.org>
References: <20231026144824.4065145-1-o.rempel@pengutronix.de>
 <20231026144824.4065145-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026144824.4065145-4-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2023 16:48:22 +0200, Oleksij Rempel wrote:
> In certain projects, the main system regulator, composed of simple
> components including an under-voltage detector and capacitors, can be
> aptly described as a fixed regulator in the device tree. To cater to
> such use cases, this patch extends the fixed regulator binding to
> support the 'system-critical-regulator' property. This property
> signifies that the fixed-regulator is vital for system stability.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/regulator/fixed-regulator.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

