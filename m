Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A67785059
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHWGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjHWGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:08:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98CE59;
        Tue, 22 Aug 2023 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692770920;
        bh=HCRf0bYitUgJeoYadT30o4Zk+mj/zJgeLxF71JImRUM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GFCnvMBqQ9inmxKAjf96S7+//Z9WNjbTaQP69TIaeMNHJ65k0waZvcUz2DBlnLsg+
         mvyUbdPXSNsg5o/meCvX/NlJk5xwKYKegp7C2ZR71n0xDxDOYgffGwbmHpc1+Fjr/Q
         +C8LvaU2skkBxVM3uHTCZj8l0G8xa0/wCbupV2rz4dCUSlK65n4mUmxJy9DMoqYZ3/
         ynP52v9TTKhlE9e949ZztF9Vke09uRhyjNsNAYKqqZm+IZhYMi0P5HZMwyQN9AVJfX
         zdOfuVWxW8K0fnS0oH4BmlskBmQsevNvF5NoR/hO/N2mvP6/Wmvml4o6UO1+vsBr1l
         InorIjv7oXL+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVwkw1zKjz4wxn;
        Wed, 23 Aug 2023 16:08:39 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the powerpc tree
In-Reply-To: <2023082218-pecan-chef-e4bc@gregkh>
References: <20230818145826.00c7ead1@canb.auug.org.au>
 <2023082218-pecan-chef-e4bc@gregkh>
Date:   Wed, 23 Aug 2023 16:08:39 +1000
Message-ID: <87sf8auw7s.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> On Fri, Aug 18, 2023 at 02:58:26PM +1000, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Today's linux-next merge of the tty tree got a conflict in:
>> 
>>   arch/powerpc/include/asm/fs_pd.h
>> 
>> between commits:
>> 
>>   e6e077cb2aa4 ("powerpc/include: Declare mpc8xx_immr in 8xx_immap.h")
>>   fecc436a97af ("powerpc/include: Remove mpc8260.h and m82xx_pci.h")
>>   fbbf4280dae4 ("powerpc/8xx: Remove immr_map() and immr_unmap()")
>>   7768716d2f19 ("powerpc/cpm2: Remove cpm2_map() and cpm2_unmap()")
>> 
>> from the powerpc tree and commit:
>> 
>>   c2d6c1b4f034 ("serial: cpm_uart: Use get_baudrate() instead of uart_baudrate()")
>> 
>> from the tty tree.
>> 
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>> 
>> Note that after all the above are applied, it looks like this file can
>> be removed completely as nothing in the tree includes it any more.
>
> Thanks for the notice, I'll let the ppc developers remove it as it's in
> their tree.

Ack.

cheers
