Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38280A471
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjLHN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:29:34 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FAA10F8;
        Fri,  8 Dec 2023 05:29:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cb55001124so1362594b3a.0;
        Fri, 08 Dec 2023 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702042180; x=1702646980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9RiRu/3thmztbxW891ETgTSqlyTQrNppWmgw1hCX+w=;
        b=HrYhyVl06naFuNyE3Ba+ITA0tqacNxo6LWv/E/6mKUgiquhT+HLWe+liZzYCKMX/An
         yRxIjwfLa+8SstQaK1JU/t5eTlCDbQtxSoQBeM3jGkXQ5QoF90oe3iHEaiyvg7gH4u3S
         dCiVKL8xEXDUd2KV7Hc3pVm+6XEf3PvHBuUk7ETeMUrupnl7tmmlXmc24SfgYOyBoY9Z
         zF+9nOzBzDsS743HUIbc+kevqWH3QYsZ1AhFb19ZS4hvyAUtXNhfYgFkd6jQI7TC+awi
         AhcubpoO4F6q7YSSEI3OPbViXgA946eccDCgTb+Gbo8hW5nDseCio15gZMhfUAdZVGoN
         qBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042180; x=1702646980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9RiRu/3thmztbxW891ETgTSqlyTQrNppWmgw1hCX+w=;
        b=TDk2t++m0p/9O+B8DvsbA2MGPdCV0RYuwK7IDSI8sO2pUBnp0jKulXdz+wDkP37s2E
         /vxOBJi802Er4Y5q9bKOXA0P0Uj74CO+xhbBwBLZVgtZ5f/RsaJrxTRwg6RIWcUs1/ud
         k0azrK+/UIFt6hkKcEHqhojMNcJcaHR71cHHQNngv37KCtk/L6ybwHW2OGzeuqoB3CVE
         wnBE9Fpkts+hP6YJNjC7NPEidF/n/0vyIf5MM7Fw+bcaqYjNI3QjbdGEFDZKN/jbiXLa
         upWCmOk9I7aU2/Dy0WkAJfGEc0mTsSHBMxYa+YACnYk6Px6iRykOOfM4uURC2U0hVtbw
         vNUQ==
X-Gm-Message-State: AOJu0YwCy+RCcJcrDyqK0KwkWNOLI33eNGyYZ6LX2iOaMKFyGCjEHdEJ
        /kk3tJSLB0TJ5HePMCJiUXo=
X-Google-Smtp-Source: AGHT+IHyhZjWoG+p1M8gr8qZiD9ytqcoZ7ZIXmhGLe5ZbI/4vs9XzpByblfyDm6VC+SbAkUZpoUtNQ==
X-Received: by 2002:a05:6a20:1445:b0:190:2036:fc4f with SMTP id a5-20020a056a20144500b001902036fc4fmr113775pzi.33.1702042180223;
        Fri, 08 Dec 2023 05:29:40 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id gu25-20020a056a004e5900b006cbb58301basm1624298pfb.19.2023.12.08.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:29:39 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:29:27 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/13] dt-bindings: iio: Add AD7091R-8
Message-ID: <ZXMaN1QORkSUMqZy@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <53d55f3195b15bd8d47387e296036730ea270770.1701971344.git.marcelo.schmitt1@gmail.com>
 <5209ef11-e2c8-4399-913e-e1e0399e295d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5209ef11-e2c8-4399-913e-e1e0399e295d@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08, Krzysztof Kozlowski wrote:
> On 07/12/2023 19:42, Marcelo Schmitt wrote:
> > Add device tree documentation for AD7091R-8.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Except what David said also:
> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +                compatible = "adi,ad7091r8";
> 
> Use 4 spaces for example indentation.

Ack, will do for v4.

Thanks

> 
> Best regards,
> Krzysztof
> 
