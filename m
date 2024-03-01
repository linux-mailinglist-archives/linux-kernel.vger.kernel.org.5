Return-Path: <linux-kernel+bounces-87760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2494686D8A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A0A1F22E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF62BAE7;
	Fri,  1 Mar 2024 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZFknf+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B13C13F;
	Fri,  1 Mar 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255918; cv=none; b=SmJ9ntktFnUAkWUnu5h0O/oCVbYeWkbNTZh/53347SZt4W28/Mi0zK5eJvTCzWAKUgcqNRfSeBAgkhvipKlUDgbd1tSYBWrsrV1KQ/H5N9NntitdoNMtKPZ/Sh+47OiJArD1uwDgar+SSV3Yx8KHIO2H3MqI1mfASSURgTKvsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255918; c=relaxed/simple;
	bh=0iBUDhtwMEo0O+9wKFS0kyakW3dZ/E2QyQ7ooDjFpbQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FR8kmak5oDAJFHTsLoWU500zwaqqHucF/Mv2X1D0ZnHrUfrj2EylTk+DsuQdE4t+fkocE1HFouzUE7fRq0NJ/Ds9EeV3dBG0vQ7eL3jtHWEqCbyflyMe/WchbhnbAjt1e1fhrTUkMSgEVt0IO1Cc3A2eROXQLw6TMPF4ZmYq8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZFknf+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD364C433C7;
	Fri,  1 Mar 2024 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255918;
	bh=0iBUDhtwMEo0O+9wKFS0kyakW3dZ/E2QyQ7ooDjFpbQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bZFknf+Jwz6jkBWfYmf5Y2+bv/GeQtEAa6NMjAZnXxyLfSA86IvebXkW4rkaXzfhL
	 jFf/MF8Y+Z9hUQF9lAxGWJ57prDwDkKh0qbjo6LkDaKGaShN94nnJKPYjhWz15dR7R
	 t8LooijnGardfbe60wK/AifGeY9VEu+Dkz4JntFxkxFTQcbZ68OwWN9WLvqoc/2IkD
	 sivJLzyiP6ERsEBmFVPjKEadvvZg2UPXQ/8biFmQtdlgegpwQ9KKtFLBvsrKe2ccl7
	 2p+1zSFZtcEV/400eN4C2jPbifGPLuFickJVcj06HM/fTchysHGoPt/JP/auTB6esA
	 IJysrQ9qmbGcg==
Message-ID: <ca14c4f5f4be95e0b9b347ff03b668aa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-4-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-4-074334f0905c@gmail.com>
Subject: Re: [PATCH 4/7] clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:18:35 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:49)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: d75b82cff488 ("clk: qcom: Add Global Clock Controller driver for I=
PQ9574")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

