Return-Path: <linux-kernel+bounces-87763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B886D8A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC39B21312
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64142B9D3;
	Fri,  1 Mar 2024 01:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6FD/J2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4902EB0A;
	Fri,  1 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255989; cv=none; b=roqcMXlZtlw1UxxQVMMsTMWeTh9S2YcPaGa4iVEKyWNLhVGLtv1kewAyX3TwdErHWUogW5ccIG0xYLl5mCD6dk0R7LtTU/lb7toLS2M3MrSJl+OXcQ8DjDH1t5prgbIoOkiTK0lFOFia53c55hZss91lmldaGTT3wG4c5QUTjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255989; c=relaxed/simple;
	bh=0ETUyHmULsfrkMhIsbC7LtvomnQPjHhF5lhx7L4Th/s=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ro/IjQbybjAeChRVeyP5wMniyAEn6fNIlAvL9aN5d7qpLF+VZ4Hi3zX9GPh9zqec2scup03l1Hab0Hwg9ULFlV2Jn5vOD1SihfrB86G4ikqFkjRLUNlFuBbvN56p/ugQ8IrA5R7j5e5guB91MwMVebYz1yyJ0c16nWJJa8NRXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6FD/J2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77396C433C7;
	Fri,  1 Mar 2024 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709255988;
	bh=0ETUyHmULsfrkMhIsbC7LtvomnQPjHhF5lhx7L4Th/s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=W6FD/J2v+lMWtB/Yi//4ZoOs8rUdLym4uCz+sWmY0J7mc5rgBRCBx5d+JqkJbPzrC
	 gmCZfTNO3j6bgPLF0up3pzp36E5XeMypqEnUPEgJA5MmuSHgNT5jzPKbre4gZ0xhao
	 i/ZdB3Y6eR8pAKk7ZdtOfDVCSolxaZXj4BqVWZRpiKzpTv95z27ItgHHNq9K9shNPZ
	 GekRJ1qBik6wt2L64+Awqrccnb8C1TiO3Z/rOE1fR49XIbZ/IPHYXKmYMwYr/g8BpM
	 1iCZG5cNzGJm6wLjFEdEQsmUKkPK9b5m1czJu8/AZdYl+c6vIwRDhnx6mXmmohdJPB
	 OFnvBRe6rvlMQ==
Message-ID: <6d9fa1b4882d3e4f3367120def16097d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229-freq-table-terminator-v1-6-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com> <20240229-freq-table-terminator-v1-6-074334f0905c@gmail.com>
Subject: Re: [PATCH 6/7] clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
To: Anusha Rao <quic_anusha@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <gdjakov@mm-sol.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, Varadarajan Narayanan <quic_varada@quicinc.com>
Date: Thu, 29 Feb 2024 17:19:46 -0800
User-Agent: alot/0.10

Quoting Gabor Juhos (2024-02-29 10:07:51)
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
>=20
> Only compile tested.
>=20
> Fixes: 2b46cd23a5a2 ("clk: qcom: Add APQ8084 Multimedia Clock Controller =
(MMCC) support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

