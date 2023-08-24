Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64527866F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbjHXEzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbjHXEzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:55:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E01702
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:55:04 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 461AB1EC014A;
        Thu, 24 Aug 2023 06:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692852903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O+ueU8rToZviomdXW6WPY/SINTgDG7dQWhSOJWeZoEQ=;
        b=hqRFJYhUYcs+GwpjTpTnZhIKuAsqCUAx+ZxaVyUiaSgsPehM+BtmxMDSF5RBhSGEWjrTMQ
        T7V56Qw14777nDtpLmFEUYi4IjTwF4PfdLloIo9llFM5sw1DpRuJ1e57cO9TAL53xzhQ4k
        N9d/95QOgehrDGEttiggKws8vOw1MPM=
Date:   Thu, 24 Aug 2023 06:55:15 +0200
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
Subject: Re: [PATCH 11/22] x86/srso: Slight simplification
Message-ID: <20230824045515.GEZObisz++bg1CabRj@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <18b18b8709b72625b60156545a705b052646667c.1692580085.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18b18b8709b72625b60156545a705b052646667c.1692580085.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 06:19:08PM -0700, Josh Poimboeuf wrote:
> Subject: Re: [PATCH 11/22] x86/srso: Slight simplification

Commit title needs a verb and a more descriptive title.

Strictly speaking, we should use the IBPB selected as the retbleed
mitigation for SRSO only when the SRSO microcode has been applied so
moving this inside the "has_microcode" branch makes sense.

But even if it is outside that branch, we will still say "no microcode"
so basically it boils down to the same thing.

But sure, ok, slight simplification. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
