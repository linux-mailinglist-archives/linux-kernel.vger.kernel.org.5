Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C0479D135
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjILMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjILMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2910D3;
        Tue, 12 Sep 2023 05:37:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-403004a96a4so35120395e9.3;
        Tue, 12 Sep 2023 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522268; x=1695127068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QWtGYWuF5LIVU/WAF0Ixic7dfS96mQ79iX0NaLlRek=;
        b=ANSkYU+yTbzN2dijjlwFMDCMSW/bSYa6B0Hn+kbW9XbbIBG6gQA8lIG3/4Zj6CqoAD
         rfw9v6zXbWjpllOeJTIQ0+aXm98vr71/jVl3KqNmTO/nq6p9z5uTm0im96i1Y8FAGb0o
         cmTiGecy3paX7N0SiRVPg9MT3WM8ifur5UM90psnGP9l823gkZIzdTKsg32EVzrN5cRP
         Yu8WVqweLnBzPHL1cjsGc+/gAeucKM0Z5VhR3Ph2QU6uXXn+Papxlk74TkJ2WjrxmDEf
         K/XOMYhqLcESPrv9msGW7+eRJZ81Th8VoasMWMxFYI472RstQAKPdD1SN/PkVzA8f34F
         C0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522268; x=1695127068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QWtGYWuF5LIVU/WAF0Ixic7dfS96mQ79iX0NaLlRek=;
        b=u0cc3tiO2kiOYZ3JVdxDPFAco4H7ytsQwoz20mTbX3LaYrVTG0zv1cNOvIja7uPKWM
         eEHRW2VhKRkuiihs86i+RbiuAovDlEsdFd41iiCKlT+F7IiEGL0JjDz5l14hnsA5c9N4
         bXN7cY8J2JvwCSpQn5Fm8HK6JoyJyUYlOgLmLMCXEuWEfQL4cQ4+se11ar+zUads48vG
         P8Poy6Av8JFZiHx83SY6JWU8Dy4Bsmi/wRElvOUjoPMqcbBSlVhugs4dQcXcRpbrIlU6
         qCjvUj46WuOnPoO6tTTHQbP8a9lCXV4wxIEprDPIVJeXXda7LEJH8wZUjKEBUUMEx4Wu
         AW3g==
X-Gm-Message-State: AOJu0YzE5w3RJ2u15HkbPGWAa610bbEoRdq+ufdEVf6OWCT0KyS+Ea/o
        u9hzW830dvtZu1p6xtyAPhg=
X-Google-Smtp-Source: AGHT+IFev/gnHA4MpFv7arGmL5MKepo/ibmW+1fWlLThdleRnVCHHztlkRbz3HeOBTdNx8hpE494uQ==
X-Received: by 2002:a05:600c:21ca:b0:3f7:f2d0:b904 with SMTP id x10-20020a05600c21ca00b003f7f2d0b904mr10593501wmj.8.1694522268316;
        Tue, 12 Sep 2023 05:37:48 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z21-20020a05600c221500b003fbb25da65bsm12834554wml.30.2023.09.12.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:47 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5][next] bcachefs: remove redundant initialization of pointer dst
Date:   Tue, 12 Sep 2023 13:37:41 +0100
Message-Id: <20230912123744.3929609-3-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer dst is being initialized with a value that is never read,
it is being re-assigned later on when it is used in a while-loop
The initialization is redundant and can be removed.

Cleans up clang-scan build warning:
fs/bcachefs/disk_groups.c:186:30: warning: Value stored to 'dst' during
its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/disk_groups.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index f36472c4a781..9fa8d7d49f3e 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -183,8 +183,7 @@ int bch2_sb_disk_groups_to_cpu(struct bch_fs *c)
 
 	for (i = 0; i < c->disk_sb.sb->nr_devices; i++) {
 		struct bch_member *m = mi->members + i;
-		struct bch_disk_group_cpu *dst =
-			&cpu_g->entries[BCH_MEMBER_GROUP(m)];
+		struct bch_disk_group_cpu *dst;
 
 		if (!bch2_member_exists(m))
 			continue;
-- 
2.39.2

