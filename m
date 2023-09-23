Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507D27ABED5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjIWIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjIWIWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:22:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6140199;
        Sat, 23 Sep 2023 01:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD51DC433C7;
        Sat, 23 Sep 2023 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695457345;
        bh=eRwEN3mkKPhjClWHqDUhD4TBrOyvNcyWKa6ZocsOfz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTF50jiSmG0WIVWHwTS9Qkd5jPI1V5r16Kh65ioznRqM9BV/w3JmWqHXkyL4TmV/Z
         J3J44/+4ZkU8MKIaB120KhvnYpzgjYWjwrnFxjL1JjnPTWVIUmXgtpDu8Nsc3cpl/l
         m2OTqaDVdwYm/X93AxMpy4rukVw4L27DIV3ShJHs=
Date:   Sat, 23 Sep 2023 10:22:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
Message-ID: <2023092317-convent-crimson-584a@gregkh>
References: <20230920112826.634178162@linuxfoundation.org>
 <2ab51081-698f-4556-b673-cc0b62b0ace5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab51081-698f-4556-b673-cc0b62b0ace5@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 08:59:27AM -0700, Guenter Roeck wrote:
> On Wed, Sep 20, 2023 at 01:30:50PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.196 release.
> > There are 83 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 157 fail: 2
> Failed builds:
> 	i386:tools/perf
> 	x86_64:tools/perf
> Qemu test results:
> 	total: 495 pass: 495 fail: 0
> 
> gcc-10: fatal error: no input files
> compilation terminated.
> 
> The error is due to commit 653fc524e350 ("perf build: Update build rule
> for generated files") which uses PMU_EVENTS_C without introducing it.

Now dropped from everywhere, thanks.

greg k-h
