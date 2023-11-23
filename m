Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30C7F60C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjKWNtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbjKWNtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D931B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700747368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxe/WLsh7nIXyyUO9oSfkk7wRCeEdhack6GYCW6HjJ0=;
        b=d6RQLGwEBO/KlAePUon008cDe56jMQPKOtWWtyXUJ673ChcM/qmSsv3Z5nQn0ONU9MbXoe
        rDu3IsqLJtbe4HBE6youQ+cF7LU0s8BIt7UboDOpa3TWjsShYbybjjiRTTHnqUICNaJ+Z1
        GIWdfKK+tmyYOFrjJLn1mLoviv13VS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-01FaU-9lNxS8bxXlt4ljHw-1; Thu,
 23 Nov 2023 08:49:25 -0500
X-MC-Unique: 01FaU-9lNxS8bxXlt4ljHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEF9428004ED;
        Thu, 23 Nov 2023 13:49:24 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0906B1121306;
        Thu, 23 Nov 2023 13:49:23 +0000 (UTC)
Date:   Thu, 23 Nov 2023 21:49:20 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>
Cc:     lkp <lkp@intel.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <ZV9YYEK4L160ECQ+@MiWiFi-R3L-srv>
References: <20231114153253.241262-3-bhe@redhat.com>
 <202311160431.BXPc7NO9-lkp@intel.com>
 <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
 <39ccb4fda795a76996cf6d1c3b25909692358211.camel@intel.com>
 <ZVdyLdAzgNBXfjiW@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVdyLdAzgNBXfjiW@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 at 10:01pm, Baoquan He wrote:
> On 11/17/23 at 09:37am, Liu, Yujie wrote:
> > Hi Baoquan,
> > 
> > On Fri, 2023-11-17 at 17:14 +0800, Baoquan He wrote:
> > > Hi,
> > > 
> > > On 11/16/23 at 05:04am, kernel test robot wrote:
> > > > Hi Baoquan,
> > > > 
> > > > kernel test robot noticed the following build errors:
> > > > 
> > > > [auto build test ERROR on arm64/for-next/core]
> > > > [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes linus/master v6.7-rc1 next-20231115]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > 
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-234003
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> > > > patch link:    https://lore.kernel.org/r/20231114153253.241262-3-bhe%40redhat.com
> > > > patch subject: [PATCH 2/7] kexec_file: print out debugging message if required
> > > > config: hexagon-comet_defconfig (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/config)
> > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/reproduce)
> > > > 
> > > 
> > > Thanks for reporting.
> > > 
> > > I met below failure when following the steps of provided reproducer.
> > > Could anyone help check what's wrong with that?
> > 
> > Sorry this seems to be a bug in the reproducer. Could you please change
> > the compiler parameter to "COMPILER=clang-16" and rerun the command? We
> > will fix the issue ASAP.

Any update for the reproducer? I would like to post v2 with the fix. I
doubt it's the same issue as another report on this patch, while not
quite sure.

> 
> Here you are. Thanks for your quick response.
> ------------------------------
> [root@~ linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-16 ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
> Compiler will be installed in /root/0day
> lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/./llvm-16.0.6-x86_64.tar.xz
> /root/linux                                                                             
> tar Jxf /root/0day/./llvm-16.0.6-x86_64.tar.xz -C /root/0day
> PATH=/root/0day/llvm-16.0.6-x86_64/bin:/root/.local/bin:/root/bin:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> make --keep-going LLVM=1 CROSS_COMPILE=hexagon-linux- LLVM_IAS=1 --jobs=128 KCFLAGS=-Warray-bounds -Wundef -fstrict-flex-arrays=3 -funsigned-char -Wenum-conversion W=1 O=build_dir ARCH=hexagon olddefconfig
> make[1]: Entering directory '/root/linux/build_dir'
>   GEN     Makefile
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/menu.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> make[1]: Leaving directory '/root/linux/build_dir'
> 
> > 
> > > [root@~ linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
> > > Compiler will be installed in /root/0day
> > > lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/
> > > get1: /pub/tools/llvm/files/: files/: Is a directory
> > > Failed to download https://cdn.kernel.org/pub/tools/llvm/files/
> > > clang crosstool install failed
> > > Install clang compiler failed
> > > setup_crosstool failed
> > 
> > 
> 

