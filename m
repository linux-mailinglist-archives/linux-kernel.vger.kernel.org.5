Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D147DC3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJaBXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:23:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F22C1;
        Mon, 30 Oct 2023 18:23:46 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 8DFAB5C02B7;
        Mon, 30 Oct 2023 21:23:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 30 Oct 2023 21:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698715424; x=1698801824; bh=ECJVLlwFCF/F13QtKPM5WP7/K4iiTwcNU6h
        5mUohoTo=; b=nhepGC7V5AVwfIUrdbvCdHNrqipLAurfvLbQehLFlJ53PiUjGoZ
        YQNs45CB7LtqeuVosRrGDSCuNaN0knFyLHWoleezyEpj6oloWy1y5T8EzTMn6wib
        qgRnbta7rHMoy6m2/X/nmzMo9p7hgeZL/CyqTvzZLRYo08N/IYYZBHv34K4ZEDiM
        8F0SAyY4pTpoweMqbam8L6MaDOFST2SHTpkK2SyA7tjPSAtVu0Th86zROcl/daSv
        ZaHowa3QE+DWxnLYTZxxPuExD2IDfLP4EkxVLOFwlZmw/CERmalaW+PssNvFlqyh
        Vf0zb0jlh87nSrFAEnyfYZbG0spHqcDbqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698715424; x=1698801824; bh=ECJVLlwFCF/F13QtKPM5WP7/K4iiTwcNU6h
        5mUohoTo=; b=V8vq+xXih7rt9zzoQ8UjyrZgqbTJ3TvTAvP874IAxlU1ZKueUtG
        9rbs1eKo1yjw0lpwbgLt1duEkvmUkBEXFzytHMf6+add0oa6AIGM54KmG8ghAUjW
        wT5BCE2sTlUGsZ/xjujq3pzW8sNzTH3g+RE77BA+KeDTnakzcIb0TLiC02ppEb6R
        Fpt1fTHiuGTI6fzluPvumknJRDzLCMcooAHnrHXeUtgLJZ/hel1/HGECO+m8i7Xf
        bPwv4NJnSkmopsngxXmfUSZSSftmxvTDJsazZhukrALWo0AqKRoCHxj/dz6IxAoG
        eD+h1q7A1dmGBYdgnl256NOMTlb15CG87gQ==
X-ME-Sender: <xms:IFdAZbdzt5swDur9SJgkwlMlM9x9fPbrVufTYtnT3DsCCZqPw-ykZg>
    <xme:IFdAZRPLvMUYngRg_04AFTNgQQB6N5rOM7SRkWn3-0sNFmpt5s2W-xJdQW19rX4lj
    mzvcj7duPMx>
X-ME-Received: <xmr:IFdAZUjhuXbqySMP7cq0xc9Y1HFDOcYPDH7gIIXImH6bWiQrkLDZUDATqZx8BuTDAdOlvlWbbR9_k-zzhwgcav07ePI69O050hrpKLoL9H4fKb6Y3gRB8p59>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:IFdAZc8Hz_CAmHd6_QT7WICbJlGEOQJa5RjU7i9Ek7WjkG18ursrIg>
    <xmx:IFdAZXsRQnpZMiYFcq_s2XhDgYHths2h5mX8fHb5jGCOF1NLLRNbAQ>
    <xmx:IFdAZbGPILKcM2IMg8Uch2zKFbdeoyY1WTx8T6scyqyFwSfTBFv8Vg>
    <xmx:IFdAZQEFxaEAMEdtJXVJxFFpaZ5MEiZJF7H_gGVvB9NURssBzd_PZw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 21:23:38 -0400 (EDT)
Message-ID: <e9ceb034-e37e-f0af-aee1-85f573a41418@themaw.net>
Date:   Tue, 31 Oct 2023 09:23:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/6] mounts: keep list of mounts in an rbtree
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-3-mszeredi@redhat.com>
 <b69c1c17-35f9-351e-79a9-ef3ef5481974@themaw.net>
 <CAOssrKe76uZ5t714=Ta7GMLnZdS4QGm-fOfT9q5hNFe1fsDMVg@mail.gmail.com>
 <c938a7d9-aa9e-a3ad-a001-fb9022d21475@themaw.net>
 <dfb5f3d5-8db8-34af-d605-14112e8cc485@themaw.net>
 <cbc065c0-1dc3-974f-6e48-483baaf750a3@themaw.net>
 <CAOssrKdvTrPbnicFTiCiMNhKfdfwFEv4r_y1JeEe+H5V6LpkKg@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOssrKdvTrPbnicFTiCiMNhKfdfwFEv4r_y1JeEe+H5V6LpkKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/23 17:06, Miklos Szeredi wrote:
> On Mon, Oct 30, 2023 at 6:45 AM Ian Kent <raven@themaw.net> wrote:
>
>> Is fs/namespace.c:iterate_mounts() a problem?
>>
>> It's called from:
>>
>> 1) ./kernel/audit_tree.c:709: if (iterate_mounts(compare_root,
>> 2) ./kernel/audit_tree.c:839:    err = iterate_mounts(tag_mount, tree, mnt);
>> 3) ./kernel/audit_tree.c:917:        failed = iterate_mounts(tag_mount,
>> tree, tagged);
>>
>>
>>   From functions 1) audit_trim_trees(), 2) audit_add_tree_rule() and
>>
>> 3) audit_tag_tree().
> So that interface works like this:
>
>   - collect_mounts() creates a temporary copy of a mount tree, mounts
> are chained on mnt_list.

Right, sorry for the noise, I didn't look far enough.


Ian

>
>   - iterate_mounts() is used to do some work on the temporary tree
>
>   - drop_collected_mounts() frees the temporary tree
>
> These mounts are never installed in a namespace.  My guess is that a
> private copy is used instead of the original mount tree to prevent
> races.
>
> Thanks,
> Miklos
>
