Return-Path: <linux-kernel+bounces-86671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87B86C8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154A41C21BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C677D06D;
	Thu, 29 Feb 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDBklEfB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13487CF16;
	Thu, 29 Feb 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208346; cv=none; b=ZQBgPLFv0iKU7oW3yccviSdnqVN+uNP+c7u5CL6ONipPAaKBOsvGyYU11aBHWDetM29S6SH1kgz0R5b/XTrm/arlgrC5KURxwVXOVX9iAJA3bSvNrWR1bTBWL9x7i2AcbKA40gaaYrhuCrpAFCyi/80BcFPkyzqWsSR9FR5VOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208346; c=relaxed/simple;
	bh=/bbb7l83hj76pskoFmjDlhlQeqTmupIOHZ/UQmFJtMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bM98s3dkl0ivauIxiG/N8l11aj/6xVDggKRSOfU6LjZcfDk5VrLqgUkdT17Kr1X7CSkzVf+oLjK8M15gXvpKp5Kk0v35Wm9P4GwdORMgN7VZ2neQjRj+QzJGCxPAv5bW5if5prCCMdAXrq0y/hcqNm4QUQ1wwDvcjXsRVmUy894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDBklEfB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e151a1434so86475f8f.2;
        Thu, 29 Feb 2024 04:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709208343; x=1709813143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKTrC5BUEoERGt6YpPOVR4/EueT/sWktcgEEY9nn3IA=;
        b=kDBklEfB5a2IiUyyO7bkZzsYM8mo5La/NcUOYLpF0DHeE0dZPfrRGdS6yiSBcxKTQ0
         6LzmH9KUeKo0v2r8BqnTJPDwgwDoR8IfKDZsDwMNoh8RBfT1swGAj8F85C3ZwvH4l/mD
         FSpM0YoPy3nIFUo7IOzS8pVnyGin8GmYbm/2bHZmK8iLTb0KUmXrAR9EDDHyh9hVSMjc
         0Z4/4DpueFCG5AhWZAW6jQm/pJOYf2J3c3Gmu927FyHDWnJKc8aj/qPyqDvouqwMLd82
         8ClJEY0Q70vX/o5AgOSSybRs6FHsnnpIz038iWZBTJMDVq3fQ8KmzHTL6BIHJHosAWYP
         v2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208343; x=1709813143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKTrC5BUEoERGt6YpPOVR4/EueT/sWktcgEEY9nn3IA=;
        b=wDYglsUK9FxC3odqAljAdwq3RBdgJtt07eFbGydSuy3F0Y1UuvVAuBgrsIs6ApsQ+S
         IgG9FBnGyMLdfzd8+09EZSTIT0ZiC2GacMyLrhVdUB63r1tYm++iOUWwMopKdUefyojc
         8zWeeNGuKNCnZiz2FFoZO/BSNlCh5qpruSH+Gegafc0aaeW85c4YHfWJFSB3ZDmL1xuX
         OdUibAMPHWyQQl0kCq/YwfEP87hNe2n7xJL6dn8RMMk1xlrRkWsyjG3aIGEdfqZQ6HUE
         FvVPpi37JkDRO0IR1Tc2mw2NV6xydbpZktuGx1UCwCQKE9uXnqs9JXKN1/6Cv+TJ792m
         goNg==
X-Forwarded-Encrypted: i=1; AJvYcCWRcb5JR6GBYBD5pqOsRvKN7r/piFj2LgspBJlOUq+xigYdpGKyeSWFvqjRR6eQQgMNnqoJ9cWIivSSzy/4gltAbshxrIfNna1lVxz1
X-Gm-Message-State: AOJu0YyQQdWkbg67bl/Z1J48WX7Damz6tGeYqcAMig7R4A12D2y4SRJC
	UBALRd7T//3OcDxh8SR/cn9u9SVP2ZxIRXAukTwb4N1NhpLFFWi6
X-Google-Smtp-Source: AGHT+IHflToI7cmVEoLUgAq6Qi4/DXWnunqwZQL/91orV5BJE1B14iuKUeIa2YpviLArwrKjin+VxQ==
X-Received: by 2002:a5d:484a:0:b0:33d:297d:75a9 with SMTP id n10-20020a5d484a000000b0033d297d75a9mr1311981wrs.24.1709208343075;
        Thu, 29 Feb 2024 04:05:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id dp14-20020a0560000c8e00b0033d8ce120f2sm1588446wrb.95.2024.02.29.04.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:05:42 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: greybus: Remove redundant variable 'mask'
Date: Thu, 29 Feb 2024 12:05:41 +0000
Message-Id: <20240229120541.219429-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable mask is being assigned and bit-set but it is never
being used apart from this. The variable is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/staging/greybus/audio_topology.c:764:15: warning: variable 'mask'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 08e6a807c132..5dc4721105d4 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -761,7 +761,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 {
 	int ret, wi, ctl_id;
 	unsigned int val, mux, change;
-	unsigned int mask;
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct gb_audio_ctl_elem_value gbvalue;
@@ -802,7 +801,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 
 	mux = ucontrol->value.enumerated.item[0];
 	val = mux << e->shift_l;
-	mask = e->mask << e->shift_l;
 
 	if (le32_to_cpu(gbvalue.value.enumerated_item[0]) !=
 	    ucontrol->value.enumerated.item[0]) {
@@ -815,7 +813,6 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		if (ucontrol->value.enumerated.item[1] > e->items - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
-		mask |= e->mask << e->shift_r;
 		if (le32_to_cpu(gbvalue.value.enumerated_item[1]) !=
 		    ucontrol->value.enumerated.item[1]) {
 			change = 1;
-- 
2.39.2


