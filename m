Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6776A0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGaTJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGaTJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:09:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00718D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:09:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-407db3e9669so47421cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690830570; x=1691435370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ZKaun3P60KBSb3dXImXzwtjn2G20uEFZ0KIDGH6Q4=;
        b=WmuGikmqqLWs/hkQqPxF2wfDP7LvJYJnfaXgFkMbPgwKrSU6uimY4ao4KnlbBTjpM9
         5zgU/n1E374yNmfy0dGOZCU+u3OJx1Ymdo7qIvs0RLll44M5N5u0QYGRxQ423HuULLYT
         ILtwHYsrAmUj8rBE4Nm3nEt3i9nmg2fG7LL5UqLgvTJ9OIDH8WfVQADUSd/lg1DJjpDV
         xWq7zHWbJniIROpQHc/mO1Imp4SYkD+wOr4sPbzEDPPhTUCzpl3iwaypq4o+UH6LXakz
         Yc4BQT3oR06sc/HmtW99gGtOBY7IDLEgVhUEOArJuyDTSbQkHU3O5NHMCNRTRFqBDzMJ
         H8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830570; x=1691435370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9ZKaun3P60KBSb3dXImXzwtjn2G20uEFZ0KIDGH6Q4=;
        b=BvLJgGeyfXP5unZb0eWPKszaP+SQoWFM1HzYzxJ3DxPsFubhfSaaUxgS+ZaLohZp/K
         CBCsUrUSp1XiRbqtrcUGYtytN1h9ygRhgswaIHSS1dL5OO1mKR7Dgm6i+BG3xZd4v2Tb
         Fyt6tX1jU7Q3/J9WidJMrHcIDDdRCn70T+5toKmvr/L3aJAQY6qAYY6fII3yh7hQquCI
         a2YKTwbjHDqj+l/E8jtDBCcs5duvAHA04lRxYOrGzV5vCM+DzBBICc0V/YPNAMwYblKT
         xQYopthvzlwqrtZYsMMaLM46M+HaFATBg8MJu+CMScuCjhiTVGjlaZedonjJGmHGIGRw
         3b2w==
X-Gm-Message-State: ABy/qLZ59VxGm9so6CYm2hDNXR7EizgZ8XN1xLRkic6QWMPprQ6CYY5E
        LOXhZfcMYyZcH1ajMtcvTjhst5vhI1+UHvNULD94Ug==
X-Google-Smtp-Source: APBJJlFfo2p96/nutQsKmS/qFUh6LjCFIF9CNQDvdpN84ZjFMhfR5eCDL3Trl9lWpw7Vx9l6xKq8Kty+v0HYSvma2l8=
X-Received: by 2002:ac8:5b45:0:b0:3fa:45ab:22a5 with SMTP id
 n5-20020ac85b45000000b003fa45ab22a5mr629087qtw.27.1690830570348; Mon, 31 Jul
 2023 12:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com> <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 31 Jul 2023 12:09:19 -0700
Message-ID: <CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Gonda <pgonda@google.com>, dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > You could imagine some userspace application that receives RPCs and
> > does some attestation for each one, would adding then deleting a huge
> > number of keys present any issues?
>
> I can imagine a lot of scenarios, but reading the SEV-SNP whitepaper it
> seems to imply that this is a launch-time one-off report that
> establishes a channel to convey other secrets. So my expectation is that
> this interface is used to bootstrap a guest and never again. Are you
> aware of a high frequency use case for these reports?```
>

Attestations may be requested by RPCs themselves when a service
decides to allow a user to present their own challenge nonces that
should be included in the hardware attestation. The "once at boot"
workflow only works for a specific type of application.

> > > >
> > > > How is freshness incorporated into the key exchange protocol? Wouldn't
> > > > we need to do a challenge response between each remote party that we
> > > > need to attest the provenance of @pubkey too?
> > >
> > > That's left to userspace.
> >
> > But you haven't allowed userspace to add any data into the quote other
> > than just the raw public key.
>
> That is not allowed by the SNP firmware interface. The only input is the
> 64-byte user-buffer that the SNP whitepaper calls a public-key.
>

The whitepaper presents a hypothetical usage of the attestation
facility. It is not prescriptive. With only 64 bytes, you're most
likely to be providing a nonce or a hash, and not a full public key.
Indeed, you may be presenting sha512(nonce || pubkey).

> > The current sevguest ioctl allows users to pass arbitrary userdata.
> > This would allow for some nonce to be included.
>
> It's not arbitrary user-data, it is only meant to a pubkey per the "VM
> Launch and Attestation" section of the SNP whitepaper.
>

It really is arbitrary. We've also been discussing including hashed
vTPM quotes to tie them to the hardware attestation. That's not
necessarily how it'll be used going forward, but the interface needs
to allow for this flexibility.

> > At a highlevel I'm not sure why this is better than each vendor having
> > their own driver. It doesn't seem that difficult for userspace to deal
> > with these systems given userspace will need to be written carefully
> > for these PKI protocols anyways.
>
> The common facilities can still be made common. Namely, the interface to
> take in a pubkey / user-data and the location to pull the report need
> not have any vendor specificity.

I can understand the desire to abstract now that there are 2
datapoints instead of 1, but given that you've said folks aren't keen
on this usage of the key system and developers of these drivers are
also not keen, maybe we should let there be some vendor specifics
until we have a better idea how this will work with more technologies?
RISC-V and ARM have attestation facilities coming, and it might be
hard to shoehorn all their capabilities into this as well.

-- 
-Dionna Glaze, PhD (she/her)
