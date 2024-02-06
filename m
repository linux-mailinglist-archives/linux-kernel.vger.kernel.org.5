Return-Path: <linux-kernel+bounces-55248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6B484B9B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6983F1F26602
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681813248D;
	Tue,  6 Feb 2024 15:34:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FB1332BC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233660; cv=none; b=aaKq8sYlMLQTISGcwKMNFROJQr2CKF7V9YRwjEYmETdU7subZ3BGZ+q5RTF7yNHBkxGU0ZPl2kSq8NKkdBhVJh+jWA75nq4HvXED5XDIFXcPGdUtg1xfvL98cik+Z9jwcpeL/bbF0nuB/OWzOwBuAWwp/i8bDbilX+aozLV9KVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233660; c=relaxed/simple;
	bh=SjO8eaWp+Pka7A7XYgCKH8eNO0wLeSoBwCwAPqpEEK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mlcle+EZI+ajCh1wFweW6oyIwenFZivl498VWYlE9McbDR4W7TIl1VEJedh4WI2y96U9YP85yIUm77ATSca4OR79MQLr5ZTBU+R+LmbP4drMHrdwcgP5d/lURYFl+R/jdPE5EyfH5y8oxdU7QBnnaezMetPept5w6smA+tQ3D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F6BC433F1;
	Tue,  6 Feb 2024 15:34:19 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id ECD0B1060761; Tue,  6 Feb 2024 16:34:16 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>
References: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>
Subject: Re: [PATCH] hsi: hsi_core: make hsi_bus_type const
Message-Id: <170723365691.255815.3681356681345738613.b4-ty@collabora.com>
Date: Tue, 06 Feb 2024 16:34:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sun, 04 Feb 2024 13:32:13 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the hsi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] hsi: hsi_core: make hsi_bus_type const
      commit: a0e35a173a86d93040d0e08f9c38526b6cf6c1d1

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


