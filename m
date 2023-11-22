Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54E17F4E99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjKVRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKVRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:43:36 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC31A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:43:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EB9BD3200A24;
        Wed, 22 Nov 2023 12:43:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Nov 2023 12:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700675011; x=1700761411; bh=HG
        qIVGUX4u3PtJ0XmRkxpd4ga76lF2lDbzJ+i5QVFks=; b=Lhqp2f1KdShPl2Jus8
        DpvRpkbT3N1ebRoAo07BdizqTIMp2Ejfd7AxIcY1nycwzBFdr6N3wJn7KlqToXVE
        nAPgsUHSH0g5Of4GfN0z9UlnSWz6E8jYUpgiG5s2iSos5E+MIteBZJzNn+pGeE54
        qVnObB3nJRBMTOZT/3BX2xsl/CQNAo0/NZRf3D9vOZ5qd4mZG930C7MSnscFEwOa
        FIgTC41KNsBKR6XDpCSLawRbdPz2dvHUpS9p4NUs3WUBmdbX+/kiGBxfQZBbI977
        l+KohS4pQIopl6WFxW2WxOhmtYGbxRe9eDdlaCLc6gEdA7GdlcHkjG7mwtLwmp3i
        tgqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700675011; x=1700761411; bh=HGqIVGUX4u3Pt
        J0XmRkxpd4ga76lF2lDbzJ+i5QVFks=; b=gQ7X9tiIr/0YQPbX2tNSU36AJE0/1
        0AwevGsbP0k2eyCXphrV9hZw2TkXT+ZWe+GLrc7POmCEOIlM9lvrmCn4P5fFMQ3g
        WOVdzW/wRf+hBl+5W1AO1riQ8PrtEisimnzYBhaLt4n2faQ4OCzctQqbUs0czMHS
        LktQWJ0Axw2npGTxdmodcwcho5mJD4hu6QhckbCyWtkxCqqFk+UvXG+q0N03jRXJ
        5O0mxHo6kWozWYfvR7boTGylbGnd0aedHqodZJnSW0NjvQKUc3Nu2/InG2P9/qHG
        lopAdmKxr6ikVIdYh5sFtRHCa+LLWSmjBfYDcifoOO4kQ39yT+XznLJJg==
X-ME-Sender: <xms:wj1eZawGTpaIik7V0moXfsTA9Tqa1X02HWTWFt6VwwJHIhYt0_JAtQ>
    <xme:wj1eZWR7va865i7mHE85eTYFWM1VM5hXYa-dD4JhVnqITCXh8VasPdKV_BGE4JnNh
    ey0ITZNoRjMzWZrlIo>
X-ME-Received: <xmr:wj1eZcW5GYA_HXTzmgG7tV2VCyQxUqKP9vm7AEZeczYVCU5iG942QtX6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:wz1eZQiDWgTN4SKHNiQksrHPDrMjfGBMIywQv7yTDAMTKytlho81Dw>
    <xmx:wz1eZcC-5iPICkiRAfCJzoLosZuUBT1030MI3Xy6-TCVS9hUjIdsCw>
    <xmx:wz1eZRJUhnJ6jwbFFxCbgO9U9set3bhPsYOnoxWmai2yT93snoR1xg>
    <xmx:wz1eZb4FIcM3kLIroNfwiH9MEawYH0wYY6CBzOdAL7UxPc21LxNY3w>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 12:43:27 -0500 (EST)
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-3-shr@devkernel.io>
 <724f61a5-4d02-4232-ae8f-71f55e73186a@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Wed, 22 Nov 2023 09:43:09 -0800
In-reply-to: <724f61a5-4d02-4232-ae8f-71f55e73186a@redhat.com>
Message-ID: <87pm01r8eb.fsf@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 28.10.23 02:09, Stefan Roesch wrote:
>> This adds four new knobs for the KSM advisor to influence its behaviour.
>> The knobs are:
>> - advisor_mode:
>>      0: no advisor (default)
>>      1: scan time advisor
>> - advisor_min_cpu: 15 (default, cpu usage percent)
>> - advisor_max_cpu: 70 (default, cpu usage percent)
>> - advisor_min_pages: 500 (default)
>> - advisor_max_pages: 30000 (default)
>> - advisor_target_scan_time: 200 (default in seconds)
>
> Is there a way we can avoid exposing advisor_min_pages/advisor_max_pages and
> just have this internal e.g., as defines?

Yes, we can.
