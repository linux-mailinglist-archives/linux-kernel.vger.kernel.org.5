Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D9807610
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442696AbjLFRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379747AbjLFRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:07:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8968CD4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:07:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so26855a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701882473; x=1702487273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62swcpHmDcdrzEklgnBANJd/n5tMHFnHaZwN9QLuoRY=;
        b=EF46/yeWWRirY2RBRcPYQ2OWvyJzVsKHJYFj6ywrqkxTgrdYsttMqxrNqI6SSeHrSv
         S0xzorAS5Q1bwzLTiGnJa7wmtV8LtBNxMudH8NljiS1HsCoMwS5ZmxlkgY2AtepgvkNB
         TxyjZZqvr6q3SQNNO98vR5zRCaPJ+e+kOPYRsEq3a0GDbhJWPZwrDJj1Tr5gltR/OfSf
         /VDUx5fr20W1ETiTS0W1/HX0YpblGDvhzjCysJduhBPBTVugISfJtAl22yL2WoAMHzSj
         EUYEgMD0sUfvflqNfCB5p/Y8RVtf/WaG0KFghFAShOvbSxDCpvd90vqeMHLwj51RnWHx
         Hp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882473; x=1702487273;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62swcpHmDcdrzEklgnBANJd/n5tMHFnHaZwN9QLuoRY=;
        b=fOejVJ9xdnqxyHTKlELGgo6NXfnlzcpfOBxQjxh1/0B0HCFED4ajP8bLYDIjJ9A+7+
         kgYLDE+V4POiB+QhhVNfyFKfhEej4G89Iv8SYEZhPYKj9hXo+K9JoFIGgrjbXg/a2aG3
         FlOhjuApXYlD9QB0BTuCHkHIPIIBh//z3rOlNyQ0uQ7J1yGHiMxavDUjzooHer+DLzhj
         ykCTg+LPhE2d49gxH6NEt4d4+sfZnX+nR51WRdeMb3cH+P+mmYyGQNDwgNiK9iOR3d0h
         gER200RhX5Fvx8U2xrI2iFra0Es2h8RVWMIlQjhUo/4+kDcf3yjkNK0ggjuzt5hK66+l
         Xswg==
X-Gm-Message-State: AOJu0YwEe9LOMyOWxoChyGsq57FXvCUz8LRsNbRHwAyIXPz30yQ6m0lX
        9FaYEGDUQ2OT9ZM6s8C5rKzw9w==
X-Google-Smtp-Source: AGHT+IFNdOlSwSYRE5V19ix0+QEWJdVY39+A0aCl0rPmo2N3/BkNZKr80Gs2ypCNqOVZyHsks6oS4g==
X-Received: by 2002:a17:90b:8d0:b0:285:b67b:f435 with SMTP id ds16-20020a17090b08d000b00285b67bf435mr930224pjb.41.1701882472807;
        Wed, 06 Dec 2023 09:07:52 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a005a00b00286bf87e9b6sm76581pjb.29.2023.12.06.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:07:52 -0800 (PST)
Date:   Wed, 06 Dec 2023 09:07:52 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 09:07:45 PST (-0800)
Subject:     Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography implementations using vector extensions
In-Reply-To: <20231206074155.GA43833@sol.localdomain>
CC:     jerry.shih@sifive.com, andy.chiu@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, Conor Dooley <conor.dooley@microchip.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>, heiko@sntech.de,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ebiggers@kernel.org
Message-ID: <mhng-9f5b6a98-57f4-40a8-becc-93319bbed97c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 23:41:55 PST (-0800), ebiggers@kernel.org wrote:
> Hi Jerry,
>
> On Wed, Dec 06, 2023 at 03:02:40PM +0800, Jerry Shih wrote:
>> On Dec 6, 2023, at 08:46, Eric Biggers <ebiggers@kernel.org> wrote:
>> > On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
>> >> This series depend on:
>> >> 2. support kernel-mode vector
>> >> Link: https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@sifive.com/
>> >> 3. vector crypto extensions detection
>> >> Link: https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@rivosinc.com/
>> >
>> > What's the status of getting these prerequisites merged?
>> >
>> > - Eric
>>
>> The latest extension detection patch version is v5.
>> Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/
>> It's still under reviewing.
>> But I think the checking codes used in this crypto patch series will not change.
>> We could just wait and rebase when it's merged.
>>
>> The latest kernel-mode vector patch version is v3.
>> Link: https://lore.kernel.org/all/20231019154552.23351-1-andy.chiu@sifive.com/
>> This patch doesn't work with qemu(hit kernel panic when using vector). It's not
>> clear for the status. Could we still do the reviewing process for the gluing code and
>> the crypto asm parts?
>
> I'm almost ready to give my Reviewed-by for this whole series.  The problem is
> that it can't be merged until its prerequisites are merged.
>
> Andy Chiu's last patchset "riscv: support kernel-mode Vector" was 2 months ago,
> but he also gave a talk at Plumbers about it more recently
> (https://www.youtube.com/watch?v=eht3PccEn5o).  So I assume he's still working
> on it.  It sounds like he's also going to include support for preemption, and
> optimizations to memcpy, memset, memmove, and copy_{to,from}_user.

So I think we just got blocked on not knowing if turning on vector 
everywhere in the kernel was a good idea -- it's not what any other port 
does despite there having been some discussions floating around, but we 
never really figured out why.  I can come up with some possible 
performance pathologies related to having vector on in many contexts, 
but it's all theory as there's not really any vector hardware that works 
upstream (though the K230 is starting to come along, so maybe that'll 
sort itself out).

Last we talked I think the general consensus is that we'd waited long 
enough, if nobody has a concrete objection we should just take it and 
see -- sure maybe there's some possible issues, but anything could have 
issues.

> I think it would be a good idea to split out the basic support for
> kernel_vector_{begin,end} so that the users of them, as well as the preemption
> support, can be considered and merged separately.  Maybe patch 1 of the series
> (https://lore.kernel.org/r/20231019154552.23351-2-andy.chiu@sifive.com) is all
> that's needed initially?

I'm fine with that sort of approach too, it's certainly more in line 
with other ports to just restrict the kernel-mode vector support to 
explicitly enabled sections.  Sure maybe there's other stuff to do in 
kernel vector land, but we can at least get something going.

> Andy, what do you think?

I'll wait on Andy to see, but I generally agree we should merge 
something for this cycle.

Andy: maybe just send a patch set with what you think is the best way to 
go?  Then we have one target approach and we can get things moving.

> - Eric
