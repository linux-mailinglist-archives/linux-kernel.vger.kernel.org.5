Return-Path: <linux-kernel+bounces-10054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5C81CF33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4251286E15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8B2E84E;
	Fri, 22 Dec 2023 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhPsbGbz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9A2FC43;
	Fri, 22 Dec 2023 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3f29fea66so15122485ad.3;
        Fri, 22 Dec 2023 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276117; x=1703880917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLrEctJKTdv+9DQYIiqT5d8pIz5ARZucJNkVZeQocxI=;
        b=EhPsbGbznyrFnsnxKFD7I9YQhvIsBCpKTu5OtPzjG0kRtQwWOWBM8CFt/kydfDUJkS
         ejV6isqlnrpqYTY2kri9yrkoVHgPerNUroJE3CIuJUj9vhiv7W2Kjt/UhhxivzmMewHL
         D25KVe449O22LnrSVrub/oJ2qrRfzqYVl1aYM/CUloWuC9S6UsS6mqgoLshk9uJpbFEl
         yKSW3e1VdCS1EXw0aSTr72OBQw9Lze6aJgPIZNYt7GseUCZE4MG34ArIHG9p1dAuTxFw
         8Q90nyPkUjhVd1GgClvinYBNXEezgusg61rESU2My0McZjhJNJrDPCzHfEaOJksZxHQZ
         HI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276117; x=1703880917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLrEctJKTdv+9DQYIiqT5d8pIz5ARZucJNkVZeQocxI=;
        b=xAxOThPvkUKFHszCTspVsDk/e3f1ja7/tHF4mqxT662IOOr/Jkuk+rzhrWfs/Ogpn/
         IMYmxXugYE0U7lPDym8CbA4HXuga+k3LAE1J6G3qI7IwLn2zuTfxM9RMdh7c7uxvpqDg
         qj+daYba3WRvySyrs9WsCECRciSkjU1RKa7XYfmKYnm67apxzn1xGZSeQZAd0aYtw9DF
         Ocr77lr9L6+NRrLsDjv4pKvhw/c4La//SquAjHNJ/Tg7XzXoiHTodtk/IuOjHrQHYqZL
         K8U9OdRAibXeMCUxyCx7Tlj0haZsO0QpxGreHaZ4nL4vD88CwKv/hli6V+isGyEqIPPB
         iwRw==
X-Gm-Message-State: AOJu0YyM9aay+74v45tVXeMVcnw6fwl7YAwFBg4RQd+vaDAT/8lKlxhX
	DgsZqa0yPIXCGF2iO/V0Slg=
X-Google-Smtp-Source: AGHT+IEIokT7TBCD1z0pxoBMQ+BF23UOr1l/aVdCm8o0pnIaamekIXFExQ3ix1pzgG1NcmHoUDZFlw==
X-Received: by 2002:a17:902:7085:b0:1d4:8c4:5e07 with SMTP id z5-20020a170902708500b001d408c45e07mr1149471plk.23.1703276112357;
        Fri, 22 Dec 2023 12:15:12 -0800 (PST)
Received: from ubuntu.. ([202.166.220.102])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b001cc1dff5b86sm3792746plh.244.2023.12.22.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 12:15:12 -0800 (PST)
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
Subject: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in isp2400_input_system_global.h
Date: Fri, 22 Dec 2023 20:15:03 +0000
Message-Id: <20231222201503.2337-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The script checkpatch.pl reported a spelling error
in isp2400_input_system_global.h as below:

'''
WARNING: 'upto' may be misspelled - perhaps 'up to'?
//MIPI allows upto 4 channels.
              ^^^^
'''

This patch corrects a spelling error,
changing "upto" to "up to".

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/staging/media/atomisp/pci/isp2400_input_system_global.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h b/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
index 61f23814e2fd..3ff61faf0621 100644
--- a/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
+++ b/drivers/staging/media/atomisp/pci/isp2400_input_system_global.h
@@ -19,7 +19,7 @@
 #define		N_CSI_PORTS (3)
 //AM: Use previous define for this.
 
-//MIPI allows upto 4 channels.
+//MIPI allows up to 4 channels.
 #define		N_CHANNELS  (4)
 // 12KB = 256bit x 384 words
 #define		IB_CAPACITY_IN_WORDS (384)
-- 
2.34.1


