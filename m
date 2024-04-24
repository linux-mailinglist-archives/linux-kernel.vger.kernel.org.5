Return-Path: <linux-kernel+bounces-157228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C888B0ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573751C2427E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5616E87B;
	Wed, 24 Apr 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="c6U5Oiae"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357F16DEC2;
	Wed, 24 Apr 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973198; cv=none; b=KyFnZYlhlX+MAnb5sYlsT9SNWtoka+W11mQSBMianfa+qugxp3ye1H7K5wok4GUGtazpd9t1eOpSJA4yn6fdUfgQGzotQeM32Wbq87g3is8CdrkPM+3YvwoyVaaoyKUpBuS9JCINCWnmEOSvEUhhPLCVFiTFMK7ULqWm/iI45DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973198; c=relaxed/simple;
	bh=WBMpiZjgIfVXMrAcPx9NMWoDfmhP6hduabqP+C8jHwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=im1eR/5Myt0oUkgrn8jvn2naoqdyuH8JJmUfUyQI93y6IbxxFi+6RmqZ4DTJPTjVY6PUGJVfiXXWCEcAGJ0HOTu29CbNvKAgkxeijOn1uY6hcP6REqunV5Cwqch55qXGhgmgi7u69q4+J2OjzzPQBs6iDvRq1WGUVl7HVQ1nbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=c6U5Oiae; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1D3931A76;
	Wed, 24 Apr 2024 17:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713973134;
	bh=WBMpiZjgIfVXMrAcPx9NMWoDfmhP6hduabqP+C8jHwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c6U5OiaeE/4nz3Wy/b9sVijUWKmC2rwkGomfuKKo3T6MCZ9MBZxcHr+tIDEUihEeH
	 tDw2YrIUnKMDsXOSxUk/PNF93QQLW2m8PPVEC4KZ1/jGVzN7VQYQ+dj3SdeyWBdyad
	 0vfALqUI6lCT0wD73xdo+nRp0ifj+TCcMiSCnDP4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 24 Apr 2024 18:39:14 +0300
Subject: [PATCH v6 11/11] media: subdev: Improve s_stream documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-enable-streams-impro-v6-11-5fb14c20147d@ideasonboard.com>
References: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
In-Reply-To: <20240424-enable-streams-impro-v6-0-5fb14c20147d@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=WBMpiZjgIfVXMrAcPx9NMWoDfmhP6hduabqP+C8jHwc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmKSe7I8p1ChuqaCLjjiaOJvojo8lVOAeEpHbV0
 FKbocEAZ5OJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZiknuwAKCRD6PaqMvJYe
 9XO7D/4u0G8IgN0GzozUuG5SvVM9Vd12LaqK0UlDz0ysAujEGCxqcQeL3eoS9zsseMOTF5DHnoM
 /DwlrnVKFUb3FKsH5/Lsad1unFpgB1u1O7PHjo2O8ftRSEO2aAs2oTK42AHuSShyjsO/U7ecWMZ
 NSu8w32Vu5sGNs2pMmQOMUqpk3QcE+KLS+w4tmt4zz+oAJ3LVVBpVR39ozD4PvcKeTvDX0RSXUw
 0m7UGkBt2+xEBvNTq4swlTUnMPF+nLnAQPbkD0reyLGiGJv0V3cBlz9uFH1T3OqYv77f6XLXnSf
 prol02yBZOBYO7p7dVClUhtsk0QaBa2q2QF0HqiOTvJiE1wAHhYygb4GTkvGR5ncnCQSoitnQhN
 XIh81eSuaiJxt1QHM0V0Z5E2UU8J0h4rMOzM3iskNcJxKLUhg6bGs9Pesqzv3X9IBGANH3iD3Mz
 CmL7+kEFH0I4n96rZuZtciXfK59s1SVbvCKHA02lstXz0FcQdWX5+8rGn99ncZb3+7jwDL72yQ7
 lKDg7zEUAiXInLjnHQaX8dqSMZ9V7PkaHRismbqjritGnCNLiMYyM7fspAPT2G92hCFKd/dSeTA
 ADrw0CQOR11DCKimUeyVCQE//OxmRCnWlCv88g7gy8713+tXmnJVVERl5RoS/qbTBcgY0Vc1atg
 dlfZrST00X80iSA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Now that enable/disable_streams operations are available for
single-stream subdevices too, there's no reason to use the old s_stream
operation on new drivers. Extend the documentation reflecting this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 include/media/v4l2-subdev.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 14a3c91cce93..99564a2ef71c 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -450,6 +450,15 @@ enum v4l2_subdev_pre_streamon_flags {
  *	already started or stopped subdev. Also see call_s_stream wrapper in
  *	v4l2-subdev.c.
  *
+ *	New drivers should instead implement &v4l2_subdev_pad_ops.enable_streams
+ *	and &v4l2_subdev_pad_ops.disable_streams operations, and use
+ *	v4l2_subdev_s_stream_helper for the &v4l2_subdev_video_ops.s_stream
+ *	operation to support legacy users.
+ *
+ *	Drivers should also not call the .s_stream() subdev operation directly,
+ *	but use the v4l2_subdev_enable_streams() and
+ *	v4l2_subdev_disable_streams() helpers.
+ *
  * @g_pixelaspect: callback to return the pixelaspect ratio.
  *
  * @s_rx_buffer: set a host allocated memory buffer for the subdev. The subdev

-- 
2.34.1


