Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF87D750C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJYUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:01:33 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28846129;
        Wed, 25 Oct 2023 13:01:31 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so53221b6e.3;
        Wed, 25 Oct 2023 13:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264090; x=1698868890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtCIrzQdKJKpdZUt5PfKXCO1t0V+axutt8PwHegZEgo=;
        b=gzhNN3tENUzqPQf2fRCpWdPsZ33QVMmB52pZ7JZ/AAyeznjtpd/2tmc6DvtHgW0nEt
         jC3bWEhBdUZKk79YO20oYi1euLcQ29sVxK/9tkQniyz613vj/3cCenYoJ1C+tJtWA7yI
         XDlkYvkWs3zZO17sZRj0u3IzCsByRQJeE3pKPXMkN12MQc7cZQR2KH4hIU6W/+ShHEeJ
         iO41Ell8b8nHAMcVRjp+Ap5tfEpeo13QIUBwOopVccrKqwg+Zh7nkUdXxxyl1lmkbJgB
         A8LwmJQD5BktxedoCdR4ulCI/kO7jPnSk6ohthUVAT9QMECVW7GtJa7S27YoEpd1m7sn
         tCyw==
X-Gm-Message-State: AOJu0YyrKMcvBdMTPBDV/jbTg/R38LehxoP6NKhaN5cLj51bu/qsGyrA
        oh/qdVsGmhxqQqVv3qrgMg==
X-Google-Smtp-Source: AGHT+IELNsn2Chz8fXxLtmRsO/2l9N3y9d0dHei8xC6gf26APrHK7LAuncZMip0aOeqqbDd6rVicAw==
X-Received: by 2002:a05:6870:c07:b0:1e9:c59b:a9ad with SMTP id le7-20020a0568700c0700b001e9c59ba9admr20117756oab.52.1698264089869;
        Wed, 25 Oct 2023 13:01:29 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id mo11-20020a056871320b00b001ea689d8969sm2713388oac.48.2023.10.25.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:01:29 -0700 (PDT)
Received: (nullmailer pid 1067101 invoked by uid 1000);
        Wed, 25 Oct 2023 20:01:28 -0000
Date:   Wed, 25 Oct 2023 15:01:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, stwiss.opensource@diasemi.com,
        skhan@linuxfoundation.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-watchdog@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: da9062-wdt: convert txt to yaml
Message-ID: <169826372027.1056631.8936616422863313473.robh@kernel.org>
References: <20231014170434.159310-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014170434.159310-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Oct 2023 19:04:34 +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add a mainterner block. Took a value from dlg,da9063 PMIC.
> 
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> ---
> 
> Changes in v3
> - Changed type of dlg,wdt-sd property from boolean to uint32. Following the discussed in v2 patch thread.
> 
> v2 patch: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231010211439.98458-1-n2h9z4@gmail.com/
> 
> 
>  .../bindings/watchdog/da9062-wdt.txt          | 34 -------------
>  .../watchdog/dlg,da9062-watchdog.yaml         | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
> 

It seems watchdog bindings aren't getting applied, so I've applied it.
Wim, please take watchdog bindings in the future unless noted otherwise.

Rob
