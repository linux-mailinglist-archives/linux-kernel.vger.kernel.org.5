Return-Path: <linux-kernel+bounces-146899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348E48A6CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1F7284C30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E912C49D;
	Tue, 16 Apr 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+GV0c8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788003BB30
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274864; cv=none; b=NVJk9PZpMMF/lOJyR91N1qBbRS1fE2QvZ5UiwleA/tfmFGsYq7Pt2cmYMl2nptD2puMCzDfTWlQBrB8963cRzGyC16tI+f10IBj7pBbGNT/LnjDwdHQ5WVuM8g7kN3aceM8UuC45KTukQMc+FSwWqL1ebflO5IysDSTH/TokV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274864; c=relaxed/simple;
	bh=b5mTg0z4oYzKbTXPS5Ca9YSCSmYP80Vsy14fqETxjpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f/JFnxzlS8leybof1xAP3iJ6z2LyHRVmIvguICWvwVJlwnT7FBPfe+ox1tQZcyNDOqllqKjWcAgKiVYxbc7kIsq5GWHKdS7+hN4M6K0rRxGEFDeJEVJXc8Ejg35FS+mt93nZ3Wm/cn5jBg/8Nev7VcOXpQv5xdDNJJZWCMjykj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+GV0c8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA5C113CE;
	Tue, 16 Apr 2024 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713274864;
	bh=b5mTg0z4oYzKbTXPS5Ca9YSCSmYP80Vsy14fqETxjpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i+GV0c8u+4Mp+hIYeBLGod/+I6s2h0TRDsvK7LoDwnwh1cAUCMZn3KKOuQ9H84FkY
	 3SDG/xqu9GFbkGhuXgsFsebgCWI6sZiw0rex7qmhLSTo57CEe+7vqOzWVEifwHUu7s
	 AnnVV8Ay7eLFsMDhC/ik3ACZVVaqgJf733Maqc3buQxVAZejyH9HAvN0SDf+DHzlKf
	 3dhJCXJlokMLiSaPR+K8BHPYJWYeFSMG40SH94byBA2U2FlMxnFO6QpxL0ARLfWgFw
	 fGO5Axuz6H2ZjjoYmPWEs2kaO4XbOsh0KGr/XzDMPy9im13TJEjd9vSbHHhXXj2Mvv
	 LuhpDDtd0y3sw==
From: Robert Foss <rfoss@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Xin Ji <xji@analogixsemi.com>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240416-anx7625-v3-1-f916ae31bdd7@chromium.org>
References: <20240416-anx7625-v3-1-f916ae31bdd7@chromium.org>
Subject: Re: [PATCH RESEND v3] drm/bridge: anx7625: Update audio status while detecting
Message-Id: <171327486021.31483.13603823438662708518.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 15:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Tue, 16 Apr 2024 07:21:35 +0000, Hsin-Te Yuan wrote:
> Previously, the audio status was not updated during detection, leading
> to a persistent audio despite hot plugging events. To resolve this
> issue, update the audio status during detection.
> 
> 

Applied, thanks!

[1/1] drm/bridge: anx7625: Update audio status while detecting
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a665b4e60369



Rob


