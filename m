Return-Path: <linux-kernel+bounces-41873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0A83F90E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20EC1C20DB1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F92E64E;
	Sun, 28 Jan 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiZAlxBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65382E3E5;
	Sun, 28 Jan 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465639; cv=none; b=mY90CMzb5N5ZGsOtzE8DJVOx1raBo0LGHNgGo/fyrEpXREBqMnuMs/EAUOZHIK28gwta8e3Uih9nR6H9DfrDMmNkhvK2dpUQ+5LBHInJKhEgitkndYzs+nNL4TSrgcpvuzD8x28WLZtSabZDN2E8CxgpR/G+usuruvUKnlP2Jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465639; c=relaxed/simple;
	bh=x5xkeH90w3zTKfbeaIMy3rP33RSNJq5Pa47+wWoCNdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkFSHYBtKfyHo2ZVwH1ZuC+8knLJUuFsBNlMo1e0Marl7SiqW61lDKVxkFTlpuQ3j/8Pbo2i2mneT9jsYtD1DVO8H9wdaHGOTEOZHKr4jyXctZ+xjbuEy0O3ju+psmaRD0Sr8vr5OPVOszqPi057jvIZj5dk14n+6fECr0WSQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiZAlxBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8EFC433C7;
	Sun, 28 Jan 2024 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706465639;
	bh=x5xkeH90w3zTKfbeaIMy3rP33RSNJq5Pa47+wWoCNdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiZAlxBl/QM66pRhB8zNgzoRorx/VZwAqg3eL3kIpnjeZjOfalNxnGUFC4ir850yt
	 YEJ7DJaX7QOsl7Zd/ju49KPLeCCE1sHzvzkVubQoT1ZoEE1giRYYx5775+FmBPBBQS
	 Q70xaE96g9LrYsctbNqXDAMigh/LnYYsUlRaI/TO3HPMqVEe8tD+g4psmizH/TbRy4
	 ATJ44jhMyft1Tgn2Kj+McYGPAIqAzfOgXTmuuNEnF+cnbWqhfYFuJ7fqyWZOzx2CDH
	 GXJ8DulkIW4LPaNUXqtwqIrvY1jo0H5lOLeecBhvj22Ln/aQNzUjdlyapyepKfszoO
	 HLxsXnn9AF+KA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm7225-fairphone-fp4: Switch firmware ext to .mbn
Date: Sun, 28 Jan 2024 12:13:51 -0600
Message-ID: <170646562749.66688.7240389646566501227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110-fp4-mbn-v1-1-45e7e33b1834@fairphone.com>
References: <20240110-fp4-mbn-v1-1-45e7e33b1834@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Jan 2024 16:21:19 +0100, Luca Weiss wrote:
> Specify the file name for the squashed/non-split firmware with the .mbn
> extension instead of the split .mdt. The kernel can load both but the
> squashed version is preferred in dts nowadays.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm7225-fairphone-fp4: Switch firmware ext to .mbn
      commit: 410dd97e3f394a1bac444f1964754968557f844d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

