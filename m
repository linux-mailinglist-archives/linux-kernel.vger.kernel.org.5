Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FFC78FAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348447AbjIAJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbjIAJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:28:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA510D7;
        Fri,  1 Sep 2023 02:28:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso18502305e9.0;
        Fri, 01 Sep 2023 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560492; x=1694165292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=921PCazgPbPvMm6h5EIxZTtPV/S3F9LCWQZ9BR5vflQ=;
        b=mMkJywTtrrdOzuM1XXcSFDh6ElIHYWiihSJoWAXfXfS7+o07NvqW7QfoNedtq3Mgg7
         J5Dzp2JbzLnPqgUEKOPjrtjXlnYEQ9nUrpONXHnUOYWzyYo6MeEmpnSkH9N0yaG7Tx1a
         bvT3PEtuGvhOE+CcOSUYXCJOJMd0x21i1mqjWKOtRywp3YyOS7LdLzaz20wKnlOl8eKL
         OhWgyV06wEvn1jOm5biuDAN9PqbazQP5AOXNRtoXU6M/g9UrRKJ4zMiCSgwx+V4gunld
         GIlYbodc82TFaMEgi8L9VHAudU6LP5qgjNpAEhKeLqwDS42V4gXJpFVL6RxKdOlYUjPG
         GThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560492; x=1694165292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=921PCazgPbPvMm6h5EIxZTtPV/S3F9LCWQZ9BR5vflQ=;
        b=kZgemb2PutwLYDQN/7hc5gRTcxS3cK9cpjhcm4h9ZO3xqvDvnFkLHXgUZAMq4BYL4n
         Tk5k32t/fg6W39fyqVd7zEuSLjyZmJM6LQajfupQR48nFn6s35hWJN9R+YOe9NBpugYV
         72E6HMpuOh20alEE7DLDxD3TBwixFJDiANJA1UBut0SwQFjjtSeigwX3K0zNVDw9PYOe
         QhyIa1jKXZTqNut6/XWiswnJ55CIH+4dpBbIuKG+PJmo837rqIW9OUe6MfYEBw/tfUsA
         C9vkzddFDfh9RBCON1/3O9RMSAThu7xO33hgjrYUoXBujDIKBhxy9T0UcaUSM5C54dH8
         F4Jg==
X-Gm-Message-State: AOJu0YyzKIWNsqNyZLFsDC62qYGXqRxwPn5Wy4qPm/nVp8zEb+KFJXFL
        uRGlxXsI6aVQ3OEQ7bff1f8=
X-Google-Smtp-Source: AGHT+IEc6rJeSSYPDFUfT5rGECkv/1fyu+f2+VIOpvD+PXwRc7Z6zMw8NZ50pxUPaCFo3NWbJdWPhg==
X-Received: by 2002:a05:600c:5109:b0:3fe:d589:ed78 with SMTP id o9-20020a05600c510900b003fed589ed78mr3278661wms.20.1693560491666;
        Fri, 01 Sep 2023 02:28:11 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b003fee6f027c7sm7369556wmr.19.2023.09.01.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:28:11 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:28:09 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
Message-ID: <ZPGuqeR3zQqoQbyI@debian>
References: <20230831110830.455765526@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 31, 2023 at 01:09:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230829):
mips: 63 configs -> no failure
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/4881
[2]. https://openqa.qa.codethink.co.uk/tests/4902


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
