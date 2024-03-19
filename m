Return-Path: <linux-kernel+bounces-106946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD487F5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35581B21DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151780638;
	Tue, 19 Mar 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AivIkT7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF07C085;
	Tue, 19 Mar 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816555; cv=none; b=selNE+Nh6OvtPCC+2Adw+oFv3T4BXNwb7v500En+S240Y3fCEkk9XV5j09Krg69AcZ/LY3rdkVjtXVjKGhctfa+h6EpeEqpnNXMuMxR1HfgulOa88a/JfSql3JrF1GfireLoY6VDePTKW0/NHejIiLiEjZmYx99mtXRC0ac6UUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816555; c=relaxed/simple;
	bh=8USZTzteAjV0B2uELdNk1xEh2fo7mLqO6fX5+kbNrmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bU/R0TZjT61q/xK1Z+Lhn/gyC3Of7SmbOC4QPMyA91d66VKINWQYjOmkgFqs0q+JgUnWERBS9ClcUqaDISeskUSkLl8LLBSHgjMmfzDLd5O2tW3dMhGHUu3OasiD8rLf6ZizBFnHGGb44oBIPBpDbf2MIiygebY9MPRBX9whH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AivIkT7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7343C433F1;
	Tue, 19 Mar 2024 02:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816555;
	bh=8USZTzteAjV0B2uELdNk1xEh2fo7mLqO6fX5+kbNrmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AivIkT7SYtHpZYtcDx8/r01WhGs/OJxwJ/MeMfCmSTlNzoSwbdv3RXJn7nTz/FZjn
	 foBuBoJP7q7lDGKAidK95GblRUdNFZJ8VYv2/hTKVRORpg1Zws7QKcn0aqre1i/dqK
	 nEsEjVVge7JecD01yeivJiLDhw2BlqRiRIH91nowrvSItLZWRDpBwqGx7Q0zOtStum
	 epm6xiOU92S6tAVy6GcEthHVj4feRaOnZacnAf0b4nVn/TTWfhP7D/2UHtncM2T9qu
	 ueT/vxaACGyMiUetrm7t1hRxtkM2tbl1VmedTPUdND6YwQSlSqELSme7/qoBHSoxMk
	 OfOeODOwpjq4g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hui Liu <quic_huliu@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and Power buttons
Date: Mon, 18 Mar 2024 21:48:45 -0500
Message-ID: <171081652658.198276.3509161510345353918.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311-gpio-keys-v5-1-08823582f6c9@quicinc.com>
References: <20240311-gpio-keys-v5-1-08823582f6c9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 11 Mar 2024 18:09:31 +0800, Hui Liu wrote:
> The Volume Down & Power buttons are controlled by the PMIC via
> the PON hardware, and the Volume Up is connected to a PMIC gpio.
> 
> Enable the necessary hardware and setup the GPIO state for the
> Volume Up gpio key.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and Power buttons
      commit: 511b4858dc8a1b4d857dc847976a5481c9b367fa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

