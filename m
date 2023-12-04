Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6282803EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjLDUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:07:21 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D8D2;
        Mon,  4 Dec 2023 12:07:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1521A3200AC2;
        Mon,  4 Dec 2023 15:07:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 15:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701720444; x=1701806844; bh=9anVqRMnfV6B5EoLFHEo7lDtKN9nMWpzmp4
        bifNE4cs=; b=omPDKffjOnPSb+/bslfn4VK83XyifFieLu9Ywi75ziHYRaNiOJ5
        mn1ySINpO9YTCpp5AK2eNi8GYbLpIV0eZguATq+gYc1i3Dto0Jts/q+eauDelC1E
        +9XUgxvp+5Gjan0i7yrsurgGcP3G7+NH51sYKB6bT6R6vtAQd1twQ58v0hor04BS
        eGjLfMbE2lbyRBwuLosW4D+lO2dEpzywTlYm98b47iPKhO/jEoKDRhhJHz3E1YAs
        0teaAld5oZznBGs1kJLxPd82RQVYAF9hNmW3/4WkmWBRIekZmUtKgC+NFL+g8rXQ
        LjZBAnJH0vpg3yH8DtOxbGGoFcwYkwAI+hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701720444; x=1701806844; bh=9anVqRMnfV6B5EoLFHEo7lDtKN9nMWpzmp4
        bifNE4cs=; b=t+RWieXOS3fZHa+VhyXHDHf0FwTX1sBzS+EpcgwxTAdgNDNXlwC
        Kkk+2OP+dLwoMq0pQriVtJx6xRn7Q+MuLbZqdR18lFAbzbdbXJfzs0CvB1rDgYEg
        l3ZLw2g3mz+RIdEzdV+5Hx53EHr1M+gxDUZbKYP5VBTvKJYLFNL4rBiiuDUnE6dS
        CUdq/+IrbqPxDpCd7gGOHnInvynr1VyEM1kyB90lGGw/EEd2rLYeU+IGnug7GMK1
        8/myhDo4KT71+HpqM22B95f8Tg8sUd2igxtb3vGRB/0EKtBsTU5hXqIcQL4uBiYW
        BlNBhLNmdji3snpdkBBhvrS3us0xBJxv16A==
X-ME-Sender: <xms:fDFuZbTqynIHJw6IQw-rukNqqG2i0k8LD3Asgu1CtLE6UK6ZzfwVZA>
    <xme:fDFuZczCKe0zN2Vd-ivgIluOxUrXfaQZ2ShNyShEtSCojr62nQC7qrAGJLWKUfNa1
    qsEFmQKFwvtUehLIcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fDFuZQ2RO_NW3yJSg4dqmf7__DVni-6v07SkCgs3IvzvaVJSYosTZg>
    <xmx:fDFuZbDcjVfYzLd6tO0HvymPNEFkZfcfAbQCjWQWoZp0M5RAmFmv-Q>
    <xmx:fDFuZUjbMApqkLE0-nDKL9pfd7xvXrwyJclekPPfHt8t6MGILJd9iQ>
    <xmx:fDFuZXOJk3P4zGFDvSuaKnBtaTKyNx2I7TdJhwu88yL3CGv_p4fmmA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1A82B60089; Mon,  4 Dec 2023 15:07:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <820dd18d-21a9-4c0d-ad92-021dc9b782b4@app.fastmail.com>
In-Reply-To: <8f5f9a4b-f809-44cb-8f26-05e39b29dfb6@wanadoo.fr>
References: <20231204085735.4112882-1-arnd@kernel.org>
 <8f5f9a4b-f809-44cb-8f26-05e39b29dfb6@wanadoo.fr>
Date:   Mon, 04 Dec 2023 21:06:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Yisen Zhuang" <yisen.zhuang@huawei.com>,
        "Salil Mehta" <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
Cc:     "Jijie Shao" <shaojijie@huawei.com>,
        "Hao Chen" <chenhao418@huawei.com>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023, at 19:54, Christophe JAILLET wrote:
> Le 04/12/2023 =C3=A0 09:57, Arnd Bergmann a =C3=A9crit=C2=A0:
>>=20
>> Use dynamic allocation for the largest stack object instead. It
>> would be nice to rewrite this file to completely avoid the extra
>> buffer and just use the one that was already allocated by debugfs,
>> but that is a much larger change.
>>=20
> could :
>     pos +=3D scnprintf(buf + pos, len - pos, "%s", <something>);
> be more widely used to avoid the alloc()/free() + copy of strings?

Yes, I think that would help, but this is beyond what I trust
myself to do blindly.

     Arnd
