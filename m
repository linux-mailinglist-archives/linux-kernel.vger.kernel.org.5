Return-Path: <linux-kernel+bounces-55961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00C84C41B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0131C21BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143E52E84A;
	Wed,  7 Feb 2024 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdUlUjfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6432E62B;
	Wed,  7 Feb 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281239; cv=none; b=j53NnuXK+p8rLaCCWjiY7rmmRPvduCfsiOt56iWwN+wm4vDLoQKvrOLHJGE6zWEvg0Oa4/6sJMgXHykh4A7q6uuH5OIYOOP8rGbgPtCF3mZGzuZCoBMqnutakdI4u17DrIast8Ua+DC5IJ75kQBw8Pbau+sos98zbeP55zO4xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281239; c=relaxed/simple;
	bh=fbuKI5I/KredeKMIwa77Y2hV8wzA+0g6yOY4Y3NliWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeWY4Dyw6i/rjfkIs1cskSn8MQ2vj+wNi947jucuMei1O02+yhLYY8Uql4taVxPoQlGIL4GCGn+IBS1rWZfr/AGG1gPQeDxJ3n4zcIlvchaKq2lByGR6v9aBf4blR8wL6M1Lyn9MAw39VeHiB2D8zW8kuh0p8JGx1OjmiVshT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdUlUjfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500EFC43390;
	Wed,  7 Feb 2024 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281239;
	bh=fbuKI5I/KredeKMIwa77Y2hV8wzA+0g6yOY4Y3NliWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdUlUjfwx3zdxNNLxEA+ASxo73osA8saY+pfcqsNmaSuhQ0g9LvRaWtxtw+IWY+NW
	 aLriV3kOdFVX8nhH8dq2rAqgT8Fmmq2otR1t6W1HcUGS5ILlYD3qYg9EA62jdrwj/1
	 grOs5zoBn3oEegIntnnX/uO7JHY/Zd3iw15ZmbqQKs8m/8ogwFJnUNrCjOFfrHO8wY
	 gcsMAYYtyCQGJ0d+6xQZuCokxISFI/VaRx6tj1HC9GE9rSSvHlNSPqafC7YH5saTmH
	 VywLR8Lba/GjxVuhQGLyt49pzNrevpBjEyQr56wypC+druqfOwH8znORgPyfk00NM5
	 h1YrBq/KR9r8A==
From: Bjorn Andersson <andersson@kernel.org>
To: kernel@quicinc.com,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_collinsd@quicinc.com
Subject: Re: [PATCH v3 0/2] Add PM8010 regulators for sm8650 boards.
Date: Tue,  6 Feb 2024 22:46:36 -0600
Message-ID: <170728117683.479358.8973558237499261418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125-sm8650_pm8010_support-v3-0-2f291242a7c4@quicinc.com>
References: <20240125-sm8650_pm8010_support-v3-0-2f291242a7c4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Jan 2024 17:31:14 +0800, Fenglin Wu wrote:
> Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      commit: a2eb99176b102b8945de94dbd0d60b53a240fa6e
[2/2] arm64: dts: qcom: sm8650-qrd: add PM8010 regulators
      commit: 4a8efd8a02efd9837da06b3995141f66b2c0e8dd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

