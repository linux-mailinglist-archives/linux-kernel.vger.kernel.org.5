Return-Path: <linux-kernel+bounces-162499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FF8B5C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2BF1C21F75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0680023;
	Mon, 29 Apr 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="OuEMaWs/"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0207EEF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402558; cv=none; b=qmbWJdHci7XZ+aRAYyKqqEeNxk1B/uMFIE7IJVAXJMmNaHSLVy8AMxZwV6i/ZaqUiTFh+xo/jeqePhFg0X+HcBFu2+SJp6yFlXs88Uk8NqZQa+X9VYDJOgQAO4JcxA3AJ4twMFZ+4B3RNp/CzNIzRzCTP/ko1Vu0qtShWj4rPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402558; c=relaxed/simple;
	bh=cCS+DVLBcUHkUuYmcqkFBMezGuTJlFBBRX3YxppQm40=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=fryk4p6L2NSo51AKjG1i22sGgXoY9itqL3Etb5bDPSMy/eFAf8uEF0HZe7KMZEXnzyhAWMf4D6RQ3pL3GzNn3DH7pg6+1u77qNxCSUxlRmQ0NkVKiAOrTizacVPpfWCwwx/3loHlJ/e0TMXuQW7M/hnRiZEnwPAjNdge43yRAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=OuEMaWs/; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401928; bh=cCS+DVLBcUHkUuYmcqkFBMezGuTJlFBBRX3YxppQm40=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=OuEMaWs/7pg3zJyycDLH8eqqRUDlq91Rjfc35++RcaAXUaxMaDHlQNl4iwWeb5sCs
	 h9AY335esHMkvPbm4Q+uo5PIy1ZzCOw5oD123CbkFuaP10Bk3uP6DfE/OYFT4CHcqC
	 91BemroiHoJCZwDXJdLA9Ubj5TSm9WAB7cltUkxYolEaeejAzBb8n51P3d31hIXQ7L
	 OfiKEA7P1qzeyhML7P6QN/m53IXqpMN6YtPcoOcAlXNgzhdwczfQSvvZ0co09Hwkbx
	 2qJpJqvE6ufCkDLzypjtDACzeoEdFt/aB1vY9A9mlLIST9LgxBRQtcjev+syCTUFf6
	 6Ti2RcRrPYaWg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMr3f1NzCW;
	Mon, 29 Apr 2024 16:45:28 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:28 +0200
Message-Id: <079287cf3922f3b38a4f751f6e9097816037dd8e.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 03/12] regulator/core: of_get_child_regulator: remove goto
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

Because of_node_put() handles NULL properly (like kfree() et al)
we can call it also after the loop ends (due to child == NULL).
This makes the gotos redundant.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5db3bf08145c..3d7147fabbed 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -438,18 +438,15 @@ static struct device_node *of_get_child_regulator(struct device_node *parent,
 
 	for_each_child_of_node(parent, child) {
 		regnode = of_parse_phandle(child, prop_name, 0);
+		if (regnode)
+			break;
 
-		if (!regnode) {
-			regnode = of_get_child_regulator(child, prop_name);
-			if (regnode)
-				goto err_node_put;
-		} else {
-			goto err_node_put;
-		}
+		regnode = of_get_child_regulator(child, prop_name);
+		if (regnode)
+			break;
 	}
-	return NULL;
 
-err_node_put:
+	/* Release the node if the loop was exited early. */
 	of_node_put(child);
 	return regnode;
 }
-- 
2.39.2


