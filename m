Return-Path: <linux-kernel+bounces-9997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA881CE78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11821C22576
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A582C1AD;
	Fri, 22 Dec 2023 18:31:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862924B20;
	Fri, 22 Dec 2023 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E109121EB3;
	Fri, 22 Dec 2023 19:31:17 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Input: ilitek_ts_i2c - Fix spurious input events
Date: Fri, 22 Dec 2023 19:31:12 +0100
Message-Id: <20231222183114.30775-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

A couple of fixes to prevent spurious events when the data buffer is not the
expected one.

v3:
 - added reviewed-by and take over series from emanuele

v2:
 - initial series, sent by mistake as v2 instead of v1

Emanuele Ghidoli (2):
  Input: ilitek_ts_i2c - avoid wrong input subsystem sync
  Input: ilitek_ts_i2c - add report id message validation

 drivers/input/touchscreen/ilitek_ts_i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.1


