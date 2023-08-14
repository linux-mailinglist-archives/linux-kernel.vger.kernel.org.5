Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCD77B89F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjHNM2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjHNM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1A610D0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04349637F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14691C433C8;
        Mon, 14 Aug 2023 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692016094;
        bh=Qa+koGcZ/5SfZLsg97XT6OX2/jmgLU9/dkCdhrh7P3c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Yud9//x9voDwzwPvp9WpQ0koSWHLxbu0jxT0nux7+AWWP3yfK15S+XzhDbDMMLW+A
         JhDOt5Bz6V42v/04OwbD2Qp54rkClUnuvBxkxd22w8GeHrz105yJLIjMACqf3/nMSw
         8bggOSJuG8+5KOyw5dG/FiBOkmxZA226YHAsdz0QkViIDfFtK81l5XyBEvxd3yreFC
         JfoGzS82GhSWxqQR1jziKadK/LsXyGsHwSIplQJ5G84HdPFzpfqVmETdQhnFlga8QQ
         chBbfUyPtpKXE+asE83OcTNNrw/jLqcBrr1E0WK5HgGDnyCOVPboYasEXW4/tHNq5M
         z2Y/RzjSLv29A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: Re: test code for kprobe
In-Reply-To: <fc71730b9350026427fe1c2bdbce9b993d8bc6f5.1690704360.git.namcaov@gmail.com>
References: <cover.1690704360.git.namcaov@gmail.com>
 <fc71730b9350026427fe1c2bdbce9b993d8bc6f5.1690704360.git.namcaov@gmail.com>
Date:   Mon, 14 Aug 2023 14:28:11 +0200
Message-ID: <87il9hg65g.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nam Cao <namcaov@gmail.com> writes:

A RISC-V specific kprobes test -- much welcome!

Please add a proper commit message here.

> ---
>  drivers/test_kprobe/Makefile      |   3 +
>  drivers/test_kprobe/test_kprobe.c | 265 ++++++++++++++++++++++++++++++
>  2 files changed, 268 insertions(+)
>  create mode 100644 drivers/test_kprobe/Makefile
>  create mode 100644 drivers/test_kprobe/test_kprobe.c
>
> diff --git a/drivers/test_kprobe/Makefile b/drivers/test_kprobe/Makefile

Architecture specific test code usually reside in "arch/$ARCH"
(arch/riscv), and is part of Kconfig.debug.

Have a look at:
* grep for ARM_KPROBES_TEST in arch/arm
* grep for KPROBES_SANITY_TEST, and in arch/powerpc grep
  test_emulate_step
* grep S390_KPROBES_SANITY_TEST


Bj=C3=B6rn
