Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8B7C5363
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbjJKMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjJKMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:15:13 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845565256;
        Wed, 11 Oct 2023 05:14:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8391932009F9;
        Wed, 11 Oct 2023 08:12:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 08:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697026378; x=1697112778; bh=RM
        gJN57kN3GhsZBL75M3QGGQOq+DMKk5oTpXvzw/avU=; b=VfCUeyfiXfj5EkKkhH
        AMqqLCLe2/A7V3TE8d1EVlU15ekS4/l8TYV2BceoWP4ffSt72NweGXPCim4G4BC0
        Ar8VJ+ZjCXjkeYqwVf7Dv6NUeaU3pGd/LLmZd58Z3cIeJZfNhqveMDcjt4yTBvLk
        ZqEC8sjT1MkcW/hy9ofqagRNewL4xZf1Fp4c3AmjPDg2Uxk/CcXzDFOuRHy9TN27
        4vLLHw0D+r/ab0Buehk50cablqiLLcAZopCVDE+C3cm2///A77Qcu1gEfRyJ4RwB
        dgmZtcHYJs8RGbxkj3UO9arjkxHE2i6Gr2yKN6q/i03PKo/+Vp4vTezkmPlVKWBk
        GquQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697026378; x=1697112778; bh=RMgJN57kN3Ghs
        ZBL75M3QGGQOq+DMKk5oTpXvzw/avU=; b=nzWM+L3JNCPexk2qqO8p6bv2qA90m
        xV63FwH6T/7kI3d7HKmQ2S6oKd/z9hT3oDkCJqxcCKR8C+aUstSTIRzKGk2Jr+Vd
        Bc5BzItXiLoxdmU4ghNvdKhVtSt40+uqwbdLI8QQ92XFnkym56cg7T+j+nfQphHP
        rDa8syLnpnTwa79/X20hWrutsAE1FLycDUAWG83LKcTyWnPwG9szdBFjaGcSGb1K
        pOPqwZBSsObRGPuqQibePPWxH414dFOoZOdAUEg9ANfvTdT3kGR7M3gPzczrRArO
        KAVje4Co0NGYXXQEURIK+/rOH2ZuDCS+p9eJzzCQy0ux411JKjml9zHuw==
X-ME-Sender: <xms:SJEmZdlxqhGkqQYayD1v4S4BnehdhZShScc_fwO1JJOAK7OUv8u96A>
    <xme:SJEmZY2L3REWvQMKMxd7XM09x0_4pmc-cOrWxWbLYZi40OUqGtWnB-uIUcvr1yn0H
    XrKVmFiYqv63xnydz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:SZEmZTpxEYpQK3aVjCurn2HV0LFNlE3bwL7D8hDC13Qc9ytogoP1QA>
    <xmx:SZEmZdm9gmf4cyAiwaLrDf9v_gLsZrQGisVPQPQAW0N2QYeeOgg7bA>
    <xmx:SZEmZb2Pi_cTh8jIj0VLK0y8cRG3NEY9wkGQdMHAv6WezlD0uIKIEg>
    <xmx:SpEmZUu5J6M3uPJOXqgJwAj2_dTmCDIcL-2COR4LOOWybd3Di2MwAw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1BF3B60089; Wed, 11 Oct 2023 08:12:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <939cf309-b7e4-461a-93e6-dd6212887d08@app.fastmail.com>
In-Reply-To: <fd43fb0d-5d52-423d-bb1d-bc10e64ea3ee@app.fastmail.com>
References: <20231010213420.93725-1-graf@amazon.com>
 <fd43fb0d-5d52-423d-bb1d-bc10e64ea3ee@app.fastmail.com>
Date:   Wed, 11 Oct 2023 14:12:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alexander Graf" <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v6] misc: Add Nitro Secure Module driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023, at 13:31, Arnd Bergmann wrote:

>> +/* Maximum length output data */
>> +struct nsm_data_resp {
>> +	__u32 len;
>> +	__u8  data[NSM_RESPONSE_MAX_SIZE];
>> +};
>
> You have endian-conversion for some of the data fields
> but not the 'len field here, I guess these should be
> __le32 instead of __u32, with the appropriate le32_to_cpu()
> and cpu_to_le32() conversion when passing the native
> u32 word from userspace.

Ignore this one, I misread how the length field is used, this
is obviously not fixed endian as it is only used for
communicating with the kernel's virtio code, not the device.

     Arnd
