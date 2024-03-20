Return-Path: <linux-kernel+bounces-108505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CEA880B69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762571C2243B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532D1EEE0;
	Wed, 20 Mar 2024 06:48:53 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC11EB22
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917333; cv=none; b=LPi+Khtq8EwKhZPV0yhkhkdNW2LYU4mgCCf414sMBo90C9Q4QPXJ7bxeFwA9ribIx4BnNYJGf5wAmzqNYrsRsQmFV/a60E7ke5XLb9yILuaKnT2xyL7P7nnPzJBg8PUvTls7YNq/BORgV7AA/U5i4LkJa3uJfMaiceVCB/ZTfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917333; c=relaxed/simple;
	bh=DY9u9Lfo3eLrRjxhkOIgk4l+MnabArFl2xaj8Q/AkWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Io9I2Dq5l1HJlwSpY2G7ufcnqx3S+GkXU7AXrjwtSRCj/UMeQd047JDGnhO4xwnrSA+xdMVvlKccK4ZgGsczYQneB8mSxMmUbfIqgXouvQtXXDWyeIvFyoECSZCmzFCTLyH6VHflAxhHT77khQgm83wWxLaj/PbUuABATvaIL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1710917269tim8edwz
X-QQ-Originating-IP: N/gtq/qVsCImawz7+krmJbHB6YTzvD9BQyecJFGP9jM=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Mar 2024 14:47:47 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: eSZ1CZgv+JD7iHPpKJQ1UIkA+4LYjupyEdilj7fFRGppFaU6b3VN4VVL+xaGs
	zLmELMkKmtVwMndWR/RQjQDX0HtesOzf0zFnfdB7FlYzDJDthaIV4Mjdu4hSNmPqsEcyH2i
	DXw4Y9E+PZKmQ+P8cdRgiOydbZLQsmYF4BZtF1qV3ANa3hYiXzSl854TRPeBgSxIFCa7YaE
	ieveaQc6hh2UVh6cCvKqQcsfvXQzXQA41kXVDE+26Wt0jr4v/Hg/GQWHN/uihjOnKaE64lO
	3Ux21U8lsSNgCsdum9BNXsIoQqq2EcRer2Kh1dm/pZ50qOTzszWJk8YEwZkY2q9Eeklj1Vm
	0Wj7pNKuV1g+XSt0Ps8PVL6VNgplnJDdw6DGe897+znaNsr8KNu39dVjulwtA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4717924098038868021
From: Dawei Li <dawei.li@shingroup.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 0/2] Minor cleanup of pgtable_l{4,5}_enabled
Date: Wed, 20 Mar 2024 14:47:10 +0800
Message-Id: <20240320064712.442579-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

This is a trivial series of minor cleanup of pgtable_l{4,5}_enabled.

Change since v1:
- Split into 2 patches, as suggested by Alex.
- Add Reviewed-by from Alex.

v1:
https://lore.kernel.org/all/20240312085005.298657-1-dawei.li@shingroup.cn/

Dawei Li (2):
  riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
  riscv: Annotate pgtable_l{4,5}_enabled with __ro_after_init

 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.27.0


