Return-Path: <linux-kernel+bounces-3877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CD817496
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452EAB22CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342F3D54D;
	Mon, 18 Dec 2023 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzXycjzm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA23A1C7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33668163949so1037463f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911756; x=1703516556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rm77/0kPx+P8OIQIJY5wdGZ9XMi+lBmDPWTQSConRDc=;
        b=PzXycjzmXa5F7f0Y4EMmCg3p/eITZk1ZsNDN55kkGRsrKypaD4+Y2fs2+SdAnCSEQ6
         B4swK+NUzSmGaiPb7hnK2iQeHOSREfb6UbhCmMhXa3M8Ee+Xa2g5VAaxstWtFlm7WwVq
         De89es0XfqMDfDHwNcaE5QK/blcUEjnfD5vYuZoI2kkiRYzkRPIaaOLmxpfmphBO3cnr
         GamIarH4Ejs5oDxZQmJnecYnaGEVyPC/0B/9kBNljbRiFppP5eQoLrH82HF6yB+ARGTI
         FP/efpBdDy9gIR5+ZuVc51KTlJ8r/0sTgNmlKDkyeT0Xi1mbMbxJN52vtpSyZqlwDBqV
         7R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911756; x=1703516556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm77/0kPx+P8OIQIJY5wdGZ9XMi+lBmDPWTQSConRDc=;
        b=CYfxjxnzMOVdTboVu2rhpeV+U+i0B89CsKE5meJtMc3IY4BCBtHgCV9JjA9X9EAzYL
         1vvthnYBFxhz30FphnbLB07W1vPKn3ykRdmwr08qTdYR9t7xgavIvQt4rjTkrHfiI0A1
         vvZfFNeIavbcgeIXi6VYjro+srduZr7QIHxmBG0aG6jrWYWQjnE4fr7R6rLe2jrxYmhV
         hK3ndZrQdm47kCu9hLx/afulWPH+uVB/oODoUyPDMSU3raDinubxdkubifcaI2FDCIbJ
         mcd4DDsSTDxld/TYHoPqrhQGwVRXX/vQou9N8WUDdr2WSnXeZyFqy77qvrHcXxst0IPJ
         ltxg==
X-Gm-Message-State: AOJu0Yzp7q+dNl6OgyiFAhlreieFG6CbEXhe8CsnCdARCwoML7oOe56f
	qtvN4IZM3abarfeMtr9vptU=
X-Google-Smtp-Source: AGHT+IEZMaYHrNVPVkNE/UPwg5r0Q+nFpTQlPHxsEXsFBUQg9ObBF5TjBd8mhjUWUMTBx7PINvMofQ==
X-Received: by 2002:a05:600c:4749:b0:40b:5e59:f731 with SMTP id w9-20020a05600c474900b0040b5e59f731mr4114327wmo.163.1702911756076;
        Mon, 18 Dec 2023 07:02:36 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:35 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Add support for the ds28ec20 one-wire eeprom
Date: Mon, 18 Dec 2023 10:02:25 -0500
Message-Id: <20231218150230.1992448-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Ferland <marc.ferland@sonatest.com>

Hi,

Here is v4 of my ds2433 driver patch series, see [1] for v3.

Changes:
v4: Drop last paragraph from the ds2490 patch commit message
    (suggested by Krzysztof).
    Rename the __ds_read_block function to read_block_chunk.
    Statically allocate the validcrc bitmap, suggested by David
    Laight.
    Remove both W1_PAGE_COUNT and W1_F23_TIME defines from the same
    patch (was previously in separate patches, suggested by
    Krzysztof).
    Nullify pointer earlier in w1_f23_remove_slave to better match
    w1_f23_add_slave (suggested by Krzysztof).
v3: Do not use in-reply-to when sending a new patch series.
v2: Incorporate suggestions from Krzysztof Kozlowski: drop the 'w1:
    ds2433: rename W1_EEPROM_DS2433' and 'w1: ds2433: rename
    w1_f23_data to w1_data' patches.
    Create a separate patch for the validcrc bitmap change (also suggested
    by Krzysztof).
    Fix build error: initializer element is not a compile-time constant.
    Rework the ds2490 patch and remove the ds_write_block changes: I
    have no way of reliably test this change with my current setup,
    and I did not experience any write failures. Let's not try to fix
    what already works.
    Rearrange commit order for a more logical order.
    Tested with the ds2433 eeprom.
    Rebased on v6.7-rc2.

[1] https://lore.kernel.org/lkml/20231130135232.191320-1-marc.ferland@sonatest.com/

Marc Ferland (5):
  w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
  w1: ds2433: remove unused definitions
  w1: ds2433: introduce a configuration structure
  w1: ds2433: use the kernel bitmap implementation
  w1: ds2433: add support for ds28ec20 eeprom

 drivers/w1/masters/ds2490.c   |  25 +++++-
 drivers/w1/slaves/w1_ds2433.c | 162 ++++++++++++++++++++++++++++------
 2 files changed, 157 insertions(+), 30 deletions(-)


base-commit: 3f7168591ebf7bbdb91797d02b1afaf00a4289b1
-- 
2.34.1


