Return-Path: <linux-kernel+bounces-20401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E79827E40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1143128599F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3338F60;
	Tue,  9 Jan 2024 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWgXTy49"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1738F40
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dc05ddb656so1487505a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 21:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704777095; x=1705381895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5+Xjx22xxqPiCGgK25ju8RGeEqdjeF3l/sM3phgZ6w=;
        b=eWgXTy49XsNe9WvZEr7JwnQ/CqDmS3JGMP4fM9z34+aaEoMeZm927BmgRhXx4DL0MQ
         huF6qhsaxFMZ8sq7rmjq0h92cphaxCEwKtaS8jMdBAYH1yJY1x8tHthKKYpRQXvJgWkh
         fgiI69TPRtH5W1pdpP+g302CvX08bEd2BJuylK2YCduxpfe65X/j6gDuOkiJTvP0npIe
         OrXXPOq0jFqGFtxsi6gf7xDNDI6SfIxWFmTJ/1WoOyZ+70RGUlvMPxfHu5lBzw8l1hYM
         B49o8tt8Vohwjx/+YYacNQ/AX1TtWCxJSf+kdWw9BAgY5lIGFX0NpsCKOfSWnIRFfb8i
         p+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704777095; x=1705381895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5+Xjx22xxqPiCGgK25ju8RGeEqdjeF3l/sM3phgZ6w=;
        b=oRAhtJDxo+6oX8LnlI2KKLGrZ3/Rej1PO09uHrE9aeGL5hQKMbDinVEAufgS0sMmkn
         J1oLAD5v2M1/UH2kv3aJFXaOgKrLrCvy/lmqhn/EpHdxmrODZRidq1K6Jo7Ic3mykEfo
         j4KIqX9NYidymEmAD2OJUyTZ0s306H1wrQ9t7Vhz4w4lKLGbrfKBe0vuZqUXyKeWcN9m
         jrQ3PBx+/wWcbANQMcJisGdZX1+CuGawESWpA6fiHMQiKmqWQQ3mvFmK6YF44A3YSeoc
         7VohOs8UQPWHvWfVorPVeENPXnXTzzXPTa4mfPEiilPXGyYwCESxiE3US6ivJ4X+J4vd
         eJtA==
X-Gm-Message-State: AOJu0YxvtYbIH9F40QEHEmV2uPev8OhbvlEDRUPlaxC1YoaNRpVrW6b0
	F9K0QFdEYNQr7UVpFlvyGBGJZxWQQvjs5LNs8o8=
X-Google-Smtp-Source: AGHT+IEQ+NK5ED0Jjnt2Zy9a4KC1ZPi4IVMYz/Q9y01/lxLRiIKSzYiaBkSfxKXHZHAvw9IJiHzmf6/8uRZVmM/CVPs=
X-Received: by 2002:a05:6870:40c8:b0:203:7cb2:35 with SMTP id
 l8-20020a05687040c800b002037cb20035mr5299063oal.60.1704777094674; Mon, 08 Jan
 2024 21:11:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105060456.15331-1-xuewen.yan@unisoc.com> <a8023072-0900-4be9-bb34-02850276404b@redhat.com>
In-Reply-To: <a8023072-0900-4be9-bb34-02850276404b@redhat.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 9 Jan 2024 13:11:23 +0800
Message-ID: <CAB8ipk_hcbYbZhoV0ZCDH0smQPTz98CQH7wP=PjJS6kcxavpVg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdep: Add missing graph_unlock in check_prev_add
To: Waiman Long <longman@redhat.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com, zhiguo.niu@unisoc.com, 
	ke.wang@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Waiman


On Tue, Jan 9, 2024 at 11:51=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 1/5/24 01:04, Xuewen Yan wrote:
> > The check_prev_add() is held graph_lock, and it should unlock
> > the graph_lock before return 0.
> > But there is one condition where it will return 0 without unlock,
> > that is:
> >
> > /* <prev> is not found in <next>::locks_before */
> >       return 0;
> >
> > So add graph_unlock before return 0.
> >
> > Fixes: 3454a36d6a39 ("lockdep: Introduce lock_list::dep")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > Change in V2:
> > -move the graph_unlock to check_prev_add from validate_chain(Boqun)
> > -Add fix tag
> > ---
> > ---
> >   kernel/locking/lockdep.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index 151bd3de5936..c8602a251bec 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3178,6 +3178,7 @@ check_prev_add(struct task_struct *curr, struct h=
eld_lock *prev,
> >                       }
> >
> >                       /* <prev> is not found in <next>::locks_before */
> > +                     graph_unlock();
> >                       return 0;
> >               }
> >       }
>
> There are multiple places in check_prev_add() that will return 0. It
> will be odd to have just one of them has a graph_unlock(). It makes the
> code hard to understand. You should insert graph_unlock() in a place
> that matches the other places where graph_unlock() will be called. My
> suggestion is as follows:
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3de5936..d9f2df36332c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3252,7 +3252,7 @@ check_prevs_add(struct task_struct *curr, struct
> held_loc>
>                  if (hlock->check) {
>                          int ret =3D check_prev_add(curr, hlock, next,
> distance, &>
>                          if (!ret)
> -                               return 0;
> +                               goto out_bug;
>
>                          /*
>                           * Stop after the first non-trylock entry,
>

As you say, there are multiple places in check_prev_add() that will
return 0, and some cases had unlocked the lock, if all goto the
out_bug, would it cause double unlock?
Maybe as follows?
---
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..8b665ba90ad0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3178,7 +3178,7 @@ check_prev_add(struct task_struct *curr, struct
held_lock *prev,
                        }

                        /* <prev> is not found in <next>::locks_before */
-                       return 0;
+                       goto list_err;
                }
        }

@@ -3215,6 +3215,11 @@ check_prev_add(struct task_struct *curr, struct
held_lock *prev,
                return 0;

        return 2;
+
+list_err:
+       /* still get graph_lock, unlock it before return*/
+       graph_unlock();
+       return 0;
 }


Thanks!
---
BRs
xuewen

> It looks like this bug was first introduced by commit 910b1b2e6d
> ("[PATCH] lockdep: internal locking fixes"). So you may also add a fixes
> tag.
>
> Cheers,
> Longman
>
>

