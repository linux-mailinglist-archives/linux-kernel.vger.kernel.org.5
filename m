Return-Path: <linux-kernel+bounces-8661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA681BABB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A20028D551
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E353A1E;
	Thu, 21 Dec 2023 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAQK00WN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8C539F9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bc870c540so724910a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172402; x=1703777202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dC5SYh5wvDuLRLTzz+EBxLcN+RV8t/MMdts61ZKTGpM=;
        b=gAQK00WNHcA8r+I0bj28Kz7rqnbPcfUT2GYgmb8LDByRdUPvO4czgORZRb8uiIkkdG
         0+25qmmcpCNL9I1EbR4sYjFNYjCNvaso+AFRRMREnT0SuowObLh7L5fG15dNNz0oHIDr
         MBQmBtor2ncMs5EMj7pF4Z01S+MBRQGtgKpNMZmjQnW+Sbzcf9A2XZPdB7df0HN1YAvr
         aY3joIDG+Tnx8BNCIQiaNFXEY+fhR55GKrB8sNpVLyd84PacoM9eahV90nue/77pniL3
         0o3WvIkRBtDaISBtawSeRapTRTgkxuRR6kxx3ZoT/CDA9pe3CXhrfdbnkXqjnk9/MHaQ
         EpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172402; x=1703777202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC5SYh5wvDuLRLTzz+EBxLcN+RV8t/MMdts61ZKTGpM=;
        b=fd5IjA4zLSd4OMEkax2uKv1K0PbO/CuhKer/QOdx8Fm1ui7bPtYkoE4yt2jdAQ0iCL
         HxvwN6cjMipTtJU3LnIsClpFp/uSN/JXB4KvdmGAUviFPNYgtDWOF09QqDOaI8Htrpy/
         HO7C7II7xRxTUg6v3jBCPgyoicrIXPhwVI+DmHrqhWwD0ELCoYuSPl7Wq2ORu+HNxfuH
         8h5tUh3a8DvhvWhiIsP2Dzbrjmihhv/knG8sRLEXMhoq2ztDbbA8oJ6eL3DteX9dP45z
         LYJ1pfihzYHPD/elkSLnvpqeHUckbG7rhvKuKJ3Ze6zpsN4Hr4ntEEkv617qWGy3cI0Q
         MZ3g==
X-Gm-Message-State: AOJu0YzvqdQgfOpXPj7BlHejPYgstw49bk9hOoOBOEO0vt+nJCEpbmWr
	EW3IeRKkZy4EBHYmWW4mJ386e2x8lBSAQEZdii9MPA==
X-Google-Smtp-Source: AGHT+IGmod8PxPFs6GtLGlc1ip28xbRCud5bvi34qmO5VlkGOnVt8UR2EPlFRqRpX/09QQQYU5oP5AUdyh4JCBlfl/U=
X-Received: by 2002:a17:90a:5408:b0:28b:cbec:2f4a with SMTP id
 z8-20020a17090a540800b0028bcbec2f4amr2327195pjh.15.1703172401946; Thu, 21 Dec
 2023 07:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
 <d8507f86-2458-4b01-a774-5102473e657e@oracle.com> <1c13b0cc-098c-4f75-9f37-a53a66965409@oracle.com>
 <CAKfTPtDqqAYNCFb6US-4Yd=-xvj8mhMuO0PkUhWsqekxp__M4g@mail.gmail.com>
 <a9993f8b-6449-4452-a168-db966d9bae49@oracle.com> <CAKfTPtD1Q7R0ySc=a_5Aw9M0McQiom80DWEB6FRv7vYoPRVebg@mail.gmail.com>
 <20231221082105.GA600162@ziqianlu-desk2>
In-Reply-To: <20231221082105.GA600162@ziqianlu-desk2>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 Dec 2023 16:26:30 +0100
Message-ID: <CAKfTPtDP6FXKa0ifpXd+jh5DBBBXmz7CcgaB7w8R5in1iQbTiw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
To: Aaron Lu <aaron.lu@intel.com>
Cc: Imran Khan <imran.f.khan@oracle.com>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Aaron,

On Thu, 21 Dec 2023 at 09:21, Aaron Lu <aaron.lu@intel.com> wrote:
>
> Hi Vincent,
>
> Thanks for the heads up.
>
> On Wed, Dec 20, 2023 at 06:31:08PM +0100, Vincent Guittot wrote:
> > Aaron,
> > Could you run the tests that you run for testing "Ratelimit update to
> > tg->load_avg" and check if this patch impacts your performance ?
>
> I run hackbench/netperf/postgres_sysbench with nr_thread=nr_cpu on a 2
> sockets/120cores/240cpus Intel server and didn't notice any performance
> change after applying your diff so I think it's not a problem.

Thanks for the tests.

I'm going to prepare a proper patch

>
> Regards,
> Aaron

