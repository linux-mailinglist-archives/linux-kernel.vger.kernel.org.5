Return-Path: <linux-kernel+bounces-2715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F154F8160E9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E821C20CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B94D13F;
	Sun, 17 Dec 2023 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYKH14w8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883A4CB51;
	Sun, 17 Dec 2023 17:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149F6C433C7;
	Sun, 17 Dec 2023 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833714;
	bh=bTqEKnYMhSRJJRwiX/+p1T0ulMAkO3d0CunqXzjf5iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYKH14w8Zy+9ewiz9NYLoT1H6gO1rJtK73zFUMjIn3uOWjtqZjQPDcWkw7g+22XCG
	 LXMRk4aLNbSWRL5JLXiBTy1l8jPgofjxcZaICt3dj70eof38euIezRnMMhtsiNHKqG
	 ZIziK+BaG8sa3hB9KeRt+LA/xbRRQJ+hIBSOpYOl9tTadDRvzfZAtpAoCQev4XzUfi
	 ZbILJN9wiKG82sSYGTyQpJO+EoxJfqsKWLHBu5iELTujGFpdzKCpeeiVpJHPU5soys
	 pTEO4TSDveiymjz+loOIlIdaPkG8dXSwB/7e8m1OJVQK8uV0gOvf3PwENX1v1EpTet
	 ILkbh8ZLo0Eyw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] MPM hooking upping
Date: Sun, 17 Dec 2023 11:21:09 -0600
Message-ID: <170283349433.66089.9684159319812056573.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 01:01:07 +0100, Konrad Dybcio wrote:
> This series hooks up MPM (which can finally be done after winning the
> lengthy bindings fight) on 6375, 8996 and 2290 as a good start.
> 
> The hardware in question is present on all RPM SMD SoCs (so, roughly
> msm8974 and up), which means many more platforms are there to come.
> 
> MPM is one of the key pieces for allowing full system power collapse
> (and perhaps as importantly, resume) and serves roughly the same role
> as PDC on RPMh SoCs for this purpose.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm6375: Hook up MPM
      commit: d3246a0cf43fd24a1986163284edd2389143809d
[2/3] arm64: dts: qcom: msm8996: Hook up MPM
      commit: 09896da07315cce07b019ab00750c8a57e1b53a3
[3/3] arm64: dts: qcom: qcm2290: Hook up MPM
      commit: e3f6a699404154e7e103f8055f21c3556721603f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

