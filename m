Return-Path: <linux-kernel+bounces-73479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CF85C32B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07A7B25638
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38B78B44;
	Tue, 20 Feb 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzMPy4z+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A3768E4;
	Tue, 20 Feb 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451871; cv=none; b=IiZWxn2xFbtV+b6GVWQ3aAtYqQoItTVKVQPF5KGcQvipXUexuU+9C6iCvKf2UqsalyPzgl2qvhbgzny/tcSPzl5Llj/3eiDqVF8AL3x5eriCtgP31JYqnm/3gM3Ke2XEwSoCRMzL9ihQlzU7mCOXXOZAp5ZrlKAqXcw8oCUKmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451871; c=relaxed/simple;
	bh=qtwbn4UPn2z9JflxF9F9+oogdoTrqWdb0O9YF4n1ZFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YD5t0p9JLNfyJ8kecT/0YwKEa3c0xTMbyw3lcgywf992RHIYgFovs4bMv6Mr/1aJuHtNxwAYcYEpOj92gsXmgyf5lbw5bGWN6VXnnjkdTLT+0UvND1Zy+onuaUMVJvl1dC3J2A/vdQiIg6YbIzaFtW6uGCdm5uIhOvHDHPpShYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzMPy4z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EBC43601;
	Tue, 20 Feb 2024 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708451870;
	bh=qtwbn4UPn2z9JflxF9F9+oogdoTrqWdb0O9YF4n1ZFs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IzMPy4z+vtvxETZ1uV3xZei5PSMnNB9fh6OWOyNpJSL0QRi8jhcf2BRkjhnfuumFZ
	 dlnVqkaJGjf8Y0j+HXgqz16k1kFbdGsoZ207b9w0+lMt18gj+HCZCENnxsbHkmrCJ+
	 ooHjlh+W0JxEGKpLQJ1mTOcj/mG7mMhQqUpM3tZldFass3ECVlArcnI9rnJvBqIf/Q
	 A6VGvKk3w1Een9ODstz1FpoOPjzpyg/uOaDgwhxSjzxdcXAgJCQPSVxicZjIOxBcGZ
	 Z3HCRtAkY6zT/VMdaTHdThc/mXgpStxZ+ZG5D2NP+6NejnSD5zl7FVhr6qGsOIKnHH
	 3Qu9QLYRf8Oqw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: replace underscores in node names
Date: Tue, 20 Feb 2024 11:57:40 -0600
Message-ID: <170845186086.159943.10821539995515301290.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213145124.342514-1-krzysztof.kozlowski@linaro.org>
References: <20240213145124.342514-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 15:51:24 +0100, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: replace underscores in node names
      commit: 408e177651614977032e66091ebd26f9b948e64b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

