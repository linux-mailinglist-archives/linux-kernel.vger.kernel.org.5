Return-Path: <linux-kernel+bounces-65745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2F85510F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288F21F215A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036612BE9D;
	Wed, 14 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIzJDL7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613EB12B165;
	Wed, 14 Feb 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933472; cv=none; b=OduuTH/lY+6foo9fcMM425lGQFFW4E/xKWzF2KJdnQMEXwTgjB0jn3UC4D/DLEO2kLELBQWr8MMYOxsHjx4KNgzuilGPqz8wI1Qpuv8zy5Wp8WGyW7Q83zvIlY//AS1/nLsw0mboBbOLMP91Xwi8PugP7212Rd7WNG011FSTpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933472; c=relaxed/simple;
	bh=YaYzQS2TMZ6SbsI9/AZEoEa8PAU8fUZJpJZ6GY5gC74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kU9oIQVr0zvw/cuPE7io61DHLaKvojS/9OZVzDK226tPIp/S/mdVQzORRrtB4ShSBSl2KJBVU76+1nqzkpMTySYDmVswXeNnVB/7cx58GJuVD5TghV2Lb6F2Q6E0DnEyy0KE5wGeKSqcFnqGLOKN24OTMipxAgVfAyF7CEw7dMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIzJDL7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A27DC4166C;
	Wed, 14 Feb 2024 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933471;
	bh=YaYzQS2TMZ6SbsI9/AZEoEa8PAU8fUZJpJZ6GY5gC74=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MIzJDL7cgB89sOU8ga+FDy6gMGIcqgIuDHwD9mtoVIDwAC8eOfYNmriMsQnLQCc2L
	 j/A74J6KAhCUMrFIx3LfCzTc0X4TibgSOUb+/7kejHRp10699du7jUBilpeBEAXlN8
	 /u+62CWZMtgAEDi7FMOHJ3dGU18gXwXV2/h3ukzyNtIXeFnltD5ud9gWGIJQtNURDz
	 N2Vp39BufViSwXN6ddcqiqX5r9analZJQ7feO2mZAqijMsqVAqDDG5Laj4RzgrxiUh
	 gBXjCil45byeFaVBGlQN84XCgafsfGWFHBKb5h79roBKphaTVFrDt9wBr9ZbOr6qqv
	 L0TvqvpfJjBFg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: minor whitespace cleanup
Date: Wed, 14 Feb 2024 11:57:26 -0600
Message-ID: <170793345828.27225.126406196959593352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208105208.128706-1-krzysztof.kozlowski@linaro.org>
References: <20240208105208.128706-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Feb 2024 11:52:08 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{' and
> around '=' characters.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: minor whitespace cleanup
      commit: 77e7257a601743a1cd67fa474288389fffa8839e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

