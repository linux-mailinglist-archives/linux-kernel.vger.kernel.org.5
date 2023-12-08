Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9E80A1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573526AbjLHLOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLHLOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:14:41 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAEEF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:14:46 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso2015343276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702034086; x=1702638886; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jwXyBoP9BEPVzorojlYLkS6JKqqck3ZSXDY6OiJbKT8=;
        b=Uk+j0JwgGJWABVKbspPA3bLLS+m6PUgxdHcyN+Oiw0EeKM5h2DnsqonCdHewR8JnYA
         zt/EXCQ/X8xt7nC/Wi3DGdBUIDmkLCnWh3XeaBQJf707JW/G636ikaHtzNLLFwMhmOYt
         PRZM6xvU+0RKayDCqt8CJULUEQ5gAs3yArKP1vtmJ/bFJLse+4zIKEQ/HH2ZD+u9MKD3
         tbvtogDAF7ydpxZiINUt/dknyPt8YcPMg3ckj5FbjGj8rYt4Y+yH4bMuOYwrQGOpCnK0
         0B1bhtJY/+JjAYLKOS2uWwlFqKE3oU+4E211fioQ82aqaf5iVj11I/cfrCHVlqKcuckr
         hvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034086; x=1702638886;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwXyBoP9BEPVzorojlYLkS6JKqqck3ZSXDY6OiJbKT8=;
        b=idY2zaJwhNC7i8IZzsaKlEayZIZVDUvNMk08xdH9A5Wl8GlAshFSR19ILfn1KGKFCe
         Ppf0GaZeboEgQmXxJti/MxuTEZGVV2tpZIASJuCQDHkI/4TSp/+PicmZ13nwzC5U24li
         K+7rEXxzdbPnl5tqnFM766o+8E9ULFN98y/ePLA/koATXJLQtcqVDqLtDRPcibSXwzDe
         npJ7gDiC4MEZtibbwMNlbMO+sI9ksYUUwO24fZHCfNiD2hjhjGjNGMXDJ2aYb2bPmu+7
         rynWKGRPxfU8h9iK1mANY4gCq+OXqb4CeRc4WusuGrr0O7N+v0qs/b95scYlmM0yAiZK
         esmA==
X-Gm-Message-State: AOJu0YzV990+WxyjHCTZPMI42bykcDYbnGfjWqlXJ1ElJzuwy5CBsxHD
        jMMX5OBoglKsMJu2QYG/+PBYkYh+kBFPEZbEQBFodLwlOSPtNA==
X-Google-Smtp-Source: AGHT+IElEUcvtMEN4bskBmI1iwpmTNOsAAvF1/vNdwadjd4LrOAGR+sTfUwSZQ7gvIj0+sHX42EdmkupJNQtcvjDQu4=
X-Received: by 2002:a05:6902:282:b0:db4:99ea:8b9b with SMTP id
 v2-20020a056902028200b00db499ea8b9bmr3831557ybh.65.1702034085949; Fri, 08 Dec
 2023 03:14:45 -0800 (PST)
MIME-Version: 1.0
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Fri, 8 Dec 2023 11:14:35 +0000
Message-ID: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
Subject: Building signed debs
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to build a signed .deb kernel package of
https://github.com/torvalds/linux/tree/v6.6.  I've copied
certs/default_x509.genkey to certs/x509.genkey.  The .config is the
one from Ubuntu 23.10's default kernel with all new options accepted
at their default and CONFIG_SYSTEM_TRUSTED_KEYS="" and
CONFIG_SYSTEM_REVOCATION_KEYS="".

This builds the kernel and modules, signs the modules, compresses the
modules and then attempts to sign the modules again.  That fails,
because the .ko module files are now .ko.zst files and the file it's
trying to sign isn't there.  Full failure is pasted below.

Unsetting CONFIG_MODULE_COMPRESS_ZSTD is a workaround (ie disable
module compression).

Is there a way to build a .deb of a signed kernel with compressed modules?

Thanks for any help,
Tom

  INSTALL debian/linux-libc-dev/usr/include
  SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/amd/amd-uncore.ko
  SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/intel/intel-cstate.ko
At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or
directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/amd/amd-uncore.ko
  SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/rapl.ko
At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or
directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/intel/intel-cstate.ko
  SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/cpu/mce/mce-inject.ko
make[6]: *** [scripts/Makefile.modinst:137:
debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/amd/amd-uncore.ko]
Error 1
make[6]: *** Waiting for unfinished jobs....
make[6]: *** [scripts/Makefile.modinst:137:
debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/intel/intel-cstate.ko]
Error 1
  SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/msr.ko
At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or
directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/rapl.ko
make[6]: *** [scripts/Makefile.modinst:137:
debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/rapl.ko]
Error 1
At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or
directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/cpu/mce/mce-inject.ko
make[6]: *** [scripts/Makefile.modinst:137:
debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/cpu/mce/mce-inject.ko]
Error 1
At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or
directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/msr.ko
make[6]: *** [scripts/Makefile.modinst:137:
debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/msr.ko]
Error 1
make[5]: *** [Makefile:1821: modules_install] Error 2
make[4]: *** [Makefile:2036: run-command] Error 2
make[3]: *** [debian/rules:17: binary-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess
returned exit status 2
make[2]: *** [scripts/Makefile.package:146: bindeb-pkg] Error 2
make[1]: *** [/home/tkcook/git/linux/v6.6/Makefile:1538: bindeb-pkg] Error 2
make: *** [Makefile:234: __sub-make] Error 2
