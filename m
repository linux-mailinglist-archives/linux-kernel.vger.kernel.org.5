Return-Path: <linux-kernel+bounces-141768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23518A232E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0693D1C21447
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACE53A9;
	Fri, 12 Apr 2024 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWqTXu0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C94C6C;
	Fri, 12 Apr 2024 01:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885248; cv=none; b=nlI+oRdeqjoGKH3xsmZ1LepPmFXiy4jQIUfHpxNGMtOqhbvUeHvoZJVpplauMWmkbsD7cXg8IKwWJTjXI3MRqxylaQYUuihsLk1hMr3YiDnLh8eE8Z/rpG5x32v3cGPzEiHzm39csAGU3VMKz9GgxKuysl7B/zhJ2iJqsGuf0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885248; c=relaxed/simple;
	bh=YW9xxHO7EdZuAhVJ5aAbnRjYGBZMzMVifI/U1z8qaWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNj6FaZUl90MDVpaMGHGBsboqNkcRRuMtaUXA5i962JaXHyaKqys1wR/7l3CGNNU3HgtgXH+ITUZznVJ6J41wHQzezXUAZoWTvSFKwVQa43nFd8hz3FezRPkqBobxcbP5wA02egHDYFEaLVr82l2r6LwkoyZkp9482TtEwo0nIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWqTXu0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E50C072AA;
	Fri, 12 Apr 2024 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712885247;
	bh=YW9xxHO7EdZuAhVJ5aAbnRjYGBZMzMVifI/U1z8qaWY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JWqTXu0oYKuh+OS1ZrzzCW9yrKDztTSHLkGOuk1EEI8CFn+N+Cz71ECInihlydFoF
	 qlkpwidcEBFCcOLoJRSC/FgVhTvgmF8xyxc5uOosC6DdhbBVHky/uL97+zHtGeP0In
	 dnppocm2UsQ3jaefwTMRSAJ3g7rPlpH0nD/ww4NuwCD3tWGXWkua0PBwwQwJkF1t9t
	 Qth+JFDOz1PWmwsH9eGvhPxC9e7ptlLLu+HoSJX97qZvngp8wekvIyEGuyJuEXG+6L
	 iXR69jLm+K4wEe9Y0lQRo8NV3ZOC9WD/Y1PUPd+dz2pk3akpmGc46SnthUDw69xxqQ
	 0pYqlb7QQkNRA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
Date: Thu, 11 Apr 2024 20:27:21 -0500
Message-ID: <171288524177.749915.3224551491309677040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211202700.17810-1-ansuelsmth@gmail.com>
References: <20240211202700.17810-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 11 Feb 2024 21:26:55 +0100, Christian Marangi wrote:
> Add QCA8075 PHY Package nodes. The PHY nodes that were previously
> defined never worked and actually never had a driver to correctly setup
> these PHY. Now that we have a correct driver, correctly add the PHY
> Package node and set the default value of 300mw for tx driver strength
> following specification of ipq4019 SoC.
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: qcom: ipq4019: add QCA8075 PHY Package nodes
      commit: 2338f4315f16b937e924ff679b91bb8c0ab53f25

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

