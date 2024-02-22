Return-Path: <linux-kernel+bounces-77536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43823860707
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631441C23526
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC521A14;
	Thu, 22 Feb 2024 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="bFMHxLQ6"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B418629;
	Thu, 22 Feb 2024 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644842; cv=none; b=IeCWXaGsf2zY3JW3ZQsmlcIsY4/R8j3F4ac2ZM2WtZrlW8hQUJO70mR0rRxRIqscqEK2lWrWFqHESJEK2U977WH6gbmWiaPFv4RRZxvJ9rwiInERRMsHp+VRcmrP1TC908RuoXh1dEbLEDuIkmcOnk47vkARWZCxs+gWF2AVGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644842; c=relaxed/simple;
	bh=tMAlTZsOvCYKytNUvHoLZfMzudRoJG0IpAzJt9bpixo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krkQYAPqVUuAqNizun49qKtmNncdOhybu5wdHLoLa2Je+F8D9rToCRZXs8NG3a1Pc1bVuxBLrbkSQ/xJUImawrsLpQMsVZXg28LY5xe6BYILIgzKvPLxp4YGur228EiA7DvwZAqjfvQQ5sKCUY1KkGfkst8jr1R8T1chKtl0X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=bFMHxLQ6; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8A238200C97A;
	Fri, 23 Feb 2024 00:33:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8A238200C97A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708644836;
	bh=zi0Ftown2eOssqg2MrxzR4GuTOt3TjpmtA5CJpt0Kew=;
	h=From:To:Cc:Subject:Date:From;
	b=bFMHxLQ6Q+uvm85eTBexoAlhuCB9sZkrmBAFxqCivT2Vzhmt2rAL4vM9ZIyFrj4h9
	 1rPsC3B9UJ3XgWJ9TavZUDvfcJdGonG8Wu6if2LN7X2nw63rCbUbM9P+2J4GWP7xX5
	 9/v2D6pXirYjJprWGomJp3TnhW3jjVRSqgDsYjThqd+73HkQz64wOwzeLNRZTSZ1id
	 yXzhNmReBKv6jCzedT7UsZvR9P7OaTrtUxJFnnpwaS0GA7cZiU9tcfHAWF9rfSRHS2
	 RMQB8ZZ5gabUsXzUxr+7H40Dt7uUqN8AG2xYYwlRBsPhlmykHEvqDn//Ym3ndt8SaC
	 PFaPmWnwU2faA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v3 0/3] ioam6: netlink multicast event
Date: Fri, 23 Feb 2024 00:33:34 +0100
Message-Id: <20240222233337.5342-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 - patchset was mistakenly superseded due to same cover title used for
   iproute2-next equivalent patch -> resend (renamed)
v2:
 - fix warnings

Add generic netlink multicast event support to ioam6 as another solution
to share IOAM data with user space. The other one being via IPv6 raw
sockets combined with ancillary data. This patchset focuses on the IOAM
Pre-allocated Trace (the only Option-Type currently supported), and so
on IOAM "trace" events. See an example of a consumer here [1].

  [1] https://github.com/Advanced-Observability/ioam-agent-python/blob/netlink_event/ioam-agent.py

Justin Iurman (3):
  uapi: ioam6: API for netlink multicast events
  net: ioam6: multicast event
  net: exthdrs: ioam6: send trace event

 include/net/ioam6.h             |  4 +++
 include/uapi/linux/ioam6_genl.h | 20 +++++++++++
 net/ipv6/exthdrs.c              |  6 ++++
 net/ipv6/ioam6.c                | 64 +++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)


base-commit: a6e0cb150c514efba4aaba4069927de43d80bb59
-- 
2.34.1


