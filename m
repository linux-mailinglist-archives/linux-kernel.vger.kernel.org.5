Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2B80CE31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjLKOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbjLKOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:19:42 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA9212F;
        Mon, 11 Dec 2023 06:17:53 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d03bcf27e9so26945025ad.0;
        Mon, 11 Dec 2023 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304273; x=1702909073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQCSZCHRZifXrm2rHeeJVxoyk1kBTheYDBk9lmCNOio=;
        b=DWteeA9G9+KWL1JJ5nyOscj1KRl3rN/30VZq1cON/fFiRpJdS4ngFCo1kKKb2wXzI8
         koUYTRiuaO5t3nigev7a46Jc6n6b5GsYxUTuDOz5bGbEaVK0jTtgj4pGl/YyytOc/zlr
         PWUwSJl49ruIwmKvd3PWRVK+aQOpup5jF9EPyESDGBhVWav2pNS+lfVy6sJcyroInjbk
         R3yI0OUlXJbk+7IUoz4y/9EC4W4nqxomhBKJ9uAcsoHrbvbFYiV+4zr/qfczf2Y0AtGY
         a+ItubsUhoTuK7gF1KqwF8t2ZqzvLAjRuy0ANUVLNBrcCY8SHn6eWf7MNGE+86vndsrB
         LjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304273; x=1702909073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQCSZCHRZifXrm2rHeeJVxoyk1kBTheYDBk9lmCNOio=;
        b=myIwWmw/lU3Rlzr2ezxK6ruDQHh0ED+U2oSbxCW5B+dBtsfs4gEdCVHnWzlDV+9dV3
         qVoj97BXFMfzMvIzP3s93I8tnIpIVABTWGiCzY4M7J7HY4a0/AWBdlqeDW0cqKxXebji
         uTY99wzNu2cI0geGVL4gKn4JmLMzTe831xwUEl5orJl5kBiwDu0EbJ/uVPzCREM16n3/
         ZSwxTQPdyL2XuA6iH2ZQIBTW6WuwwHgrigUSpw5zmxqWpIvYtUvcnEUMa1fJTD62eF9o
         4XGYbSMcs+eVfut1lM8ubWfSUef9GN4dWgE0BegPwrjf3fhktY3EdbcHYQglfozTEutw
         kC0g==
X-Gm-Message-State: AOJu0YzUGhhN68GD8q2oVZMWSIp1bACNvR8AcqZ2M273sZB/ufqSCvaz
        w06ujFDXz7yjARPWpiY5n+0=
X-Google-Smtp-Source: AGHT+IGgbLZWtCsbqHPS5cp/C5+jKiGs3bIxlGTixkc0tac/6iObkizX9mZzNwEHQcFHKHYBel0W6w==
X-Received: by 2002:a17:90b:1191:b0:286:c105:2373 with SMTP id gk17-20020a17090b119100b00286c1052373mr1896361pjb.45.1702304272647;
        Mon, 11 Dec 2023 06:17:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028593e9eaadsm8462569pjq.31.2023.12.11.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:17:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:17:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: hwmon: Add lltc ltc4286 driver
 bindings
Message-ID: <a71eae64-680a-414a-84e1-709c27a90d0a@roeck-us.net>
References: <20231123015440.199822-1-Delphine_CC_Chiu@Wiwynn.com>
 <20231123015440.199822-2-Delphine_CC_Chiu@Wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123015440.199822-2-Delphine_CC_Chiu@Wiwynn.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 09:54:36AM +0800, Delphine CC Chiu wrote:
> Add a device tree bindings for ltc4286 device.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied.

Thanks,
Guenter
