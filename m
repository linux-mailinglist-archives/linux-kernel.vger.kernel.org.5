Return-Path: <linux-kernel+bounces-55949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE884C3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14504285817
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF820337;
	Wed,  7 Feb 2024 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOPz6F0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8E20319;
	Wed,  7 Feb 2024 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281221; cv=none; b=UCpC/+ca8zCvA8MBYjVOthvzWEtVv4TDwp2TINoSNWZjFY9v2FpTlPyjnR5ElpDGPNgGK5igsSFIAABXVbIgPKhfzk3B7/OUwEtBGOeR6KiuaUWCR0XMUsCAdVVty8k9RwF5rT2Smbd57N6qHdXFQWKcugfpd+TK5vMae6HjQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281221; c=relaxed/simple;
	bh=xuSaL9WMpsa08OcWTc5eN4qGpXKlxlY/+CVmWqnsS5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdWSLucnsJrs2wnx9rwltSkrIMYnOioVjhedILtyE3TfNJ3tUU+wa/y4pyw0rWOklyJmxD/jskhOly0O3zX/bYrDbuz+ZCoLAmZpJb0pvBY2heEFghVmg7Bf/QsPMdcTb5PcnkktbEV+4XjYZ7rdFLZ9H85rP2PWMqIFlnwB93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOPz6F0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE082C433C7;
	Wed,  7 Feb 2024 04:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281221;
	bh=xuSaL9WMpsa08OcWTc5eN4qGpXKlxlY/+CVmWqnsS5Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OOPz6F0KpR0VT8rN8UVG0lmT+nsn1ojGjBGjs+E0QQRy1jug+nMHaHXCmW0fWWo5U
	 bOs+GMLSlPZ+l784jnzh/WwGQOoeWdYGR26R40zsq1D84nJv+22I+ZfUnd2u9z7SPz
	 5FK4/6Th7DlC1d4JdkluGtb0TvTFZSiUrza4bg29qD2Vq+x5BmNuIES2zFaMFhij/x
	 WbTZaAVbZXDDgFu7G0ROIde8NC8qAW5eEcsx9ov8xb0EJVF6zIneFNOzPgqhX19fQs
	 3PzwSyAJC6vQQfwRJVpVEeUmFHOAf0sio8hd2QxGpTvOq918/AmqLY3D5W30uf1d0X
	 y1fne3nfZahKA==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Isaev Ruslan <legale.legale@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: ipq6018: add QUP5 I2C node
Date: Tue,  6 Feb 2024 22:46:24 -0600
Message-ID: <170728117668.479358.67804220618568249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
References: <CACDmYyfOe-jcgj4BAD8=pr08sHpOF=+FRcwrouuLAVsa4+zwtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 15 Nov 2023 18:38:53 +0300, Isaev Ruslan wrote:
> Add node to support this bus inside of IPQ6018.
> For example, this bus is used to work with the
> voltage regulator (mp5496) on the Yuncore AX840 wireless AP.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq6018: add QUP5 I2C node
      commit: cc3cfef3e3d942f73fe8adc26105bccdb296ec52

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

