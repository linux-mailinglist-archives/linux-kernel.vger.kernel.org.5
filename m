Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF727A9829
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjIURcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIURb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:31:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4907EF2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:10:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 768F85C00D9;
        Thu, 21 Sep 2023 12:26:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Sep 2023 12:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695313617; x=1695400017; bh=Z4
        KTSVuT7KTNJQDkW80sMex9LfoppnMnFr8nX3dMwCI=; b=Fz0czn+/yTiq1GYfus
        vKWoXAaohjlfOZULNdSTrC09A8RtoVBuWppooW2W1ktthlcDHqomphrj181K12gt
        2WA2/+G5AwVeR3qLS7IXnoh3dT22v16ak0vMHkvKBlrVqMv0q1BYIdpqISpAKRjo
        SULEg88zbUiET25cITjD4OiggmcpEOKz2RYoH4YY8hLMlvjuArl5Sp1H7naRcKA3
        9amqaOZCj0rmWuzFRSm1UeJKYSxUnEThrYrj92nqq44qJ9rbewwEzsBdQWXrqrNG
        VI99fFrGY6R6QjRXtvuNYLqQKzRssLbFC2nOXV7zxut5mx1EfwVD1RfBGzXFBeBI
        GX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695313617; x=1695400017; bh=Z4KTSVuT7KTNJ
        QDkW80sMex9LfoppnMnFr8nX3dMwCI=; b=dbJGRNkmrurrKLejhuj4yx604dXkV
        /LfUhIe9v0WlyCQbs+Y01sZmOcuU2XphlZpgNRgXsM3zG+ZkUK/xDYaTImfFowe+
        FX9WkmV9Y+x/P0dqX9wYXn23NoIrq7dLT7f5wTAbp7KxiLLF8//xjKOvUeui9S6N
        fqgT8m66ZngeAh0F7OoV7EGTKBnnE3xPQ2fcibN5Fr9Lj+QqejV9EIAntWlaCofj
        R/P4hdyqxTaRCPPSMZvciMi24lnysJ7U5tjPI3uTswyCZy7H86PNzRcpeJgNAcdC
        gHoh3vYNZ6hVjFtkKS7z+JlLbjoTmJSJotwXqqHyslTcK7ePyQ7hgSA0Q==
X-ME-Sender: <xms:0G4MZUV41JueJ-Fm8kLYNG4v4IMqf1tALiyteweDz_EPo1tMT5wGrA>
    <xme:0G4MZYlPFzujAYK3f9KN8whekS6Wt68ClqmdcMvuSHIv4FvvdyTIUToDNVNdg91Y9
    lpL8Z0lYLwSWfinDRU>
X-ME-Received: <xmr:0G4MZYZLDjJEqEeK6IFYsOyw3WvwRou1tXjOynQTMs-vHCJwWxhPegnmcnp8qrAp2I7LJLI_PbhBdv3_pc8ATco9EKU3iW4mSCxpy4wwphNv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:0W4MZTX4W0Au-VSocOoWmSivje2gfeLqBt8NY_u7VP2-vLgCWJgSWw>
    <xmx:0W4MZekQSAse2f0Kdxc9CKj-UBjr8F2l35szhqwv8y0PAt9lNtS9mA>
    <xmx:0W4MZYclk7I0tAAl-RdMjg-1UlzxiN0kKhJpfS39fe1I1K5DHIqbtA>
    <xmx:0W4MZVsDdeg2jbDJdEaKX4qFhrIIkqI1v0Zbb6yeWsNbi0iWqFCc8g>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 12:26:56 -0400 (EDT)
References: <20230920190117.784151-1-shr@devkernel.io>
 <20230920190117.784151-3-shr@devkernel.io>
 <a5e5b08f-851b-3dd1-889b-5b09eff5b7be@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/ksm: Test case for prctl fork/exec workflow
Date:   Thu, 21 Sep 2023 09:25:46 -0700
In-reply-to: <a5e5b08f-851b-3dd1-889b-5b09eff5b7be@redhat.com>
Message-ID: <qvqwwmwjh4qb.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 20.09.23 21:01, Stefan Roesch wrote:
>> This adds a new test case to the ksm functional tests to make sure that
>> the KSM setting is inherited by the child process when doing a
>> fork/exec.
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   .../selftests/mm/ksm_functional_tests.c       | 67 ++++++++++++++++++-
>>   1 file changed, 66 insertions(+), 1 deletion(-)
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c
>> b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index 901e950f9138..40b86c9caf3a 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -26,6 +26,7 @@
>>     #define KiB 1024u
>>   #define MiB (1024 * KiB)
>> +#define FORK_EXEC_CHILD_PRG_NAME "ksm_fork_exec_child"
>>     static int mem_fd;
>>   static int ksm_fd;
>> @@ -479,6 +480,65 @@ static void test_prctl_fork(void)
>>   	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>>   }
>>   +static int ksm_fork_exec_child(void)
>> +{
>> +	/* Test if KSM is enabled for the process. */
>> +	int ksm = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
>> +	return ksm == 1;
>
> You can simply do "return prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0) == 1;"
>
> Or maybe even "return prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);" and adjust the
> comparison below in the caller.
>

I'll use the first one, then its all in one place.

>> +}
>> +
>> +static void test_prctl_fork_exec(void)
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
>> +		char *prg_name = "./ksm_functional_tests";
>> +		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
>> +
>
> I'd simply have used the magic number "1" or so. But this works as well.
>

I think the current one makes it easier in case we have to add a second
one later.

> Reviewed-by: David Hildenbrand <david@redhat.com>
