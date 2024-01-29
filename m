Return-Path: <linux-kernel+bounces-42105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD6E83FC58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729161C2197C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C25F9DB;
	Mon, 29 Jan 2024 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA65APc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616BAEECC;
	Mon, 29 Jan 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496166; cv=none; b=oJD32yfYe4TpGyIPaAMdWNPGQ9nTF+N+ctIsm89NZlhS57ovaJ8MSSlcYPOc8MfdBmZFa1o6E6mGaQG3Ed2TELtQmRHBSkYiuT9MIqnIaJGVpWUpHo0ZtwF1Uz6SHqOIhbUAHFwooT2tMdz7MCcN3WLlA3TZaoHdHS3HWVeL6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496166; c=relaxed/simple;
	bh=oSInDhdGSUJ6TpRTGQtb0omDWXuT5kvGFHgM3DqsxHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzPW+4ZVmVhGsgMvp2MUGPIM5SRtE0NauDFobMZN5qo6Y6TPy6ZwhN/KYZl0bW7UOIJuaA1S0y6sWsU9yxGYC3dJ5ALW5Tdd8+hePAc2+9BhIKcbNfmRYhnHQ2b53gWMNAWmJH7SWbN1+zDfL0spFZC7Bib7/aGXgdfuKgLu/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA65APc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80585C433C7;
	Mon, 29 Jan 2024 02:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706496165;
	bh=oSInDhdGSUJ6TpRTGQtb0omDWXuT5kvGFHgM3DqsxHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qA65APc5TfM+yfhh2St47J2+R1gW0iKtbOpEApDSmyXoRkDSwuFynykLxY6/olvzT
	 9SKgw1u4PjtZMf5Y3kXt4DnljNqxb0pgX13cFKRFecqXoRZFs+/j3K2C4mioXHDLY3
	 AgpeZPAJOhpk6NvdohDoTDTsw64c2QjIVPE+N412qliKiWYU2dm6ehLHC62UqfYgqt
	 8JParKIWu3zVwT6V+LBtWpeclMAznVSIho66PN2MO2pkxa2H+BiM22Bu0iQB/wTXsi
	 +WIDZQGG3MrCyhetnXwgix4yqh7ybDffskKMxrT9CSgF/2+Q5u5+4FVJyWjS5Ue/9V
	 gSDEhCQkLHBRA==
Date: Mon, 29 Jan 2024 10:42:41 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 1/3] platform/chrome: Update binary interface for
 EC-based watchdog
Message-ID: <ZbcQoY7q1nuiv6Y8@google.com>
References: <20240126095721.782782-1-lma@chromium.org>
 <20240126095721.782782-2-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126095721.782782-2-lma@chromium.org>

On Fri, Jan 26, 2024 at 09:57:19AM +0000, Lukasz Majczak wrote:
> Update structures and defines related to EC_CMD_HANG_DETECT
> to allow usage of new EC-based watchdog.
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>

If EC_HANG_DETECT_MAX_TIMEOUT has been defined in [1] (which isn't yet):
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

[1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h#4749

