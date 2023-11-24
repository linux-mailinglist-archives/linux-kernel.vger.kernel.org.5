Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F17F85C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjKXWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:06:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40522DD;
        Fri, 24 Nov 2023 14:06:23 -0800 (PST)
Date:   Fri, 24 Nov 2023 23:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700863581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYWKtxRcU5OtvShV9MVXedkqLwLEiA10wruWu5tg6y4=;
        b=EQLq442UGtTT/DnnjDkqTXlQiiNsR0bBnLFgSJiH2fVNkQreIt7BSV6qYVrer6J4bFdSB8
        Ouo9K1qlIDcGyZqGlFc30ktEUE071Oe2AVo5bfuCeb98WCu7sjqYNCh5bDu9emE7KDdSAy
        PwyF1c0zQlTPmNxgy5d1o/hqUJIpnURqDhQBgaTlY7GbAP3V5XeX/O4fu1F6fn5FUl5bhY
        KSyOZKnts6gH18nyV+tcky1ApazGKbfsCVBLhVLMIXeNxIa9cvnSv1gMaOe5k/m9cC9rJH
        4NXUGiuMOV2WWewEi6m0kA5oWaAZZy5khnfKGO/peMmYGno/exJGZpXfDaik1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700863581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYWKtxRcU5OtvShV9MVXedkqLwLEiA10wruWu5tg6y4=;
        b=zZvS0vzuzH+La0XV7q4a47WiYqqYw+neRHd0ZuEDS44yCC/aafCpv44B1tZgS6raa+X66X
        XtPGt/29k30/xRDQ==
From:   Nam Cao <namcao@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/491] 6.5.13-rc1 review
Message-ID: <20231124220617.l5Rx1XH4@linutronix.de>
References: <20231124172024.664207345@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:43:56PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Noticed no problem with qemu-system-riscv64:

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam
