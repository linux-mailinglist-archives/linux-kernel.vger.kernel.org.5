Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1B757F65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjGROZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGROZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:25:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B512199;
        Tue, 18 Jul 2023 07:25:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8baa836a5so45179815ad.1;
        Tue, 18 Jul 2023 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689690327; x=1692282327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RecCA8vAFQXqohj5TOPR9rOC0edp+q0SVjbjIuPLS2c=;
        b=Gw2kPAo65Kv8O7eN2R3imSArpp3sl+zwXomh/gx/glI7B/aOOkZRdJYBo9niQUcWUs
         cxiLx/U1ALQC33BgIDYK5UpG9UV4Tcv1X/R5w5EFtphYvzbXh8QfuimjDQp5y1k5sx+x
         zJGn3juBl49+O+GoqubCevXG3mUHDriuufo3xQDGHvtelOtA4Kuf/rhnI2HmvpV/S8Lo
         BZ9RaiGs37K4zzLSc1dGFAHFXDIr21RKayxi5q68ielyUMVpcNXPNz5NUI5I2X2p8n/A
         Vb9eyqxtFG/0qO4N8sqKhlPGD+OciG51JX4xiUu/6OrWkPXr0Pej73u3HkfbBGRqBsm1
         N49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690327; x=1692282327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RecCA8vAFQXqohj5TOPR9rOC0edp+q0SVjbjIuPLS2c=;
        b=Gjd7FukDEbKsH7g7C8j571t7/pqNJXgCG39LkSX1mdjwORYkeiECc3ptydlzXkUScp
         1Su8sFWz2NXJLe1qA5oUNTEkAgGlOVezBPJIVipZ6doB3jNZXFrNAuala54GyDC9ROOb
         q1SDDH+trLC/ygvDp/tAZAsVvCtKQ3q9H143OMm5+iFjGTgBZikB+aL4gPb3AgpvzBpx
         2wjYw2bGKB4roaMX32UWdMfg3s+QCGmQMiXOQ2GX26qBjlwDUuGH4v4KNnuD9f76qHXx
         RDg7Fpy5eMYF4x2YenNknURZka25rzdquDaNRvxYTWxA4R08zdZQlF9NZchBmWlro34W
         xZeQ==
X-Gm-Message-State: ABy/qLZWcQlPM2/8qGmQTcHr8NtRNoN8OAcUCGq/wMst6C61feGlQovZ
        1MLXdHfXww5U5PqF7YUpLvI=
X-Google-Smtp-Source: APBJJlGTNBTi10xRnLxTNvbAGliZrTe+7oB/h3WGBUx3s26ABAxe3uDi+qg37LchChzL4lbfZStnfg==
X-Received: by 2002:a17:902:ce81:b0:1b9:e23a:f761 with SMTP id f1-20020a170902ce8100b001b9e23af761mr18256106plg.63.1689690327104;
        Tue, 18 Jul 2023 07:25:27 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902ba8a00b001b50cbc0b4fsm1952851pls.111.2023.07.18.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:25:26 -0700 (PDT)
Message-ID: <f52eb3fe-e141-5fc7-047f-185ff6e74735@gmail.com>
Date:   Tue, 18 Jul 2023 07:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] TinyDRM display driver for Philips PCD8544 display
 controller
Content-Language: en-US
To:     Viktar Simanenka <viteosen@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230718080727.323426-1-viteosen@gmail.com>
From:   Randy Dunlap <rd.dunlab@gmail.com>
In-Reply-To: <20230718080727.323426-1-viteosen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 01:07, Viktar Simanenka wrote:
> Support for common monochrome LCD displays based on PCD8544 (such as Nokia 5110/3310 LCD) SPI controlled displays.
> 
> Signed-off-by: Viktar Simanenka <viteosen@gmail.com>
> ---
>  .../bindings/display/philips,pcd8544.yaml     |  92 ++++
>  drivers/gpu/drm/tiny/Kconfig                  |  11 +
>  drivers/gpu/drm/tiny/pcd8544.c                | 506 ++++++++++++++++++
>  3 files changed, 609 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/philips,pcd8544.yaml
>  create mode 100644 drivers/gpu/drm/tiny/pcd8544.c


Why is there no change to the Makefile?

-- 
~Randy

