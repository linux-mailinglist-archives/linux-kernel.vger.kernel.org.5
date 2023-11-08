Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDD27E52E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHJxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344001AbjKHJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:53:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE31BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:53:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E383C433C9;
        Wed,  8 Nov 2023 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699437217;
        bh=X1QfPsk6/FLpLtKsEI/zWg5ToEpPgmfoGfnmPEqLETI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r03aAzwK8u8Iu4RbZUbQE9MLoKo0DZp6ST+mkNjJY88sj7bB+2v0IItQLxdu4ZlNG
         Buo1PG+41i9omssomgoaPld5szeOn4Q/ic4fb+xIFNwe88mvFcuY4yJiTXAZvIHhPE
         jzVtVb1AsRLUyS518rATQSATi/weHa1vvi+vA+VW9Vaiygwpxf3ACx8oSs04lU4zC2
         /6NBYhcTbsL7/2LG4jnQb2gFvdzY4Zgrc8zYWV651KjBg/HLgyIa5KMR3bAdhK0gg0
         Tfr51PEPmXZTAX65VYmVl8hE0qi9GhdS2QwhQWkK84vjlV6sO3L+13hn+5TbT1ST3Z
         7coCu8vgn/PJA==
Message-ID: <d2ac7d2a-95cd-4da0-ac00-985cbbab9f08@kernel.org>
Date:   Wed, 8 Nov 2023 10:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
To:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org,
        rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
        mjguzik@gmail.com
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231108085156.GD8262@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 09:51, Peter Zijlstra wrote:
> On Tue, Nov 07, 2023 at 01:56:46PM -0800, Ankur Arora wrote:
>> Hi,
>>
>> We have two models of preemption: voluntary and full 
> 3, also none (RT is not actually a preemption model).
> 
>> (and RT which is
>> a fuller form of full preemption.)
> It is not in fact a different preemption model, it is the same full
> preemption, the difference with RT is that it makes a lot more stuff
> preemptible, but the fundamental preemption model is the same -- full.

+1

-- Daniel
