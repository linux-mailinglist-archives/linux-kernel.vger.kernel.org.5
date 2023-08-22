Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41007783B72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjHVILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjHVILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DFE9;
        Tue, 22 Aug 2023 01:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A094C6147F;
        Tue, 22 Aug 2023 08:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99528C433C8;
        Tue, 22 Aug 2023 08:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692691873;
        bh=dP7XQ0sCXAruh+GpITOqH5w9X6cDXAv3cJsgzKeIU5Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cmF9bCzW3ZTBmxrwDqSFLRomoVyePOb6UicYk6s0az7G6Zgw/xsfCoPX5gpakSpzZ
         YKZ9tPbcTmtbXJdGnpIvf/3Y54Kc5R/qSQnwJGGADLPCHhX7dpK3Hvtw5jW1TgGQbg
         ssP6xcaDa537UbAWX80ipw5Qf/PlnbJPdMukidpNLR3DGXayDmusx9PqxWFFt8OGgb
         qu3qHAyK0gtGtV+27EI/nFQnwIe6IhfH/KkrcpK1NDNlZCgB+RxXk4Lzs2GcpTIppK
         APmJy5Lbzd6AWl3TFzZ1rGFECKPuQdKHB3UJVtm7eSfU+LMWjpLVDJpPhofZDSdG5S
         QbS35/3ipEMYw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for Aug 21 (riscv-64 asm)
In-Reply-To: <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
References: <20230821164605.7bac05f1@canb.auug.org.au>
 <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
Date:   Tue, 22 Aug 2023 10:11:11 +0200
Message-ID: <87ttsr33a8.fsf@all.your.base.are.belong.to.us>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> On 8/20/23 23:46, Stephen Rothwell wrote:
>> Hi all,
>>=20
>> Changes since 20230818:
>>=20
>
> ../arch/riscv/kernel/traps.c: In function 'do_irq':
> ../arch/riscv/kernel/traps.c:384:1: error: s0 cannot be used in 'asm' here
>   384 | }
>       | ^
> ../arch/riscv/kernel/irq.c: In function 'do_softirq_own_stack':
> ../arch/riscv/kernel/irq.c:94:1: error: s0 cannot be used in 'asm' here
>    94 | }
>       | ^
>
>
> 2 out of 10 risc-v 64-bit builds failed with these errors.
>
> Is this a toolchain problem or something else?

Hmm, do you have a link to config/toolchain/log, or similar?


Thanks!
Bj=C3=B6rn
