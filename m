Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA8F777D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjHJQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjHJQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:01:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC330EE;
        Thu, 10 Aug 2023 09:01:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbbbb77b38so7957675ad.3;
        Thu, 10 Aug 2023 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683260; x=1692288060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjTeYbFZbYKPcKF+bargQV6tYusrwZi5lIEU4OMkY/E=;
        b=KPLvINHkZCohYHANmrMub0k7TT3l5/FPsM6iwBKG5HvyGOS6WTV/FVHu/6psIhCePY
         QqpzldZRt7cwhjumPUI24RUeSG5+cfVZGaM2Ysg6+mYlgWNdIeWAInqbbbBcOxwQyx56
         hW0eyNgs8p0V9w0TEvwX1FE3MpCrKwuFghbdRuB4AptyGHynuNSKATWZ06NZi0htCTBQ
         9drUJ4c+IpniniJaOvLm78OPkhT35cidCA8SRLXMSXul/49tP7QlSy27Ag0KjsfjUJ7y
         2N6Zod8MRww1OUE6qS4HzN/Eam/+pEunmP2SvUv8XanNDRcKn+/RkzVM8jZI8zdYfs6q
         weYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683260; x=1692288060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjTeYbFZbYKPcKF+bargQV6tYusrwZi5lIEU4OMkY/E=;
        b=lrJA4xSIWqxoBKGQcJMKMyyVkDbyS5y06N/dPgyMtPm+oxsl4UkhFTUtZNXaibRaG5
         cXN4apQnfVeNNQhGVIUHk52kI1qCwE0ef0/UgavBLHYaPCvW7tNKaL/MY5sw9xYUzhYD
         JutjnG+rV9lm5nQe/ffff66+F8jH02ytjJD92W1D4+jqW68nN7nr/928g5wZNEDlhUXF
         hkIlYcqnbLz4knda9F6PZSgLPijq6YHwHTbfHqHVhvpsk2FTLrvTe2AIj/ljMvU+X6gO
         BIKbXiiptndJ4imeVfKW/WY1cLgA9dBjrDs7b5g82SVEnzuTsy7YvTv9hLpq6mCiwlui
         1KIA==
X-Gm-Message-State: AOJu0YxL2Z6xiKUsOzNVzxe4JJJJ/PIJzeuoHSzliBusI6NPqtEpXOYA
        wpGajn1HaiwxSR2kKnATW+M=
X-Google-Smtp-Source: AGHT+IGeIrtOYyWloO8eecZ9t1WCp/6HVPRvaBU7e4/G1prfV5kAHCCDzYkysAJV2BvAAYI/QzxJKA==
X-Received: by 2002:a17:903:1112:b0:1bb:a367:a70 with SMTP id n18-20020a170903111200b001bba3670a70mr2664565plh.17.1691683259835;
        Thu, 10 Aug 2023 09:00:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b001b53be3d942sm1941107pls.232.2023.08.10.09.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:00:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:00:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
Message-ID: <4426cb20-3165-4e9a-9309-14b376e9f61f@roeck-us.net>
References: <20230809103658.104386911@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
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

On Wed, Aug 09, 2023 at 12:37:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.291 release.
> There are 323 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 147 fail: 2
Failed builds:
	sparc64:allnoconfig
	sparc64:tinyconfig
Qemu test results:
	total: 432 pass: 430 fail: 2
Failed tests:
	sparc64:sun4u:nodebug:nosmp:ata:net,e1000:hd
	sparc64:sun4v:nodebug:nosmp:ata:net,pcnet:hd

Errors as already reported for v4.14.y, here introduced with 4.19.290.

Guenter
