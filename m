Return-Path: <linux-kernel+bounces-21154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E491828ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72FE1C24536
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72A3A8F6;
	Tue,  9 Jan 2024 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azLjjcxU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADD3A8C7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 17:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D01C433F1;
	Tue,  9 Jan 2024 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820668;
	bh=D7KV1IGnrkXqUutExUdjibJpcr5iZJVE7kOMwjqDBjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=azLjjcxUBJVJs7dVbTFf3s2B/YPVpZUMPF1PMrVOIKcwVqKJe7cgvbGjceH/bEGlA
	 /J6c6wUifbb5lI4ZysV8Q1FuSKZwhVzo12gYZZJGNd22juu+sPubMRu22n4FPmQ5SQ
	 KqLMmX730gSn4lkOXB8KXSAOolWrywFMlpDuN3rNvWuRcNwZMQn9NViWf3NzazXdL+
	 +sM/MCqVH03g6D3Yi6pVLIyCCuSAo+uotxLD0HWuh0CcGqgZ/iipTnhxzUPCpb/aR1
	 B5E3Hde7t3CeIa/CdRy5l2udRn8IRTKk/OFTG+Jo4pCU0T2bOFZ2sa7FdXolXA6c+6
	 MGZDeCmhSZOHw==
From: Robert Foss <rfoss@kernel.org>
To: linux-kernel@vger.kernel.org, xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org
Cc: allen.chen@ite.corp-partner.google.com, dianders@google.com, neil.armstrong@linaro.org, sam@ravnborg.org,
 hsinyi@google.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, andrzej.hajda@intel.com,
 Laurent.pinchart@ideasonboard.com
In-Reply-To: <20231221093057.7073-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231221093057.7073-1-xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH RESEND] drm/bridge: Fixed a DP link training bug
Message-Id: <170482066511.1300150.1577752604987496736.b4-ty@kernel.org>
Date: Tue, 09 Jan 2024 18:17:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1

On Thu, 21 Dec 2023 17:30:57 +0800, xiazhengqiao wrote:
> To have better compatibility for DP sink, there is a retry mechanism
> for the link training process to switch between different training process.
> The original driver code doesn't reset the retry counter when training
> state is pass. If the system triggers link training over 3 times,
> there will be a chance to causes the driver to use the wrong training
> method and return a training fail result.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: Fixed a DP link training bug
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ca077ff8cac5



Rob


