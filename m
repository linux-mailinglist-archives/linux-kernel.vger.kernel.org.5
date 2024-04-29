Return-Path: <linux-kernel+bounces-163119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809398B65FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3ECF1C215A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5F77624;
	Mon, 29 Apr 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enbfHYXn"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1A1E886;
	Mon, 29 Apr 2024 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431621; cv=none; b=o96EjoWBfCYptOSwkWqnt//hJyZiiTa/XJ+2bf0iGKEMHxHPeRsNOQ2sMbHvk/psFqWas/x20QCm1SKSlKEOSL7jgSEZKKNPhcthWRIVh9NwSd0aDWKLLK2CR7KSEDZpu+9VM5ghSCwmdPV5JansJTV4Mll4DAbhloPW1bIvCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431621; c=relaxed/simple;
	bh=dL0o/ufwJBiUqRbb02bZCxha9ZSzutJqJcs3mS4kp+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajtDMfR2/8wri7LP8dPmGKlZNGnlr6bqxOX+OqGHcLp08W+4XvokduCk/whzQvDgE6+P87KncKp1I+ImEWYnhvwerzs9dpdBQkM4fZxEkL/qqWnJWRimz5G2z5HdlqAfH6d+GE4saff9m/+2mbt7sCsgZH9yjqzwmG4wGBx5w2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enbfHYXn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6a0c3b691bfso782386d6.3;
        Mon, 29 Apr 2024 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714431618; x=1715036418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IxfdkyFt5OLCIS5OAJXlji6swH3nvqAQmnUqjM0TX4=;
        b=enbfHYXnyOnTNCccYJmmpRFp6uFyjA243AHy4XskE53WXTQo2tyoPSUvRZnwqvQ1jl
         aoCDUSY/jXKyKtrx0ROiJWJ2zI/apl3iaPZi2aYRpvEtNjqlEQj/PULEf1DSFMFxhKB7
         Vcj/Rq+Z7CQw9XpM/xR0IRhbx/KAWvd2F4dEhzvMGWDs/3ytPW3Mactsk39ue3DCX/Y+
         4733kUyeLLuPq4HAobfu7NnGAxHE+OK6tjNSla3tILnMWKuiH2JbGeRJASx6zyUy7RaC
         UUwfPwQ6QbDg8LnsrqDuebNklpVH5MJ60D731SriQKCj4l417d/VdFqO4T+f6Ot747nn
         AWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431618; x=1715036418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxfdkyFt5OLCIS5OAJXlji6swH3nvqAQmnUqjM0TX4=;
        b=oND4ADQbbvpY4F9QtnnBH81Kxea3ls8E5Y1xnsYUFUjaWhQF+rsm13ozD6Fn3kpaQL
         QAQLjP9ynr1q6PD5yr4TPaqZTWhby6fDyjm2o3QQB9bgD1o2fo6zcbXRR+pFjmNW5Grg
         cKbG0k0QN4l26CdLG0rJe81xhPutW7CCtce895T5dlAuzlZKWKuzS8IFYufdp5FemrXk
         ygnlbbyDOaVqxGRR2VoaEc78vN60r+mnofmizn9Gg5As0ASonEqRVcwgU7tvCTBVvI9E
         5rYvFXxJbGy4RlQidoKz2Tcr789H2/dVc+54bSxG0zuv17I7EMT6YnmtDAXEWqdiauUo
         RNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUgKpCOj9sxVMfqz1YhEgtpm/kzhfppz6qjBZNfkBu06K0R0lZ2An62kbc6x60rLTANPTWJvgBFAPHXSRdDnQbJxe7vTTMtkktt1Io=
X-Gm-Message-State: AOJu0YyZ+yqBxWboClRCf5i9G0ayNspI0yFk9Zqyu+g0W0gh/UDL3BzA
	LF7clbo0AFeIReegD4Ozgw4gdMmpJhkgvMNCxsgH5qmfzVn0MuFQ1uLdzEsmQX36tSwXtfuFNFp
	6HB2VkVwd92MnKxr8NLwIrLPRIDXinHeQN9uTi8F9
X-Google-Smtp-Source: AGHT+IEbjAosZC96d/RanqA+wzMVaXf7eMoXt3QgxJ9NiYNBKA7eEMc7GzluIcM0vbIdj53OskB+0EmZKREdPwd3iCU=
X-Received: by 2002:ad4:4a70:0:b0:6a0:a98a:487b with SMTP id
 cn16-20020ad44a70000000b006a0a98a487bmr12731802qvb.2.1714431618334; Mon, 29
 Apr 2024 16:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de> <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
 <87h6glt9zc.wl-tiwai@suse.de> <CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
 <a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
 <CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
 <CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
 <87pluedgx5.wl-tiwai@suse.de> <87jzkmdghh.wl-tiwai@suse.de>
In-Reply-To: <87jzkmdghh.wl-tiwai@suse.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 30 Apr 2024 04:00:07 +0500
Message-ID: <CABXGCsP-e5CjqCFztiym=zjQ=Z00uxYcQPFACEbTwjV=BHEdJQ@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:42=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> That said, maybe the first thing you can try would be to check who is
> actually calling the corresponding function
> (snd_timer_close_locked()).  Put a debug print or a tracing hook to
> watch out for figuring out.  If the commit was really relevant, it
> must be called very frequently and concurrently, and I don't know
> really who does it except for dmix/dsnoop.
>

It's madness.
Yes I added printk to snd_timer_close_locked and saw that function
invoked only 3 times when the system booted.
And never invoked during benchmark.

> git diff
diff --git a/Makefile b/Makefile
index 40fb2ca6fe4c..3ecff79a23b8 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION =3D 6
 PATCHLEVEL =3D 9
 SUBLEVEL =3D 0
-EXTRAVERSION =3D -rc6
+EXTRAVERSION =3D -rc6-test-build
 NAME =3D Hurr durr I'ma ninja sloth

 # *DOCUMENTATION*
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 4d2ee99c12a3..59d8e4698b0b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -407,7 +407,7 @@ static void snd_timer_close_locked(struct
snd_timer_instance *timeri,
                                   struct device **card_devp_to_put)
 {
        struct snd_timer *timer =3D timeri->timer;
-
+       printk(KERN_ALERT "DEBUG: Passed %s %d \n",__FUNCTION__,__LINE__);
        if (timer) {
                guard(spinlock_irq)(&timer->lock);
                timeri->flags |=3D SNDRV_TIMER_IFLG_DEAD;

[Tue Apr 30 03:33:25 2024] igc 0000:0a:00.0 eno1: NIC Link is Up 1000
Mbps Full Duplex, Flow Control: RX/TX
[Tue Apr 30 03:33:33 2024] rfkill: input handler disabled
[Tue Apr 30 03:33:36 2024] DEBUG: Passed snd_timer_close_locked 410
[Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM TTY layer initialized
[Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM socket layer initialized
[Tue Apr 30 03:33:36 2024] Bluetooth: RFCOMM ver 1.11
[Tue Apr 30 03:33:51 2024] systemd-journald[949]:
/var/log/journal/1b6a399fb0874de8b095a739fe2ff323/user-1000.journal:
Journal file uses a different sequence number ID, rotating.
[Tue Apr 30 03:33:52 2024] rfkill: input handler enabled
[Tue Apr 30 03:33:55 2024] DEBUG: Passed snd_timer_close_locked 410
[Tue Apr 30 03:33:55 2024] rfkill: input handler disabled
[Tue Apr 30 03:33:57 2024] input: solaar-keyboard as
/devices/virtual/input/input18
[Tue Apr 30 03:34:08 2024] DEBUG: Passed snd_timer_close_locked 410
[Tue Apr 30 03:34:11 2024] input: Noble FoKus Mystique (AVRCP) as
/devices/virtual/input/input19
[Tue Apr 30 03:34:23 2024] show_signal: 8 callbacks suppressed
[Tue Apr 30 03:34:23 2024] traps: gldriverquery[4464] general
protection fault ip:7ff83958c76f sp:7ffc464e0e00 error:0 in
libLLVM.so.18.1[7ff83920c000+3afd000]
[Tue Apr 30 03:34:25 2024] workqueue: gc_worker [nf_conntrack] hogged
CPU for >10000us 5 times, consider switching to WQ_UNBOUND
[Tue Apr 30 03:34:26 2024] workqueue: gc_worker [nf_conntrack] hogged
CPU for >10000us 7 times, consider switching to WQ_UNBOUND
[Tue Apr 30 03:35:27 2024] workqueue: gc_worker [nf_conntrack] hogged
CPU for >10000us 11 times, consider switching to WQ_UNBOUND
[Tue Apr 30 03:36:28 2024] workqueue: gc_worker [nf_conntrack] hogged
CPU for >10000us 19 times, consider switching to WQ_UNBOUND
[Tue Apr 30 03:39:33 2024] workqueue: gc_worker [nf_conntrack] hogged
CPU for >10000us 35 times, consider switching to WQ_UNBOUND

I saw a similar picture with ftrace.
I had no experience with ftrace, so I am laying out everything here
for you to see if I am doing something wrong or not.

# echo "snd_timer_close_locked" > /sys/kernel/tracing/set_ftrace_filter

# echo "function" > /sys/kernel/tracing/current_tracer

# echo 1 > /sys/kernel/tracing/tracing_on

/*  Benchmark the game here  */

# echo 0 > /sys/kernel/tracing/tracing_on

# cat /sys/kernel/tracing/trace
# tracer: function
#
# entries-in-buffer/entries-written: 0/0   #P:32
#
#                                _-----=3D> irqs-off/BH-disabled
#                               / _----=3D> need-resched
#                              | / _---=3D> hardirq/softirq
#                              || / _--=3D> preempt-depth
#                              ||| / _-=3D> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |

# cat /sys/kernel/tracing/set_ftrace_filter
snd_timer_close_locked [snd_timer]

Now I am tormented by the question: how can reverting code that is not
invoked directly during a benchmark affect the benchmark result so
much?
I'm afraid that I won't be able to figure this out on my own.

--=20
Best Regards,
Mike Gavrilov.

