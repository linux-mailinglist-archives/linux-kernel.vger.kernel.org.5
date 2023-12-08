Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5480A8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574083AbjLHQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574071AbjLHQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:31:24 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5110D8;
        Fri,  8 Dec 2023 08:31:31 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9e993d94dso536178a34.0;
        Fri, 08 Dec 2023 08:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053091; x=1702657891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0dh91LsH3FMgzR6j6ESovfFZbs4+hPOeOOy5RhBvXI=;
        b=uifQLQdRIWRj2V2SodGq396PmvjaqsOPuIsdTAIrv3LljJwqMhs3e55Yp179zhePmU
         P8E5DRoB4hgo1DAZ9Odfe/xWs001hAN4ceS9mnPH56UiIp8/o41RaoQR4a68K5KUdcCM
         1jfbcJvOrYU+bnfpIY0CNII2lQFDKn592z420VdP9QYsy2WplCDsdPXu80Fma/wCMU6p
         mhyfpfdEYkzlVZwgj1G4Gjb/nEFUNnZOT68g9+HgGxBhK8KJQozNzIgNRvBZXwTGrGgQ
         Z94n3mmumsbpeJm+YNDlbAX2QxTVBi0AMjOGQdP0gKCO6AVEVj2m8VZGJ1kb1sEWTATA
         /ObQ==
X-Gm-Message-State: AOJu0YzwMOyh/DY7ztPMZcMJOGDF/dmXJ0e/mdTAfMgZKaY77l7z0UcS
        JrK7R0PvDslgIC3WY8I+2w==
X-Google-Smtp-Source: AGHT+IHDm3wqp2WeSg6dUcKIT7qXKxWAFG2zul4H7tfMEgrUVi5XlJJQvhg6VUWNouCkEz0LkhH29A==
X-Received: by 2002:a05:6870:700a:b0:1ea:c913:3494 with SMTP id u10-20020a056870700a00b001eac9133494mr394403oae.6.1702053090816;
        Fri, 08 Dec 2023 08:31:30 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pv21-20020a0568709d9500b001fb4dcb74ebsm455362oab.54.2023.12.08.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:31:30 -0800 (PST)
Received: (nullmailer pid 1679055 invoked by uid 1000);
        Fri, 08 Dec 2023 16:31:29 -0000
Date:   Fri, 8 Dec 2023 10:31:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keith Zhao <keith.zhao@starfivetech.com>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, william.qiu@starfivetech.com,
        xingyu.wu@starfivetech.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com, p.zabel@pengutronix.de,
        shengyang.chen@starfivetech.com, jack.zhu@starfivetech.com,
        changhuang.liang@starfivetech.com,
        maarten.lankhorst@linux.intel.com, suijingfeng@loongson.cn
Subject: Re: [v3 1/6] dt-bindings: display: Add yamls for JH7110 display
 system
Message-ID: <20231208163128.GA1659919-robh@kernel.org>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-2-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204123315.28456-2-keith.zhao@starfivetech.com>
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

On Mon, Dec 04, 2023 at 08:33:10PM +0800, Keith Zhao wrote:
> StarFive SoCs JH7110 display system:
> dc controller, hdmi controller,
> encoder, vout syscon.

What are yamls?

I prefer not using 'yaml' as yaml is lots of things that are not DT 
schema.

Rob
