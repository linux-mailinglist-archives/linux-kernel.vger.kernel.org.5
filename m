Return-Path: <linux-kernel+bounces-28762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E78302B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E667E2862AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F351DDE7;
	Wed, 17 Jan 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCTf7WkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95311DDD8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484834; cv=none; b=XZZqdi/fPgeIKasVwmrhf/6wZm056qH2HsYQ8f6moHqFmlpkTCQ1dhVMgo8B3m1Ui1l910csUblft1+0aazdPsoKH9X/LsqMQoN9/FGsXzpsomHwbiwhxPzTK0dHScle8w6SZ6sUgcTZ7JFAIc3nbVsgcuex46RKNUgLjk6NfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484834; c=relaxed/simple;
	bh=DzKkZ7pwJrE9T6YvgnxaoBeYmKwKiuExIE8dk9CyibA=;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=cjaw3bvQ9OXzcpixLDGgYrDsHjkodNBcmYr+p8i28M4nSv2olZz1roQc/fUBlGDywTtv4mYGYWJ35iYeouVgzfHQ/xksteVhfcyRxHGgIolguB0z/GBsEWi4KTsEOrFpWd/aBSfHFs6F89CHgAYOAqGJXZU9yx4ajlYw+jxYDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCTf7WkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193A3C43399;
	Wed, 17 Jan 2024 09:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484834;
	bh=DzKkZ7pwJrE9T6YvgnxaoBeYmKwKiuExIE8dk9CyibA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PCTf7WkKYcQsxfBy5YaMXL+ElkORn7WfuEF8eFRn2qRb61DC+JtbEK8GFyFu8mUlw
	 I1cYBv8LyBf8Ikv5AxqVrChMnQ9NKFjO3bIL7p/a3AnL2R4NL+lpb1v8eFLxf1Hb5D
	 dkbaKdsyb6t5+8MZMeDJYwgJ5G+H4sRzm3GRGvUoVaAz/wbnobeCpMyTLbSXvpCCOt
	 qRUTwHp0Kyurh5QmjUuA1x8xkuIVTvtpsaCpKn7db4IRokIT0svzO9o864B2EcfG5Z
	 bjCTb3Pm0Ls+7VxbxW3r7wNLS+HSulQsgard3UH5d5G0nCP/WXhU3ZUU+FfggJtlIi
	 GdSqHeYw/uzjw==
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
In-Reply-To: <20240115171351.504264-6-michal.winiarski@intel.com>
References: <20240115171351.504264-1-michal.winiarski@intel.com>
 <20240115171351.504264-6-michal.winiarski@intel.com>
Subject: Re: (subset) [PATCH v5 5/5] drm/tests: managed: Add a simple test
 for drmm_managed_release
Message-Id: <170548483207.96553.13751158453989527090.b4-ty@kernel.org>
Date: Wed, 17 Jan 2024 10:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 18:13:51 +0100, Michał Winiarski wrote:
> Add a simple test that checks whether the action is called when
> drmm_managed_release is called.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime


