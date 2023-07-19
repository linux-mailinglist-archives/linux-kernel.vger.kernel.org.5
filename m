Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED0758BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGSDB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSDBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:01:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F38130;
        Tue, 18 Jul 2023 20:01:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89e10d356so40574225ad.3;
        Tue, 18 Jul 2023 20:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689735713; x=1692327713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thEXipIY2P8Bpgx7Y1frh4stUCxjS6n/WqeDaPQ8aHk=;
        b=Iy+R6Qd0V4s4bT9RJ3FezOfc7WJQ+rb+9QXAkxeEjwybR5cizWC/UZEdrl8YM3hwg8
         dW2DaSkYKOUIsDJ0u56J/xojUdPc6NxQFhRFYAqDCWAfBkDN3yMPMre3Az5pmIo6uXz8
         UffuZpkXHn2l5N017tblb9mOtiwoEQQeJfCGfgG5/PCPYhD9LIni/eSbIMl2BeP3L1vf
         3RqZkDFC+CbZfkzdS1gbb/0ZVcBKZAA+RP5NCoj7k7CEwDzoE2BI38XZMqSR8Mxdh05R
         BzlQFcwjOjvctwIZpfvxIiF9nGJg0RbibV8NJ8IBitopl5N2xZhm5mqVqZpfJ50fQ1Tg
         8cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689735713; x=1692327713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thEXipIY2P8Bpgx7Y1frh4stUCxjS6n/WqeDaPQ8aHk=;
        b=J2mxAqTaOfzkexyYlBZv7i+ig0H2XDta0YnSK9E7f2giuh6JmcUB5XRm3BmR4X0qNq
         cQ0KTGP39+Bl8gAMoMe5AowbpozNeS0UkTCDSWWodbvi5n7HXG7dQuTpF3eNkD0pfOdy
         8EzYKjNEGrP/SDexdQ0bnmNzZlJj88iKw+rT7vkkMsmC8n5uLqqHsVJHv4dfU8VSUcJi
         Y818+bdjjjczevn2Ich/z/un4sFM6neQdz/yGRsgiJiyJJnkXv2qC53DVhJRWHC86l7J
         ESdaxD2fb0kucwwQOzYaL12WvYYC05xxKNuP2ft68uOzhJUf/77DO6TMNIdVHsORE7JB
         7IZw==
X-Gm-Message-State: ABy/qLavrrwURoouotr/JdxHzdUATgh7Wp5ZuEvz+lPSsZ6i/DdqcR0V
        oiJnEq9IapeyklxqLPo2sRRJ55fcCKU=
X-Google-Smtp-Source: APBJJlFjdttqoYssE/6qZLiIsLBdjGeqg7VNST6scNwR5mrv0qTImM0RWKAdc+W3gejnhWkBT2u6VA==
X-Received: by 2002:a17:902:f693:b0:1ae:6cf0:94eb with SMTP id l19-20020a170902f69300b001ae6cf094ebmr4306055plg.5.1689735712656;
        Tue, 18 Jul 2023 20:01:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001b89466a5f4sm2610007pld.105.2023.07.18.20.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 20:01:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 20:01:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: trivial-devices: Add MPS MP2971 and
 MP2973
Message-ID: <a023d225-2a6c-4c98-9bbc-61fb6a6896b7@roeck-us.net>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
 <20230714135124.2645339-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135124.2645339-2-Naresh.Solanki@9elements.com>
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

On Fri, Jul 14, 2023 at 03:51:10PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add Monolithic Power Systems MP2971 & MP2973 to trivial devices.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter
