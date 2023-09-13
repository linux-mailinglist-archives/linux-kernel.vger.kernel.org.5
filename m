Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88679EB56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjIMOnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:43:12 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694F09E;
        Wed, 13 Sep 2023 07:43:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2ADF33200124;
        Wed, 13 Sep 2023 10:43:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 10:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694616184; x=1694702584; bh=I6
        KW7EN8WvVpcxWfprs/LJK5tndoIFl6DB/6pYFRPh0=; b=IsVydtLgKseG3i3ML8
        4b/WocveJKvs59G51DXEWtVbu7hHrUwVUyOEyVRtn/2UyVUVUNi2dT/E4U9cODza
        xkMIkOP1ZdPlWVLcFwIDXTVz7OGV5cwhEZM6v6fI4BnNrcKBZYNoJbQ0ChDyoTds
        4I2+JjcJIUKsjGzIOkfs6lzsdVIzsBswI7jGtDxs+YF70JHZX1kLtwUmQBVPWRLg
        HgipqwZTqTGY6p/YNlnCK1n60vjv5HV1XEb7xMKCBwQMMde5HWB1/96xrS5D+lph
        +fgykQNo3DCHkbwEH58sgXUOPoErO2Hlz/QNMaePc9eT5MRUch6DD9rmPHHTsOj8
        L1dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694616184; x=1694702584; bh=I6KW7EN8WvVpc
        xWfprs/LJK5tndoIFl6DB/6pYFRPh0=; b=Vf0KujZYCawZbS+XrCdJUmeTAc7Gg
        7ywQukNuFVgldRRrsbK9lrfuSoTVoi2WNPbE/BwDJmW+TGeexiSFAvFKOZn/3LOH
        Tuit06RIOD5rVZzLQPHjL1l0DGQAgEloIr4lxLtcqeKM5YJnoZwnN3ZXabUK3gxY
        VfE0zyKOymr9uOLxyMC/2UW2CL8cix20TLNr+7mSRfGXhK5Ko9parr5aQPVUaoG9
        Of9CrdX75lqC8nga6LGXod8KEJUWQuqrQh6Y6OEagZwVrzt39kwfbd3uxTLQtxkh
        flalktSwldhtrREIM0ri5vCtee5zcKMV7sfFCnanBQdI1iN0cq58x7PWg==
X-ME-Sender: <xms:eMoBZd81D9U4PG1S6KuDuT32xq8PMoyJimrSqgXEuJxyKo33trJHnw>
    <xme:eMoBZRtmarVCRCNVbulJfPtXuR0a-PoWjyiCAAw26Cy1H0jz97FBjIfBUOfsA0foP
    RPV5_IU1_XMnSqh3b8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepfeeftdevveeihfetieduieeg
    teeftedttedtheefgfektdffueeujefftefhleeunecuffhomhgrihhnpehurghpihdqgh
    hrohhuphdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:eMoBZbATTlioymGAWf1Fl-90l4ZJkWDsZPLfWpKGbJ_7U-Jum5-YOg>
    <xmx:eMoBZRfuEcqcQxhFdajq8p0L8Nq_4oMSJ1DzLd323HZDTrN2O6ZoSg>
    <xmx:eMoBZSPOAtE83vmeOskNNhRUI1tEMouXukMkSNCDAfEPlobsQo6WJw>
    <xmx:eMoBZTEvlS-KDl4IqW3rE7EEl36sT1jSoPoxFPqonA_xDPlq8tIeJA>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3428D15A0091; Wed, 13 Sep 2023 10:43:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
In-Reply-To: <20230913160045.40d377f9@rotkaeppchen>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen>
Date:   Wed, 13 Sep 2023 16:42:33 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Philipp Rudo" <prudo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>,
        lennart@poettering.net
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 13, 2023, at 4:00 PM, Philipp Rudo wrote:
> Hi Jan,
>
> All in all the code looks fine to me. Nevertheless I don't think UKI
> support should be added at the moment. This is because IMHO you
> basically reinterpret the kexec_file systemcall and thus add a new
> uapi to the kernel. Once introduced it is extremely hard to remove or
> change an uapi again. The problem I see is that the spec you based
> your work on is in such a poor shape that I don't feel comfortable to
> add any new uapi based on it.
>
> For example there are two definitions for the UKI which contradict
> each other. The dedicated one [1] you have cited earlier and the one
> in the BLS for type #2 entries [2]. In [1] the .linux and .initrd
> sections are mandatory and the .osrel and .cmdline sections are
> optional while in [2] it is the other way round. Which definition
> should the kernel follow?
>
> Furthermore, I absolutely don't understand how the spec should be
> read. All the spec does is defining some file formats. There is no
> word about which component in the boot chain is supposed to handle
> them and what exactly this component is supposed to do with it. But
> that is crucial if we want to add UKI support for kexec as the kexec
> systemcall will replace the stub. So we need to know what tasks the
> stub is supposed to perform. Currently this is only some
> implementation detail of the systemd-stub [3] that can change any
> moment and I strongly oppose to base any uapi on it.
>



I think I have to agree with you on this one.

I kinda experienced this first hand. My initial patch required a kernel
command line, because the spec in [1] didn't say it was optional. Then
I got a response saying that it's actually optional. And the spec got
changed in PR [2] (I have a WIP v3 that allows a manual cmdline if the
.cmdline section is empty as explained by Lennart in [2] and now
also in the spec since [3]). So there's already 2 changes in the spec
in the last few days related to my patch. That shows that the spec is
not stable.

What's even worse IMO is that the reason given in [2] to change the spec
is simply that systemd-stub has a different behavior than the spec and
therefore the spec should be updated. At this point it's not really a
specification but simply a flawed documentation of the behavior of systemd-
stub / ukify.

I also discovered that ukify treats the initrd as optional [4]. So is
this the next change in the spec?

In [5] Luca writes:
> [...] we fully intend for the UKI format to be an open and stable
> specification, that anybody can support and rely on.
But that is unfortunately not where the format is at this point.

What is annoying though is where this leaves a user that actually
wants this feature. They can carry a patch or they might have to wait
a long time.

Can you indicate what it would take for the kernel community to consider
this spec as stable enough?


> In the end the only benefit this series brings is to extend the
> signature checking on the whole UKI except of just the kernel image.
> Everything else can also be done in user space. Compared to the
> problems described above this is a very small gain for me.

Correct. That is the benefit of pulling the UKI apart in the
kernel. However having to sign the kernel inside the UKI defeats
the whole point.


[1] https://uapi-group.org/specifications/specs/unified_kernel_image/
[2] https://github.com/uapi-group/specifications/pull/72
[3] https://github.com/uapi-group/specifications/pull/73
[4] https://github.com/uapi-group/specifications/issues/74
[5] https://github.com/systemd/systemd/issues/28538
