Return-Path: <linux-kernel+bounces-87176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D586D0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEA728C3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BDB70AE8;
	Thu, 29 Feb 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edSCxE5E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B404AED8;
	Thu, 29 Feb 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227943; cv=none; b=EtmTkG0oOZeggspooNjs3y7v1ERNg4bydMVITjq/9c/+wPqkozWAtCZVhn57VG6JiRuNmg8pcd0ZUA6SjknCnzpN6vLGLtdqmdp9MZWQXsXUVl4MyMgHAXNRBkZqBDDr/LOE96oFEVU0gifP2lXMilSDi2AI+fUOqN026k7Ve4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227943; c=relaxed/simple;
	bh=6bXIeVlR0GAzaKfFhUu3O2VlxKDhrflLZZpXxWA96DA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ntFr3j6ssecYYHh66/XAxSZjpzP1J3PziBfPgv/pn5tZm9PxTv8QbpzmGR95UluuxtEHTnTSaVerkmp2d/cav7WwK1EyRacqrxjwi8xJrXA1OKU/peC+Q4+BzXiUE2ErrACkQzJDG89S+0GTUOsoAV6+SrbZz6YCPOAWppHSQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edSCxE5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289C5C433C7;
	Thu, 29 Feb 2024 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227942;
	bh=6bXIeVlR0GAzaKfFhUu3O2VlxKDhrflLZZpXxWA96DA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=edSCxE5EhsVAGbQ0T7jh0+bQWa3i5pA8Fs+XchkY0tQyQq9CvX5CUWMjbCP52UaTI
	 fC+xcQkkdcj88vz1DUAvTMqkaWkCkeq79JG1vtF2WkX+nLz+xhZ3kkbeWh9xaLDWYR
	 EjBYLjJqgoMB3UTnKNemEFvW/GGTlMF4fOt1rDKMh5/Di2j7wBvTOQjcTC5d/mVsXz
	 1dM0CXojJeP3cEw3GJMnCJsc3LFWLNWGK/bODOWrVVqztxkXHzOsQCOMvbbaf8bC5I
	 dz9MBtjtfsGUgZ7Ge9yXbROHwAqQrpH7XgKa0TFPHzhzi/GnHbyU6nB1ayK5PBo1vf
	 rF3FHOAuBlrfA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>
References: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: qcom-lpg: Drop redundant
 qcom,pm8550-pwm in if:then:
Message-Id: <170922794089.1621047.4298674249267222601.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:32:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 26 Feb 2024 08:37:12 +0100, Krzysztof Kozlowski wrote:
> "qcom,pm8550-pwm" is compatible with "qcom,pm8350c-pwm" (latter used as
> fallback), thus it is enough for the "if:then:" clause to check for the
> presence of the fallback "qcom,pm8350c-pwm".
> 
> 

Applied, thanks!

[1/2] dt-bindings: leds: qcom-lpg: Drop redundant qcom,pm8550-pwm in if:then:
      commit: 3cc566d0a66dfcf929fb01154ac66e798106261f
[2/2] dt-bindings: leds: qcom-lpg: Narrow nvmem for other variants
      commit: 8bebf994a972369e327b1d3e8fb1a43b25d0bd09

--
Lee Jones [李琼斯]


