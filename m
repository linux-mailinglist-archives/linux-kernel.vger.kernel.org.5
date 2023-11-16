Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47D7EE784
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbjKPTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKPTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:32:33 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB331A8;
        Thu, 16 Nov 2023 11:32:27 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b6d88dbaa3so721728b6e.1;
        Thu, 16 Nov 2023 11:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163147; x=1700767947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf+4dZZDuZGo7AnzFtsjVfhJVrgljwo52a4BWevdDuA=;
        b=GFyn/0F432WVNdIkXHU/sgnxuwlBSR1zWGMprLC7vgyuno5/PYO0TE8AT9LgXbMCR/
         KLaf9b9QgZQeR/iKg6NM1vydtfRLkeW+3/IpWF31aIlNO5YvzNQUkCrVd6HVnOmgsufe
         jIVvrEeA+69BhL/FUk9G9LvICKiRuh5q+Kr+xU8t9MmR7pvXd6nLxkdzg5mEWw7YODdN
         qj4gRK8TThng1vA8fKPSx5toQ/wUt04oFKXO9RAIZ6YDVjFHlIhVoFV6rl9Q6KI57zg+
         mtKnx2rZTyjL6JgApa22+KKMHQpCZ5O8TcAhrhH0HdFSE0c+N5YlGJli5HPAIk2+6x0f
         KzJg==
X-Gm-Message-State: AOJu0Yz/iHPjP6SvJr4IMgA6J9UanbwcmVOLDnMgvbDDwtpVdi+A3gU5
        mSoVEImIg4haGsrgTrcFLQ==
X-Google-Smtp-Source: AGHT+IGoHhHekj7XRAdJdS/eRokVcFsihbXxRz8CbyoM8f7I1qH4lzAXhkKZ3wH0b6xVEv8WkbwDTA==
X-Received: by 2002:a05:6808:1482:b0:3b6:cae4:63b6 with SMTP id e2-20020a056808148200b003b6cae463b6mr20839687oiw.44.1700163147055;
        Thu, 16 Nov 2023 11:32:27 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fb14-20020a0568083a8e00b003b2ef9778absm6463oib.46.2023.11.16.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:32:26 -0800 (PST)
Received: (nullmailer pid 3081501 invoked by uid 1000);
        Thu, 16 Nov 2023 19:32:24 -0000
Date:   Thu, 16 Nov 2023 13:32:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: spi: Convert spi-davinci.txt to YAML
Message-ID: <170016314389.3081362.3941133682118537803.robh@kernel.org>
References: <20231114212911.429951-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114212911.429951-1-afd@ti.com>
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


On Tue, 14 Nov 2023 15:29:08 -0600, Andrew Davis wrote:
> Convert spi-davinci.txt to ti,dm6441-spi.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes for v2:
>  - Fix typo s/dm6446/dm6441
> 
>  .../devicetree/bindings/spi/spi-davinci.txt   | 100 ------------------
>  .../bindings/spi/ti,dm6441-spi.yaml           |  76 +++++++++++++
>  2 files changed, 76 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

