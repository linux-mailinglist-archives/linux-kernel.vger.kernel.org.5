Return-Path: <linux-kernel+bounces-23368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5D82ABB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D951F24BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0621428C;
	Thu, 11 Jan 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2GRHbs2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60612E79
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704968089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N/UoCwqwLqGcoRY403M5K9c8YGwWXRlfn//t7u6wv2s=;
	b=M2GRHbs2JnzzBtD5OLnJT2GgqKWAr93c/SR3CxLSlO/KvN9uEndY8nWOAJGPReHGkbjMFu
	SJFYIdpM6bdbI9pvWslnCxbgxqrNg3kFy0K9M8/rD9jZ7hNwT/ermCJ9smzlesz+1r47+9
	uXa92eMZHf0Xa1vkHwKh/LtqHknFSFQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-qDOqVlY4N-uUCEladh4b8g-1; Thu, 11 Jan 2024 05:14:47 -0500
X-MC-Unique: qDOqVlY4N-uUCEladh4b8g-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bbbfe871afso1302715b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968087; x=1705572887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/UoCwqwLqGcoRY403M5K9c8YGwWXRlfn//t7u6wv2s=;
        b=ecX//NOZhuyBRM7IH1gCLirq2u+e65dk9IDrqNM+IjBP8RweRG7RmP+cPaEeekdzA6
         qvYquIoIc/LsH6jkr8NstKAIMSuaKA5nygFG1cR1aWizqAo0MC45uqQtMHEnRSVo1gKD
         LjbfVtZ1feNP2blyDAV2RsYQdY+If8Ulaigiyg0TemhYitKmU5Zj51pS+svk2JywOnFU
         coK8eHMKVMTDZSfi6TK63+dVGrkDFMUPE1mtjYchKpx3CuRzTcvunUj+/G/1UIhH/Vf0
         3ENaD2V8Zj0WwiDMVW+KpKFsFAkYGcgpJStH38yKnspFQjWtCGW3WQsf205avBrEqbrm
         n1Uw==
X-Gm-Message-State: AOJu0Yx5Kir4v+PnAHHJzbQUPFdgUThDgTZ1OLqa5xaXBIm05d6pYM1r
	stNyUd0jBQXutU492FkwFM4oKZvlRaOwz3mvnVuRbaVRw5nFxv1Lmn1H0er3xRNE5zhVouN7Kds
	/r9URb7xkoxxplY61Lt+Ij0tqaq6VtHQo
X-Received: by 2002:a54:4415:0:b0:3bd:44ea:a6a9 with SMTP id k21-20020a544415000000b003bd44eaa6a9mr1768448oiw.4.1704968087197;
        Thu, 11 Jan 2024 02:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4P/rjoGuSsC484KSAD6OYk0J+cSTTYILIQID5AnGfJR82sS+9GPYmICi9JFFqXoGebsRpDg==
X-Received: by 2002:a54:4415:0:b0:3bd:44ea:a6a9 with SMTP id k21-20020a544415000000b003bd44eaa6a9mr1768436oiw.4.1704968086951;
        Thu, 11 Jan 2024 02:14:46 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b0042993549c3asm313237qtb.32.2024.01.11.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:14:46 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v3 0/2] drm/imx/dcss: implement region request and devres
Date: Thu, 11 Jan 2024 11:13:45 +0100
Message-ID: <20240111101346.15193-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OK, I messed up the ARM64 build. That's what you get for living on x86
for years and decades. Mea culpa. Should work now.

--

Changes in v3:
- Fix build errors (missing variable, forgotten remove to call of deleted
  function)

Changes in v2:
- Add the region-request to this patch-series. That was previously a
  separate patch.

dcss currently does not request its memory resource. This series adds
that request with devres. As we're at it, it also ports all the ioremaps
and associated allocations to devres.

I can build this, but I don't have the hardware available to test it. So
you might want to have a closer look.

P.

Philipp Stanner (2):
  drm/imx/dcss: request memory region
  drm/imx/dcss: have all init functions use devres

 drivers/gpu/drm/imx/dcss/dcss-blkctl.c | 14 +++-----------
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 15 ++++-----------
 drivers/gpu/drm/imx/dcss/dcss-dev.c    | 19 +++++++++----------
 drivers/gpu/drm/imx/dcss/dcss-dev.h    |  1 -
 drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 25 ++++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-drv.c    | 12 +++---------
 drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 23 ++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 24 +++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-ss.c     | 11 +++--------
 9 files changed, 37 insertions(+), 107 deletions(-)

-- 
2.43.0


