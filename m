Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9F7ED72A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKOW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjKOW10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:27:26 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6983C192;
        Wed, 15 Nov 2023 14:27:23 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b5ff072fc4so97633b6e.3;
        Wed, 15 Nov 2023 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700087242; x=1700692042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e17v8Sw4wSJJjTaEGlOWNvLKDpho2BpFrgN/WZm5exE=;
        b=BqH4lBvIPcYOdW4R/viS7Pf1SEDUjq7gDMi+Fg77bGQglQLclZC76lG9yzFIkvTTXY
         29rceaBs/OX5ENNv40axfywDZlAdJroZ6JmIzz9b+GoRDeW37fHGFxK+ZAWWbHPJhwp/
         r9niKHaw6CwelYW4yql7jMp2C5ZcWxp6mMPGYXWxXsNVuCSus0UG3n2BDKbTVHIUSAiQ
         FnvZtd8xc9aC221/3ITNgzh58KNzZkmUdFE/R9HJd0+PyYcZUlkKlMz4uxbqKAyTGPay
         4HV5/QNAXs6M7uhO2vUwJf1sBf/F1JmdNq086MSo8/3J4AvYmhKOq4fWkVksw16GIXAX
         4dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700087242; x=1700692042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e17v8Sw4wSJJjTaEGlOWNvLKDpho2BpFrgN/WZm5exE=;
        b=IRuAiFDFUu/OX5VktPTLlWhnUqFuOqj1SdKWwNpzegmoYjzZejz9D+JMNITN42zqCo
         SQu24sJrg8TNHXoaV6IFRee9ql9uX/ReQ2dMeeqbA9xjtxNdanPFOmSNlmxD9/EshbvS
         H6cBzyeqrs4Qzzq7/JiTrBlSk1W0Bw6q4cybIZ1ZPeUPB/KenSS8lWOofG4FG7iY1tab
         wbVn8+lW8vISrye4xB3gDD4zXMCPN7pccoGj4GjVy2RX9BM/O33dtexy/E/QxwBAyzqx
         UBzE9V+iMlGGyAkSYEt/dSusqrUk6PCV4izvckYdRAJi6GQVvIN6vTZNFgeVK7Sp72X1
         SE4g==
X-Gm-Message-State: AOJu0YyItwjHx16EfQpMidNWEPu377/4CW9Hy5F7SykDh2x5xlk4iLi8
        NcNotke8eAhgrd5183YFjRw=
X-Google-Smtp-Source: AGHT+IFzAmvQX76tphpqTzSfTrMQ1xJxEJB6K6SOEfqb0t5crcNxzmM10NYre9nmdBE6apikiF5LZA==
X-Received: by 2002:a05:6808:6541:b0:3b6:dc6f:2741 with SMTP id fn1-20020a056808654100b003b6dc6f2741mr16185463oib.19.1700087242730;
        Wed, 15 Nov 2023 14:27:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dq8-20020a056808428800b003a9ba396d62sm1633251oib.36.2023.11.15.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 14:27:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 14:27:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Yin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Message-ID: <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
> Add a device tree bindings for mp5990 device.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

What branch is this patch based on ? git fails to apply it.

Guenter
