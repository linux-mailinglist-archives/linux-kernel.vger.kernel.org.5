Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957C7F8C24
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjKYPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjKYPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:45:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143C1E0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:45:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43554C433C7;
        Sat, 25 Nov 2023 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700927129;
        bh=ObM2SPrwslmICoD8Q96gXrgGU06eqzKoLp3WXIF2rqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhLQiHQ1HATVxzr6Gwt7XXIQnHL8Zcz8zl1jLM3PWyQBet3x6mNKzyg6WExfgkqWx
         eW/useTyVBnWWRuGDIMzAPCMYU7/svCq+s78rzFjRBFSUDJcyCDW0mbfkdBt676+cq
         0SHPxRpgr9gXGwIE4sB7XgvvDD5hQ3bal73ka9D0=
Date:   Sat, 25 Nov 2023 15:45:27 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        dima@arista.com, linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5.4 000/159] 5.4.262-rc1 review
Message-ID: <2023112517-agreed-email-0ecc@gregkh>
References: <20231124171941.909624388@linuxfoundation.org>
 <CA+G9fYuVgqVc57YAwfA8MK6_Q86wD=RznCYKHDf_tD3foM9Y5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuVgqVc57YAwfA8MK6_Q86wD=RznCYKHDf_tD3foM9Y5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:09:43AM +0530, Naresh Kamboju wrote:
> On Sat, 25 Nov 2023 at 00:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.262 release.
> > There are 159 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> As Daniel replied on 4.19 build failures,
> Following build warning / errors occurred on arm and arm64 on the
> stable-rc linux.5.4.y and linux-4.19.y.
> 
> tty/serial: Migrate meson_uart to use has_sysrq
> [ Upstream commit dca3ac8d3bc9436eb5fd35b80cdcad762fbfa518 ]
> 
> drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
> drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has
> no member named 'has_sysrq'
>   728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
>       |             ^~
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Now fixed, thanks.

greg k-h
