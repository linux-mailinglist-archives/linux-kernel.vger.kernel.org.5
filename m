Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765DE75C1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGUIeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjGUIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:34:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CCB30C3;
        Fri, 21 Jul 2023 01:34:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so13908695e9.1;
        Fri, 21 Jul 2023 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689928447; x=1690533247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQAwCIhJQKqcYnCuAcDKHJfPf6lVhwCI1dubWC+OCok=;
        b=bI8ei4FEb7bBSYhgsSPUywSQ5XnjsSSLQavY2q4fPr0JNWgvaSPcOqpC4iZZU1Ufxj
         tabL7NbtBO0sB9n3dQhtMdnV2w2RSMAlyjoVlNQKVGKR/8u/YAZaTYVOhlL1dzHRXEBS
         ZZxahZO16cB5m22uYkiMg8ynUf0UjrIMFRX9WeMWc1x1sGYdtMRVM42cVKpxcTTjpMaz
         IAW2ZQakzTNWqkEic3LjVB9LFq4OJuL4Kqr7NxFRnvTvuslucDEXgeSNEA0jL2HYbjCs
         i4zcL6ZniALVTd01sBfCV8D1mUMZ8pfDcU6d0aG1vXIOB11PtXZ3rhLQSn1EHrZws9Jf
         zjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928447; x=1690533247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQAwCIhJQKqcYnCuAcDKHJfPf6lVhwCI1dubWC+OCok=;
        b=MgiQc3td1unY+ECRocM0JKCWSv+WkfJ2A1Ago52/wWQsACzj8QXLmaHP9iivzXdF98
         8A9BWhW3ZNDAZuZ8iM9rKoiu/Rnve+SHSlQ/AoiMIeqOpWStvjuYRJftt3I5yg78Eebb
         RBhin+yD7KCet/FBErbDDdtksPHJTXKCm9cy7wUlCrWgxfpL8pDQemosq0z0KLM/r2Ux
         CJTl5monKz/5ZMNjpiG+6ybbO259xKWEnV3eWSE0Bjfp96F/ubxsht76B03I11uSuDTG
         5DE1We87N/2gv3oXvu29xQS355ty0rYZ6tYwe5glxii0HASJl+oGnPNYI+CzHYllcWUD
         dWFg==
X-Gm-Message-State: ABy/qLZ4Arl/he/pYnVz1HTliFLBjRcTEkeuVeJyEoEnQx7xGng9VHfo
        aKEFzG65+u/41Q305ji4ZdgblNbnn+o=
X-Google-Smtp-Source: APBJJlGcaMnbd/zNvCFSLkP92ZxlT0y98wOs124UuYYj8d+gm7hhYqcbODGqa+5VJFa6n61iNzjo6A==
X-Received: by 2002:a05:600c:2802:b0:3fb:c462:1833 with SMTP id m2-20020a05600c280200b003fbc4621833mr872759wmb.30.1689928446942;
        Fri, 21 Jul 2023 01:34:06 -0700 (PDT)
Received: from gmail.com (1F2EF292.nat.pool.telekom.hu. [31.46.242.146])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c280b00b003fa968e9c27sm5615351wmb.9.2023.07.21.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:34:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 21 Jul 2023 10:34:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack
 memory
Message-ID: <ZLpC/IbswCA0yUHD@gmail.com>
References: <168980685456.28540.8149705038742119504.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168980685456.28540.8149705038742119504.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Rick Edgecombe <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/shstk branch of tip:
> 
> Commit-ID:     7c8f82db8acb9f0935703c0d96cda552bbf91ff2
> Gitweb:        https://git.kernel.org/tip/7c8f82db8acb9f0935703c0d96cda552bbf91ff2
> Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
> AuthorDate:    Mon, 12 Jun 2023 17:10:48 -07:00
> Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
> CommitterDate: Tue, 11 Jul 2023 14:12:47 -07:00
> 
> mm: Don't allow write GUPs to shadow stack memory

JFYI, this commit was the last user of writable_file_mapping_allowed(), 
which breaks the x86-defconfig build:

  mm/gup.c:1015:13: error: ‘writable_file_mapping_allowed’ defined but not used [-Werror=unused-function]

There's also a now orphan reference to writable_file_mapping_allowed() in 
the comment of folio_fast_pin_allowed().

Thanks,

	Ingo
