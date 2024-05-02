Return-Path: <linux-kernel+bounces-166777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88C8B9F64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C011C2288C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99116FF3E;
	Thu,  2 May 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEw//myQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756CD13C820;
	Thu,  2 May 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670612; cv=none; b=GLk7u0kVSFyrcUUtRFmbAT+AMaXSuzQXneH5ahxDCXlDAXlMEWozyAiFZTUSMhPnHJ2++rPHC4UQUJGQ/CSgoTcILQMxcTZoV8NmNg505EqIObG9hBq2PyUGl0/TDYoMz+m2HbFs1ou9B64c6K45d4TS16dHPA3nU5T61ezi7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670612; c=relaxed/simple;
	bh=VnsaxWRKYnVr47uFHyKJNESO4A+VCX3F1VXJeDiJ/wE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b7u2DUgGxKeiTq0VmDg2bS+XE/lgpYWbiYHsEkineELJX6tY0hEO5CyBDb1ZMFyJBvlAaxy7zb6qa38vDVL4plXIcNrMSnLbi0qF1oN0neqidFsWJIsuLGCoNGTP0+uzBhZhihW6iTxJ6cpU9KS9yXqI/8lH1T9t5FL+YF6987w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEw//myQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0581FC113CC;
	Thu,  2 May 2024 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670612;
	bh=VnsaxWRKYnVr47uFHyKJNESO4A+VCX3F1VXJeDiJ/wE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pEw//myQGuRYUqtOXZmIxXyH4H0J8VfltjfUEy33nM03vSVHns36q/Bjn64wncMoI
	 rwzMZJVErkdkTx8k+ppDCwWTrsXFKHtC5L+9XiJnw6VL2dMRM04xB2sPTiZAr+2r6I
	 3O2v8YpabggFwN0qP1dYNJNNKp3Q/CoJOe8Ob9VaxBrTN5Wt0byFZlanRNobwQsZhc
	 JqoVg3++raHpIwZsZgwxtCQDiMwHeUB8K/wo1mWA0sFjaeSwVYOOgimfHt7GZQjW6c
	 +C3s9FbIV5aWZH0Y92nf03YMyI4PZ7DlEFS6dP0iKCYXIJgO+jz+CkPoNj9MuhIlgZ
	 MjM0Y0hEu9BiA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240430172520.535179-1-robh@kernel.org>
References: <20240430172520.535179-1-robh@kernel.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for
 pinctrl node
Message-Id: <171467060972.1223907.593520549880230505.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 30 Apr 2024 12:25:19 -0500, Rob Herring (Arm) wrote:
> The use of 'oneOf' to include 1 of 3 possible child node schemas results
> in error messages containing the actual error message(s) for the correct
> SoC buried in the tons of error messages from the 2 schemas that don't
> apply. It also causes the pinctrl schema to be applied twice as it will
> be applied when the compatible matches.
> 
> All that's really needed in the parent schema is to ensure one of the
> possible compatible strings is present in the pinctrl node so that its
> schema will be applied separately.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
      commit: 8f553c27697bc5e11074e37dfc0def6e39e489b2

--
Lee Jones [李琼斯]


