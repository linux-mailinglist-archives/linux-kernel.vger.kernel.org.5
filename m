Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1177B6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjHNKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHNKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:34:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824EBFB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=n/5fur1O7HmezLAB1D08kXCllPEF6sWoE3meSxj3Rn4=; b=bklOlH07ynK64pEaHS88zLq1IS
        i/qiUuqn+txNvZDv5Qef9vDhw6UQ/rfkNEO5cRGGEFCZ8LOiEh6NfXX22H4XE1Uspiie8XzHTlBHd
        vyQoJZdxEa1sVjvgYkCuVsg3o4Oq+JxDY4szfDU8HhQH8bSp7m7fZ3qm8LVQYbdcA/KUacB8B4qnI
        nGU1z7fGaYRxtyHT0hyKVCKBMo9Vkq6HXASb3h9B79lOvf4zd4HIa+Di9tmYYTPy3dUwEopfZjUuu
        NBKFd9yQcD0yjGF76a6PQ98OaVDYwINu0UcDahLdYAhgEnNhrkZdPEIYFNyAaMMEkiiiaIuNLfRlU
        TiCCQ8SA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVUuE-00AW74-07;
        Mon, 14 Aug 2023 10:34:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A17A30020B;
        Mon, 14 Aug 2023 12:34:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B96A20C1700F; Mon, 14 Aug 2023 12:34:37 +0200 (CEST)
Date:   Mon, 14 Aug 2023 12:34:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew.Cooper3@citrix.com
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Message-ID: <20230814103437.GC776869@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
 <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
 <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
 <20230810130229.GA212435@hirez.programming.kicks-ass.net>
 <bd670c70-47f6-efc7-6ad2-cd833b414ec1@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd670c70-47f6-efc7-6ad2-cd833b414ec1@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 04:23:27PM +0100, Andrew.Cooper3@citrix.com wrote:
> On 10/08/2023 2:02 pm, Peter Zijlstra wrote:

> > So BTC as a whole is the fact that AMD predicts the type of an
> > instruction and then picks a predictor to predict the target of that
> > instruction, no?
> 
> No.
> 
> "Branch Type Confusion" is the technical name AMD gave last year's
> issue.  Hence the name of the whitepaper about it,
> https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion.pdf

Bah, then what do we call the actual underlying issue that the AMD
branch predictor starts by predicting the next instruction type --
before it has been decoded -- meaning it can predict it wrong, which
then leads to a tons of other issues, including but not limited to:

 SLS through JMP (or pretty much anything else)
 RET from BTB

?

Calling *THAT* branch-type-confusion makes a heap more sense to me.

