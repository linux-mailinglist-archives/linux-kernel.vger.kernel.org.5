Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0878D1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbjH3CDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241658AbjH3CCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:02:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6A1A6;
        Tue, 29 Aug 2023 19:02:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso163256339f.3;
        Tue, 29 Aug 2023 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693360967; x=1693965767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HdvKkJi2c+ExbelovmbW80s8E7flt09p5Cj4ccXEHs=;
        b=gbu3ftSbCqrssLv2fiOxQ0F8z8G669vcG8OeBkSxlY5rJVPWyT/6CwYteAMzwCx25l
         uk27GOITIxCXkwwC0+vg5FtVfJ2YRyf9Z5CdvAc93T5xH/OTa2+tTI4yHnGY0jtvPQSd
         QsCCJuSCED59amjwIPH8htxlAglfp2fr2bLjiSIfa4/AMA6IWou782gBjaxKihG7zd0L
         JhTHowsv0PsDgROc/uFOB/M8FtbLV4rv/K1HnCDvHActOtjgYxbzPqSpUUKJFsbZTIST
         /9o5JzBFxEofRfKhuZbFWHjlXY8iazozlPHSjLeV8dzYxWIdzPwpkfr4fw6TWP6TnbBI
         zDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693360967; x=1693965767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HdvKkJi2c+ExbelovmbW80s8E7flt09p5Cj4ccXEHs=;
        b=HloRGDfqjgkNbWjy77E4os7RTJ9b9iFGWMG7g/fTdU2sEfw1i52/WlGEXF6kMhkOEO
         nP4KTvbKTVryOR+Cp2uaUoGM9y9/DbTfm+vnFreswtGeQ6ln6acaCSmQ1Emkr9rLZYkb
         EwP/VNn6RPGVxFSV/9B+xUyF3mTY4TZTKzOeB95TawY/tQCschpS5sR+yvR38+jhGzQc
         JuTawFujz3976RRrkclwjOF56bLiDvwPm2Vd9lkTG3RYNPX3P8eEpzjn3/jFdymealQU
         +pue7PLYFzV2gEfKWtaGboVZzUGcid4ly3z09tO/zAX0LXxC/JCQKDRx8npf1NSGHCCZ
         VSXg==
X-Gm-Message-State: AOJu0YzTbQyTKaeTQTeaf2uMhvSi3Wv9JWuao3qjZPJxoeKoSRi940JN
        8AXjc92PgD8TlgHBGsEXdqg=
X-Google-Smtp-Source: AGHT+IFqJsjo83gpaGlXAPmitQ8p6dvFtGBhgUqFDq40D+IDv6LtTjNczlr6RzeXm0LhlXaxVEbIsQ==
X-Received: by 2002:a5e:c91a:0:b0:783:7275:9c47 with SMTP id z26-20020a5ec91a000000b0078372759c47mr1134770iol.7.1693360967114;
        Tue, 29 Aug 2023 19:02:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14-20020a6b580e000000b007951e14b951sm160847iob.25.2023.08.29.19.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:02:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:02:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Message-ID: <014b04d5-8b2d-4ffb-9460-69b0ad166f24@roeck-us.net>
References: <20230828101149.146126827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:13:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 157 fail: 2
Failed builds:
	mips:mtx1_defconfig
	mips:db1xxx_defconfig
Qemu test results:
	total: 487 pass: 487 fail: 0

Same mips build failures as with other branches. Not new so

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
