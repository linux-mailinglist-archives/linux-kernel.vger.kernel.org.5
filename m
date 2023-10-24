Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C087D4B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjJXI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjJXI6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:58:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026688E;
        Tue, 24 Oct 2023 01:58:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6291477e87.1;
        Tue, 24 Oct 2023 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137924; x=1698742724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R3ukY78Kprvb6C1LoI+nPL4aI7gxBNbUgQKPAJ7OQLE=;
        b=PuBGW6O9IYQhRIIhFuyRJybpXEJr5+BlBbWank1Bx+rhRaPDjUIea+Z9x9aH2Zunb3
         CHgpL0vg5PYKXgq0HhkooY/Hs0rHocfY/XUc3I9BLGs/WI3z+imT3axqLYLwE+/HXJwX
         6AjDLaunB66b8lL1YzECFEbBjTGkGzsK2dofR5hnmPAIJMLbTCZ7AQhbTvffpIRjY9FQ
         Tf1voUAUVP0spOJ1LHL3agN+GAIY2W91t400yuMrWruMHszx4jXftWGTpPEh01ZNUXLl
         tUjzbkNKUdRUAlE5ikQJ6TblbqwV2RqWIMWdbRHOwUrSfEg2Srx4kF4OX44ORYsO9pkt
         DzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137924; x=1698742724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3ukY78Kprvb6C1LoI+nPL4aI7gxBNbUgQKPAJ7OQLE=;
        b=BZjW3Se3yUaYUZhst/r9xu5UyTNpm3MJqkhf9FD21O8jt9q7yE34FtVK7Rn9vzpict
         bxFthhfvzFW3/K+mwa/gm4H5jwvNAPaukM4in+VqTRD4QRbI/bziP9Vh8B/FFez/l1Wb
         FNmBnym6NTgt6x54aH8Fu6NVuJ49vudNl+yFIMASXOUlvRvry9BEX0Fhblt2IlbRSjFF
         /2ygOx9H/kdbtyFz8hiE3JNej1B4vH3mJR9WqZDbBJCSN8ngACLlNs167rImrxzwtrpO
         DPVfYu6nQqoBlPMKSpO8LRDEOPYVZ4T11lcDu+H6vS/mcI+mWzgddW7AP75gBjV9cmZF
         qlYA==
X-Gm-Message-State: AOJu0Ywh+THBnUvIRyGHaYpaC+BhjR8SbxtnYvehRqwXMRtc/ZjKvDGY
        C8nDF14naqqwI36A35QC0iI=
X-Google-Smtp-Source: AGHT+IGYWqD3rltla/ILn0B3w4VTLRUMK+wO1IisM/F6AuKk6mqaTE2sXgcrkONCvmhwF1KdG+pzzw==
X-Received: by 2002:a05:6512:ac3:b0:4f9:5426:6622 with SMTP id n3-20020a0565120ac300b004f954266622mr10094777lfu.69.1698137923908;
        Tue, 24 Oct 2023 01:58:43 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id t22-20020a05600c41d600b004083996dad8sm15997945wmh.18.2023.10.24.01.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:58:43 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:58:42 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/98] 4.19.297-rc1 review
Message-ID: <ZTeHQl8avxkq5Kfq@debian>
References: <20231023104813.580375891@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 23, 2023 at 12:55:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.297 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no  failure
arm: 115 configs -> no  failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/5351


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

--
Regards
Sudip
