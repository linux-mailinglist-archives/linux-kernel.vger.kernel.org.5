Return-Path: <linux-kernel+bounces-75631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3585EC84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8195E285A67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73C12BEBB;
	Wed, 21 Feb 2024 23:05:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410986632;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556741; cv=none; b=FBiMGLLQHSK4F/rRiG8b9doWVAUzYT3OKUavKOwzBm3eGTWbDXg6mvAuEq8wCU2BcVZnaoWx62/nND2z+c5iXss2gjwcOAombegt39DHd4VbXu+3CmH1I2OfGNK8dY9sY/OCgX4W6bUuW7RtA+hF9qnDGnL3VrnGl4w8nU1UUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556741; c=relaxed/simple;
	bh=LAAbCC+QCTemFN3gQPcvPRW68/SdYRMsVBiAYhtn8Wg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9/1JcWrtOJa0qb9cw8vAzOkRQEh9zLh8es8PymU05c/+BBH/PqaTMBofvf8B6ZLSS7aa+zN3YsdWrJ/XHyOmdbKMQDHE7LUZ3P/TZsW8Hchfl4pX4aw8sYAXf1OzwPlCG/lrfrl2kdcD5i8+w1aXmkrb7/vdBnzyumm6c87zQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAA7C433C7;
	Wed, 21 Feb 2024 23:05:40 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id CCFDF106B79D; Thu, 22 Feb 2024 00:05:37 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Davis <afd@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
References: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
Subject: Re: [PATCH] power: reset: xgene-reboot: Fix a NULL vs IS_ERR()
 test
Message-Id: <170855673781.1674060.14659779619103169462.b4-ty@collabora.com>
Date: Thu, 22 Feb 2024 00:05:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 20 Feb 2024 12:02:22 +0300, Dan Carpenter wrote:
> The devm_platform_ioremap_resource() function returns error points.  It
> never returns NULL.  Update the check accordingly.
> 
> 

Applied, thanks!

[1/1] power: reset: xgene-reboot: Fix a NULL vs IS_ERR() test
      commit: 62f4b33bf2b966035420c3e211bfa37f697c4d1f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


