Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3197DA806
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjJ1QU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1QU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:20:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8702CE5;
        Sat, 28 Oct 2023 09:20:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2843309b3a.2;
        Sat, 28 Oct 2023 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698510024; x=1699114824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT9WTH6/M3GiAfWTUMKKJgdgKxBiJQefVVsQat7FxOQ=;
        b=X5e8eWm1n4qm+thBGZt/c2xVIayXCZH5W1C/h4dvIjwa+l2radHy1cP03ML1wJz0DU
         2TAHsbM/WD/rBCqWh+qO3r4mIlyM3lXalYxevUWhFgRI8AESJQSi7CKARVoF4we7GohN
         PHe1KR2ZzJjbVSLAVGyeikaiVdRnQrvI3JMv/03Dm6dt3/ECmP37mV7lJBOQiFyAJKEZ
         NgdTD72vgQHca2CzBeen843ImhhCP4BwTUccqbEeY4KRwkM1VMdxpAuGtdSWFY0oLhxU
         t9Uj34GCbx8ZfIsibY9kKoMoLvVjxAxLgUcC5TvmhGYRrfQRQcweVkKak+ef23cwE+Le
         yrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698510024; x=1699114824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT9WTH6/M3GiAfWTUMKKJgdgKxBiJQefVVsQat7FxOQ=;
        b=kuUbXF6JQmNhITKG2IKvuUulP3l7CQiMp3fQ3O9eF/Yo1Cweut20YIi8PfF6hFCHwl
         ZUANT0pLIhtduS40fFho+7s9msWoqFa3BzrrfJmuVse5zAlXvSWpGCxF6VnpdUvLbN2s
         yKFe4PyIbuVUiJrXjLVANrpb1S0WLmcRDVXIhoj59UizD8O/6HtsOFvQzYSWDDJmbBM1
         cEk1XQhk/WOMvos+rTW3N8Pe/H3Qo0ISFICGIQvszUs1U/onxVYhR7/uKeYm9NCAzlzV
         Pvx/lE8yHrSf8daEnJ4om+yXZE1UTGWIJ/+Lu1SW6WYb+YiFSrutxstjYVsDWYMTrJHc
         wiSg==
X-Gm-Message-State: AOJu0Yz0/d+zlH8fvj6u/ryXatUh0eGXuMW6AiLQNEzeDQoDDBmFXdHB
        KZ40ificVpfqx7YCmAyHLrA=
X-Google-Smtp-Source: AGHT+IHJhBXFjEFWZclViV4Ss51F9C7SAzSbQQRBvpyCqGaV4EydAiGGZj90kF12MI62I+3QMbI9Kg==
X-Received: by 2002:a05:6a00:198c:b0:68a:4261:ab7f with SMTP id d12-20020a056a00198c00b0068a4261ab7fmr6275125pfl.31.1698510023986;
        Sat, 28 Oct 2023 09:20:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fn8-20020a056a002fc800b006a77343b0ccsm3140045pfb.89.2023.10.28.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 09:20:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Oct 2023 09:20:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: npcm: Add npcm845 compatible
 string
Message-ID: <96dcad12-af5b-49ca-872b-34ed87c9766d@roeck-us.net>
References: <20231018181925.1826042-1-tmaimon77@gmail.com>
 <20231018181925.1826042-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018181925.1826042-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:19:24PM +0300, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 Pulse Width Modulation (PWM)
> and Fan tach controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied.

Guenter
