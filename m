Return-Path: <linux-kernel+bounces-143077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700928A33CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CECD2811FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE514A604;
	Fri, 12 Apr 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8504dgn"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F4148313;
	Fri, 12 Apr 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939118; cv=none; b=kXaY1O4vX5DbuvpJnxJEqbEkAL7H5LhEi0XNAckK6sosJYHxHGrHewFSm2vagZr/vD1LFW0P8wAJJpM36WctmCpkCSdubePADXFfr8pnxmSruBw/dwYlDtIQIvFZvXne9cyEghZccpCAzKOmD8a7uMKl8jo/1ALcN7H/ALHe2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939118; c=relaxed/simple;
	bh=+/Ao6tah8HHTzxYdBhw2rCA83A9fOpuOCf642ssB/IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq84A9SohPuyRIkveS3j30uhroi1mEjhwmg3fLpwjXUGKOkpbnacrFgPgzR/DOb1naMGLjnqkUz0IpxC8JLASe3biq95q0gQ65Qbt81trLbsZnnI3NfImwUOsiiJ13aTOYgyBw6K0rC241DH/vPmyTPyHVl3nEQBPEHAFyK/WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8504dgn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso11947051fa.0;
        Fri, 12 Apr 2024 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712939115; x=1713543915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1ZiDdEdBLa6WUq6dSl5bzwxlD6MdFYlMkt9vqw7lek=;
        b=e8504dgnbJ+K6UBCdyiyKmMZTjip0hVHGbjosKHXBBxV5ejQnU+YkxY2REMf6gS2KN
         k94nYE6uvWl/8lkZsDdocwjBxUEt8+J0VYHn0eCR+wBN5maVFUME5B/P+l2MaMRNW7mI
         AGFL7oMn3vEbPLAAcycpjd6C5ri34sWvFKxqXP/OOSXLApOhz3S8Yf0MP/XqiFBSQlAa
         oAqOtwnQ6nM5cm/hoip0tAcTMXP3aJ4DL1q0rokhFnwjsUIHkEs8AKdZZF3g56LL0TFF
         JJsMmLm1IJykGJIevevvPxNfjAim4IxHK5pNxrN8llNE7SwN900y0GMlj527BM9wUNjj
         NmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712939115; x=1713543915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1ZiDdEdBLa6WUq6dSl5bzwxlD6MdFYlMkt9vqw7lek=;
        b=p/+9K/hfo6acze3Mjmsk5Zyo3QyCi0v93incSr78v3m8rPhqOQIwchAbJX97Ec2Czv
         iZ7fftSv6hZexA9/5PM/9T1rB9h/aZUwWYrfqJ3hWkHjxXcDvswh9RAPU3FljeTXPKST
         fYK0DaaCtsORNnABuxEZ/fUk+kbg+fj7O9r5UmjayjM+cXeaF3ptXSpmMa+fnEKyz3OV
         dbiTot0smW+BXG0pm/CMwrkUkttldE0I547vAAz4o9GNZmuXYcr0rmauw7LFqDwL30+T
         RWto5TpMthvSDrHLZ7rkDRvuUfkfVkdrmCnk3WuFMK8GcLiepmucn6zOzppFE9HO4O95
         wHYg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFUPxT1HIElbv/3dWp7ChhxNbA7awOqLpO8wxEKrJSszgg4rSLGW7vXIO9PKIhi+tt2A2JEUUy6yUmfKMY9VKgzYXsyQkQ5JN4VWN1/Deq1ofG5iFA+szErvhppvSKSnHnwgQ3C0CiT9ERoIqXisLKOp+ujFoJLigfCfn8Cx9omRhJbx8MLL1taam84a6XYY7JBld6gWjbw0BTOGgpEdf
X-Gm-Message-State: AOJu0Yz85IGk5Pxfa4cR+XdcstNGL5yVwAvBTa6yAu8F6d3w+17maHLn
	aYnzQCxo9UheFFtD9nhgQIu9JIPsF76b8hwj5DzdO/s3i67b5/QY
X-Google-Smtp-Source: AGHT+IEA2Mx2PVZ0wxEHfJ9V8RofGxmOrjMMCiJmTk1zmlFqSPe8iGWGd2yd72AmB/HZ5oyd/lApWA==
X-Received: by 2002:a2e:7c19:0:b0:2d8:cd7f:3cc8 with SMTP id x25-20020a2e7c19000000b002d8cd7f3cc8mr2526091ljc.20.1712939114765;
        Fri, 12 Apr 2024 09:25:14 -0700 (PDT)
Received: from fedora.. (d-zg2-064.globalnet.hr. [213.149.37.64])
        by smtp.googlemail.com with ESMTPSA id q4-20020adff504000000b0034635bd6ba5sm4576554wro.92.2024.04.12.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:25:14 -0700 (PDT)
From: Robert Marko <robimarko@gmail.com>
To: kvalo@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit property to limit channels
Date: Fri, 12 Apr 2024 18:24:09 +0200
Message-ID: <20240412162510.29483-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412162510.29483-1-robimarko@gmail.com>
References: <20240412162510.29483-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The common DT property can be used to limit the available channels
but ath11k has to manually call wiphy_read_of_freq_limits().

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c32be587000d..59bde128d351 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10124,6 +10124,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (ret)
 		goto err;
 
+	wiphy_read_of_freq_limits(ar->hw->wiphy);
 	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
 	ath11k_mac_setup_he_cap(ar, cap);
 
-- 
2.44.0


