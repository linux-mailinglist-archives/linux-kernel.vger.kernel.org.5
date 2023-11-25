Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546E47F8AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjKYMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:37:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2411F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:37:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a03a9009572so376315466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700915876; x=1701520676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMZGUL4Fmisevm6QbqQLOWCdm9wztiPfJx/gfl7xa4A=;
        b=wM2vlAI3vMW/j96ORvTHU9nVxsR9O/Auutkgig20ZMUfHziGDhpxoKN7YII5Y+jGUO
         e1zctvM1rxGfv+yBOotbNhtjkJaIwxkMTdSz5UN8DyQnB9IhCFYo2d9K8mN2J/Y9RvAQ
         LTNC5EDGEqJQxQuZ3DuhCiKvYcGo4Dhb5uA07Dljr5aP5DhsthP5buXBzcPeTYgZjzzx
         nt3f+Kbe/idz7rAwMQIm7V2bLV9CpQUxMBiZYGXzqFRmXrLea1EM0FbiyAW/Dx8yJGJ1
         0E8tXk5EtJEPrxjSJTh+Leo5wC+lCmZmAXRJyxvzs3gRgAbiipq3T6qpfh+hg2V2YY16
         ORBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700915876; x=1701520676;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMZGUL4Fmisevm6QbqQLOWCdm9wztiPfJx/gfl7xa4A=;
        b=hbNLG/UKsRN6U3iw55GG0RsH5jAK+MxQKMx1dsSveUQo1X5vFxKcuSRikYFMBM/7sk
         25lzUZ4ZiLYOYud/Ejbf7I95R+OSQqZyW2Hms6ICf1hadDl5pFekspb3YajuFrj9d2oM
         rXzxI88wzFOuJ8nZVpJE2TuIAy3zvoLGfqW2JyPxP00xzdJnXhW3wOGejwAP5n08KWJA
         bDBZhVwLVA3TkN1BJWyDQoXLImFpTO3TqgpR+rx+l69d0paD5JXtizDG4cQmb6AOu+Go
         e5VLuPLxGuGejUL0DST3+O84I7o00BgE655gJ76BLzv2Pxs5xcIp5UR+aX3KERFU8cce
         vqtA==
X-Gm-Message-State: AOJu0YxuPkjGowFiSmUNnOd/lB5y2sGvflRRQBYx8Zu+lgiKPsB53EER
        8jk9H/gmxAdQMMnkk/X84kBjgWuZK3QZDhcpxYg=
X-Google-Smtp-Source: AGHT+IETP8hpOkLt+3JK4huabCOdXODMIVCAIfoxaZFwBxT1nO5GfSR1cy/c2Mm1k2C7Kx/zxkysBw==
X-Received: by 2002:a17:907:b9d3:b0:9fd:9616:c48e with SMTP id xa19-20020a170907b9d300b009fd9616c48emr4508401ejc.27.1700915875959;
        Sat, 25 Nov 2023 04:37:55 -0800 (PST)
Received: from [192.168.0.174] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b009fdd2c6d042sm3468612ejf.148.2023.11.25.04.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 04:37:55 -0800 (PST)
Message-ID: <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
Date:   Sat, 25 Nov 2023 14:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
To:     pratyush@kernel.org, michael@walle.cc,
        Fabio Estevam <festevam@denx.de>
Cc:     linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20231125123529.55686-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I made a typo on Fabio's email address. Now added correctly.
