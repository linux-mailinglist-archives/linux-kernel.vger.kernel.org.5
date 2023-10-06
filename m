Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB27BBF25
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjJFSyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJFSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:02 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413F10E;
        Fri,  6 Oct 2023 11:52:42 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c63588b554so1570212a34.0;
        Fri, 06 Oct 2023 11:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618362; x=1697223162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnCQZZLMaYvVQmBFNRBtIb+9ksHQ8DNiyna3qi1ebDE=;
        b=vibPlvZs+KKNjZD2cofHPJNJsfuPl05djX6n1LmTMmA2v+r+w0bk/MwdSCwCn2O28+
         /i0lQfOckQW4otk5bsDTIrmaes6zuunub0PSWSe20AF3lbBml9srHMM6yQOCoMbfSPJB
         km+4QoTmSX/e8PYhCBIWPVCwUZc0H5K8iEo8WIkjU4ejroInnY3xY5NLeOWaR7U7xnTO
         BYUcweVP774plKShKXGfrStNcdmf2yL5NKqAKmW+rYngPe8Y8q83Ui/A/90303o6Sf4Z
         25aOZGZaRToRxLYxOHQr/KuZld0stE1ymn/rV1bGP+iGJLjCE+PoA+NZGuyIqye1YAPt
         GHWQ==
X-Gm-Message-State: AOJu0YwBu27LYtjwlzzGD7ufwqXgyeBIeQOL/DRfk6/19LCI+FM6Wvbj
        SiJTmUNIslrXTtPEpm3nCPcLKudAfQ==
X-Google-Smtp-Source: AGHT+IG6E4QV9zTksKhyXU6kJo0Oxau71Xh5m+hAQybK2lC+F5L7Po4YjA6MK8F8BcW8mLAKYGVt2Q==
X-Received: by 2002:a05:6830:208:b0:6b8:82ed:ea2e with SMTP id em8-20020a056830020800b006b882edea2emr9752976otb.4.1696618361805;
        Fri, 06 Oct 2023 11:52:41 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z24-20020a05683010d800b006c4e2f00135sm654140oto.28.2023.10.06.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:41 -0700 (PDT)
Received: (nullmailer pid 135620 invoked by uid 1000);
        Fri, 06 Oct 2023 18:52:40 -0000
Date:   Fri, 6 Oct 2023 13:52:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] media: dt-bindings: Add missing unevaluatedProperties on
 child node schemas
Message-ID: <169661835849.135550.16625897748454275391.robh@kernel.org>
References: <20230925212803.1976803-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925212803.1976803-1-robh@kernel.org>
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


On Mon, 25 Sep 2023 16:27:58 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml    | 1 +
>  .../devicetree/bindings/media/i2c/toshiba,tc358746.yaml         | 2 ++
>  Documentation/devicetree/bindings/media/samsung,fimc.yaml       | 1 +
>  3 files changed, 4 insertions(+)
> 

Applied, thanks!

