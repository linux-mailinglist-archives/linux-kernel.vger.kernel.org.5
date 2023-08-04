Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF02770619
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjHDQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHDQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:34:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13746E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:34:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so91615e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691166853; x=1691771653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGi4XR/XiNGHXh0Do308MZzOF1T6uCKkf5XCj+VVIgM=;
        b=w4JbRCmCeXyYZbgatosbC1xc36AV6HL9HjJ9LrLcB3GUtjTl7t3im+4tPeU3Vx9uhc
         Ntdq49YvfpItVbRNaFCzV2Cx0YbVodMnw9ugoixhLuWeu+Kbh1DtE54tuG0vnzpe1vco
         nNtcsJtFVU4hMwoYtmsS2I+Czqw7AVRdl9va6b4Zc+tPaoHsXzbia4Plqa4qGdqrRfsV
         fXNGh7XcxB/RVPEkp9AOswAF4fEaVBIepuKT14H4TcI0vcgPwKpwIq2mlsw4FE0+YJv1
         G/AgkijT7KSOyChAD6kdCjf0MFb9Sc4P5Fzy+507qzqXBgTo3HE07Ib6kYqJyzNcuYj1
         q43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166853; x=1691771653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGi4XR/XiNGHXh0Do308MZzOF1T6uCKkf5XCj+VVIgM=;
        b=c4tUbe2oQKuFgKzuvYDuGXxLvWZG1G5JKOT4Ls0qhLsUb71ErZwUxwDkLXsd7As9UI
         QGlhjVQVGQGlKTWbRo6ZYxzixAODfv2K+rB8K4a/vwhnOujw2g8HcoHmqD5D6HtztGT/
         dCI1RJJ1d11S/dCK4E80hDquEUSlWDlbaRhEdwuOA7vh9yVglGw4Smq2cNL5FN4rSs1/
         Pb+ioLmqrrz4mAKOcesRUfJlb8Gs/hWSSRugAKl80AY2uq3E8v7JHMEXVKKAQnXRlWbo
         z6vSi64Qo/V/JVieXt8nx2t1ekggYG4XBegLQ1BsZOmlAIdyUKrIuGLZQMWyY3TA+OwQ
         oyGw==
X-Gm-Message-State: AOJu0Yz5gqbwbZSeQYcmZXU8z9T4zrJCw1RdpGmAt7a2QbYhyE1mF2P9
        P0pViqId3zojKwSUve/sIQLEdyG7eRRTFEMB5MTGLQ==
X-Google-Smtp-Source: AGHT+IGAdKeZqRvkKRomTSzriDgFXuHClhG6kUDwMC0cJbQcMZKnRfXz4LZDu/jT8ZwYE3RaXiaPloSO6rSe4VpedCY=
X-Received: by 2002:a05:600c:3ba9:b0:3f4:fb7:48d4 with SMTP id
 n41-20020a05600c3ba900b003f40fb748d4mr81305wms.3.1691166853428; Fri, 04 Aug
 2023 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com> <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Aug 2023 10:34:01 -0600
Message-ID: <CAMkAt6pPCJ0YsWaL692heDCUYjF9KCBq3PNiPK2LyBd=wD0+ig@mail.gmail.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > > > + * shared secret and then use that communication channel to instantiate
> > > > > + * other keys. The expectation is that the requester of the tsm key
> > > > > + * knows a priori the key-exchange protocol associated with the
> > > > > + * 'pubkey'.
> > > >
> > > > Can we instead be very specific about what protocols and cryptography
> > > > are being used?
> > >
> > > Again this is a contract to which the kernel is not a party. The
> > > requester knows the significance of the user-data, and it knows where to
> > > send the combined user-data plus quote to provision further secrets.
> > >
> > > Not that I like that arrangement, but the kernel is not enabled by these
> > > TSM implementations to know much more than "user-data in", "report out".
> >
> > Can you explain why using this key API is better than the ioctl
> > version? Is there an overhead to adding keys?
>
> Setting aside that folks that have been involved in the Keyring
> subsystem a lot longer than I are not keen on this usage [1], I expect
> the overhead is negligible. Keys are already used in RPC scenarios and
> can be destroyed immediately after being instantiated and read.

OK the overhead is negligible. But why is this any better?

To me this seems strictly worse to me as a user since I have much less
input into the hardware attestation which is one of the primary
benefits of confidential compute. I don't want the kernel limiting
what cryptographic algorithm I use, or limiting attestation reports to
signing pubkeys.

I understand having a proliferation of similar drivers may not be
ideal but given the hardware lift required to make confidential
compute happen will we really see too many?

>
> [1]: http://lore.kernel.org/r/c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com
