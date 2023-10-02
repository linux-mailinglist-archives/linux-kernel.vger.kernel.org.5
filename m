Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861137B5693
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbjJBPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbjJBPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:32:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A270AC;
        Mon,  2 Oct 2023 08:32:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BB6B86E2;
        Mon,  2 Oct 2023 15:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB6B86E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696260741; bh=WKwix5ltgB/Rv47bjZiYblkMD2/CI4dSq0MKwEEmH7w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OwSsZDW/5ye5r388TvoSDEcESUIR+xj07++SnzEsA5gsZDHH3iMedoo+rgSmNAXqh
         1RA37+x960flUtH4LLp60ZDAAAUpQhklj8Ighq0ajc6085S63fRLMo/VQYf2LWRD0u
         DS3qyUr4WrfZ641H8L4Gjty76PwdOXh+1ZycePTG/hOjjiqc9BEkf2xgJY1KnPJ63U
         3+ToPlOlnI7X2a37oLoIOuW8QsawBQG1VBP3KIWEDzUYyDbOsWweXAoJ483CyhK/36
         qTNo8tyxs4rLyqZYzRvOCiBd7GRbdYQkRF3p9XpTcWvR22uWaaCpdlUPbXCVtjIE0Z
         2V/LRYh7ePROQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
In-Reply-To: <20231002-panoramic-submersed-7f5bfd8d1e76@spud>
References: <20230928103134.2779459-1-costa.shul@redhat.com>
 <20230930-mauve-jargon-0f7760fd262d@spud> <87h6nbka8x.fsf@meer.lwn.net>
 <20231002-panoramic-submersed-7f5bfd8d1e76@spud>
Date:   Mon, 02 Oct 2023 09:32:21 -0600
Message-ID: <875y3phwfu.fsf@meer.lwn.net>
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

> On Sat, Sep 30, 2023 at 08:26:38AM -0600, Jonathan Corbet wrote:
>> Conor Dooley <conor@kernel.org> writes:
>> 
>> > On Thu, Sep 28, 2023 at 01:29:42PM +0300, Costa Shulyupin wrote:
>> >> and fix all in-tree references.
>> >> 
>> >> Architecture-specific documentation is being moved into Documentation/arch/
>> >> as a way of cleaning up the top-level documentation directory and making
>> >> the docs hierarchy more closely match the source hierarchy.
>> >> 
>> >> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>> >
>> > This doesn't apply to riscv/for-next or next/master, with git
>> > complaining about the sha1 being lacking or useless. What does this
>> > actually apply to?
>> 
>> docs-next, I would guess (though I haven't had a chance to try it).
>
> I'm far from the world's best git-er, but doesn't the lacking or useless
> report from git while trying to apply the patches mean that this patch
> depended on commit that is not in next/master (which I assume includes
> docs-next).

It just means there's a divergence somewhere.  One tree has a patch that
the other lacks, and that creates a conflict making the whole thing
fail.  Business as usual...

jon
