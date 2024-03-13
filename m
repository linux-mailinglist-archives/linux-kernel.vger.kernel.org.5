Return-Path: <linux-kernel+bounces-101332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D3B87A5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E0F2833B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8DC39AF8;
	Wed, 13 Mar 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrXZnY3U"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD41CF87;
	Wed, 13 Mar 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325122; cv=none; b=hsubfgj2BA4z3+kLq9J/X+qvbeT10wPn23bj7W0AZs3rx+Hjyryc/TgT7of/8upk4kYiO81U+7BQA8aVnRBCZTXFICc+bBqBpKIGhFT5/a0qrBAL91scu/UYlcf8jmud6yqKYbBhfoa+P14d5z/xPcWzLGWxPhawyzMvUSKxGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325122; c=relaxed/simple;
	bh=7CM+nFMkUJ8A0Bs7FMJA+7hDVVwj6VqsCEoQzqU7Jx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3M/xyei5SytZqgUret2/3exEd4CFI7X6Kr6w9Ag4sCxRu847gtHcG0tJeCHYEVKff+TUjfrkwRkYKf8Z5jI/YQU8AvrzsXIkCjN+iZO/MuVcxqrIlb1579WctgfsYXsDMgI93OcV5zp1uckrShzDy8ZHtG+/S2TA9Im3LypQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrXZnY3U; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d29111272eso110017741fa.0;
        Wed, 13 Mar 2024 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325119; x=1710929919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WbgbM7u13n9JAWDUNVwGH8wowagV0mD8Odr6/826/Y=;
        b=OrXZnY3UJkOJIzNQQSZ9emPPwy2Kn+A8Rk8dQuTf2Lek2olpKeXmNXJlROo5wR3BLB
         9a/smQ860wanw4EZWuYM2TiAK+ZoSxsrRia9ZMiejwZvUCs5V//1Wxc7Df56meePMp7j
         T4bJrg//GLENP55JOLsZPFP2VqP9K0XUulaqSwU9d3OQizFO2ruLizLHGb8R81BxXeX4
         VdEq+Bg2qje1THfggC4+se2P1F6S56peXNwuLN1OWlwEhlV++PuZRL5wXVngqU2z/fe2
         N/p8sCUQktWjkvo6Z3qTlC+bXe3fEklA4UC0mZfjiopVtHb5yoN/+Apqy6VXU8MA+WVm
         IKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325119; x=1710929919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WbgbM7u13n9JAWDUNVwGH8wowagV0mD8Odr6/826/Y=;
        b=kQ3fa2dJ8w/5GUz6c79TndiaKye4cPSQFQuyTHKuYGs2+eifgOLvDXGQWY+Jtp5qv2
         RHmDj43Q1EL1mDUdSnXvipYgWp8Y7iHSuOg8KaGT14rhikCVoALCzpxk9BDIiqlLk8Bf
         imvTfU4nFerEdGdjJ86ZETvZEcuAmWeDrh1QaGRKm/Laq052hMJXeUTzC/V593SxlMI4
         9rilCzexxQ22iuju7OUMvlSxbJGWsUkTEOooY0KvP8OQONdtYJEGDYoOHvUfZLhay4l5
         lNJxB1YDhOMYiCoXMknpaedH0tYaBWDcXEhpe0sNfxDQufGfCv+cTPkpjQFb04kO5KsG
         +NSg==
X-Forwarded-Encrypted: i=1; AJvYcCWgkHJbnqt9qg1Jv3eL68HmyKmIAyNwA4WbvP22UeqZbA2sJJ0sCRuHBAdEqJSKSnaV+5NsHDX3akUmQ9IAM+DEJHs1KfnFs9opryZxfPzilv7BxC0AUQbi1U6g5rZU+xVo9GKgz2g9vkjmFQQ=
X-Gm-Message-State: AOJu0YydwPTAI4Ls6zO+mJKK0TPyW+yFvQj+UN2UbMZBFWw6Ue6HxtDv
	3c5Tf6ZvDWvPi3ld+NE6uJlX8oituO5RH+ixXusIhcFReHhH3vxm
X-Google-Smtp-Source: AGHT+IHoT2ZmjtUjxmO/R270JNPRNEDgRKP0bvUIyvZYbf43dcWukrjeVSwF+SEv+DgvHKn/R9RIOw==
X-Received: by 2002:a19:3846:0:b0:513:4105:6b34 with SMTP id d6-20020a193846000000b0051341056b34mr2917615lfj.64.1710325118452;
        Wed, 13 Mar 2024 03:18:38 -0700 (PDT)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id h41-20020a0565123ca900b00513c271b67asm549795lfv.239.2024.03.13.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:18:38 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	khoroshilov@ispras.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] wifi: iwlwifi: dvm: fix potential overflow in rs_fill_link_cmd()
Date: Wed, 13 Mar 2024 13:17:55 +0300
Message-Id: <20240313101755.269209-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'index' variable in the rs_fill_link_cmd() function can reach
LINK_QUAL_MAX_RETRY_NUM during the execution of the inner loop. This
variable is used as an index for the lq_cmd->rs_table array, which has a
size of LINK_QUAL_MAX_RETRY_NUM, without proper validation.

Modify the condition of the inner loop to ensure that the 'index' variable
does not exceed LINK_QUAL_MAX_RETRY_NUM - 1, thereby preventing any
potential overflow issues.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index f4a6f76cf193..e70024525eb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2904,7 +2904,7 @@ static void rs_fill_link_cmd(struct iwl_priv *priv,
 		/* Repeat initial/next rate.
 		 * For legacy IWL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IWL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0 && (index < LINK_QUAL_MAX_RETRY_NUM)) {
+		while (repeat_rate > 0 && index < (LINK_QUAL_MAX_RETRY_NUM - 1)) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
-- 
2.34.1


