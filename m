Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B007DC0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJ3TnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3TnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:43:16 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E1E12B;
        Mon, 30 Oct 2023 12:43:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C00813200406;
        Mon, 30 Oct 2023 15:42:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 30 Oct 2023 15:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698694979; x=1698781379; bh=PsJGzIrCBaCrtIhZZeL7C9rcuU0UA6MoDzw
        fDN8leh0=; b=aTSqkCi/UkHAgEcDYLMzvljR2j0i10ePIhRtfm7CoXaJHUkw2aE
        vZONa/bqGH9wb5ugST4+nqiGpj7ZzXwc0Vhk1z8qVIKRP7QWdBtN0vbzkgTe6EmL
        4rwp3Z3V95TV04oj6CPhENG2IoX2BWgTnqBquoK7b4xWaMdFiBCKFjDn4VQW5Nfb
        dM08Pr4Cam5LYvJiSWCe6wrsU6gab9DE0DRv/GvZIdNhL3DWiZBW6AC2hKF6DzBi
        cl7K9rF1RHU6+v+ciADGICpgtMJKB96sTeauVGvWlfDMu8KBhGUrbBFHzjrw1dmi
        GGA4ng/yJ3ByL56MYLM+y0d0Rd8gjJPO1aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698694979; x=1698781379; bh=PsJGzIrCBaCrtIhZZeL7C9rcuU0UA6MoDzw
        fDN8leh0=; b=rvMMKeKDBPCbQEBe2Yit4ba8thhPfFHAw2/0MY5fififDYLOXFY
        2avPCyj5SkQR18+b1B5NrxTDL0/ZsOxclsUjHeCC5xxBRbTi45fHZ4QGPJmlg6FX
        4sbtTiW7D8wYB1QgZoU0gDwPIvysdSRBm813zwfSC+OqYl/NoA1cFfNDkRoR2Dts
        Zupg2YTXwJ4K+aWPFcg4ztbt6mTa6IEoUTQbXoBb6KcTXuf7ZtZ5X9v1IXWrCfjE
        DJotWh2HniZCZsqbSyutgwYOR2zUpMNjapRRbcR41yLP7pXNxjJwl9yL3+C5RSPG
        vBub2lQ7flXsQ6UuTlyTofw7QCfp7D8rD9Q==
X-ME-Sender: <xms:QgdAZcieN50pRRnI2-eWiPKpUVobzlb6EBM23A1Mc-ghx9k2zZcMrQ>
    <xme:QgdAZVBnrAE9p7YJQJmDE38ZyBicXcy8UF1qCvs7cWDm8EV4d1tg5Ae7O2PYFP8LM
    lRv7vP5kuzD1Vw0ng>
X-ME-Received: <xmr:QgdAZUE1WjDlTkiq1pprtCR6WrgM3HD46akcVk-VNkFusadXmlMAEEWzrF4-PPvCXtbKoYhRivR6h97Iq_ot0h9VBBXlDkHVRgzXNqDzbdVaSloSiaSKaPXt1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepvddutdekleevvefhkefhleeiieevkefhfeduheelgfejkedv
    jefhkeeihedtlefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:QgdAZdR-EF36o4ElkXWVudVEWWMgcody3IABqLhnCoX2shFITH8hFg>
    <xmx:QgdAZZw8rHHcLomsSvzj0tferT1qKzxOTadgZhlhMlRKLHGHFb4hBA>
    <xmx:QgdAZb6SgM2lJ6UdX9rkPlcEQ08kEGKl6e-idRaM686Ry6hMKqVKmQ>
    <xmx:QwdAZR9S1XXGEFAIGQE-UoC6b5m35kldr7CDufC4FLIkXmvSgLNTMA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 15:42:57 -0400 (EDT)
Message-ID: <e63664ce-de35-7072-c081-9191df89d5f4@sholland.org>
Date:   Mon, 30 Oct 2023 14:42:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: linux-next: duplicate patches in the risc-v tree
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <mhng-b6345abb-81b3-450c-ae11-deed854821dc@palmer-ri-x1c9a>
Content-Language: en-US
In-Reply-To: <mhng-b6345abb-81b3-450c-ae11-deed854821dc@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 13:15, Palmer Dabbelt wrote:
> On Sun, 29 Oct 2023 13:56:29 PDT (-0700), Stephen Rothwell wrote:
>> Hi all,
>>
>> The following commits are also in Linus Torvalds' tree as different
>> commits (but the same patches):
>>
>>   767423658d53 ("riscv: kexec: Align the kexeced kernel entry")
>>   fe2ed36d419f ("riscv: Remove duplicate objcopy flag")
> 
> Sorry, but I'm lost here -- I'm not sure if I've managed to screw up git
> again?  If it helps, I'm not seeing the same commits here:

Each of these commits (separately) is a duplicate of a commit in Linus's
tree:

$ git range-diff v6.6...riscv/for-next | grep -v ' [<>] '
1441:  505b02957e74 !    2:  fe2ed36d419f riscv: Remove duplicate objcopy flag
    @@ Commit message
     
         Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
         Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
    -    Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
         Link: https://lore.kernel.org/r/20230914091334.1458542-1-songshuaishuai@tinylab.org
    -    Cc: stable@vger.kernel.org
         Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
     
      ## arch/riscv/Makefile ##
 297:  1bfb2b618d52 !    4:  767423658d53 riscv: kexec: Align the kexeced kernel entry
    @@ Commit message
     
         Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
         Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
    -    Link: https://lore.kernel.org/r/20230906095817.364390-1-songshuaishuai@tinylab.org
    +    Link: https://lore.kernel.org/r/20230907103304.590739-3-songshuaishuai@tinylab.org
         Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
     
      ## arch/riscv/kernel/elf_kexec.c ##
