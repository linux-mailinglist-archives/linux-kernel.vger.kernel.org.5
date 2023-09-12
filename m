Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D231079CAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjILI6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjILI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:58:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3235AA;
        Tue, 12 Sep 2023 01:58:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so5359218f8f.0;
        Tue, 12 Sep 2023 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694509117; x=1695113917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqgrnIE/Nleiv5H2zORysEJ88F6QQ39FuzEgmdDH2Mw=;
        b=WhKO+PbAFZe3NbQ+BXIqm/nI9xeHGlSjonr/JxZl8g/EqzwmeSVnjjstMPGU0mneX9
         816UMXTvHPHbNsRMzUeceacZLP4F7JP5ewM6SrqRyECvLsfxTSivxqq6H6ixdBnG6nQw
         yRbzsOKQ+HuVIs+czy80Ae1HQr6GFSPMbMVD8nG2cvTmH21jw9jt97gwb/coyPkgT4gB
         +Ow0SU9oltqIgQiI+P7SknqaLiXsq7TNfIeLA5qDe1qPq0s65kRY3mlLxNXhuja+Po4I
         JXn+972yUsdXuIV5nQ3lEN5/GGcttEG5noHDaoCYIJmCXzlFcssXsrSQQwo4LzPrIqKD
         yasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509117; x=1695113917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqgrnIE/Nleiv5H2zORysEJ88F6QQ39FuzEgmdDH2Mw=;
        b=knBvRs/5ozkkRUvGCbDMoHcPCtjlfyjw5Ee0X1hBXt9mCzrrR8lD/xb6R9ChmQg1/7
         dnvVfViKHY7u0G7bub1YwPy+jEmFVVu44Rz31uQ9YfOf7bwxpmZQufx67BzJ0hhWR910
         6I0HZsdUXRuBgczTRb2IHRRWDw6c5rltZxOv7VGpWKC6PHvpS4qKHMSIVPIuGinYKfbC
         7+UbvqKiOOwSN/XlBqJTlkNzyzn+C8G9HbmGZwL45HR0I/S33TYzdgah8/ahf9lsKfZS
         mh6kMMQ5crAhKkDoIlOe9u3C9AKBjgsT0l1RteGEXCQZXngx/LlaCs5r9Thc5Eu2gQAx
         vKow==
X-Gm-Message-State: AOJu0Yz11N1QusBJOd35pZRyD9xLtUhFXgePIfbLkrGsCBnjJhrHBnTr
        Nu7j3rfu3elr/EhnES3JgmA=
X-Google-Smtp-Source: AGHT+IG1E3JmKEJWylxvVmRipV3cHZc6eCG3bX4xM89DOWLXXJcx0EYwaTGkXBUJ5VWqopy3YCxO/g==
X-Received: by 2002:a5d:6510:0:b0:317:ec04:ee0c with SMTP id x16-20020a5d6510000000b00317ec04ee0cmr10090043wru.47.1694509116834;
        Tue, 12 Sep 2023 01:58:36 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d456c000000b00317afc7949csm12315234wrc.50.2023.09.12.01.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:58:36 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:58:34 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
Message-ID: <ZQAoOpFsahI9Mt6H@debian>
References: <20230911134650.286315610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Sep 11, 2023 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 13.2.1 20230827):
mips: 52 configs -> no failure
arm: 70 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/5002
[2]. https://openqa.qa.codethink.co.uk/tests/5004
[3]. https://openqa.qa.codethink.co.uk/tests/5003

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
