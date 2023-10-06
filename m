Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80F7BB48D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJFJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjJFJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:51:25 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307BAD;
        Fri,  6 Oct 2023 02:51:20 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: B6F02E4.A2FD6
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:213:242:ac11:64])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id B6F02E4;
        Fri,  6 Oct 2023 11:51:18 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1696585878;
        bh=2O7Z74NrcNY3C7YcNAvm7mBNNZyOF3fhdowlO4ULU+0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GApPb/ctpV6h3Ig7YixyU7wxSYGRYK+mqdvd1QooGIVz6EUY6TzlSp1kmAanCGHji
         GFHp9nnHBsTBHW3FIsyPKggW6K1LmA+m7zHffIWJjZC+pWUZoR4rDXHv/kQhmcO/7r
         5knpRGwivzPrLmWNo3oG2GBZOGirUtsWWRNM2wEk=
Received: from [IPV6:2a02:1811:d31:8b00:3eef:508b:d52c:c553] (ptr-82s0fs6lc2e44cgawyb.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:3eef:508b:d52c:c553])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 6D1DCD4EB6F67;
        Fri,  6 Oct 2023 11:51:18 +0200 (CEST)
Message-ID: <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
Date:   Fri, 6 Oct 2023 11:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Kai! I'm not familiar with any next steps to get this merged 
upstream, but atm all commits in this series have been reviewed by at 
least Jarkko. Let me know if anything further is needed from my side!

Best,
Jo

On 05.10.23 23:25, Huang, Kai wrote:
> Hi Jo,
> 
> Just FYI I won't review the rest patches in this series.  One of the reasons is
> I am not that familiar with the rest.  Jarkko has reviewed anyway :-).
> 
> On Thu, 2023-10-05 at 17:38 +0200, Jo Van Bulck wrote:
>> Hi,
>>
>> This patch series ensures that all SGX selftests succeed when compiling with
>> optimizations (as tested with -O{0,1,2,3,s} for both gcc 11.3.0 and clang
>> 14.0.0). The aim of the patches is to avoid reliance on undefined,
>> compiler-specific behavior that can make the test results fragile.
>>
>> As far as I see, all commits in this series now have an explicit reviewed-by
>> tag, so hopefully this can get merged upstream? Please let me know if any
>> concerns remain and I'd happily address them.
>>
>> Reference output below:
>>
>> .. Testing   gcc   -O0    [OK]
>> .. Testing   gcc   -O1    [OK]
>> .. Testing   gcc   -O2    [OK]
>> .. Testing   gcc   -O3    [OK]
>> .. Testing   gcc   -Os    [OK]
>> .. Testing   gcc   -Ofast [OK]
>> .. Testing   gcc   -Og    [OK]
>> .. Testing   clang -O0    [OK]
>> .. Testing   clang -O1    [OK]
>> .. Testing   clang -O2    [OK]
>> .. Testing   clang -O3    [OK]
>> .. Testing   clang -Os    [OK]
>> .. Testing   clang -Ofast [OK]
>> .. Testing   clang -Og    [OK]
>>
>> Changelog
>> ---------
>>
>> v7
>>    - Add reviewed-by tag (Jarkko)
>>
>> v6
>>    - Collect final ack/reviewed-by tags (Jarkko, Kai)
>>
>> v5
>>    - Reorder patches (Jarkko, Kai)
>>    - Include fixes tag for inline asm memory clobber patch (Kai)
>>    - Include linker error in static-pie commit message (Kai)
>>    - Include generated assembly in relocations commit (Kai)
>>
>> v4
>>    - Remove redundant -nostartfiles compiler flag (Jarkko)
>>    - Split dynamic symbol table removal in separate commit (Kai)
>>    - Split redundant push/pop elimination in separate commit (Kai)
>>    - Remove (incomplete) register cleansing on enclave exit
>>    - Fix possibly uninitialized pointer dereferences in load.c
>>
>> v3
>>    - Refactor encl_op_array declaration and indexing (Jarkko)
>>    - Annotate encl_buffer with "used" attribute (Kai)
>>    - Split encl_buffer size and placement commits (Kai)
>>
>> v2
>>    - Add additional check for NULL pointer (Kai)
>>    - Refine to produce proper static-pie executable
>>    - Fix linker script assertions
>>    - Specify memory clobber for inline asm instead of volatile (Kai)
>>    - Clarify why encl_buffer non-static (Jarkko, Kai)
>>    - Clarify -ffreestanding (Jarkko)
>>
>> Best,
>> Jo
>>
>> Jo Van Bulck (13):
>>    selftests/sgx: Fix uninitialized pointer dereference in error path
>>    selftests/sgx: Fix uninitialized pointer dereferences in
>>      encl_get_entry
>>    selftests/sgx: Include memory clobber for inline asm in test enclave
>>    selftests/sgx: Separate linker options
>>    selftests/sgx: Specify freestanding environment for enclave
>>      compilation
>>    selftests/sgx: Remove redundant enclave base address save/restore
>>    selftests/sgx: Produce static-pie executable for test enclave
>>    selftests/sgx: Handle relocations in test enclave
>>    selftests/sgx: Fix linker script asserts
>>    selftests/sgx: Ensure test enclave buffer is entirely preserved
>>    selftests/sgx: Ensure expected location of test enclave buffer
>>    selftests/sgx: Discard unsupported ELF sections
>>    selftests/sgx: Remove incomplete ABI sanitization code in test enclave
>>
>>   tools/testing/selftests/sgx/Makefile          | 12 ++--
>>   tools/testing/selftests/sgx/defines.h         |  2 +
>>   tools/testing/selftests/sgx/load.c            |  9 ++-
>>   tools/testing/selftests/sgx/sigstruct.c       |  5 +-
>>   tools/testing/selftests/sgx/test_encl.c       | 67 +++++++++++++------
>>   tools/testing/selftests/sgx/test_encl.lds     | 10 +--
>>   .../selftests/sgx/test_encl_bootstrap.S       | 28 +++-----
>>   7 files changed, 77 insertions(+), 56 deletions(-)
>>
> 
