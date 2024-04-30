Return-Path: <linux-kernel+bounces-164742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E4F8B81EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63006285781
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A11BED6D;
	Tue, 30 Apr 2024 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gDFtIopR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD421A38C5;
	Tue, 30 Apr 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512717; cv=none; b=jWy5fUwQl0MhUwXeQmesEEnLIu5TwD+WxpHgy5RQy/zW/Z7o4Dqbv/arkpVR3J74o9pQUv4zK+B+xttS5/Ld+waqTaYHEZ88qMkV7tQvmK+bB0Yx1hG87+nyJbN7mXA/huf/OC+rwU4tRKMCnAYQdwpAyo5XU9PqZ/QSaqf0gPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512717; c=relaxed/simple;
	bh=2ru9K6Rw8I7gIbBKD1Rt3ynmkOzlBwx6d8Jo/+vjmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHVpo/SP158PzoqP/uH012ORSRIIGRjLkDcWmQUlRnyPImq6PSx3t4m0G2OeydJ08Pb9fMh4dplQPBKJJ3UlJBomQ0xFR50bIj6R3f5gmsmD/u6l5KytIj4ly4rRdNSQZLuq8GXIBFCqVieMzvW7Y9mlYOLZ+kj6yqDOvMlr14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gDFtIopR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (237.69-130-109.adsl-dyn.isp.belgacom.be [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A936966F;
	Tue, 30 Apr 2024 23:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714512656;
	bh=2ru9K6Rw8I7gIbBKD1Rt3ynmkOzlBwx6d8Jo/+vjmMk=;
	h=From:To:Cc:Subject:Date:From;
	b=gDFtIopRmyY2s7eKY6aYJDglqsHToB9rNAI12vsMG9fXgeZu0hRyT1Xxc+uczFUAB
	 TnZrK/pAbHfMqD4qDWWU4/gwljbqS74rBZ/ThqO96ce+tKMeRmterls+yj8AWi0m6h
	 Wh3adnoV3iiJB2sX650WOE4vI2H5w9GQjvrp2Tzw=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Naushir Patuck <naush@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] media: bcm2835-unicam: Fix compilation errors and warnings
Date: Wed,  1 May 2024 00:31:44 +0300
Message-ID: <20240430213146.23187-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series fixes two compilation issues reported by the
kernel test robot ([1]) in the newly merged Unicam driver. The fixes are
meant for v6.10.

[1] https://lore.kernel.org/linux-media/202404302324.8aTC84kE-lkp@intel.com/

Laurent Pinchart (2):
  media: bcm2835-unicam: Drop usage of of_match_ptr()
  media: bcm2835-unicam: Include v4l2-subdev.h

 drivers/media/platform/broadcom/bcm2835-unicam.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: a1c6d22421501fc1016b99ac8570a1030714c70f
-- 
Regards,

Laurent Pinchart


