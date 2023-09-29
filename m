Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF227B35D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjI2Ohb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjI2Oh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:37:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F43E7;
        Fri, 29 Sep 2023 07:37:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5043a01ee20so20035126e87.0;
        Fri, 29 Sep 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695998244; x=1696603044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUNwvLwFToVAfWcR/28CLGE4Es+QNTF6TkYHUEQHD4s=;
        b=Rj0NZWFuAOV9iYDo5bsf7fYOWHsvZfk1YRPDc2Wqiqp/n6t+MIV+/IrRpzC+WCjd3j
         ZIn69Rm8TOArIkVsgSEXm1hqvP6iTyYCxhA/kn56bNwUM3efvIAI2nO0UmBzQn7uwxx1
         ubnm3KEzzveXNnc1N8NNEraHufwM+qUX1n0LcD+bVK6JFN2/nYuo19i/zNPzS7hxZXW9
         3ApClifsQBLe4mEBZHJQvfiootTDLTY0NW34OKyw0H7t/4QMO1CrkTZ+/SAijB7WgFpw
         Mytj4FIwdbv+maBHnWkTv+NdYT48/WEtcTmbt8NodUQVmd1nTXBDREwbIIFsIAyae26B
         wCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695998244; x=1696603044;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUNwvLwFToVAfWcR/28CLGE4Es+QNTF6TkYHUEQHD4s=;
        b=MmzhfnmZHEl4qGtmEgOaqFhgGmnqHrWVrwyMFSLQ7J0VEc0G+jMxEayfNbIIA7rfac
         YX27e5zeXUb9Et7QaM6fvCzyY8RBw3goMoz87/YJyPWNbZhkP9czNja+mbxx7cumYJ3O
         6q9FHH2aXxlk0OSiBPSIF4oF0qTU1XBFczGK2LWaM7CTfDHx0lQf4IiUPlDTl6k4fhV4
         RgpzwiaZOTz2Szsmp3pJmbePmrY1XeAQMX76aOzb+V2gqZVHrJnJv+8fHSGQ4Ul8q4c8
         bxI2/r2oq2lrAA0m5zECzl8AOgpvL9k8uhvOHlwkIUH/72UM51gQ9jbv6B0XcaLej2G9
         hfHw==
X-Gm-Message-State: AOJu0Yy4hSvCp0Mis8lYzNXOEJauMwVKjciDMBhHHFrxebcoi+9HRGGO
        AYNltuhk+syU3+RSVzJrsC3GJgz90usDhA==
X-Google-Smtp-Source: AGHT+IHUHCDBIDPn4259ioRDpJePii5esA4maiNhkyVCdqB3LqMbY1Rg4TgnTMgWvoxlO74gWpxlZw==
X-Received: by 2002:a05:6512:a95:b0:505:6e21:32e1 with SMTP id m21-20020a0565120a9500b005056e2132e1mr2305416lfu.10.1695998243867;
        Fri, 29 Sep 2023 07:37:23 -0700 (PDT)
Received: from ldmartin-desk2.attlocal.net ([192.55.55.53])
        by smtp.gmail.com with ESMTPSA id l20-20020ac24314000000b00503fb2e5594sm3534066lfh.211.2023.09.29.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:37:23 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:37:14 -0500
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam =?utf-8?B?R2/FgsSZYmlvd3NraQ==?= <adamg@pld-linux.org>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Julien Cristau <jcristau@debian.org>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        Nicolas Schier <n.schier@avm.de>,
        Quentin Armitage <quentin@armitage.org.uk>,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [ANNOUNCE] kmod 31
Message-ID: <lnbkvt5hhvgksgjqko7t6niw6uzr5ewjp32wyy2s26rzwdgh2y@l775iv6f6tkz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmod 30 is out:

         https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-31.tar.xz
         https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-31.tar.sign

Improvements

         - Allow passing a path to modprobe so the module is loaded from
           anywhere from the filesystem, but still handling the module
           dependencies recorded in the indexes. This is mostly intended for kernel
           developers to speedup testing their kernel modules without having to load the
           dependencies manually or override the module in /usr/lib/modules/.
           Now it's possible to do:

                 # modprobe ./drivers/gpu/drm/i915/i915.ko

           As long as the dependencies didn't change, this should do the right thing

         - Use in-kernel decompression if available. This will check the runtime support
           in the kernel for decompressing modules and use it through finit_module().
           Previously kmod would fallback to the older init_module() when using
           compressed modules since there wasn't a way to instruct the kernel to
           uncompress it on load or check if the kernel supported it or not.
           This requires a recent kernel (>= 6.4) to have that support and
           in-kernel decompression properly working in the kernel.

         - Make modprobe fallback to syslog when stderr is not available, as was
           documented in the man page, but not implemented

         - Better explaing `modprobe -r` and how it differentiates from rmmod

         - depmod learned a `-o <dir>` option to allow using a separate output
           directory. With this, it's possible to split the output files from
           the ones used as input from the kernel build system

         - Add compat with glibc >= 2.32.9000 that dropped __xstat

         - Improve testsuite to stop skipping tests when sysconfdir is something
           other than /etc

         - Build system improvements and updates

         - Change a few return codes from -ENOENT to -ENODATA to avoid confusing output
           in depmod when the module itself lacks a particular ELF section due to e.g.
           CONFIG_MODVERSIONS=n in the kernel.

Bug Fixes

         - Fix testsuite using uninitialized memory when testing module removal
           with --wait

         - Fix testsuite not correctly overriding the stat syscall on 32-bit
           platforms. For most architectures this was harmless, but for MIPS it
           was causing some tests to fail.

         - Fix handling unknown signature algorithm

         - Fix linking with a static liblzma, libzstd or zlib

         - Fix memory leak when removing module holders

         - Fix out-of-bounds access when using very long paths as argument to rmmod

         - Fix warnings reported by UBSan


Shortlog is below:

Adam Gołębiowski (1):
       autogen.sh: remove --with-rootprefix, it is gone since kmod-11

Dimitri John Ledkov (1):
       build: enable building & running tests from a subdir

Dmitry Antipov (3):
       libkmod, depmod: prefer -ENODATA over -ENOENT if no section found
       libkmod: fix possible out-of-bounds memory access
       shared: avoid passing {NULL, 0} array to bsearch()

Emil Velikov (10):
       depmod: Introduce outdir option
       treewide: add some static const notations
       testsuite: add function declarations for __xstat family
       testsuite/depmod: use defines for the rootfs/lib_modules
       libkmod: error out on unknown hash algorithm
       libkmod: remove unused kmod_module_get_builtin
       libkmod: annotate kmod_builtin_iter API as static
       shared: annotate local API as static
       configure: manage libkmod.pc.in and version.py.in via AC_CONFIG_FILES
       libkmod: add fallback MODULE_INIT_COMPRESSED_FILE define

Fabrice Fontaine (1):
       configure.ac: fix link with -llzma

Florian Weimer (1):
       kmod: configure.ac: In _Noreturn check, include <stdlib.h> for exit

Gustavo Sousa (3):
       testsuite: Wrap chdir()
       modprobe: Move insertion block into separate function
       modprobe: Allow passing path to module

Jan Engelhardt (1):
       testsuite: repair read of uninitialized memory

Julien Cristau (1):
       testsuite: fix override of `stat` on 32-bit architectures

Lucas De Marchi (8):
       testsuite: Move setup-rootfs logic from Makefile to script
       testsuite: Handle different sysconfdir
       libkmod: Do not inititialize file->memory on open
       libkmod: Extract finit_module vs init_module paths
       libkmod: Keep track of compression type
       libkmod: Keep track of in-kernel compression support
       libkmod: Use kernel decompression when available
       kmod 31

Mikhail Novosyolov (1):
       libkmod: do not crash on unknown signature algorithm

Nicolas Schier (1):
       modprobe: rmmod_do_module: Free kmod list of holders

Quentin Armitage (1):
       modprobe: Write error messages to syslog if stderr is unavailable

Yauheni Kaliuta (1):
       man/rmmod: explain why modprobe -r is more useful


Thank y'all for the contributions,
Lucas De Marchi
