Return-Path: <linux-kernel+bounces-11619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758981E90D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF5D2835A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B2537EB;
	Tue, 26 Dec 2023 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aGliPHUd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D79524C9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4277c62426fso40269751cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703615310; x=1704220110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVG9ArmoQ15xyAc+yxUrO+uyL/lDfCQ7yjtpIzOf96k=;
        b=aGliPHUdB8U3RJNTI1zp45s5PMXpIevTm/lbl5/gLJusHvGDGsCDVDpf9TKlOd2Gz6
         ValHQ/7PxpfsKmdzBLftziFHip6OW5+9n3CBvIWYb5P00zXPxK3HxUfUpusw98sMpgvW
         P4FGFt3O56aTSLILIAqmw0JytiS9xyVgfmkxzwHZMSQBWOwqCerd0/FR2detewgOSABH
         vcdfSamfZCFQLLRqwKiux0BFT6GCADcFGAJaTHtWk9E4ZtIK01X3VKlqDT8y2HhEZLfs
         G3VS97kQb4yP1zMoo/bFAFBQ80wb13sEu0ZafokNKPhuo92Koyxa5UipTwSOUoJ0FLc8
         tiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703615310; x=1704220110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVG9ArmoQ15xyAc+yxUrO+uyL/lDfCQ7yjtpIzOf96k=;
        b=tth+mpcPcZP/pbfXpFkpoMQOKKHNt4elP6n3BHE/i8xLawjzwD01ypuDmdT5p9jXh3
         MWKATWo8WlS7hhmUtRF/DXNFOTz5pQlWBU/XZeUnCrFEUI5O/WI2wNOVKx9ngjISmeTZ
         kdKoHLnkBHoe+mDgEuffX3168VJzS3nlIZKIqrlZgQtwgaDJa6T7lHLqH+ysp35EwiZD
         1G8yVeeve5HABwWfTJH6BgNvzRp6/z/565vl5kCXRu+YOzrNWsdpbwKdBXEKcsZSNnsx
         AkZtWdLpXhBPw5O+1QkbWPnExh5flPj4eUXG8ncIH7i3mVwfUIICzCfoWXTGpsoTsoM5
         FDUg==
X-Gm-Message-State: AOJu0YziEbHLqfbDj+DriFr5J5pOBjt13FBtf5l/JAltL0JVid8Woiag
	MhAJ87v5M0nsV473wDhz4naaHgx05d5v9Q==
X-Google-Smtp-Source: AGHT+IH95QHCHc+3GftDlCRw6iuKFmHCYQ8XAfaQiziiu2P452x5R8wFRpdo00E2wU0m4vpqb5AUoA==
X-Received: by 2002:a05:622a:1817:b0:427:8376:a2f with SMTP id t23-20020a05622a181700b0042783760a2fmr9360806qtc.99.1703615310169;
        Tue, 26 Dec 2023 10:28:30 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id cf23-20020a05622a401700b004276963b28asm6274675qtb.15.2023.12.26.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 10:28:29 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rientjes@google.com
Subject: [PATCH v2] vhost-vdpa: account iommu allocations
Date: Tue, 26 Dec 2023 18:28:27 +0000
Message-ID: <20231226182827.294158-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changelog:

v1:
This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

v2:
- Synced with v6.7-rc7
- Added Acked-by Michael S. Tsirkin.

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index da7ec77cdaff..a51c69c078d9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -968,7 +968,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			r = ops->set_map(vdpa, asid, iotlb);
 	} else {
 		r = iommu_map(v->domain, iova, pa, size,
-			      perm_to_iommu_flags(perm), GFP_KERNEL);
+			      perm_to_iommu_flags(perm),
+			      GFP_KERNEL_ACCOUNT);
 	}
 	if (r) {
 		vhost_iotlb_del_range(iotlb, iova, iova + size - 1);
-- 
2.43.0.472.g3155946c3a-goog


