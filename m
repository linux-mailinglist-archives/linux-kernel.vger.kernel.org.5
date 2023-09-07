Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7579798C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbjIGRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbjIGRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:16:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105ADE65
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:16:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98273ae42d0so31873466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694106920; x=1694711720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hn2uDmjOOXu6fIxxN8+ualmECQ/DiaKNpRYaCI67NFc=;
        b=cSROyOWi+YB2465EjwzjRh8QKm5pxaLKeeZRVQxlBaqEYN6k0JNZmZoaslU7cafw8I
         qZxADbZyjgBncILgt2TZiOV0+Bs4Vx2ytZnXDvf/9RKcSF+AXlVo9/5GtN6FhxmFSCjA
         nU2bFvQ9Wc0ZLLsgY9gHpw3kTebb0Xtfl6r4U6bCUEF+MnhqahbEDBNgdLNQGVSWGuwT
         LZgxb/8kgK9AYeZeFzJKrpbdRCV2IRSf9Wm0JxkMRrwNHH3jJaoEDS3MvyCE8u65re+V
         8OrrTHQVoe28j8AbbaEgd+HSh3Qor0kF4c2OyJR1d1pIBrqlouXNe91W5JMzhCRAcAVH
         ykoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694106920; x=1694711720;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hn2uDmjOOXu6fIxxN8+ualmECQ/DiaKNpRYaCI67NFc=;
        b=bK5+hELYPMKzhWbyMCbcaAwPRyP9wdBYMX7p7GkKE/aBBitRSnyr0No0GfGpU40Nke
         THeho0mgLIlmbGkBaEm2V72Qq7dzN2VljHlQGGY01jOabfMsKBabPT0qCZVqoTeqd0/Q
         aSqVuNeiL5w2uZeov8R41Uj13PyKzTfuVjTxMbUxXz8rOXj5dJBIsFsoL53NFqiIu98W
         cbYZf9t6AsmaIiSQLDngOcKvUsPyKXF2MK6TRlRv+PFItO/hAq+hiBu2iPNUZGukeeIL
         EBdT28g6BjhtrYpFbPPRTighBnI1WMFSgtTLNI1y8xyCW9UJfC8WwaLTW9XTJpoH2JJC
         Twrw==
X-Gm-Message-State: AOJu0YxLJ35YYkTxcFaed69t686NlJpMLa7jtBzuVKXm+Ddh7sYZLZkU
        DI547njv5m3IXRbk9y508nzaDYfSJlKmVQ==
X-Google-Smtp-Source: AGHT+IFnHGLb3wX8hiYQ6tqvPReQabYj+GoY6alyacmcc5c8OcdRZufgIb42eLrUhf90NY6IY9RlHg==
X-Received: by 2002:a05:600c:1c8f:b0:3fe:21a6:a18 with SMTP id k15-20020a05600c1c8f00b003fe21a60a18mr15226116wms.3.1694090951606;
        Thu, 07 Sep 2023 05:49:11 -0700 (PDT)
Received: from [192.168.0.102] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003fe601a7d46sm2406390wml.45.2023.09.07.05.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:49:11 -0700 (PDT)
Message-ID: <f872ed00-f474-b217-ed78-8612242d448b@gmail.com>
Date:   Thu, 7 Sep 2023 14:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] staging: vt6655: array names updated as per kernel
 coding guidelines
Content-Language: en-US
To:     Pavan Bobba <opensource206@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZPnA0Pra2HK30nBu@ubuntu.myguest.virtualbox.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZPnA0Pra2HK30nBu@ubuntu.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 14:23, Pavan Bobba wrote:
> Below array names updated as per coding guidelines:
> 
>     1.byVT3253B0_AGC4_RFMD2959
>     2.byVT3253B0_AIROHA2230
>     3.byVT3253B0_UW2451
>     4.byVT3253B0_AGC
> 
>     Conversions performed:
>     a.type encoding info dropped from names
>     b.names replaced by snakecase
> 
>     Issue found by checkpatch
> 
> Signed-off-by: Pavan Bobba<opensource206@gmail.com>
> ---
>    v1 -> v2: 1.subject name modified to more meaningful detail
>              2.name of the tool added in body of explanation,
> 	      which found this issue

Hi Pavan,

you did not fullfil what Greg wrote:

- You did not write a descriptive Subject: for the patch, allowing Greg,
   and everyone else, to know what this patch is all about.  Please read
   the section entitled "The canonical patch format" in the kernel file,
   Documentation/process/submitting-patches.rst for what a proper
   Subject: line should look like.

The issue is that hundreds of patches could have this title: "array 
names updated as per kernel coding guidelines" Make it more unique.

Rename CamelCase variable starting with byVT3253B0_

Always consider that Greg reads a lot of patches per day.

Bye Philipp
