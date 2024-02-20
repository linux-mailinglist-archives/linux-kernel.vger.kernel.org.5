Return-Path: <linux-kernel+bounces-73350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EF85C158
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03235B23945
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D9768E6;
	Tue, 20 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="mSQkd3b8"
Received: from egress-ip43a.ess.de.barracuda.com (egress-ip43a.ess.de.barracuda.com [18.185.115.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C876059
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446349; cv=none; b=a7vaOyWeFh56zjS7qnuLFyDC++kLY77A6kCfKT02UjW/xWygeZ4JvNt82mkG8nEb1jHfXuLVuA53pkDu1Gn5aSsBC7BVxQmxnSeQXlMPCgkjwb1qPbTZIK9h+yPuBSWziz3lXc0XpjUYmvAieoCoJQVdwlh0AqgWYrxokEJW564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446349; c=relaxed/simple;
	bh=H5FBmGFk/JAqnBLzMz51HsWYL+w+B8UJUW2xNg42z+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkGPJHQGODOT07zOC6hOINI5i2adbEZ15vMeq0foe9xZsdsyCtFShUj9r7poar//b5ywXz1UQoZNY95JJx0MKpGq/sWl+zpI7w5Hk6rTTJmRJC33fbMBQlsLmAlUN5pL/p+ZDMOkdPhLA9aFswNpX92AU29v6qYj8JME2DeMi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=mSQkd3b8; arc=none smtp.client-ip=18.185.115.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199]) by mx-outbound9-168.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 20 Feb 2024 16:25:38 +0000
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dc1db2fb48so5295845ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1708446337; x=1709051137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGSBqi+471g6iUqgaSDbqqcZPD+H6nZRINSP+WgoQ4w=;
        b=mSQkd3b8c4v9MacJ1eqqchSKGxR6O1MsD+4O6uBKogtQdkTa/D3usG4ntS6DMj5Ncq
         fpFV7TPsknIlVs0tEu4e+p/jV8TQhS8XLyMqb7UPcXCl6WGOCRrF2r7cskbmzAlZ8i8r
         zdS+8sVXqbTOmk61Zdm4FsM+YdIpdUWHD8sHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446337; x=1709051137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGSBqi+471g6iUqgaSDbqqcZPD+H6nZRINSP+WgoQ4w=;
        b=oCWgUSgapE30+v1S4mRQC8xjGpcM2BfVP3hJ+305NcccEqC3NIG0Xg6LKbDd5zvD05
         UKSfjAT1Cuhr/iIO+ZlLDDDMhjWDeYYBMEY/MRzr7aW+hdBYCS6RfjjkGdmmAHuzFyGm
         P+MUCfMagbjEqe5hUljullOrR2XfQu+jmpb5HaaGgZ1qTMTOxbpGKiJgmc9J5q5sBE/u
         bR6CG8FN0ElWKHuwlNqitWqz4i+zToydQRw4VgoHWW3PbETcXSUmeP7WsXRxdc0CLQQe
         oe+azuB1VZgSl2kwZQqlyWSGErU3HMwcJW/1X9YwDH85+eSd+ssfasT7x332aqNdm7lr
         wqkg==
X-Forwarded-Encrypted: i=1; AJvYcCXEZRKO4lkuzh/K+78kx/2u0fiZjw3JQHSqMlqP/hnAXi4NcV4WN2Gt9gfyvVt/s2fnTKDjfpzd9BtQh6/1wJ8akyx19xXLXYO1fveH
X-Gm-Message-State: AOJu0Yy/n7tPKDZU0ATmS7AhPtvW6HEP2jH1aDgTLkxCeP7ZQbjGJJGG
	wyJd871miOvQakkw8hY2j0t4ifJzqmktjQDMH2nnM7RU/pq9Ckgpo2+bUR8dlGZLY/bO7NRXjxh
	Wr7RAq1MUmyQ9NfbbvIpjgQ2hIi8REdNznfI9gz6d4Aw33bS7AksKd3Us5GD8btObtihfBXRfwt
	iVNi06DhA1/CDRWXKcSnJf
X-Received: by 2002:a17:902:b687:b0:1da:1daa:e2bd with SMTP id c7-20020a170902b68700b001da1daae2bdmr16183505pls.19.1708446337039;
        Tue, 20 Feb 2024 08:25:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvxvdngmwfVLXi4RuPweXwVlvVK5tru//fjtL0wlKmy5mowGYnUhXP0nd/MJ7ingHb+/MxRg==
X-Received: by 2002:a17:902:b687:b0:1da:1daa:e2bd with SMTP id c7-20020a170902b68700b001da1daae2bdmr16183484pls.19.1708446336746;
        Tue, 20 Feb 2024 08:25:36 -0800 (PST)
Received: from LAP559U.mistral.in ([106.51.69.35])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b001d9ef7f4bfdsm6447398plc.164.2024.02.20.08.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:25:36 -0800 (PST)
From: sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-kumar1@ti.com,
	sabiya.d@mistralsolutions.com,
	Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH V3 0/2] Add CAN and OSPI support for AM69-SK platform
Date: Tue, 20 Feb 2024 21:55:25 +0530
Message-Id: <20240220162527.663394-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1708446337-302472-12796-15689-1
X-BESS-VER: 2019.1_20240214.1700
X-BESS-Apparent-Source-IP: 209.85.214.199
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrKysDAEMjKAYuYplmbGacnGZg
	ZJKeYWBkmpSamGKcnJScZJFmmmyRaJSrWxAIV8xEhAAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.254352 [from 
	cloudscan15-170.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b, BSF_SC0_MISMATCH_TO, NO_REAL_NAME
X-BESS-BRTS-Status:1

From: Dasnavis Sabiya <sabiya.d@ti.com>

Hi All,

This series adds support for the below interfaces on AM69-SK platform:
-  CAN support on both MCU and MAIN domains
-  OSPI NOR flash support

v3: Changelog:
1) Updated OSPI partition table to increase the tiboot3 partition to 1MB.
2) Rebase the sources to accommodate the latest merge.

v2: Changelog:
1) Removed CAN interface aliasing.
2) Updated bootph property on the leaf nodes.

Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/
Link to v2: https://lore.kernel.org/linux-arm-kernel/20240219111422.171315-1-sabiya.d@ti.com/

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
  arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 163 ++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

-- 
2.34.1


