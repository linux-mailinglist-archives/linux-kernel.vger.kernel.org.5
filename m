Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909837657D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjG0PiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjG0PiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:38:04 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC61FFC;
        Thu, 27 Jul 2023 08:38:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 19C5B5C0167;
        Thu, 27 Jul 2023 11:38:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 11:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1690472283; x=
        1690558683; bh=gSa2UE+tG+6ppJSX7+/fH6rMPkCm1rn2JSAsjLzC194=; b=e
        wEh34iZWiAQ2T7UejitYODzQ5DWGyK+gPKwM6HTiqIJrTLWUtxT0jc0GqJ++6fTE
        117LEiBg5HA+GUebwrfjkhEiSEf49KWLF2y1a/PvUApW8y8fFV5vesb2jpqTXXGA
        y6e84vNkq5E7pojrfdI+1igrbc0yZa1NcTRU888wK3Bc8qArxeXAEBkWXtU8BvoD
        gfg0iHXCcWBzVFg03w9TVmuSxaS5JBTLiMTkVbPLqw+5KF7oDIYb/HkhXcIBBisO
        2nWX8lfIGuORPyUh9lY7PDozRScNjZZOLWVMN3YA7bcfZVzYZt+u73/Kq73oVoxU
        rF9wyy0MkRHoEVrTECmlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690472283; x=1690558683; bh=gSa2UE+tG+6pp
        JSX7+/fH6rMPkCm1rn2JSAsjLzC194=; b=YcPsXyNfVHw4nWK00SBx/jXr5Syt9
        5TrA+JDktsPKJSCuCHzHpr0uMNUQIdXfLyWnNjF/v/1t4GRXtlfLidmSa+SiuSBU
        12TE4NH3+lxiDrLnsDJFfbMn5sDJbFC22GzXgoKNk8NU3b7UemokiUFZRDcLaBhO
        jdMNwom+RrkQXmC1XpuVasC8h7jriKhMprjj+BcrmQrr3c6w+bVAS/A5p7N0JJg/
        iD63K0a2TAkATR2nYjl0qRGf+LNk8cF1kBh+TSsxwoOzws6QOIllE3VnGPs/3EJA
        2tRVYJXQNXtHrGaSjvtYWY1I8+xzLAKEVi049InIbmXKksDTtTs6kLQmA==
X-ME-Sender: <xms:Wo_CZBdIYgyEQ2KzyGQhtkh0VG4aBUagzW2NowXOGY7y73Mu_N6reA>
    <xme:Wo_CZPN3x0EZ1Dc2jtb4MX0Q1JQSeMtclQDq_fZ96C9CIzx9hwupai0-PAsEWy3uf
    7J5ynCqjT09RDyS1ow>
X-ME-Received: <xmr:Wo_CZKi8Fn1iCD476yRFLdjIyT2I1vp2eh9fsjPF7EQCyQVycWo1uXRzw7Ydh8faDa6fzQV_SrsUvwkJNo-msQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpeffrghvihgu
    ucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrth
    htvghrnhepvefhleffvedtfeduuddviefhheetvedugeeludfhgfevveetgeffkeetvedu
    uedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtgho
    mh
X-ME-Proxy: <xmx:Wo_CZK-v8I8UBdL20bSVclL8S8AXVIb8J2Mxm3xSLNb-stFIRWyMog>
    <xmx:Wo_CZNvL6XpQL9Xawl-BpZI5oC0tGskBIuxMMeQWERL64ROj3TqW8Q>
    <xmx:Wo_CZJEqfbveEI_mo1SB6R1MIys5ffykPuuetq9l3DBRamedAwrgEw>
    <xmx:W4_CZHILZUeDs9Nk4GlpGc8HPZrwJM0Sm5cy953T8SA3XASlAS_Jgg>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 11:38:01 -0400 (EDT)
References: <20230727152234.86923-1-me@davidreaver.com>
 <87o7jx5q4d.fsf@meer.lwn.net>
User-agent: mu4e 1.10.4; emacs 28.2
From:   David Reaver <me@davidreaver.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-bus-nvdimm: fix unexpected indentation
 error
Date:   Thu, 27 Jul 2023 08:36:46 -0700
In-reply-to: <87o7jx5q4d.fsf@meer.lwn.net>
Message-ID: <86mszhjrfr.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Corbet <corbet@lwn.net> writes:

>
> Thanks for the patch.  This problem is already fixed in docs-next,
> though, and thus in linux-next as well.
>
> jon

Ah, sorry Jonathan. I was using Linus' tree, and I must have messed up
the search query I used against https://lore.kernel.org. I'll try to
remember to use docs-next for future docs patches.

Thanks,
David
