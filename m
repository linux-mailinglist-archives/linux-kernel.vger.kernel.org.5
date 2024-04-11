Return-Path: <linux-kernel+bounces-141231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A0F8A1B21
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D287B1C20BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF9221105;
	Thu, 11 Apr 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1hBSZP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0B4F88B;
	Thu, 11 Apr 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850662; cv=none; b=FEdh04yPlbPHXQ652M9fdBZADjCfgh+kGHLAFBkuKEqZIAasTLpf/3aJYeUqjWEzqFyxNaQ/4+/ZYzoUdjU7g1hbuNMolwJswBeTk7y7JcBrmRXoOcLhXgB2zD8YVXagFAww48ayqc8CFiaAsUwk8VdqVukFkg4VGikRakCwg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850662; c=relaxed/simple;
	bh=5a8Ggj/Vj9rXkUXznIAW7aZ3v6ArcbbuVb8Q07FRUYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=su7b/hNK8qht0mM/9DpviR7HFc1PtP/1hXAIt1KECmr5EWvooehjJtWErlTs66ZS1PVAenIW9uCyYVvdLgxNeq49tt2O9TlumsoiyEtVJjfuSPlhQGOUCoQdJoyTNETJGd75Clake2QEOFhzdC665NDxOEbSuKD8YlgpLx98Sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1hBSZP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C893C072AA;
	Thu, 11 Apr 2024 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850662;
	bh=5a8Ggj/Vj9rXkUXznIAW7aZ3v6ArcbbuVb8Q07FRUYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G1hBSZP8EM+NU9CyuGee2kekCmUlWdJupViFdAChfuBSInRE9tcvlE4zzI/EkhxN4
	 CkW0HFRsHFcXMbJHEhlq9GFrNtyfoAstDbFSlE5j6rTiizcDiyFTIjtL036n5Crf48
	 enuI5kfPQp6anq87UYZmk4Dk8TwU2ER+jxoRsYuTLk0dbfP8dvI1zCSy5bzD/C+MWi
	 0XKN3vY/mQSFGFzXMyDwFKF8SGzX7iGtcFwj9Bq0doJmv3CqD4VC+SDkOK7J1C7y1J
	 5KHn444sz0hZaRZXvUkgpwu4qJBbn/LUxV3h+vU7cxRjWxbaCrfazRSkkhzZFOA4i1
	 MJEbe918jqxhQ==
From: Lee Jones <lee@kernel.org>
To: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 INAGAKI Hiroshi <musashino.open@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240323074326.1428-1-musashino.open@gmail.com>
References: <20240323074326.1428-1-musashino.open@gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: leds: add LED_FUNCTION_* mainly
 for router devices
Message-Id: <171285065997.2464516.13537165356997238017.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 16:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 23 Mar 2024 16:36:08 +0900, INAGAKI Hiroshi wrote:
> This patch series adds some LED_FUNCTION_* definitions mainly for router
> devices.
> Those definitions are useful for OpenWrt or something.
> 
> v1 -> v2
> 
> - fix sort order of LED_FUNCTION_MOBILE
> - improve the commit description of the first commit
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: leds: add LED_FUNCTION_MOBILE for mobile network
      commit: b65a10938791d90c88ef4f3ecddee22b9fc23b2e
[2/2] dt-bindings: leds: add LED_FUNCTION_SPEED_* for link speed on LAN/WAN
      commit: 03075af4c95133dfa14f434dab3b7b97e6cb9b56

--
Lee Jones [李琼斯]


