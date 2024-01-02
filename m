Return-Path: <linux-kernel+bounces-14579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC5821F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A410728474B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890F14F68;
	Tue,  2 Jan 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6rPSluQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC214F61;
	Tue,  2 Jan 2024 16:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA56C433C9;
	Tue,  2 Jan 2024 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704211266;
	bh=/2AN/VWXr8ksHc3PGhRXX0U2bsA62YQAqBV3Ee3tcCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6rPSluQQs4jETa5jmcpafOX8fA7CoEva5d76AKvP23rY77Ax1SJ/eFo/0Ej9tEIy
	 pFlTJ3CWEoMXUcCyuyyiO7suKNbtZi+K2oErrnc1mlldU9rBCMJUl03Z38lqP7VRbT
	 QgH1pZDywRxE4mQ43aPD/LbomzAp70wJpy0F1do8sM5aVUWSJHuxzCcq0UZadcgN9l
	 bkM7ZhLBETwSri2ZhFA6IapMqjGNP8/CTfn3UqB/tNSOEcdWn4BxoKMwhkAvmgO7c0
	 k3xvr2NKBvIWUvHgXiyfQEUN1iuu6bvLsGxVvB61V4ylYGc+ImIbBumMBFO91LVYsZ
	 AFTyYjP4VmQfQ==
Received: (nullmailer pid 2922887 invoked by uid 1000);
	Tue, 02 Jan 2024 16:01:04 -0000
Date: Tue, 2 Jan 2024 09:01:04 -0700
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 18/24] of: irq: add wake capable bit to
 of_irq_resource()
Message-ID: <20240102160104.GA2915145-robh@kernel.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.18.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
 <ZYxcvSLL8yWW-URu@smile.fi.intel.com>
 <CANg-bXCrR2FKSi6ik7LZBqTQz9=HDW=0cy7GZN0yaB0PsKKjkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXCrR2FKSi6ik7LZBqTQz9=HDW=0cy7GZN0yaB0PsKKjkQ@mail.gmail.com>

On Wed, Dec 27, 2023 at 11:21:14AM -0700, Mark Hasemeyer wrote:
> >
> > > +             u32 irq_flags;
> > >               const char *name = NULL;
> >
> > Don't know if OF style requires reversed xmas tree order. If so, this should be
> >
> >                 const char *name = NULL;
> >                 u32 irq_flags;
> >
> 
> I see both methods used. For example, of_irq_init() uses normal xmas
> tree order. I'll leave it unless Rob says otherwise.
> It is Christmas time, so I do want to honor the Christmas trees appropriately!

DT requires sideways Christmas tree because we're special. You'll have 
to add a 3rd variable. ;)

Rob


