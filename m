Return-Path: <linux-kernel+bounces-134754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BA89B668
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871D6B21AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AF1C3E;
	Mon,  8 Apr 2024 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpcLU0vn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8123524F;
	Mon,  8 Apr 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546957; cv=none; b=EoYr4LV88nXFkHAj+JV7TDbQZz3G0LEDEFFJnZK8Lt34kgjkzj9u7S0HIEvpu7WGiBwYVAtUN8gN2M1taZDyJFpJ1wvi31IJeY2kR+plYH5bVb/tMMkhzqatXA293eJJ6qKq/u0UpqsfUoR4cbC4lQzhHIiFsCy6WaVNiP1VLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546957; c=relaxed/simple;
	bh=dx9iqr5tIkbizzXBEuqix5gqYfDy6aTqS79L4wrySxc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=G37whAOOXXKTDrKQkpqNf4rvjaYR7SKWM1Q0LLWn7M8lB+WOBAXDh/oLCSWbtswoJT65VORkBUuKBWZqNHnqfnevdqhoOFJsHoPKqaUQC+JDjE+IOTGjzPbPNPYZ3Qith6c6QyWVp7Q0WoBt1fr5bI8kYz04HsofgKctJXMbzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpcLU0vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A139C433C7;
	Mon,  8 Apr 2024 03:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712546957;
	bh=dx9iqr5tIkbizzXBEuqix5gqYfDy6aTqS79L4wrySxc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DpcLU0vnehQGDHiCm9qrkV2adCskw7Ej6mCs5eCwR1m+6MtZ37rJD7ma9jQ5qbmN6
	 sdmJ9ea7XG1v2mNB7QBjgtS+O3MrvItER8TD+/PyT8xYbKSnS/9zLYNzsL+I2IgKMU
	 BmYxwhiJjoRy2UpMhMQCxJHrhFtedUBE1NCTL8Amqe4KtVEpXwbMppoq1P1jD2eGMw
	 H37sSp4j8BBNdXwNZzwWsm/gcaWSE+iTE5MsBjuqlEZHcIStwCq5te52UD9FmLLeGV
	 c141LGe8PEIl/cAUamndrIV5y+0CzsBi4SysqhI5DSCfKMfjC4Mc592HCX692gR/nH
	 8Qz9Pg6/H/eog==
Message-ID: <1f89ebad6dcb2161188354f990d3dad1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240228185116.1269-1-vamshigajjela@google.com>
References: <20240228185116.1269-1-vamshigajjela@google.com>
Subject: Re: [PATCH] spmi: hisi-spmi-controller: Do not override device identifier
From: Stephen Boyd <sboyd@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vamshi Gajjela <vamshigajjela@google.com>
To: Johan Hovold <johan+linaro@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Vamshi Gajjela <vamshigajjela@google.com>
Date: Sun, 07 Apr 2024 20:29:15 -0700
User-Agent: alot/0.10

Quoting Vamshi Gajjela (2024-02-28 10:51:16)
> 'nr' member of struct spmi_controller, which serves as an identifier
> for the controller/bus. This value is a dynamic ID assigned in
> spmi_controller_alloc, and overriding it from the driver results in an
> ida_free error "ida_free called for id=3Dxx which is not allocated".
>=20
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver=
")
> Cc: stable@vger.kernel.org
> ---

Applied to spmi-next

