Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DC7C92EA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJNGMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:12:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50161BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:12:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so102481466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697263922; x=1697868722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwhbn1hukRofnIjJhbz4lIcJRjmPcE71e0px0OJJDnA=;
        b=UzcinwG/rCr3+fyfH9CubN2Sa4zZQAsVrlTOQKNeyGE1SPFaGqRa8ZGnFf4GsEH506
         F0PQ6Om+uLQQLaQLWuwlgTdpYUFb9kO+4a/BjXjq/KnclSZM4H4xJJeYWt6g1x64vnEy
         PUL6zrupeszB8ZiW65n18rmMAcVy4SmLtOL9TZCX3qwEQTeaJz4jgU4iAcDGthN92CNs
         HPQGNv0+ysLACf/L3F2QXXuIOqg6tjGIJqNsI8DgsdqVklzF85eShGDeYNI2XAuqeKiB
         J6Eesj+KMQ2nWkRsUFmmDMWEaEoCotwMng0hpS2Q4jjG+AoWdYfZsSyvAKp6UJ39wdI/
         I6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697263922; x=1697868722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwhbn1hukRofnIjJhbz4lIcJRjmPcE71e0px0OJJDnA=;
        b=DU9MwjE4TF+Up3pyEYOtR70Ds634yKf0MG9q97MzGeOYYx8QCgVBHio+h/C+FJTaO8
         WrL6QjkThdlkjp1yDc8PG858+872PB1VMvQmj4Wm0SLORSC8SMFkFYYQD7WPwPd3sNrf
         5v7ymlZgbrPWQIN3SM9YDNMICXgVpCBDHaRWn30ev8ctgz1M4f5W9Fm5VgfTG7txxVCa
         TFwkZEXsoF99q2Qf7QKV75tcrG3HfIH5KBJQmxJBVSsPe0jeAuYfnxyHVvpkK3nthzrt
         Hs4LcFfgKPe4jYi1Wkvu42oPPGFpOHvyakCScqK/FGT4hGpX2N3OGWbCwEtwYP+eGy2P
         w5Vw==
X-Gm-Message-State: AOJu0Yy4uoddUAVvN0ldKSbUX0aqA5uD86M+wGGnIs30s3/N4Jervrns
        g6rFA447TpqHCDv1auQJE94=
X-Google-Smtp-Source: AGHT+IHFjGetvQBHJfWxuQWM0DaEQ/iFOMbRiehWHPfpaOqU3OW3uDKJlGgX3iK39u02BT8gyMGEhQ==
X-Received: by 2002:a17:906:530b:b0:9a1:aea8:cb5a with SMTP id h11-20020a170906530b00b009a1aea8cb5amr23967931ejo.1.1697263921429;
        Fri, 13 Oct 2023 23:12:01 -0700 (PDT)
Received: from [192.168.0.101] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id pv21-20020a170907209500b0099bd1a78ef5sm504039ejb.74.2023.10.13.23.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 23:12:01 -0700 (PDT)
Message-ID: <bac0d5b5-9c6e-4892-b328-bc998add7f64@gmail.com>
Date:   Sat, 14 Oct 2023 08:11:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Type encoding info dropped from arrary name
 "abyBBVGA" and variable names "byBBVGACurrent", "byBBVGANew"
To:     Pavan Bobba <opensource206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1696791459.git.opensource206@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1696791459.git.opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 21:01, Pavan Bobba wrote:
> This patchset series consist of fixes to issues found by checkpatch
> 
> Pavan Bobba (3):
>    staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
>    staging: vt6655: Type encoding info dropped from variable name
>      "byBBVGACurrent"
>    staging: vt6655: Type encoding info dropped from variable name
>      "byBBVGANew"
> 
>   drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
>   drivers/staging/vt6655/channel.c     |  6 ++---
>   drivers/staging/vt6655/device.h      |  6 ++---
>   drivers/staging/vt6655/device_main.c | 24 ++++++++---------
>   4 files changed, 38 insertions(+), 38 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
