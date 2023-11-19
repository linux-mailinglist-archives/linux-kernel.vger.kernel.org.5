Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83C7F0691
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjKSNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:49:46 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8E0C4;
        Sun, 19 Nov 2023 05:49:43 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b6ce6fac81so2331799b6e.1;
        Sun, 19 Nov 2023 05:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700401782; x=1701006582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea1nL2nPexAtRKPgqXuGpzPO5QHlIHi+M6o+KnmRKRU=;
        b=tcALYVDifEX4gTM1hXLEcOsvOdsaPOvwuJXAPbZCoAQ5ies15q+gdll/NWCcMAsT7o
         wRoYj9QtULjBN0myplDayp6m5XkoltMxj1aZhbB9acCE8STlL/YFWaB8NTZtl6nXnhqp
         SiSgA9Gr8fPVpqSyHI03wE2TrLJuBNTd5JldvFEkGC8MtbcbzKjCsxrHc3BC6kczq2hQ
         HRlDaZELzJ2+KHyfjc5KBTFSPmmYg7mPiG6ExZeD86vXj8DvDrSWyEpV7scOql03DEEa
         50ZrbT9tg0Hfy5kr0XbiBsZ8z4DtvM+2g/23kyfxMqZVCF53UZStfbSIvnYAbvpNNeGf
         RFyQ==
X-Gm-Message-State: AOJu0YxlDFr1+Vypvi61sSy1++D3UUX9C3WwKtMIP0qdZkzj8KtuxO62
        /TzUAMT1t8NvZTGdk1YJeA==
X-Google-Smtp-Source: AGHT+IGxVkAxDv26Ud8aWhrf5vJNXccASuADchAxq+oMG+km9HHX6JHB8u48ZRVIHJQaYC1FS1BOuw==
X-Received: by 2002:aca:1005:0:b0:3b3:e64e:e0a4 with SMTP id 5-20020aca1005000000b003b3e64ee0a4mr6236212oiq.54.1700401782352;
        Sun, 19 Nov 2023 05:49:42 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id z21-20020a544595000000b003a9ba396d62sm968588oib.36.2023.11.19.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:49:41 -0800 (PST)
Received: (nullmailer pid 9867 invoked by uid 1000);
        Sun, 19 Nov 2023 13:49:39 -0000
Date:   Sun, 19 Nov 2023 07:49:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231119134939.GA8784-robh@kernel.org>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117192305.17612-1-petre.rodan@subdimension.ro>
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

On Fri, Nov 17, 2023 at 09:22:57PM +0200, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> 
> Changes for v2:
> - Removed redundant quotations reported by robh's bot
> - Fixed yamllint warnings
> 
> I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> python errors and exceptions

What exceptions?

