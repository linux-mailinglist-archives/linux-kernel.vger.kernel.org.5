Return-Path: <linux-kernel+bounces-152644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314208AC1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E035B280C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB357307;
	Sun, 21 Apr 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/2/eTkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8156766;
	Sun, 21 Apr 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738596; cv=none; b=aa/n+PgBe3t7VFTYBIcrKQuJ1hhCA/A67boDrTs+C0akvthPIxmg7+u4RD4zRzOxNopPOuz/9oipAWboPkfLSNqoMyUcHQiAsDnqkn+jQJqofqTUipzB+5QPlD72MYo3i3hyzl7R6Y88pg+qgKVCQtDkpzQwbXWVhgNpjHBch8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738596; c=relaxed/simple;
	bh=DJ1KbGDJb8gpwYCrAcJR756b6o63hEXu4cCgzBfV/vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyWtA+wufQplF3QQcQxFD6OJH3DvwDov5uQ3a6gpULf8wBrPnOTiEAVq5JbwSOHnDV95E/2Swln2jIKnyu+q+W8ddcnf0uqP+S7OGbXe4Tu6ELi5d1ZuI1WJSKGNIVzfdxINIPksoPrJI4hz5mh4LrvJEa8HUprDBelsV5FG+mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/2/eTkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474EC32783;
	Sun, 21 Apr 2024 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738596;
	bh=DJ1KbGDJb8gpwYCrAcJR756b6o63hEXu4cCgzBfV/vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/2/eTklgi4dB1YeCS/grDCfKe48U4aLE/3YXOkZRiLeHeqNPCgp7LbiQ374tPhSO
	 vBGkRwEBHp4JTXBb/mEElllBjnoexOgde8kTIw+tNCDabFejbb/VPzxywLtvD0z8vt
	 /RlVbxATZ7ZWixlUUUXVegftdhJyjxvPZNP8/23NJ9y5m2S9bpp1cTM+ihh54zmarE
	 qXD+MV6jVYMP+S4g61cKaxj1tNmntrDcphAFbS5mHsuph/PpxcMjQ2azBQ0EASezZd
	 qZ6SRT1ievi/Xa7+P1pdgZQFp2XbPPeerYmZvmUI7GCYFZixJ1wRN7cvdwK9iNSZqg
	 uUqxXJuWhGy6Q==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-kernel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakob Hauser <jahau@rocketmail.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Nikita Travkin <nikita@trvn.ru>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: msm8916/39-samsung-a2015: Add connector for MUIC
Date: Sun, 21 Apr 2024 17:29:30 -0500
Message-ID: <171373856764.1196479.9685154896470551087.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215122605.3817-1-raymondhackley@protonmail.com>
References: <20240215122605.3817-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 Feb 2024 12:26:17 +0000, Raymond Hackley wrote:
> Add subnode usb_con: extcon for SM5502 / SM5504 MUIC, which will be used
> for RT5033 charger.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8916/39-samsung-a2015: Add connector for MUIC
      commit: 7c4b3191b3cdb01f69bb5c1323fe67e018e7b9f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

