Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352A37D16C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjJTUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjJTUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:07:21 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D19D63;
        Fri, 20 Oct 2023 13:07:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F1395C0040;
        Fri, 20 Oct 2023 16:07:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 16:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1697832437; x=1697918837; bh=krgRG5ssPVrKu1an7h2M8y5D/EOyXr2xu6O
        1a2sTjg4=; b=BXBnjeZtYkZ/AwNYLeUxSVzX8yFEAxcqK/bYd/7us0Ezas47U00
        jHjcHlIoqkDdriTshuakzddt+3Q/FyaF6FwiDMI6oiUXJ/BoOK2nrjbf/8uz7ABl
        cdh2LUU32dScffQulKc8UUcc88ajZFrUlM2s8h5AQy/UgfoGeMzBL07NV+vcJCcX
        pJkW5bD2xSCDdhvccdO75ShOHQGXAZ6I1QXer0+N8AUCrnCRvxL+7bD54oQxSXVc
        r0MLGvQbtjZ9I+Ymk3IKeOzmwHFtWP/5TjQ3J/hMhuFeJ7NsxR+QG0PEkYesbBRX
        16gzuVLWjT3iEGCRazEIPAysmBLeZKB/kRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697832437; x=1697918837; bh=krgRG5ssPVrKu1an7h2M8y5D/EOyXr2xu6O
        1a2sTjg4=; b=bKKQDZX+o61ziEh51I5e2IjOUU5kWhBjRoa/w0GEWg/MzuyoAmP
        OgyHLQqdTlDDb9wA3VPKRKpMnIxmcvu8SwnUQgJ+uvkPTfh4snUtjz3OTEWwwK4h
        r539oOsgvXwJ7HIzMFAx8KCH/Chs1oU3UEuKac+Ck4FUXfAYXkX+fN+TQWjsKT8d
        32EzA+K9ZnZPOqVenDkETTf7tuBawHw2nkT4C7TsqmtG34/ElGae3XRQu3BNyFJK
        cgLCo+09EzJJuITZv8TeXXAEJskaiekml9L8f/5Dq8Bp/zd6T3h6fek/2xJiF6qB
        UbTmhtbug7h/pRHTKkT0fn5PTaGYhCeSYGA==
X-ME-Sender: <xms:9N0yZRdRnPrIXrKERB59DvvzWrVt3SMUiueStJiCB8eCMFV0PwNkTQ>
    <xme:9N0yZfNMkyBoC6975-_XfRxnXfld9ATQlZEjKNldjJC6sX02pVTAWY_1K5MWn7e9I
    PyB4ys7emVNHUZqmYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9d0yZahtPtfag39CovwLGtWQj9SUQ3J5QhAYwYd1Qn2Xs7c8rXcRzg>
    <xmx:9d0yZa8M3ccq1mPBxC-3jgx1tRywgwAVIj6MHKq3Fqk0RNyMPadigA>
    <xmx:9d0yZdtkG2J2EQFsgTK3OEbM5YKxMSgZfi-W91FVBP9BPHPzppLSvg>
    <xmx:9d0yZdO06buusJ0x7Rs0_amFYTX0Zj-VZtCSLuK4vHozRyH3jQrPhw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0424B6008D; Fri, 20 Oct 2023 16:07:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <5e45b11b-853d-49e6-a355-251dc1362676@app.fastmail.com>
In-Reply-To: <CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com>
References: <20231020132749.1398012-1-arnd@kernel.org>
 <CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com>
Date:   Fri, 20 Oct 2023 22:06:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Yonghong Song" <yonghong.song@linux.dev>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Chuyi Zhou" <zhouchuyi@bytedance.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: hide cgroup functions for configs without cgroups
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023, at 19:26, Alexei Starovoitov wrote:
> On Fri, Oct 20, 2023 at 6:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>> @@ -904,6 +904,7 @@ __diag_push();
>>  __diag_ignore_all("-Wmissing-prototypes",
>>                   "Global functions as their definitions will be in v=
mlinux BTF");
>>
>> +#ifdef CONFIG_CGROUPS
>>  __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>>                 struct cgroup_subsys_state *css, unsigned int flags)
>>  {
>> @@ -947,6 +948,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct=
 bpf_iter_css_task *it)
>>         css_task_iter_end(kit->css_it);
>>         bpf_mem_free(&bpf_global_ma, kit->css_it);
>>  }
>> +#endif
>
> Did you actually test build it without cgroups and with bpf+btf?
> I suspect the resolve_btfid step should be failing the build.
> It needs
> #ifdef CONFIG_CGROUPS
> around BTF_ID_FLAGS(func, bpf_iter_css_task*

No, I did test with a few hundred random configurations, but it
looks like CONFIG_DEBUG_INFO_BTF is always disabled
in my builds because I force-disable CONFIG_DEBUG_INFO
to speed up my builds.

I tried reproducing it with CONFIG_DEBUG_INFO_BTF enabled
and it didn't immediately fail but it clearly makes sense that
we'd need another #ifdef.

      Arnd
