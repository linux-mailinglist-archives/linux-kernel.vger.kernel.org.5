Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF07DFBA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjKBUo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:44:57 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FEF184;
        Thu,  2 Nov 2023 13:44:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 773813200960;
        Thu,  2 Nov 2023 16:44:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 02 Nov 2023 16:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698957889; x=1699044289; bh=Xy
        ycHQGm8Ach4EeAq+P26zFx4Ln6IaVWO2c9NZBcYRY=; b=rvAXTBjhdU0m58NjHJ
        U6gwyWJCxDxpmw1lOfbIKAoGy5DDWwg7V7ecnPardZMIcFwq1L6pt9LmRDFTxO5N
        IP15LRgOcS5+zoUQAe00C3oTF6yM9JAL+JaY+0ybGTdHb+wJUm6UdeI+HCVADtOI
        QW/xFkqJo7TJx4jYgEGlgLK9VYWQz5RjXBfeyz+Pv9RO3MZjvhKBEG6vjF8vZmHu
        Fy8SwaFRjKcPg/qfrBKPwRftAv09mYzpAikJ6S8nw+bNKfAv2qLBSXL6+j8MZ++w
        kcP7j2vc05WlIcxVkFx7b4R2t3IF9G95A6ZKkJbRm56WOv9OS5gQUxlsRnpIveUB
        7vTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698957889; x=1699044289; bh=XyycHQGm8Ach4
        EeAq+P26zFx4Ln6IaVWO2c9NZBcYRY=; b=EPf4RoNFbPerLrUsQ0ziFzgWBD9ej
        ETW2jQt+mwMWTQ7SjUR+NJj3cOv41qFp+mRaYqs1YF0knrxFJuQd+ZdmZYUHXVNX
        zDt1+rjGfTxkFqiyuDsXzuxaHqAtqBLxzpa7pec82j0rkpoFoRjEXaH4Xm0ghph+
        sD05AHDy6tJcjHaic/X77MBxaFZBZOZMNreYNbVOL46RZybHOFd7rxMCDpDTNKks
        3tCwAcNEYuqg6TjYoWX/+pSF8V9q7iAotNUMVTTxbsqhuapOMiIYeya6XSoYWSPd
        Idh1wHZz9+Dj86IVMXljCuzCX1l4KFJFcPiXNbWdKcsfDo1znc1qo5bAg==
X-ME-Sender: <xms:PgpEZQ9FuFqoZrhBPGQr8vehDcU_MEpxVkyUt9t4Ei0F3Y88mH9A-Q>
    <xme:PgpEZYv9SiJXJ3lbkr8Zj2h3_GMkUi3A2uImCPvA_KmM_Getlw-w-K32EtuHU4j8j
    d8pDYTLzRKDaK0idkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PgpEZWAuPTeXJ2bHRqiB7wkXgC-w1zuW2X8yaPX749rP_cxLXcRLAA>
    <xmx:PgpEZQdrGsJvgChd1n4Ib2l1hUau3QdY3Tvam7kN1HIRtieJQU4_hw>
    <xmx:PgpEZVOgH1qx5qpFw-MSQQKqZkZFzE_oYP5eLL6br6a7m7psonkQUQ>
    <xmx:QQpEZalAFkT1r6QEX3XWGdEo67G6arGBUQK7W5-IfDg4JmwEpJDDeA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6048EB6008D; Thu,  2 Nov 2023 16:44:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <d554f8f6-6e2d-471a-b266-3775c349276a@app.fastmail.com>
In-Reply-To: <2023110207-payphone-unlit-8590@gregkh>
References: <20231011213522.51781-1-graf@amazon.com>
 <6b836c66-dbbf-417f-8fbe-dfd67f464a64@amazon.com>
 <2023110207-payphone-unlit-8590@gregkh>
Date:   Thu, 02 Nov 2023 21:44:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alexander Graf" <graf@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Olivia Mackall" <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        "Erdem Meydanlli" <meydanli@amazon.nl>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023, at 12:29, Greg Kroah-Hartman wrote:
> On Thu, Nov 02, 2023 at 10:54:34AM +0100, Alexander Graf wrote:
>> On 11.10.23 23:35, Alexander Graf wrote:
>> > When running Linux inside a Nitro Enclave, the hypervisor provides a
>> > special virtio device called "Nitro Security Module" (NSM). This device
>> > has 3 main functions:
>> > 
>> >    1) Provide attestation reports
>> >    2) Modify PCR state
>> >    3) Provide entropy
>> > 
>> > This patch adds a driver for NSM that exposes a /dev/nsm device node which
>> > user space can issue an ioctl on this device with raw NSM CBOR formatted
>> > commands to request attestation documents, influence PCR states, read
>> > entropy and enumerate status of the device. In addition, the driver
>> > implements a hwrng backend.
>> > 
>> > Originally-by: Petre Eftime <petre.eftime@gmail.com>
>> > Signed-off-by: Alexander Graf <graf@amazon.com>
>> 
>> 
>> Ping for inclusion? I haven't seen any further comments on v7 of this patch,
>> so I'd assume it's good to go? :)
>
> Ah, I thought there would be a new version for some reason, sorry about
> that.  I'll review it after -rc1 is out, in the middle of the merge
> window right now, I can't add anything to my trees, but new drivers can
> always be added after that.

FWIW, all my comments have been addressed in this version. I'm not
exactly happy with the design, but none of the alternatives we looked
at were better, so I guess merging this version is better than having
it maintained out of tree.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
