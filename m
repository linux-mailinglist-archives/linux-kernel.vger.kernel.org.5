Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981B87C04EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbjJJTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJJTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:48:00 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA298E;
        Tue, 10 Oct 2023 12:47:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 854832B2;
        Tue, 10 Oct 2023 19:47:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 854832B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696967278; bh=cSAnQCe5ozuzSh9BgixGZxQQjWIwqW45PYOSq7td7vo=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=CbxkbiA2JrjJ87nEvlpd4zsoRbQ4ntUP79tUocWMU9pnJORSrhJCLX37LCi/7ltAo
         WITACmB4Vlc/964LfUkHgKAF9Y25q5avKFSEcIZ4iZePafCyT4fZ64bvCM64UqBSPS
         GeGG1lnoJc8IZPoO3YsEYb0B8F5xlys1t70DBIlhp11QUSPjO6vf4Qen522cRhr4ft
         QzOe7XMIiED2pE+VUcRO3Nu9d2JikRoa6DEM+8obm4ubqwWHuXyB9tVmQAVWDMsypm
         8o5FZmBcAuol5goJcN6q8iJTK5zIMfq7Mi4Yneo6cunyfjVCZBdeKJ0gLZUzDNlPge
         ItpJaDMhQrsHA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v1] docs: move riscv under arch
In-Reply-To: <20230930185354.3034118-1-costa.shul@redhat.com>
References: <87h6nbka8x.fsf@meer.lwn.net>
 <20230930185354.3034118-1-costa.shul@redhat.com>
Date:   Tue, 10 Oct 2023 13:47:57 -0600
Message-ID: <87jzru5keq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> and fix all in-tree references.
>
> Architecture-specific documentation is being moved into Documentation/arch/
> as a way of cleaning up the top-level documentation directory and making
> the docs hierarchy more closely match the source hierarchy.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>

Applied, thanks.

This is the last of the arch moves!  Thanks again for helping push this
through to a conclusion.

jon
