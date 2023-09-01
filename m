Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7D78F804
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbjIAFdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjIAFdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:33:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751FE7E;
        Thu, 31 Aug 2023 22:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YZPgpChgnOdkkjbZLm4uCY678/7pNJpKyUpTmTDyQog=; b=su2xVevYCKnwYLmHD1FRSZM0rB
        yY3II0uznXcrPUeQe4aFK3H6pUJIQz8xb/wwbCh46ibUHMUCfnEcM2mtGL9/KyRnGzmycOukJX/3J
        S+rdOiDKkvwLqiXdi4HvS7khiMFUcmFM2BGoG1styTcS2r/Iuvsa2HWeRrjPOtPw4nhDuXG1zpZCS
        cJ6OFkkolWZqagunuBU4Vwi7slu5oFFLfmpI51v7eiFNSnHqQyP7fSKiISMd4/TfDU04/t62ItlfO
        gebXUN8yz31wwOo0wfZYr74RF2Tj5BlaGCCyxmYBDltr1NYpUtYjbM+4YhbgWHuRyQLc9P2/uAGTw
        lkhtLRYA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbwmr-00GUx1-2O;
        Fri, 01 Sep 2023 05:33:41 +0000
Message-ID: <33a5e278-fb4b-b5db-e4f6-bb5a1e4228ef@infradead.org>
Date:   Thu, 31 Aug 2023 22:33:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 31 (riscv: ANDES errata)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
References: <20230831135535.13c67178@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230831135535.13c67178@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 20:55, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* include material destined for v6.7 in your linux-next
> included branches until *after* v6.6-rc1 has been released.  Also,
> do *not* rebase you linu-next included branches onto v6.5.
> 
> Changes since 20230830:
> 
> The risc-v tree gained conflicts aginst Linus' tree.
> 

On risc-v 32-bit or 64-bit, when CONFIG_MMU is not set:

32BIT:


WARNING: unmet direct dependencies detected for ERRATA_ANDES_CMO
  Depends on [n]: ERRATA_ANDES [=y] && MMU [=n] && ARCH_R9A07G043 [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

WARNING: unmet direct dependencies detected for AX45MP_L2_CACHE
  Depends on [n]: RISCV_DMA_NONCOHERENT [=n]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

WARNING: unmet direct dependencies detected for ERRATA_ANDES_CMO
  Depends on [n]: ERRATA_ANDES [=y] && MMU [=n] && ARCH_R9A07G043 [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

WARNING: unmet direct dependencies detected for AX45MP_L2_CACHE
  Depends on [n]: RISCV_DMA_NONCOHERENT [=n]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

WARNING: unmet direct dependencies detected for ERRATA_ANDES_CMO
  Depends on [n]: ERRATA_ANDES [=y] && MMU [=n] && ARCH_R9A07G043 [=y]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

WARNING: unmet direct dependencies detected for AX45MP_L2_CACHE
  Depends on [n]: RISCV_DMA_NONCOHERENT [=n]
  Selected by [y]:
  - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y]

../arch/riscv/errata/andes/errata.c: In function 'ax45mp_iocp_sw_workaround':
../arch/riscv/errata/andes/errata.c:29:23: error: storage size of 'ret' isn't known
   29 |         struct sbiret ret;
      |                       ^~~
../arch/riscv/errata/andes/errata.c:35:15: error: implicit declaration of function 'sbi_ecall' [-Werror=implicit-function-declaration]
   35 |         ret = sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
      |               ^~~~~~~~~
../arch/riscv/errata/andes/errata.c:29:23: warning: unused variable 'ret' [-Wunused-variable]
   29 |         struct sbiret ret;
      |                       ^~~

64BIT:

I don't see the Kconfig warnings, just the error/warning messages from errata.c

-- 
~Randy
