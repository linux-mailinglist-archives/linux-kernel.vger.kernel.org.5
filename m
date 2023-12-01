Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7AA800FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379473AbjLAPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbjLAPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E31B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701444919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsjGSOYFgl6bCPMlmbPKHSuXPWM19efMk5kmhq6NZWE=;
        b=aBQ6pxBerSqS3mT72hZ/ld3+b64lESEDG6P/TzDsF/M1u+evW7C/1pRPh8r3+RqkK/zJXn
        UinTBHMGEwyQZXYEa06hl0wKuhEJvNidUezPDMZg88NBGgHefxbh20Fl0y23NO222VMDU8
        buPXCBE/4S1YxkclObdFj/RQe5gfzAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-9wH9prGVNDmBGbX5YQxUpg-1; Fri, 01 Dec 2023 10:35:17 -0500
X-MC-Unique: 9wH9prGVNDmBGbX5YQxUpg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333305a3d94so545140f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444916; x=1702049716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsjGSOYFgl6bCPMlmbPKHSuXPWM19efMk5kmhq6NZWE=;
        b=RhqAEman1p6uYkxrVeKQ/HijCHjweRbcW5yWUdgUUfd/VPYyyRGvGWVGnPd1oIZqJJ
         aaXpooE8fzl2Kq0wGhQesNEH7byV260KPAA1mD/rPLikCytQUqj4FVk0tyrho6/mb/ja
         Bsa/Hkwm0fio0tncCn5rA8qkozCgoqfIYox1blv24jp20/tyXUNmgH30ha+NGW1jHN0f
         gZRh8d2TcW+OLWZG5IMcZQDVYga9t3FVr0MCg4/pXX+11qMhlv2+a4rry+479DIU5Nqw
         xVwnoFsj0H/ZlffVMnXHGd4u6Ir7WmGfbHXuFz0g6wnrBSnQkL6red/nTfJ+fBUWoTU+
         XRnA==
X-Gm-Message-State: AOJu0YwbFLDfgZHY4Ai9ZXexVQfF3GXDfROii+6XQHQ2J3Wha8ZWpj0S
        qnvaI7Kz+LI2njmu+hC/rLMElQl8Jd/DoGIeZxTGxaZcQYTmgdWSLohDT/Y2yWkAQTox5QZUkid
        XA1Km6QC6UxWxxAJI5jL8U6/qZ2dg7iuyR+otUxZi
X-Received: by 2002:a5d:54c7:0:b0:333:2d34:3ef4 with SMTP id x7-20020a5d54c7000000b003332d343ef4mr965968wrv.9.1701444916122;
        Fri, 01 Dec 2023 07:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMxld/P6Ep7Ts48kNdUIEhlNH5IuBjgjyNuxuJuLeyrfLAReZ3kUO2FrhzFpuKR1USJXhJldpEuSSF+mfQ9jU=
X-Received: by 2002:a5d:54c7:0:b0:333:2d34:3ef4 with SMTP id
 x7-20020a5d54c7000000b003332d343ef4mr965958wrv.9.1701444915844; Fri, 01 Dec
 2023 07:35:15 -0800 (PST)
MIME-Version: 1.0
References: <169783215859.257534.17071765559550518745@demetrius> <ZWhgT8s2BDZ566F6@duo.ucw.cz>
In-Reply-To: <ZWhgT8s2BDZ566F6@duo.ucw.cz>
From:   Clark Williams <williams@redhat.com>
Date:   Fri, 1 Dec 2023 15:35:04 +0000
Message-ID: <CAMLffL-kJzqGBAhWyNEixz_HMNzDfmi=94Ltux-L-5iC=kUK6g@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.59-rt16
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

I'm working on the v6.1.64 update now, should have something for you by Mon=
day.

Clark

On Thu, Nov 30, 2023 at 10:13=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote=
:
>
> Hi!
>
> > I'm pleased to announce the 6.1.59-rt16 stable release.
>
> We'd like to -cip-rt release "soon", so I'd like to ask what are the
> chances of -rt release in next week or so?
>
> Thanks and best regards,
>                                                                     Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

