Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3A758179
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjGRP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjGRP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:56:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085821996
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:56:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689695797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ad66UUVO3pSvlvkox2MT7k2+8Ed+6IONyfoOpiaiMsQ=;
        b=Rg0d5kKSCd43BjEkyMdTFN67J6jqWri0AVjjiUS6uNMKi04ud9ZpOg8CGEcd2+ikOj43Pu
        Vlhx+rlZXZDGTv2Y+HN6kIbxTx093nsrdC2VDI0xXubcp3uceOx15bHLo31EpU7OcWghIb
        aEchJXAN9uxjujSd4RkSs0Ox1g/309du9E8GGufcDCZ+B0bOcC66YrAltE948H334dOSXx
        3ATRRs/4nTOP4N9aqPxmaN0HRxs3YOT86lw5uGkqf9DtETeNsqBr6aqdFfxFhh/o7Vc89P
        l0NY0DYI+vlap8o48TXIb5vRen1ISN84mv7CExQXszp1flCCWrKudBUXcKN81w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689695797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ad66UUVO3pSvlvkox2MT7k2+8Ed+6IONyfoOpiaiMsQ=;
        b=C2Dd1CsruzP9g3plb51s2N3XB3xjiOkINkIAtHSksmc3925NKlZ+72cSNp6YC4/EqSKMAZ
        ZG9xWXtVTEc+CGBg==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 54/58] x86/xen/apic: Mark apic __ro_after_init
In-Reply-To: <a89d5dab-4c52-0bff-ad35-080e62a57447@suse.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.297124390@linutronix.de>
 <a89d5dab-4c52-0bff-ad35-080e62a57447@suse.com>
Date:   Tue, 18 Jul 2023 17:56:37 +0200
Message-ID: <875y6hxlfu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18 2023 at 17:31, Juergen Gross wrote:
> On 18.07.23 01:15, Thomas Gleixner wrote:
>> +	.get_apic_id			= xen_get_apic_id,
>> +	.set_apic_id			= xen_set_apic_id, /* Can be NULL on 32-bit. */
>
> While changing this line, could you please drop the comment here?
>
> 32-bit is irrelevant, as Xen PV is 64-bit only these days.

Sure.
