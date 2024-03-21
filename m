Return-Path: <linux-kernel+bounces-110186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AAE885B46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CD61C21D44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD08613B;
	Thu, 21 Mar 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve8saih7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393984FC5;
	Thu, 21 Mar 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033197; cv=none; b=flJ93Wy03UhurcAo7dcBNbkMMZvFfwt0KX15ERSfJznkaxBIkk5DHRfqF7KNSmWZCq+Zi1Iac4JcEHjHN4RwC7waRj0Tg/0hNlJvhiMfzDHo6bZLVfvSv0HLHM1odcxHyz+dHUqN1oVj/VrCrgisr6iNZi9tEWkMDSjrJHi2Q7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033197; c=relaxed/simple;
	bh=QfTBa6Jq2tL0XdM9ma6XrXl+buIzJ1XE881t6neWUEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bGOIJRWRXguMKQBrevwTRWsxfyvsD/ita3e6Cs2sV6p4dzL95hooIcSs/7E/PExKF3oSOSGFv+sOQTqh9FdPVExbYYVCiJ4J0sfzSCS7MqRkGOFYDDC0pG2ZAhzQ5uSVW3nmWfoNYVHpv38TpfB+MCU59MkJMGqJp1CexC76BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve8saih7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483A6C433C7;
	Thu, 21 Mar 2024 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033196;
	bh=QfTBa6Jq2tL0XdM9ma6XrXl+buIzJ1XE881t6neWUEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ve8saih7JF2Ck7mMTozEdnAsTkBhx/DjJOEvy8dePW3U2UEnL6nPtUt1BI+BCCSAJ
	 r380KZuY6z9PgkxpzlzGWTQiWfXgqL3JgvkXdHRePgpaDBPXp4zM7U5msdZQhNX2kl
	 OL8IxAV/RRJKdurYGEUOCMXZM0jich4tu7WZbD3TOJxWHiyh0/LnML0wWMviGZ0qEY
	 OWgOTmHVdW7Uj/Qz4Zc/FcUdhXq1mmoO6Ph/HF6Wyu7NdJl8XFnGmkXHSoOpF7cUqv
	 SBeX1IJRac0hprRk4a8J3ayzzfFZ5/kZv6D3oO0je7IElxyWleOHWStUrltZ36wCsp
	 LEuxFNqKCXO/w==
From: Lee Jones <lee@kernel.org>
To: pavel@ucw.cz, lee@kernel.org, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 andersson@kernel.org, konrad.dybcio@linaro.org, 
 Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240306172710.59780-2-danila@jiaxyga.com>
References: <20240306172710.59780-1-danila@jiaxyga.com>
 <20240306172710.59780-2-danila@jiaxyga.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: leds: qcom-lpg: Document
 PM6150L compatible
Message-Id: <171103319402.47386.15024571125365763928.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 14:59:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 06 Mar 2024 20:27:09 +0300, Danila Tikhonov wrote:
> The PM6150L LPG modules are compatible with the PM8150L LPG modules,
> document the PM6150L LPG compatible as fallback for the PM8150L LPG.
> 
> 

Applied, thanks!

[1/2] dt-bindings: leds: qcom-lpg: Document PM6150L compatible
      commit: 385019bc6f0d57917282b634b80d3e359ab50163

--
Lee Jones [李琼斯]


