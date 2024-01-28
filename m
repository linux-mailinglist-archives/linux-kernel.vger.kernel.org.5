Return-Path: <linux-kernel+bounces-41500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E683F2DC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A2A1C21364
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867123FEF;
	Sun, 28 Jan 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO2S+RBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7920FD;
	Sun, 28 Jan 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408250; cv=none; b=KGZZ4n1pScjwF18xMUw7W8NlJL6FT+nspNbP2Ev1wG9L8vu7bd/KlEvYZ+ujxaBlDbf8sZSyeUVjnFQ2crv8tG1Qbt34jJPDvXG1vCgpXE+txE7aZtUSFoWzW/eD5NMXDC85UxKUNgFqesp6BaOOkA0KSe+Lc2Al0AIurb9PJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408250; c=relaxed/simple;
	bh=P9X1lYikPtpxbSQG2/3BfxI2tsDCVl+GpUxXXDTyPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9o+Na+45Vk+PEdMaoldZ9d5XEmuL+tMZ0eaSZgvVYQNGhuMlJLZ577VJXYSMApEET/gfL9tB2m27upbarOv5Eb/RRfGqmKpfKECpkFQtTZ3+Z6HVk7FvC/rq4JChIFaFEt8ZuhcB+njLTKkoRKseEkJcM6bjrGccGHk5MV8JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO2S+RBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF0BC433C7;
	Sun, 28 Jan 2024 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408250;
	bh=P9X1lYikPtpxbSQG2/3BfxI2tsDCVl+GpUxXXDTyPEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mO2S+RBYzS/sVk7otTnPapGXc5u0dI7sRGBGjRP9ikj0ygwJ8zsilJZ528u6eK9FS
	 6ZFtnncvAjXWn4mSbcdM8EPQ+qn5H0gGuNH5p6VOhpcRcvsQ/VR7JVsr1XjTs6aq9o
	 8BVq+8AD38V8B/eZ5y89uT6pZPPlV0Bg3x/E5C26+Er4AXqXDaExaERkS4rNSWimbz
	 wxKV7ElluujKhKP+fcI0m+sIfyAFOfob/IVssw6tFeewWVy6nyviT87ZfhqYJlw3Y6
	 ECx2T7o8zxpZrfQsmx5I1j40wgw5kkFYTKD52uQyvM/7DRDPRFvY1VBSwT/+Rlgp6U
	 GuaBqX1qLPkqA==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Hook up GPU cooling on most qcom arm64 platforms
Date: Sat, 27 Jan 2024 20:17:17 -0600
Message-ID: <170640822839.30820.16093287038356526240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org>
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 02 Jan 2024 14:34:04 +0100, Konrad Dybcio wrote:
> It's been years since Adreno has been registered as a cooling device,
> yet only so many platforms had the correct DT setup for it. This series
> attempts to hook it up on most supported snapdragons.
> 
> 

Applied, thanks!

[01/12] arm64: dts: qcom: msm8916: Hook up GPU cooling device
        commit: 04ee83047e4f7ba3e12f96315c08e146d10e1b7b
[02/12] arm64: dts: qcom: msm8939: Hook up GPU cooling device
        commit: 93c4e1fb9dd9e56b09adc4a85692de3a97209960
[03/12] arm64: dts: qcom: sc8180x: Hook up GPU cooling device
        commit: f48cea4a6fffa3651ced6f8f348f62ff4f268d87
[04/12] arm64: dts: qcom: sdm845: Hook up GPU cooling device
        commit: 08b1b831e1a91793a20a41e090f969f41195a03d
[05/12] arm64: dts: qcom: sm6115: Hook up GPU cooling device
        commit: de5e4e88ac148eb3aa9759095c91cbf810901774
[06/12] arm64: dts: qcom: sm6115: Mark GPU @ 125C critical
        commit: 834932689f2f545f05ee1bbaad5e5e7f4c9fe136
[07/12] arm64: dts: qcom: sm8150: Hook up GPU cooling device
        commit: f18c63a8213913394e20b07790e1ddd60d42f44c
[08/12] arm64: dts: qcom: sm8250: Hook up GPU cooling device
        commit: fb18c893816b37c907c1c0883b92e19dcad58c97
[09/12] arm64: dts: qcom: sm8350: Hook up GPU cooling device
        commit: 43c925e4567390bbf7adb4778b4cae3c93b924ec
[10/12] arm64: dts: qcom: sm8450: Hook up GPU cooling device
        commit: 36fd56ab4d1d13adb9ced8592dc51e009240442d
[11/12] arm64: dts: qcom: sm8550: Hook up GPU cooling device
        commit: 6a464089284a6192aac8405918aeed92b3bba8b6
[12/12] arm64: dts: qcom: sdm630: Hook up GPU cooling device
        commit: ac68c7d3912d09878b8b42866b47fdd6459f5703

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

