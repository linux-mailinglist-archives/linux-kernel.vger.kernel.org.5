Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748DD7642CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjG0ADC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjG0AC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:02:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A6272A;
        Wed, 26 Jul 2023 17:02:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68336d06620so437451b3a.1;
        Wed, 26 Jul 2023 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416169; x=1691020969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF/zbO8J5jCFWkkfTUlV3SZYG3BARK5otb0ix5VC2cc=;
        b=Fjx3QVVUlzQ2Ro8/dFitccgjryvoqQDcbuyomOXbxAfGnU4NQbaoeR4+UN45wJ3JKX
         9WYUS5Aa0wvaMOqOV4GNVNYr3coawlE00tx2yt4ZUw+u5OkyBqmMSte+kVnPRYIJTOtI
         HHOXyVCDil2h+RPszoHa/SSRIlZ3pezmFy38nkO18v5BH727g46DSdVbaf1673U4rOz2
         doBBoSV8FjV94FC4/7A0gla1bqUBzzqkjlyo7vcw13LJBUdFzZbRVTH/cd7nNjJfDsHk
         d9I79iHGH5HC5mxbt0YYz7i9kqCZQ1cQ0suufgYmDUKHOaoUb8/z62WhXRejMyLP4kOI
         0c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416169; x=1691020969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF/zbO8J5jCFWkkfTUlV3SZYG3BARK5otb0ix5VC2cc=;
        b=jiPQ8iUJXvIvzeRHzNEIFk3FzUO0Hs+sXza1ZwqiF31zYc+OMbr0enp974bT34lkD9
         bDm0J73bvFxjhPq1a4hlJw29RvaOc+yarxGubs+rnd9K4uLk5UH4EDrQCcNqMuc2/Auf
         SKo6Alvd+VGVENhzy4U3dapbtFN0dXUr4iBb7lWyyddxxkn9NmBPutjc6sr6wJsNznwN
         IcVXDC2STO8jy/wQ4mtE0ty0MHpmYYqvMfdQDyVOylEC8WfT97LUFEAxpD3C61Se+5bT
         +DIEJ5x0NyG5v7oFzXIXqoqgGDH9qBgShdgM9bK7R/cNpwkV3FnVqPcQ2+2uQCCiW68h
         Vjxw==
X-Gm-Message-State: ABy/qLbO/VXkDeKSysWlqmfXZSUJmPh7O1RjaT3ZlPoDrM9lVvGuJJoo
        0+n3GX7TgpFU4o9cnAk+XHM=
X-Google-Smtp-Source: APBJJlGQ7HZ0lhbjH/Vo4xT37Es8W6rvUtN5Cs2TMrz/X4BShdvD/LaYRUHeYwf1w842kAco0FafUA==
X-Received: by 2002:a17:90b:2394:b0:262:fe45:860b with SMTP id mr20-20020a17090b239400b00262fe45860bmr3491997pjb.0.1690416168999;
        Wed, 26 Jul 2023 17:02:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ne11-20020a17090b374b00b00268160c6bb8sm126776pjb.31.2023.07.26.17.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:02:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 17:02:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
Message-ID: <c76caf84-55be-4fec-b41c-18e0585bb325@roeck-us.net>
References: <20230725104507.756981058@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:43:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 521 pass: 521 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
