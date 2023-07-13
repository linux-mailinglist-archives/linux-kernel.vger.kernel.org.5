Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA17527BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjGMPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGMPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D291BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689263523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X4bUvPPJK1envGxsQhoTn5XMWB1el/UFbBhqAYuNPTY=;
        b=ExabAIBwo/q6DM/jEyVmM7CHKDbaVP1Cq+hnr04tugw3DQ073CK+sRuoaKzZgX1JfsnkdT
        pjaw1lkNsGB75IaFBFMLfQqHyyfVF7KmMZd/H+jm+mXeZ9LLkRPn+zsbqCCGUzG4uJ6vfv
        yzt+KIQIgaeX8BCVijq27D2EWUb0P8w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TTFDX21DPPiVcUCdKs9Oig-1; Thu, 13 Jul 2023 11:52:02 -0400
X-MC-Unique: TTFDX21DPPiVcUCdKs9Oig-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7677e58c1bfso111009285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263521; x=1691855521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4bUvPPJK1envGxsQhoTn5XMWB1el/UFbBhqAYuNPTY=;
        b=Slx/8jIAdI7cyotL2H02hTZjw0zaEon6tpetWtG3VKB0n12S5Lyi9UpiR7hlSROD0d
         eAUekV5OU+IvFbir2Bx/4sIIDZEJYhFfXT8vm49jDG/iqjapiwMP242EiT84UX3B7GVX
         n4fiC/T1n2em3m3PdMcLcVoAI3YHdCrdBM4ztQ2vxaT/AntKlweI84I6MLreStpePFWQ
         FWguaV+dle7Oq46Wah9R4smAfY0nFtqo5s5i0R2DPMH4AEWmMAdYepNm9drzM63YCWQl
         bkwHLbKQBhw6zMSInL/5bny+8T08ckmvVWFbJ915FwOSnhH95bebRkrwYggRCflklle8
         NYNw==
X-Gm-Message-State: ABy/qLZntEQqBVIgWuZ6JPTsSIqb57ZZjK8kildBZxvp5TfRB+aiMDpG
        ztIV3YNyDfasFAyyGExnQnvSeWey0jq1yPkENG8lbCq4gGa6GTLkpoelMhM5ubDGDqiMYiR7/L4
        Irl2ClR67F6m3teoNqWrjIw1kawoM74s3pSgFzjlZn6W2YYkp5zFuxdAvsJq8UQrJtC5gD81Ycr
        dW16PDs80X
X-Received: by 2002:a05:620a:3726:b0:765:36a5:9207 with SMTP id de38-20020a05620a372600b0076536a59207mr2450577qkb.0.1689263521578;
        Thu, 13 Jul 2023 08:52:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1HXhFgCXQQ9wQRzUZE3ydfzCrr6ytVJUc7kclm3tL5/PlERzChkfSUDI80J73Ux63lNDJNQ==
X-Received: by 2002:a05:620a:3726:b0:765:36a5:9207 with SMTP id de38-20020a05620a372600b0076536a59207mr2450551qkb.0.1689263521243;
        Thu, 13 Jul 2023 08:52:01 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a120e00b00767b24f68edsm3015790qkj.62.2023.07.13.08.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:52:00 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?Q?Daniel_P_=2E_Berrang?= =?utf-8?Q?=C3=A9?= 
        <berrange@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
In-Reply-To: <2023071329-persevere-pursuant-e631@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh> <875y6o429i.fsf@redhat.com>
 <2023071329-persevere-pursuant-e631@gregkh>
Date:   Thu, 13 Jul 2023 17:51:57 +0200
Message-ID: <87wmz33j36.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Jul 13, 2023 at 10:57:45AM +0200, Vitaly Kuznetsov wrote:
>> FWIW,
>> 
>> this was an RFC to answer a fairly straitforward question: is upstream
>> Linux interested in / is a suitable place for having SBAT revocation
>> mechanism or not.
>
> As Peter said, there was no questions in this patch, so how were we to
> know that this was something that you all were asking?
>
> Also, you need to provide lots of information in the changelog itself
> about whatever "SBAT" is, as that is not anything that anyone should be
> forced to look up (links go dead over time.)
>

Very valid point, "SBAT" is certainly not something very standard. The
RFC should've contained the description and a clear question with a
question mark at the end.

>> We can, of course, iron out the details whether it
>> should be "linux.org"/"linux.com"/"lore.kernel.org/lkml/" or
>> "linux.onion" and where to put objcopy call, whether to silence its
>> output or not but these are rather implemntation details.
>
> It's a sign that this change was not thought out at all, as the
> follow-up questions, and lack of answers, showed in detail.

...

>
>> I don't
>> particularly see why anyone would need to get additional sign-offs to
>> just ask a question (which I don actually think was asked before!) and
>> IMO an RFC/patch is usually the best way to do so.
>
> Again, no questions were asked.
>
> And when I asked questions, no one knowledgable answered them (hint, we
> release more than 3 kernels a year...)
>

I think that getting these questions was actually the main reason to
send out the RFC. (Personally, I don't think that stable@ is an
insurmountable problem with an epoch-based revocation mechamism as we
can e.g. switch module name from "linux" to e.g. "linux-stable-5.14"
when screating a stable branch or do something like that but that's not
the main/only problem we see here).

>> Following the discussion, it seems that at least x86 maintainer[s] are
>> opposed to the very idea of having SBAT revocation mechanism integrated
>> upstream because it's hard to meaningfully define what epoch is.
>
> You all did not even consider how this might work with our existing
> release process OR how we handle security fixes today.  In fact, you
> totally ignored it, and didn't even do some basic research into our past
> history to see how this new feature would actually work had it been
> present 10 years ago.
>
> You need to convince us "of course we would be foolish to not accept
> this patch because you properly researched it, documented it, and tied
> it all into our existing release and security and other policies and
> proceedures".  But none of that happened here, so we would be foolish to
> ACCEPT this patch, right?
>
> Turn it around, what would you do if you got this patch in your inbox to
> review and you were responsible for doing kernel releases and security
> fixes?
>

I replied to the thread not to defend the idea as after the discussion
it is clear there's a lot to take into consideration if anyone decides
to pursue the SBAT idea ever again (and the discussion is now well
preserved in the archive!). I replied to disagree with "get sign-offs
from senior people before sending RFCs" idea, I believe that asking
questions by sending a not-fully-ready patch as "RFC" should not be
discouraged. 

>> This is
>> OK (which doesn't mean we all agree to that) but as there's real need to
>> revoke "bad" (in UEFI SecureBoot sense) kernels, distros will likely
>> come up with their custom, downstream only ways to do it. Without an
>> upstream reference, however, they may come up with very differently
>> looking SBAT sections, this may or may not be problematic in the future,
>> who knows.
>
> You all haven't even properly defined what "bad" means!  Or who would
> determine it!  Or how it would work with our decades-old release process
> that has evolved over time.  Or how it would tie into our existing
> security fixing policies and processes.
>
> In fact, it is a complete end-run around all of that, with only a "trust
> us, we will update the number when we want to" statement.  Also
> without even defining who "us" is.
>
> And if a security policy doesn't even define who is going to be
> determining the security policy at all, is it a security policy you want
> in Linux?

All these are very valid questions, of course, and in no way I'm trying
to say that they were answered in the RFC or in the following
discussion. The only thing I'm saying is that the upstream discussion
itself is valuable and should not be discouraged.

-- 
Vitaly

