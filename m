Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67467D4901
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjJXHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjJXHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:51:06 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90674E5;
        Tue, 24 Oct 2023 00:51:03 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 07C70C009; Tue, 24 Oct 2023 09:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698133862; bh=h6e4ASUwqGKjNohmy7ZK23hAnr+NlDUoomsSYM9NmDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIsF6+gWa0kHAb7tZfBSdiBafLWl8Q1SNrEbBQvBMAPGocduTP+LE7efo6iOHLn6c
         cgw+DqozdzskNw851zv7uxsGcMPzopPpM8EYsAeP01lJriqoA1m+fi8wIIheZjaTyZ
         Hzf5Xs5UAggytSVRhyDHO3WzT8H7yYByJcKQ+kI7CKhS7i/gYZVvf18haAG5c0lUbm
         oN2WcCo54UPdFE14AeFCga6DWS3are91dUfbw1dGTbr0l8XVs0i2Dhi7b6XnUhFL56
         GcRfWpVHkYHybxmC54SByQCFu8Ljq6BcE2/yRU12qTqzXNm0zltyiVZymJGzhaaN2+
         PHqzwMkG82yFw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C99B5C01A;
        Tue, 24 Oct 2023 09:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698133859; bh=h6e4ASUwqGKjNohmy7ZK23hAnr+NlDUoomsSYM9NmDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBZ/gVPDGQTVf84yBhQvlQsIUrUF6fYaVV3MIrszKRmsijHOmviEm1BoBSXh48mUp
         cIlJIdy1kfh00OWE5vJoXMGdCPc0k01x2Z9rH56/oddrgbjzlbAFSJtwO/gzqXs7ew
         LYdxfNykrO4UILMEkI9avMnNShAix7pSfvqihPPBFvWDTBgRb6C8327bWIgZh0QlJ3
         tVJRu+we9ZZDtBbTD1gHuFNQSEBskg/ukV7QlBY6PkGOaXoOpGOxyinM513mRwNvP1
         JmLQRS+uE7Mow7c3GvuBcXBtylLzoBIiY0CFuaq7l0Lzw8IOgiHLf7775+b5cZTghu
         Zs2EG5Ykn+Asg==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 31c69e22;
        Tue, 24 Oct 2023 07:50:52 +0000 (UTC)
Date:   Tue, 24 Oct 2023 16:50:37 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
Message-ID: <ZTd3TZ7oZH7nxKfY@codewreck.org>
References: <20231023104826.569169691@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote on Mon, Oct 23, 2023 at 12:55:07PM +0200:
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Not much point in adding to the IRQCHIP_IMMUTABLE errors reports; I went
ahead and reverted these two commits:
da4ad7dba3a1 ("gpio: vf610: mask the gpio irq in system suspend and support wakeup")
90225415cad6 ("gpio: vf610: make irq_chip immutable")

With these two commits out of the way, I could test this 5.10.199-rc1 on
our armv7 and aarch64 boards (respectively Armadillo 640 and Armadillo
G4, which do not use the above gpio driver).
There was no other obvious regression:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus
