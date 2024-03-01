Return-Path: <linux-kernel+bounces-87761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3686D8A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535912850C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EB2B9DA;
	Fri,  1 Mar 2024 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1xnb4kO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9B364BC;
	Fri,  1 Mar 2024 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255958; cv=none; b=tLdfzpokIIGZVYH0tGW1i2JLZAlFSGpeuNFkINwjdqMmz9WB4bDVVSy96aPEeBNhFHiaMsErJ6MvNJWCMjbeZeK66uFVt+wop+hoGM2qOh3if+KutGvyzckLpbuFW0tnt6CUiOyASY4/wW7TqYUZbGh6Yv6Nk5uLPpG1MTVOVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255958; c=relaxed/simple;
	bh=yDHOLE+llrw++hIhn0lONNzhM0FIHeIDdS78CASsC10=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=G1701OaX9L/m37sTEPX30GbkDvoNiSOZpYFrPQe57cnBZzI9t7RmiG/cSdjYPnObpyX9+ivi1tdFeVJccG037pMjCLt2fRLpIjgina1zkGhy9UH1JO/zaRDxhuQv7S4p31RykF2fU2uORefGv5TM1D30EcVvh670iPAiqqeDXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1xnb4kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503FAC433F1;
	Fri,  1 Mar 2024 01:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255958;
	bh=yDHOLE+llrw++hIhn0lONNzhM0FIHeIDdS78CASsC10=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=p1xnb4kOYm99rTTpXNDW5+ne6sFTtzX2Jw/1VvsLq/RMNn10+7yw2LIoJYay9Dmn2
	 1L0CFKCp9Puw9PXbeB7F4oK5EkbYUDLnZfH5wp/GPPvuC0s+UrO3FeUWbHhhcFVAUa
	 1hit3XwPVC1mrB9RIofg2wx7AA/xpYuFd6Eikzpsg7J3LoYSvQ/49LZYeJkRg+rDkQ
	 YL2AzoHe6SwM69YqZ76t3p6wB68hdBD2QwB2TPR4i0OT3PJOmWuoC3aIbcjjt5zZDm
	 Q/VNFtqYKPjNIN37RttJnX9/Pw2Z2s8uYzUDLrQNNdNFBiiMrzZQgTy9f7lE1QYMNS
	 JreNauwrv6+8w==
Message-ID: <b688090cefa0ce2957fc119c8ef7f92b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-5-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-5-074334f0905c@gmail.com>
Subject: Re: [PATCH 5/7] clk: qcom: camcc-sc8280xp: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:19:16 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:50)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: ff93872a9c61 ("clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

