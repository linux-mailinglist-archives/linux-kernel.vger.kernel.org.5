Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF57A896C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjITQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:29:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25580C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:29:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1C1D03200959;
        Wed, 20 Sep 2023 12:29:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Sep 2023 12:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695227359; x=1695313759; bh=dR
        x230nt4NjZWtPiovmpTS2FKilrb+bo4roUw7JE65U=; b=RdvBM4aT024PvV0gRj
        APTMtWxLswJw6xGUQbAqFsxLDnkQOF1fZ71Xq9uVHmIOS4CFTuxLYv9Nk4UXeEJT
        ROqeM5so1Ym+iFtOy/cxiRXq32ORPAkt+RdevW7LHtljjnIEC5kQhG6lp52t0YME
        jELUAKixn6ikFyY7xom8KBhE4+Qd8NiEqHmjXi/t7+vZ2J3dP3HQLibr9grfZuez
        EBuogKVlbLpokyZjpa3bGOZfIogIAYGeB0vXmZx6nPuXHYJ+tHT1CGoive0fQq16
        hxvhtlHXbnY407PcGdQWxzHqx5YGT0F1EgrYdfMg3I8NcYRRXPqBBZ/nwaTFbUGI
        n8OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695227359; x=1695313759; bh=dRx230nt4NjZW
        tPiovmpTS2FKilrb+bo4roUw7JE65U=; b=oj5YYpNdpnmimqf6QHwn9hCnXiZfG
        LIhxpErSJ8pwPrY7oNxlWxrX8zN0cR7ooCNFfLt+MleJHz/OpV6K3gsoffqPWmqT
        ZZ8p2+EeiWIE6ORx3r+O/eeQET/j3PWvFZjprFt6j48bMHz/0WBOGhiF+lH0LUuv
        nkBqt13dWrIdtt2g7WYVqxGMYn8nyCckgynKMOJ05dh1NilKwJeDiF6QLkBVxs4Z
        gB9+7SIlHXwtkm7pSlSaH2O2Iv+XXI177YfQHDAkAatoE0wMIOMWx5M92rUuIflz
        T1Jx2qoD3OvFDC+ZbukvsjbZ7QelCQCaG8uF+dWH5Ve+JaEDFg9pA36CA==
X-ME-Sender: <xms:3x0LZZG_-XAq568-42DDi8dqvJ5YI3OnHqAMTh4btfxZFIJkp_Fvpw>
    <xme:3x0LZeXyFBwt-lxlA6pB0aLYWXct5JM2NST6bpEWf8JTQSnRMFyTVKaD9dC2FIQ3Y
    SsNH9fgd2la40iTYzY>
X-ME-Received: <xmr:3x0LZbKBoT8K0r_RkyTJ-FwuuW-8eSJLGzbVAPdU3pDQ3OdLx6VUzckeO1H5Vr79reYDk3EMz8SXKkp4RFz6Q97-4oZvfl6KzcxMKsQOw6g7gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfhgfhffvvefuffgjkfggtgesthdtredt
    tdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrh
    hnvghlrdhioheqnecuggftrfgrthhtvghrnhepveelgffghfehudeitdehjeevhedthfet
    vdfhledutedvgeeikeeggefgudeguedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:3x0LZfGQRWOpYALml8lgOzYi6j0oFZVueCAxLXEYp1iDQNJGCPSTfg>
    <xmx:3x0LZfUAR52UiuT9GCnZqBOZezGIwmOlad3iKoDveXc6zIPMJRkwcg>
    <xmx:3x0LZaMi2pq3Q22AJ2Aads03Ryr0MYih_9tW8AYhtcWlHEN__fscgA>
    <xmx:3x0LZRIrCnzKNt3lIZkoUbR-4WmR251kzuMdSAK4OxCCiNuLZCjkdw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 12:29:18 -0400 (EDT)
References: <20230919205158.1897353-1-shr@devkernel.io>
 <20230919205158.1897353-2-shr@devkernel.io>
 <a86b8604-befe-23d9-3f7b-34dbaf399adf@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Carl Klemm <carl@uvos.xyz>
Subject: Re: [PATCH v1 1/2] mm/ksm: support fork/exec for prctl
Date:   Wed, 20 Sep 2023 09:29:00 -0700
In-reply-to: <a86b8604-befe-23d9-3f7b-34dbaf399adf@redhat.com>
Message-ID: <qvqwmsxgbyg5.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 19.09.23 22:51, Stefan Roesch wrote:
>> A process can enable KSM with the prctl system call. When the process is
>> forked the KSM flag is inherited by the child process. However if the
>> process is executing an exec system call directly after the fork, the
>> KSM setting is cleared. This patch addresses this problem.
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> Reported-by: Carl Klemm <carl@uvos.xyz>
>> ---
>>   include/linux/sched/coredump.h | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>> index 0ee96ea7a0e9..205aa9917394 100644
>> --- a/include/linux/sched/coredump.h
>> +++ b/include/linux/sched/coredump.h
>> @@ -87,8 +87,11 @@ static inline int get_dumpable(struct mm_struct *mm)
>>     #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>>   +#define MMF_VM_MERGE_ANY	29
>> +#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
>> +
>>   #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
>> -				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
>> +				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>> +				 MMF_VM_MERGE_ANY_MASK)
>>   -#define MMF_VM_MERGE_ANY	29
>>   #endif /* _LINUX_SCHED_COREDUMP_H */
>
> Fixes: tag?
>

Added fixes tag

> Reviewed-by: David Hildenbrand <david@redhat.com>
