Return-Path: <linux-kernel+bounces-144733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1B8A49F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F827286037
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1A36120;
	Mon, 15 Apr 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHQXtDkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4E2C6B6;
	Mon, 15 Apr 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168797; cv=none; b=I175oT+kSKr4xk53L1IJS7Ca+vTWIk3oQOVTXlPNnFsk7miCQQBugQEEj5r/vdxrxkPd9NjLZRRCU00rueqz4q57JSy/bwmxEKMcGZsX2b3egmwzHi3ZRWK8xzel2waEefdmHS50c1Qyb1q3tAk/rk14KPUkwMcbRYt7yr/T998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168797; c=relaxed/simple;
	bh=kC6AAi/JZRBq8QknujOSktqMQOIYSHhF0EMVUrjpbrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZNVwZI8ti1io6VD+aEtjA7lbN5dyF/Li/gswk69hNp3549Qfhs8uoOLMUDxQ8dYb32QJwVqmtNbNtBpEhzsEz7svs2i8lXwE/Pl58449gOMbGWDCh45OnOMAQVOZKG/kKV4X5XDJPVn02227+PacN540gdB6FfJUGOwunU+TXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHQXtDkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26D1C113CC;
	Mon, 15 Apr 2024 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713168797;
	bh=kC6AAi/JZRBq8QknujOSktqMQOIYSHhF0EMVUrjpbrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YHQXtDkKuGTGdZE94jkwbbdlVqtdZVIcDkyXkuSIfO275liUtTM6CjySm/0Lv73S3
	 F7ppFMeWToGvNhITdusuEJqOvxS5Bip/y46shQ+majgPCgzjjvRX/3oxabbKRUE9vj
	 oAru4fdH1N/XXGbt32ngdNXTzLd5nmr52urFfJuhgwueZZlCHup4Aw93xn4/yCDOpy
	 PxjSYn/sVL8OAMXqT1yYbEm52NNgB2wDnjim+e961Dz1W+FyFai9bmK9SAsH+rNfa2
	 z75qwmQ+BqaRoSbFnhwp/DzSGfb3nqqxq5cGurdrAv6nRD6VO0xQPC9T5qWxx1za6Z
	 Ry/wHNMK4dGnQ==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, 
 Sebastian Wick <sebastian.wick@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Vetter <daniel.vetter@ffwll.ch>
In-Reply-To: <20240410122008.38207-1-sebastian.wick@redhat.com>
References: <20240410122008.38207-1-sebastian.wick@redhat.com>
Subject: Re: (subset) [PATCH v2] drm: Document requirements for
 driver-specific KMS props in new drivers
Message-Id: <171316879419.200641.10651479011126419872.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 10:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 10 Apr 2024 14:20:06 +0200, Sebastian Wick wrote:
> When extending support for a driver-specific KMS property to additional
> drivers, we should apply all the requirements for new properties and
> make sure the semantics are the same and documented.
> 
> v2: devs of the driver which introduced property shall help and ack
> 
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


