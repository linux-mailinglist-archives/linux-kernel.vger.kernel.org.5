Return-Path: <linux-kernel+bounces-95721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8C8751BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B88B24844
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818E12EBC4;
	Thu,  7 Mar 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="MUG8Dria"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884012AAEA;
	Thu,  7 Mar 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821434; cv=none; b=jI+zdYuJz86Dm8rIJ33WvZLHwyS9SjkcCkyg8Ex/04XO4q0vC2Mq2tP43WwMOzc17mEOLRS0xHub+lb4urcJzCB9JQTEmu0ztjN+qccUEOtTxYh9En1bhWVjTEfYOp6ONY0JsIFtGgzM2p9SElp3/+h/VWvf+gNfJ72oCCFvYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821434; c=relaxed/simple;
	bh=K9CJFiPzKn0/9n6jjy0t/iiOfJO/+ZvwcJIGx4qeTZk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J5Ro71f2OY6QMjS2Wijks+0u35atiqpUmC47pZw3qi04HP708FRqYjpnK5YJ6kSsAuZDwm2bhsARGqmERLmmgUAT6uOgiUYQrlRTChvZ7DXcmOXNnW+aLVyrwJz12CDBThfs4HswpphgjhA3t58vsJdOk3GyI8qWWAyexQiBkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=MUG8Dria; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 465C814B179E;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 465C814B179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821430; bh=NtBoOwRe3XBFBZHutJKVQqhD4VpJV2GK2CANHjLz/tQ=;
	h=From:To:CC:Subject:Date:From;
	b=MUG8Driagh/YJX5zknkOAKFqiV4JfXjch6qaTQi31vyKsDAVB3XGNBKI2IWaOJZnz
	 71TXepSpg24dvsAO4XRSDTuqo1LDga98G9coXVab9HdpMpPCRWTFT5Z0psEPTttBdt
	 dBjFZ+r0L54KuS1o5fmA7i5Og0OxeqgSjpG+5jSw=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 427E231923B0;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, Eric Dumazet
	<edumazet@google.com>, James Chapman <jchapman@katalix.com>, Martin Schiller
	<ms@dev.tdt.de>, Shigeru Yoshida <syoshida@redhat.com>, Mina Almasry
	<almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Tom Herbert
	<tom@herbertland.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2 0/6] fix incorrect parameter validation in the
 *_get_sockopt() functions
Thread-Topic: [PATCH net-next v2 0/6] fix incorrect parameter validation in
 the *_get_sockopt() functions
Thread-Index: AQHacJsSfM+z51tyokOtTAwhDOyUiw==
Date: Thu, 7 Mar 2024 14:23:49 +0000
Message-ID: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/07 13:22:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/07 10:14:00 #24028863
X-KLMS-AntiVirus-Status: Clean, skipped

This v2 series fix incorrent parameter validation in *_get_sockopt()
functions in several places.

version 2 changes:
- reword the patch description
- add two patches for net/kcm and net/x25


Gavrilov Ilia (6):
  tcp: fix incorrect parameter validation in the do_tcp_getsockopt()
    function@@
  udp: fix incorrect parameter validation in the udp_lib_getsockopt()
    function@@
  ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt()
    function@@
  l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt()
    function@@
  net: kcm: fix incorrect parameter validation in the kcm_getsockopt)
    function@@
  net/x25: fix incorrect parameter validation in the x25_getsockopt()
    function@@

 net/ipv4/ipmr.c     | 4 +++-
 net/ipv4/tcp.c      | 4 ++--
 net/ipv4/udp.c      | 4 ++--
 net/kcm/kcmsock.c   | 3 ++-
 net/l2tp/l2tp_ppp.c | 4 ++--
 net/x25/af_x25.c    | 4 ++--
 6 files changed, 13 insertions(+), 10 deletions(-)

--=20
2.39.2

