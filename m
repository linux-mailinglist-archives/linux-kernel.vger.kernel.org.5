Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E637F30AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjKUO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjKUOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:53 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565B61991
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:40 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dae7cc31151so5134192276.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700576739; x=1701181539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dCTl+by/8OgzPkqiTTy1mu7iUQvkaM00OdF6QByqCRc=;
        b=FhGgruZs5WQMJqYwgCqX69RUiOZAWt18vg+4MnG2tk2BVTFtcWomFpNh/5WgHKgUTG
         9tHYJjR6VR0gs/6mMYNa2TprKEIAXxsPYTqihSgSsjak+MrJ5GI4qdt+lhop4bHQRABL
         nvKi8WzVZWVJfKN8M+1BuFsPj2EtZDaFCoHSHGR2A+JFyp7srUxH9QgKie7t4mafS+EL
         Xpy1mne8HKC9FZDN4/DXW+7W1k7Ga/Gy6YoBLl+h10hbgxaexjbS72I6BUV89wkQz2Pn
         8kJaqcL09gLUUJvTZ8oO4q1+rsig9An2gWLnxWt+74QQFgC9qJChuxUOXyrUcJPjrvrk
         aP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576739; x=1701181539;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCTl+by/8OgzPkqiTTy1mu7iUQvkaM00OdF6QByqCRc=;
        b=CciTAnRc9d4OGA5U4ks2Y6I0wakSnl/7Nrha14Ms4Yzt8pOw8ZNYM+sAnLnVj28CtD
         kvSA+QKzdnqe05sVNV2LcaQQhKO/uF8i4sWWvwSIh/2X3MHytyVymK3r54gi/WQieBa9
         lPT9DPfHDDnKJXqpKAHNxa+xx6iDQ/fvSqytyxnhEyJM04mOXFr5mur1omSyzB/VdS6H
         XIlDKLXI/rTHYiIPNMTky8HXOj+0fWr4kSN5NXnMhC6bPCHRuSCw5aCnnHnBx8dkd16H
         5Zc+entGgecuLSmnmQ88RDiuvj8POv3IBuav7r0bFXih/mF5XX48uGS2O7oO/WccQrPn
         GCkA==
X-Gm-Message-State: AOJu0YzvpAMtKytsbMzAA33Iyjbp/0t7NVUB9MNHmI0hTqDAptptUsMx
        PgokvEThVNIhMMv8PJ/bZdsqRG0YKaOOLFoml+FDxg==
X-Google-Smtp-Source: AGHT+IFzC/P9VBpC/SW7HcjRqPIjGI6/u3317qHHutxgt4On71zUFgu360yHalbn7IBXSLbaUggzuHxl91TG21rj54k=
X-Received: by 2002:a81:6588:0:b0:59a:d42c:5d50 with SMTP id
 z130-20020a816588000000b0059ad42c5d50mr9563819ywb.52.1700576739223; Tue, 21
 Nov 2023 06:25:39 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Nov 2023 19:55:27 +0530
Message-ID: <CA+G9fYvcaozQvas-h55FPjXk+uomF2CyeYbWGCsXM8yGo4SZgA@mail.gmail.com>
Subject: SuperH: fs/namespace.c: In function '__se_sys_listmount':
 syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
To:     linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Ian Kent <raven@themaw.net>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        dalias@libc.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SuperH tinyconfig and allnoconfig builds started failing from 20231120 tag
Please find the following builds warnings / errors.

sh:
  build:
    * gcc-11-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
----------
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=sh
CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
'HOSTCC=sccache gcc'
  Generating include/generated/machtypes.h
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
during RTL pass: final
In file included from /builds/linux/fs/namespace.c:11:
/builds/linux/fs/namespace.c: In function '__se_sys_listmount':
/builds/linux/include/linux/syscalls.h:258:9: internal compiler error:
in change_address_1, at emit-rtl.c:2275
  258 |         }
         \
      |         ^
/builds/linux/include/linux/syscalls.h:233:9: note: in expansion of
macro '__SYSCALL_DEFINEx'
  233 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
/builds/linux/include/linux/syscalls.h:225:36: note: in expansion of
macro 'SYSCALL_DEFINEx'
  225 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name,
__VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
/builds/linux/fs/namespace.c:5019:1: note: in expansion of macro
'SYSCALL_DEFINE4'
 5019 | SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
      | ^~~~~~~~~~~~~~~
0x129d9d7 internal_error(char const*, ...)
???:0
0x5dbc4d fancy_abort(char const*, int, char const*)
???:0
0x7ddd3e adjust_address_1(rtx_def*, machine_mode, poly_int<1u, long>,
int, int, int, poly_int<1u, long>)
???:0
0x81dd91 output_operand(rtx_def*, int)
???:0
0x81e5a4 output_asm_insn(char const*, rtx_def**)
???:0
0x8226a8 final_scan_insn(rtx_insn*, _IO_FILE*, int, int, int*)
???:0
Please submit a full bug report,
with preprocessed source if appropriate.
Please include the complete backtrace with any bug report.
See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.
{standard input}: Assembler messages:
{standard input}:11800: Warning: end of file not at end of a line;
newline inserted
{standard input}:11856: Error: missing operand
{standard input}:11856: Error: invalid operands for opcode
{standard input}:11837: Error: displacement to undefined symbol .L2699
overflows 8-bit field
{standard input}:11690: Error: pcrel too far
{standard input}:11705: Error: pcrel too far
{standard input}:11707: Error: pcrel too far
{standard input}:11712: Error: pcrel too far
{standard input}:11719: Error: pcrel too far
{standard input}:11732: Error: pcrel too far
{standard input}:11737: Error: pcrel too far
{standard input}:11760: Error: pcrel too far
{standard input}:11772: Error: pcrel too far
{standard input}:11777: Error: pcrel too far
{standard input}:11778: Error: pcrel too far
{standard input}:11788: Error: pcrel too far
{standard input}:11791: Error: pcrel too far
{standard input}:11807: Error: pcrel too far
{standard input}:11809: Error: pcrel too far
{standard input}:11844: Error: pcrel too far
make[4]: *** [/builds/linux/scripts/Makefile.build:243: fs/namespace.o] Error 1


kernel: 6.7.0-rc2
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_ref: master
git_sha: 07b677953b9dca02928be323e2db853511305fa9
git_describe: next-20231121
Test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231121

Regressions (compared to build next-20231117)
------------------------------------------------------------------------

sh:
  build:
    * gcc-8-allnoconfig
    * gcc-11-tinyconfig
    * gcc-11-allnoconfig
    * gcc-8-tinyconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231121/testrun/21199202/suite/build/test/gcc-11-tinyconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231121/testrun/21199202/suite/build/test/gcc-11-tinyconfig/log


--
Linaro LKFT
https://lkft.linaro.org
