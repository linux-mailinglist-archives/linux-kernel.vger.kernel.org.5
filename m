Return-Path: <linux-kernel+bounces-129070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB60589644D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2739A1C20DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFF4D595;
	Wed,  3 Apr 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFJJK1ml"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D764CB41
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124037; cv=none; b=UiIfgpUxTT2rEYHwyQ3XDb8JK0YBLf36tg2vsxBU7A7Uma35HrCm3Gm9pVHZzZ1kHaopatvuli0tsS06GJmJPjqD6RMsuOL6gRFbqwjt6aJAgJcB+dR7WIW7G70tO4ZGkoCU66DSMehDyPicTn91CqKdUefwI7t+j3j1kSiEKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124037; c=relaxed/simple;
	bh=RvRmCihrPR6nqu0uOGLjEw2g7U2DBNWoL9Lnv/JHcvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frnN8DO0I5rlt8SozswkkBs4dKRQp+Ys6D5iDJb63bS5rYIsKH8yyRYstF9q56Rc/lDcyBhOUClY2tm9JQU+jIyQlCBK5Ww2AMcDn5QBmJKopwPMh2S+h+8iWSyLQGeX6dqhLSBHHn6C6CDsMm4usTLt4WV6KAHp8fl8ya3tRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFJJK1ml; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3436ffe05c9so958441f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 23:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712124034; x=1712728834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeN7BH7FX/UdYJqsptGEzUMzeVN4Ecw1to7ZT4gs+X4=;
        b=LFJJK1ml25esA5RtsGvoQrb6hJEnpww1f673N733qdfjrNWsKj10ozcwVHZrTHekjI
         SGm9tq/HcVknbEel6ca/9jXJNEHQj5AkzjpvlUQhBUL8N9o5IcegWywTqsGYmGWbu+f+
         +oj3L9EYEs5slu17ylruwJWll3ZppIZ8zd/tzHKfXdASvUNmCZay3TS5YeTsN0LqiPm5
         YDuBhTLoXDE302gSRVdc1GhAfURSaUFqWnYFHL57EEiJD3WwQKq6hIfpCf0AX0775O4l
         iwFLCrx+/7dEZWP14AK4iGYhu2hXDykdzZ4PH4i0T6CZUn/pczJMX3gxWLFgK6WiEWt2
         cUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712124034; x=1712728834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeN7BH7FX/UdYJqsptGEzUMzeVN4Ecw1to7ZT4gs+X4=;
        b=vQAQDFHs9qozwUR02n5ujWn0GQ9+S52yGJxDOOoKhy3ctelH6HCml6pId+ozWoax+E
         aIPLU6ZpsI6Ey2gUmWMWUn76M2MaRUiMkyzqzgkcP/xwElzkeYSAsxRSqegjoi1Kc6ah
         Ctv77+djeXF1a6tsWS4Hf6SNMreu8zkP5Z3SoJ3Wi7/gCWo1ImFm+9LPpiV/IqU2D007
         NgynnGFkzGXV6UJeXxKrF+1A/zxs8OOqEC3tSYkRY5oqerGjtUmKYIxe6iMZWDw3iBwg
         rM4QWFjceLdyECl268UAi7YB3VTHreZUJOCU1uUMdZOFpNQMuiyNNvhOYVr9pRNuy1aI
         Xskw==
X-Forwarded-Encrypted: i=1; AJvYcCVNzvh3vIo+BMzRIdL/ONa+76ahdA+ZmziXECtL8hguMK89ZBVR8BaGume0/TLW71sL0LNpyiiqic9XTfwSpgxjMTEWIP+OqtZIG9AM
X-Gm-Message-State: AOJu0Yw8u7S8cZls5FciQ86Q/xjIvpLatK/JXSRQNQQz+9A+OvZKkekJ
	sonE4Atv6p+uaQcIAsN0/JaTHj8y6gDBNMyGZnlF08WRs4b83IXX9opYQIHPAfvYPmre8pwphBF
	BxV4I/uJwvtj7k2sFJhtNJvTlcLfVPZqrHis=
X-Google-Smtp-Source: AGHT+IH3nsAv2UK8Wyq1ILIiH45zeQeBmtb0KjGWrkJbhttIj7144Jw4++Zu9fS38fYLtKpZCM5FPhBVeFQNBKARQ+Q=
X-Received: by 2002:a5d:5590:0:b0:341:b26f:8929 with SMTP id
 i16-20020a5d5590000000b00341b26f8929mr1083115wrv.37.1712124033796; Tue, 02
 Apr 2024 23:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707219895-31977-1-git-send-email-zhiguo.niu@unisoc.com> <ZgwnDnrLJUPyYKYW@google.com>
In-Reply-To: <ZgwnDnrLJUPyYKYW@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 3 Apr 2024 14:00:22 +0800
Message-ID: <CAHJ8P3L4oH25YMBkzpoZ0n2HwFBbFzt+seoZJkcy4_ZL5Ki5Xw@mail.gmail.com>
Subject: Re: [PATCH V4] lockdep: fix deadlock issue between lockdep and rcu
To: Carlos Llamas <cmllamas@google.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, bvanassche@acm.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, xuewen.yan@unisoc.com, 
	hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:41=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Tue, Feb 06, 2024 at 07:44:55PM +0800, Zhiguo Niu wrote:
> > There is a deadlock scenario between lockdep and rcu when
> > rcu nocb feature is enabled, just as following call stack:
> >
> >      rcuop/x
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFF817F2A8A80, val =3D ?)
> > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > -001|do_raw_spin_lock(lock =3D 0xFFFFFF817F2A8A80)
> > -002|__raw_spin_lock_irqsave(inline)
> > -002|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F2A8A80)
> > -003|wake_nocb_gp_defer(inline)
> > -003|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F30B680)
> > -004|__call_rcu_common(inline)
> > -004|call_rcu(head =3D 0xFFFFFFC082EECC28, func =3D ?)
> > -005|call_rcu_zapped(inline)
> > -005|free_zapped_rcu(ch =3D ?)// hold graph lock
> > -006|rcu_do_batch(rdp =3D 0xFFFFFF817F245680)
> > -007|nocb_cb_wait(inline)
> > -007|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F245680)
> > -008|kthread(_create =3D 0xFFFFFF80803122C0)
> > -009|ret_from_fork(asm)
> >
> >      rcuop/y
> > -000|queued_spin_lock_slowpath(lock =3D 0xFFFFFFC08291BBC8, val =3D 0)
> > -001|queued_spin_lock()
> > -001|lockdep_lock()
> > -001|graph_lock() // try to hold graph lock
> > -002|lookup_chain_cache_add()
> > -002|validate_chain()
> > -003|lock_acquire
> > -004|_raw_spin_lock_irqsave(lock =3D 0xFFFFFF817F211D80)
> > -005|lock_timer_base(inline)
> > -006|mod_timer(inline)
> > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > -006|__call_rcu_nocb_wake(rdp =3D 0xFFFFFF817F2A8680)
> > -007|__call_rcu_common(inline)
> > -007|call_rcu(head =3D 0xFFFFFFC0822E0B58, func =3D ?)
> > -008|call_rcu_hurry(inline)
> > -008|rcu_sync_call(inline)
> > -008|rcu_sync_func(rhp =3D 0xFFFFFFC0822E0B58)
> > -009|rcu_do_batch(rdp =3D 0xFFFFFF817F266680)
> > -010|nocb_cb_wait(inline)
> > -010|rcu_nocb_cb_kthread(arg =3D 0xFFFFFF817F266680)
> > -011|kthread(_create =3D 0xFFFFFF8080363740)
> > -012|ret_from_fork(asm)
> >
> > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> > This patch release the graph lock before lockdep call_rcu.
> >
> > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no lo=
nger in use")
> > Cc: <stable@vger.kernel.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > Reviewed-by: Carlos Llamas <cmllamas@google.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > ---
>
> This patch should be good to go. Maybe it just slipped through the
> cracks. Ingo, will you be taking this?

Hi Carlos,
Thanks for restoring this mail and now this patch can only be
temporarily included in my code locally when I do related jobs.
and hope someone can help merge it if there are no review suggestions.
>
> --
> Carlos Llamas

