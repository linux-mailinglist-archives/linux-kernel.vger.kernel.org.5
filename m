Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0587F4E96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjKVRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:42:55 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6274DD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:42:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A70CA3200AB8;
        Wed, 22 Nov 2023 12:42:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Nov 2023 12:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700674970; x=1700761370; bh=4q
        GVKYT1B7qwrlgMwXg0Fed9QuLJAWFc+73xVSblvWc=; b=yjVY1zX/CNOjDgaikV
        KsgA6T4ZmG6zmYW2MMeR1ZglSZzQgqh+6Ntz9UCLSsXneW2/rJBZbKYMdTPBnKey
        wymd4Do69W+xJLCgu6xVkpPDVIMSvX3+LtafOwrX4NrILQgnxd89WMe963gaMQXI
        NpD4DmIYzsDF1YcUx3nH5+jwncBy971m1TkuQuFw26OoDPLO/6ftlP0NgD9MYBR8
        B+tJ0uRkvmZys8qPDBInOMnLVsgdhCfCgJ+pQcSyAvza0EVB0ZRp01tVHESvJP93
        ynPiftFjFJIPjkqMNnjhJUa/iuJikG0AkIAwGv2J2wjfldOKrNQQVcljCFfpOcCA
        ebKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700674970; x=1700761370; bh=4qGVKYT1B7qwr
        lgMwXg0Fed9QuLJAWFc+73xVSblvWc=; b=QB6J1++lSADjwDoB6VBvueQz7pYTh
        l3pptE8/mpJrECczilynFgu8hI5KmXWbYqlnE7SqNpf6RTB3gro3vCb6U6gjzNIo
        aREz4e1jSSydgYiZUstUb3EeLG/mF8Ht1k5yu2k65m5YYGFLmvDkRgYK+FGn3ohj
        QdwVdqc+L1rekzylds7NrO+Gww6tekCcLKL5FTg4BakG5OFt5D0MesuBXboFioSN
        63kw8K2rr9LQ0oROIlhWd7UQwwIM9+8xjsgafl3Rxe2bY71v0FZzx7VMh5H4yw8A
        /arBxIKldQ9zpx1y0clQjLyImIKpIOrciK25nev74S4sYaG7iQ/7OzsKA==
X-ME-Sender: <xms:mj1eZWzskVSaneH9uakMf_rmGLV8Mu2WeSfdzjdhfM7rrmgyB2tuFA>
    <xme:mj1eZSTOEADKjYP6UUU0usCEyCnh321nwgGlBmcY3hQvtIE58jJMahNSPJ1tQpH8M
    3YDo0P2ych61Hw8Xnc>
X-ME-Received: <xmr:mj1eZYV17FgD3LT1o_YYSwkIoVC-V8LIOYvozOlGSrwJqm-FOhIbE8CI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:mj1eZcjzwj-MqWKv-iibuyoqEUhMqsZGnNHWxFrmH4ILGAS_0BOw8Q>
    <xmx:mj1eZYBAq7V4NyOToJ5bsjgMxW4EZLaiWtqjx2W4CYLalkFLVPawGA>
    <xmx:mj1eZdISxCydl8WfDxYDvg9WdBwKXAvlEqe4AnKBeZxABdjAXlWtiw>
    <xmx:mj1eZX6auqfVb8_6_J2KpOS29EujKcMeDuFWsQ1TeGN41MQNvzBBBg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 12:42:48 -0500 (EST)
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-3-shr@devkernel.io>
 <724f61a5-4d02-4232-ae8f-71f55e73186a@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Wed, 22 Nov 2023 09:42:16 -0800
In-reply-to: <724f61a5-4d02-4232-ae8f-71f55e73186a@redhat.com>
Message-ID: <87ttpdr8fe.fsf@devkernel.io>
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
>
Yes, we can.
