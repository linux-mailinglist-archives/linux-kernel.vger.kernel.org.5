Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7276BE28
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHATyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:54:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDBEE67;
        Tue,  1 Aug 2023 12:54:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C520B5C0182;
        Tue,  1 Aug 2023 15:54:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 15:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690919667; x=1691006067; bh=2M
        n6OlH+kFijO/OSJ+b/5cNGvEQaHJDvRBONu3It1/A=; b=X7jfWhTFQxa5lSdG95
        SsWWLexeFFtQc95pZEWp6EAdfSTXI/gQXdthLOJUWvH+vZ8bf7EX+IcYCviT7+79
        pSNHWiMKQSaSdF7xUioTGQ2thWV4URCokLk5Linfp3fQooybJsFfB+g36IURnvPl
        iZPCphWffMNNqFKN/hd10P4Sjdfcu6QlMnIm0mvWKYOdqsy0oemNAdGAkhdD7Cvp
        BKXrZtdUWt7eGOPYJhDMeGJv0kYGl4t5DvprPlfaox0mYaP6f9z9EV5SmkHP20sE
        d7ZtUG2XMY7p2cbqN8sTVceDUDOsag+JboAN7FVQszRotWfkVoRFdAO3ZZqBINIc
        kabA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690919667; x=1691006067; bh=2Mn6OlH+kFijO
        /OSJ+b/5cNGvEQaHJDvRBONu3It1/A=; b=3OwLcOUZllw6Sbjm9UT2+gmZhibYm
        pprBGPfmlk/2cEPQNOjT5Q6ufnY3zsf7zBj+aCJvjbbEyL8pwHJUSX/581DphrYe
        e0bGfTvhKTJPyPuqtQm/Pk63BP9WjarjECFE4nw9D98ZMJyF3p3Kb3JvVOzhOQ9P
        +mqOWiL2gHZkdUcSaeiFvCa15yDfwmtTDYV5SjGilQ4+RI2SJOk7uYikV11WJ/Pi
        ASMNlbGCtFZzDj2yocLspiT/vHb+9rKZaF+WlMmQf+l99mf2+l6UZ7qYZ8Q3nafO
        URs/eYx7jxm2uOT3UO/sg4ILi5XxPBE3TAVfBwRcPj46g9JFDYxA7zPnw==
X-ME-Sender: <xms:82LJZLsgBRxlwfpe5Lm17zt_oCvzDJfPg2wJ5Q8enm-lEvX_hQV5cg>
    <xme:82LJZMcN8Sfw4jiY_V4VICjgZzpBED6Lv_SB4Su0YaLQ4VOrVqVfoMkd04MKA52iJ
    41YtC-iPutXthkGKwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:82LJZOz_19DDArDRPTUNXgYzbdh66qCb8FJcHZsim7fs-oNgq8x67A>
    <xmx:82LJZKNrWdZVimqPaEDCmk2-UmrVzT8vVun2AXXL1nlIEtBZ5gNr0Q>
    <xmx:82LJZL8KT2uS7LIM9azLPLTlxZF52kBPrdPwc_dHrcOAiX8gYIzWPA>
    <xmx:82LJZGl70duxBsuVAE_fN9UzKs_lRKGh-pbaTHVQ9pc0Bpk73K-vng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 607BCB60089; Tue,  1 Aug 2023 15:54:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <1f7e045a-5dc1-4667-b09d-bc74953e48b0@app.fastmail.com>
In-Reply-To: <67f2a68f-8462-e1de-c016-b84d7c6e3222@acm.org>
References: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
 <a660adba-b73b-1c02-f642-c287bb4c72fc@acm.org>
 <CA+G9fYsYifn9ywPc8KqYHwDDSTRQGOgf_T58Gpt9CYDBs8u+SQ@mail.gmail.com>
 <227327a3-399a-4a9f-a775-e9627656b5a1@app.fastmail.com>
 <67f2a68f-8462-e1de-c016-b84d7c6e3222@acm.org>
Date:   Tue, 01 Aug 2023 21:54:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bart Van Assche" <bvanassche@acm.org>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-next <linux-next@vger.kernel.org>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2:
 /builds/linux/include/linux/compiler_types.h:397:38: error: call to
 '__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
 failed:
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 19:51, Bart Van Assche wrote:
> On 8/1/23 07:56, Arnd Bergmann wrote:
>> On Tue, Aug 1, 2023, at 16:23, Naresh Kamboju wrote:
>
> If I change the return type of ufshcd_check_header_layout() from void
> into unsigned int and insert the following at the start of that function:
>
> return ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2] != 0x80;
>
> then the compiler shows the following in the output window:
>
> xorl    %eax, %eax
>
> In other words, the expression next to the return statement evaluates to zero
> but the same expression does not evaluate to zero in the BUILD_BUG_ON()
> statement. Does this perhaps indicate a compiler bug? And if so, what is the
> appropriate way to fix the build error? Insert an #ifdef/#endif pair inside
> ufshcd_check_header_layout() such that the compile-time checks do not happen
> for gcc version 9 or older?

I played around it some more, and this apparently comes
down to constant-folding in sub-byte bitfields, so in the
older compilers neither the ==0x80 nor the !=0x80 case
can be ruled out because of a missing optimization.
Instead the generated code would try to initialize the
variable at runtime and then do a conditional branch to
the assert, but that of course fails the build.

I'd suggest something like

    if (defined(GCC_VERSION) && GCC_VERSION < 100000)
            return;

before the assertion, in that case it doesn't evaluate it.

     Arnd
