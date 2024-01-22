Return-Path: <linux-kernel+bounces-34021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE398371FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102E41C2AE77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD1605BA;
	Mon, 22 Jan 2024 18:47:18 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958C604BE;
	Mon, 22 Jan 2024 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949238; cv=none; b=Qy5EbdHpe7MG1bcplmxtoLUzG/nY+BPlpLcaPCqIihp0a9MdziuV8KWwf/5TwlEkMz7SGeDpedLLloOtPKcDlFZAYx7yeiSYa7Gimtx4ljiNslK4Goe4KawpW3x79pU+X6lj140k0b6H+efazuU8Epo/qbd18W7/h4qMxzgzbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949238; c=relaxed/simple;
	bh=2FcpcK//gV6t4tbeKRXqr0tCEGpr2xkrWi07ki4Ib+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQut8zpw7cnQvr0OJje83UbHH0bmmkd/ugNjkEx0iqH5FjLfoZUCObpTl0w/UZTQivJQd0r5et1VmAN0ocBcvHs4/hTH8JDvUlryJwzFdgEWLwtZIS2W8WMZwmDYON8qaiWG6Y2Z95ZdoNH0NzsxBJQrhou3AxyinJX+jbORT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26f73732c5so382958066b.3;
        Mon, 22 Jan 2024 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949235; x=1706554035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sifsnwJKjbeVUw+8v1vwo1kqKRBi0h7LZ0ZH//xM3QQ=;
        b=rrwocnsQKxZ8YcG4fgBPtHJ+i8+obmPkRZBOOLHTKJt5+D0jliYwdVkljmXiNo+DPW
         e9Ss2Gtcle05gbkobb8n76NX9VYiwpkJWvxYvzGnH+9gLxpvgMVUk6rDIQsCv73dUYSL
         lCFUbBzb7tOHgE7DWzHeEeTHJzGDsd7Mv4A6nnZC+0T3k2KEjDxrG4pNgXUYVlBUxe+V
         GAGQ9xW1BgUJKcW39loXr/4leeMFgn8MFvyNKZD5C+jQS5N8TbV1MAi1RUVemTOoHvp1
         Aeen+AoA89D4EZlAskNwJar/xVevnrpCIFgP0rmYayvEdCugK+2RfBvbvD4KWcYDL2mg
         mghA==
X-Gm-Message-State: AOJu0YxTVMfqRzX+ozTre+sDebwLrLQzXVezIWAD8SVZbBP/8SDcr5/3
	qC3x7KFDvxrzTECVGaSIIdrTu92JnSffEagdfldlRTiNsHprDTCU
X-Google-Smtp-Source: AGHT+IGnMPwJE0Q1is9T7HFK8gmXR9/O6YtKRNDxxHEp8E+cqEbkgWVlRf9uHCbWgNDeIHVRIbex0Q==
X-Received: by 2002:a17:907:2092:b0:a2c:872c:5683 with SMTP id pv18-20020a170907209200b00a2c872c5683mr2043302ejb.41.1705949234925;
        Mon, 22 Jan 2024 10:47:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709064bd900b00a28f54aacf1sm13671366ejv.185.2024.01.22.10.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:47:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Dariusz Marcinkiewicz <reksio@newterm.pl>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:BECKHOFF CX5020 ETHERCAT MASTER DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 22/22] net: fill in MODULE_DESCRIPTION()s for ec_bhf
Date: Mon, 22 Jan 2024 10:45:43 -0800
Message-Id: <20240122184543.2501493-23-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Beckhoff CX5020 EtherCAT Ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/ec_bhf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index c2c5c589a5e3..44af1d13d931 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -590,5 +590,6 @@ module_pci_driver(pci_driver);
 module_param(polling_frequency, long, 0444);
 MODULE_PARM_DESC(polling_frequency, "Polling timer frequency in ns");
 
+MODULE_DESCRIPTION("Beckhoff CX5020 EtherCAT Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dariusz Marcinkiewicz <reksio@newterm.pl>");
-- 
2.39.3


