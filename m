Return-Path: <linux-kernel+bounces-165751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18648B9094
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26631C220B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82C16ABCE;
	Wed,  1 May 2024 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jItkTfhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E41168B04;
	Wed,  1 May 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594866; cv=none; b=J77AXw+L2HXB6ohTDh+k58wdhW2SAoIXvWwkvwvgfJSnypkDXUh26gwWAAjB+0YBIjKtgu2osGKbhLgxn9w1YnHYK+dc9zkvMXJzKH1MiFbwwabgQ9iKkp6BDFbPjvyrJOOADIzdi56OJRzIU191bm9t5fUvf+ZEs+XhiopcOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594866; c=relaxed/simple;
	bh=NQYZ4dGnOZ9iIvBhWfBi27FrCCyqWbFbUxOkNGUQKd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HulctSlb5/GoC7Ym2Aq8VaCXh+BMfJcYh2ayhspijH9FLgc83lG2QkDLxcjbiuchs4y0fS/FxzNSSmBpL1pEpzubP8RjiRR5nyLPQsA2rWrFmmzbJMwVa0uXs/avpYPBs0oW0UYXHLf/Dcarq16+dAZtmho42kckWLhLE2dnOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jItkTfhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF05C32789;
	Wed,  1 May 2024 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594866;
	bh=NQYZ4dGnOZ9iIvBhWfBi27FrCCyqWbFbUxOkNGUQKd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jItkTfhx3akEVB+1doiYiRDYMFQNcpSlbLr176V/u1XzNd1tqKOXIKCvxgH08v9Dd
	 X7kPAv7JfMXfJeDxB/qlHKsG6fqz9bbGhjft0k3SROIZnpVBbePHAdvtzF3IKp86ac
	 qSMMy0IY2WnXEy+4P9r0aZ6j/6SpDMMuJXm0X+Z394XGYJzbV5qOsoFd9a5Q1AiHNz
	 xUutua6zvjsrqif5ZenKWn4fLmyvCHo8NJIcx4S9hNd+kvYDlYfnVsOK3ya+me1wiR
	 NDu8z1NtCuide9utMFMbRAsvxpF2UdSVnnUSzpwG6TRILW9wKom2oqt4LONnIrtmKl
	 uEXLFCwfdOHPg==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: (subset) [PATCH v16 0/2] Add DT support for Multiport controller on SC8280XP
Date: Wed,  1 May 2024 15:20:56 -0500
Message-ID: <171459484207.41039.4630873334442786752.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 29 Apr 2024 21:50:46 +0530, Krishna Kurapati wrote:
> Series [1] introduces binding and driver support for DWC3 Multiport
> controllers. This series adds support for tertiary controller of SC8280
> and enabled multiport controller for SA8295P-ADP platform.
> 
> Till v13 [2] the DT was pushed along with driver code. Separated the DT
> changes from driver update and pushing it as this series. The first two
> versions were marked as v1 and v2. Marked this as v16 to avoid missing
> of change log till v13.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller
      commit: 3170a2c906c61407d725e9022b6225c5ff062d9f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

