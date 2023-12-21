Return-Path: <linux-kernel+bounces-8812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F281BC93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F301C2496C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4135822D;
	Thu, 21 Dec 2023 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVDRxIC2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA8627E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so15940a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703178355; x=1703783155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+iAuPIe0Ha0Wx+VX2L2grmFHyIC2YpAns6Hg50Y4nI=;
        b=nVDRxIC2WsQbMOguobUX+4Z4NewZUPxUuV2ssw1SenMD3ul2w20k9/6+ipcB65bGwo
         5Goz6kh8NPxm752tdmRgwmirwTaw0RDvW2ZGPkPL/pQ4Wpjta07WEK7On+BhqRJ52+cX
         ks5RYRwtAnO7UDMe47HavV50D0h7O7k0wQbZWG7rI9/YWsyUE/mgeitbRpuQv8c9QyRg
         l8kwUcPlFo9li5iz6mRV+4yf4/F3+vEj6T8EEVLc75s9S/+MwgKbmw9Z50vlOBxQpqir
         PhycWi5G2rqIojyG4ubSmfWCGDDF8W1zMpJt/WxnjOu6fs03SP+2OYlIkfk9gKLD5xVa
         mHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178355; x=1703783155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+iAuPIe0Ha0Wx+VX2L2grmFHyIC2YpAns6Hg50Y4nI=;
        b=NU/StspofYUE2+gnEJRF77U+t520vb0ivoT2jusWh8x8s2m3ghsuZTENcv95cT6FT8
         JJchIXMK/447LhA60brlbHSygM56Sa5uhSj7kcrXeP5MRuZWQHcgKPicxkgbNmbsgq7z
         9OqxFrqZBglYRtg059MrB6rkmOswOslcXywNTswR8IPG5J3s/SCMEBeNSVNDdCvCIK2T
         kHs78WoiKUbaAGO9BzsGA8TuEJyAD0x0bSwGvlcw/dYKC3Li4HxeMfIxn+fcNcyzqSQ3
         znH6ZSHbFLfIPT//6rzawibbPNJKO3HvuVww3zVXqhKm9GFpEGGSXtTjfHAHf8jvQMBx
         MC4Q==
X-Gm-Message-State: AOJu0YzrfyHmoDi5glg+torhYttY6AtSOghKFH2sMXQoI/gBJk0rw0Ee
	SXI/YxqOu83zyNcHRSy+d0v5Rl+DfHMsbnjVNU7hbXs14kA=
X-Google-Smtp-Source: AGHT+IGA+rQc1lGTBBpmqD15O0mUa3Pbuh+TFdkZe9WRua8VzEZUNkfvCHVJOC4QAV+zAXbgy9vNeRf50jwHPoayxa0=
X-Received: by 2002:a50:d69c:0:b0:553:d734:3f5a with SMTP id
 r28-20020a50d69c000000b00553d7343f5amr116829edi.4.1703178354836; Thu, 21 Dec
 2023 09:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-7-jstultz@google.com>
 <155363f0-26f5-4946-a36e-ee68b5887e60@infradead.org>
In-Reply-To: <155363f0-26f5-4946-a36e-ee68b5887e60@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Dec 2023 09:05:42 -0800
Message-ID: <CANDhNCq4ENTQfhKZvJp+=2rx2hgPekPd8=MEL92ipcGEDiwiCw@mail.gmail.com>
Subject: Re: [PATCH v7 06/23] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:04=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> On 12/19/23 16:18, John Stultz wrote:
> > Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
> > sched_prox_exec=3D that can be used to disable the feature at boot
>
>   sched_proxy_exec=3D
>

Ah, thank you for your careful review! I applied all your suggestions!
thanks
-john

