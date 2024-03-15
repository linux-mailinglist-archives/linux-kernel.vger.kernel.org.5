Return-Path: <linux-kernel+bounces-104187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED987CA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38023281BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE341798A;
	Fri, 15 Mar 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifi3cfvD"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375A17592;
	Fri, 15 Mar 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493774; cv=none; b=W9VeZ8EijcQSFVXnfAkGtnanZjBTpf2k9QqHpuO6vVRaXuHA/Y/CL0hLUcaPPClGc3Hv0GhwBGnLdqPkhTEieVrZKXNXnDXZyWs3r9raMqYaI3O7q6p7L9b0o1rjXcE+3KTaakKv3yhQN0HcuuHHyQPLz2/rIOZ8XsPkbZmsPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493774; c=relaxed/simple;
	bh=6eRLO1ilpanWKc8ZBdMe29fHVLUp4DyMn0BYswI+o5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oa5bjzwaEz/cvLKzF+p4TVoOZOvxJDb8NB/pUqQswkXrikgN9kEvjLJaOK2Pk8nMdfZ0/ykdVEqeS+leHWoXZ/rHHKULBQGGl9dDug7CrThvkB4861JioO13LEFjQFgHDf0RjOSJvI3Yo1RdJdYKBamIZD2xah7EHc2rKyUaB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifi3cfvD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41402466fb8so1249545e9.0;
        Fri, 15 Mar 2024 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710493771; x=1711098571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGxpqeVYITmqsu8ISYbdggA8wEernvQ3qM2whpST9xA=;
        b=Ifi3cfvDlHII7RLFiX09LCo+XQ1W+zEZQF0Qor/hPSUT/ZqKW8JTpXuil6BilGsFA5
         w63X7mrJBLNigZ5QC+WVeuj7tb815Nfza34iYVrZVUwr03G7+tpHSJRh4YD/unWU/ong
         +oTsaLOf9l2ObqeDcJHtsjf3XWthL9KOmzWWm5XW7ISe6+VTrEy5bjNT2EDZu3JKiP6I
         zqYGcIct+EhezyDd6iKI04VbciII8BX+EhUXb3ysP0ck6lPLZNCt3h9rBB9LebGdIdOw
         O7FVOb/jCD0vLfhsPXJVX7asndejYB/bLy3xJioq2hpOcrBAYswzG9bJTdHNo99bo5m6
         rcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710493771; x=1711098571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGxpqeVYITmqsu8ISYbdggA8wEernvQ3qM2whpST9xA=;
        b=QitB/T75yB9MlN+r/4S/ThDkjVeKwv2ikN0EEFF5jSRfdupLUutKOEp3lkt6/fCpZZ
         yX/6sc8X3tzySHDKONeZuOkrEV7JdjP6mWWarW/QHjHpgoM9UlUzsgWitw779EUx31ei
         mEBccmaQ0/N2o6nSJWktWHndU8fFcLi+mkXhc0rZtCxya8X0bKbeVBX0FfjvgXVEwleR
         mGozJa9b6zMlDYrCpO4JMLzVJUmAoejT7faXPH4UUfie2i07cqRmQ5dy1l4dJ4905zAC
         rQOoKX21c3mN5ZqP9yEHCew9cm/sWR49E4fBecFo3xdrQG+Y9DljKRHS40kuGLDnAcAM
         Oc4A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+bWmOgQdMBeMj9WPG2HTq1v7/GWhqfSV35PFoqAhiLSbRe2N8KdkjydDP72+FmvmqtqiydT7Xf2LVelyzg/OE8+ZpKQLsNmB+jWi
X-Gm-Message-State: AOJu0Yz0pXhIi2aN602tsgbIPyAu4Ts0DMTfHbOw+WJh27cgAXDjIjrU
	/97YahgrFm1ovPi3en5BMaqN+iUfWuAcDZdb7J0zpcXRCnSHNGL4ag+CX2qyqWs=
X-Google-Smtp-Source: AGHT+IH4hfq7wKhnrhc38RUmnv/6x309HrRcxXSHxhQRObiDiRWGWskNZ5S1CEfcYDXBUw1fO9QhWA==
X-Received: by 2002:a05:600c:4f07:b0:413:1139:3bec with SMTP id l7-20020a05600c4f0700b0041311393becmr2890485wmq.35.1710493771112;
        Fri, 15 Mar 2024 02:09:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05600c3d8a00b00414009768b0sm1499649wmb.33.2024.03.15.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:09:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/gr/gf100: Remove second semicolon
Date: Fri, 15 Mar 2024 09:09:30 +0000
Message-Id: <20240315090930.2429958-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 986e8d547c94..060c74a80eb1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -420,7 +420,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
 			return ret;
 	} else {
 		ret = nvkm_memory_map(gr->attrib_cb, 0, chan->vmm, chan->attrib_cb,
-				      &args, sizeof(args));;
+				      &args, sizeof(args));
 		if (ret)
 			return ret;
 	}
-- 
2.39.2


