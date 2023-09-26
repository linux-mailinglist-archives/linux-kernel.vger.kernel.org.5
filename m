Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FA7AF072
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjIZQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:16:45 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161348E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:16:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E66865C00A0;
        Tue, 26 Sep 2023 12:16:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 26 Sep 2023 12:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695744995; x=1695831395; bh=I8
        dC3DP9zi7HuNHGX4/XDLMbigK9k3MpPIy6l2HTeZE=; b=Zg64SfB59AcBYJQ+H7
        QaKBUJk1pe6142rAvTPPskcVLvsCFSZg/GGZ3Oml6Bk35quwVSpLNUzbD1n7yVY+
        NDJTA6x04X6feFde2q9IMG0RQ5rLq+kfj9W32hCxgX4BCYNhcObFrIDgQwK2Lh+/
        /QnksATVwncxOg9AZ5dVfY5v1wCrd7EQGhPC1O/UYDHmlsJpn7qVP99MBhhYiAY5
        smDnTC7ZR+dDtFHZbmN8xy+eATvdaou/MGwmJf3skjtb/FLVFjnLX2jPRy8Pgh1F
        sGLEm3PRbWHVGbZoPveSFuLQyqCJ6Ej71xHeUyZZ7V0ldZHdGh3KrjKKkgOuptIo
        cjFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695744995; x=1695831395; bh=I8dC3DP9zi7Hu
        NHGX4/XDLMbigK9k3MpPIy6l2HTeZE=; b=dckkDotCK9fhF/+mLZr/VmbmZaKqR
        dFDBYVmdHPN0pDTLj0hp12hEbq6ORFUYWAPGiQv361v2+yFpS83PFCJvh9y4p+sX
        7L4JSQ6L5NKFwUFtTIDA4XdNLnUpsX4L2RRpoE0C1uDGMpJdhuWuO88N0NwrUXhp
        qIcmy/0QEdy1hjV2Xuv/fHgkZzsy+EZuYmpcM+m2fsTZgzpW+iibdwv0+hYnti1N
        /yB96iHeVyQTtbay/sBGzI3GgMo4mbF9f9VPXNRBKL4duCM2iOZEZehiPNH2C0EH
        bTf0/sHU1o+jhLYnwgWIWNEmbJN7NRpbtOE+zxCMTMZgPaC3roRoJAORA==
X-ME-Sender: <xms:4wMTZbcftUEpTncLhAHXxtid7Z20LB98_XdOOl1ocR3ZWpc_b_MFyw>
    <xme:4wMTZRMHR-t8ZSBzMdWd_MXkKrtm29VbUM8XJShb4UMqwBghA6MIPZO16hBMbhGDp
    __Wfzp6hbkmITZyXlk>
X-ME-Received: <xmr:4wMTZUhtffSSnTo_jDVDDjYxkJTuUOwNPANKs4iK6FaGV3J2xrUA9B5wFOuvKbRAdlmOMIEAbpBRaH10j3CTYKM6SPqLC1p2FndS5md-jPI0dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdugeeu
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:4wMTZc-j2TwgpfAGPfVQd3lVbGFFbjNfOU4pYJ68s76kyHL47JH36w>
    <xmx:4wMTZXt97jID4pOmOeVjwMQOB60y7tRb3cp_jL0XyvxYqpTMW-5zUg>
    <xmx:4wMTZbGLksy2iWaks-6QHAIm2hpWzTkJBuiI6x_5X_z7sN9VFmoQAg>
    <xmx:4wMTZdX7n5HzHF6dbckYcqd6v0vNqciR0uLHBresSw1ywUpmeYAxpQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 12:16:34 -0400 (EDT)
References: <20230926040939.516161-1-shr@devkernel.io>
 <20230926040939.516161-2-shr@devkernel.io>
 <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/ksm: add "smart" page scanning mode
Date:   Tue, 26 Sep 2023 09:13:31 -0700
In-reply-to: <ae2be79c-a030-a4d2-0d89-15efa17fe77c@redhat.com>
Message-ID: <qvqwmsx83o68.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 26.09.23 06:09, Stefan Roesch wrote:
>> This change adds a "smart" page scanning mode for KSM. So far all the
>> candidate pages are continuously scanned to find candidates for
>> de-duplication. There are a considerably number of pages that cannot be
>> de-duplicated. This is costly in terms of CPU. By using smart scanning
>> considerable CPU savings can be achieved.
>> This change takes the history of scanning pages into account and skips
>> the page scanning of certain pages for a while if de-deduplication for
>> this page has not been successful in the past.
>> To do this it introduces two new fields in the ksm_rmap_item structure:
>> age and remaining_skips. age, is the KSM age and remaining_skips
>> determines how often scanning of this page is skipped. The age field is
>> incremented each time the page is scanned and the page cannot be de-
>> duplicated. age updated is capped at U8_MAX.
>> How often a page is skipped is dependent how often de-duplication has
>> been tried so far and the number of skips is currently limited to 8.
>> This value has shown to be effective with different workloads.
>> The feature is currently disable by default and can be enabled with the
>> new smart_scan knob.
>> The feature has shown to be very effective: upt to 25% of the page scans
>> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
>> a similar de-duplication rate can be maintained.
>
> Thinking about it, what are the cons of just enabling this always and not
> exposing new toggles? Alternatively, we could make this a compile-time option.
>
> In general, LGTM, just curious if we really have to make this configurable.
>

The only downside I can see is that it might take a longer time for some
pages to be de-duplicated (a new candidate page is added, but its
duplicate is skipped in this round). So it will take longer to
de-duplicate this page.

I tested with more than one workload, but it might be useful to get some
data with additional workloads. I was thinking of enabling it after one or
two releases.
