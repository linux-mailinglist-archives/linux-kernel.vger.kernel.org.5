Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F078C35F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjH2LgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjH2Lf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:35:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409CB109;
        Tue, 29 Aug 2023 04:35:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c615eb6feso3534227f8f.3;
        Tue, 29 Aug 2023 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693308952; x=1693913752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWhAtL2TKAqZhNqTfWPeRd6vPLlQaIg+ZlfW16RbgSE=;
        b=ZFXXSDF09zrHP4TQEdm1z/2f8J0GVa8l/tVn62bcGmv3gQzX8LR37g5UjPuwxAVoEu
         oTOrMiCH/Lc/RuzNtxFNIxaxFI/QIoZl+MngjhtTgtB68D7EKRFMYxIy7c9gv5u6J1GA
         gJz98LIbcQoDA3eu+2zmMuCZoi5RqlTFAhNgxPIVQkQoAvA04BfesckW1HlpKHDWXXjf
         wQri5WErEfU/wKrjIzr38oizGUPW8wTdUub05pcfC/CV4UDmz7d1mXEwGI1Rq7EkSuxZ
         BCA4MDuaDTzvohVb339hjbhVTUpT6opZDhk3v6OMZulymwgaP/w+nI9OE4v0B/PcP78P
         qcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693308952; x=1693913752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWhAtL2TKAqZhNqTfWPeRd6vPLlQaIg+ZlfW16RbgSE=;
        b=JXghfDdJ7bUH8HpsVSxmNm4eJ/+fOGmnuB+YHBK9C1IyVttnNcsLnXBAAK0oFqyftB
         5Mz5w+8sMFAcDKqsJWPaz1AmrRQ7p5bgEejwKKyI8xj8kXQWD1GQVzZUqFs4EkdjqXRP
         iEKIPeXufCS8v6n9VtZhhpyVbdDljbze9B+gRVtTikZG0315gXsgnBkfz1vRaGG5Lu+i
         LBCI0uM98FCKlcWePde3K2d4lk6e1D96mQsSfd8ZwUwk/uaxOQF9NxXoph4n7lG/WRNV
         Kvi0s7ah+Kc0liqmNgXBimrTby7cbjkJWHmp5y0DgTQKAUG7v3c3jOmgKcv/p0T2jCR0
         ko4w==
X-Gm-Message-State: AOJu0YzsFxCHwOyv67dYuWD2Oi5oTnX4ZUOua2nYm1q8k1OOtEBkaV0r
        9UVdWDZkovvKjgTJnWTUpec=
X-Google-Smtp-Source: AGHT+IG1HNZ5VMTyMEpkNg73r5goCQlAVI6Pib8xIMrDC5m+I2nm2/1ePjQiKBmtjapVMFZeXlr/QQ==
X-Received: by 2002:adf:fc51:0:b0:314:1443:7fbe with SMTP id e17-20020adffc51000000b0031414437fbemr20697268wrs.36.1693308952394;
        Tue, 29 Aug 2023 04:35:52 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d4406000000b003143c6e09ccsm13507702wrq.16.2023.08.29.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:35:52 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:35:50 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
Message-ID: <ZO3YFi7KghBSABnH@debian>
References: <20230828101157.322319621@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230829):
mips: 65 configs -> 3 failures
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:

mips builds are failing with the error:

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h: No such file or directory
   33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
      |          ^~~~~~~~~~~~~~~~~~~~~

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4837


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
