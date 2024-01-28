Return-Path: <linux-kernel+bounces-41855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5242483F8B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A61C21B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF54597D;
	Sun, 28 Jan 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8jXPwbl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696C44C75;
	Sun, 28 Jan 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463967; cv=none; b=Aun9OMt2QJu4pdUox3swg35UXMqJPNToKuLkV1uuJjcy9sOiV5Lofj3Lqh7WwLrrrzO1u2EDcUUvw0iIAC8ZKRJKIfXtnsMNJwpYsSReJ0XBqGZjuyS4J7v5HpZaxAFgmMYbGXj52Mg9OnKHreP+OlbpjIwTM7E0fmL7TJPDkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463967; c=relaxed/simple;
	bh=SNr0g4NgKQkS//N5RgmXqXKm4z4Bwi3re2LgEuUF3mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EofWKaZf+Jpp7LDtCmxE8N/SaxldoWk1ZsdkkTgt80z5lhgKnXOHNmIqwwFfAVXtLOkR54ubhpO9XIGyMDRf2jimAlmAHiI3J3QFEkFto9fSPAMr0NzOg5nrup3BaBJGnhg2U5cB5W866IgeoZAhkq1Jh639DDR8sBAE+pwqooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8jXPwbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A7C43142;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463967;
	bh=SNr0g4NgKQkS//N5RgmXqXKm4z4Bwi3re2LgEuUF3mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8jXPwblCqx+yfQvYO1Z8S4rSLSkWCUUY9rUA2fXTNBjyftgQNy5niXQB94SWBl9d
	 Zh9LfmRncVNm98eSnQSKyxX0a7ygbsC1hY8Q8o82GSU7HQJ3kAQaqvTZtEyKuxr6ld
	 y7qNyRIiYyi9pcabkVoXCSZ9fOilSHkRQePDC8zxH55Xi3pVPVfEF6D7WYYVwgJK97
	 ohf/+gWI3FY94E7NVJbfbqp8vUob77Xb8IZu0lmu2+2+WjP8XFiGBMBdHaXphB0ueh
	 ecFZqjuaQPTZP+qIlIcaQT7wWGhXehj1jrOv7eEpeEqp5OaPUQQxl37gRCL+9wrq6v
	 fdc8UHbv6zJUQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending messages
Date: Sun, 28 Jan 2024 11:45:50 -0600
Message-ID: <170646395045.64610.6864219622708181971.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 17 Jan 2024 18:31:52 -0800, Bjorn Andersson wrote:
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send some of
> these commands to the AOP, which allow the user to override the DDR
> frequency, preventing power collapse of cx and ddr, and prevent AOSS
> from going to sleep.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: aoss: Add debugfs interface for sending messages
      commit: d51d984c5525aebac0f90356ab1d923541b5cc60

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

