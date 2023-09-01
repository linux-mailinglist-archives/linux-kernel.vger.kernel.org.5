Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA81790096
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjIAQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbjIAQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:15:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E710FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:14:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdc19b782aso16098415ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1693584896; x=1694189696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G93qFbiZ0Pa27qlWWadHG4TtIzXjbNoLKN50FdpZHI=;
        b=Uwtv0wFA15O7a9eeHv0PYvoRwgP7mLb51xdNrPKnwgJIf5FleAc/jfDCKiAUoi2nkl
         5MFquBJi0bEvQjAFDtdYIOuZjlpnIxxHebMInlk+xdQBaPK5ZNCjwy8fzc6+Pv0vpzjw
         XimkhjG89r7XlYtqECHPtcwjnArpa8NTuNNHjCgaDNMBMjBGawhaIzsJZSMLbalrGGNE
         hSFHoRcJd+fG9QiyGKU57yr6t4wA4AQAWr+ZHqVjErPuul966d8KLlvlSnXaplHodUP7
         iJ+45fP7lwGbwf/WCkh73w5V6SCyk03IecueISXpvYkGI39dy4ItfoncgypN59u0op7Z
         a8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693584896; x=1694189696;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G93qFbiZ0Pa27qlWWadHG4TtIzXjbNoLKN50FdpZHI=;
        b=EDOuyFMANLZr1Cp8xt0LRVsw/gd3MdB2V1uOZmRp5Cx6JV76bh3fVjLS8DWskHzPJF
         SjgPy6VZP3Kgr20EBHyNi346Rso2zlm/XBUUTgHyQdDmls6nEUNNR4woXGpio1ChpTSI
         z78hSf1+eYKcOrNS19JGNdPzBAxVMvy4mIhHbSBV9JxYtLWbfgqWVnjx1CCElNJWh6d4
         QuyJrbSJJFck11Kpt1Ew993AYf8pKXjKDhUHmeyST7V1QExjUp1NdKbM2h7p08w5SovY
         J3f3ZYeEre24AGAELx5hNAkyoHEU2idu/4+XR4lUZZaPUjMOMA2OAwQdgdu1L2RGs2li
         ufnA==
X-Gm-Message-State: AOJu0YxLIq5bUoCP26zbIzGucoQZQh8z3wfVxKXmezreN85SOmXt5fQZ
        3BLC9bYyRQHQ9TUX9sELWgx64jA1VFjCN7lz1C8=
X-Google-Smtp-Source: AGHT+IE7oRbibb2gHXpKQsBvWgWTLAAcbjj6HDdxEQq7uFlPO01bSIbhSG3otP3Jzrv8pdG5Qv+MsA==
X-Received: by 2002:a17:902:e54a:b0:1bb:c7bc:ceb4 with SMTP id n10-20020a170902e54a00b001bbc7bcceb4mr3855141plf.60.1693584896067;
        Fri, 01 Sep 2023 09:14:56 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b001b9de2b905asm3172118plb.231.2023.09.01.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 09:14:54 -0700 (PDT)
Date:   Fri, 01 Sep 2023 09:14:54 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Sep 2023 09:14:51 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20230831075730.0dd941dd@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-09c3d557-b385-4501-9a39-0040b03edb48@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 14:57:30 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   dbe46b094026 ("RISC-V: Add ptrace support for vectors")
>   ed1a8872ff83 ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
>   f508b0175578 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
>   555dd72bc06e ("dt-bindings: cache: andestech,ax45mp-cache: Add DT binding docu  dbe46b094026 ("RISC-V: Add ptrace support for vectors")
>   ed1a8872ff83 ("soc: renesas: Kconfig: Select the required configs for RZ/Five
> SoC")
>   f508b0175578 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
>   555dd72bc06e ("dt-bindings: cache: andestech,ax45mp-cache: Add DT binding docu
> mentation for L2 cache controller")
>   30bc090f40f8 ("riscv: mm: dma-noncoherent: nonstandard cache operations support")
>   f2863f30d1b0 ("riscv: errata: Add Andes alternative ports")
>   93e0e2419b65 ("riscv: asm: vendorid_list: Add Andes Technology to the vendors list")
>   eb76e5111881 ("riscv: dma-mapping: switch over to generic implementation")
>   14be7c16d420 ("riscv: dma-mapping: skip invalidation before bidirectional DMA")
>   fbfc740ced8f ("riscv: dma-mapping: only invalidate after DMA, not flush")
>   b6e3f6e009a1 ("RISC-V: alternative: Remove feature_probe_func")
>   b98673c5b037 ("RISC-V: Probe for unaligned access speed")
>   26ba042414a3 ("perf: tests: Adapt mmap-basic.c for riscv")
>   60bd50116484 ("tools: lib: perf: Implement riscv mmap support")
>   57972127b20e ("Documentation: admin-guide: Add riscv sysctl_perf_user_access")
>   cc4c07c89aad ("drivers: perf: Implement perf event mmap support in the SBI backend")
>   50be34282905 ("drivers: perf: Implement perf event mmap support in the legacy backend")
>
> are missing a Signed-off-by from their committers.

Sorry about that, I must have screwed something up merging these and 
just found my email had been screwed up for a bit so I hadn't seen this.  
Luckily most of them were being given some more time to bake, but I sent 
up Alex's and Linus just merged them.  I'll try not to screw it up next 
time...

>
> -- 
> Cheers,
> Stephen Rothwell
