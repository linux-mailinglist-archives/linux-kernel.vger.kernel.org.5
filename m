Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A667DD5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjJaSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjJaSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:03:09 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F792;
        Tue, 31 Oct 2023 11:03:07 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2cf67be2so3752692a34.2;
        Tue, 31 Oct 2023 11:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775387; x=1699380187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBWbi7Y3InN0amfRzl58wtob2sEve30Z46Ww/SB9XT4=;
        b=PUCzUqXeEw9DUaJJe1hcXtjnkXpMbHkNcLV3hd2sbEiWD8ZxNQ/owISVzb1IN9kfxo
         jy/AmIWmb6w8LpzUhgScdMK2UbId0mkwT0c/X8mnJXghjLTuCSzxUO+QhoGv97cgWJPW
         fLifm0s4TU5YtMP0zweu8A2Xr7A5qEDAqeiQNidRxsDMVMf1Ixb1PMPP9tllNi07YNWZ
         FkZqeWnaT3G1R0WRBZHrkZltdLxHT080LvEBSEBq8GSENOZ7VSzVgOnczKaWDeulWj4v
         trvQZ9U/BmqjzmZY+jwQOLKptvy+wj8v5mUIMwuRNWYYYsEbnJipxCWtj4tF335JOqjf
         8K5Q==
X-Gm-Message-State: AOJu0YzaeiW40OuEagHBTlD1S1gh4OKWIxT1fspOsQ6cUojP/O9bUhLc
        Or4bvQ6YFV+lcpXL1+JsdQ==
X-Google-Smtp-Source: AGHT+IFDmYyfKEScG+IjynXcRP20bxlv/OFOAsa8+QIiCzBhwpfmGNXYpoE8KH5Q0d2rdGE8CuRIww==
X-Received: by 2002:a05:6870:1004:b0:1d0:d78b:982e with SMTP id 4-20020a056870100400b001d0d78b982emr12693903oai.35.1698775386709;
        Tue, 31 Oct 2023 11:03:06 -0700 (PDT)
Received: from herring.priv ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id ds48-20020a0568705b3000b001efce0658e6sm367856oab.39.2023.10.31.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:03:06 -0700 (PDT)
Received: (nullmailer pid 1823980 invoked by uid 1000);
        Tue, 31 Oct 2023 18:03:05 -0000
Date:   Tue, 31 Oct 2023 13:03:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: add "internet" and "rssi"
 function definitions
Message-ID: <20231031180305.GA1813504-robh@kernel.org>
References: <20231031132901.11732-1-yangshiji66@outlook.com>
 <TYAP286MB0315235C51DAC7905DE4573EBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315235C51DAC7905DE4573EBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
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

On Tue, Oct 31, 2023 at 09:29:01PM +0800, Shiji Yang wrote:
> These two types of LEDs are widely used in routers and NICs. The
> RSSI (Received Signal Strength Indicator) LED is used to display
> the Wi-Fi signal strength, and the Internet LED can indicate
> whether the device can access a specific server.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  include/dt-bindings/leds/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
> index 9a0d33d02..55a426e39 100644
> --- a/include/dt-bindings/leds/common.h
> +++ b/include/dt-bindings/leds/common.h
> @@ -88,11 +88,13 @@
>  #define LED_FUNCTION_FLASH "flash"
>  #define LED_FUNCTION_HEARTBEAT "heartbeat"
>  #define LED_FUNCTION_INDICATOR "indicator"
> +#define LED_FUNCTION_INTERNET "internet"

Duplicate of 'wan'.

>  #define LED_FUNCTION_LAN "lan"
>  #define LED_FUNCTION_MAIL "mail"
>  #define LED_FUNCTION_MTD "mtd"
>  #define LED_FUNCTION_PANIC "panic"
>  #define LED_FUNCTION_PROGRAMMING "programming"
> +#define LED_FUNCTION_RSSI "rssi"

'rx' or 'wlan'?

Wouldn't you need multiple LEDs to indicate signal strength? Maybe 
'signal' or something would be more generic?

>  #define LED_FUNCTION_RX "rx"
>  #define LED_FUNCTION_SD "sd"
>  #define LED_FUNCTION_STANDBY "standby"
> -- 
> 2.39.2
> 
