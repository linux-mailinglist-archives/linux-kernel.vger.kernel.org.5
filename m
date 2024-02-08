Return-Path: <linux-kernel+bounces-57763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C5084DD24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648FA2870AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F36D1B7;
	Thu,  8 Feb 2024 09:38:29 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B086BFC2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385108; cv=none; b=Rxtuq1EiSLKZODpHG4r/Q3LnvI5LHE2j0tkYmSbK0TTa1gml46V6WvbucsepOlWRRyRixcWK6ysOrLtKVXmmUmmL7E3UiiVqLPD8/lcngVrBbFJ5pTAG+dm9ERNhymyUU5mrjsHq8RjeHXS5C+a2FSHNVGnewZNeipxQINNCA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385108; c=relaxed/simple;
	bh=HePxAJzG+Hzp9z7hNBUyZDvvmWxVkU8m291kkXWPkL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMmnwWCuyXwoEuuKtUeo7ZeXTZjnCeSdwLJQYad9YVAIhukQDyIlPOX/eaYpIZeHKK3f5XdPjqSg5ky5uMeZ/PJBV1FhN67FAh5wbsqv7ctkrlLWT6sWL5GqZSkt5iUBs7ltNG2407lH1Ut1tiMWT88IKWNbyT5qohEMa58sYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from framework.labs
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Thu, 08 Feb 2024 10:38:19 +0100
From: David Ventura <david@davidv.dev>
To: david@davidv.dev
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: [PATCH v2 0/2] net: ipconfig: remove wait for drivers
Date: Thu,  8 Feb 2024 10:35:53 +0100
Message-Id: <20240208093722.246930-1-david@davidv.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently ip autoconfiguration has a hardcoded delay of 10ms.

Make the delay configurable via the new `ip.dev_wait_ms` argument, and
set the default value to 0ms.
    

    David



