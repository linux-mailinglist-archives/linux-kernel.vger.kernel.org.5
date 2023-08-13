Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559A77AB24
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHMUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:20:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499110F9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58DE60E07
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D367EC433C8;
        Sun, 13 Aug 2023 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691958044;
        bh=4c9Nf0xCFNZxfPRt4PlZyVsc+0YLNfixZSDSHDUw0jA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kbgnKHJuhrQSID8NCvBNxiKkQ85EEKEim4uacdl5bqSV9FcdOOa42L2xbef9HPoZW
         ayelpyjakJg63h0I9RoWxdIL/tOx0dUoV4ifR33Vb5QZpyu9TJsLneM7DVhgPb7dml
         F3APjUXxBTMSPyIhavL/1RcbMo1s1hA/lZg8U06lB2ZL9Ru6UThJ5hCPCllLjacBab
         q/GhCxtg0u1FcZjTNWzsEqmj83d2ov7RmtiIOt3Xgb7/Ty0DsPgDKa6bVdos0bVxxO
         Isd+h6n/EYzsuSM/42vN03WB/iCBzp7QvHQU91Ow6yDsleSCA7nX2IdAYDbXmxj+10
         AxsJ7pddBfYAw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: Re: [PATCH bpf-next 1/2] riscv: Extend patch_text_nosync() for
 multiple pages
In-Reply-To: <20230720154941.1504-2-puranjay12@gmail.com>
References: <20230720154941.1504-1-puranjay12@gmail.com>
 <20230720154941.1504-2-puranjay12@gmail.com>
Date:   Sun, 13 Aug 2023 22:20:41 +0200
Message-ID: <87y1ie1yp2.fsf@all.your.base.are.belong.to.us>
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

Puranjay Mohan <puranjay12@gmail.com> writes:

> The patch_insn_write() function currently doesn't work for multiple
> pages of instructions, therefore patch_text_nosync() will fail with a
> page fault if called with lengths spanning multiple pages.
>
> This commit extends the patch_insn_write() function to support multiple
> pages by copying at max 2 pages at a time in a loop. This implementation
> is similar to text_poke_copy() function of x86.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
