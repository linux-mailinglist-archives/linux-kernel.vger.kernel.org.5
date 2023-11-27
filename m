Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2A7F9DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjK0Kh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjK0Khv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:37:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8AEA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:37:56 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so2734194a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701081476; x=1701686276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/PWxu0CGkUCHBZBjzdAigp9CyDU6IvKDJgxAJlFCJU=;
        b=akuNXPvgNPVTxAPJoDNDzVCaGsopcNg6334V9A34AzdLL4ri5ijkCH2TpUfOSANAIk
         CcxFybkZ9SDnhpDTGBFKXm6k9js/nKvdVd490oxZ97CdPn6gLkVqY+kF4oawPn1QSoiG
         l0qasEP11FAmGTodt8MsgR3K5IMV1A0fLx37cXMq5cdW8ERA6CT7nyRsadvbaThEzrgD
         QTaW8CPPz4IC0Bmqh4YJotrOACIuXk1qEeVi/MtIabpzwSk3nGFMjuaqZy47sXtUgnw+
         PpNq3zAm0EwfEM/Wb0cwvhm1AeMKB2BPA+gr41zrVkOspfGhBJo00liopYcC8ycIAj2v
         3o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081476; x=1701686276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/PWxu0CGkUCHBZBjzdAigp9CyDU6IvKDJgxAJlFCJU=;
        b=aVCRKQzgaMsHX6/sXVmeAFC3JJNB448mdqR1fD5I2sup6uuEyi4q/QMxAfDzTdbCCi
         zMBcDk3A/3ZLR8BttM3dlKfURwv1+hSyH4jjr2w4f79bYG0o+vsrsDPmkqaQ/3iU4ssZ
         UhUhGCENgP0d2BqJSofk36qfOzDBOnbnesKsOsnYFW18oEQ2irpYY3C0RtFM/v9KRdo3
         Aapz4Lj2kGmYG+Z1//XnEN/0RFkk0QSm3eKXarjZTyGK7HTQms+6WWLaboQvlegSfuzo
         Pq44zWXvo8CHJOywmMBkC3iJJvCJOpMzVLXcdMFmhdGXYgcTyI20qwIFBvWNZ+3g8q7m
         Rt8A==
X-Gm-Message-State: AOJu0YySIy/VadVtUUx2uU901bO8a9lpzN/W9HrHhzpdM39nyYf0WCXv
        p3INLMTDA3qep8InCqZLUebPd703hwCt8GB3K9mdDw==
X-Google-Smtp-Source: AGHT+IGGQVEvkb0vLzDuA7xrsio22fp69iXNY50Ds3eqYS46Mh8mDMF+oKp0btfo2ir9YnY7+2ITAnDbGnOmJ6B8ECo=
X-Received: by 2002:a17:90b:1b09:b0:285:b97e:5dbf with SMTP id
 nu9-20020a17090b1b0900b00285b97e5dbfmr3416143pjb.10.1701081476007; Mon, 27
 Nov 2023 02:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20231121101331.22837-1-naresh.solanki@9elements.com> <ZV9MNdOCkIpLB+6Y@finisterre.sirena.org.uk>
In-Reply-To: <ZV9MNdOCkIpLB+6Y@finisterre.sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 27 Nov 2023 16:07:45 +0530
Message-ID: <CABqG17jRbqcw=QioyZTPFTidUDiPDgBFbm45vfvG2Sc5TOznvw@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: event: Add regulator netlink event support
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On Thu, 23 Nov 2023 at 18:27, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 21, 2023 at 10:13:30AM +0000, Naresh Solanki wrote:
>
> > This commit introduces netlink event support to the regulator subsystem.
>
> This looks a lot nicer, there's some feedback below but nothing
> maissively substantial.
>
> > +#ifdef CONFIG_NET
>
> This is essentially the entire file - it's probably better to just put
> the stub functions in the header and do the building with Kconfig.
Sure.
As I understood, Will add an option REGULATOR_NETLINK to include the
event.c file during build.
>
> > +static unsigned int reg_event_seqnum;
> > +struct reg_genl_event {
> > +     char reg_name[15];
> > +     u64 event;
> > +};
>
> Given that this is going to get sent to userspace shouldn't it be in a
> uapi header?  Some of the other event types don't seem to do this
> though...  that might be an issue with those examples though.   We'll
> also make the event numbers into uapi so they should go in a uapi header
> as well.
Will update next revision to include uapi header.
>
> I'm also not clear on where the 15 byte limit comes from.
I felt 15 characters would be sufficient for regulator names.
Would need your inputs to make sure here.
>
> > +EXPORT_SYMBOL(reg_generate_netlink_event);
>
> Everything else in regulator is EXPORT_SYMBOL_GPL() so this should be
> too - though given that the only caller is _notifier_call_chain() which
> is in the core does it need to be exported at all?  I can't see a case
> for anything calling it independently of that.
Agree. The current scope is limited to regulator core so will remove the
export.



Regards,
Naresh
