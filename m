Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9067FAACB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjK0UBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0UBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:01:19 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1174B8;
        Mon, 27 Nov 2023 12:01:25 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6d7ed2c143eso3123990a34.3;
        Mon, 27 Nov 2023 12:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115285; x=1701720085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/1Bukk4BZ7q2jm9cQ+nh+Ew1x1vbMAH5xhvy5k7R8M=;
        b=lSFG6pA5wKjns0zTlvVkLibyiQp4j9V0Stsxxe/QKIZ3Du9I1HEAnMdqHp5FfKPK4I
         ULVtDmQ9+8hNjmi4DWHDedhd//qGNR48PvmmDUXJPN70gbXBNHf+YD5+Vk5PJKmZB5U/
         2iE2lcTE7eJiEm2M2JW2qOBL0p6hZwCfDMzUp321WEnpZlqctgzMG67WtGF8zCiey3QI
         LXWxlJ2Aue8rPNyYPD+Dldfc1zXFb+r0QrlfeCdZ55vZjcWm6Ep9T42PZ46z1qTZ2Kxt
         lzPJiVi62hq7xhBq+0NFCAeu5lm9k6VZ3Yve26YHj6y13hcmxVF4JEj4YEoIA9ME0iCU
         keGA==
X-Gm-Message-State: AOJu0Yw53vRUdrhho9opBV+zDSDnMfDQ2LXM03me4M35wbH/l4JnhvoO
        G2HKWXmtIkNqY2F6Iio65Q==
X-Google-Smtp-Source: AGHT+IGpGZwUOq3P4IPSr4NBY/hO/zlRPqa0tzUESZae2bUTULaZ08r0lrc/X6YYWp6GU5CPIonPNg==
X-Received: by 2002:a05:6871:7292:b0:1fa:cbf:88a3 with SMTP id mm18-20020a056871729200b001fa0cbf88a3mr15764884oac.26.1701115285170;
        Mon, 27 Nov 2023 12:01:25 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l7-20020a05683016c700b006d812c49f21sm805272otr.17.2023.11.27.12.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:01:24 -0800 (PST)
Received: (nullmailer pid 2911558 invoked by uid 1000);
        Mon, 27 Nov 2023 20:01:23 -0000
Date:   Mon, 27 Nov 2023 14:01:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomas Paukrt <tomaspaukrt@email.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: serial: Add support for enabling
 RS485 mode via GPIO at boot time
Message-ID: <20231127200123.GA2896702-robh@kernel.org>
References: <3Zb.ZZsn.wkax8K4so6.1bN6eS@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3Zb.ZZsn.wkax8K4so6.1bN6eS@seznam.cz>
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

On Tue, Nov 21, 2023 at 09:28:12AM +0100, Tomas Paukrt wrote:
> Add an option to enable the RS485 mode at boot time based on
> the state of a GPIO pin (DIP switch or configuration jumper).
> The GPIO is defined by the device tree property "linux,rs485-mode-gpio".
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index 9418fd6..7a72f37 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -47,6 +47,10 @@ properties:
>        later with proper ioctl.
>      $ref: /schemas/types.yaml#/definitions/flag
> 
> +  linux,rs485-mode-gpio:

This has little to do with Linux, so no need for linux prefix.

The preferred form is always plural '-gpios'.

> +    description: GPIO pin to enable RS485 mode at boot time.
> +    maxItems: 1
> +
>    rs485-rx-during-tx:
>      description: enables the receiving of data even while sending data.
>      $ref: /schemas/types.yaml#/definitions/flag
> --
> 2.7.4
> 
