Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10B8777D20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjHJQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjHJQCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:02:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA493583;
        Thu, 10 Aug 2023 09:01:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb84194bf3so7794725ad.3;
        Thu, 10 Aug 2023 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683313; x=1692288113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhjuD6PDjoSNGzVq78DxrvehUxJ8DgFa3UmyJqzoZdE=;
        b=LN/cYZnL8rp6wXOHeEVceyyQBN/xuaEcnUwG5tbVeLPojeY2bkgoLBFGs3gLlbDeQD
         GVI2lY7piPQh/D68vi3otlqLW2nb1uaKRZqvk71PnvA6GZq4noJXrugYfM+6jg9zOi9o
         UQcCFYiHXpjtx/LuHI92QxTz8eVcCmcwHIB4JS+7UdQagDgtuOPMcMO+TEQUfsboqA5D
         ggt9QqLAIL/+o0gE+1QEGxnIKRt8oWQAu1nGsExmmE1vcqPdjR+GQi7xQ/61MzS/NJ/H
         oYMJpqFgnmQdZI68+A4YJPzF0vxS/k0GxWduKPGkrb3HS+mEQM8DYd0xJls4E7y5JXMh
         Ed2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683313; x=1692288113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhjuD6PDjoSNGzVq78DxrvehUxJ8DgFa3UmyJqzoZdE=;
        b=AZHhqQfbogKe8PMnI40kiNqnt5RQWXtma/WTr5kgqf2qEFKbeoO95ZyQrWgquwv11p
         FTiSp44n+QndeQ/zCZd19yZtGKmIHe3e0u8qsK7ixHHlpkbenWywJHebkE1EUvKKKNik
         HDQyq0VwYdOguQZXnn3PHSTWXMY7O2O3qW2WR/dhncJjIqmFicqS7QJZNuo4BwdnZ4jb
         BWCkwTu2+3pwcP5DHrNA0q8Q2kxpSNIZVy3bAqIXUrpkRdLkSgDxJAw4NuH0f4nrowBV
         m2bAv8hSRjk7ME6CaUNkIBg8coa8apy8ek95cWsnSlMg2CXs+cyNpou7yeeBrDsnqy2z
         XrlQ==
X-Gm-Message-State: AOJu0Yx8mY1I/iOyLshvC7Z4/WVMh19/IWgWEmzQ0XScZgGo6Klvh6NN
        RoFLzeetEPW4pw81wgF1asE=
X-Google-Smtp-Source: AGHT+IE2ek/IiJoLaXZLOGdw3nxB0aCc9vcJRnw0VWViYoqivOShB+S8bs3K1r5NaAkCSl6qMtLQ3w==
X-Received: by 2002:a17:902:f551:b0:1b0:3df7:5992 with SMTP id h17-20020a170902f55100b001b03df75992mr3100749plf.32.1691683312756;
        Thu, 10 Aug 2023 09:01:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001bc35b14c99sm1938878plr.212.2023.08.10.09.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:01:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:01:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/201] 5.10.190-rc1 review
Message-ID: <b12740bb-0969-4b07-a777-ba79f7b04121@roeck-us.net>
References: <20230809103643.799166053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
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

On Wed, Aug 09, 2023 at 12:40:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.190 release.  There
> are 201 patches in this series, all will be posted as a response to this one.
> If anyone has any issues with these being applied, please let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.  Anything
> received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 487 pass: 487 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
