Return-Path: <linux-kernel+bounces-139762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BB8A076B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B61B21793
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33E13C693;
	Thu, 11 Apr 2024 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEEXo4jl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AB62144;
	Thu, 11 Apr 2024 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811664; cv=none; b=N/65BVq6cPhs/nprtXeICr8Eu5HLVs+5l9UZ3D00sWHCfM2c8j6ZVGVaEf4FyH8f7Qhgbk3YU4PSABhERB0Wq1zo/ZPxF7DkRW7/wyxrqR22JJ39HKkvZCIuuPFUjLs6BO0a8jWddX2BQ6X3BcphTQaLjEdbCk0xTHXD4Aolo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811664; c=relaxed/simple;
	bh=iXUl7mi0PL2dzPz55D0s/Cdt8vWE4qwt/mrMsbksjMw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=M0swk+sednixdiQGNziCuNkwGYVDnFaGm6OYtSkbuYEWhBS6urKZ7adztOTqH3urMQM+qPP9FvpRQF3aW2aI/UbBDFc3iq2IyphohFZaFlJYb6apV+XmGGe+Q+FCN0IQltmsDIrFKRIOC2H7M+j7DbAh/6jizo52mykPo5yHmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEEXo4jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50611C433F1;
	Thu, 11 Apr 2024 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712811662;
	bh=iXUl7mi0PL2dzPz55D0s/Cdt8vWE4qwt/mrMsbksjMw=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=nEEXo4jlkYaL/QJDzWQzfik5QFt5pz715Fw/5QhKKYXy3TODEMb2q4s3zab1iaD6A
	 P/saqOEE7/hVmi5H6RYUt3cBqlgQ+ZLm0DyUGW/WTEF6s16tLnWocN4/ZDOaQEUX/2
	 BNnxLrm3kbqwjlbYRvM/TfpYS75a8/9DWp6NgttWYyfN5eoApURnFaFZLtaJPbFJ8H
	 TIKfUYvAef1x4oRAqdItWfyLZf+4sEDHbEcQUCpAukTJQQ/59La9wzD14Ih/5YJNMB
	 NrNK7bqvpc+qrTpf7w3NLhCvZ8zU9n/6ToYVtURnAZy8WQ8o39pl1m4PP70A+hsRxh
	 1PsyQJ1aCtSPA==
Message-ID: <5fc87d10b06f8b5b3024ac6c5674b18b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a70e7219-5fd8-4797-be43-199f8995409b@quicinc.com>
References: <20231220221724.3822-1-ansuelsmth@gmail.com> <a70e7219-5fd8-4797-be43-199f8995409b@quicinc.com>
Subject: Re: [PATCH v8 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
From: Stephen Boyd <sboyd@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 10 Apr 2024 22:01:00 -0700
User-Agent: alot/0.10

Quoting Kathiravan Thirumoorthy (2024-01-22 09:46:23)
>=20
>=20
> On 12/21/2023 3:47 AM, Christian Marangi wrote:
> > This small series fix a current problem with ipq8074 where the 2 uniphy
> > port doesn't work in some corner case with some clk configuration. The
> > port to correctly work require a specific frequency, using the wrong one
> > results in the port not transmitting data.
> >=20
> > With the current code with a requested freq of 125MHz, the frequency is
> > set to 105MHz. This is caused by the fact that there are 2 different
> > configuration to set 125MHz and it's always selected the first one that
> > results in 105MHz.
> >=20
> > In the original QSDK code, the frequency configuration selection is
> > different and the CEIL FLOOR logic is not present. Instead it's used a
> > BEST approach where the frequency table is checked and then it's checked
> > if there are duplicate entry.
> >=20
> > This proposed implementation is more specific and introduce an entire n=
ew
> > set of ops and a specific freq table to support this special configurat=
ion.
> >=20
> > A union is introduced in rcg2 struct to not duplicate the struct.
> > A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
> > of frequency table.
> >=20
>=20
>=20
> Bjorn / Stephen Boyd,
>=20
> I would like to know if there are any comments on this series. To enable =

> the clocks required for the Ethernet interfaces on the IPQ platforms,=20
> these patches are needed. If no concerns, can this be picked up for v6.9?
>=20

I'm fine if Bjorn wants to pick it up.

Acked-by: Stephen Boyd <sboyd@kernel.org>

