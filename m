Return-Path: <linux-kernel+bounces-55944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60384C3DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603121F221E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF071CFAB;
	Wed,  7 Feb 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEwZ19aE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428611CD3D;
	Wed,  7 Feb 2024 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281211; cv=none; b=CKfpBgJCwCyRUYzR9jxunkeT4bSJbHzSwID47+5/aVvID8CednT/TxxwVRm5kI/lf+QCLwO5OyfMoOdwmYNR/cKtnVAe8hCfU/paGcu9IenO/+mhmjPQeQackmM3YceY+X4L5I+I2M1Irs08Smc7+E9aisuDxcVXE0enxQ1AabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281211; c=relaxed/simple;
	bh=ZolLkX8+GJN1b/yf5VSGLzz4mFErT9IfSbvJWJhnSEQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2Pw89tWrMSYTF9UACA4fnKWxqyjQl08OtqE9Mainvv5KWbFk+HdwiREokMGUXWKfOE7v6Xb0BJ2tfN7sU3hA2/AilOw9WS0meE1xmVR9YBs4wfzqDIGB4T5PZ+TB2JXIulXdxgx1LvYSaMmmlrLK3DflxFpvgKxS1xMbRnXyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEwZ19aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD38C433F1;
	Wed,  7 Feb 2024 04:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281211;
	bh=ZolLkX8+GJN1b/yf5VSGLzz4mFErT9IfSbvJWJhnSEQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tEwZ19aEp1TfW0QVtuAef9akdiS7F/LZBqhYf7uoJmo2ZLa95X0g8psC2LCOYbEyy
	 VTKRHn6ExDwTuRbgV6HmPuh4NlJ/dG69Z6VSiAjVcVjhFzo0bA8QqSeZ6YnenrjcGD
	 V3+40EeyCRgwEdG8lTYy4zss7qNF88Seosd0yKgmZhu0fifMUD1UMHt+HOqTWhzOPb
	 cognq4tps7denThTPv+j7W9Pi2yW49PDrv2UEd2gRTSKPthNKzlIUrjzPhULPa7uId
	 zXS9v39o5H6Na7Uk0HAqKMNfZ7tfph1tasHWEU8Q1ByUXEWjrUUXgZV+kdg7BSHh2G
	 lvohDlEe7Azcg==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
Date: Tue,  6 Feb 2024 22:46:14 -0600
Message-ID: <170728117687.479358.12175881436084064299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131022731.2118-1-ansuelsmth@gmail.com>
References: <20240131022731.2118-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jan 2024 03:27:29 +0100, Christian Marangi wrote:
> Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
> of using the default value of 390KHz from MDIO default divider.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
      commit: cb77d0ad460e2c97a00c02ed78afdf45476e5e5f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

