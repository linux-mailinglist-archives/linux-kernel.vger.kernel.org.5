Return-Path: <linux-kernel+bounces-10315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9881D29E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2681C22A70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177563A0;
	Sat, 23 Dec 2023 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0vN1LtS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D75664;
	Sat, 23 Dec 2023 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba834684abso103659339f.2;
        Fri, 22 Dec 2023 22:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703312217; x=1703917017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7njaXclry8FJLwii07+vYUOoiK5EVEJQBJVFl/kxqE=;
        b=e0vN1LtS2itSAh7LXF60xnsKzuXL2jXcQROdmxTOR8nlR3a0IP6R7BbJMSAFXCxxQo
         khJL+RCDQThN+HqTYi9pRv5ZUtPVf9EbhI24a3Y4yCeJ+LjCZm6zPzkVU+CtwaVFhr7v
         7tqTBqu5LJ0IbU5YCzHYznXHDmpgQZ4PgA1ztTZWXwGMiGz4v99dqrU8GIE/QAnKycPI
         tQ7JwpjTwvX+Gkr2A/oMXbD2zLlTJfSIgRORuw+Xn75Q2NPJmiU0KK3w0EtoJlqi98lT
         k1GrK+rpAPLpF6Fa8+mUx5Z7E4xcXiQkIv6/yqTpW3pYKrcig4ygQLsqI5Djp7TXRWaE
         0nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703312217; x=1703917017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7njaXclry8FJLwii07+vYUOoiK5EVEJQBJVFl/kxqE=;
        b=glnJiF7G8DJnWA9sDVB5LksaU9jTI/mxm6+RPhvLZTE6xEnDO6BwV6xy7khGQwEVe4
         hwrgL26FSuPys4Zu3eCAYoydWWwxWRlqM0Ne/kFppki76nj1UCFkzNvGKI9ZBEpX5vHX
         HkG9BuxNA0A0XPxuVFnpPqS8q6MVUo91vTUx8jyssrxX0RTRVsTxm+307dPf1xaG1wxo
         RcLXMt6oVnn5h6ssDhbFG13Tps1aXnThGd0cZUXuKGyrl3iCUNDzqhTVDAsfBVfPgp2v
         PNupiOHlc7aKu8ytaUtlHeDcg+MbgLfGv5xqjPA/BHUmqqW7CO3z7gPUV1nmkC8RFxn0
         q94w==
X-Gm-Message-State: AOJu0YyAToffjB34ALdFMN1Ru8fhJgA0fT25umJ44rDgVoTxqG5WkEjV
	vN2OOtZrRXW+NPCaOU0HvcvHbPgMa0nPqw==
X-Google-Smtp-Source: AGHT+IF8YJ43SrzDQe7J5DlABGxtPTsbfEZgJo+fSABzEFKyifcAkhaVcjxBU16GO8jG8S++691oBg==
X-Received: by 2002:a5e:c80e:0:b0:7ba:813c:39bd with SMTP id y14-20020a5ec80e000000b007ba813c39bdmr3096868iol.42.1703312216698;
        Fri, 22 Dec 2023 22:16:56 -0800 (PST)
Received: from localhost.localdomain ([2400:1a00:b060:2b26:f462:e3d9:c28:4c99])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b006d97f80c4absm3024061pfd.41.2023.12.22.22.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 22:16:56 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org,
	hpa@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] staging: media/atomisp/pci/base/circbuf/interface: Fix spelling mistake in ia_css_circbuf.h
Date: Sat, 23 Dec 2023 12:01:47 +0545
Message-Id: <20231223061647.78669-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported following spelling mistake
in ia_css_circbuf.h as below:

'''
./base/circbuf/interface/ia_css_circbuf.h:76: poistion ==> position
'''
This patch fixes this spelling mistake.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
index 0579deac5535..e9846951f4ed 100644
--- a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
+++ b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
@@ -73,7 +73,7 @@ uint32_t ia_css_circbuf_pop(
 
 /**
  * @brief Extract a value out of the circular buffer.
- * Get a value at an arbitrary poistion in the circular
+ * Get a value at an arbitrary position in the circular
  * buffer. The user should call "ia_css_circbuf_is_empty()"
  * to avoid accessing to an empty buffer.
  *
-- 
2.39.2 (Apple Git-143)


