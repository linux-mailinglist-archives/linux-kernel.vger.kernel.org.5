Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D07F0E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjKTJIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjKTJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:08:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F82C9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:08:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40a48775c58so15094285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700471282; x=1701076082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7fnUrCHnN757NRCeEKxZxgB9tSX3+YYg88GEAjrUGw=;
        b=H3HqvSMVCqLVpWR0yJpPlFluwS1UlUPzGKogI1yHM5Osjcj4U2aynyxLACNYDUtb9k
         QIPYOtVf9pgYl9fcw/xuAiJB6WlkP+bclF8RmbWKtJk7dK7NLYKYPSWOetJNFi+Z9xFu
         PZu26WMDDT1Qo2VHAMP6DxQhxLt/dXoZghv5MUAsqmS37GOpX3lDdUiO8ZGYLtfjgTyv
         E7VD+Y5vA31zyBGD6rPT5u1fjnkSCMdzxuQFj7O3cH5cxB73i7Q05/0TvaHF8AY2neId
         yZAOhkiKmnBDEIVh5NVMLWOHOZRFv0eDCDqCBme9R/sTE+hj86OGpmrWrIh2AKXrNNix
         n/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471282; x=1701076082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7fnUrCHnN757NRCeEKxZxgB9tSX3+YYg88GEAjrUGw=;
        b=aT7phqRL+OPOfU7kOPLHy4oDEiRuham8LjtFyBsFcKYnWEz6XtbyBBmbAdqfdbU8XE
         2og6sI71gRl/n3sUSf/oJz7k9VYAQLv3fb55mWiq/EbHcuNQ5fXAbdeOcnIKN1I0ZwVL
         0HQ4+qVFyscp1IN7+sIbb/9oTkIRHQJWtPp9mhMiT2R4UNTuBhk002gifodBFFLS2ZOh
         n63i33052m5sSwEAuNtSPzyehU0A7eTbn0cqKySnlJSdVUpcmR/WavG5j8KjcjcvJuZ3
         nTm6aePQbIQRdIu9UrCmS61b8jtT0r52p7nmQIZzPzlpSyVh94kBdN6VM2SlUFGyamWM
         snQw==
X-Gm-Message-State: AOJu0YxKuGuuViTJbp7ipPFiA6mxYzfOS/aSZ9PrcLtZnzbSPE0Ba+eb
        JvOt2tnNiupvdGuvHsMUJjGENVgCqMsEZe6K2wM=
X-Google-Smtp-Source: AGHT+IGrJU1gcz4+zQty6U16XXZXL4L0phRDT42QBU2fcJOl/p7s8EljhgpBi/6s95q7Gw6z+A+pWg==
X-Received: by 2002:a05:600c:4750:b0:402:f501:447c with SMTP id w16-20020a05600c475000b00402f501447cmr5782193wmo.0.1700471282601;
        Mon, 20 Nov 2023 01:08:02 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c230100b003fefb94ccc9sm12489829wmo.11.2023.11.20.01.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:08:02 -0800 (PST)
Message-ID: <b6148647-c84c-4d21-ba68-6ed5a015aca7@tuxon.dev>
Date:   Mon, 20 Nov 2023 11:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: set soc_pm.data.mode in
 at91_pm_secure_init()
Content-Language: en-US
To:     thomas.perrot@bootlin.com, Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clement.leger@bootlin.com
References: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.10.2023 16:02, thomas.perrot@bootlin.com wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> In non secure mode, soc_pm.data.mode is set when entering pm in
> at91_pm_begin(). This value is used (not only) to determine if the system
> is going into slow clock mode (at91_suspend_entering_slow_clock()). This
> function is called from various drivers to check this and act accordingly.
> If not set, the driver might enter an incorrect suspend mode. When using
> secure suspend mode, at91_pm_begin() is not called and thus
> soc_pm.data.mode is not set. Since when using secure suspend, only one
> suspend mode is supported, set this value directly in
> at91_pm_secure_init().
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

Applied to at91-soc, thanks!
