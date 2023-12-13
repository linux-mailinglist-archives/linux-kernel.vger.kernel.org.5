Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEA811E14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjLMTGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjLMTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:06:04 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472019AB;
        Wed, 13 Dec 2023 11:06:01 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-58d06bfadf8so4656905eaf.1;
        Wed, 13 Dec 2023 11:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494360; x=1703099160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlDa5mEHFBpFQpmGoSARdlKsC8LvTsrH+ND7Vz1stQM=;
        b=j/NadyBdoEBsaAw2sDH4jhnr6DMzjcKdkLkrB+xDSA38uyoYXnPQ1TfFcrEW1lXxqk
         0qsDLIMsiNYRE02DnovSpSQdVv60z7A+BnpuvFmJw5lDp05dH2SF6r8sw1O0xoZWkJjw
         PfOddSHniUHCRa6t2NA9G6RJXE6XQAKtUSQL+tyua4iIYbkdjUSRDQTSsf2ZdWQR1n/k
         v4o/ZslelQR9HMG/8yWesTjicXdoQ0u4reBqjLbx836VUEKU/+JWovApj7JC+tIaGsVr
         RvaZBeg+bGJG2e0Ca0yIaUOv8c8Ldqz+ibdqk7SOhtlgvSrFYY2HtUoAIJX0Wryf/++B
         Wq3w==
X-Gm-Message-State: AOJu0YzL0vzAMnKc0MA9+DOLzTrU2K9YjwD/fvmOGZ/R3JaXoS8BN21T
        Fyh924TtjhKkzpQxj9yuv9Y=
X-Google-Smtp-Source: AGHT+IEwFVcI79AiqvaOWcXX+w30ZNY8OM5klCBU5S6FrRCPhyO4pW2NXW8+OeYe1O30jcRRkeVR3w==
X-Received: by 2002:a05:6358:52ce:b0:170:f019:3122 with SMTP id z14-20020a05635852ce00b00170f0193122mr3897766rwz.7.1702494360434;
        Wed, 13 Dec 2023 11:06:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id v189-20020a6389c6000000b005c6801efa0fsm10155639pgd.28.2023.12.13.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:05:59 -0800 (PST)
Date:   Thu, 14 Dec 2023 04:05:58 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vigneshr@ti.com, tjoseph@cadence.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        danishanwar@ti.com, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v13 0/5] PCI: add 4x lane support for pci-j721e
 controllers
Message-ID: <20231213190558.GA988516@rocinante>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128054402.2155183-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> This series adds support to the pci-j721e PCIe controller for up to 4x Lane
> configuration supported by TI's J784S4 SoC. Bindings are also added for
> the num-lanes property which shall be used by the driver. The compatible
> for J784S4 SoC is added.
> 
> This series is based on linux-next tagged next-20231128.

Applied to controller/cadence, thank you!

[01/05] dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes
        https://git.kernel.org/pci/pci/c/b3ba0f6e82cb
[02/05] dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings
        https://git.kernel.org/pci/pci/c/adc14d44d7cb
[03/05] PCI: j721e: Add per platform maximum lane settings
        https://git.kernel.org/pci/pci/c/3ac7f14084f5
[04/05] PCI: j721e: Add PCIe 4x lane selection support
        https://git.kernel.org/pci/pci/c/4490f559f755
[05/05] PCI: j721e: Add j784s4 PCIe configuration
        https://git.kernel.org/pci/pci/c/9ca59b45ecf3

	Krzysztof
