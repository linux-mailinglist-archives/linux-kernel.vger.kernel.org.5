Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952577079F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjHDSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHDSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6894C18
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE2D620ED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF4AC433C7;
        Fri,  4 Aug 2023 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691172626;
        bh=7bRcPqBw1AJb6bBB+EAT619vN7OlXAeurQV5Wi2lxnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEKhRv+LufzZUV9H/g7aFDOMF5dmneT1c5025LnuiW0JszqsGUtDEG59bizYL/ugq
         m4kElPK/LERNS8e6puLCSRA0u/3mP2KMszLsxDzxz79TYd2S/M/s3r2rk4ogSompQQ
         M76ROqVWhtRjaCeuZ+5t5NkQGE3FunJtLjbFD+56C56ipyafaTAaQjxz5297/XPRph
         NfG1C5imHqNW9UVU288dJAa3ep6rc6jcboSm3Lefk1RjR4XG+AueKysayiWG7NTBLr
         dfbjXdVXhC6NvxoVJogXx/WzwywxJ72ZWg4O60hPOFcsK5SWutzJPc+xJlwsZJ4BM2
         GGTHUgdy5WVQA==
From:   Will Deacon <will@kernel.org>
To:     ryan.roberts@arm.com, joey.gouly@arm.com, catalin.marinas@arm.com,
        bhe@redhat.com, kristina.martsenko@arm.com, ardb@kernel.org,
        thunder.leizhen@huawei.com, mark.rutland@arm.com,
        Zhang Jianhua <chris.zjh@huawei.com>, yajun.deng@linux.dev,
        anshuman.khandual@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next v4] arm64: fix build warning for ARM64_MEMSTART_SHIFT
Date:   Fri,  4 Aug 2023 19:10:13 +0100
Message-Id: <169116598480.145836.10755378062074393749.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230804075615.3334756-1-chris.zjh@huawei.com>
References: <20230804075615.3334756-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 15:56:15 +0800, Zhang Jianhua wrote:
> When building with W=1, the following warning occurs.
> 
> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>   129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>       |                                         ^~~~~~~~~
> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>   142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: fix build warning for ARM64_MEMSTART_SHIFT
      https://git.kernel.org/arm64/c/4e0bacd65e72

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
