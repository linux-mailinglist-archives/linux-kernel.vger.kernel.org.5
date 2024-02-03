Return-Path: <linux-kernel+bounces-51212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C08487D4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DD01C22B70
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56960B95;
	Sat,  3 Feb 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQUOr7KA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4960260;
	Sat,  3 Feb 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979990; cv=none; b=K48iwQ4B4scd2orShc63nIYky+W2RgtptDzS6zr4s/NInPnftWev3GGoTHAe4O4fXg3NH3LYZQzsfumz0TFzRs3c83YirlDXAheCtwMIMcqS/W+jCYiwssmY3YNaC1X/r8hOI6mzhWXdMWeK/tMKWRR2aiuFM+9NTMGP9pv0hkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979990; c=relaxed/simple;
	bh=s6nZRbM0fTJL+N2c/ac4KqfCqy+WoklBkqv8viEYCMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5iLAnY53Wj735qV/pEo19ryysH5tfUqFAgTthMpqLjqyDL5fVyEwIT5FiO83xlHW9pbE+v4JSvLXJqjtG/INy1VuufJY9uS+gLXanb2EUMfIqhkjnaccNigYi8T15B1Si8xaba0bEe2lhc1vowrNoebtVHJFqtB/ljZ9LYiWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQUOr7KA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FEEC433C7;
	Sat,  3 Feb 2024 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979990;
	bh=s6nZRbM0fTJL+N2c/ac4KqfCqy+WoklBkqv8viEYCMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQUOr7KA6ItuhvvIPxQly6HS3T0rkdSMcOWUkDjEwBPL+LJu6JlV3uSXqpKGINKpA
	 zhp4Zrzzcp1BotCx/eepZvAg6YFbb0PIBtQLuwXmtIwSAZtRjoFNquozAUItpF+/9T
	 yiYi0T0YZcJ1BTiZ3fMHszvLY65A59Bxq9R5YqOsyG1zmbxit2UbXJtdhltY08x1jO
	 wlo9xK9+6LJiDw5L1RxXVf9DPM5wwPP6CBblfb6w6UxOdhjgsuGwTWaQcDfrXXIwr5
	 +hcl2zdG2Ad7upyEJ/hJZA5oXsPni0tAeIGIAWuma6FxIAoiLxyyNayHKBSr14HQCF
	 XAiiAuvFa+JXQ==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP
Date: Sat,  3 Feb 2024 11:06:21 -0600
Message-ID: <170697997759.332807.15158372274778421217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202171915.4101842-1-quic_jhugo@quicinc.com>
References: <20240202171915.4101842-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Feb 2024 10:19:15 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> addressed there will bounce.  Govind Singh has left the company which
> appears to leave the Q6SSTOP clock controller binding unmaintained.
> 
> Move maintenance of the binding to the Qualcomm Clock Drivers maintainer
> as suggested by Bjorn Andersson.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP
      commit: d22118f005231f543ef45e17342c3eb2a71cbfe3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

