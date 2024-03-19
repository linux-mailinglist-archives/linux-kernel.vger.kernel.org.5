Return-Path: <linux-kernel+bounces-106950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197887F5DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25CF28110E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270A7C09A;
	Tue, 19 Mar 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMs9U/i2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B781746;
	Tue, 19 Mar 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816560; cv=none; b=e1ERCCbrIpzskvZyZl8BDVA4b4xFB4u65O6oP60g8dr6TPJLEtrmqqT5ZYTkUa/AutMoeyIURm0p1thMmJ4ZIfv6Os/drmkOWJ0PzEyaiqtgJlBw+JoaQJo8AcKODck67XnFj789qq7b4K11iNwP2XWz97NxIRr/8bJBZXEA5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816560; c=relaxed/simple;
	bh=yu6Jg41TxjnYSs4rOkaehackNhkJ8Ue/OAn5c2fK64Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0U9v02Y7diYguM+nCvHB7EFA2RGJNhnfn2zFTxvbf/bosyjXHfuJDEyUJzPG4rkyNnn2oU3MDVi9BnnlItKf4I05+3ptUoEITYbHupr8+faCWxi82LEnc/F/iiGxNdLiUg5SX7tvDnLljSe8kEKMI5AjYnGtD3hD4HteL5qVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMs9U/i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0911FC43330;
	Tue, 19 Mar 2024 02:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816559;
	bh=yu6Jg41TxjnYSs4rOkaehackNhkJ8Ue/OAn5c2fK64Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMs9U/i2p8hx0thYGaGx46i48fEFrd1kTifeByxU/+NWNNijCkv7nNV5vW++iktFM
	 kG+yWW2gKna8Sxd5Ohs9k/4BfQoggYgoHVmAnspxs61DoFErshJracV9wtjajkjO3R
	 pgm12lDKbbxxKIapsxJ4UYqQftsy3DgCJqvtmvjiAUUlLn5vJ1U9tikffvStLtquU4
	 bVsQPu2/xzlyiCsBMq/MFZanUZLTx5UOvby2rfxjTe/FRfJfLewj3H7vBnRv9JqygA
	 zDk9RNZkfRGEFxs5iCChjSe3RyNuvsruIJ0IqU1XM8bEtZY9d1LaJ20Wp6JOByL8ZN
	 /fh0S8uFFktkQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: abel.vesa@linaro.org,
	quic_sibis@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle states
Date: Mon, 18 Mar 2024 21:48:49 -0500
Message-ID: <171081652635.198276.7515341680847894816.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240317132918.1068817-1-quic_rjendra@quicinc.com>
References: <20240317132918.1068817-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 17 Mar 2024 18:59:18 +0530, Rajendra Nayak wrote:
> The compatible's for the cluster/domain idle states of x1e80100
> are wrong, fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle states
      commit: d6feddef4b82b3245a32089f6e6618bee1ae6cd9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

