Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319AF7929C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353045AbjIEQ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354845AbjIEPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:00:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96718C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:00:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26b47df332eso1259053a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1693926011; x=1694530811; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPvJLoyycJ8FP0yyR5An9IwotXlbUbPD3qnANIFUgNA=;
        b=2NpsyeMsbx5CPvLbZPXTkvCPiiHWIUWyM3/EYeLIk4Qdvk+LqH6ntbDzC/vOxTAzC4
         Ftak/dd72WLSm1nSIBqDBTOcbfv9TV696fbL2HJ2tXLvriEq0D7agwzOZNADgniGMaNM
         lKH2K3kDa5kIyzR/FhTFVh572clFJTPhb4Amh48oghpdzdqFBmjQ4xlrjeGWf+Oc50MM
         S4tKLAcdyqYyKpBFyTupSHViNIDpCYxcQT8+R5WYqJnE0YZb1/rBnZqm+Wv2T/TYCgwK
         dKGP33Nxb5TEnFKCT3S286OZBPDsbfiYzxpwHY7DDKnSVwfFfXSMy9KI+zYJj2RWxZca
         j/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693926011; x=1694530811;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iPvJLoyycJ8FP0yyR5An9IwotXlbUbPD3qnANIFUgNA=;
        b=llHHXcZNFkbtQCiXpUPqbOP4iiH0uEiCzPpbDWT8n8Z+St9opYSkcft170kJJgcpEO
         1SFFg8ZVlcmbPdwHISlwp94qcZOLMglR8guTUfAf3BBL9b2BICkU0Dy9VHlhWXeKrEzF
         YEOqyYiyoPRdpDjekEEw8tM07BASzFutyFU0KDsPriZYq3QtEc7lHZTQaovq4cU6xQyq
         UTFWRcRg9qZsZZpcLo29gPS9w5XGg1VYq3EgDZtMJ/KJp9PZUodfM3yf1TbtDBzNYApZ
         0gZCvs0oq+PA1rFjYS7QBLtRGEm2jRqx5zIoPDDVEsPBRK+tFR+JblDtnIXm2Y9XNsZt
         YvfA==
X-Gm-Message-State: AOJu0YwTw4MjpK8AdW/Y6oBruc7xYFuXRmB3zDh3BSnV+nYA5erH2gtX
        IbZTZ0TMvAlm+ncdarjDe7Oo/A==
X-Google-Smtp-Source: AGHT+IFLFt+j2AJFVoUL8TgAiutUSWnl+6SJXEKxttZm/NKF0d5BCmFn4HM4lXV0/Smqx+T418+RIg==
X-Received: by 2002:a17:90a:c90c:b0:269:2356:19fb with SMTP id v12-20020a17090ac90c00b00269235619fbmr9873947pjt.15.1693926010784;
        Tue, 05 Sep 2023 08:00:10 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902eed200b001b8a1a25e6asm9410186plb.128.2023.09.05.08.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 08:00:09 -0700 (PDT)
Message-ID: <6d8d829b-0ca5-8f8c-8b62-a9736b26b586@monstr.eu>
Date:   Tue, 5 Sep 2023 16:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 6.6-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these 3 patches to your tree. There should be other patches for 
Microblaze to go through Andrew's tree.

Thanks,
Michal

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.6

for you to fetch changes up to 0d2b49479bf91c857d83608da7b64328e556dff7:

   microblaze: Make virt_to_pfn() a static inline (2023-08-23 09:35:22 +0200)

----------------------------------------------------------------
Microblaze patches for 6.6-rc1

- Cleanup DT headers
- Remove unused zalloc_maybe_bootmem()
- Make virt_to_pfn() a static inline

----------------------------------------------------------------
Christophe Leroy (1):
       microblaze: Remove zalloc_maybe_bootmem()

Linus Walleij (1):
       microblaze: Make virt_to_pfn() a static inline

Rob Herring (1):
       microblaze: Explicitly include correct DT includes

  arch/microblaze/include/asm/page.h  | 27 ++++++++++++++------
  arch/microblaze/include/asm/setup.h |  2 --
  arch/microblaze/kernel/reset.c      |  1 -
  arch/microblaze/mm/init.c           | 16 ------------
  4 files changed, 19 insertions(+), 27 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
