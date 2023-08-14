Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDEE77C25F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjHNV2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjHNV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:28:00 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6284113
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:27:57 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9a2416b1cso4181857a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1692048477; x=1692653277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2Gb6QdAQZGLkPrUcUrS4E1/hnWfvRNciGalZbqgQQ4=;
        b=i11OJNbYHC5AYqDBR2eu2fGiK9DqeYAVHKwAtBqDqVczemPMwMq9yxj0tSz8BMAJy9
         Td5JKgLF5NR7KOz2qv7DwuVONvciQESKh8dLyfB6SZTY8qDJFQP3y0mQ1NbREL5rTC4Z
         F4fAQra83kQoWFJkYnHg+4p6ZlIDUtVKUTvZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048477; x=1692653277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2Gb6QdAQZGLkPrUcUrS4E1/hnWfvRNciGalZbqgQQ4=;
        b=SeGIaeasdgJPp5GJShob/RiWYlsglSuyduQ7yu+hBSG+Zw7e47ZT0NheujA+T+cIOA
         cPFzuA7G2VYBaf4wQMFwn2e03Ai5D5Oq4/I3aGBVBOhufrjvG4JacapH4eRA6QZMIZjW
         AMNXlsLu3BH4XKMK/W31ZrHHEPnVSu+/1EcO17l6QCBnB7UBfAyfq9FxlZ7I31m+WKix
         ym/1ZfJKNIOEv0XDnCAxogzvMiuhfAEoyOkGyPHZI9Z2wwQZe6/Gs2jMSXmEjmVRnBcC
         Hu/xuJr3TjqW7Tu8biPPW6ya8M/J94Do/09AuPxBC0n59XGXpMOfc2+FMOQD1DE41N9x
         GQHg==
X-Gm-Message-State: AOJu0Yw+PkKerEhW7HKwUO/V6qChyCtcRLVGIeTnwaV+Xsh4afa17QSd
        673nNzijKIsrK2PNfN1yy518IQ==
X-Google-Smtp-Source: AGHT+IF5Big4bba0sH4Y/J9B79lhl7z/AYAs28CvbkFA9qljvEtUNhSestPpkhMBziUHW7zBNaIktw==
X-Received: by 2002:a9d:684a:0:b0:6b2:9bdb:a84a with SMTP id c10-20020a9d684a000000b006b29bdba84amr10662554oto.32.1692048477015;
        Mon, 14 Aug 2023 14:27:57 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id d27-20020a0568301b7b00b006b1570a7674sm4708854ote.29.2023.08.14.14.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:27:56 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 14 Aug 2023 16:27:54 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
Message-ID: <ZNqcWhqouBYey/8g@fedora64.linuxtx.org>
References: <20230813211724.969019629@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:16:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
