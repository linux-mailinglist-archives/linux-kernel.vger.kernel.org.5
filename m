Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E27B47C4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjJANxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjJANxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:53:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD85B7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:53:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso419697266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696168397; x=1696773197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WuNs1fTx2E5mS1rvQvEyzQGp3aoI7mPY6rfOs6zQoc=;
        b=bhl1gIi6qVkhUEJb7Vng8sjAIuF/p21CbQssQIoLKx2VXYLhWhoUexa6CetS16oBUo
         FMahSa/DBO8hP1tWzGJj0s0QkdnKlbv6qdXGt75+OfsmG832Q1jUq+Svc6IorO+N/t7t
         PnOQPIC+1I2t8DxKoNUuqNBMyOmXe4ryh+teG/A4fW3mpsTnc/u0aW0odWElrVObbWNZ
         q5JmtK6xEdPHMccfsqiimToxTinz2681ARCFH9mDpQz2Z/hqj8lp6BxqfN5mzNjO8p0o
         HB4sDI3+wN6dGri2qsjE23SVQHkDbBpkmeeG4T9H45u5+CPJDdarOx4UOk0tfcwop13N
         1fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696168397; x=1696773197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WuNs1fTx2E5mS1rvQvEyzQGp3aoI7mPY6rfOs6zQoc=;
        b=KWUR2gWipFPbX+42AM0iPwjIrTFOUTikEenNF5PFXXa9gdYgUIMIbOm9Lcv2YWuX6r
         CmBRiBqxCm8QPuxIGhLJHoeNxPGT58HK5P5ZZ305Rtak6+RzHi1hBRdquJ7397qTAKat
         yOQH8R06bl4kiziRuKj+l/uF8kjJEumnUeRdT8i3IA8c2V0VZJJQRxV2eNQ/aixvKBBO
         iMPYt+20O2wXlqqEwo5IyhFVyYywZyCC9JLxWjva/FgYGs37ZqFfnqr2lgldjUWthO9U
         kZvNyoc1DjdErwpAeBZ45VScBihZq283V9dhB5nswqU0MIxaeOSae++zkG0ESFHdvp1p
         xtVA==
X-Gm-Message-State: AOJu0YzyG45HDA+fgFLzjXR2H+Xqry7QSL/0lgieXecJKgE1iZGdupv8
        Wvo0h0AcbaooaaTLz0ccgd71KtCwE8E=
X-Google-Smtp-Source: AGHT+IEc5ukey0Xg7SMaP+CP83lphjqcmHf48JoyV6boi6Pijm9hSYazdyW6GLkBoYcB3OvhVxZoaw==
X-Received: by 2002:a17:906:5185:b0:9ae:50de:1aaf with SMTP id y5-20020a170906518500b009ae50de1aafmr8099784ejk.4.1696168397395;
        Sun, 01 Oct 2023 06:53:17 -0700 (PDT)
Received: from [192.168.0.106] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id fi3-20020a170906da0300b009a1fef32ce6sm15622065ejb.177.2023.10.01.06.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 06:53:17 -0700 (PDT)
Message-ID: <e367844f-7990-0ac9-3898-04cacc863095@gmail.com>
Date:   Sun, 1 Oct 2023 15:53:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] Type encoding info dropped from arrary name
 "abyBBVGA" and variable names "byBBVGACurrent", "byBBVGANew"
To:     Pavan Bobba <opensource206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1696141471.git.opensource206@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1696141471.git.opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 08:43, Pavan Bobba wrote:
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

Hi Pavan,

this is not correct. You need to send all patches as an own email.

It is also required that you include a version history in each patch.

Please have a look at the patches send in.
https://lore.kernel.org/linux-staging/

In the version history your next patch series is V3.
Please document in each patch what has changed.

A sample command I use for this is:
git format-patch -o ~/Documents/kernel/patches/ --subject-prefix="PATCH 
v3" --cover-letter -n --thread=shallow --to="Greg Kroah-Hartman 
<gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org" 
f3c8deddac66d11c41ba720e4048aba37e41e885^..HEAD

Thanks for your support.

Bye Philipp

