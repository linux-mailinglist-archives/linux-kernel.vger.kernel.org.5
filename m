Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46DF78765C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbjHXRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242825AbjHXRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795641707
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA9A46498C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B777DC433C8;
        Thu, 24 Aug 2023 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692896858;
        bh=3oH8t8PggeAM1ZPWCragw/1L8QjhMxipw7RDC0C+0J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwmWEryWoweK2SWRb6CgpZvNdCOamPZNF/53P7BvXMiYR5dHeAfp7HbhsZ5G6i7g/
         yTaFTEZQXlD+QDIJR6dYYWR7HbOf8Dwwu49+AfaiEt0RafD03ddCprvOUgEnT78q59
         SRncYOlVCSV8ufOwHWUw4e5MaaaxL79urudsoJMclFjNH+2bPNOXKUXmukPoHAaoTp
         bdp53txLFZ7xseuWn/33YLtGRJmF+CdCSskK184t8543Clop+3bCuIaCMmE49bIRhU
         e/01NKUsN6KJV1X4RxF5c9o4EdhI5tKB3DfoWb4ifmz8443wgShMLjJI8onE7EMtYC
         fHVJikHAsE+bQ==
Date:   Thu, 24 Aug 2023 10:07:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Message-ID: <20230824170736.vblolmlkfzfwmmfm@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
 <20230821162337.imzjf3golstkrrgd@treble>
 <ZOOSXc9NE1rMHDZ1@google.com>
 <20230821170520.dcovzudamnoqp7jc@treble>
 <ZOeHp0skdfrARNFe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOeHp0skdfrARNFe@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:39:03AM -0700, Sean Christopherson wrote:
> > Also, since you're clearly more qualified to write this patch than me,
> > can I nominate you to do so? :-)
> 
> Sorry, didn't mean to ghost you.  I can write the patch, but I won't get to it
> before next week some time.

No worries, I'll pull in your code (with a reserved_bit fix) for my v2.

-- 
Josh
