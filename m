Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77417AF872
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjI0DIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjI0DGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:06:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9497140CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:39:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AFAC15C2646;
        Tue, 26 Sep 2023 20:39:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Sep 2023 20:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695775168; x=1695861568; bh=FJ
        cCaP4MuvryHEoEUOeUXajPd8VqAGlTE+SmLU44ry4=; b=Dw9OQxS+KdAP3Jr5JK
        +M6z7yEbV0uBDa8LNmm9KcarKaVgRCoLoDcx7lcPUsWRbBxyXMZtDAqFdjg3IfOU
        1eA1ucrxMaA9/Mm5qIgL8ZraGgEOO+98sJgaz70PlvbXODMbQq5XSmvRj73G/KzF
        kc4Ohl2I14T645tdIHj4VapJHk0S3bT8kB9+v+nxDZblTV7gvAPBctllj7wLOb0b
        bdQ204SV20eAcXTM93q75KlYz+D9gV3asSTTrRdiMty2EPtcCeBOvNrfynlhl7fZ
        WcT/RwBq6tWlF3ThVCBumz1rJtet4nu2q2NuCApNHoktIo68ZNNco+4bTL0GDFL/
        tEKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695775168; x=1695861568; bh=FJcCaP4MuvryH
        EoEUOeUXajPd8VqAGlTE+SmLU44ry4=; b=P7wJVG+iBD4UMTt1qLcnPrIwHXJOL
        sU6KpFrfdEZiyW2Ddi0tnq6tVhRpfeP+YA/lJZLF02zn5Q020liZzSK9w9WPPbmU
        hH0nbcwnITbOvVgBktU6pz6TeME4W3tfEgl6uxyQsPB7NpjtiOCBlYg9IoeJ8Ppp
        BlKXQQcLNwPX2fPd3Jm1UVn2Rw6IrcQhdLk23X8nUW36LXES5vDufCEoqW/CpV8K
        bEnFngBEgq0v0KR8WB8YVoS5SQuxCXjx8+dShbSG4I8jR05xMe9xmGqdxSTGfgBc
        ElD4un7mBAlqId+bKQ5g5RVTqS8XZNydNrQ9RfKezL0rI3NGvO+mOvF2g==
X-ME-Sender: <xms:wHkTZV5IhFtQzEJruWR-oQlo0DaTshWUUiyOcWvZf2BhohiM_W-law>
    <xme:wHkTZS5g9VIr0h47GV6NOTGD7cxJWtOSN-Tb3617liDHdUOqZWjsVHVwSwYoJ8uHX
    v_kDWCbiGDe513C4qc>
X-ME-Received: <xmr:wHkTZcefq0wIvjdaYN9KXeAbOM-vIgGPldq6N_vVeNY_A0a0XHzoshgkhj1t_YyC1ZeK4t1QPohywjTMOJsB3Tzb8X2hHj89lvtwCIJjsvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdugeeu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:wHkTZeI99_hZXge_mUQmHXqRDdPepw9lVjy8DwTYBSncAsvejclKnw>
    <xmx:wHkTZZIpemc9LvEip4KRSWx8VSp9UWW8cuR_bgP3mggAiKwHWhCaqA>
    <xmx:wHkTZXx72z9loB5CqMqV48CLEu2H6fyNr2gKdL8qUr2o8nv5Cjf1kw>
    <xmx:wHkTZXjpoXzeH7o7vlLE7uJfry6WRCI-9rXGD-nKPUEprCJjQDszdg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 20:39:27 -0400 (EDT)
References: <20230926040939.516161-1-shr@devkernel.io>
 <20230926040939.516161-2-shr@devkernel.io>
 <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
 <qvqwmsx83o68.fsf@devbig1114.prn1.facebook.com>
 <20230926140955.8b2627711116339af80731f2@linux-foundation.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/ksm: add "smart" page scanning mode
Date:   Tue, 26 Sep 2023 17:39:09 -0700
In-reply-to: <20230926140955.8b2627711116339af80731f2@linux-foundation.org>
Message-ID: <qvqw5y3w30w4.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 26 Sep 2023 09:13:31 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> > Thinking about it, what are the cons of just enabling this always and not
>> > exposing new toggles? Alternatively, we could make this a compile-time option.
>> >
>> > In general, LGTM, just curious if we really have to make this configurable.
>> >
>>
>> The only downside I can see is that it might take a longer time for some
>> pages to be de-duplicated (a new candidate page is added, but its
>> duplicate is skipped in this round). So it will take longer to
>> de-duplicate this page.
>>
>> I tested with more than one workload, but it might be useful to get some
>> data with additional workloads. I was thinking of enabling it after one or
>> two releases.
>
> We could keep the tunable and make it default "on"?

Sounds good to me
