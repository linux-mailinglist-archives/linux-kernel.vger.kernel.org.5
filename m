Return-Path: <linux-kernel+bounces-87759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193186D89E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF47285075
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B62C85F;
	Fri,  1 Mar 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrxbYPnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F142B9CE;
	Fri,  1 Mar 2024 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255897; cv=none; b=QypGibWiz8aiPVSnSXMIKih7GY/5CqcXYuftkAS1GZPZZhmvROHSKEtmSYSNB3w0D5Y/ForzyKRnriri7tbUlWFHjFODjzkXB/5sttraNgGwOrQZ7QS6iYz5bF3EkXDztNBx9DsNy2drOcPk8aZGtrYq/bAticOZHxWgl+gjHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255897; c=relaxed/simple;
	bh=dwr1VScL2FXk54am+5mIdK03WNHtPs+GCc9zQTQjWRM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iD1kKtJA+hJphtE8cS/pGChW4rgVmTAxS5rYc99JEiPEug1GKrk+kc2Nmayx6LdHAGzRkXk5+8f/DMtMXMvG6Ah4Ox/cAjuCmhH2f7tjqZNTmFl12331Sy13/KVleWmSmlZRCu9nDTLINxNEabz93ZdS/YBxE/YW6T56AltfXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrxbYPnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A331C433F1;
	Fri,  1 Mar 2024 01:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255896;
	bh=dwr1VScL2FXk54am+5mIdK03WNHtPs+GCc9zQTQjWRM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FrxbYPntvgvqdbylcMzTGJ79x0It5aXV8DC6RcIYaTc2gnRfVX9hh/T4K/WLHH7ah
	 OGDfH7GI54JXtdUKKWvNd86+fjY89LTrFpzY48LLoNp9ZNV/TG3d3tSm5nfi7CL6Za
	 YY/9Ql/+VOflMXUVdlXZO7OFXLoc30EuYCJ2VuP8pq0n1VEkwafT7+aA3TCN9fRcMG
	 WO/HdXx/1NDqXIKHlQvvTIrm2N1k45jAa2XowF5zUVcgLtKJombv9ICCP03Y3DA6XK
	 VsZm/VCFomFaRfrnYlG+ZrpUhgoQrR+B2qaixz7c40vIiMeY+8HDaNNHG/kL7Xus1H
	 QGf/aE+3wA7Qw==
Message-ID: <de4220cb965063714e252b1a70396508.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-3-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-3-074334f0905c@gmail.com>
Subject: Re: [PATCH 3/7] clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:18:14 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:48)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: 9607f6224b39 ("clk: qcom: ipq8074: add PCIE, USB and SDCC clocks")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

