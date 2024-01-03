Return-Path: <linux-kernel+bounces-15623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66E822EFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C081F2462D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC01A5A2;
	Wed,  3 Jan 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJrjbBo8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4C1A59D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704290201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hCkb20O6J2xDi0YbNHzIX9GPZtKCzLI0mpamAv6ItgE=;
	b=MJrjbBo8/xay8HA3MB0xXQLDTYAKGkJGAoa819wWFPBbPnZOQAJ3jd69J7QswI2TTa6mpE
	snRU9pjlTQoG+HkMgxKrx/NUlH0rCyI4ir3bWMJ2OU49EgxYKP/AuzeXO6ndHFWqa0UQwd
	DyQ4AHAsPdfkO1jacXwsPOsKXTde5h4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-xHKxYaBaNkOx6zpXnVrJxA-1; Wed, 03 Jan 2024 08:56:40 -0500
X-MC-Unique: xHKxYaBaNkOx6zpXnVrJxA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-336937af9e9so312937f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290197; x=1704894997;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCkb20O6J2xDi0YbNHzIX9GPZtKCzLI0mpamAv6ItgE=;
        b=ECuGk2aZwe3VtPVIs1rF3iri5/H41To/5AA+wfSLhzdFOBda3mwRV+penS8fxmtez6
         FrNnmDtQoq1807tZ3+c2E10hMkuHlL+VPdFJd6tb3k1qGLjeGIU75+cptzfidcKjUj9x
         F7cmlnHSabqn58hwDL5Aml10a/VPW6V0+3Zd39KKDm3FGfZqp/WMhks4ISHc/SGmBeQg
         1HXO1C53XL87H7yZDzFzx3y/jne/OHAVwVd/AhvfnXiPivCDhbMwawU45T3jNoogPfvm
         o8pI61U+zIksDRkVZS8fPTK9BnfzOkLcbdHJDm/zyLOulTzDsiroz9kZCmD20ENDI3RP
         mmxg==
X-Gm-Message-State: AOJu0YxKqmGrqfd7AHfJn6hDlhq4AfnxvmegHmdwPLF9pMNCPnOm4U2M
	iUR8EMvYDENIXZOL2gWTOPjj14Sf0WMWrataH7+H4eoRk1KPzovyNOptRCBBcF2ryaNXm988nHZ
	I0r1oxZtNV7sCx7S5eYCybhR5mhDVq2Lg5grCvlBW
X-Received: by 2002:a05:6000:d91:b0:336:d24d:3c76 with SMTP id dv17-20020a0560000d9100b00336d24d3c76mr461740wrb.28.1704290197582;
        Wed, 03 Jan 2024 05:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWXd+Cr5ICnHNHPN5feEnvtAS4tbmJEsb00X2uIR7GEL+1NW1b3PcV/IOXHPSzwnNEX72Jxg==
X-Received: by 2002:a05:6000:d91:b0:336:d24d:3c76 with SMTP id dv17-20020a0560000d9100b00336d24d3c76mr461726wrb.28.1704290197297;
        Wed, 03 Jan 2024 05:56:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b003368849129dsm30018195wrx.15.2024.01.03.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:56:36 -0800 (PST)
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
In-Reply-To: <CAJy-AmkG+6jZCGFBnqA_33NtBBq_hjemqkPCbZX2Jty0KWQE+w@mail.gmail.com>
References: <20240102073351.1527503-1-alexs@kernel.org>
 <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-Am=R=gRFqSdGjXaMqq7Yetpp-4=bLtnP-87GepN4zff5Tg@mail.gmail.com>
 <xhsmhjzork8x5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJy-AmkG+6jZCGFBnqA_33NtBBq_hjemqkPCbZX2Jty0KWQE+w@mail.gmail.com>
Date: Wed, 03 Jan 2024 14:56:36 +0100
Message-ID: <xhsmhbka2jzaj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/24 11:14, Alex Shi wrote:
> On Wed, Jan 3, 2024 at 12:16=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
>>
>> Why is that an issue? If those tasks didn't have to be
>> TASK_UNINTERRUPTIBLE (via TASK_IDLE), we'd make them TASK_INTERRUPTIBLE =
and
>> they'd also inflate the 'sleeping' schedstat (rather than the 'blocked').
>>
>> What problem are you facing with those tasks being flagged as blocked du=
ring
>> their wait?
>>
>
> Uh, Tencent cloud has some latency sensitive services, a blocked state
> means the service has
>  some trouble, but with IDLE state involved, it's failed on this judgemen=
t.
> and 2nd, if a service has abnormal, we want to check if it's hanging
> on io or sth else, but the top
> 3 D tasks are often queuework in our system, and even a task in
> blocked state we have no
> quick way to figure out if it's IDLE or BLOCKED.  2 different states
> will help us a lot.
>

That's useful information - generally it's good to add the motivation for a
patch in the changelog.

> Thanks!


