Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA67C5D62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJKTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjJKTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:03:35 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810479E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:03:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CB8540E01AA;
        Wed, 11 Oct 2023 19:03:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QrrpHl-Cn7QB; Wed, 11 Oct 2023 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697051009; bh=vPOgBNJTPbQOhMbYg87tDw12X8IrNzhCwtHDGFXYC2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0sFaOjFWmokCL5bvo2rV7FctBrNnS18FFJ2Kvb9vOLE4bTyzro6wzk2hCGV7t4od
         bn2mgaYOu/jlO+ME0N3Gm1vhs29a2t+OHKuAhpX9bDXiqJHR0aeRihHIj5MnsjxSll
         uQkns+LJWs9PbeDB/EmGB9KYuXjx9057uqgjgZdOz9ajzmX3gkR5XiTGiIhSgj+DkE
         8my5w9BkT7MFcf3VyYcc350A5QaUfhH4lG72rWLu+VC7sgHdwPxEqvY5JS68hf0zjE
         3zxL9zKFAX+XSYH7ONaCHSMYIjDhlh+OyQRlaUWZS4FSPORRuHsBh/xorF0x85VX8b
         H1ZHuXyB3QCVhZm7lETEL9TcCUXwuflBm5dv3FbcG5rVSwqMvOQe29mAOUmjXjtMTN
         lD2iT/WqX/cMbIrKl5ylYhvoABOorX9YVVn0msIlkVz8aTJsGEk2o6jbgZW9AkPajr
         Q6cGJ64fM47dWD2NdcNiz2JFQ27cxf4y2Y/YnxM2SfKOH0s1bMa5iydZEsW5JBV8lF
         4Rf51s700GxHZTSQyo2p576Zy4PZscMlGEsgl5A4JlW2wiRqlykmpPBAdl/AUOR5Z8
         JSMCWJ+N7UOa7V6oYqUeB5H+xmOL6sCsBsrp+h722pMKs6vmxRZc+Kd3uMvd8gKcXf
         jt6iuLHyOxsCo2oJ2Y8+6Kbk=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 952CE40E00B3;
        Wed, 11 Oct 2023 19:03:18 +0000 (UTC)
Date:   Wed, 11 Oct 2023 21:03:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011044252.42bplzjsam3qsasz@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:42:52PM -0700, Josh Poimboeuf wrote:
>   MITIGATION_PAGE_TABLE_ISOLATION
>   MITIGATION_RETPOLINE
>   MITIGATION_UNRET_ENTRY
>   MITIGATION_CALL_DEPTH_TRACKING
>   MITIGATION_IBPB_ENTRY
>   MITIGATION_IBRS_ENTRY
>   MITIGATION_SRSO
>   MITIGATION_SLS

The train has already left the station on those. The other mitigations
don't have "MITIGAT*" at all in front of the name. I.e.:

config RETHUNK
config CALL_DEPTH_TRACKING
...

and prepending them all with MITIGATION_ is going to cause too much
senseless churn for a reason which I don't think is worth the effort.

So let's stick with the current naming scheme and do

config MDS
config TAA
...

and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
