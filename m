Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B681B77B187
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjHNGYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjHNGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:24:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20514195
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:24:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so2623229b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691994260; x=1692599060;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVal+SmPwyPXEWd8E/hW8Myn0EzYgFGiM97Uxtw14hQ=;
        b=gCJQuA3dsTfDJieIBSLrO57qTyyDyVyxEU+8UhRnxnPwlSoGZXlUqghn2upnUe+Mxp
         VbeISFKHoYYJy9eDGjF7uge9P3/hsVvZhbx4oHsnGttRZ+1Q2fBoOL3vjsXDUl0qHg4f
         i4fFIIlLGkuAU6O3tu9et3SlBYczV6tpUl5NxbdUHKGKAiMq5dAg15PX1v97Jv7TOvXt
         ROijNORYbXf47zQrEVWvS4AgAuw308X6aw2/uthYKEcDcw7uOxw4m5G+agmTpwFrPw5I
         nYLHGAIG8VFmzEFqTrgLMsUo1tH9I42+KbIUEV0/TaZkxSDVEausufKUbOrIh/VhjCzf
         S+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994260; x=1692599060;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVal+SmPwyPXEWd8E/hW8Myn0EzYgFGiM97Uxtw14hQ=;
        b=VO1TXeME9TMuAUp9H3pHV3F41yXob7Xf3X89HCYw2RiDQkpfiWPWoqgWFKv5vF0jqr
         zQtrBaladax65lwbGIrxvEwYZl6kI7iErIsUXXXnaSCe98s8uBJ959EedbtXRQhPaCLr
         uVgzKB2HxE3voxZuSMf+gM96/ckEjJhEfoCYm2ilPXjMxQNvGUSKQzJiEh7+6EhsIXqQ
         xPMmjNbCR585JZPgBqbhATPFSI9fhC48pg+5ZLnAqyo9SQYNXueBvTrnrtmL9+01PzoW
         2LAwJ8QDNR2IogQij7dtZiHBwrvFsYKCJLETcBjOSVlHbRt4Lr3varcqQu9lHgYcnzUc
         vZtA==
X-Gm-Message-State: AOJu0YwoOfVaf1hH9s4UyTcg/NL+rwJrrB68+l4Ibc4LcQeR53m6NXpp
        ZrloivSjd+UQAKFpkZgi6VY=
X-Google-Smtp-Source: AGHT+IG3UeHMP3uaM2nERoAOz2IwLxw1P/hOZpeV5uvZekc4E/A4TSFDrOfU7cwHb3eu20J/EFyE0Q==
X-Received: by 2002:a05:6a00:1915:b0:666:eaaf:a2af with SMTP id y21-20020a056a00191500b00666eaafa2afmr10781211pfi.14.1691994260525;
        Sun, 13 Aug 2023 23:24:20 -0700 (PDT)
Received: from localhost ([1.146.8.58])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79108000000b00686da0e163bsm7372165pfh.11.2023.08.13.23.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:24:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 16:24:15 +1000
Message-Id: <CUS1WM4XRDIT.2GTHPR1FHQKS2@wheely>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] powerpc/radix: Move some functions into #ifdef
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 9, 2023 at 6:01 PM AEST, Christophe Leroy wrote:
> With skiboot_defconfig, Clang reports:
>
>   CC      arch/powerpc/mm/book3s64/radix_tlb.o
> arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function '_tlb=
ie_pid_lpid' [-Werror,-Wunused-function]
> static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
>                    ^
> arch/powerpc/mm/book3s64/radix_tlb.c:663:20: error: unused function '_tlb=
ie_va_range_lpid' [-Werror,-Wunused-function]
> static inline void _tlbie_va_range_lpid(unsigned long start, unsigned lon=
g end,
>                    ^
>
> This is because those functions are only called from functions
> enclosed in a #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>
> Move below functions inside that #ifdef
> * __tlbie_pid_lpid(unsigned long pid,
> * __tlbie_va_lpid(unsigned long va, unsigned long pid,
> * fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
> * _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
> * fixup_tlbie_va_range_lpid(unsigned long va,
> * __tlbie_va_range_lpid(unsigned long start, unsigned long end,
> * _tlbie_va_range_lpid(unsigned long start, unsigned long end,

Thanks for doing this. Functions vaguely belong where they are, which
makes it slightly annoying to move them. Is it also annoying to add
ifdefs for each one where they are?

Thanks,
Nick
