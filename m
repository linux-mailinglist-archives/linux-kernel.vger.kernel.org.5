Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67C88081AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377834AbjLGHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjLGHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:13:41 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91A193;
        Wed,  6 Dec 2023 23:13:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5DB9E5C0106;
        Thu,  7 Dec 2023 02:13:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 02:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701933226; x=1702019626; bh=Gn
        fimb5hncqefIVhB4bE5spPvjRgxNsO0UKP3I5CJ24=; b=gnWq7FOm+5cnwGQBNT
        HmxCJaQ6tNzZTBXwtwv4/U8MjVoAXSBaFsj8tCRvV/BdnA+WMCMl09H4NX7R26EH
        ztsKPXk18n4GmiTwUGKHgnnbQ19wv6Xky3yCMWxwc8DbP+wychgUnL0C2+jhXGEf
        O/9WttnO4lcFOnYNjO7cwgYUzaZaLTAb165HkfnfIizoJk/M+Oyo1HGBGGtoWmA6
        VQZMREfGurPDXfwB9mG1K+m2Xv/3e3pf9//q8A+5o5FPXyiE+QwXZpuvWEK1wcyd
        UNI8mtli1S/uip2jJ0Mv/uyxLj7LDpx4pz/sgwoM6gSMR3fCzpn5Mr90naURD794
        8AeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701933226; x=1702019626; bh=Gnfimb5hncqef
        IVhB4bE5spPvjRgxNsO0UKP3I5CJ24=; b=i+Y4B8PbYyANvyOKhO2ZnAkV6NfvF
        D7FoMvWU4H3mHECLyfTlqlCbPQsRoeqbrnWKcQ4yoQi6Z/JglUWjGa06eOeYcP6A
        5nFZ7KITak3ZnK+JnvvwRtbq6tpX3JDgUmoLlDT2e/WPl7vJY15tW9pIzD/wWEk/
        Da401Dm81NtH/LaROxplvxi9AsVJwSAv09extM7e7OwEr0vHFoBuwkBN4ZQmFCxP
        N23FYqsOY0JH4PuesXQxD17qLS7xynAssFV5EoGKAczh8ngtORvqgZ5Vy3bXzGXc
        CebPyc8dQk9g5nt4HG4lAYhCVlR3sVbQ6ffKL4EdiZlhUhUFgMT2bR6HA==
X-ME-Sender: <xms:qHBxZd9sCX8c6trT7KmRinsU51OWkr_7BMZpuhqo0QsiTLjfsrs8Gg>
    <xme:qHBxZRvRXZYKtkDm_oGQNkVVOhb0lvc-P42yCjwInwOAE65prjpo9JG_CB21F-bI3
    txS6V1F6PPV89SEeuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qHBxZbCiFHYuaKoPVy2qV56RM_cEsEzx5FDH3xWw92oZRmnb109z7w>
    <xmx:qHBxZRfRFrAOpnYshMVHwUX7bEKa3ht3Z4YoOBU-45OmsmQRF_J9Xg>
    <xmx:qHBxZSN1CWnXaxU3_PyI1GtDy0lmgWwhKUBiS1Ks_M8LGXiNlUJ6Jg>
    <xmx:qnBxZXZgt3s_BBYuiKpH2X6KqajrkKo09kfgHL-dtMIDOwdv8qCGaA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A144DB60089; Thu,  7 Dec 2023 02:13:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <67fab0f1-e326-4ad8-9def-4d2bd5489b33@app.fastmail.com>
In-Reply-To: <20231207002759.51418-8-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-8-gregory.price@memverge.com>
Date:   Thu, 07 Dec 2023 08:13:22 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        jgroves@micron.com, ravis.opensrc@micron.com,
        sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Michal Hocko" <mhocko@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        ying.huang@intel.com, "Gregory Price" <gregory.price@memverge.com>,
        "Jonathan Corbet" <corbet@lwn.net>, rakie.kim@sk.com,
        hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Frank van der Linden" <fvdl@google.com>
Subject: Re: [RFC PATCH 07/11] mm/mempolicy: add userland mempolicy arg structure
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023, at 01:27, Gregory Price wrote:
> This patch adds the new user-api argument structure intended for
> set_mempolicy2 and mbind2.
>
> struct mpol_args {
>   /* Basic mempolicy settings */
>   unsigned short mode;
>   unsigned short mode_flags;
>   unsigned long *pol_nodes;
>   unsigned long pol_maxnodes;
>
>   /* get_mempolicy2: policy information (e.g. next interleave node) */
>   int policy_node;
>
>   /* get_mempolicy2: memory range policy */
>   unsigned long addr;
>   int addr_node;
>
>   /* all operations: policy home node */
>   unsigned long home_node;
>
>   /* mbind2: address ranges to apply the policy */
>   const struct iovec __user *vec;
>   size_t vlen;
> };

This is not a great structure layout for a system call ABI,
mostly because it requires adding a compat syscall handler
to be usable from 32-bit tasks. It would be nice if this
could be rewritten in a way that uses only fixed-length
members (__u16, __u32, __aligned_u64), though that does
require the use of u64_to_user_ptr() to replace the pointers
and the reverse in userspace.

Aside from this, you should avoid holes in the data structure.
On 64-bit architectures, the layout above has holes after
policy_node and after addr_node.

      Arnd
