Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6E7D3E70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjJWSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:00:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449F0B4;
        Mon, 23 Oct 2023 11:00:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9e95aa02dso25839985ad.0;
        Mon, 23 Oct 2023 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084001; x=1698688801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=if1LMXlv0NhauuH28lMDtOeb3mWnKzXBZm74izG4Zeg=;
        b=NaqIhgGUqZX7XhszXcHTH+UdSsN4w3EdTCGGrVWYIOrH0RsJoEYstRBOuYHynuAzSU
         CtwXWkT45L88gCcZMUOe1NDmLExLnMOAiFk7ke8NFEWKeBUJukAIc+23kM33gPs+YGiZ
         aIqh7WKJFwo31PDmp5y61uB33xS0P88GUv9cNxixiK96VJ4ZbW68zRNfSxf73vZn1HN4
         FpWNyb8UkqIWYxRc4O3L26EBE9udt04/Llo6hZ4UNxqetb1ZWnlbhJUx9lzDEmt/kxkj
         nuUyc4TCX/MVnk2dVa+ZZuUITw5BhQHlRKwrwigme+hUJdmrDfGTUsc6gFkQvXUpPWWm
         hk5w==
X-Gm-Message-State: AOJu0YwNU24+7VJuY63w/MsLJM5Gsgm9kimfN7uWKOPuFPnCKtz0R3/y
        l1GL4/Rk948voBrd16vs4r0=
X-Google-Smtp-Source: AGHT+IFPsJVzfo/OsLom/DGay5ElN50D6Mg9r1ORsvr+E5Vaiqj5Mg4VAHv4nQ81x5tqmsYnXxHHvQ==
X-Received: by 2002:a17:903:6cc:b0:1c3:868f:5958 with SMTP id kj12-20020a17090306cc00b001c3868f5958mr13544298plb.20.1698084000520;
        Mon, 23 Oct 2023 11:00:00 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001b8b45b177esm6155629plb.274.2023.10.23.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:59:59 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:59:50 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1698083995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=if1LMXlv0NhauuH28lMDtOeb3mWnKzXBZm74izG4Zeg=;
        b=gTtBmBYKRR0gMuSKRaMDRVG8fsRnt3LpbRHsD9gI/89/og95qXEOq0fm0TStsg2vgEaiaV
        gTo8yAfMW7yPDIJ1uo5jGHSSkyk0S1uOW1BtTiiempUVIKgmcQx4DrNxYba2Cyt4XbvGbk
        HwX2dUvlcsKWWNQsLg2kiSc1t9AJQGEfPQKa74628fcIIZusdFJSlCwwPrFBNWHdFcyfYc
        hhz+DzfKxkLej9C+i8aP+4Yz5i2T6fT9Oe4fhIGtrBkpyJW2d86ScWYkr6Miv16WLvkKCG
        WfpYAoxgIyK2q8sS2CDQh4nI6Jm8R2InkOUr3Km2YV1kpF/QxeGi0L9VcRsO0g==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Message-ID: <oeyc3waqchvvqlc5adqr73gqcz3tbvygq7lwtthccrvo6glhpp@bribwsnfv4rm>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/23 12:53PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

No build and dmesg warnings, my system runs fine:

[    0.000000] Linux version 6.5.9-rc1+ (rbmarliere@debian) (gcc (Debian 13.2.0-4) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #9 SMP PREEMPT_DYNAMIC Mon Oct 23 11:50:20 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
