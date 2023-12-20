Return-Path: <linux-kernel+bounces-7145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6381A22F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB328870E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A273FE44;
	Wed, 20 Dec 2023 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJCfN46G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB893FB33
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77f5b3fa323so369987485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085518; x=1703690318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoXHOZhoklkeSWNJlzLRFgk2cePKxMMAtNjLJkIi/A8=;
        b=QJCfN46GqHaUH/Rgpx/fzqCXPvGGnbS20x7yhgi4KCy5jiJb62isGqJCj5zviEbNlN
         T2iIRQ8uooNHqG484SBbk60qmZmbnSoiNoGU3bcYtLWocPdUSA9OVH9Br5zY2QHhz0jI
         P7fJp9QNx5/qdJ+jUcTybUDfiSWomtTQ6p4fi+lvlyvyNt+BXYT0tvPFcrrLQHRoARz/
         NRmJ2bUtDJhswzcMLGtUA88jBN7WZCsAKk6GshDxhgZ/e6o8+jZ2UGc4YPRj22wKi8lm
         gNjqOSzAznfhDNy6Zb22W3fYUyPGgHaJ33bik+lhb1BS1m2E/mh5lsUAffgY0LsHM9Km
         5T7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085518; x=1703690318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoXHOZhoklkeSWNJlzLRFgk2cePKxMMAtNjLJkIi/A8=;
        b=Muv9G8rOqEg51jbPKfPvueWdZ7tDaC8z+IBCaIZSMoBDZ5Sf837fqY27+qxFyHEUyy
         4VcWeRzyVtDRdN0lDjvkr3wq24z7c4DseE485RcrYSZdiLnMXkyxmI/IiDTFj1BV9BiA
         /6ptzQQszEYfhfrG8upZZgSRzCMKkBQyGX74XlGJsDlNlM6igoaVKZ5GbObvrZWTuie9
         dLkuKXT/I0mp76I+0XMfcARWecpUM7DpQUXssBeFQaFWRfh3FaTajn7fG5VG1GqSq48A
         h7sNXWxo35GzmU70zp+JTzKrkufM4OHfmJJuCxdepUKa359TaLtCr2dRUqFqi4/GnoKF
         oV1g==
X-Gm-Message-State: AOJu0YxlmP7ooa4ZgS5VyP/0mSw2b9fg3lJt+oecwpPtEN1zNsIbX7t6
	aND6mNnxMJ+C+wSKAweBYNoFr2INS1HarSiSREs=
X-Google-Smtp-Source: AGHT+IEN8RDDPtaShOXe8A12ppAg1EnNAjzZfeAX9fEE+wUTARgaDM4daLLt3dallb7uwNr3CSC7b/ayFh2a8C1SlJg=
X-Received: by 2002:a05:6214:2426:b0:67f:61ff:c7a1 with SMTP id
 gy6-20020a056214242600b0067f61ffc7a1mr3118125qvb.9.1703085517708; Wed, 20 Dec
 2023 07:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220140112.821992-1-wudaemon@163.com> <20231220143249.833273-1-wudaemon@163.com>
In-Reply-To: <20231220143249.833273-1-wudaemon@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 20 Dec 2023 23:18:01 +0800
Message-ID: <CALOAHbAXdRbX9Wbn8qpH5eFUKcju4Ahb+VjMx=JjJL=cVox5tg@mail.gmail.com>
Subject: Re: [PATCH v1] sched/rt: Fix rt task's sched latency statistics error
 in sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>
Cc: bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:33=E2=80=AFPM Junwen Wu <wudaemon@163.com> wrote=
:
>
> >>I think we'd better use if (!on_rt_rq(rt_se))
> >>
> >> +               update_stats_wait_end_rt(rt_rq, rt_se);
> >>
> hi, Yafang.when execute update_stats_dequeue_rt, rt_se->on_rq is still 0,=
 util dequeue_rt_stack,
> the method is not effect.

Ah, you are right.

> I this we can use if (p && p !=3D rq->curr) /*Mark the end of the wait pe=
riod if dequeueing task*/

Agreed.

> because schedstats is not supported for rt group,we only need to update r=
t_se that is realy task.
> --
> Best regards
>


--=20
Regards
Yafang

