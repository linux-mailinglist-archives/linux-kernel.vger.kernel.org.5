Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D76770FEE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjHENa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHENa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:30:26 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557AA1FE3;
        Sat,  5 Aug 2023 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691242223;
        bh=98rfeMPMGKOT7p9pXais0jMvQjSP6guO+kflRMuc840=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dcezqWo9mTkqSCwHjO3N1vDSbGvoZaGmlJmBbJ6/gCunym2MMea3dHzAe83THLoeU
         WYr75KYPicgDjfpzNok1iyrKIhokXenW6FUcMQn0W2V6wa/uQYWTAHiWARtDjEgt5J
         MAcAGgdaDc02Nhw1/JNpV/A95h2xxHwWeQTxu5d4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D7C291281B2B;
        Sat,  5 Aug 2023 09:30:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Ltna7M8JNLWK; Sat,  5 Aug 2023 09:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691242223;
        bh=98rfeMPMGKOT7p9pXais0jMvQjSP6guO+kflRMuc840=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=dcezqWo9mTkqSCwHjO3N1vDSbGvoZaGmlJmBbJ6/gCunym2MMea3dHzAe83THLoeU
         WYr75KYPicgDjfpzNok1iyrKIhokXenW6FUcMQn0W2V6wa/uQYWTAHiWARtDjEgt5J
         MAcAGgdaDc02Nhw1/JNpV/A95h2xxHwWeQTxu5d4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 646A31281B1F;
        Sat,  5 Aug 2023 09:30:22 -0400 (EDT)
Message-ID: <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>, dhowells@redhat.com
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 05 Aug 2023 09:30:21 -0400
In-Reply-To: <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 19:37 -0700, Dan Williams wrote:
> James Bottomley wrote:
> [..]
> > > This report interface on the other hand just needs a single ABI
> > > to retrieve all these vendor formats (until industry
> > > standardization steps in) and it needs to be flexible (within
> > > reason) for all the TSM-specific options to be conveyed. I do not
> > > trust my ioctl ABI minefield avoidance skills to get that right.
> > > Key blob instantiation feels up to the task.
> > 
> > To repeat: there's nothing keylike about it.
> 
> From that perspective there's nothing keylike about user-keys either.

Whataboutism may be popular in politics at the moment, but it shouldn't
be a justification for API abuse: Just because you might be able to
argue something else is an abuse of an API doesn't give you the right
to abuse it further.

> Those are just blobs that userspace gets to define how they are used
> and the keyring is just a transport. I also think that this interface
> *is* key-like in that it is used in the flow of requesting other key
> material. The ability to set policy on who can request and
> instantiate these pre-requisite reports can be controlled by request-
> key policy.

I thought we agreed back here:

https://lore.kernel.org/linux-coco/64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch/

That it ended up as "just a transport interface".  Has something
changed that?

[...]
> > Sneaking it in as a one-off is the wrong way to proceed
> > on something like this.
> 
> Where is the sneaking in cc'ing all the relevant maintainers of the
> keyring subsystem and their mailing list? Yes, please add others to
> the cc. 

I was thinking more using the term pubkey in the text about something
that is more like a nonce:

https://lore.kernel.org/linux-coco/169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com/

That looked to me designed to convince the casual observer that keys
were involved.

> The question for me at this point is whether a new:
> 
>         /dev/tsmX
> 
> ...ABI is worth inventing, or if a key-type is sufficient. To Peter's
> concern, this key-type imposes no restrictions over what sevguest
> already allows. New options are easy to add to the key instantiation
> interface and I expect different vendors are likely to develop
> workalike functionality to keep option proliferation to a minimum.
> Unlike ioctl() there does not need to be as careful planning about
> the binary format of the input payload for per vendor options. Just
> add more tokens to the instantiation command-line.

I still think this is pretty much an arbitrary transport interface. 
The question of how frequently it is used and how transactional it has
to be depend on the use cases (which I think would bear further
examination).  What you mostly want to do is create a transaction by
adding parameters individually, kick it off and then read a set of
results back.  Because the format of the inputs and outputs is highly
specific to the architecture, the kernel shouldn't really be doing any
inspection or modification.  For low volume single threaded use, this
can easily be done by sysfs.  For high volume multi-threaded use,
something like configfs or a generic keyctl like object transport
interface would be more appropriate.  However, if you think the latter,
it should still be proposed as a new generic kernel to userspace
transactional transport mechanism.


James

