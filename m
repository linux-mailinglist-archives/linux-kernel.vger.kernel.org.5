Return-Path: <linux-kernel+bounces-20614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8482826E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370F7B277A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56A25756;
	Tue,  9 Jan 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrqdkFJ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47F224E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97294C433C7;
	Tue,  9 Jan 2024 08:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704790045;
	bh=232TwjJF1Ui9G01uyqDCIoqp2EAkeZW9NrKM8Q/mDxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrqdkFJ8xBDM4yyc7Ibmg5zTYv+Nc3fu0HyRIE95AhwN7WYBJktMV+DDImb/KqAFk
	 zEHn1rmxXgInltwcjglTsbPRV3v/ONuvRPp4UgRp8uBsSqwU1a3+9AUZ6A0WEF+HSI
	 n1IpogbCc3d09kc0a04secaTxunmIWbKVOqZD4GT3vbUCjw9nNDW5YMKZ+mkExaLM3
	 2b/mKoVSr3nJZxwW8uIsJw6uCekrfNi44tNBcVnZtI30hZKa1rCw38JFsDlPf197WB
	 HQGr/i+ZwFl5f5pm8F8FyrCiJNTBFIun6vLCG7xRED08ng2+lCaPwT3i0WY916mWwH
	 aYK/n9teq0D4A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jan 2024 09:47:20 +0100
From: Michael Walle <mwalle@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, DRI mailing list
 <dri-devel@lists.freedesktop.org>, Inki Dae <daeinki@gmail.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
In-Reply-To: <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
References: <20231113164344.1612602-1-mwalle@kernel.org>
 <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de>
 <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
Message-ID: <2400535875c353ff7208be2d86d4556f@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> Inki, are you picking this up? Or if not, who will?
> 
> I can pick it up but it would be better to go to the drm-misc tree. If
> nobody cares about it then I will pick it up. :)
> 
> acked-by : Inki Dae <inki.dae@samsung.com>

Who is going to pick this up? Who has access to the drm-misc tree?

-michael

