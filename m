Return-Path: <linux-kernel+bounces-9853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B79281CC61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08F1B22A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19600241E2;
	Fri, 22 Dec 2023 15:48:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD723753;
	Fri, 22 Dec 2023 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbb09061c0so352745a34.0;
        Fri, 22 Dec 2023 07:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703260096; x=1703864896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gYeD2yzGZwwurwvl8ayZlyc/Lt3sLmhRH2Kr42uCCE=;
        b=HBF8awl4dU14fkzmLaUuvqJJ9hk29nWIK0pcnN0RWnqPdPEadTUPrC+ykLLlBXh08t
         FiJ3RIJD5ECbvxwoshLomgnLB4pRUB45FZjpIkZ5Ko03agxBH6Lq99lol8YdXJJ+nJ9O
         njx3vPzeUxdQalqGp9SdGFyaHAPvEBWs5wTVRHSAaCaqv9VRLYefTaKPPR/fH5yV0mU5
         8pejvym7fHlMpN+vGzhun+4+YdEhcgSvvn/H6u+lJjuBcnpUlbsy6LbC1H3dK5FTP6d0
         di8umzgRAUTLsrGs05e4Cs9tWiU85MQaIutb3Yo8F7E3BdeiM6K4dzKOHBCIWAC1oJEt
         YepQ==
X-Gm-Message-State: AOJu0Yx9ynTEDx9XrlmrT6Kk7PPfoFcbyOCKd1t5xiVkNjKZKXQkV1WG
	o4KgndSPAxoj+7NilpT0ciNGB4FxgKNZL2Go5uYT7jVC
X-Google-Smtp-Source: AGHT+IE48QazkqSXBtIz6Uu1f9SlL9qrmY3QMpMuHy0FCkkm6auxMlTsi0Rwvm3HzEPvvm63otfp6H/10KD5XRe0tcs=
X-Received: by 2002:a4a:dcd1:0:b0:591:4861:6b02 with SMTP id
 h17-20020a4adcd1000000b0059148616b02mr2840210oou.1.1703260096485; Fri, 22 Dec
 2023 07:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219092539.3655172-1-daniel.lezcano@linaro.org>
 <CAJZ5v0j+F2uLauRqGZ1nvX3CsoA3+JXyzXFp5VtzvVTQTg6Yvw@mail.gmail.com> <fa8628c7-f49a-4226-b26e-ada31316b130@linaro.org>
In-Reply-To: <fa8628c7-f49a-4226-b26e-ada31316b130@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Dec 2023 16:48:05 +0100
Message-ID: <CAJZ5v0jXv1BHU_m_KebNfLt6ygPDZOnNp+aQk-cDESpDSdbSKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net, lukasz.luba@arm.com, 
	rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 4:03=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/12/2023 18:19, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> +struct cdev_value {
> >
> > I'm not sure about the name here.  I would rather call it cdev_record,
> > because it consists of two items, the id and the value.
> >
> >> +       struct list_head node;
> >> +       int id;
> >> +       u64 value;
> >
> > This is kind of a union, but sort of in disguise.
> >
> > Why not make it a union proper, that is
> >
> > struct cdev_record {
> >          struct list_head node;
> >          int id;
> >          union {
> >                  krime_t residency; /* for duration records */
> >                  u64 count; /* for occurrences records */
> >          } data;
> > };
> >
> > which then would result in a bit cleaner code in some places below, if
> > I'm not mistaken?
>
> Can we stick to
>
> struct cdev_record {
>           struct list_head node;
>           int id;
>           union {
>                   u64 residency_ms;  <----- ?
>                   u64 count;
>           };
> };
>
> ?
>
> The usage of the ktime_t will have a more important impact in the code.

OK, but patch [2/2] uses ktime_t for duration computations regarding
trip points.  I'm not sure why this is different.

