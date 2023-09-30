Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A777B40E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjI3O0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbjI3O0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:26:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E351FD;
        Sat, 30 Sep 2023 07:26:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E1CE06D6;
        Sat, 30 Sep 2023 14:26:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E1CE06D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696083999; bh=+zJwzVA6xYPyFirYQsaCDkrq4i+jIS3PORmpAYYOKtc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mhhN1LL7SrQf5o37LFQCYsx+OoJ/Jm7J2L3SGmhIpwh4RwXC4WP9H2nUpfMh62GIL
         pPyNZVHJ2gvunI7ZXyd46xxKMsw8DWLflFrBoHk+5+uWaWpn6S2YlBVcHtZgDmm6+5
         5hP6kE3Gi7nSUU3vk+tzfTodEOgnYoJrNh/Uqid5ekOaMkaW6x8U8V+B/LPV3K4k2l
         MT/i/ljPrE/BpwbszyfmxpCFQcKDg/9TEfQcy7amFVSJL3R3WA1yY9ByWoA1O6grCB
         e/DUnumkbTR7KT6vRx9Cykxpfy8qvpXCGBSDaKId+yqXzoltWa68rOSAFKz13nyJe3
         KiEAWOCVjmxIA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>,
        Costa Shulyupin <costa.shul@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] docs: move riscv under arch
In-Reply-To: <20230930-mauve-jargon-0f7760fd262d@spud>
References: <20230928103134.2779459-1-costa.shul@redhat.com>
 <20230930-mauve-jargon-0f7760fd262d@spud>
Date:   Sat, 30 Sep 2023 08:26:38 -0600
Message-ID: <87h6nbka8x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Thu, Sep 28, 2023 at 01:29:42PM +0300, Costa Shulyupin wrote:
>> and fix all in-tree references.
>> 
>> Architecture-specific documentation is being moved into Documentation/arch/
>> as a way of cleaning up the top-level documentation directory and making
>> the docs hierarchy more closely match the source hierarchy.
>> 
>> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> This doesn't apply to riscv/for-next or next/master, with git
> complaining about the sha1 being lacking or useless. What does this
> actually apply to?

docs-next, I would guess (though I haven't had a chance to try it).  If
you would like to carry this through the riscv tree (which is probably
the most sensible option), I suspect Costa could be talked into
respinning it...?

Thanks,

jon
