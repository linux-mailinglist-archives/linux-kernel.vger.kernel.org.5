Return-Path: <linux-kernel+bounces-58196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D159A84E297
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101561C27064
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464578B6F;
	Thu,  8 Feb 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN5oFLSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632857992B;
	Thu,  8 Feb 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400572; cv=none; b=i0iadGqiFze3kDfh32Ikf+T718KfcHMFGk4qZL9kJtn2NrhxEiJhn8d04j4lVzm9MyRpLXSIWSN6HNIxp7wMGCAkY/Ml5E+IG/OqHZrWdhgZ1N3MDBgBR/qGvh4NL5AthRcqhMZU01XSP4AF5WtdbsgaXfrSF9E7ZKAKZjeMCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400572; c=relaxed/simple;
	bh=82CzqNnogb9XCv5sBHsnHrp7dl4pVkzbukdyXCcKFOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=haExW+7yasxkz7Wz+bU5LGbvyL26RSWgux9bQILoGQ4Q2fPcfuPFCZbQpFQhMMbK74zb+g8VS3SzT7+rRDAdedU80BVFDsKJfnxCox5f918sx5BgH6fbhObdPc5QIm2r5D+7jURVCch/6sXkxzHUI9pHzQcBwMIlY5pffeDDwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN5oFLSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57088C433F1;
	Thu,  8 Feb 2024 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707400571;
	bh=82CzqNnogb9XCv5sBHsnHrp7dl4pVkzbukdyXCcKFOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mN5oFLShcahVjZtJDtLTzRDrmx9ahF+OIfTtUPc47BGL25V4TpeXWgc5H+0hJhc7d
	 3fiddBPUmZx2vjd0bKfE8VK72tc5PY9D8jE8uoI8ocbzbFPIUXULTnysiEueM9oV/f
	 Fo4Z1/pvbO+rzOOHJYyYrWHPRD+JzdnKM7zUw+c7WtWCXCoJZxWLxK4wIGAErkEEOV
	 Q3tynK9I0GAYOxMZfFq7vs4DpCpH77bnbBT7N4Wd9vrM4ykpcvU5VQ7TbZ5pO/nU88
	 CAuXYNbfClUFsqwqEZ8YR/hrJeToikcA0g1l758OSVgx2Bn60q/YADyivhifIexUGv
	 SvRKpsYNT+F7w==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Andrew Davis <afd@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240205174736.27749-1-afd@ti.com>
References: <20240205174736.27749-1-afd@ti.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: syscon: Add
 ti,am654-serdes-ctrl compatible
Message-Id: <170740057008.1047281.7613076529270827979.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 13:56:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 05 Feb 2024 11:47:36 -0600, Andrew Davis wrote:
> Add TI SERDES control registers compatible. This is a region found in the
> TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
> SERDES clock and lane select mux.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl compatible
      commit: 95e11742e8e46b049b574f99d919dd118362c49f

--
Lee Jones [李琼斯]


