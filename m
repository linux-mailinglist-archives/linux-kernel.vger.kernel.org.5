Return-Path: <linux-kernel+bounces-127717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E28894FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C241C20B92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D75F547;
	Tue,  2 Apr 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Q43HfRbM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCE85C8F4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053099; cv=none; b=j1WTU6Rw85jlJLQIjSwS3XGEgE9ikJX61uWoeSm5G05WR+esPQe6fm4CrWCgp/WYBv83AtFsJD+dAJXc8jr6BiVzDFjI/FdhT8COiDNeBUYXPhpariZZOsUCmf6EH7Yp6vf4FYtmKdGnaqgHy40oFuxVX/APkknFRiIa/7wS7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053099; c=relaxed/simple;
	bh=dXhymU/yhP/SWi0YisBT6HFMgx39UOW7ypyZK3sbSQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZerRkV0EQGnByBNCNETU9HIqupJjFgRZZnApHQrCpveqHmc90oN2/5XxtngBs5Eqy81xfiaQbUKoNFDXnCA2OMJi/d1qUjc1XZRNK5PIwEwXTJ9httkIODjmgjFIM6DR4hpB0EVUDyp/VxJWAKppqqzU6qeTAPcAXoDti+McZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Q43HfRbM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso655370066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712053095; x=1712657895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/mwm8zCn+doNkvtBZ+vvbGDawPDSfojGEsYmNo3/HI=;
        b=Q43HfRbMt2qIs4njHO4isN90w+CAwFEB0bYcDT6BJ/vp9y+dH541xxZap5shjjhCb7
         FqaTg+BQagH32JrXbh2Itmtc8cVljuay6SP44HqbACDk5jtCXnLqhhJdo9Y9J4D0vGUg
         RLd5bfVPwoxE51ITCq/FDabHbsMzyYzEnfWwryQU0qtlOcrck+7iaa7hJp7VG0Ycu0YJ
         4Gxb8+NdSFdATq+JVf0MxU3ZsZYMAFgIcoXv8s/PzcYW87tEehOfTVclxKd9rGv1Oq3/
         0tHYqE/EANUOW93amb2Y0x6yJH882/WXH75e77mU01OthhQYKle5FXkBVNJQz5UHMbIp
         fMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712053095; x=1712657895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/mwm8zCn+doNkvtBZ+vvbGDawPDSfojGEsYmNo3/HI=;
        b=ISnNvbo+MT7+e/+D+G14r9jMJSnln/c/hhwNFFbwmxJEltp8H05b3cR/fc20y92mDc
         5FAVKxjvq2PnjO3+iPxzjRKmKKdi2Or3rtG9YxCHb2iC3zZ5tqNr9dVPXeCxsq8LUfPJ
         +4GRBiIpFW9tSVoKc0FYF3RuDtCMKd7wGYJ4bry+KQqhzMSJ4mxtR3jLg9bvqUIFCKg7
         7nAXvUlIYGo4fdhpRHTomr5fmB6+D4VmEcJY4AWqtZzkeu4I9/TiKCOS6y2JrT3uR0rF
         dFnjuGXcU5WtnG1Aeo2FwGE9oxRpTgz8JILdxs70qL/XuDiVaiPHD94X/aKbXErcz8r4
         FgeA==
X-Forwarded-Encrypted: i=1; AJvYcCWwIm1Q2w2KQ8A9YVQCfLN9+3wqJm1jBv1UuFjVmitgBq/Ta/WhNxcDP1cUJd77+q2LYm+0rpIhSR49yxkChZ0qByj45laJH837R6my
X-Gm-Message-State: AOJu0YzW8woIojQwzb4w1/KZ4GXNh9yZ/rOsNodt1m2pd6eQZZNpyxv2
	xsa6F7grWv4MCthmjOFIOY4gXR7y47+0h9oWtVxf1Qo6EO5RiPyb3BH+p738QkC3tlF2ci8ejTu
	uwpA=
X-Google-Smtp-Source: AGHT+IGRRkrsspMxPa7CSS0ljbAnAoga3Kv+wy8nZ/y9VMIo2bDrs30aCtEgVHfaq26HrGZO6HQEYQ==
X-Received: by 2002:a17:906:c249:b0:a4d:f2d9:cf1a with SMTP id bl9-20020a170906c24900b00a4df2d9cf1amr7201372ejb.63.1712053094629;
        Tue, 02 Apr 2024 03:18:14 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id c15-20020a1709060fcf00b00a4e4c944e77sm3943658ejk.40.2024.04.02.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:18:14 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] zonefs: Use str_plural() to fix Coccinelle warning
Date: Tue,  2 Apr 2024 12:17:16 +0200
Message-ID: <20240402101715.226284-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(zgroup->g_nr_zones)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index c6a124e8d565..964fa7f24003 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1048,7 +1048,7 @@ static int zonefs_init_zgroup(struct super_block *sb,
 	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
 		    zonefs_zgroup_name(ztype),
 		    zgroup->g_nr_zones,
-		    zgroup->g_nr_zones > 1 ? "s" : "");
+		    str_plural(zgroup->g_nr_zones));
 
 	return 0;
 }
-- 
2.44.0


