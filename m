Return-Path: <linux-kernel+bounces-2798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD9816206
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B45B21BFD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253F482E4;
	Sun, 17 Dec 2023 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaRx8pR7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C1481C9;
	Sun, 17 Dec 2023 20:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F7EC433CD;
	Sun, 17 Dec 2023 20:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702844669;
	bh=MrG/J4jSnITze5df+wa+7cDGeZH6SCd5BYEjWk2JkVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaRx8pR7D28+3jAmOCeJBJwlsWAaASm4yiy2dshGHR8hWNw/d+U4QzI8ksagI4I9h
	 rUyJOSL6twEuv4QJp2uYsNfqYbojPpLfmYl/qboU3aAfH2m5QUM4LY/i7fqJSePf38
	 2jAq87zRjscdNH8fzpZ0A9Bh2nNbdaYCrW6nXOKVbiZAlKtmX7sHBlz9055KIAtaFg
	 FXKlJRyFUsRxktrhDI7tTb92yKdz7RjFIzimOjOdhceZn3qDpsTPm2vdW2n+reI2mQ
	 bdOqIFXrPHcfRcSIkcWsmauiklKH4K628PbH3J9sq3rijdHoaisuDlZg/7Bmc57psk
	 z558be2sNbn4g==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Samuel Pascua <pascua.samuel.14@gmail.com>,
	Iskren Chernev <me@iskren.info>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: Re: [PATCH 0/3] Several smaller msm8974 fixes
Date: Sun, 17 Dec 2023 14:24:24 -0600
Message-ID: <170284466202.74678.52820815256260449.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
References: <20231217-msm8974-misc-v1-0-bece1ba2667d@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 17 Dec 2023 16:22:52 +0100, Luca Weiss wrote:
> Send some smaller fixes that have been sitting around in my tree for
> some time.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: msm8974-klte: Remove unused property
      commit: 32b075f8a2d4fefb8d791431606930883a5d5f15
[2/3] ARM: dts: qcom: msm8974: Remove bogus cd-gpio pinctrl
      commit: 1522b3bb306986e2f3923152a05939176b2a8a0c
[3/3] ARM: dts: qcom: msm8974*: Re-enable remoteprocs on various boards
      commit: 648002a27c6b3ae293cc415e1fbf20aaa6af8bd3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

