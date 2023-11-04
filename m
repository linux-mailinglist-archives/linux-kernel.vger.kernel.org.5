Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877567E1066
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjKDQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKDQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7963BD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699115278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u2jDVzbLBh0kvfSZEJXD4LBDAg75vXnR88Q8IZiv90k=;
        b=eOh+fd61lnOkiQORZWuxHsjr2W2Gnsb/Kz7g/ANC3P03UoyOUvxxXQLhQ4k4EDJnwPV34I
        rSHCWgQZHX6zXW3cTohneHPjSr6LdGfNP2eW82R7cjRjAIpr50PArJl6GAdj2lAu753GR2
        P0XWtwrS7Y2Zg/48T3hTz1ABGGouam4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-9CFNkHJMO1SAUMVHEno9qA-1; Sat,
 04 Nov 2023 12:27:55 -0400
X-MC-Unique: 9CFNkHJMO1SAUMVHEno9qA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1460C3806287;
        Sat,  4 Nov 2023 16:27:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.20.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCC3AC12913;
        Sat,  4 Nov 2023 16:27:54 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94.2)
        (envelope-from <fche@redhat.com>)
        id 1qzJV3-0004Q4-T3; Sat, 04 Nov 2023 12:27:54 -0400
Date:   Sat, 4 Nov 2023 12:27:53 -0400
From:   "Frank Ch. Eigler" <fche@redhat.com>
To:     systemtap@sourceware.org, linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap 5.0 release
Message-ID: <20231104162753.GA16986@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 5.0

Faster & more reliable kernel-user transport; support for forthcoming
debuginfod "metadata" searches to mass-probe potentially installed
binaries; deprecated support for RHEL6 2.6.32 and earlier kernels;
more DWARF5 debuginfo format support.


= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-5.0 (commit cfc2c1d53924face11e3fab78ded61c359778eb9)

  There have been over 110 commits since the last release.
  There have been over 35 bugs fixed / features added since the last release.


= SystemTap frontend (stap) changes

- More probe point process details are printed in "-L" list mode with
  more "-v".

- For the case where newer kernels may break systemtap runtime APIs,
  better pass-4 failure diagnostics are printed.

- The target(s) of process probes may be specified by path name globs,
  as located selected debuginfod servers.  This requires the
  debuginfod servers to support "metadata" queries.  At the time of
  this systematp release, this debuginfod capability is under review
  in elfutils, so not yet merged into elfutils master/releases.
  
  # export DEBUGINFOD_URLS="URL1 URL2 ..."
  # stap -e 'probe debuginfod.process("/usr/*/curl").begin { log("hi") }'


= SystemTap backend changes

- Performance improvements in uprobe registration and module startup.

- The kernel-user message transport system added framing codes, making
  the transport more reliable, but becoming incompatible across
  pre-5.0 versions.  Use matching versions of stap and staprun.

- RHEL6, kernel 2.6.32* as well as older releases have been deprecated
  from the codebase.  RHEL7 and kernel version 3.10 are now the oldest
  supported versions for Systemtap.

- New runtime macro STP_TIMING_NSECS is now supported for reporting probe timing
  stats in nsecs instead of cycles.  This may become default later.

- Add new runtime macro STP_FORCE_STDOUT_TTY to override STP_STDOUT_NOT_ATTY.


= SystemTap tapset changes

- Tapset function print_ubacktrace_fileline() now understands DWARF5.

- The testsuite Makefile has been simplified to remove concurrency,
  so "parallel" and "resume" modes are gone.

- Numerous kernel porting tweaks.


= SystemTap sample scripts

* All 190+ examples can be found at https://sourceware.org/systemtap/examples/


= Examples of tested kernel versions

  3.10.0 (RHEL7)
  4.18.0 (RHEL8 + CentOS Stream 8 x86_64, aarch64, ppc64le, s390x)
  5.14.0 (RHEL9 + CentOS Stream 9 x86_64, aarch64, ppc64le, s390x)
  6.4.15 (Fedora 38 x86_64)
  6.5.6 (Fedora 39 x86_64)  
  6.6.0-rc (Fedora rawhide x86_64)


= Known issues with this release

None, it's practically perfect.


= Contributors for this release

Aaron Merey, Aliaksandr Valialkin*, Frank Ch. Eigler, Housam Alamour*,
Martin Cermak, Ryan Goldberg, Serhei Makarov, William Cohen, Yaakov
Selkowitz, Yichun Zhang (agentzh), lijunlong*

Special thanks to new contributors, marked with '*' above.


= Bugs fixed for this release <https://sourceware.org/PR#####>

30396  kernel 6.3.* objtool/ibt warnings during pass 4
30406  C symbol conflicts when using Fedora 36's 6.2 kernels and -DDEBUG_MEM
20735  "soft lockup" bug on RHEL7 ppc64
30405  Kernel errors in kallsyms_on_each_symbol() with Fedora 36's 6.2/6.1 debug kernels
30395  Regex code has invalid memory reads caught by KASAN
30408  Always fail to read userland memory (read faults) inside perf event probes with 6.2/6.1 kernels
30454  The stap runtime does not call nmi_uaccess_okay() to protect data races against CR3 switching on X86
29765  Convert NFS from readpages to readahead => tapset/linux/nfs.stp breakage
30484  stap-report scrapes too much /sys /proc
30415  conflicting types for ‘kallsyms_on_each_symbol’
30459  Ko compilation failures with kernel 6.1/6.2 kernel headers
30570  Type inference for elided try-catch block has unresolved error variable type
30617  Systemtap unable to successfully build kernel modules for linux-6.5
30634  sprintf_traceback* can flush content to stapio stream
30442  optional statement probes still throw exceptions that kill pass-2
29108  persistent intermittent bufhdr-corruption / transport-failures, even with large -s
30749  stap --sign-module doesn't sign the module, as one would expect
30456  Kernel 5.18+ retired set_fs() and replaced it with the user_access_begin/end() pair for userland memory accesses
30777  Systemtap modules unable to run on systemtap supporting Intel CET IBT
27410  rpm-set path based probes
30858  improve diagnostics for kernel unsupported version
30864  json-c required, but not during configure
30831  Systemtap scripts fail to compile on newest linux 6.6 kernels
30416  unable to find member 'request' for struct scsi_cmnd
30434  deprecate rhel6 (2.6.32*) support
27791  hw_breakpoint.exp fails to build
26152  _struct_compat_timex_u() function doesn't work on rhel8
13480  ARM missing syscall.sigaltstack
30401  s390x specific: invalid application of ‘sizeof’ to incomplete type ‘struct stack_frame’
30407  Tapset function print_ubacktrace_fileline() no longer works with DWARF5
30987  Addition of strlcopy and strlcat to glibc prevents compilation of dyninst based systemtap instrumentation
30803  Extend debuginfod.process probe to glob by package name too
31011  Memory leaks happen when stap's -t option is specified and the stdout stream is not a tty
31013  Use of sleeping _stp_stat_del() operations in atomic contexts when cleaning up for -t
31012  Bug: kernel module loading might block a CPU more than 1.5ms on very fast machines
31018  Map operations might get no lock protections due to "pushdown lock" bugs
31028  Systemtap doesn't find probe points for process.function("*").callee("*")' in code with DWARF5 debuginfo

