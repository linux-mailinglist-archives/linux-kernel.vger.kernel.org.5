Return-Path: <linux-kernel+bounces-87764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE486D8AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40191F22F98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8F2BAE7;
	Fri,  1 Mar 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOxuoQOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361738385;
	Fri,  1 Mar 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256017; cv=none; b=VzFdIkT0sC7qm9Hwp+msm92tQ6sjnTF35xPsUTdsRF/6xQORuj4ZS9ndMyxZJeMIQ8Rgvb/PRbvM6MbBgxO3h8zd27EJiRR8q1RTlmYlFrM3LbtY9IC1MZ9uW1u6v5lluHCcypROl4gjZAmTq3xFPZtIwIWwY5keTIvNkvkpkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256017; c=relaxed/simple;
	bh=siavMLID54Kqx6FNuwgB9uww5d98GNCLY+aKlPjMbIQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=R/dkuPwIUtCfojk0WDlJDRQw105oPKiazPvcYDHu5x+IkRZTf4UabFGC9TBUlttASVPxAK3A+PsrbfSMwakiWcqqmcbcrWP3z66V6HzZBm6BCF+JlAnZpEJWhxDmafJXRO1AiXhG6EUK8CJrrWwBV0SoaXtQrhcOtIQUvUqbTFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOxuoQOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75636C433C7;
	Fri,  1 Mar 2024 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256016;
	bh=siavMLID54Kqx6FNuwgB9uww5d98GNCLY+aKlPjMbIQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WOxuoQOPuMnNnDjrcRquSnzVcdr6BGlkoG2ZMqnl52fZzyGDADGQGr6d6fDmjUlq3
	 cMVQ7foBCMALaxTktwAda2KuRDSpRvdF6P+F6XQ0CaOcyMxho8CHbs18DCM09G1Ve3
	 7TwEbS4QLHGkv194A/AmYRUUuimDgJ928BNP9ymGWlwtxG0UugINWoGE56m5hnH11H
	 sDLJOvu3WXgl2XCbrQb6jf/Oo0EZOLyOZBid0gl1dewbzmxvTV4usxO4M8Wcdh9flB
	 Mg5BpuKazqETd0RpmGv8Zvfcj0bXtbyuU107xAR7f4hQCsHvIin3KAHpYXjQa2GFzo
	 Cw4iMV97VycvA==
Message-ID: <1b7ccb1a0051e28f67a35ec1fc935e63.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-7-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-7-074334f0905c@gmail.com>
Subject: Re: [PATCH 7/7] clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:20:14 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:52)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: d8b212014e69 ("clk: qcom: Add support for MSM8974's multimedia clo=
ck controller (MMCC)")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

