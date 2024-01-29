Return-Path: <linux-kernel+bounces-42548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C98402EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A781C221E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D515F55E6F;
	Mon, 29 Jan 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9u35mle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28700537E2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524767; cv=none; b=iW5UORXV6QrSkRlEfLy64dYrHXcdAWdJcQttYQtoPcAHL76oQHB54UjGiI4k4UEYrABnJtHcmHmL2w+Nej+JvVBy2UaXgcPhPNbmlwcNmYn1aMz89ztkOTE4+F8XPy3QcSKm0Uaxzlt9FnD5Jx0Txi/zjB2rceSSbx+ja/4/SYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524767; c=relaxed/simple;
	bh=ZtUBCi9XIZuwuDTg6s55jPiMw3sTTY6gvTY3F6eAwJQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o79gYEQqhHOoMCv6Ia5Ivv2YJUYJJZqAOmgRngKYNcs2PEeGBSGf+3V5oN/Xpk2oiU5za1VHide4wzM+lirnRa4Ge60XXeJxSC+Uio00EtTbDYO4OyskMpVbLPHLTy6+Krb5oyl2Y3WEdwi2Uet7WpB7+Aj1OAw23D1IAyh9hI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9u35mle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19190C433F1;
	Mon, 29 Jan 2024 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706524767;
	bh=ZtUBCi9XIZuwuDTg6s55jPiMw3sTTY6gvTY3F6eAwJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9u35mle835jprIpONX2W0+umzTKqsmHhfY+HoJ9nnxxW55pRozt2az/PNp9cFd3x
	 f8isKhmOjaP20sip49Y269Fzwful2gHGFn2Ka7cJingoUUZ3ixHYqkFWl8qI4Ea6hB
	 3HLufF8lKMJnEJowl5+B9Cag1MJVW5aDEUSVBwQW1qPi5Ct5k8NWwqHJwagI3RZJB7
	 5cyZ7fl7w2CLxguhOB238vG9zfnRY7zZ7nuuwQjUoqRe7PlSFQVBMQCF8J78F1fu5w
	 R5dZt6CRu1C9ScOCpx9iWMtTqDUEFEmiuybqd5ncgNAoTWTE1BIoxY5Us17cXH6fhn
	 /mUqrto5E07ZQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jan 2024 11:39:20 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Inki Dae <daeinki@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, DRI mailing list
 <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael
 Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <b18d88302acfca001a6693d78909bc2a@kernel.org>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org>
 <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
 <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
 <b18d88302acfca001a6693d78909bc2a@kernel.org>
Message-ID: <795e2da5ae251321279920ee57c3d033@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> Also merge commit 663a907e199b (Merge remote-tracking branch
> 'drm-misc/drm-misc-next' into drm-tip) is broken because it
> completely removes samsung_dsim_atomic_disable(). Dunno whats
> going on there.

Actually, that merge commit looks even worse. It somehow folds
the original samsung_dsim_atomic_disable() into
samsung_dsim_atomic_enable(). Therefore, now the enable op
will clear the DSIM_STATE_VIDOUT_AVAILABLE flag?! It will also
never be set. Dunno how to proceed here.

-michael

