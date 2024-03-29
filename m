Return-Path: <linux-kernel+bounces-123936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D066F891001
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F6C28BD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC22125B2;
	Fri, 29 Mar 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiNjuOuf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A94FF9F5;
	Fri, 29 Mar 2024 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674406; cv=none; b=Z0HqfjAlUWlM77iT4vC+sfYhMZeqB733XpuTzS7q7VRkKV2VgbjQbz7M6lnSCWNnscEfABjmHQPzeoXChENReBl38y9DNJGptEP3B2Lu0UREQek3XruTK6j7LDvo5C/Kuc1wCWUdd43iG7VPSOSEG+2ObQX11RzgTsZQS1odqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674406; c=relaxed/simple;
	bh=DMYOlN+V/xU+7yMkSGCmldEtFZxBdXtHIsaBi1vE/bI=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Subject:Date; b=UiyIzZJvGi40/yewNC00ovMi2aGembFrtdvTftlkNvYcY6x/jz6e7VlLHBl6vAe7H+zocScEbARKL2qjDWJxXdPwIFELNyPx84Y+Xv8nEivV+iuWsyZfXgvPyF/17xLnP3y43fpP19vBOKemgiqWVz5Z7DGJ/69Lc/bfflm2OiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiNjuOuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D63C433F1;
	Fri, 29 Mar 2024 01:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711674405;
	bh=DMYOlN+V/xU+7yMkSGCmldEtFZxBdXtHIsaBi1vE/bI=;
	h=From:To:Cc:Subject:Date:From;
	b=DiNjuOufITECihQO2wQ8Of6yEnAq+KqQh/g99p4Aq6lQSSsqg09Vefj7Y29aivse/
	 NepX+2rlQl7DBzpYAAY10KiDE6zp4vcJXXh0ZkXBtdNKu+6h6SSzX01zN3cPa4pifp
	 7TCmgTnSdLtNnplwsTjJG3Apyyvjy9G1WdZF/khTuUSK1EJn3arCxwjW4iQyZaF5/Z
	 PwpPu/5WtdrkTUzjxhwtiLhMmH5/2qjzrXQyiCEBkokbH3jZSqBCDhL+lAkF96bgjH
	 jCDoFRrhShKEl24POzeWnYq+AUvRwmgOKErgjpY5PSoMGH3uxqjtlO+N2GtWbyccJo
	 pGJhF6wDLFd3w==
Message-ID: <9ddf393a481f2caf3cdcb7b1a9e5c80c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Stephen Boyd <sboyd@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>, <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Add clk-fixes branch to pending-fixes
Date: Thu, 28 Mar 2024 18:06:43 -0700
User-Agent: alot/0.10

Hi Stephen,

Can you add the clk-fixes branch to linux-next's pending-fixes branch?
Krzysztof mentioned that it wasn't in there and some CI uses that. The
clk-fixes branch is always merged into the clk-next branch of clk.git
and usually it is fully merged into Linus' tree before the next release.
I accumulate clk framework and driver fixes on this branch and send code
from here after the merge window closes.

  git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git#clk-fixes

