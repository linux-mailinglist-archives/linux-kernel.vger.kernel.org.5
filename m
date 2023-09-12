Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287F79DA43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbjILUuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjILUt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:49:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D4199;
        Tue, 12 Sep 2023 13:49:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 382963200954;
        Tue, 12 Sep 2023 16:49:52 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 16:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694551791; x=1694638191; bh=Dv
        Cb/EIqO1JW+sf1gb8MGaN948NTLFayPCF4KFvH4ug=; b=Zpx+QAadIrfUHY6wVf
        Vbrmm+MyjRvASW54gJcsA4hetbwWutRn6RWvOYtQRSUNwQ43lX7KZmZAqH37v2Ec
        s9cTHkc9DXu8CBHnwdP396U9JG+pttZBPKdInHKslhwJnr8tMfMTKmCwJnSJY7Bq
        6LpzGVeui1dwYFi1JOhlK8d9dRo0ck//FXc+Z6hePBH5+bN8gwOYE50vc4vrGhJi
        TpBxq1kGFNl+YGqr1CiNtQggBUoTtwtbhFm+z7Agq+lM0kdkYY6RPm+J6I3N6Y9D
        2WzVnlY1MA/rtnsrmy+2Bd7/gym1Wedx7PMbovMb2+HEJ253s1OnOhZbx930niVC
        /IeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694551791; x=1694638191; bh=DvCb/EIqO1JW+
        sf1gb8MGaN948NTLFayPCF4KFvH4ug=; b=af0d3cR5qR8XnTHMukkyjpBqXXsT6
        B4OevtfhK74VrrdbQ+hVH0NoHRr6btQDyyHYeiejpjGmlIsVSG04GJhedLAEjjB/
        1wGuDYJ7Jnd3rCYIdloAfKMrveOVZOwbcKKYLfj16ULAXvNdMOLv66RsyjWSVWYL
        uphPRk3H3eBgog+jAT8CPs712Tm8s9SnxUsjjNxamggWQB262Hwh0YAh0a3cmwO+
        YGckqd1tPnOj7GNDY/VH/MWnfsRRkok501kKVYLu3KwVMtlI/vsNUYvlk+chzxJa
        mWutR1tSkb/x+6yAX68wP4KeGpCKbk39bvgCZPwbjbrtwlw5lE/0pW1fQ==
X-ME-Sender: <xms:7s4AZUIIgzxTfkP56niPL64dW72pnyqCkFl3_LeeAoz89hzAzUnm3Q>
    <xme:7s4AZULsA54M3zA-gh3GPX1ubmtfYzfRhlDSSNqa_V8-oAR1koUybcnnMW8OF-rPX
    4EXMK8KsAso3E2Jpyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffffeufefhiedvfeehgeev
    ffffffduvdduhfefjeekgeeviefhuddvgeekvddvhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:784AZUs8J84shFswdgIaQytbAaAMsI1MsHcSnJYEZBOwS7rkv-N7xw>
    <xmx:784AZRZ65-owIok0-iFbhw14Ca6bXCaevSyXoxC6QfukkSzWpbIz7A>
    <xmx:784AZbaDyti8-a4W676AmJSQSGG1-Tr7uAkq0CZrIdZeY54_hRQs5g>
    <xmx:784AZYRvUR9LOJCU7v--icna8kQXS0CyPwWJuLIu8Mv8RKXkNm77dg>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DFC7A15A0091; Tue, 12 Sep 2023 16:49:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <1c342231-7672-450e-b945-e57cd17b4ae7@app.fastmail.com>
In-Reply-To: <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
Date:   Tue, 12 Sep 2023 22:49:00 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, lennart@poettering.net,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> These are sort of "tautological" arguments. There must be some
> objective reasons why this architecture was chosen instead of
> other (i.e. using what already pre-exists).

I think I misunderstood you in my earlier reply. I do not understand in what way you think my arguments are tautological. Can you elaborate?
