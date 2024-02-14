Return-Path: <linux-kernel+bounces-65741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86B855103
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95D82926E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050A129A9C;
	Wed, 14 Feb 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebJQy62q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9E129A74;
	Wed, 14 Feb 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933469; cv=none; b=srHxg1vj57DR5Hvn4kDRLeaLNNaI48EWXkJ28XViZm5PempmhDLQZwOkuxgx5jU+xqpSKTDJhSPp9V2YcJ01tTX+pB7xf9cLK8DCK3RxtH5QtYGFu4jo0WhqeTAKsHlOr675jKP5TzNc8nvjOJKcT5M7+wvaTuJ5Vydfpyn/rAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933469; c=relaxed/simple;
	bh=Spmgup1gSKpPKodE6SMchsZQLTvq1zqI+bToeeggngk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD48fMT97eNo6seekdKnzI+jTu3UwwXzaJv0uKu2dombPwUPQQzRK1iOvMFqE6yHyRF18bzlromIfY0WnpoOdHTqWtJxwVrdWB5DbAOu6krc2Fec1J+s7NQnsaDFoeST4xzkGWFCbHrABsDvy7JELFSXGh/ej9GEBBBPqz7k2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebJQy62q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B112DC43142;
	Wed, 14 Feb 2024 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933468;
	bh=Spmgup1gSKpPKodE6SMchsZQLTvq1zqI+bToeeggngk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebJQy62qyEuwDtrokrH29HCQ+pNVSYz1ZcfsTQAWP7TagXld66wG3nZa6G1jtHMkq
	 5mMRPnr5UmLReTb8rroUJHlq+byb86ShfiLYw1oj8Y+MhdXXQ5PWvEETBVdVumJvnO
	 duHFRy7CPW+RMH/kNrCGzGAdM2pJzobkhkEw5kN8Hysk8DgGrMkGpd0kkuvJsVYv+e
	 CxctXBzshEXPBKT4WjBFbpIs4bhTHDLPYcfGYavZKQwc64Zt6ENFidrJ9VUZf4jDWs
	 BnAiQAAeQBREGfcGD9t24ZO/8GqiB+zCF2Il+dqBnCN+WBaPmHNOwDjh/Mh85h4BIx
	 vSItikl/L2ELg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rudraksha Gupta <guptarud@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add the mXT224S touchscreen to expressatt
Date: Wed, 14 Feb 2024 11:57:22 -0600
Message-ID: <170793345830.27225.14356783664499305768.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
References: <20240131-expressatt_mxt224s_touchscreen-v2-0-4463ae0414b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jan 2024 01:04:45 -0800, Rudraksha Gupta wrote:
> Adds support for the Atmel touchscreen to the Samsung Galaxy Express
> SGH-I437. Copies the gsbi3 node from apq8064, which is a similar SoC,
> and sets appropriate properties.
> 
> Applies successfully on top of my previous patch:
> https://lkml.org/lkml/2024/1/20/56
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: msm8960: Add gsbi3 node
      commit: 1cf6313648753e489ece516d05f77b39e52ff07e
[2/2] ARM: dts: qcom: msm8960: expressatt: Add mXT224S touchscreen
      commit: 5936ee212525c7d1221a42e8189932cf42d35776

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

