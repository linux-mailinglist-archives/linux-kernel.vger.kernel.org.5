Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8CB7B6AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjJCNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjJCNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:40:53 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14591AD;
        Tue,  3 Oct 2023 06:40:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8AB133200B40;
        Tue,  3 Oct 2023 09:40:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 09:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696340445; x=1696426845; bh=pFiUCM0Cn00jPD1kU6gNbpIBQuIHykihdnF
        gCoeT11M=; b=N1rsup18Lf/e/7bOBtifmqIztvYO5QZengtcNpzCJUyAeIOrTTQ
        RwSPWXxrpgkpGub37RnfhA4l8kNZQ2/6ISAtp4cXBp4pd3EKcIhdhuISJbqMH3QW
        VqmrZPyWiiojsQA5j+Bq7TWvI7emjjNTTN97CZt1V3mWhIJWVUJQuhxqkN9PWg/v
        LRsQuH3JdNmtHO9nOBgsU8298q1dSBXlrhbpGNJfHdzpTlRkTe1EgY800b63u7Kb
        BE87xNSa8uC4A/ZlPsfVjAUyBOFSn3Vdg+iypFhO55M2CVb0AeST8iyxupVigOkg
        ZzNy4a+XxzwvQjdzhcXceRKkfi/dSkqG9TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696340445; x=1696426845; bh=pFiUCM0Cn00jPD1kU6gNbpIBQuIHykihdnF
        gCoeT11M=; b=X8xWX1F87dFRO3w8fBnHCxAjOlmej7UIeTtFEDQO3JFj/z8xhhD
        aqjCsFoshVqquyrxj81l2OdqYMGnfHAoT/nqTkKtWiJf1IHJu7mnbaf3Z3PuCYs9
        b2sM7M3PJmxAbYOTRr89zA4YghcmGNN23VyItGXPLMnhNfFmxRHKF2Y/p31zrZv3
        DF9LC44mfcQ40ZFJUDlywjvAn5wtDgx+gcB11wfUg46FGB+GOkxW2me4VD3jXMEt
        HEjHxcA4Regb8zAABd97Eh+CtQ3ZujpuRyzA5jWMBKBNjnLTgdEOeerC58PD2e44
        lyRKaXA+a0Lr+HSchP8KNTHjK15YI4eq2cw==
X-ME-Sender: <xms:3BkcZWwjGs7LvcVC55nvMdLGmR9riSdPjYORODr6gtPz9GK-cGTc-g>
    <xme:3BkcZSQ5etQsozNBvMakkeCpck1-cuwFp8qsdzYhcDYWMnIzwv3bf1CflTP_ep1Jz
    q_qiNJY6B2xjdIbGVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3BkcZYUE8SN8HerVPa3OcBXQR5czyY9JUEKot_I15wNz2yoWT1VMDw>
    <xmx:3BkcZcjWLZ1RDOhC-0EiDQtl_E_FbQc6oFR5BbIP0uTIq5yMO9Maaw>
    <xmx:3BkcZYDnH8g49iUq2pL8bFWVz9yW9vTeazdOY-kBlLTanv0l-TuHtg>
    <xmx:3RkcZRJZ3hxVzxVnwd3RLlepQE3kDRSWegZNuC_ltIWliSaKyMIg3w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0F0E8B6008D; Tue,  3 Oct 2023 09:40:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <0174c612-ed97-44f3-bec5-1f512f135d21@app.fastmail.com>
In-Reply-To: <20231003.ahPha5bengee@digikod.net>
References: <20231003.ahPha5bengee@digikod.net>
Date:   Tue, 03 Oct 2023 15:40:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Cc:     "Konstantin Meskhidze" <konstantin.meskhidze@huawei.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
        gnoack3000@gmail.com, linux-security-module@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        yusongping@huawei.com, artem.kuzin@huawei.com,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the landlock tree
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 15:15, Micka=C3=ABl Sala=C3=BCn wrote:
> PowerPC-64 follows the LP64 data model and then uses int-l64.h (instea=
d of
> int-ll64.h like most architectures) for user space code.
>
> Here is the same code with the (suggested) "%lu" token on x86_86:
>
>   samples/landlock/sandboxer.c: In function =E2=80=98populate_ruleset_=
net=E2=80=99:
>   samples/landlock/sandboxer.c:170:77: error: format =E2=80=98%lu=E2=80=
=99 expects=20
> argument of type =E2=80=98long unsigned int=E2=80=99, but argument 3 h=
as type =E2=80=98__u64=E2=80=99=20
> {aka =E2=80=98long long unsigned int=E2=80=99} [-Werror=3Dformat=3D]
>     170 |                                 "Failed to update the rulese=
t=20
> with port \"%lu\": %s\n",
>         |                                                             =
 =20
>             ~~^
>         |                                                             =
 =20
>               |
>         |                                                             =
 =20
>               long unsigned int
>         |                                                             =
 =20
>             %llu
>     171 |                                 net_port.port,=20
> strerror(errno));
>         |                                 ~~~~~~~~~~~~~
>         |                                         |
>         |                                         __u64 {aka long long=20
> unsigned int}
>
>
> We would then need to cast __u64 to unsigned long long to avoid this w=
arning,
> which may look useless, of even buggy, for people taking a look at thi=
s sample.
>
> Anyway, it makes more sense to cast it to __u16 because it is the
> expected type for a TCP port. I'm updating the patch with that.
> Konstantin, please take this fix for the next series:
> https://git.kernel.org/mic/c/fc9de206a61a
>
>
> On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>=20
>> After merging the landlock tree, today's linux-next build (powerpc
>> allyesconfig) produced this warning:
>>=20
>> samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
>> samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects a=
rgument of type 'long long unsigned int', but argument 3 has type '__u64=
' {aka 'long unsigned int'} [-Wformat=3D]
>>   170 |                                 "Failed to update the ruleset=
 with port \"%llu\": %s\n"

I think defining the __SANE_USERSPACE_TYPES__ macro should take care of =
this,
then __u64 has the same type as it does in the kernel.

        Arnd
