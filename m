Return-Path: <linux-kernel+bounces-28761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E98302B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C311C2498E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7A14266;
	Wed, 17 Jan 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwp/MxHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DC1DDCE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484832; cv=none; b=IX+Zi8Rg1j6xBCc8Yj7fZZfq/38Um7EwwYKmXjURXITC+doCEJaN8OykkrAw8WmDchXZ9qMpBEf6gLv/QcWhYFwN+o0b1qHfPxY7hp39GexLdcbfH3byJRbjTMN/91L74GAZDoxi1pO8L16fWMvAxM6slzGoks5Dvb4jKR9Xb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484832; c=relaxed/simple;
	bh=EDFiShPmnlc3Bz+tm7IGonEKApiN8X1nqhV18m3LYRM=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=CFLYMVta+Xgn5rZCCRLV19xgrG9EYcsp8XPLYCeJiZG3CSDGv8idwR6F8pKVDlJ0FAO2lsUpkkdUXbuqSPPKd0AUR4H36aueYbtAs0EQuwkZX0g/sk0Kg1T4bE5vkwEFGf4cfwxojROEcEMw2ILktlkH9XmoYZ6vHa6NlzhxspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwp/MxHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9B7C433C7;
	Wed, 17 Jan 2024 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484831;
	bh=EDFiShPmnlc3Bz+tm7IGonEKApiN8X1nqhV18m3LYRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rwp/MxHgI8vLpuIjfb1tb7YP/tLNXY67CQiDTOleQmxq/g30I4ZdYK77vnPHmFmOR
	 hrH0dft3Aq/LgJ9FAdOyT3s9GfMi+OBBG/0Zg6kqH4BvyGJnMq7qXcR7WtfXMgDe9e
	 b8C/k0NyPYQRYJ2U0CxpHzTC3G+Yz0j9L/cJG9G3k7FtlNtdIyg9D+Ey2w1HFYutS/
	 qHCjtCh8yOrUwBmdnqsFT51/jShrxSs8Y8Nznlk2oOa1BqGPwlBxhwIUYmk2n0U9Pa
	 8YzJmQX4mXPka5XUur5DI+kOzpJZlKNmHnZ/5aECQikep6hAwXyUTWtQD0dqI8B8aC
	 rQl1lv8/acjjw==
From: Maxime Ripard <mripard@kernel.org>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Michal Wajdeczko <michal.wajdeczko@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20240115171351.504264-5-michal.winiarski@intel.com>
References: <20240115171351.504264-1-michal.winiarski@intel.com>
 <20240115171351.504264-5-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH v5 4/5] drm/tests: managed: Extract device
 initialization into test init
Message-Id: <170548482927.96553.15455064080012962695.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:47:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 18:13:50 +0100, Michał Winiarski wrote:
> It simplifies the process of extending the test suite with additional
> test cases without unnecessary duplication.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


