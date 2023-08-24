Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B47787898
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbjHXTge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbjHXTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:36:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A221B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:36:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc83a96067so2395525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692905775; x=1693510575;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wIorNWdyOim0Yl5+/O6guxDVdvD8pw8pKxbm7dcdPQ=;
        b=vkfnSDccPDleQWhZypW1vaQBlDMLohs76rDCLW1jIn9gS1PE25ocbxD3nx4CGayjiy
         xRFJ2Wtcx7SZUPtvClu/a/1a2m+o2CfJNuKyJQXM3crXLK4eHGIODYS7KAazwqXYoADm
         vVdYud4oxdyMI8mSMAp7B1I1GJu2PzM6oITVBUfY1B6S5XYuExLSIIQg3Ij8Renq/rxy
         tyzv7kiTH7j8otIZFX1IfaEeclwB1E/mJ0dpBzywnAkEO+UzIk5QbDHKFPIL3HFmtZdB
         lbKaYFUyCghRLvjEAcQgQ7EpVqFKVfX1lCfLlv9ACXCpgOpVeWL9c4NSkhAz1emRcE8z
         1gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692905775; x=1693510575;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wIorNWdyOim0Yl5+/O6guxDVdvD8pw8pKxbm7dcdPQ=;
        b=RvB5KPXX2RA+L8qDjVt3stkfYxiQ9P+LLmARj81aUhmDpQ8Sx3vcbKY/ZBvxfg3AeB
         QV7pDuwhoS7NZvf9jvkVCSBedk1eT24uK+q1zRVPcX0iR1b4ygbmUV4R1Iickn0a/VYa
         433i5//0gJNCP6kjhsuuh4Z6u/IaTfouaGdUzBkxCj8lBwoTQJpINXuPPLX9zpmgo6Tw
         FpBzjI/PMRnPLYcsooAbYX2eEdam4+Qu18OOXXTMtjHeymSQ9JWGWsz2x43eubCPnNO5
         IAKxRn6KQHfyVg0ZKFrpTIKIkGFzXiC9o5J/BRZkvg0+ZLOU5IDhzhDUPpwWo8lDycYV
         SAVA==
X-Gm-Message-State: AOJu0YzTobMhsfALLYXC0qND26WQ7oArXcdEPNB3NKpT1E2NQxy/YG/3
        uOkChlBVpTNhGDGRGN6wYhQN5g==
X-Google-Smtp-Source: AGHT+IFVrj1OzIkyNOoOCKQZ7jaR0afgTplscsaJzR2zemPpPXyzwEEXtz71kxOpimuVRf4ZW2UdOA==
X-Received: by 2002:a17:902:f80d:b0:1c0:c1ed:70c9 with SMTP id ix13-20020a170902f80d00b001c0c1ed70c9mr3100816plb.12.1692905774791;
        Thu, 24 Aug 2023 12:36:14 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001b8a3dd5a4asm24040plz.283.2023.08.24.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:36:13 -0700 (PDT)
Date:   Thu, 24 Aug 2023 12:36:13 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Aug 2023 12:36:08 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix build errors using binutils2.37 toolchains
In-Reply-To: <20230824-wimp-unvocal-c27df1798ae8@spud>
CC:     xingmingzheng@iscas.ac.cn,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bmeng@tinylab.org, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-72b1a20e-8bab-42f2-9a30-40f86038bba5@palmer-ri-x1c9a>
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

On Thu, 24 Aug 2023 12:25:36 PDT (-0700), Conor Dooley wrote:
> On Fri, Aug 25, 2023 at 03:08:52AM +0800, Mingzheng Xing wrote:
>> When building the kernel with binutils 2.37 and GCC-11.1.0/GCC-11.2.0,
>> the following error occurs:
>> 
>>   Assembler messages:
>>   Error: cannot find default versions of the ISA extension `zicsr'
>>   Error: cannot find default versions of the ISA extension `zifencei'
>> 
>> The above error originated from this commit of binutils[0], which has been
>> resolved and backported by GCC-12.1.0[1] and GCC-11.3.0[2].
>> 
>> So fix this by change the GCC version in
>> CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC to GCC-11.3.0.
>> 
>> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=f0bae2552db1dd4f1995608fbf6648fcee4e9e0c [0]
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=ca2bbb88f999f4d3cc40e89bc1aba712505dd598 [1]
>> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d29f5d6ab513c52fd872f532c492e35ae9fd6671 [2]
>> Fixes: ca09f772ccca ("riscv: Handle zicsr/zifencei issue between gcc and binutils")
>> Reported-by: Conor Dooley <conor.dooley@microchip.com>
>
> Closes: https://lore.kernel.org/all/20230823-captive-abdomen-befd942a4a73@wendy/
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks.  I queued this up into staging, it's building -- so is Linus' 
master, so it might take a bit to get through everything.
