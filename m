Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E95A7CA83D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjJPMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJPMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:42:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CFA2;
        Mon, 16 Oct 2023 05:42:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080E7C433C7;
        Mon, 16 Oct 2023 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697460142;
        bh=fxutcQlYAmEEzHYBSdkxdZPz6z6pMleu2JvtcW3RJA0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yl4wcWYpL3U3in8V1PbNCTRa5+IEntDWd90AVEb+rz8vGP83frH+Go1R/D5NUKGkt
         ULrnZuVx7hXL4mrwbLHDBfqvlBMV9sGNVM91204moqgTOFxcaxoHcpqTU1f+6Ab7Z/
         LFq7/Q8qcrSbkMF+8+v/W/TpmEKD5uL7VcuBLyVuEu54HpRmEXmMEXLBDniwNv5vK7
         +nd4wOL1kjtsQh6FTxVwT6SyCPFkg5YXLDlUURJzDpV2tfVvJ1XRF8DRE3LffIQVSX
         8Q/Uz9fAEY9UNyvBSaWk/APgvqpQ1erXxraUhheFRLM3CvF8wsP5EgolpOU3F0GhBm
         dkV0FtlSRxHNg==
Message-ID: <8a1c19dc-0a4f-4079-b2df-704ae647b1f8@kernel.org>
Date:   Mon, 16 Oct 2023 14:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate
 symbols for kallsyms
Content-Language: en-US, pt-BR, it-IT
To:     Petr Mladek <pmladek@suse.com>,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
 <ZR7jIxh/VNT6tMVr@oracle.com>
 <CAPp5cGThN5bKsGAqiVwOV2w4tH1LgjS3eoAgucaRwty4d8JVSQ@mail.gmail.com>
 <ZSU2dTTfLqIydSQU@alley>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <ZSU2dTTfLqIydSQU@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> In any case, as you've pointed out, duplicates can arise from names in code
>> that is not intended to be a module.
>> Therefore, relying solely on the module name would not fully address the
>> problem you initially aimed to solve.
> 
> From my POV:
> 
> The source path and the line number is enough to distinguish duplicate
> symbols even in modules.
> 
> The added module name would just add extra complexity into the kernel
> and tools parsing and using the alias. The tracing tools would need to
> handle the source path and line number anyway for symbols duplicated
> within same module/vmlinux.
> 
> Adding module name for builtin modules might be misleading. It won't
> be clear which symbols are in vmlinux binary and which are in
> real modules.

+1

-- Daniel
