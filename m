Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281587CA4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjJPKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJPKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:08:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704F83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:08:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3c8adb27so673131366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697450882; x=1698055682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfQl9vIo1Q4bgWONgiMcieW7xbQTrWGaH4cj7Q1KRsk=;
        b=iOJx2RXIPnE8iUm82eSxx3JyFt9+4XN+CdJZlNSE5ALguTZgiYBr3higHYESukwF8q
         Bvv2MWuqZ8CXfAHaD9tOFVIVKOaHEhQGoKk16rOTFPznY5iaSOC+JLtyELLxh4sHUW3R
         5ubdmSWgYkKmW/QhwBYVg1Fm+FSRfKHobjfoqRcd5p83NRlOp8Rg5NYSp0S8F6lA4uLg
         3eRGn4Cfc848gdiQJCkvvtjquZ2tPiNY4NN+nyZWLgHA45nqPHJ0l/cdMg3yivCk17Ji
         4tHDZB+wvyFpdzD3jKbcRa0QTQbsydEvYlzK9ehPfpJXFi6zsLXcAyH5abs8zwcmx72t
         KsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697450882; x=1698055682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfQl9vIo1Q4bgWONgiMcieW7xbQTrWGaH4cj7Q1KRsk=;
        b=s4P0nSo/LqJN0q/H5w7L1we6q/jwfK2Tou0FynK5RtZNALHyCGq9yA1AgiNJ/+BvDm
         Yc38BS8NSqsVkG2kR8rFV+Av0Nza1WXp+ARzXBsUZ2RqcV3GecKRWr40Iwl6XhX16MpK
         kJ3XIPdbfX1LAcriOO/xkTqj9pN0NTp//z4jHDiQDS3LjNUd9zynerYXS9557e/BLHES
         etNkroPOYS/fMQFHGM6fhJvcsZSBlhYF2lMT1ZfXhStuvG6+WUmkI9CLpWCBgkqaWhWD
         mH2ELRHms3UuII3NSC7nPdlg7SkXhlIeVsvpz5hYIrKRu0STM518HtgFfyF2iLTYsWxv
         jRIw==
X-Gm-Message-State: AOJu0YyUtjrgAzsY1RdoPbNiIrB2VwJBBW7l75HvjlFNT3Xq5drxc64u
        6r7kcn4eW/bMv/tqM154sluDgebl/fc=
X-Google-Smtp-Source: AGHT+IFIPVjetitvA9mTuRDhFIhGnIAaqxiQKn48DPTyO9U530Cbq4fNlwhIt2YAdMHNBJIZKCuQCQ==
X-Received: by 2002:a17:907:3f17:b0:9c4:b8c9:1bf3 with SMTP id hq23-20020a1709073f1700b009c4b8c91bf3mr1075060ejc.27.1697450882167;
        Mon, 16 Oct 2023 03:08:02 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id n25-20020a17090673d900b0099297782aa9sm3668311ejl.49.2023.10.16.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:08:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Oct 2023 12:07:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZS0Lfy8LUdRG3ca0@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
 <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 11, 2023 at 03:03:25PM -0700, Josh Poimboeuf wrote:
> > I wouldn't call it senseless churn.  There are concrete benefits -- for
> > both users and developers -- of having all the mitigation config options
> > living in the same config namespace.
> 
> I don't see it. What does the same namespace give you?

Having the current inconsistent Kconfig mess of CPU bug mitigation options 
is called 'technical debt', and it is a liability.

Just look at it in its messiness:

  CONFIG_RETPOLINE=y
  CONFIG_PAGE_TABLE_ISOLATION=y
  CONFIG_CPU_UNRET_ENTRY=y
  CONFIG_CALL_DEPTH_TRACKING=y
  CONFIG_CPU_IBPB_ENTRY=y
  CONFIG_CPU_IBRS_ENTRY=y
  CONFIG_CPU_SRSO=y
  CONFIG_SLS=y

Or current naming is confusing:

 - 'CONFIG_PAGE_TABLE_ISOLATION', which works around a CPU bug at hideous 
    runtime costs switching pagetables at every system call entry and exit, 
    reads like an isolation feature like CONFIG_CPU_ISOLATION=y, which is a 
    useful feature that improves worst-case latencies at essentially no 
    cost ...

 - 'CONFIG_CPU_IBPB_ENTRY=y' reads like a useful system call CPU feature. 
    Nothing in the name tells us that it's a workaround for a CPU bug, with 
    a significant runtime cost.

 -  What is CONFIG_SLS? It's a compiler-driven mitigation feature, with a 
    cost, not a driver for the Space Launch System.

 -  I could go on. Literally *every* mitigation feature Kconfig name we have 
    currently is problematic in one fashion or another: and all of them are 
    whitewashing the fact that they are expensive features to work around 
    CPU bugs...

All this mess was created due to arguably rushed fix-the-next-vulnerability 
time pressures of the last ~2 years, not due to some holy grand design 
decisions we wish to preserve as maintainers...

The first 2-3 mitigation options not being harmonized was understandable, 
because we really didn't know where it would stop. But we are up to ~8 
already.

Unless someone like Linus shuts down this effort with a NAK, this kind of 
harmonization would be welcome IMHO:

  CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
  CONFIG_MITIGATION_RETPOLINE
  CONFIG_MITIGATION_UNRET_ENTRY
  CONFIG_MITIGATION_CALL_DEPTH_TRACKING
  CONFIG_MITIGATION_IBPB_ENTRY
  CONFIG_MITIGATION_IBRS_ENTRY
  CONFIG_MITIGATION_SRSO
  CONFIG_MITIGATION_SLS

Efforts by competent people fixing this technical debt comprehensively are 
welcome in my book, as long as advantages are substantial and the 
inter-tree churn is not prohibitive - which I believe is true in this case, 
and churn effect can be reduced via smart timing of rename-patches in any case.

Thanks,

	Ingo
