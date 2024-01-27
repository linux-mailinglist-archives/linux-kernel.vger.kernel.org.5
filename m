Return-Path: <linux-kernel+bounces-41431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D983F0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2051F260A1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF42E835;
	Sat, 27 Jan 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy5u4aMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE02DF7D;
	Sat, 27 Jan 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394894; cv=none; b=hOgn/r7gUsRxtIcghEMz/DhkgykjGvAGkcfX0w1/5chJpCZ4xsd+WohxHXbB2U0G2hiX8aLBWDMlAish9WW6SGzvYjDVclJEVcdZTTFw8P54hHNtVJ0fTb8FC27tzqvOB9VNdzPWYZmpSYGg7BhrpyU8LGaI4C1jYurGTc5rUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394894; c=relaxed/simple;
	bh=3XI+ijAAAJlxjLXfL/N3a6o8AO58B78cy9nUhRsZQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDNfapP6PheeFkQ7Oi36c2n3v01QFKl0IyoBeBX/At6lWhOd+IatS+13D9xYvrcoLjkZw/1DkDrU5+ZUu/tROSgJj86kUDpNVs2FRN74DfSpz7PhmRZx5MjeaL5GrwEWeaO2+Rm4mtxubPMo6L0F5QlW/kI+JzEoMGHDu7gXF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy5u4aMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51249C43399;
	Sat, 27 Jan 2024 22:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394893;
	bh=3XI+ijAAAJlxjLXfL/N3a6o8AO58B78cy9nUhRsZQM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iy5u4aMo04ysrVsyxXSf38d45o3muIZ1O1RMBgXBxniVpU8UY3A93/ADluXrqYN8J
	 wX8mE3cbxNP9NFUsKv6hL66wEBcXEAEa9K7iifH4mlV8dNOA7HJas+SKEV6HldVFV4
	 iI2DP0aEGiaDaJf5zzRC38Fz8urSSe/beravBE5LdVtjqbdyGtPgJAvrPIrJgVKoCy
	 mwl1hP9MWJWozbl9/wu5jpaPY+V0cehzTTHCmLJvrr12ue4b0N1DtBArhCLpwzgGQX
	 Lw1F0eAIynHID2abwS6Ctke91kwlgLywCLECp5++tyRyslo+36a7ke7l65Os+kFRWj
	 ecIuvqvkCbe0g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mantas Pucka <mantas@8devices.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi operation
Date: Sat, 27 Jan 2024 16:34:45 -0600
Message-ID: <170639487718.21016.15465918144131759968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1706001970-26032-1-git-send-email-mantas@8devices.com>
References: <1706001970-26032-1-git-send-email-mantas@8devices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 11:26:09 +0200, Mantas Pucka wrote:
> Without it system hangs upon wifi firmware load. It should be enabled by
> remoteproc/wifi driver. Bindings already exist for it, so add it based
> on vendor code.
> 
> 

Applied, thanks!

[1/1] clk: qcom: gcc-ipq6018: add qdss_at clock needed for wifi operation
      commit: fd712118aa1aa758da1fd1546b3f8a1b00e42cbc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

