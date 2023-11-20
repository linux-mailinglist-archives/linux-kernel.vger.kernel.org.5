Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823F77F0FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjKTKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjKTKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:06:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C10DD79;
        Mon, 20 Nov 2023 02:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E03C433C7;
        Mon, 20 Nov 2023 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474751;
        bh=K0YC+nZZ5T4BKyoKuBlC5dhluF5RVj5i/m8wcUN0dvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxR8Zzs2yF8PJLGSysIVrFRKKma31+eFAvg+b4WjExSrL3JeAO8BUhsINck39DSWe
         XvwDW6MdrSqkgkMnXRVCzByOw4elPbIOD/TBhgf4iN9Zuk/bbMu0fycANKcdQs3KQm
         VQs9RtXnZMdt3g0x3NjpxQBmjqKK8blucdfLkIUY=
Date:   Mon, 20 Nov 2023 11:05:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/191] 5.10.201-rc1 review
Message-ID: <2023112039-reverse-careless-e646@gregkh>
References: <20231115204644.490636297@linuxfoundation.org>
 <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5367845-8d70-4fcf-861a-ff9b8849c9c9@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 05:13:39PM -0800, Guenter Roeck wrote:
> On 11/15/23 12:44, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.201 release.
> > There are 191 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 155 fail: 4
> Failed builds:
> 	arm:allmodconfig
> 	arm64:allmodconfig
> 	i386:tools/perf
> 	x86_64:tools/perf
> Qemu test results:
> 	total: 495 pass: 495 fail: 0
> 
> with:
> 
> Building arm64:allmodconfig ... failed
> --------------
> Error log:
> drivers/interconnect/qcom/osm-l3.c:6:10: fatal error: linux/args.h: No such file or directory
> 
> There is no linux/args.h in v5.10.y.
> 
> Caused by "interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()".

Now dropped, thanks.

greg k-h
