Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E07FA8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjK0SNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0SNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:13:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BF5198;
        Mon, 27 Nov 2023 10:13:17 -0800 (PST)
Date:   Mon, 27 Nov 2023 19:13:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701108796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5NyQGF45mYqImvmQ3ULjobI6ABngkvPGQ8K288LfVM=;
        b=iKUe7lS+JD1/Ss8mKcJXw1lDZRDVbV9NCkGEO7fkFSsthvrE62e4FK3lHezBOhL6PJm54E
        G+QW7plJOfem/NXSJlx4ib4f0L9xWc87x8e/hJkU0CiZBW1iP2w9KWvJcOFNRzF5pyU7Mu
        GBvuZUQ1k3gcoAgeq81EHUnPl0TL32b3mKFBv/M3LfTlKFa53lX2Kc//ToQ2ubAZQUf0lZ
        f/6KLCY3LqU5+bJXaYbIw+pNBT+jViTYH/HXqaZM8IL7NCfnWqb/bkT5417w9/fJqSS/hx
        7t7HGygM+URBHdfzvNq0vzIMktUqEIAitu/xJbB9yXeEr//Bc8Dg2VuRdZrcTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701108796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5NyQGF45mYqImvmQ3ULjobI6ABngkvPGQ8K288LfVM=;
        b=ckI9tv5bNdT5QEAEElpBLTb+iYzGmuTa7z+vyGEe7Fxt0+1DwPB96SZDo/RtJjxcg3u1zD
        0gEWy+r5SHMODWCQ==
From:   Nam Cao <namcao@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <20231127181311.1FFxgWty@linutronix.de>
References: <20231126154359.953633996@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:46:28PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Build and boot successful with qemu riscv64:

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam
