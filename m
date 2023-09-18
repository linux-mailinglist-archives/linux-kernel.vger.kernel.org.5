Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451197A5231
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIRSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:41:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC510E;
        Mon, 18 Sep 2023 11:41:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7927f241772so184148739f.1;
        Mon, 18 Sep 2023 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062470; x=1695667270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHf7C3g5Ru14BLQybOQab8WEpLIhmpUsAJ8vZdaELdQ=;
        b=fQ3s/mZQXwpaYXeR8jvYv0tU5aaGm9ektpEKXr98zvHzxDc58IHU+hKZqTESw3ntfW
         /KjX1/OrvmJYKjon8yIs16qfINI5Z2fMBCzRb0cJZBfqxiVsKGMmyvmY2wY2P4YlSgiE
         sXCLSEOkGoTgutSqoaDtD64aGgUe5XErugtUcjxOyCSL2c9KOrYaxAQ63et8XwTYUvgM
         jzmXR20TXORRV5dJ6q3ZbFV7YTuI5nvqp1tWE/fnevaCZibh1h0VHckdkSHJ6d8d8iJa
         sz4uPobGtOZNYVScsaPCzvD2uGfGw5K33ic1OyMXSYxDxBSzGx/ky/8S6Lc+/DB9OHHB
         TGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062470; x=1695667270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHf7C3g5Ru14BLQybOQab8WEpLIhmpUsAJ8vZdaELdQ=;
        b=diAWWeEFLMaljiXVOlTiVXBBVYqFWai+DN8l+zS6ouY1LTrJ7DIeOEeIMZzEkPmY2i
         CAqRiWqGvjjAQohdaK4Xpcq8TguK6sOXbpAFiRtw6XLCCdIuthw8mUB2YMWUPxlSJYJn
         C5HxVlebpi+Qj03W3a2OUUyClB5lcwIPAHZpe3cXNKEz+gaaTQFpxgTASsvm3tFm6hD/
         Wc+2se/XnRNrAy7BGdstEuCnUB5VXhdkphitnaLWLvGvPD1wGgiD99TOiBsXBVJ0Vd4L
         LCkYg8rJrgBxH6kyn2tRulJGXRzPUv3VfHS78MKKvvFsdOiP1S9jvP5tjk3Bd/XkxEaB
         mvxQ==
X-Gm-Message-State: AOJu0YxuwHRzfjNIHmFXPfp86/SK22FV40QK7N0lR764LD39xeIqvuUZ
        GJRqpJzqXbO88LIm8SLXpAg=
X-Google-Smtp-Source: AGHT+IEpQi1feiT+ktLgTJB4Huw1lHvDtABdARzfcIpbiSt+Hy6XGdb+ES05FTX/8BrOp1DJMQgpkQ==
X-Received: by 2002:a05:6602:2575:b0:792:4994:d1bf with SMTP id dj21-20020a056602257500b007924994d1bfmr10913079iob.9.1695062470073;
        Mon, 18 Sep 2023 11:41:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o20-20020a056638125400b0042b451aa95esm2900351jas.150.2023.09.18.11.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:41:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 11:41:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
Message-ID: <1a2c2cd3-db72-41d8-bc52-4ea4293d68a6@roeck-us.net>
References: <20230917191040.964416434@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 09:12:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
