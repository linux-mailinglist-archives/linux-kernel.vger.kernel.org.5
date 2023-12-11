Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1480D006
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbjLKPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjLKPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:48:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7966EEA;
        Mon, 11 Dec 2023 07:48:08 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c32df9174so38086985e9.3;
        Mon, 11 Dec 2023 07:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702309687; x=1702914487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wq1z89F5gUStStS9kY9mGX61kbmqB7xupwhoSFkx1p4=;
        b=XZ1zwVLzNkiimZwhd6I1SE2YfbWTYQOvymNpzOYdRXInEOPv/eBNpUvdkn0iD4QFWr
         qaoqEVgdlMB63DPa4r7Kej7Kno/3nPZRarSZo3lS6TDfLNPD+trtxtkz/NFwutbRu30h
         Q5OLdSxL/zlpKEPzu0t9HIuq3Jp0/Hesit3+Yc9VjuumWG3bbk8V4YIQtj8TU7VfAJXU
         MCvjoAiEjPwyY4We5PbsZCBHJr1aMchXmgGFU5tlbADYWeCHACbN+TwnMhC1Sd9S/Txc
         nAsZxV8Q5JtwPyLDGhSCxFfKdfQZERNDMU7lOTg/JSR02tPEVhKnZ/mlJ0AwJ2stKXh3
         wXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309687; x=1702914487;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq1z89F5gUStStS9kY9mGX61kbmqB7xupwhoSFkx1p4=;
        b=faQBJHh1GyLZEpq5mF93ISDH5OKvzP/Hod4R5udMrbSYTFfe9ZuyU2xCRxClMqr9QA
         Y2yI3HmS8bJPoNO5o5arWps2lIKvvHQayhtdeEyM6VZyx1rWCPwdv72Y9jlAitkg5V16
         0NMqxjmJ2d4bX6+nOu6FaFBYp/3L+WBS742rx7dWx8gow5tn53JvcAXUFJ6/xpmCjSvS
         pcUYAbPQCekB/Y+KKVPlMqJjAyVEpyINQyttzfJLyfxmgVb5Ly7Y2ZVa6ia59OZwOtSB
         RlIFFDs6jEANYs+O7cId+B9g5D1qOYMc9uXVKnVDt2ucUAq8dGwJQvD9KrfXDkh9PjX7
         003A==
X-Gm-Message-State: AOJu0Yygx9XhTmtrBeUCpBHjeORVLKjVCwtTL+FtHCDMzmB6i2xjzqXi
        cYy36ZbArr965MoTHx0NZ08=
X-Google-Smtp-Source: AGHT+IHJiNmLLwj1NImOACKxGQaWC3n6aUQwSFRmZNd9rYrwlW8jp/SEDWCsEBA9znsukqIdRpxNAw==
X-Received: by 2002:a7b:cbd5:0:b0:40b:5e1e:fb9a with SMTP id n21-20020a7bcbd5000000b0040b5e1efb9amr1724029wmi.79.1702309686560;
        Mon, 11 Dec 2023 07:48:06 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm13197492wmq.18.2023.12.11.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:48:06 -0800 (PST)
Message-ID: <65772f36.050a0220.678b6.ef84@mx.google.com>
X-Google-Original-Message-ID: <ZXcvM2Sl-7IZ0EA2@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 16:48:03 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:44:06PM +0100, Andrew Lunn wrote:
> > +properties:
> > +  qca,led-active-high:
> > +    description: Set all the LEDs to active high to be turned on.
> > +    type: boolean
> 
> I would of expected active high is the default. An active low property
> would make more sense. It should also be a generic property, not a
> vendor property. As such, we either want the phylib core to parse it,
> or the LED core.
>

Mhhh with a generic property and LED core or phylib handling it... How
it would work applying that setting on PHY side?

Adding the check to the set_brightness set_blink hw_control API?

-- 
	Ansuel
