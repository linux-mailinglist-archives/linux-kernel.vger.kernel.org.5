Return-Path: <linux-kernel+bounces-116685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BF88A296
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8FF2C778F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74841148855;
	Mon, 25 Mar 2024 10:26:14 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE214D71D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354674; cv=none; b=LkIpMX0swAa6GHusG/IStiUZlYi4iJB/93pXp381wkJYpWnLXa1I3GVepNUC3bgZOVBA/jWyMslIiXNxoiXlFQilxq4/VSahF1aLC0HjwyBV0EfarFdhUlahnlIhjiq/CXJ/+uCooLx2emrEfcLDfXghccPgcX+HQrkbCJpkQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354674; c=relaxed/simple;
	bh=Wg6WfcPEQwL55T2esk9lNY5WkdI7LYEAnLpWUMOjO7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tJhgkjmsYmZl9ubN+VFLfMqgEs4+2PWc95ODVeKlXzTX5/JWc6Y9bcHmj3VpDNwFXUlhYcmOOzH6wLzoSaFz42y5gjHvqslm7DuyH+UO+kUp3ysu5Qm3ijtJaGoo3cUSjwTYaQfd54O25arKQ4ScIjkhMViiijo8EhbUBIXfKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1711354526t5s54l32
X-QQ-Originating-IP: Ls4Prxq7MO6NstYxnaRQFYkyDxV81ahZ0/dWjvhVzjo=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 Mar 2024 16:15:25 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: znfcQSa1hKaBnlMfaFPyz3i3KVZXH+Ls6uBPmKtEh39Zd+BhmVL0TmkIKYXGl
	tKvXPNuC82SSXYAoj633PyDPOsSA3W4Mx6Ad1cKPYog48WdmAgovUN0bb7ugULXWd2Vk/Bm
	Irz9ppxvyB2arDA+Z3UyaNEx++5jHM5L0G9lU2prd1bPHxsKiepFh7okZrWbCS38MLVg4Fz
	gInHl66sYt8Ufu3FPNI7YaI5tW8hjpyBuREMBbbAwv8P71SqTyJm/cwG3abwdITx3O1RMAR
	ctI5xFoSQq3A1Nbt2Avl7vh5U6LSfUCkCjZlO7/vU1LBRX3yZDtFigKgxF5SWbVC7Bq3rzq
	zNdlVtvY/xNL0X+UCHop8SqQQe2MCLrxPzPcpKEDgCtoYpKLD27uZmwHJ9eyarYe62n/gQJ
	3YzNTOGA4J4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 77173555368639370
Date: Mon, 25 Mar 2024 16:15:24 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: xiubli@redhat.com
Cc: linux-kernel@vger.kernel.org, dawei.li@shingroup.cn
Subject: re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Message-ID: <EAE021FE9F306785+ZgEynLFHyPF1TMQQ@centos8>
Reply-To: e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

Sorry for the top-posting cuz I miss you original mail.

About issue on [1], maybe I am the trouble maker here.

Can you please revert commit below to see if it can fix it?
commit 328c801335d5f7edf2a3c9c331ddf8978f21e2a7
cpumask: create dedicated kmem cache for cpumask var

[1] https://lore.kernel.org/all/e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com/

Sorry for the mess.

Thanks,

	Dawei

