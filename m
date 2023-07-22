Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204775DE91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGVUj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVUj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:39:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F01708;
        Sat, 22 Jul 2023 13:39:56 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34884a8f285so16961395ab.0;
        Sat, 22 Jul 2023 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690058396; x=1690663196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sheU/pN73man5/rqxD6wz8PZXz+NHmbMVYqD6and/RA=;
        b=TwmodeBddlMtX5sAq9tJazwTjv9UEdk8GqnWgSR95BB8aIu2J2k5STrz8OGCU75EpP
         Zsj9UdJaP37rJjmsL/mJF3fWvBqaQwm+CTNmGx4ZFaP14H72Qb4a4Ksu7Yq/+umZP4T7
         1koH93do9Cu9t9ppHo40UVObdsu2NF4hwE2jAbAv+ZtyTXNHi2TL9/yfjSTPCwoXMxLO
         ZZt/VGBAUTyGbIaOA4j7pNY7wIvIDlmHZ8qZ7eeehktI2r+7BBCtwlYAo9ZgUfT7aYKO
         r87qWcO57fYmUgY+g7nPQQyxl80GYv5mLQDG5jVxj4pPU8S/Ycjdy+EcdWtxlYguZu98
         ALMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690058396; x=1690663196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sheU/pN73man5/rqxD6wz8PZXz+NHmbMVYqD6and/RA=;
        b=GOYIbt/K4Cj49TtFIywOxRpE1bN2/qilaC2IEPzBxHqgq071nLS9gEBvVyXFU6ormU
         OCxrPC+AhIH2wD3K+DQF25r6DlgzWli8VqLfx7PFjgtjJsitZ+zOtV77IZXJmDaVOWBJ
         pAjNnoEykUTcuEcBrN1wTlvHRHpCjHAO2sp7nqlXN7wULjjIODc+lBUVoT3rlnHD4IVo
         cPAWnf1UuQzfZfdN+uBo5l4AKIm5DpkTmPjnnK2TErNkjdYLIHUhZsNz2zR0pfCEB/07
         VR+86xJlHPLm2/XEqNkobXxYOkplX88RV6arIeiaNotpZGsk3K0AnQgcOc84vue1rdpw
         VM/A==
X-Gm-Message-State: ABy/qLbuzTpqG7H9k1WFwoATlad9B1hZdh8lq5sevy3luR6942gmItN/
        Y5ZtDX0usfBouxvMhbwhW3c=
X-Google-Smtp-Source: APBJJlEnLGewhEaGoGk+H8xEsKCQEYSwxvo94/nG7Z4zmYJS0sHzwrkhPKC/JJ8j1/Ud3VyNZZoxRA==
X-Received: by 2002:a05:6e02:118b:b0:348:a412:b1e2 with SMTP id y11-20020a056e02118b00b00348a412b1e2mr3973542ili.14.1690058395938;
        Sat, 22 Jul 2023 13:39:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14-20020a92d24e000000b003424b3d6d37sm148021ilg.24.2023.07.22.13.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 13:39:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 22 Jul 2023 13:39:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/532] 5.15.121-rc1 review
Message-ID: <b07a1b7f-8c54-4e9a-8b35-28fd2b12eb75@roeck-us.net>
References: <20230721160614.695323302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:58:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.121 release.
> There are 532 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 502 pass: 502 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
