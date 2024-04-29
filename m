Return-Path: <linux-kernel+bounces-162488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A18A8B5BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC981C21446
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D080058;
	Mon, 29 Apr 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="cR4NfQRT"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CD7EEF3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402258; cv=none; b=cVQuoY9fUNDsLf558abJ7UZLFXvVAxjEcW8L6NthFR2Aoje/VzZH2R3/x+MfxYA+N81fsJuTAY8FjAuoGnTNNqcpKYQjdskkfl1AAK1Y6aMlXjt/qgYJmggCezSwllMdB/GVQ8i7gnJ0sB5tcq98C2bPDUZKsG0E5VQIEi9j8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402258; c=relaxed/simple;
	bh=27EreRFOAHgU+jSBmIoV3nR5fKGUFarI3dQ5IBk0P9Y=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=fMEGeHx8N+hYYWYV9u43pl4bqUYZEDH4+2UikEXKaB/ic4oOId2mMAoltirH9Zp3IkRuATpjaHMqXb9rA5ohJ2b67lVmCCP8c6YKwl3Dh/ZonfYdG6yrXiI3+6fK2YI/seTn3KOisx487+FXZivEJKCtV4uDYzCu/ox1wcG2m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=cR4NfQRT; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401928; bh=27EreRFOAHgU+jSBmIoV3nR5fKGUFarI3dQ5IBk0P9Y=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=cR4NfQRTMafP5SvYwBsJ4ywJrRbJF/UMVO1dqiIyf05cBx0AOZyjb1+Wax5LgjEqW
	 W9yeY/RBnAs81MwnUuuMpzq8zfCcFkx7b0BQdlLuuWbTz/kVbCUoO58CapcRgUeo9l
	 mw7lTUgWx5NnaW0He+0pQZeNv5JkXvgsWKEauYjbl4DkKUhGqXMGuS99mynmETeh5T
	 +3bNgTQO7mLnACD5+bZDDT1QriOuRYbn7xKoB6xKC3+urr/tl31WHndV7Q0FP8cNOD
	 Xbgil78aH0OrlbVvWb/AMRzCpdbdgil8lAz0XdlVBPgFHFa3fRujQLw/FnDmPXsLM9
	 emHodgmZwjqgQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMr60flzDJ;
	Mon, 29 Apr 2024 16:45:28 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:28 +0200
Message-Id: <1ec1a8090c0e316ee005629c24f2779211e0aebf.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 04/12] regulator/core: regulator_bulk_get: remove redundant
 NULL stores
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc:	linux-kernel@vger.kernel.org

On error, callers of regulator_bulk_get() pass the error up and don't
use the pointers in consumers[]. The function is documented to release
all regulators if any request fails.

Note: if an i-th regulator_get() failed only the i-th pointer was
cleared. This is another suggestion that the clearing was unnecessary.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3d7147fabbed..a1573a7ff2b2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4872,11 +4872,7 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 int _regulator_bulk_get(struct device *dev, int num_consumers,
 			struct regulator_bulk_data *consumers, enum regulator_get_type get_type)
 {
-	int i;
-	int ret;
-
-	for (i = 0; i < num_consumers; i++)
-		consumers[i].consumer = NULL;
+	int ret, i;
 
 	for (i = 0; i < num_consumers; i++) {
 		consumers[i].consumer = _regulator_get(dev,
@@ -4885,7 +4881,6 @@ int _regulator_bulk_get(struct device *dev, int num_consumers,
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
 					    "Failed to get supply '%s'",
 					    consumers[i].supply);
-			consumers[i].consumer = NULL;
 			goto err;
 		}
 
-- 
2.39.2


