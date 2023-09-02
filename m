Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF457906B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351902AbjIBJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjIBJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:02:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F41709
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 02:02:16 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-142-117.46.114.pool.telefonica.de [46.114.142.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1399D1EC0865;
        Sat,  2 Sep 2023 11:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693645334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qh1Q+mO09NbZrjmB6eTiT+6iwBAw7eCtgELMJFUeCvw=;
        b=esgnWaDZ6ugO2vTpplRmwF8Lt8hyLui74ok5/sqTjlCiKQJ9/pHRJehXdtvxSoxdjaTZQC
        MESRSawlpswDr9CElqM72kAWRPxW8ls3RB9B99SGmVYOHadctM+pm2FQKkgHFRtFS0qjrq
        EIOhFjR/ESRwtVX8n7XguZcJF2qh4K8=
Date:   Sat, 2 Sep 2023 11:02:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 16/23] x86/bugs: Remove default case for fully switched
 enums
Message-ID: <20230902090216.GAZPL6GF8qIT9AGc9a@fat_crate.local>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:01:47AM -0700, Josh Poimboeuf wrote:
> For enum switch statements which handle all possible cases, remove the
> default case so a compiler warning gets printed if one of the enums gets
> accidentally omitted from the switch statement.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/kernel/cpu/bugs.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

You could just as well take care of the default: cases in
update_srbds_msr(), retbleed_select_mitigation(), unpriv_ebpf_notify(),
spectre_v2_parse_user_cmdline() and cpu_show_common() and get rid of
them all in this file and have the compiler warn for all of them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
