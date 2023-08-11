Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C27787E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjHKHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEAD271B;
        Fri, 11 Aug 2023 00:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB684663C0;
        Fri, 11 Aug 2023 07:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC32C433C7;
        Fri, 11 Aug 2023 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691738095;
        bh=37jaUGzeZOM+QHT8pWT/O+gj6dZ1gLnHur53ZHS5/8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nn59zFnYbKmNOJrBDkTIubQrK8MoehQRZp2VMkqwUC5bvQnfKYts2whOHkgyO2Oj/
         LG8lS/HfNukMNpv8OErYygLRzfkyp+XdWgJUJwnbQUvEfuAOEMYHDeWXuXsVLH9WA9
         tDql/SHQ2LkDoSPb72A6huf/+uymUe595b0RK8lY=
Date:   Fri, 11 Aug 2023 09:14:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 000/204] 4.14.322-rc1 review
Message-ID: <2023081110-synapse-risk-8b17@gregkh>
References: <20230809103642.552405807@linuxfoundation.org>
 <9d35afea-e1b4-72d0-9559-1eccdfd069a8@roeck-us.net>
 <d52167b3-46c3-1c5f-b4ee-5c9da4400284@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d52167b3-46c3-1c5f-b4ee-5c9da4400284@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 07:23:00AM -0700, Guenter Roeck wrote:
> On 8/10/23 06:56, Guenter Roeck wrote:
> > On 8/9/23 03:38, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.322 release.
> > > There are 204 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > 
> > Building sparc64:allnoconfig ... failed
> > --------------
> > Error log:
> > sparc64-linux-ld: init/main.o: in function `start_kernel':
> > main.c:(.init.text+0x77c): undefined reference to `arch_cpu_finalize_init'
> > make[1]: *** [Makefile:1049: vmlinux] Error 1
> > make: *** [Makefile:153: sub-make] Error 2
> > --------------
> > Building sparc64:tinyconfig ... failed
> > --------------
> > Error log:
> > sparc64-linux-ld: init/main.o: in function `start_kernel':
> > main.c:(.init.text+0x764): undefined reference to `arch_cpu_finalize_init'
> > make[1]: *** [Makefile:1049: vmlinux] Error 1
> > make: *** [Makefile:153: sub-make] Error 2
> 
> Those build failures were introduced with v4.14.321.

Thanks, let me leave them for now so I can get these updates out and
then work on the build breakages that the releases earlier this week
caused on arches and different compilers (i.e. clang).

thanks,

greg k-h
