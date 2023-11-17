Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0107EEBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbjKQEYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKQEY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:24:28 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D8130;
        Thu, 16 Nov 2023 20:24:25 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586ba7cdb6bso777921eaf.2;
        Thu, 16 Nov 2023 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700195064; x=1700799864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFveOmJik6YY9ZRLOk+sCI/MXeTb5qg3AWh1DG6limk=;
        b=bV39K6F7/90W5RtDYDMI0s/dAve9bd+gfXOR/gm7U4jYCDLsO9Iqhe+HsIPI43nKqY
         o0tJCGDzGpBhLr0LOdjIthuDFvs7L3jCVKjaEXeaK6Hl4S/rC+lMDBD8BbwOWq7jmOZ6
         IQgF3e7TMcz4XRlJb6Qpg9PW/D5CSjlvHI7RH0lXtnlr7cLNmqSkhXrl3RNUecnwbnH/
         9jEOzqfvsJqujwTBgIQk9oCN0nC+SyqQv72Fu9uH6341NISSMdLdAfPBzrspgPEoASjB
         ZFNCztR21rYgAoZMQHrk5DCE4YeHs9yJFquw0DtZTohcXA5tCLkMOBa1NHS8AxuzxAh+
         wF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700195064; x=1700799864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFveOmJik6YY9ZRLOk+sCI/MXeTb5qg3AWh1DG6limk=;
        b=RiD366ueOiXD7G3P8KVc3lzQexL7RiuVFp1+UNOgllm3i6851UZwo0RqXtb8OHmOri
         DwGpQHoV00SbYR9FO14t7cysJEH6a/7RV75LzJ/mUE8UZSBITQKWY0IcByYglFB+va1q
         OkJDMjIjkUytlU/IUttNmBQvrRBGm+ZbR3O/X1Cj2jjH49fPuwouHSQ0ipqqeY5qKCOB
         t8ikmZtm+FJt9n2SBOfKOgSZSEm+5bNS11j9PPT4XrItwkBshSjk0Uhl6fE6LLHjSS+X
         CR27oBeHJ6oogMpY8Fng7bOZqXqLW5d7zNmmV2LcvclFI6A4aMVyCrLp5lPt7VTPdhjB
         4gtw==
X-Gm-Message-State: AOJu0YwvmYEkclpspa5GbwCYUso7LjiacVcThTCuGZYca4AZfHzlVIhv
        CYE94kiITZzYodV5Zh5ZyNQ=
X-Google-Smtp-Source: AGHT+IHuVn9VaCdTI1zb9XGaQfyybHaDC7kpyPSoItyKNID0FO3pFfC9O9Kc0l9ykmhdn7DC3EIOXw==
X-Received: by 2002:a05:6820:2c04:b0:58a:67b5:2df2 with SMTP id dw4-20020a0568202c0400b0058a67b52df2mr12344585oob.8.1700195064516;
        Thu, 16 Nov 2023 20:24:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u38-20020a4a8c29000000b005840989d13bsm169967ooj.44.2023.11.16.20.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 20:24:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 20:24:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/88] 4.19.299-rc1 review
Message-ID: <906a58e1-ca7e-47ce-80ae-c6586156224d@roeck-us.net>
References: <20231115191426.221330369@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
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

On Wed, Nov 15, 2023 at 03:35:12PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.299 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
