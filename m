Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8003790021
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbjIAPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbjIAPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:46:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053510EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:46:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso17255955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693583163; x=1694187963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1R8cu2Rdkpj6XMRvNWBpmLNwrpbIVxL/eXVOeZ+iSO0=;
        b=nIT8WwgBju7tct3iZ1xBs58pQNAM/cl8ogtHYimg7+U7zBWqEWD+w9I/INlviAc1wB
         viHuOvghzQdm3A5vXhwthwmNn92VchZTEcYzaA67G1E0z4ODasRr23wBzhnP1bTWeKnK
         xsCy6S/n+wjpFvYDKn5fIRxSmK9usb2Mnq5uelHAi4B1P/PK8MM7osLxRFoAmoiQ0hwE
         Mi6zJhMPnmsjNkYb9YlOlzNam7HJy5xmAS715vX32ldftwaq0epc0Jok37nnvzqavjW3
         0eJmb9aAFjohEY19n7+Ffjy56p3Aq5pMJ1hoha2nKcGuxrWNkKayIvOLxfhMpLx+ddX/
         dLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583163; x=1694187963;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R8cu2Rdkpj6XMRvNWBpmLNwrpbIVxL/eXVOeZ+iSO0=;
        b=FzxVf58zXn+E+5kfY3WHpsmgpX+zqWh6p8/i4/65qgghLZS7SeDFc3D+HsLPpnUr7s
         rwFx4CyO2RAmfdi7FKa4nS9d0XmJlKw7KovT+MOu+UBwVF8MZBoqVeHWqGTKTUZP0ntG
         pywoi+1kv583+TCO4ZMbASMvQeZLW0h7c3nkttDud2x1xWfb7PCw5CQC/TX7YovNB+/l
         Z7HeuVoyJB8uypVeBHYxxrazW5Fat2Hu7ZbtAXi7KipLY89wUSWLahxuwsdULH9jCHjw
         LHYh+HaVf034Tgsb3xlrnMuTy4VUmSPa+f+rpcAVIx/5RWxhInNysv6roIZAI6LX6HqK
         Z9UQ==
X-Gm-Message-State: AOJu0YzmLN/5wkVqO7ASXJCSdgeIzYj+7UhTYAMbyVV6k9OmpvON5BI+
        VJzD8/+57LGllcTkB9V2KIVBRQ==
X-Google-Smtp-Source: AGHT+IFBPiz/oDpMkVPJW/ecmphVC2B6/R4tEIduQRDxQo3/I5fA8c86djWpF58crQyhEknq21RGTQ==
X-Received: by 2002:a17:902:d48e:b0:1bd:ccee:8f26 with SMTP id c14-20020a170902d48e00b001bdccee8f26mr3548219plg.15.1693583163229;
        Fri, 01 Sep 2023 08:46:03 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d2d100b001acae9734c0sm3119517plc.266.2023.09.01.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:46:02 -0700 (PDT)
Date:   Fri, 01 Sep 2023 08:46:02 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Sep 2023 08:46:00 PDT (-0700)
Subject:     Re: linux-next: manual merge of the risc-v tree with Linus' tree
In-Reply-To: <CAKwvOd=buFcfe3Ho7EfdTPQwDF06K90onCHaeCtd=w0Y2NQm7w@mail.gmail.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Walmsley <paul@pwsan.com>, alexghiti@rivosinc.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ndesaulniers@google.com
Message-ID: <mhng-9e6725d0-707e-4350-a201-301f5aeaeb07@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 10:50:15 PDT (-0700), ndesaulniers@google.com wrote:
> On Wed, Aug 30, 2023 at 4:29 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the risc-v tree got a conflict in:
>>
>>   arch/riscv/mm/kasan_init.c
>>
>> between commit:
>>
>>   d2402048bc8a ("riscv: mm: fix 2 instances of -Wmissing-variable-declarations")
>>
>> from Linus' tree and commit:
>>
>>   56e1803d9de0 ("riscv: Mark KASAN tmp* page tables variables as static")
>>
>> from the risc-v tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>
> Fix LGTM; I guess Palmer you may need to rebase that branch on mainline?

Looks like I just missed it and Linus fixed it up, sorry about that -- 
for some reason my email hadn't been landing locally, I just fixed that 
too ;)

>
>>
>> --
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc arch/riscv/mm/kasan_init.c
>> index a01bc15dce24,435e94a5b1bb..000000000000
>> --- a/arch/riscv/mm/kasan_init.c
>> +++ b/arch/riscv/mm/kasan_init.c
>> @@@ -22,9 -22,10 +22,9 @@@
>>    * region is not and then we have to go down to the PUD level.
>>    */
>>
>> - pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> - p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
>> - pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
>>  -extern pgd_t early_pg_dir[PTRS_PER_PGD];
>> + static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> + static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
>> + static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
>>
>>   static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
>>   {
>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
