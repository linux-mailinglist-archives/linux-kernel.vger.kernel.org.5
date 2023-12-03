Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D65B8025EA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjLCRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:15:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53110DB;
        Sun,  3 Dec 2023 09:15:43 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d852e06b07so1091301a34.3;
        Sun, 03 Dec 2023 09:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701623742; x=1702228542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBZXO26v74KanRQ2TmzpAUNxTFWX1dmRT4JokhSA/SI=;
        b=SDsmjgNLbWa1ZYhJEVkbI42yJO5/u2ceVgNYRTjTDpwzp58ydN155MPOAnOS7XYa1z
         b6vNS61jNd0iEHrI8l1lSnK9Sej5O8Pb1QziQ9JYlMuCpvRRREvqmpuMkN4nm3DwNMev
         svVtoTvnhYoisisiDw/aZy5PdE42lJjTsFD1QZMu/wTawWJqWeVl+dlAtTLXqMp46olL
         KH+zNFKjHhZhe4UweafPNvRyuBqMa8QtYQaJUirK4Ywr7WC7AB873E2UocryXwERcZS6
         KuWMSR/r2JI3WeSyhXizO/Jew3dRLPKuKL5EedvRJmI4FV705XM1n2UPUUKiTjvmC++n
         YGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701623742; x=1702228542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBZXO26v74KanRQ2TmzpAUNxTFWX1dmRT4JokhSA/SI=;
        b=KPrXnJKJY4j2GmG/xoVn6Q6nfJBN8FeTKiS6liqS6B0eME+KOWlqb1+DTDP+7mO3pS
         idGdAgb4YoIwaUq/Fb8JGc+z1XFiktfdVckZdra9yxrtUHDa8bpYJVZfOlZtGbrYSDZJ
         4haLOyvrkrVRl3cTkB0AUSgj7TxFcUXWo9bWyD7YF9jtft8SJ3ffNxNQfj9/tLXEZjKL
         40hZVYs+M2OO9fDPPyE8FILq/Hx/tktlmoHcQd0QuQy68SiMgPNSxdiZQmDuo4vSQAOb
         0IWZrr1MJPJOswFvj34KxRDEso9Pxu2b6vH45x4vrJxZoxWfaKq9Axep/UJ27r9PTjaQ
         5YyQ==
X-Gm-Message-State: AOJu0YzkZ8BNvTqb70shtldmnffcCENW9XU7rpWVzbM7o3oVMsHPb3I8
        Jys1h1kNjkUAMg+/xhjQgUA=
X-Google-Smtp-Source: AGHT+IGpYYq9s+D+6iOr2T0a893By27s0UsjTBo8nIfE2jdkP1XUmvSZ1rAasxcX0x8uilSlny2lCg==
X-Received: by 2002:a05:6820:2813:b0:58e:1c48:1a64 with SMTP id dm19-20020a056820281300b0058e1c481a64mr935915oob.13.1701623742524;
        Sun, 03 Dec 2023 09:15:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d17-20020a4a9191000000b0058a3c5d590bsm157883ooh.7.2023.12.03.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:15:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 3 Dec 2023 09:15:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: Increase max number of io-channels
Message-ID: <3d90a57d-0149-4d4b-8ffc-af26a87132a3@roeck-us.net>
References: <5110a313a5ce52ce6d7b5cb6b08368d42063dc30.1701419691.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5110a313a5ce52ce6d7b5cb6b08368d42063dc30.1701419691.git.michal.simek@amd.com>
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

On Fri, Dec 01, 2023 at 09:35:00AM +0100, Michal Simek wrote:
> The Analog Monitoring System (AMS) defines 51 channels
> (Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml)
> that's why increase number to 51.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to hwmon-next. If there are still concerns about the commit message
please let me know and I'll drop it until resolved.

Thanks,
Guenter
