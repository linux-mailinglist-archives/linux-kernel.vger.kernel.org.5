Return-Path: <linux-kernel+bounces-73613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E785C520
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776CE283B00
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80214C5A5;
	Tue, 20 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="C4LgFSah"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1914A0B6;
	Tue, 20 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458307; cv=none; b=Whdi/iDmdZV5yF5Ktsn0c7Wh3ea3nuar8fzR/t8+Q9hB6cu6dWztbgKqPe74jZNwBR1n7j7+Om0PMaxXgxDkxahJYztrB8cDKJhc3UBQ02Rihcf4n6vcTv+f0KOgEJQOC+FpiraNm+crr9t1uNqMl9KP4e9O2VUvAeI690juALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458307; c=relaxed/simple;
	bh=SQvynyntrh4mzXiFdzzGOqWMD8t0yJGwv9xwE/ScJU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ij1j65tV0jDZFIxbXHiXvH7ejXL+BEsHzobYRal/HgBpA+KDtj995kt8/lCyMaLi24yMd6bvHns9o0fmClapyTvxj1FVPUhTm3D8mbcjT1LoUHrcCn/zFT4oV7HtkTHd1W60l8yxeMY87DfbAGQhD0uWysgky4JeQUE15hnjgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=C4LgFSah; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 16491200BE5F;
	Tue, 20 Feb 2024 20:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 16491200BE5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708458297;
	bh=h7EcwSW71SSSDL0dnFc82jgR2ymx/wCW+Xnzy4FBRVk=;
	h=From:To:Cc:Subject:Date:From;
	b=C4LgFSahEyCLpy/HMeEojNoufstQvHzsc0cLHBylkMjy5R6wKz0M2EThWqEWa1E3f
	 aZbOQ2aC4LidvCdwG7rmoTVO0/fUmd5bc6oRKreqicN8V9IBzWaAbmCeCpnvHG+itB
	 ARXZArvcM9LHzwUEBoRBMJ7ia6w8J63RLUOjzaDmaqXo4HuRiT2NhV22zptKf9d27S
	 xAbKtDTAlGp0DNoksi2GLtzacI+fDiRgvx8O/HkEVoOJBRtAgb/NfCFmf5CMIivd9l
	 BWs+zfTUk+WnOkqD3AS1VUrNfEBljTUUADxpLLsxNbO+2mf+oSEIO+oHXvilH2kYnx
	 C2NPeZ6YtUc9g==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 0/3] multicast event support for ioam6
Date: Tue, 20 Feb 2024 20:44:41 +0100
Message-Id: <20240220194444.36127-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic netlink multicast event support to ioam6 as another solution
to share IOAM data with user space. The other one being via IPv6 raw
sockets combined with ancillary data. This patchset focuses on the IOAM
Pre-allocated Trace (the only Option-Type currently supported), and so
on IOAM "trace" events. See an example of a consumer here [1].

  [1] https://github.com/Advanced-Observability/ioam-agent-python/blob/netlink_event/ioam-agent.py

Suggested-By: Paolo Abeni <pabeni@redhat.com>

Justin Iurman (3):
  uapi: ioam6: API for netlink multicast events
  ioam6: multicast event
  net: exthdrs: ioam6: send trace event

 include/net/ioam6.h             |  4 +++
 include/uapi/linux/ioam6_genl.h | 20 +++++++++++
 net/ipv6/exthdrs.c              |  5 +++
 net/ipv6/ioam6.c                | 61 +++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)


base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
-- 
2.34.1


