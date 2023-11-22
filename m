Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB27F5458
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbjKVXOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVXOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:14:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A011F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:13:58 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so164697f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700694837; x=1701299637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYxuH70oHfA52gNLRhhX4vP0LV6BSVurLPFK41qssdc=;
        b=qXoDABKJPDvyFk8Y5rtY0iwUYcq0FuBuk73Mze7YE0P9UawC8+xeXOmQ11mSDezZjB
         IYxHI/wR1I+lK9FlnJrE1PucqjwBMCbgonFJYibWciHI0rzTZuwEh9OF5jGY6qlAkI8e
         DtNnlRiD0+Bq+nW7sbr8Rs9ytxLfS19gKPWZDRCLfoPQqW9QVDNxALHcKySA87/FYZqE
         u1gGZxN4IEZ63m0SyYjX5IQuGH1cngwoq5oEgAjtEQyKMAjprDCGHRSvrX0kP7d8yti/
         YtzWnBe3h/Qj1dDdc/v4nrdAa5NrCeRrFefBGOB03+UvtuodLi6eok1+w7nzgPCLaSKB
         dt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694837; x=1701299637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYxuH70oHfA52gNLRhhX4vP0LV6BSVurLPFK41qssdc=;
        b=NMxXy0871y4n4bGz1FHONYrT2VPZJXJc12hk1T3jEdeIlhOrvS9wBHeboV0QKgzOd5
         urIwx0vjtFD1w9DDkdEFLRsXHiGgFn1FNIyoZB9aVDZGJzBfaIqAzCpK8HxpykAhwXZQ
         Yon5S1r4YEKvVI0rjnuSVLlbmVp6F6CjGukNl/H5K7SO+ZSjMSmHyafwuoWAz3LvZN2a
         bW5j8tnRQokRqKroC57cyNFCcEH3y0lqVeCMsJ81In55UDewlrpk92SnlP5t+yvqTEZY
         cqGhRJ3CjU0Os95VAR31oxSEMKsC2NR2tpQdPpjvb+5RvrowkB2ZRIifFgpw53mIQfgL
         08vw==
X-Gm-Message-State: AOJu0Yy3a7MBBCpyLEFw+rotycVHnBuqtEu9HdN42QZtjGRUDlRcqlEV
        ZNBQ4XagfUn6MUvXptz9/ZnfC+Tzu8jAz4ukB/48lw==
X-Google-Smtp-Source: AGHT+IFYi3BMn47KFjWgU73vrNPlY6rfEO7NJN6Pofc8xagO7DFbxSOaj7+w9+p5tuiCSj5HFYsfXanKI/Bqc/lCa5s=
X-Received: by 2002:a5d:6d0d:0:b0:332:c5ff:1ba5 with SMTP id
 e13-20020a5d6d0d000000b00332c5ff1ba5mr3509274wrq.13.1700694836803; Wed, 22
 Nov 2023 15:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20231122220001.539770-1-royluo@google.com> <2023112253-fresh-blazing-baae@gregkh>
In-Reply-To: <2023112253-fresh-blazing-baae@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Wed, 22 Nov 2023 15:13:20 -0800
Message-ID: <CA+zupgzWqhOhAR0_ybxTQVL928dgAqbm5eqJ6gd-0qrNK7VZng@mail.gmail.com>
Subject: Re: [PATCH v1] USB: gadget: core: adjust uevent timing on gadget unbind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

The logic is there since day 1 of udc in Commit
2ccea03a8f7ec93641791f2760d7cdc6cab6205f (usb: gadget: introduce UDC
Class). Do you still want me to put on a fix tag?

(Sorry for the spam, forgot to switch to plain text mode..)

On Wed, Nov 22, 2023 at 2:07=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Nov 22, 2023 at 10:00:01PM +0000, Roy Luo wrote:
> > The KOBJ_CHANGE uevent is sent before gadget unbind is actually
> > executed, resulting in inaccurate uevent emitted at incorrect timing
> > (the uevent would have USB_UDC_DRIVER variable set while it would
> > soon be removed).
> > Move the KOBJ_CHANGE uevent to the end of the unbind function so that
> > uevent is sent only after the change has been made.
> >
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> >  drivers/usb/gadget/udc/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> What commit does this fix?
>
>
