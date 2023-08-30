Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7607478D35C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbjH3G1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbjH3G1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:27:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE6DE49
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:27:24 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7532A3F62B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693376842;
        bh=RnIQo3VWGKo2jYdOWLsqgEFSEpzbuJCL+ZC0RfYr8WY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vSlXrT/eplq2NN0sXHzu2c4ITmS+8uHg1mVFN9OL4WUHiqPcKX9yNdVdPSzf0xoiX
         yWmbDjPwrVv+BW4bKu4KEeCeRhHPK0SmT/lhlXH19o+1HGlGz5FskLCcw46bNfk4S9
         lRswdg6K5JVPs6RkoQUKxwrLQi/BYil5z941mRSMQF3owiUEkflOyeCmnJ+i9iLnUB
         rbst4WLMa3bKGSA4P0Ms1BNP0sTWOamyd2P4/VuUQjDbWUYxhmpTnZHFNuaEyLTyb4
         42Dn7pLDDkSFriBXfZxPwB2uvgpRNCAzWDJ/RdOFCCOivcjAOTSwLxpiRqLctLGb1Y
         Hdzbro0LR511Q==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b8405aace3so56170201fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376841; x=1693981641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnIQo3VWGKo2jYdOWLsqgEFSEpzbuJCL+ZC0RfYr8WY=;
        b=AndtuJZd8qq+ksL+B+lXgD0+6w6W52Cx97wNLAIZHG8uNWtxjDweFhn2pjCIQRj5VW
         rKc7NleR5Uu2Wuznzk7LV+x6wGZHdeScC0gLAoz8Fn7YLczFZpA9IpJ9mAjiTmOK3ifP
         ZDXODmtBPm/QNihSdFP84dIdikwI8bs3A9hDqziHk2sCdtqTaTTJ+w2RWDjwSwbRRt2K
         rzamBcGIoqXjAWRdDsT+xHoriSnD6K7Igi2jt6nSy5FPrVo2Xd0O+3q8V5muK9Tuz+se
         a44KzB9iA5r9/6GDCPj/46qGtNVrdrnsJCdM20ywrJ6G6YgpvfWk1OJoMIa2d7Vxy9t/
         Iv1w==
X-Gm-Message-State: AOJu0YxIinQjHsz4zG/Cbu+XXPJt9Va28yfOzHnlwxNaoch3aqAXJ22w
        TZfi4/Zj/V4s/tw58C4kP0/tNQQEgQnf9Cxpbl4GCXd3HKxrN64ptVCqsHzS+YoXxsOwfJDbTn6
        bKjgKN8Iqejosc81lNMdCNa9TI+tWj65o3yHPtm9szBPXCVVDKUbT8pH5Eg==
X-Received: by 2002:a17:906:20e:b0:9a1:f6e0:12f4 with SMTP id 14-20020a170906020e00b009a1f6e012f4mr779898ejd.15.1693375202759;
        Tue, 29 Aug 2023 23:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8gKaL+YTHivPq1mxOTBt++hqwWULRhM6kPnw84P9cKjCmAliTJntlMQqIhVlZJxduCXn6AEPZik7LmYorxTo=
X-Received: by 2002:a17:906:20e:b0:9a1:f6e0:12f4 with SMTP id
 14-20020a170906020e00b009a1f6e012f4mr779878ejd.15.1693375202465; Tue, 29 Aug
 2023 23:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230828055310.21391-1-chengen.du@canonical.com>
 <CAPza5qe0NBWiKZ1yLyfdPGOsmM=VGqWMs=oWJqVzLRcd8AFyJQ@mail.gmail.com> <73E82F73-1621-4553-8019-2946EA573415@redhat.com>
In-Reply-To: <73E82F73-1621-4553-8019-2946EA573415@redhat.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Wed, 30 Aug 2023 13:59:51 +0800
Message-ID: <CAPza5qeYvrn49Ow9TQ4WL=aO+5+p1SgP4dN3coRRX+hYxkgpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] NFS: Add mount option 'fasc'
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I'd like to provide some context about the new behavior introduced by
the commit - 0eb43812c027 "NFS: Clear the file access cache upon
login."
This recent adoption has successfully resolved a long-standing issue.
The current outcome is that the file access cache gets cleared when a
user logs out and subsequently logs back in.

In specific scenarios, users might access NFS-mounted folders via a
'sudo'-like behavior, inadvertently adding to the NFS server's load
due to the inability to use the file cache efficiently.

To alleviate this performance overhead, my proposal centers on
reverting to the original behavior, where the file access cache
remains untouched upon user login.
This stems from the rationale that the cache should only be cleared
when the server's group membership changes after a user has already
logged in on the client.
This alteration rarely occurs in stable environments, thus rendering
the file access cache reliable.
With this in mind, my suggestion involves adding a mount option that
empowers administrators to dictate which NFS-mounted folders adhere to
the POSIX behavior - one that refreshes a user's supplementary group
information upon login.

The genesis of this patch places a premium on performance while also
maintaining alignment with the original behavior prior to the adoption
of the commit 0eb43812c027.
Transitioning to adhere strictly to the POSIX policy also carries merit.
I believe that further discussion can facilitate a consensus on this matter=
.

Thank you for lending your perspective to this discourse.

Best regards,
Chengen Du

On Tue, Aug 29, 2023 at 9:35=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 28 Aug 2023, at 3:14, Chengen Du wrote:
>
> > Hi,
> >
> > The performance issue has been brought to our attention by users
> > within the Ubuntu community.
> > However, it seems to be confined to specific user scenarios.
> > Canonical has taken proactive measures to tackle the problem by
> > implementing a temporary solution [1], which has effectively resolved
> > the issue at hand.
> > Nonetheless, our earnest desire is for a definitive resolution of the
> > performance concern at its source upstream.
> >
> > I've taken the initiative to send the patches addressing this matter.
> > Regrettably, as of now, I've yet to receive any response.
> > This situation leads me to consider the possibility of reservations or
> > deliberations surrounding this issue.
> > I am genuinely keen to gain insights and perspectives from the
> > upstream community.
> >
> > I kindly ask for your valuable input on this matter.
> > Your thoughts would significantly aid my progress and contribute to a
> > collective consensus.
>
> Hi Chengen Du,
>
> This patch changes the default behavior for everyone.  Instead of that,
> perhaps the new option should change the behavior.  That would reduce the
> change surface for all NFS users.
>
> The default behavior has already been hotly debated on this list and so I
> think changing the default would need to be accompanied by excellent
> reasons.
>
> Ben
>
