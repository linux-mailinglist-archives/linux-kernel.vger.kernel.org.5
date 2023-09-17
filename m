Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A67A3950
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbjIQTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbjIQTrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:47:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324DBC6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:47:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4046f7d49a9so11667145e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694980026; x=1695584826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7Ov0YCML94M5SspHfxk0f+6nTANT0RMxVpo3riDHPA=;
        b=BLM1GcX4Im8vVvwoQWgYXEC6srX+PKQtA42LomATVUQ82OhqwvMVAAL6Tjg12vLsXH
         moMnrQeJPxHqv/uUeaY85+GyZdRkd83tKUznvQbTgZ8QuSQbWhYorbMWxJlS5Ya2+WgU
         4lgCzDMwkDoy4P2L+xOhS9Wp3Fsqt8EgZG3uf0RCrKkIqyidZSrNWYUAfiUsjeiOAGry
         T08PasFbTwheXCd0j5ORfzAc2SDtWDv3Rxc/cusFhcX6Ldgv9VnOxMSM1WHLSu3dNOJN
         f2UZeW/Fn+hAfmg7ACubvK9t08ZsY7SQm8W2oRN9g3Tc2ePjuML1aNOe+ubi+ekGebr4
         4VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694980026; x=1695584826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7Ov0YCML94M5SspHfxk0f+6nTANT0RMxVpo3riDHPA=;
        b=XYKP6kEzAv9rSnxRDyc1PhDI72QhpK9q7D1MRDzeK88MCkr8HvxbdAkrCz3XVHfaJI
         pIkumm0OfEKDW4xeklb9iXZr5iV1KLwBisULqtaukB0Zo82tclEaCQ/CrgbY5xgXnZ4+
         xfoIk7eRqy5wBwGUjLwiyyC8Tczf7y5Wty9cIfoLiraXqXPuT1m6KG2obcxwudfecNF+
         SeNs/7VpwRHFiTNzkGYxtivpPOHUZO/ij1PXr9R2etSGyGU+VZ1iXxALQdNYq0VAIcTs
         ktgIODrpJsDC7hxvAMGxkjZdhilTIfSLJjsbRaX7KUo617wzvn7NXGfpeNxvMRpOnC9f
         nLpQ==
X-Gm-Message-State: AOJu0Yzz0TlV40tF23O6qwL4/0XUXBAA8ja0+ez8vDBApvZwiWN1B/an
        bcyinlVeRWnRHB5IIwhYqd0MZUg771t6cg==
X-Google-Smtp-Source: AGHT+IFv32MBpFNUGCzF9bXTwkfn0m4zA7NDKplheTDY9YqyARGbaLD6fMPu8kd8xVD9wWBcfxjgSQ==
X-Received: by 2002:a05:600c:5103:b0:401:faf5:85c3 with SMTP id o3-20020a05600c510300b00401faf585c3mr7196291wms.0.1694980026343;
        Sun, 17 Sep 2023 12:47:06 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05600c1e1200b003fef5e76f2csm1949523wmb.0.2023.09.17.12.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 12:47:05 -0700 (PDT)
Message-ID: <9548bc1c-23c9-427f-446e-61f051f14f9c@gmail.com>
Date:   Sun, 17 Sep 2023 21:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] staging: vme_user: Fixed prink formatting issue
Content-Language: en-US
To:     Piro Yang <piroyangg@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2023091756-duct-agile-0023@gregkh>
 <20230917192359.78711-1-piroyangg@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230917192359.78711-1-piroyangg@gmail.com>
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

On 9/17/23 21:23, Piro Yang wrote:
> Fixed issue relating to prink message:
> 	*using __func__ to replace function's name
> 
> Issue found by checkpatch
> 
> Signed-off-by: Piro Yang<piroyangg@gmail.com>
> ---
>   drivers/staging/vme_user/vme.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Hi,

you need in any case a changelog what you changed with the v2 Version.

Your subject is to general. Please consider that the maintainer needs to 
recognize what it is about. So make it more unique.

Bye Philipp
