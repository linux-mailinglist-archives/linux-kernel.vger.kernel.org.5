Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83481808C19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443524AbjLGPnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjLGPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:43:24 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673810CA;
        Thu,  7 Dec 2023 07:43:29 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E103B5C010F;
        Thu,  7 Dec 2023 10:43:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 10:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1701963806; x=1702050206; bh=kK
        DmIidL/tnOKURnMGeoV9D0OqdgpEUnz7ab3Y6ER9I=; b=enYVfsBH/ajHQbRk+Y
        748qP1SgSEffOJ5hAXxyjXL79fyI6TSkDBSLYrNCmcVCq9v5FqtoqXQwOw5lasHn
        FdjfPgvi7JpLTfg/u5bs72AFRKuCXSYkzrte+625THB8YGyrU0JihPN0miNheqoS
        D0NH44LxD7N/1sobNw0Aqy1s6ZHn/UN0gbmPjh9mm7d5+vbrOSLLAiLUK0S0P4rf
        34jHD8JOJaD+kmA/JtJS8HNws3R7fKWcZFWhqXHa5i0qhZKDLXx+5RDFDb7aZd6p
        SE7Vks6G0laiS/g2n6jj4Eq+j3nwhVdbsv3hWpdK6tutO7HMCyl1A6bJi8zSJbIV
        rYFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701963806; x=1702050206; bh=kKDmIidL/tnOK
        URnMGeoV9D0OqdgpEUnz7ab3Y6ER9I=; b=h3uVDoUlmP2wNbOIFulx31xrQpwen
        CLulfcqV4LLs/ZfG09NAuLrxZ20DgU994sXssFbwQFZNC/gutGZcX4WrybKiHidS
        npwYhQNy0OBZ7+XdwKQh+l37P9khQTd03fIAZgpnBU9YnkzQ7my3EiMVcs/UckaZ
        zfibqKZf3DUibCygSZs3dSQmqWfZowxwFWsakCyLAUwzQ5KaAebIO9ZsDMafwrDx
        aoI+Q3fr1PTB3EkNdddVmXIk7K2I7r2gVEPZImHXO3Cetg68FaozmclIfX+VFBy4
        vndBJwldaNRMEz1o/rDNBtt4Ojs6bmGByaTe+V15v5B8pYnx/V9404ysw==
X-ME-Sender: <xms:HehxZb_sVJKfMOi-TOCCliivGArYyFUiAi4OikunjBFY2XA533Ttww>
    <xme:HehxZXuD5sQrFmqOk3MNNFpe_iBolaRKZTR_s1J1y39BkcHW169nBBTCj_TFtfOOF
    Z7lEUYAavdWw9btxg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekfedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:HehxZZDVCsfJHl7SWb2tWqfN4fnvF_cYhchcV-yEKUrTek6rvae8vw>
    <xmx:HehxZXe6H4HYcWipiHFiyu5MkT4X8hi7JEQWMIDeATsek8hWPe9b0w>
    <xmx:HehxZQMTAdC7N3ay6MM5zx2arvJqA5tF_g7XDNg7hIrJ2K7AnAvQxw>
    <xmx:HuhxZVbRI5aLXterkz05RtnzKhaqqQO4vR0zgOZZCHyznO2QOKYvWA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BDB4B60089; Thu,  7 Dec 2023 10:43:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <cddbf290-021a-49d5-8729-e98cb099ff67@app.fastmail.com>
In-Reply-To: <ZXHdhVeel1dOxlYJ@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
 <20231207002759.51418-8-gregory.price@memverge.com>
 <67fab0f1-e326-4ad8-9def-4d2bd5489b33@app.fastmail.com>
 <ZXHdhVeel1dOxlYJ@memverge.com>
Date:   Thu, 07 Dec 2023 16:43:03 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gregory.price@memverge.com>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        jgroves@micron.com, ravis.opensrc@micron.com,
        sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Michal Hocko" <mhocko@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        ying.huang@intel.com, "Jonathan Corbet" <corbet@lwn.net>,
        rakie.kim@sk.com, hyeongtak.ji@sk.com, honggyu.kim@sk.com,
        vtavarespetr@micron.com, "Peter Zijlstra" <peterz@infradead.org>,
        "Frank van der Linden" <fvdl@google.com>
Subject: Re: [RFC PATCH 07/11] mm/mempolicy: add userland mempolicy arg structure
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023, at 15:58, Gregory Price wrote:
> On Thu, Dec 07, 2023 at 08:13:22AM +0100, Arnd Bergmann wrote:
>> On Thu, Dec 7, 2023, at 01:27, Gregory Price wrote:
>> 
>> Aside from this, you should avoid holes in the data structure.
>> On 64-bit architectures, the layout above has holes after
>> policy_node and after addr_node.
>> 
>>       Arnd
>
> doh, clearly i didn't stop to think about alignment. Good eye.
> I'll redo this with __u/s members and fix the holes.
>
> Didn't stop to think about compat pointers.  I don't think the
> u64_to_user_ptr pattern is offensive, so i'll make that change.
> At least I don't see what the other options are beyond compat.

Ok, sounds good.

I see you already call wrappers for compat mode to convert
iovec and nodemask layouts for the indirect pointers, and they
look correct. If you wanted to do handle the compat syscalls
using the same entry point, you could add the same kind of
helper to copy the mempolicy args from user space with an
optional conversion, but not having to do this is clearly
easier.

     Arnd
