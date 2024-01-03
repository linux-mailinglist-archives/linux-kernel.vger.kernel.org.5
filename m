Return-Path: <linux-kernel+bounces-15702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4482309B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277E81C2378B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D0D1B271;
	Wed,  3 Jan 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjFlJBc9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C91A731;
	Wed,  3 Jan 2024 15:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687F6C433CA;
	Wed,  3 Jan 2024 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704295994;
	bh=ylV0o20b8JZnTMZTGmAwoeArfi4QzOCuKZgDMqvoNJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TjFlJBc9PW4t3SSg0jjMYnP7ZBZ3NSK4uPJB6zJdetNcshf9E2pzqIfC7LlJDA646
	 nV188Fh81QBrP8XDzvxrLw4OviIkBO9S3veJ5mMD3tqFxy5ytUnn75DMyb6FQ6l7eu
	 K7V8Am9mxJskpu73cjU118pYVg+aiYjKwDx/HhyjJzEGN8b+BXD2PRYRtRt4JZAWev
	 WxOGjcrP8z6gyjsEQZVxtG2H/4MXauh31rItYgZx4Cf3Y6l6Z27d7nIkXrKKZCVfU1
	 zDw9e8mIAWUvV5WWbCawodLQ9WXHWDqggu26mMQgfIIeBUqHmPZ1Y8B3volvhOBd9h
	 /MevTp/qY7GtA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso99906301fa.3;
        Wed, 03 Jan 2024 07:33:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxD10vMHtmYL6rpGZCEidoRwa5l19RI10S+Oa6rSMX/28CAh4t8
	kNy3dfFdQWeXZ677OpWqfkL3yckLBoRb5Juryg==
X-Google-Smtp-Source: AGHT+IFY4GnGd+1pQoF79cjtNS5BvmCCQuzDPJObkUNFyaUTHvNX115fyF8pTF9dfszP7xouROLJ/yirOlqMNnu2Yn8=
X-Received: by 2002:a05:651c:11d3:b0:2cc:eae4:b3f6 with SMTP id
 z19-20020a05651c11d300b002cceae4b3f6mr4041154ljo.44.1704295992630; Wed, 03
 Jan 2024 07:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
 <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com> <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
In-Reply-To: <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jan 2024 08:32:56 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKYuqKxokDzs3xVWqYZoFfyMwMrLd17DpfCO_x7CXvRZw@mail.gmail.com>
Message-ID: <CAL_JsqKYuqKxokDzs3xVWqYZoFfyMwMrLd17DpfCO_x7CXvRZw@mail.gmail.com>
Subject: Re: [PATCH] coresight: Add coresight name support
To: Mike Leach <mike.leach@linaro.org>, Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: James Clark <james.clark@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Tingwei Zhang <quic_tingweiz@quicinc.com>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, 
	Tao Zhang <quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 5:05=E2=80=AFAM Mike Leach <mike.leach@linaro.org> w=
rote:
>
> As James mentions this is clearly a V2 of a previous patch - please
> mark as such in future.
>
> Adding to what James has already said:-
>
> 1) Mapping between the canonical names used in the drivers and the
> information as to the precise device is as easy as running 'ls' on
> /sys/bus/coresight/devices:-
>
> root@linaro-developer:/home/linaro/cs-mods# ls -al /sys/bus/coresight/dev=
ices/
> total 0
> drwxr-xr-x 2 root root 0 Jan  2 11:27 .
> drwxr-xr-x 4 root root 0 Jan  2 11:27 ..
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu0 ->
> ../../../devices/platform/soc@0/858000.cti/cti_cpu0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu1 ->
> ../../../devices/platform/soc@0/859000.cti/cti_cpu1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu2 ->
> ../../../devices/platform/soc@0/85a000.cti/cti_cpu2
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu3 ->
> ../../../devices/platform/soc@0/85b000.cti/cti_cpu3
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys0 ->
> ../../../devices/platform/soc@0/810000.cti/cti_sys0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys1 ->
> ../../../devices/platform/soc@0/811000.cti/cti_sys1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm0 ->
> ../../../devices/platform/soc@0/85c000.etm/etm0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm1 ->
> ../../../devices/platform/soc@0/85d000.etm/etm1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm2 ->
> ../../../devices/platform/soc@0/85e000.etm/etm2
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm3 ->
> ../../../devices/platform/soc@0/85f000.etm/etm3
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel0 ->
> ../../../devices/platform/soc@0/821000.funnel/funnel0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel1 ->
> ../../../devices/platform/soc@0/841000.funnel/funnel1
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 replicator0 ->
> ../../../devices/platform/soc@0/824000.replicator/replicator0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etf0 ->
> ../../../devices/platform/soc@0/825000.etf/tmc_etf0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etr0 ->
> ../../../devices/platform/soc@0/826000.etr/tmc_etr0
>
>
> 2) The patch set must contain the usage and specification in the .yaml
>  file(s) of the property used.

For the record, I don't like "coresight-name". I don't have another
suggestion because "easy" is not sufficient reasoning for why this is
needed.

> However, there was a standard property called 'name' which is
> deprecated - see
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html
> section 2.3.11. I do not believe that adding another 'name' property
> would be accepted by the DT maintainers.

"name" is just the node name for anything in the last 15 years. They
used to be separate, but would still mostly be the same. The only case
I found with them different was old PowerPC Macs.

> 3) the 'device_node' structure has a 'name' field that contains the
> node name in the DT approved "node-name@unit-address" format.

Actually, it is without the unit-address. full_name is with the unit-addres=
s.

> This
> contains whatever node names you used in the dt.  Why not use this if
> a change has to be made and find some conditional to activate it.

Don't go accessing "name" or "full_name" directly. I intend to get rid
of "name" and generate it from full_name. So use the accessors and
printk specifiers if you need node names.

Rob

