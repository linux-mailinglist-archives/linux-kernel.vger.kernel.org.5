Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581A788BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjHYOZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343677AbjHYOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:24:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96471D1;
        Fri, 25 Aug 2023 07:24:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c3b9f83f4so43080b3a.2;
        Fri, 25 Aug 2023 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692973471; x=1693578271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHyka2U6Y9QLR3iBbxMxEWSzu/iMnQI0MUngbRlsFAY=;
        b=BRzIOGxuRosXrZwg7/OsmumCL3DVKh3ipGfPDi7BQNgjqFv/K4e0DeFlCr6B9ScpJq
         tqhWrH3jBZ3JCUmy2nO/aJ99fqoda8abgk505EcnjRILOKbEQoUDhIdrY4s1YtUlSQmy
         TpRPjkHL6+i1lhltwha+HSuEM3tQ89i1GyhmGfaERgalGjlkhSm8rpPV0QOg3DyRnm5X
         ioNUCdsgXRo/Is7OidNH7wvAL1UDGdrF8S5GNRutFqo8OXIZWGJRHcb0eRNUUvP26L3j
         trdtwFz8rEt8HDzw18kjjJvsyjev6lD3yRtb55T+vQOsggThF56tEMhSwUhz2RCNODof
         eraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973471; x=1693578271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHyka2U6Y9QLR3iBbxMxEWSzu/iMnQI0MUngbRlsFAY=;
        b=QgmkYw3sX4nsOdRYcAb+x+W0HRVNgb5KV7yCMcFDjyr7eg8tyFkxtugN1PhLDic0in
         ufyZrcOUFnljT1MIRxWopbm3tfAji23AohRtYhbtKXhgYqdq7Lmvpdkc//1bAstEDmVp
         RNf/i7wVYL8iQ7gLvreTaCmd4vkU/eTlgSF8NQmbXkjj6zGzT8IxOJw6IFAG4+GI8MNR
         5R2+skxlVqRYrVzSt1hOF3igQn9rhvebZM0IbqMbuGuJaXWUTESXeBvQkH72umk2DPaW
         yd37gaDOx77YzWzocuOCN6j2TI/6X84alouaxtLCn7tUe3VM2uwMt8fLefSYyZmDAgIo
         670g==
X-Gm-Message-State: AOJu0YxthTQDeLlflttI7Jxs0A9UEj2HDSPIiRNCtweDbWpSuhJsYfBm
        b1efRyMnxNFI4l4ycSDnLUng6SHvtQ8=
X-Google-Smtp-Source: AGHT+IFVem110PP4tmF7Ev+4kTdchTFejqRzAwBbt3fP8YY3TzU76qliEjKgB2szc8YRyFlqWUssoQ==
X-Received: by 2002:a05:6a00:1581:b0:68b:4e07:133f with SMTP id u1-20020a056a00158100b0068b4e07133fmr11558479pfk.7.1692973470973;
        Fri, 25 Aug 2023 07:24:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b006879493aca0sm1623555pfn.26.2023.08.25.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:24:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 07:24:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <fb1c3952-1d72-4f9d-bc93-2988bcde462e@roeck-us.net>
References: <20230824170617.074557800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 

Testing is not complete, but early feedback: All riscv32 boot tests
crash badly with errors such as

Starting syslogd: OK
Starting klogd: OK
/etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
/etc/init.d/S20seedrng: line 33: syntax error: unexpected end of file (expecting ";;")
Starting network: /bin/sh: syntax error: unterminated quoted string
sed: unmatched '/'
/bin/sh: syntax error: unterminated quoted string
FAIL
/etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution

This is no longer seen after reverting the following patches.

92609bb3a1f8 riscv: uaccess: Return the number of bytes effectively not copied
e06648704417 riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
20704d763646 riscv: lib: uaccess: fold fixups into body
4f503bad920e riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall

Guenter
