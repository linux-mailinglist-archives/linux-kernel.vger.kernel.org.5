Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17278CFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbjH2W6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbjH2W5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:57:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7703CC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:57:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff882397ecso7660968e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693349853; x=1693954653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkhXetCzPMun8u4gfVs+ffh2I93t6SvS6t2zvrt8kso=;
        b=aQpPiu/gK8GYuexeznqgEwlitES8OTxUBeHk7ixHeNbciUQLU37yXzGcH04QWBmV0H
         jaFgylz2ftuAytmt4f3CJwqJwfq4BwUzbb2/e43UV1PYs2o+XD8kukrc6dN4lRXIY+vh
         7188zJZjqWIXQ4TnnPFK4Y+lQlf4Y2Puv1cMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349853; x=1693954653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SkhXetCzPMun8u4gfVs+ffh2I93t6SvS6t2zvrt8kso=;
        b=ImhV6T1JkgdhNRulPtOrFTt16FeOH0C7FJZ71VNlRIXUj3OEqnyIleLVdYb+hBK+GG
         brympbuo7yc76a1nj1FC3FyoU++2jBhz2ODqhq6+z778IyZerJN8LYbbgdwQrwCbKy2h
         hZ4RJe5EGfZ/Mtzw5MhLILih+abvfL+g3Rw8ogpweR9zenRNWRTvFh8qcb+3kcY3HOy5
         RgMC7TLaxMqEmyisYN/XlvflN1Laid8n/uyR9blKCExfI/tH9dVJxP1kbaNImGThVSU2
         2cbu3EfRXqq2aFsEBczj8I2+Hm+/PF6z+gE2hahuaHQnZE98gOxeeYA/l3b/HHkNOO8O
         blrw==
X-Gm-Message-State: AOJu0YxvIhwtG6eKK8wRTQq/z2dZ5D/mN7QOeGKhT/raof7wIeqYeKB0
        J9kj+PXd/2mJHTBbscLeIrha0cxNnd+wAu1SFpjPdg==
X-Google-Smtp-Source: AGHT+IHSNDYPWmFDFVRtVvMTIMyQr8m28f47j03gdwFH5kxeFcIcBmZCBlVyK9F/C7T52bS00yuH9GruzF4bQv8vfMU=
X-Received: by 2002:a19:2d5a:0:b0:4f8:6dfd:faa0 with SMTP id
 t26-20020a192d5a000000b004f86dfdfaa0mr224163lft.2.1693349852333; Tue, 29 Aug
 2023 15:57:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Aug 2023 17:57:31 -0500
MIME-Version: 1.0
In-Reply-To: <ZO5iWlczXmX7wNn9@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
 <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl> <CAE-0n51gcN+3Ng7+bz21eS_6JomnVDzZMuWyzZVB25paj29j4g@mail.gmail.com>
 <ZO5iWlczXmX7wNn9@qmqm.qmqm.pl>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Aug 2023 17:57:31 -0500
Message-ID: <CAE-0n531mK2Lvt7saXySPZLbGsA1giB3at0WDadErYOhcUv6ew@mail.gmail.com>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Micha=C5=82 Miros=C5=82aw (2023-08-29 14:25:46)
> On Tue, Aug 29, 2023 at 03:52:19PM -0500, Stephen Boyd wrote:
> > Quoting Micha=C5=82 Miros=C5=82aw (2023-08-28 13:26:54)
> > > Indeed they are quite similar. I did remove a bit more code than that=
,
> > > though: in this case there is no early success return before the loop=
.
> > >
> > > Instead of saying:
> > >
> > > lock A
> > > lock B
> > > if ok return
> > > if that failed, loop:
> > >   unlock A
> > >   lock B harder
> > >   lock A
> > >   if ok return
> > >   swap A <-> B
> > >   lock B
> > >
> > > Now it's:
> > >
> > > lock A
> > > loop forever:
> > >   lock B
> > >   if ok, return
> > >   unlock A
> > >   swap them
> > >   lock A harder
> > >
> > > With the same condition 'A held' at the start of an iteration.
> > >
> >
> > Removing duplicate code is great! I'm primarily concerned with
> > readability. The terms 'A' and 'B' doesn't make it easy for me. Can you
> > maintain the 'held' and 'contended' names for the variables?
> >
> > That would be
> >
> > 1.  lock 'held'
> > 2.  loop forever:
> > 3.    lock 'contended'
> > 4.    if ok, return
> > 5.    unlock 'held'
> > 6.    swap them
> > 7.    lock 'held' harder
>
> Doesn't this make it more confusing? The lock is 'held' only in lines
> 2-5 and looses this trait (but not the name) on the other lines.
> 'contended' is more problematic: the contended lock is called 'held'
> before locking it at line 7.
>
> The algorithm is basically: Take the locks in sequence. If that failed,
> swap the order and try again.
>
> Would a comment like the sentence above help with readability?
>
> Or we could wrap the final lines of the iteration in a
> 'regulator_lock_contended()' to make it self-documenting?
>

Squash this in?

---8<---
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9736507b62ff..39205cf00fb7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -201,6 +201,7 @@ static int regulator_lock_two(struct regulator_dev *rde=
v1,
 			      struct regulator_dev *rdev2,
 			      struct ww_acquire_ctx *ww_ctx)
 {
+	struct regulator_dev *held, *contended;
 	int ret;

 	ww_acquire_init(ww_ctx, &regulator_ww_class);
@@ -208,22 +209,24 @@ static int regulator_lock_two(struct regulator_dev *r=
dev1,
 	ret =3D regulator_lock_nested(rdev1, ww_ctx);
 	if (WARN_ON(ret))
 		goto exit;
+	held =3D rdev1;
+	contended =3D rdev2;

 	while (true) {
-		ret =3D regulator_lock_nested(rdev2, ww_ctx);
+		ret =3D regulator_lock_nested(contended, ww_ctx);
 		if (!ret)
-			return 0;
+			break;

-		regulator_unlock(rdev1);
+		regulator_unlock(held);

 		if (WARN_ON(ret !=3D -EDEADLOCK))
 			break;

-		swap(rdev1, rdev2);
+		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
+		contended->ref_cnt++;
+		contended->mutex_owner =3D current;

-		ww_mutex_lock_slow(&rdev1->mutex, ww_ctx);
-		rdev1->ref_cnt++;
-		rdev1->mutex_owner =3D current;
+		swap(held, contended);
 	}

 exit:
