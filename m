Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C07CB221
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJPSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjJPSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:12:42 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018BA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:12:38 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4S8QFF6Mk6z1r1s0;
        Mon, 16 Oct 2023 20:12:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4S8QFF4hgYz1qqlS;
        Mon, 16 Oct 2023 20:12:33 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id nOUV3jjqwywP; Mon, 16 Oct 2023 20:12:32 +0200 (CEST)
X-Auth-Info: de1F22Tx1RaWX4XjxP2PcfNuAuKKz9mapevqvNXhi42KR85gJB1zx+tHFwze0kZO
Received: from igel.home (aftr-62-216-205-237.dynamic.mnet-online.de [62.216.205.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Oct 2023 20:12:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 591EA2C1370; Mon, 16 Oct 2023 20:12:32 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/2] riscv: Add remaining module relocations
In-Reply-To: <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
        (Charlie Jenkins's message of "Mon, 16 Oct 2023 10:36:09 -0700")
References: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
        <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
X-Yow:  I'm ZIPPY the PINHEAD and I'm totally committed to the festive mode.
Date:   Mon, 16 Oct 2023 20:12:32 +0200
Message-ID: <87h6mqo2r3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 16 2023, Charlie Jenkins wrote:

> @@ -81,7 +82,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
>  #define R_RISCV_ALIGN		43
>  #define R_RISCV_RVC_BRANCH	44
>  #define R_RISCV_RVC_JUMP	45
> -#define R_RISCV_LUI		46
> +#define R_RISCV_RVC_LUI		46

The latest ELF psABI defines 46 as reserved.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
