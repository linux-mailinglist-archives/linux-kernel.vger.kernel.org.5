Return-Path: <linux-kernel+bounces-14596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B237821F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882EC282F38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366015ADC;
	Tue,  2 Jan 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SS/qOnf6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC115AD2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704212188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Knon/npUEvr/YqkVcJklmr7yzz7rrkbBClpFmvPvTKw=;
	b=SS/qOnf6FAEkkjkChy2pAlWfRaBM+y7n/4fgd9WqLp9Bqk12j5J5/Nrqawr100Lesg7N8a
	LvLVS7TTY3EaUA1Ep8raOaS2WSyzBiNV4ObMbPNewZMnUtUmi2L1iTSIhl5oo7TzZLGiz/
	JxNnffDehP0SJUUI7BmF1lFA9pFSBKI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-DNwb2Wj2OambHhcAJ14Lhg-1; Tue, 02 Jan 2024 11:16:27 -0500
X-MC-Unique: DNwb2Wj2OambHhcAJ14Lhg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7811c4af3c0so992754085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704212187; x=1704816987;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Knon/npUEvr/YqkVcJklmr7yzz7rrkbBClpFmvPvTKw=;
        b=WCdaM1l/R9dz+8XyevJT53u/mQJdrMDzoORHjOooXKfhWpfd6XUmcit2w6MbEmpp2F
         uBvz8h/EF7Q1Xwk9Oq2IzMd6z0yx9YJZV8xU0TbXkFEIqmuYboESJHEEgSNt/0l0bBgq
         kz4z8WuAhQ0LZHkfK7YchVb9jcRBIptNu9owc55LyxRhaDKYh4laIb1r4GtPpd02FFXg
         h1L2Rb44ilHrq/qTgZdkMH4np44fRUPNjsVCOS4LsB5xJTEBvjPnSfYLt/AS6hDPRtnZ
         HLivNLWfR2S8HdLjTZqm0V06VQVJj13ROct8NKXCh7L+ss88tKkYF+ySH6ZOb8n8FMeC
         Qkmw==
X-Gm-Message-State: AOJu0Yx21q9A/aK7wZs8rgeEJT2nml2TGVGi/2slGpWY6u2NShdEXvz0
	764vUOHsyQRdw3itdMkj6m2zHOtB/J72NrwTkF7s7fRD5P1H+F1/EzeZ4b1+pk+bFGUqKJtER6h
	+G95jrJgCmub5yd42WZEUAFsy5bR9AJJK
X-Received: by 2002:a05:620a:2096:b0:781:5d09:781 with SMTP id e22-20020a05620a209600b007815d090781mr8611077qka.76.1704212187029;
        Tue, 02 Jan 2024 08:16:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqDLzdZ96E/aljuEqqnRP9pA+RbYkrzgPPgGgCsT71/BiSOv6o1gSCSqDe+55v8cyFzzDwEw==
X-Received: by 2002:a05:620a:2096:b0:781:5d09:781 with SMTP id e22-20020a05620a209600b007815d090781mr8611060qka.76.1704212186813;
        Tue, 02 Jan 2024 08:16:26 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a258900b0078171447ee2sm4250130qko.68.2024.01.02.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:16:26 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 curuwang@tencent.com
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
In-Reply-To: <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
References: <20240102073351.1527503-1-alexs@kernel.org>
 <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
Date: Tue, 02 Jan 2024 17:16:22 +0100
Message-ID: <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/24 21:00, Alex Shi wrote:
> On Tue, Jan 2, 2024 at 6:19=E2=80=AFPM Valentin Schneider <vschneid@redha=
t.com> wrote:
>>
>> On 02/01/24 15:33, alexs@kernel.org wrote:
>> > From: Alex Shi <alexs@kernel.org>
>> >
>> > commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
>> > stopped the idle kthreads contribution to loadavg. Also task idle shou=
ld
>> > separated from blocked state too, otherwise we will get incorrect task
>> > blocking state from event tracing sched:sched_stat_blocked.
>> >
>>
>> Why is that incorrect? AFAICT we have mapped the (schedstat) 'blocked'
>> meaning to TASK_UNINTERRUPTIBLE. TASK_IDLE tasks don't contribute to
>> loadavg yes, but they are still in an UNINTERRUPTIBLE wait.
>
>
> Hi Valentin,
> Thanks a lot for the reply.
>
> I agree with you the current usage, but if so, we account for the idle ta=
sk into
> blocked state. And it's better to distinguish between idle and block.
>

Why is that an issue? If those tasks didn't have to be
TASK_UNINTERRUPTIBLE (via TASK_IDLE), we'd make them TASK_INTERRUPTIBLE and
they'd also inflate the 'sleeping' schedstat (rather than the 'blocked').

What problem are you facing with those tasks being flagged as blocked during
their wait?


