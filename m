Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EAF78507D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjHWGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjHWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:18:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F3E45
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:18:19 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2F7C1EC0178;
        Wed, 23 Aug 2023 08:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692771498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zvh1j4WkrDlkBeRvmLCd/rTdYRYIJ/aFqfQmIX6+BMk=;
        b=kUaZ+8xcSDuYce5xDqGsng4ylRnDgrzdUE+W2TziX4AgivQz+CneZlYn0Ty/bPT1+ilFkF
        pXXk+uCgmOy2P5EEGqTOafGTFf7ghJF/bbgrfHsJL1NcYxXPMPdxx4eIDRx2xlEmTJvT/+
        4oVlR4qRGB7sPfiRwEUB5bAcgsPWdfg=
Date:   Wed, 23 Aug 2023 08:18:14 +0200
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
Subject: Re: [PATCH 07/22] x86/srso: Remove default case in
 srso_select_mitigation()
Message-ID: <20230823061814.GFZOWkpi9KapibyswG@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <9e913c461707372017d8b9a53491dc8dcaff07dd.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e913c461707372017d8b9a53491dc8dcaff07dd.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:04PM -0700, Josh Poimboeuf wrote:
> Remove the default case so a compiler warning gets printed

There are other similar cases in this file. We should make it an
explicit rule that this file - being special and security-sensitive and
all - should handle all switch cases explicitly so that it is obvious
what gets selected and that people think about every possible option
when doing a switch-case.

> if we forget one of the enums.

No "we" please - make that passive voice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
