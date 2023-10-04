Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF47B864E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbjJDRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjJDRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:19:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C559E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:19:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FDCC43397;
        Wed,  4 Oct 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696439945;
        bh=hktkQ8e02XAmCHESfpaCyX2Rd3CJA7zbCGndca64RZI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gjqL3T2xDqdV4NtxF0Ius5ZzqObjYEqWFrBD1tm+E83UkL9Y3tyiZybLdYlaa+oTT
         Z2ZPYoQRaV3LAD7RfO77yArupx8PgjJZau0sRzPrBz/sFHs0dlEFONqpiDaxnVHYRB
         gdzgwBQN0rciUnaidlAXj6pllXqrjAbsppJbmojVOsQqOM1gPiIYsg/MPT52qV7R+o
         SqpHeB8iUdFbLGa/KReWMX2Di/3b9evEtyvy+HTPF3G+Ebs6OiAYhH/Y7Zlq1lYhQG
         4JReTy2RoMkOGDWMvJOMrV8l+R5CykMdXPaQJ/4zD6LVuoGPV00qI8/2DQdTkK5/hz
         sbqZQid26XmGQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 8/8] riscv: add support for PR_SET_UNALIGN and
 PR_GET_UNALIGN
In-Reply-To: <20231004151405.521596-9-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-9-cleger@rivosinc.com>
Date:   Wed, 04 Oct 2023 19:19:03 +0200
Message-ID: <871qeauwzc.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> writes:

> Now that trap support is ready to handle misalignment errors in S-mode,
> allow the user to control the behavior of misaligned accesses using
> prctl(PR_SET_UNALIGN). Add an align_ctl flag in thread_struct which
> will be used to determine if we should SIGBUS the process or not on
> such fault.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
