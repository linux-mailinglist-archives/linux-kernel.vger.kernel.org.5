Return-Path: <linux-kernel+bounces-104009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2E87C7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20500282C08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903CD502;
	Fri, 15 Mar 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STmtrxgr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FDC8CE;
	Fri, 15 Mar 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472382; cv=none; b=KvbLK9jmeJ9wHUTPFb0in94wNhN82CXllAawR1INo1kIL1ZjblYj1klZ1EvyhcXSDiRKWvRp9NEzyb6+/JOTyykkxCMqoDpKVhryASfZ7iJRqUKQHMI4Enhibs98JUPq9S72XbLq3EA2xXOz1fWuoZKSBNrApTmy1dT5MBFNp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472382; c=relaxed/simple;
	bh=6Yb7+xjwm7WRruf1nQs5LCpC+Q4WmT4H87mklhR2l2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRTpMIXpa0pSOOCXpDJPYhxZws/r4UpeLXzz7TGj98vwWJ/3XgFMNdbfwINak0D3pNgmKmAIgCbYOY4aHz7sDJ69n6e7rZiVLhR+7+7z/1ySHYagbbBfiCyJ/Xo5o7odqADdJBcW5EtjlyPF7/yGQs6ne3pabktDNyyM342DbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STmtrxgr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso21021691fa.2;
        Thu, 14 Mar 2024 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710472378; x=1711077178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYcy0J8PSztc7k2XFd3mh/aku8qxOF9wv2BXkd4V6aQ=;
        b=STmtrxgrGaac3AdPZ7MyG3YPR+2ed6PZy2LLtImKJfJP8F2o0X0UDi9iiAKPxIy8Ho
         PLpQR8Gl0Dk/LnZxAq9zDN16rzEaT21aS9bDL+YyVYNBQ47gLDjU4AVQtzQhU2dmQ6ne
         4hOqzGMREHRkYg9230S35pOFVck1Oj6VHbQHqGZsWa4b1KWjUN5QSMITE1LxSPPcd8IB
         nkY7TUAdRjqqlX7ZmNcrypVWgiu/bAN+DN9c5hWpHSNf5mEaov8y1igmn7Aw0lIuK5+Z
         1K2otk4q9syMZOf+4yykVri4i9GSpukQMDWRiNHV0DmSuiy/qZ4lsHYlOA9OL6mvnKnv
         HlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710472378; x=1711077178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYcy0J8PSztc7k2XFd3mh/aku8qxOF9wv2BXkd4V6aQ=;
        b=oCOFRQSbLJPEnAhTsBAgbYJ7JqUMsgF8RwcUSpOMtkvxIS19gg6GoHphMA1irN/yzY
         RGlR2cjlsSUsZ7i0mQeaQ/qcFls64q8n7E32899sa+IqLpSebb0UKMbZ6+BGYAr67HxE
         Mgv6X+0IopLKxf3ubUIJF2jBleVSKLqFCyiyPu+M1JzB49DQBR1WPRh6wp6RpQnpSMA/
         ywwkTHL86tA3o0UsqADVNO1STC1NNxsZ+oCNRUi3XYH7jITVLVgeE3XSoMGQGQfr8m+i
         mXWFM5EjxrUa2OXWCWV2u4PDtAzAldfhTA1TfJ4SANEka4TTgrOpoZ2ZogIuQzdR5IYG
         uZng==
X-Forwarded-Encrypted: i=1; AJvYcCXwubiByhJPiCw1a+ViubIPCIg85eaXfa/pVbf9tqQYSsyUUeuNmnC/HVyw7R0w9T2lAhQL71tTFU7BSs0GlNUOib2AxkJt6czWaU1lPx775dIbSzdxr+61AodtDuyJlEHpVqexwiFlqn1ga5Z8
X-Gm-Message-State: AOJu0YyPVAsFXQBa1fpckpkaErwPp+mpgKzTF7MvCyekQO+fJ+BHnh7g
	nqb4sWUfrROUzotTg4zLNxyuu0nT/jsFc+h7UV9f7H+SxbrIl3U2JFk5WJP2TnaPlm1quSvWjcl
	bMf7T2e25dG72Kij3fZ1pAT7xUKw=
X-Google-Smtp-Source: AGHT+IEoULc6Y/PBF6qRcT3RuchXEvqup3cR2JPlxj7uTufH1REVIuR1YviMgbfOx0wPhey2Ox0Rpd+sFUZoN9Rf3I4=
X-Received: by 2002:a2e:a792:0:b0:2d4:6c43:dfdf with SMTP id
 c18-20020a2ea792000000b002d46c43dfdfmr1367526ljf.2.1710472378134; Thu, 14 Mar
 2024 20:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB7084FCAF74B4CFA30D386B698A2A2@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <87cyrxm7ua.ffs@tglx> <CAAfh-jOu0hG1hfWX9kL_gOXkSLXEVGNkddP-azO=pjNAKsRGhA@mail.gmail.com>
 <877ci5m3c4.ffs@tglx>
In-Reply-To: <877ci5m3c4.ffs@tglx>
From: Enlin Mu <enlinmu@gmail.com>
Date: Fri, 15 Mar 2024 11:12:31 +0800
Message-ID: <CAAfh-jM6TSbFHUYCi0kC7JgszCaz=-So7+=at-aDfTSrOPjraQ@mail.gmail.com>
Subject: Re: [PATCH] hrtimer:Add get_hrtimer_cpu_base()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Enlin Mu <enlin.mu@outlook.com>, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 19:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 14 2024 at 18:45, Enlin Mu wrote:
> > Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:22=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Wed, Mar 13 2024 at 05:30, Enlin Mu wrote:
> >> > From: Enlin Mu <enlin.mu@unisoc.com>
> >> >
> >> > On the Arm platform,arch_timer may occur irq strom,
> >> > By using the next_timer of hrtimer_cpu_base, it is
> >> > possible to quickly locate abnormal timers.
> >> > As it is an out of tree modules,the function needs
> >> > to be exproted.
> >>
> >> No. We are not exporting for out of tree code.
> > Can you explain it?
>
> Exporting functions or variables requires an in tree usecase.
>

OK, Thanks, I  got it.

If  this pathc is following(exprot hrtimer_bases):
---
 include/linux/hrtimer.h     | 1 +
 kernel/time/hrtimer.c       | 1 +
 kernel/time/tick-internal.h | 1 -
 kernel/time/timer_list.c    | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2a37d2a8e808..259462ad6e4a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -278,6 +278,7 @@ static inline void hrtimer_start(struct hrtimer
*timer, ktime_t tim,
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
 extern struct hrtimer_cpu_base *get_hrtimer_cpu_base(int cpu);
+DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);

 static inline void hrtimer_start_expires(struct hrtimer *timer,
                                         enum hrtimer_mode mode)
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f7cf7d48b91d..49024d07c61b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -113,6 +113,7 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
=3D
                },
        }
 };
+EXPORT_PER_CPU_SYMBOL(hrtimer_bases);

 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] =3D {
        /* Make sure we catch unsupported clockids */
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bd..f649d3509060 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -175,7 +175,6 @@ static inline void timers_update_nohz(void) { }
 #define tick_nohz_active (0)
 #endif

-DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);

 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)=
;
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da50..877b9130cd64 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -14,6 +14,7 @@
 #include <linux/nmi.h>

 #include <linux/uaccess.h>
+#include <linux/hrtimer.h>

 #include "tick-internal.h"

--

Please review and comment.
Thanks.

