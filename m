Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514677CB170
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJPRfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:35:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1891B9F;
        Mon, 16 Oct 2023 10:35:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso2417093b3a.2;
        Mon, 16 Oct 2023 10:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477747; x=1698082547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxbgDYhtDgITZXcaVMlQEJg0tyXIrJSXCkcrtC+pdlM=;
        b=g54r1MxOVhr+4hLe0r9GdAilmGKdHcQ4S3ttlNIzthELDfCBSBTG7Zj6uGjU/GKk6t
         WYiRPrzoDHo/0NqRVOFVHZNJoMG7uz9zKDlrtrExA+Eat9gwt4a+MWyAoRebOtejYBO7
         fBV59TGnmpPaXm4WWVMWlPbHKf82m8+bOF60E+rH3IEs8htlGORU+XzQwL91rsP/IS51
         g39u4UgBTsfUh3vVFwEBwcEuw5BjKYTh8MXNAX9p18P7pGv7zn4qM/+YDaMXY0YZZGKe
         Yj7WeFFviNuIbbCrYosSanGb9YDTP4CHlzMUoTXkxYo9eZw/H6W4MP5FyAwBcNP9IOH3
         VB/g==
X-Gm-Message-State: AOJu0Yx2e/9AxsS87aGCDh8jvV9fLxwlT3rcOY5WGnqmVbHkgF0GhaZp
        2t0dvhchEoi4ZwnFGauzIzE=
X-Google-Smtp-Source: AGHT+IEKwkdlXXxhYgZUG8hGzqwkJmCj3u8lxRpl1+XwIhIGdC9RC10aO3ERdMN3SiHX5UrAtNGo3Q==
X-Received: by 2002:a05:6a20:4292:b0:16b:c9f2:b632 with SMTP id o18-20020a056a20429200b0016bc9f2b632mr31634664pzj.62.1697477747394;
        Mon, 16 Oct 2023 10:35:47 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001bd28b9c3ddsm8707518plf.299.2023.10.16.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:35:46 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:35:36 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697477741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxbgDYhtDgITZXcaVMlQEJg0tyXIrJSXCkcrtC+pdlM=;
        b=BMGguLUbaFpQ+At5H1FJmkE4yn747MAR0ZlZyC+GcQeITFo1MFMTcKLZnhipyalZIXyvng
        hNgp+Q7lubjP931Jj3atQZ2iEnm0HeRXgdiS2j9HdR+RmdbjIHCXlNYadCMFekOnuN4MA9
        /Dv34nnmeV9PqNbrlq460QdUppMSdAZOKTzx2tJv+mIZxQeRldIJEhq9G0OV/PohHX8NFO
        lWFe+Wq9Tm5eyC/BEN8+vOywY6E4yAV75XZ0cwb/DUjuytlkqHh8xiot1uJ7Yv6lVOk6q3
        60Q7GvTJcxDoptchqmN2ak/QZJ7BfhIZEZ0R2jJrczXUYH80Z0bthvVmPh9ueQ==
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
Subject: Re: [PATCH 6.5 000/191] 6.5.8-rc1 review
Message-ID: <77pfg3wnxbtww4sgxm3fcc27nuxjuwbxiptav5nshfjoqntwrq@7rkpslvwqupc>
References: <20231016084015.400031271@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/16 10:39AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:48 +0000.
> Anything received after that time might be too late.

No regressions or build warnings on my system.

[    0.000000] Linux version 6.5.8-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (15), GNU ld (GNU Binutils for Debian) 2.41) #2 SMP PREEMPT_DYNAMIC Mon Oct 16 14:24:07 -03 2023


Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!
