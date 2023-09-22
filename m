Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D67AB5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjIVQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjIVQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:21:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB337CC1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:21:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D7CCB320085B;
        Fri, 22 Sep 2023 12:21:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 22 Sep 2023 12:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695399698; x=1695486098; bh=l0
        GrjrIypWNrvLrMpjxWoVWk3qVTn1PfECewz++IatQ=; b=vhHMv1cQnO5x40/4o0
        uwiDeYjTh1i4iTha5hAYO1s5L/pZDueCB0K1EqkLRCLLOn+28cEx5WmcrHT4p/4+
        AQCOE+M5MieT2k/PmX0ivu7nabxOTnx9BnlDBa16N637G6D6ouxAcvZUjWGBUWTy
        FA5PICARqWElUaPnuPFgb+HL2JCa3V3oWrUoLNZ52e153ZA0cvL46eXC0gZWJtgJ
        Pp8nDHrc9mkKy3wdugQ5lioB/JyE1DCrh6Mhp1IHwxPFefG547gbhT4r2xRBwFVu
        WSK9g1nU4Zs1l84NLp/HwXKvljHrEQRA7+RDnnEsEbi4wz3Pqo9FSnjqjqxPGHnv
        7Biw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695399698; x=1695486098; bh=l0GrjrIypWNrv
        LrMpjxWoVWk3qVTn1PfECewz++IatQ=; b=ZMACuU8A891NRckNQxCOedNH5smy4
        RpnglAwhGqfZGPul3JRi83iOOoG/wVygaInrp6Jw9M706+6ksemWfvAloCXlP7t3
        9DTssfCDY2v22irBFMSWrxVTo0wHdSahgbhN/vN4iGbxC8iTrKbkPm/is+FK0vIV
        aFp/DDD0WF+/FYaON92uq0n68/qpncnZH1nJSTkG7GS6Wv1/7ebEEBkqZ/FbHtlq
        yWnjKEJjDmyTUuKMCSxWAn2K17J1Y+mDwn68kXenU7bqfTI7vJIT5ibw6OR+7dyo
        22+AyxgKm4d5NxchDwJsPjvMMH84HnkSmHf2qHAwWSUnnHcKV7sc2p/dg==
X-ME-Sender: <xms:Eb8NZZcMoprEUBNI3UM0FWRYZHaT935pi3sTbVQoQreE8O69644S9g>
    <xme:Eb8NZXMieUMn0v_OnB_g8aV48ZLk-O6OeywFmF5J5xQL8RQyIihtUMe_raiAVn0A_
    cSqc0bkAYRgSKyMz9U>
X-ME-Received: <xmr:Eb8NZShV6wKabY59Zdr1D035SWfL86FsZrIHrN-hsT6Xie4jhLjcNmFcXfUGuU_y5_qOE9Vso9X7EXSJgZrcxFgoM33ADEotu06KD7FrTcC7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:Eb8NZS-eeCK-D0PsKhDa_ptzduh9PPg6yHdu3pq_f7rIn-WCUHLh5Q>
    <xmx:Eb8NZVtYEd0KOXmxvBzcRsOUKNqGHk5GRT0rcWaQ_e-6_7A8AZdIEw>
    <xmx:Eb8NZRH9jpRYttNMf9Sv8-eMwgtMwp2A-Dz2F_vLT4jjGp5SVG3p5Q>
    <xmx:Er8NZTXoe3UnXDQkKG0dwACN4PMiKUma7ag-8uZaR7hU9WJUwI6Rfg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 12:21:37 -0400 (EDT)
References: <20230921164709.3627565-1-shr@devkernel.io>
 <20230921173251.54b854fb0ec7af2bf3e3ec3b@linux-foundation.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] mm/ksm: add fork-exec support for prctl
Date:   Fri, 22 Sep 2023 09:08:41 -0700
In-reply-to: <20230921173251.54b854fb0ec7af2bf3e3ec3b@linux-foundation.org>
Message-ID: <qvqwttrm9o1f.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 21 Sep 2023 09:47:07 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> A process can enable KSM with the prctl system call. When the process is
>> forked the KSM flag is inherited by the child process.
>
> I guess that's logical, as it's still the same program.
>
>> However if the
>> process is executing an exec system call directly after the fork, the
>> KSM setting is cleared. This patch series addresses this problem.
>
> Well...  who said it's a problem?  There's nothing in our documentation
> about this(?).  Why is the current behavior wrong?  If the new program
> wants KSM, it can turn on KSM.
>
> This significant change in user-visible behavior deserves much more
> explanation and justification, please.  Including an explanation of why
> it's OK to change kernel behavior under existing users' feet like this,

Today we have two ways to enable KSM:

1) madvise system call
   This allows to enable KSM for a memory region for a long time.

2) prctl system call
   This is a recent addition to enable KSM for the complete process.
   In addition when a process is forked, the KSM setting is inherited.

This change only affects the second case.

One of the use cases for (2) was to support the ability to enable
KSM for cgroups. This allows systemd to enable KSM for the seed
process. By enabling it in the seed process all child processes inherit
the setting.

This works correctly when the process is forked. However it doesn't
support fork/exec workflow.

From the previous cover letter:

....
Use case 3:
With the madvise call sharing opportunities are only enabled for the current
process: it is a workload-local decision. A considerable number of sharing
opportunities may exist across multiple workloads or jobs (if they are part
of the same security domain). Only a higler level entity like a job scheduler
or container can know for certain if its running one or more instances of a
job. That job scheduler however doesn't have the necessary internal workload
knowledge to make targeted madvise calls.
...


In addition it can also be a bit surprising that fork keeps the KSM
setting and fork/exec does not.
