Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E846F8036B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjLDOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjLDO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35931BE4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701700087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipCYBfsq07gJkV6QGZ5UqNjU2TxbagzWDddbF1Rf4zM=;
        b=B0c1SCeM6PVpiWBmlemQRvWUd0RZoHPClJZQ0mZQL/QOoydsTK1GoapkpFJWmvQ1cIw+9+
        7ojtPBzKXHb4J0mAiViOqyFlG08SPcYmqAfCfZ4yOCVgqIohrispmOmMrqiNEdI7G7ahj4
        oipFEiMXS8TxsshKGSLBvm/Dx6qN9UE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-RgE3gzRZMNGucOiEOpjsQA-1; Mon, 04 Dec 2023 09:28:05 -0500
X-MC-Unique: RgE3gzRZMNGucOiEOpjsQA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e11a22a0so4080010f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700084; x=1702304884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipCYBfsq07gJkV6QGZ5UqNjU2TxbagzWDddbF1Rf4zM=;
        b=neMvNZon5Di7L6+5DomEC1MWfgCAIui6lKldJ16B+alZntJjhlL5VGeKSpLcbjOCsC
         Oyd6S53MW0dEZXbX1W1hiDedu7ZF7ZeLYQRxMkhpWvM+Yiz1YzztgGhi46RUg58Iewd3
         vw6fsHo2lj7fqByx6gEcVtBEAvGH0K9iHEwjLjM8U96tABFbkTy6EEJ12ZCaE+BkXUKW
         Zv30c4VHROhD4f3RijBuTs9FXd3Gm37lgKkFBqb0f7Z/kinwOdmrUiMtYhlJOZSIRke0
         y3P+8nTdy2Bm+pTVU2g9gkzk4GyQVPSlKXw3f/yEAByvl0E1Y5GwYxB9LZKVqyJFH94z
         hwwg==
X-Gm-Message-State: AOJu0YzIABcyeRzHVoUkLyu6j0iP3cwFsUH6ItdtuG5CkZJ3AGitZ0mp
        y/m7pzlZOXqOMeKsZ4DGBWZTbVdx0lrckI9JDMfdJdLwXXvGhhbm8QUuEd0rrxlOO4TgEBjj3J5
        aBV6kiHoYGjWo+BQAFLCEyPq3XiYyLNgtNpjauVB6
X-Received: by 2002:a05:6000:1109:b0:333:1888:99da with SMTP id z9-20020a056000110900b00333188899damr3132978wrw.5.1701700084540;
        Mon, 04 Dec 2023 06:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/5f/bgJXXDtImCPQ+Vinmh68Z9+KKa3OT0wsJjvUdWSCsNCs+Rtu8tslJpCKBP83m653vA7Y6WpEiG1SM1u0=
X-Received: by 2002:a05:6000:1109:b0:333:1888:99da with SMTP id
 z9-20020a056000110900b00333188899damr3132968wrw.5.1701700084285; Mon, 04 Dec
 2023 06:28:04 -0800 (PST)
MIME-Version: 1.0
References: <170147003175.315432.12322961896739098066@demetrius> <ZWzNMjnF4NgNoKTu@duo.ucw.cz>
In-Reply-To: <ZWzNMjnF4NgNoKTu@duo.ucw.cz>
From:   Clark Williams <williams@redhat.com>
Date:   Mon, 4 Dec 2023 14:27:52 +0000
Message-ID: <CAMLffL_4r8M9wAaR2azEQeykA0VWHpN6LEO3dHRX+X=osCZ++Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.64-rt17
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're quite welcome!

On Sun, Dec 3, 2023 at 6:47=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > I'm pleased to announce the 6.1.64-rt17 stable release.
> >
> > You can get this release via the git tree at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >
> >   branch: v6.1-rt
> >   Head SHA1: 10278c5eac700351db2dbfcce88be2df51725931
>
> Thanks a lot, perfect timing and made my life easier.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

