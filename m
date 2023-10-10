Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2337C0349
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjJJSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjJJSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:19:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC40B9;
        Tue, 10 Oct 2023 11:19:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c87a85332bso49635385ad.2;
        Tue, 10 Oct 2023 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961980; x=1697566780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVup/I8HGkRjJMex/HjbVAuSvuvoEQIVY8MSOxC2piI=;
        b=MfOpGrK0kvH8vYCxhmB36FsW3sJXdQfoWKkPzDqnEKVv937ocXg3U7j4lo0k1/gMOr
         y67H0U6ZZfqTWrNqQgaGWa38OMcyj/xJ7sQP4GI+YwMcE/N9UClVoXLl9NzJ2NOChNU1
         qDO2Rc2N/R8YcnZPGXxuKzDJb1gxZqNAnnQRJRJ1KkpBnDGByPkznNy+qnpoctUVLwi/
         cQfeGx8oguhmmWYNydh+OTGyZnLpcwOgx+UUsucX1FNZ0SQpacb5KYB+67gYUGEZYzcW
         Xub4X9mB0M6p8ptcBBKBJJ8DOPOTmWtdUZYa7/0FncbKuehNhYt+xCVggXLj6d6VqXQ/
         taYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961980; x=1697566780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVup/I8HGkRjJMex/HjbVAuSvuvoEQIVY8MSOxC2piI=;
        b=kUOcae8X9wDGaypmExhr9f++doAuxAM3pRkgAUPOtM0gJT9woRHmxu2wtlm5Zsmt5+
         /dNvAsG36OB/tS5cr9Q7172Ne51ltFdedB87htCFDx0OAXnW9DnvUXgOOHsfJhVueAo7
         63z7t5a2qC7GngDXleMms3ze+Fv8uXpxCeGM922vGndRw7S7caxFHA1cUtDOUgp4FwF6
         46eT16l8Z/95QChJmSeGNGRQ4TMUSmAP0b2ZayqlxafzFc5mcpWLpQ3ek3CGkzLJwC6b
         /gt/+Qa0xpA746rPA536d9qnr1uiPBhhO6IOgj5eyWA2PIs8QMCC1z+9PnADfYncLXS5
         AigA==
X-Gm-Message-State: AOJu0YxStiCN6M4r/0+7S4wyVYCnaYF05nEWKuYvr8WRNE69OxkGsscQ
        srN8jT27uomYKJZbUPyKZcQ=
X-Google-Smtp-Source: AGHT+IEt7h9zLR9p5Auap+Z0WvhSVJdUH6h2nUn2eT5FcqT6CUOLqVXFyw3IqM1U9k6LgC2LGVi53w==
X-Received: by 2002:a17:903:110d:b0:1c6:17a4:afae with SMTP id n13-20020a170903110d00b001c617a4afaemr24114475plh.4.1696961979692;
        Tue, 10 Oct 2023 11:19:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902ee4500b001bc18e579aesm493990plo.101.2023.10.10.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:19:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:19:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <3da68535-2b87-4901-9efe-31481a97922f@roeck-us.net>
References: <20231009130122.946357448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 02:59:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
