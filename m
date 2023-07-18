Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A5575885D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGRWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRWTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:19:30 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E0BD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:19:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so18161a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689718767; x=1692310767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTirM6dws8Iol9T3+w/2xeoFNZKbQqSyMExz8yz5g0Y=;
        b=FRpKV5XY6Mnar78FFICcee2sxcUm+n/3xwTIthjFTf+IvQWpF9JcRrm76b9/Z/wjzt
         TLrCsFASLy+0QGzLwxc4IUT4g33q5kTN50Jvdb+sPz11oSdlYyFAQ0PGaBHElSA4UuVU
         ZBvHFvHhmdppGaiIHUCexqlVMBO0RSgAGPD5WlyN7Z01vm+spHVyWw2z4qdoANAHVmNk
         hULL01bQtW6wdJ9yDwrRCxmpGMXkAsy0hu6uTcVLXY/S/jBrKrhYsue/2MVII7g4YVTb
         Gc42y6cPZMkN3QAG/gg8qSq2v68StK361FvWg553IL9LaCXou4asSMu6oG4QQ4ts67nB
         Qs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718767; x=1692310767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTirM6dws8Iol9T3+w/2xeoFNZKbQqSyMExz8yz5g0Y=;
        b=LnseyMv+q/KsMz8X1LdZgrh/pUiBIDA5dAKhNZV5DQCIY7hO5jYRnv41VDSATUf+Cc
         UhE6hnUW+bnhCL7fWdBTq3u1v7C/sh+XDJ/XzGPMByLiXxDAwfF1sGZUsqVQ5gKVYprj
         rgMGJTlqCoMWwYqeHk31ne/Hf+wF7RtxoXh2NPcDSzWpmKvNJ3ZWqpyBJOTylzb6npA7
         m6pEZVouZj0452cR7OqPAjkdbx9lOthFfB/yShWEOwtlam6CVQxD1ZydV+u7PSG3OsPD
         xzNJv61792xvdFtIIxARvexCxNNpeMfO4i+rVTTzZJC7uiPk+Tblo3XmuvYcNtv4NTRO
         fTDA==
X-Gm-Message-State: ABy/qLYqLtF5Cv9N4U9tz+GfiX5pIon3+CE+rWJHxdVRuqgyj/z6SCiW
        Fmk7CSrwUKHbV0cc1N3MZWj++xpyCjAeVooMY9A0Khkz3khqIZuj2IrOJA==
X-Google-Smtp-Source: APBJJlEXIdjXTngOmMaNnVJdOVTzeg6p3lOGTAIgqMp4hs2zhfhLpFXYo4inKjrvfwO97lDw6wdDXkkcEyBBr1Qig8E=
X-Received: by 2002:a50:bae9:0:b0:51e:27ac:8f9a with SMTP id
 x96-20020a50bae9000000b0051e27ac8f9amr175465ede.1.1689718764750; Tue, 18 Jul
 2023 15:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
In-Reply-To: <ZLcOcr6N+Ty59rBD@redhat.com>
From:   Rob Barnes <robbarnes@google.com>
Date:   Tue, 18 Jul 2023 16:18:47 -0600
Message-ID: <CA+Dqm32sTcJoh-8LmtegWdihWGJWQdwCUDhmrLhru866uwQzyQ@mail.gmail.com>
Subject: Re: [PATCH] fs: export emergency_sync
To:     "Bill O'Donnell" <billodo@redhat.com>
Cc:     bleung@chromium.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
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

My use case is when the EC panics. A hard reset is imminent. In my
testing a regular sync did not always sync all of the logs. See
https://lore.kernel.org/all/20230717232932.1.I361812b405bd07772f66660624188=
339ab158772@changeid

On Tue, Jul 18, 2023 at 4:13=E2=80=AFPM Bill O'Donnell <billodo@redhat.com>=
 wrote:
>
> On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
> > emergency_sync forces a filesystem sync in emergency situations.
> > Export this function so it can be used by modules.
> >
> > Signed-off-by: Rob Barnes <robbarnes@google.com>
>
> Example of an emergency situation?
> Thanks-
> Bill
>
>
> > ---
> >
> >  fs/sync.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/sync.c b/fs/sync.c
> > index dc725914e1edb..b313db0ebb5ee 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -142,6 +142,7 @@ void emergency_sync(void)
> >               schedule_work(work);
> >       }
> >  }
> > +EXPORT_SYMBOL(emergency_sync);
> >
> >  /*
> >   * sync a single super
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
