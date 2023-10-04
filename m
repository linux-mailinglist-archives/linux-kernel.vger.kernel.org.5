Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D0D7B860E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbjJDRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbjJDRCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:02:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184D95
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:02:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967B1C433CA;
        Wed,  4 Oct 2023 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438944;
        bh=/jwS8DV3jsMCn4Bp8MLvmgTr4VDd3Ub42uJVGkJX6hs=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=FO0o3KMQIq5odmdGVS4GdB9w+/9pTPhf6vIZ4Fa0+F9RA+3A7B3QYkPjiLBkTiw8T
         sWUa9WDXpryvCkoPR49IQkgDkJH/zr3WhcAkR3/EOUDet9pzsHF9zT3U3uUQPzHF8W
         uBFuRxg0vOklVC/DVJuOGWuY+GXQsOhauWKZSqAuDtMOVxlcHrM+FcR5dRyzomtbFY
         7uR6Tq3zQ9hPhkI6YCFezizQ0EH2UFMURoDC9f3qDTYoaq1S7OMww0v+2TD3h85qLB
         4Nx0mrOUlNSbrmzT9d1bq6ufRZ/1W5WMOvUIFPFer0lB0P3oNSFusLYJz1+i0B1zxa
         dM0vJJCfFXICg==
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
Subject: Re: [PATCH v2 3/8] riscv: report perf event for misaligned fault
In-Reply-To: <20231004151405.521596-4-cleger@rivosinc.com>
Date:   Wed, 04 Oct 2023 19:02:22 +0200
Message-ID: <87cyxuuxr5.fsf@all.your.base.are.belong.to.us>
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

> Add missing calls to account for misaligned fault event using
> perf_sw_event().
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
