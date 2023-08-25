Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A49788F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHYTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHYTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:42:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9961FC7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:42:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401314e7838so2121885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692992557; x=1693597357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApTGyFrrfdw4KCGyPawOGnPGZS3+fq14dxevncgYpHY=;
        b=QSxZ31vMqZPyeawNGOHHwLl4e88qNVwEZ3i9PPe4URN7RIx+B4NH7NHylClv1LoGZp
         OSQBt1lgf+UAcMoteLaWiAGW6jDk4uBJ3B2kwFl/3fouGDvriSEXQYNJPmVkScMo6VCo
         YE4ogUcWumTUg32GBFQecW1GuDso/AgEvzxwloA78qmDfU23NYAcvgGmq8hJVv2S29YG
         19d2/u0v0C1taghQz4RqrjhVJbFCNiMVRsJ6iFJpMAXeMq//obrga2LLvfUgnrYYDdXV
         9PFZ6xsIMMNTY215FSrdw71/iYZm6r+gatP2Sg/MiYKP2lpwA7NAEnDOOcNNt00BuSGU
         nMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692992557; x=1693597357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApTGyFrrfdw4KCGyPawOGnPGZS3+fq14dxevncgYpHY=;
        b=NW8FhJMDoKoq3WopDnm6Dq2PG4WbgUrXtTs2WDwhgMhQA8yZQDljSFcTHzkwhn5GNt
         89bW09cTM3/B8hQpOiz3ecRMSz+lfvw0jVIkPRLa8Rdxb9t8JDj15HnbHK1miFRIa+O/
         3LTrrn1hAsjrSHjowf+eCjR7/xrzWwz6wdfwBXIKgFzwcZgJpjENfOihLAAoioa3q4bM
         4z3b++ynl2vdqmS+dLB/DO64O8wdZZScz4ghceQhxcslRgV6+MLxcv08QIIIBZflaZch
         kYUfDWBOLIv8yZ9jc0RRHXKG70Ibw8RVfRf0Txue54lIGBG+U25rvcjMT402zoM/fpnK
         MHNw==
X-Gm-Message-State: AOJu0YxwbLrpbQV0i/o69cj9kaOzEYx9SW8t8i3N3ra2cpdzo0hugKcZ
        H0DGEL2cK5AC4VIIQDRnuBM=
X-Google-Smtp-Source: AGHT+IG8X3HXPt4LbR41Ai+BpFfpAUFOECjvlZrKloM8fMcxozZ6I58ZfRSVrkyfXKQfFr1MUmy52A==
X-Received: by 2002:a5d:60d2:0:b0:316:ef5f:7d8f with SMTP id x18-20020a5d60d2000000b00316ef5f7d8fmr13973286wrt.3.1692992557352;
        Fri, 25 Aug 2023 12:42:37 -0700 (PDT)
Received: from [192.168.0.101] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c219400b003fe539b83f2sm6118788wme.42.2023.08.25.12.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 12:42:36 -0700 (PDT)
Message-ID: <736c8159-90e9-4575-3c22-5a62515d5c03@gmail.com>
Date:   Fri, 25 Aug 2023 21:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/16] Staging: rtl8192e: Rename struct rx_ts_record
 references
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230825140847.501113-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 16:08, Tree Davies wrote:
> The goal of this series is to fix checkpatch warning Avoid CamelCase,
> for all references of struct rx_ts_record. In most cases renames the
> references to, ts, to make the naming consistent.
> 
> Thank you in advance to the reviewers,
> ~ Tree
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
