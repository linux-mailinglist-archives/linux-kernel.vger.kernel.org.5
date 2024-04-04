Return-Path: <linux-kernel+bounces-132134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76942899014
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCBE1F2508D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FD13C671;
	Thu,  4 Apr 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxXkHXMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E313C3FB;
	Thu,  4 Apr 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265801; cv=none; b=mZEROMWYFVsZwyfJTQYrTEE9KIutChP2HAlZa1RO+IS72ZvPqNq1svmbTNQQOLyeuQ5Y2H5xR99rrd5es0CTqvAgkPf4JWXn3lbihsiEPyaXF+k2PzTEd4mtBNYj0sJE1sn229bG/T3nFHzm/N3Gx3j7OfMPWSJBmdXcgNO8PRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265801; c=relaxed/simple;
	bh=qK1WJ95y942nDqpYdpVd7M8hb2SED2//IBpTA+Bn1jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXCJMSBRpQqLtrdyZNMl9sxPTOgUihk+No1X9deUTYSlAyYtFUCJq3zG6K+Cp1SaOk+dmJ1U5YPr8I6rMmNCP6kDs0OJV/rSlP8rGi985Gn3mHXYnEn1hR7GAZGSHGxnYVDquD9ZaRrb35cEaW2gCc48ubjsF/MLFdAAZ4F5QYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxXkHXMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA8C433B2;
	Thu,  4 Apr 2024 21:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265800;
	bh=qK1WJ95y942nDqpYdpVd7M8hb2SED2//IBpTA+Bn1jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxXkHXMUcDgf0qA/6DQ54jxDBHsNtUX+npjVi2MY81OYCdFL9w0n63mg8WPFWdfzg
	 B6rv9bcAKBwRGzqZ0cwdEzAJqdQeAZyI4bk5DBp2wJ1NuriKQBmKJ3lPt2H5MvE2w5
	 UBo+OtNqDOla4UYFYKYV+7iqNdDtK11TrJCqrkVPAOeyj+Z8iFpCdxcSPY78nqDJNd
	 J+wUnPMiQr/egEIVprE4o17wyc+qRKjCpEijMA6Aa5uJAQnMVl1pB6D8saKlaIMu76
	 S6fXC3gQ+VPpXXXNQIXxJFESad2msjSNQpyrSBOyb80n0uNOEjvLExVJ0D8O8R91jC
	 AZu6UpS6dZlvQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150-hdk: enable WiFI support
Date: Thu,  4 Apr 2024 16:22:49 -0500
Message-ID: <171226578698.615813.10917637974157146735.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403-sm8150-hdk-wifi-v1-1-8da3063829c2@linaro.org>
References: <20240403-sm8150-hdk-wifi-v1-1-8da3063829c2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Apr 2024 20:10:12 +0300, Dmitry Baryshkov wrote:
> Enable modem DSP and WiFI devices on the SM8150 HDK device. The HDK is
> manufactured by Lantronix, but it attributed to Qualcomm, so the
> calibration string uses Qualcomm as manufacturer.
> 
> For reference:
> 
> ath10k_snoc 18800000.wifi: qmi chip_id 0x30224 chip_family 0x4001 board_id 0x55 soc_id 0x40060000
> ath10k_snoc 18800000.wifi: qmi fw_version 0x32040163 fw_build_timestamp 2019-10-08 05:42 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.0-00355-QCAHLSWMTPLZ-1
> ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
> ath10k_snoc 18800000.wifi: kconfig debug 1 debugfs 0 tracing 0 dfs 0 testmode 0
> ath10k_snoc 18800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
> ath10k_snoc 18800000.wifi: htt-ver 3.73 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
> ath10k_snoc 18800000.wifi: invalid MAC address; choosing random
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8150-hdk: enable WiFI support
      commit: e5fd6512f6e842d8c5883b9fa4d72c8a5295efdc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

