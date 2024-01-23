Return-Path: <linux-kernel+bounces-34803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A023A8387A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED85B20EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FA52F90;
	Tue, 23 Jan 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlcoJ8v0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17D51C5F;
	Tue, 23 Jan 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705992199; cv=none; b=pqzjB9LS1M26MXkM9je1mcaxCo1TunYK2VlItsO7veblwpnUon5t8aYhEISXzX8ehCbMzzHSdtXlK6g09oFNQzkMQlERGuqenlaeQv/8jlyl4YJsSLu+pBX8/VmEG6+YhKGPJpVF6Y/mgZ0YuzHfHe6heY+DgEBf0H5Hcbkrud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705992199; c=relaxed/simple;
	bh=HbkqSj51Sa9IVM8rrG6Dn3HDORo0yZkDPCYmR5xjh70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q+OeYK7jg4lfcG9dY7VWpDYxOyJeaRza4EdfHvu4lWoVTokWm+dKL2A87/vZykQmPu4ulVwxcvhNafkySp/EphW3Xqhg04FFIcN/1cG418uWJ9R1MKOm60YW+RtpJWr2T4XAyfX+d5sd7UYPGZe7YVIxurOYyXTCHBf5nS880hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlcoJ8v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2F9DC433F1;
	Tue, 23 Jan 2024 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705992198;
	bh=HbkqSj51Sa9IVM8rrG6Dn3HDORo0yZkDPCYmR5xjh70=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=XlcoJ8v0nu8rC+uHVB5h0kPyNxuobFe8VQ5uLmBbp3Vk675yMEVCAq2fZnz567Joa
	 oX57JdBbRJTuuOH73LI7nkm2OO7OGBH0JAhGrh6ITurrnpy2koeCODl8MPY4sCEQAe
	 8R5RxA9118ngGfe7IzXCKNwN6TLAv8cWBJEBS8EzOqQtRCqIbw4cODWU92IIkabYQi
	 eaQUAbxdOVN46JgncZMBN4Ei0P7cn05hj8l36mvl2F8ARlkgTjvA6Ab6yu4AYlW5Bo
	 G25Udk+lF+7kDovEZ63ttvOCH3Xe8Md4Y38/x8CsFnv4tSCYenf2zi72xRNTYa/1+D
	 kIl3deicFaadA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69EC47258;
	Tue, 23 Jan 2024 06:43:18 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH 0/2] Add PM8010 regulators for sm8650 boards.
Date: Tue, 23 Jan 2024 14:42:22 +0800
Message-Id: <20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5fr2UC/x3MQQqEMAxA0atI1hbSOhnFq4iItNHJQi2NiiDe3
 TLLt/j/BuUkrNAWNyQ+RWVbM2xZgP+N68xGQjY4dB+0rjK6NF/CIS4NWhz0iHFLu6kJPdJIPlC
 A3MbEk1z/b9c/zwuY8LXjZwAAAA==
To: kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705992197; l=642;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=HbkqSj51Sa9IVM8rrG6Dn3HDORo0yZkDPCYmR5xjh70=;
 b=FAllM/If3g3hJGSiylVVhhgt1gWcFDF1jpAg5NjShOSW0/QP04BOrFTOagJ+zTaTG+0FVqUoQ
 SGV7RWOr5kiATAwgy7btqMSYHKQNWmRwIBBfG4kSu094FjMvKvIgGvL
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Fenglin Wu (2):
      arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      arm64: dts: qcom: sm8650-qrd: add PM8010 regulators

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-sm8650_pm8010_support-750c05a5cd5d

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>


