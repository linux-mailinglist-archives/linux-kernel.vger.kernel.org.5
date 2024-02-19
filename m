Return-Path: <linux-kernel+bounces-71427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A085A519
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9A281A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30236B0E;
	Mon, 19 Feb 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="wC79w9Av"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABEF364AB;
	Mon, 19 Feb 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350526; cv=none; b=qEJuqxzIsQCmn7jmnZlWLbMVfuCkQaCw8EiBID2Nvdpj2i39LsySEyaAzTOy7dPmM3NXyY6L8Awe6sFQ9YDWuH6AF8e9cJtRJFE6dyF5/ngWZB9DuLA6ZKghtKvENPyDLLyXYXm29i1JIwh9AwqS1ISpPjpTxpwPjbyQSfxz7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350526; c=relaxed/simple;
	bh=wL/23D8NCnghW0/R7m8chsNXdV/IJdIAhfUV7sVJLgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDt71pCEdlsam0XiZ+8kzMdSQbReU3J246v1pVyYk1Xfb3Z05IO5bsI24nvSIl/dghqJNzZjzZVyYr88Tbt9uOY+QIDKvlTWhz3J/PFmgQEiaEtEGf2X/7tG/qvY7p1gWcGEBDS7T2spktIj2QPjkoS+ShJVwZIGSz+RSoehqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=wC79w9Av; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 1EEA8200EEA1;
	Mon, 19 Feb 2024 14:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 1EEA8200EEA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350522;
	bh=SY9aNVlTacbXAp2vEn5d+PobDYqqZDYINWpMGDqIKwk=;
	h=From:To:Cc:Subject:Date:From;
	b=wC79w9AvPvWPbkvfsT7tIFvJH/3EFpGd50R71n1M3rs7CjCGAuCVd0ylV4mTo6wNF
	 rQY1bZ3NZ3BtYaKvyMO5Hl9Pd3J7iItX/oA3HTnpqhr9MkTD9rZX+atwUvK9NWX/uw
	 RYs1ckSMOg7k9p+q28jQyd5eRdIVyJnuY0SRjfLQzrjOTkq4ULg2CJKzl59E6NKCLJ
	 nzGLqG6tJyXi/FDkleei6Ie/Q8ZXM5CB6OM9jyQFXHO3WiH+1lbqPG1+Y8KoN6UlwD
	 wR8h6nVeHMCLiA6UC/BiVSuZ4w9qs6SyURXLwrDUDnIwyvCwYLsouYZMd5syG2XRi5
	 K20lwmnsKxWCQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v2 0/2] ioam6: fix write to cloned skb's
Date: Mon, 19 Feb 2024 14:48:19 +0100
Message-Id: <20240219134821.14009-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - use skb_ensure_writable() instead of skb_cloned()+pskb_expand_head()
 - refresh network header pointer in ip6_parse_tlv() when returning from
   ipv6_hop_ioam()

Make sure the IOAM data insertion is not applied on cloned skb's. As a
consequence, ioam selftests needed a refactoring.

Justin Iurman (2):
  Fix write to cloned skb in ipv6_hop_ioam()
  selftests: ioam: refactoring to align with the fix

 net/ipv6/exthdrs.c                         | 10 +++
 tools/testing/selftests/net/ioam6.sh       | 38 ++++-----
 tools/testing/selftests/net/ioam6_parser.c | 95 +++++++++++-----------
 3 files changed, 76 insertions(+), 67 deletions(-)


base-commit: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210
-- 
2.34.1


