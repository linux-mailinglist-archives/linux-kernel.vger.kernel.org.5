Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6322D785913
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjHWNVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjHWNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:21:44 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF2E5E;
        Wed, 23 Aug 2023 06:21:22 -0700 (PDT)
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id D167C22BE;
        Wed, 23 Aug 2023 15:20:12 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 103B6201CC.A4AEE
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 103B6201CC;
        Wed, 23 Aug 2023 15:19:51 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692796790;
        bh=f4uWTUCfAgiQ37o1CO0MgqBSdsWvxL3omAE3E6UZYGk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CF43hZ2yPmYoJI2j31R0rmu0da6M9KxxXKzy3AoGbar3v+TpIjo28Mj5v7KfAWuKF
         v/eVxyVzNvlXgYplW2GqVowtXpZoboEr2wkt7q56Z+hlC6FTWBqyFNaMetxvQxkXir
         O4uw0D9vsJLvDs7sc4CSJ0R6JyGiRWBirSNWbAy4=
Received: from [IPV6:2a02:1811:d31:8b00:6a8c:3ab2:9886:5378] (ptr-82s0fs797m4gxnd4pko.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:6a8c:3ab2:9886:5378])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id C81CED4E6514B;
        Wed, 23 Aug 2023 15:19:50 +0200 (CEST)
Message-ID: <b59e79dc-5157-8729-5e1c-d016f9f688ef@cs.kuleuven.be>
Date:   Wed, 23 Aug 2023 15:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/9] selftests/sgx: Produce static-pie executable for
 test enclave
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-3-jo.vanbulck@cs.kuleuven.be>
 <71ad6389da7db8541dada0276db33f98e2a4fdcf.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <71ad6389da7db8541dada0276db33f98e2a4fdcf.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 02:26, Huang, Kai wrote:

> ... I think only this build flag change should be done in  this patch, as
> described in the changelog.
> 
> Because ...

> ... if I am not missing anything, this chunk isn't needed for _this_ patch.  The
> old code can still produce the correct stack address. __encl_base is only needed
> for the next patch, thus the relevant change should be moved to the next patch.

I understand the confusion, but the reason I included this small change 
already in this commit is to make sure the commit compiles standalone. 
That is, when building the original assembly statement "lea 
(encl_stack)(%rbx), %rax" with -static-pie -fPIE, the linker complains 
about a relocation it cannot resolve:

/usr/local/bin/ld: /tmp/cchIWyfG.o: relocation R_X86_64_32S against 
`.data' can not be used when making a PIE object; recompile with -fPIE
collect2: error: ld returned 1 exit status

The problem is that only RIP-relative addressing is legit for local 
symbols, ie "encl_stack(%rip)". Hence, __encl_base is already needed 
here to calculate the stack address in the updated asm sequence in this 
patch.

Hope this helps clarifying!

> I honestly don't understand what's the purpose of this code change.  I believe
> this change can be done (because it looks there's no need push/pop %rbx in the
> first place), but again it should be in the next patch I suppose.

Thanks, the purpose indeed was merely to remove redundant code that is 
not needed. I see that it would be better to include this in a separate 
patch, so I'll update this in the next patch revision.

FWIW: if this is okay, while I'm on it, I'll also take a shot at 
removing remaining (unnecessary) assembly register cleansing code to 
make it more obvious that the test enclave is *not* exemplary secure, as 
per our earlier discussions. Ie in response to Dave's earlier comments 
that "The only patches I want for the kernel are to make the test 
enclave more *obviously* insecure." [1].

Best,
Jo

[1] 
https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com/
