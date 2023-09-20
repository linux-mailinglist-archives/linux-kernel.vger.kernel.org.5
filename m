Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C77A8C26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjITS7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:59:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F312AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:59:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75C9A5C012A;
        Wed, 20 Sep 2023 14:59:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Sep 2023 14:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695236363; x=1695322763; bh=t4
        Kp9fLt8bqhZ5C1c0iLXPtn7Zyyv0RxVkTe9WghAqI=; b=TkEy/w0ELZo7Ts6DPH
        J/A3DNMUiSFBbNvlHGDpEbQT4vX0NWaauoea1txWsnxUvz9yQFk0z57awJGyYLV5
        3hnE80afN3X9cNNdPggYK1wTw3Es3y5c9Wh6cppa92es7YRvN/5OdlTMvuZQoQ16
        DDWyCIIBczpvEms3KhyeekdUZs3vM5G/c9NHnWpCdUGf3tSovz0b04N7U1mlv3hL
        DRuwrQuYQiC6EAhPTE7eZzsOAEW0Q4CM0fcBzn2NMUdhnGvDHh2YuAgmDhKTFiS2
        vBbSWjkqtUWJ0BmwSGNC1Sm/A8nAGJ5mJFDzb3JZGtjIffozyg7KIYtbwZyx0RTu
        L+iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695236363; x=1695322763; bh=t4Kp9fLt8bqhZ
        5C1c0iLXPtn7Zyyv0RxVkTe9WghAqI=; b=BnXfMTOSi8a+AM/3jDAuEON7D5sOq
        SDimlGw4ZLAM20NIrNs2PYkBiVzMcEq2UEyMGbIp5Yow8rnsdJ/mr9730SimOF5z
        PT8/LupdGemc2dzWo4lCcblhVWheQSO0BgV3VYfhc3Zz8QOFg4FMUoIkP7ABGn1Z
        jWbIIfDq51tSNCsSPPl+tgK0KUvNJkCu0cO96CPJme7na5sGO1Nw8x0saLzDsUP7
        uH8NRApyVyHbobokZMQGUkSuTd0uYIZqF9eYCcYi4yk8FzQVezXhWzZz+Y1N7WXX
        EU6EGd5E5nHm62Z6LbExzQUcFScpiMBdPWz4Y3HkGkgM5ovBwU3cyeFew==
X-ME-Sender: <xms:CkELZZDkcboljhWBsagkdDuN5rDvwesyXAXLjlNdYMLUwcPuDNFP-A>
    <xme:CkELZXjNjZJXU4Ceww95Q1CXFjrSvEH98qc5uX2ZOxwvcJrh6vCBQ-ccaQp1JPxPN
    _l2nR6iSluAYMoYWnI>
X-ME-Received: <xmr:CkELZUmk-j5TRxe-esALbrHoLPb3cQTdd7NuWzWwDOgbbaIeX59T-4Z5mOFkEO5Roy-0BKmG09WMaCxVeY9gQP9y1lHR5qcTTnAQyrF7TqhW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:CkELZTz1gAb-N7tbrGIKY3FWxmQ69Y3tuF-a5n9YaYl4Og6Fjk57Jw>
    <xmx:CkELZeQW0PhwDh8ELkw3YcH9sYdUxjTfJkhISLksqb-5ECFbFm8JjQ>
    <xmx:CkELZWYzQTijEJhYdd8lzLzf7KxuIe3XyDj7PeSnUbxdaEg60Gk61g>
    <xmx:C0ELZbIhp8RTppB0gYXDRieDxt1DVDrWDD6UrGNKCnaoMSCmz68x0w>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 14:59:22 -0400 (EDT)
References: <20230919205158.1897353-1-shr@devkernel.io>
 <20230919205158.1897353-3-shr@devkernel.io>
 <daf57da6-b22d-bdfb-c6f0-0ac07824ab72@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/2] mm/ksm: Test case for prctl fork/exec workflow
Date:   Wed, 20 Sep 2023 11:57:27 -0700
In-reply-to: <daf57da6-b22d-bdfb-c6f0-0ac07824ab72@redhat.com>
Message-ID: <qvqwpm2c1xix.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 19.09.23 22:51, Stefan Roesch wrote:
>> This adds a new test case to the ksm functional tests to make sure that
>> the KSM setting is inherited by the child process when doing a
>> fork/exec.
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   tools/testing/selftests/mm/Makefile           |  2 +
>>   .../selftests/mm/ksm_fork_exec_child.c        |  9 ++++
>>   .../selftests/mm/ksm_functional_tests.c       | 50 ++++++++++++++++++-
>>   3 files changed, 60 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/mm/ksm_fork_exec_child.c
>> diff --git a/tools/testing/selftests/mm/Makefile
>> b/tools/testing/selftests/mm/Makefile
>> index 6a9fc5693145..9ab6aa402544 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -73,6 +73,8 @@ ifneq ($(ARCH),arm64)
>>   TEST_GEN_PROGS += soft-dirty
>>   endif
>>   +TEST_GEN_PROGS += ksm_fork_exec_child
>
> It's not a test itself, so it shouldn't be run when running all tests. See
> below.
>
>> +
>>   ifeq ($(ARCH),x86_64)
>>   CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
>>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
>> diff --git a/tools/testing/selftests/mm/ksm_fork_exec_child.c b/tools/testing/selftests/mm/ksm_fork_exec_child.c
>> new file mode 100644
>> index 000000000000..298439f0d55f
>> --- /dev/null
>> +++ b/tools/testing/selftests/mm/ksm_fork_exec_child.c
>> @@ -0,0 +1,9 @@
>> +#include <sys/prctl.h>
>> +#include <stdlib.h>
>> +
>> +int main()
>> +{
>> +	/* Test if KSM is enabled for the process. */
>> +	int ksm = prctl(68, 0, 0, 0, 0);
>
> Can we use the define from a header? (PR_SET_MEMORY_MERGE)
>

I changed it.

> I was wondering if we could simply exec() ourself (same binary), but pass a
> special cmdline argument. Then you don't have to build a separate binary.
>

I'm execing the same executable with an additional parameter.

> Just special-case in main() on that argument and perform this check.
>

I added a check in main and invoke a new function for the child.

>> +	exit(ksm == 1 ? 0 : 1);
>> +}
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index 901e950f9138..4dc0bb522c07 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -479,6 +479,53 @@ static void test_prctl_fork(void)
>>   	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>>   }
>>   +static void test_prctl_fork_exec(void)
>> +{
>> +	int ret, status;
>> +	pid_t child_pid;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
>> +	if (ret < 0 && errno == EINVAL) {
>> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
>> +		return;
>> +	} else if (ret) {
>> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
>> +		return;
>> +	}
>> +
>> +	child_pid = fork();
>> +	if (child_pid == -1) {
>> +		ksft_test_result_skip("fork() failed\n");
>> +		return;
>> +	} else if (child_pid == 0) {
>> +		char *filename = "./ksm_fork_exec_child";
>> +		char *argv_for_program[] = { filename, NULL };
>> +
>> +		execv(filename, argv_for_program);;
>
> s/;;/;/
>

Fixed.

> Add a return; so you can simplify the code below (no need for the "else")
>

Done.


>> +	} else {
>> +		if (waitpid(child_pid, &status, 0) > 0) {
>> +			if (WIFEXITED(status)) {
>> +				status = WEXITSTATUS(status);
>> +				if (status) {
>> +					ksft_test_result_fail("KSM not enabled\n");
>> +					return;
>> +				}
>> +
>> +			} else {
>> +				ksft_test_result_fail("program didn't terminate normally\n");
>> +				return;
>> +			}
>> +		} else {
>> +			ksft_test_result_fail("waitpid() failed\n");
>> +			return;
>> +		}
>> +	}
>> +
>> +	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>
> It's probably the cleanest to disable PR_SET_MEMORY_MERGE again when returning
> form this function, so the other tests have a clean slate.

In the next version it is disabled at the end.
