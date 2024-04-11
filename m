Return-Path: <linux-kernel+bounces-139739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0968A071F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636D11F22784
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635EB13BC1C;
	Thu, 11 Apr 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jku8B7I+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD82BB09;
	Thu, 11 Apr 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809075; cv=none; b=lu1gKfdlHRewBJi8UxLxpT43BDQuonk0Fr35hltseZqF1TNvvWX0J85F3cGAWxEhziROV7xqZL9zN8A+vWF5C+hfuSLBkzWfpPcAUvnBVH4eRJxQQV/khVFVou++QZ0hrBHyb9COTpLgK4bW52SF5+gAL0TnDDGj+lrQoQ/DKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809075; c=relaxed/simple;
	bh=LQWAuoCn1kPcx9Am/NeCrTjJ5/EuA4eOzZJNn5sTNoo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=vCV8RNKRFnodjc0yzXs180051ISvy/CgCPDUbKRFOTpIQXvI7QerutwRiCbtKZ/Ypx3c+AIpNrlQZha/Pge7G/h472A+kecc1JyYlVZXVgLaM6dvQpVHcBlD9qJatEUfhpQUH0qtknFsgHL6hskdxMCsTakezYJseyVqvZL25os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jku8B7I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBC2C433F1;
	Thu, 11 Apr 2024 04:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712809075;
	bh=LQWAuoCn1kPcx9Am/NeCrTjJ5/EuA4eOzZJNn5sTNoo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Jku8B7I+9+3tnBQAf2WhJg2Ed1NYpFtEmT+qE3US5JblrZOe8lm0Skz9pEMMOI59G
	 PtXFGbvMygs6lIJwso1QEbCJIZFdxX6WTNhy1ue+iSpoJzMNmirEW8C3CRFyN+N2Tf
	 csgmu/JsWKxn2qd55EhDPEeIiDIDxq2/80KDJTUy7lFpaoFUHcCj0kQt+b+hzCREsf
	 j6PC282NPnyl7Kflrw6+XItaHpaoZ1NdbOqp9Sz8IbuBKDGuWeCV6Gd5PtuRsYY4Fy
	 Vi/shDWklwA+92j9WOP72tMmlKqSY2ANuUxjS1ygt8KnnGBTKfPbV976YXpMPmJDkl
	 yEH6eyv4MV4LA==
Message-ID: <a48f6017bacb4aacb0a318554229cb65.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH7PR12MB728433875E7B7DD673E8785D8A342@PH7PR12MB7284.namprd12.prod.outlook.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com> <55fd522918aa41f386e01432248933da.sboyd@kernel.org> <PH7PR12MB7284F36E51750D47102410448A202@PH7PR12MB7284.namprd12.prod.outlook.com> <PH7PR12MB728433875E7B7DD673E8785D8A342@PH7PR12MB7284.namprd12.prod.outlook.com>
Subject: RE: [PATCH] drivers: clk: zynqmp: remove clock name dependency
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>, linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
To: "Simek, Michal" <michal.simek@amd.com>, "Trivedi Manojbhai, Naman" <Naman.TrivediManojbhai@amd.com>, robh@kernel.org
Date: Wed, 10 Apr 2024 21:17:52 -0700
User-Agent: alot/0.10

Quoting Trivedi Manojbhai, Naman (2024-03-26 22:47:28)
> >>Quoting Naman Trivedi Manojbhai (2024-01-02 23:20:17)
> >>> Currently, from zynqmp_get_parent_list() function the clock driver
> >>> references the clock by name instead of its reference from device tre=
e.
> >>> This causes problem when the clock name in the device tree is changed.
> >>>
> >>> Remove hard dependency of clock name and update the logic to use
> >>> clock reference from device tree instead of clock name.
> >>
> >>Please use struct clk_parent_data instead.
> >Thanks for review. As per my understanding, you suggest to replace the
> >proposed logic, and use "struct clk_parent_data" to get the clock name f=
rom
> >device tree.

No, do not get the clock name of a parent in the driver. Use struct
clk_parent_data to tell the clk framework what the parent is.

> >
> >I have gone through other drivers which use the "struct clk_parent_data"
> >structure, they have hard coded clock names in the driver. In zynqmp, the
> >driver receives clock name from firmware.

Don't use a string name. The devicetree index must be stable, so simply
use the index that the binding has as the index in struct
clk_parent_data.

	struct clk_parent_data parent_map[] =3D {
		{ .index =3D MY_DT_PARENT_1 }, /* parent index 0 */
		{ .index =3D MT_DT_PARENT_2 }, /* parent index 1 */
	};

> >
> >Also, the "zynqmp_get_parent_list" function is called before clocks are
> >registered. So at this point, we don't have the hw structure which has
> >clk_parent_data.

I guess that's a problem with how the code is written?=20

> >
> >So, I did not get how to use the struct clk_parent_data in this case. Ca=
n you
> >please provide an example which I can look at as a reference?
> >

There are many references. A new qcom one is drivers/clk/qcom/gcc-x1e80100.c

