Return-Path: <linux-kernel+bounces-162478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B18B5BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E3628233A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48084A5F;
	Mon, 29 Apr 2024 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="UuMwGh6L"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44F80633
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401942; cv=none; b=jy2JancY3p+I1HPfJaMWnH+MmCiNWfFj0fBU8Qa+X8qM9uW11W1einQsSW8Fx62oEnmVp+71qsWs7G+UvzwNQ1IWf57RQ2IGL70pr3BKh60eVNzz1icjP3QsW1N7eopPtFqi0R++wuN+Z8vEzvCKBeDGvaJwh7hd/VC3x3Q25Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401942; c=relaxed/simple;
	bh=XOjGi/2Lne6XOZ5e5aW/2dU32ukuNR6WyG/LG7Qn0N4=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=P9R4+SI4Vo505ZmPpeNzPDJjJeJ3goXAOYqsstp4sa1nvieZSk9j/xlucmJVE6ZmQth3R8tVyQswdLtGefY2aUoWSIN8SKAEB/drM0CZ5rAJ04+p9WxxyAjpgsvOOCG2f9rcyG76fe0wJ4tyVxSFNjVXqGpjlPmfyeVm8cdqw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=UuMwGh6L; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714401932; bh=XOjGi/2Lne6XOZ5e5aW/2dU32ukuNR6WyG/LG7Qn0N4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=UuMwGh6LUoMayHam9P7nJfARkeY0zPPQJWQneeIFexxCFe/Su5sQFB1jEkeXKqbiR
	 9CM+rCS7457f6hH501JhBNeV+fnQZC+n+7UcBQMuCwofDMMoDfPJCVlrVG3gEpHrbf
	 1W/r13ev/HyAFRY3ij+R8ed6YnPWNwvuv+Rqvr2Psw00urBe5LQh2OlZ6ce0GFiraj
	 GqVoU64kqcoGBTLg5nftioWxqGQN+EMexLOOdxDHCRZQrAIRRfDW6D91TCiMiCCNLW
	 ui1jzJGhEoaWLT0mgpSqcJZrQTMZCtN2/S5/PWA2l5wOXOi2vxmYXOrRezsv36wqIG
	 nB1L1LRoh1Jmw==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VSmMw4JStzd3;
	Mon, 29 Apr 2024 16:45:32 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Mon, 29 Apr 2024 16:45:32 +0200
Message-Id: <90c898494b540d51767a108574cf76b7477085e5.1714399603.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 10/12] regulator/core: use dev_to_rdev() for device ->
 regulator_dev cast
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

There is 1:1 relationship between regulator_dev and device (rdev->dev)
structures.  Since we already have dev_to_rdev() to follow from
&rdev->dev to the rdev, use it instead of dereferencing a pointer.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 51 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 431e1c164b11..d7192530d3e0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -650,7 +650,7 @@ regulator_get_suspend_state_check(struct regulator_dev *rdev, suspend_state_t st
 static ssize_t microvolts_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	int uV;
 
 	regulator_lock(rdev);
@@ -666,7 +666,7 @@ static DEVICE_ATTR_RO(microvolts);
 static ssize_t microamps_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return sprintf(buf, "%d\n", _regulator_get_current_limit(rdev));
 }
@@ -675,7 +675,7 @@ static DEVICE_ATTR_RO(microamps);
 static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return sprintf(buf, "%s\n", rdev_get_name(rdev));
 }
@@ -704,7 +704,7 @@ static ssize_t regulator_print_opmode(char *buf, int mode)
 static ssize_t opmode_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_opmode(buf, _regulator_get_mode(rdev));
 }
@@ -723,7 +723,7 @@ static ssize_t regulator_print_state(char *buf, int state)
 static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	ssize_t ret;
 
 	regulator_lock(rdev);
@@ -737,7 +737,7 @@ static DEVICE_ATTR_RO(state);
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	int status;
 	char *label;
 
@@ -784,7 +784,7 @@ static DEVICE_ATTR_RO(status);
 static ssize_t min_microamps_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	if (!rdev->constraints)
 		return sprintf(buf, "constraint not defined\n");
@@ -796,7 +796,7 @@ static DEVICE_ATTR_RO(min_microamps);
 static ssize_t max_microamps_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	if (!rdev->constraints)
 		return sprintf(buf, "constraint not defined\n");
@@ -808,7 +808,7 @@ static DEVICE_ATTR_RO(max_microamps);
 static ssize_t min_microvolts_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	if (!rdev->constraints)
 		return sprintf(buf, "constraint not defined\n");
@@ -820,7 +820,7 @@ static DEVICE_ATTR_RO(min_microvolts);
 static ssize_t max_microvolts_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	if (!rdev->constraints)
 		return sprintf(buf, "constraint not defined\n");
@@ -832,7 +832,7 @@ static DEVICE_ATTR_RO(max_microvolts);
 static ssize_t requested_microamps_show(struct device *dev,
 					struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	struct regulator *regulator;
 	int uA = 0;
 
@@ -849,7 +849,7 @@ static DEVICE_ATTR_RO(requested_microamps);
 static ssize_t num_users_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	return sprintf(buf, "%d\n", rdev->use_count);
 }
 static DEVICE_ATTR_RO(num_users);
@@ -857,7 +857,7 @@ static DEVICE_ATTR_RO(num_users);
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	switch (rdev->desc->type) {
 	case REGULATOR_VOLTAGE:
@@ -872,7 +872,7 @@ static DEVICE_ATTR_RO(type);
 static ssize_t suspend_mem_microvolts_show(struct device *dev,
 					   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_mem.uV);
 }
@@ -881,7 +881,7 @@ static DEVICE_ATTR_RO(suspend_mem_microvolts);
 static ssize_t suspend_disk_microvolts_show(struct device *dev,
 					    struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_disk.uV);
 }
@@ -890,7 +890,7 @@ static DEVICE_ATTR_RO(suspend_disk_microvolts);
 static ssize_t suspend_standby_microvolts_show(struct device *dev,
 					       struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return sprintf(buf, "%d\n", rdev->constraints->state_standby.uV);
 }
@@ -899,7 +899,7 @@ static DEVICE_ATTR_RO(suspend_standby_microvolts);
 static ssize_t suspend_mem_mode_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_mem.mode);
@@ -909,7 +909,7 @@ static DEVICE_ATTR_RO(suspend_mem_mode);
 static ssize_t suspend_disk_mode_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_disk.mode);
@@ -919,7 +919,7 @@ static DEVICE_ATTR_RO(suspend_disk_mode);
 static ssize_t suspend_standby_mode_show(struct device *dev,
 					 struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_opmode(buf,
 		rdev->constraints->state_standby.mode);
@@ -929,7 +929,7 @@ static DEVICE_ATTR_RO(suspend_standby_mode);
 static ssize_t suspend_mem_state_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_mem.enabled);
@@ -939,7 +939,7 @@ static DEVICE_ATTR_RO(suspend_mem_state);
 static ssize_t suspend_disk_state_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_disk.enabled);
@@ -949,7 +949,7 @@ static DEVICE_ATTR_RO(suspend_disk_state);
 static ssize_t suspend_standby_state_show(struct device *dev,
 					  struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	return regulator_print_state(buf,
 			rdev->constraints->state_standby.enabled);
@@ -959,7 +959,7 @@ static DEVICE_ATTR_RO(suspend_standby_state);
 static ssize_t bypass_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 	const char *report;
 	bool bypass;
 	int ret;
@@ -983,7 +983,7 @@ static DEVICE_ATTR_RO(bypass);
 	{										\
 		int ret;								\
 		unsigned int flags;							\
-		struct regulator_dev *rdev = dev_get_drvdata(dev);			\
+		struct regulator_dev *rdev = dev_to_rdev(dev);				\
 		ret = _regulator_get_error_flags(rdev, &flags);				\
 		if (ret)								\
 			return ret;							\
@@ -5278,7 +5278,7 @@ static const struct attribute_group *regulator_dev_groups[] = {
 
 static void regulator_dev_release(struct device *dev)
 {
-	struct regulator_dev *rdev = dev_get_drvdata(dev);
+	struct regulator_dev *rdev = dev_to_rdev(dev);
 
 	debugfs_remove_recursive(rdev->debugfs);
 	kfree(rdev->constraints);
@@ -5588,7 +5588,6 @@ regulator_register(struct device *dev,
 		goto rinse;
 	}
 	device_initialize(&rdev->dev);
-	dev_set_drvdata(&rdev->dev, rdev);
 	rdev->dev.class = &regulator_class;
 	spin_lock_init(&rdev->err_lock);
 
-- 
2.39.2


