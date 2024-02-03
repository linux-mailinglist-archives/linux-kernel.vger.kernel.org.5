Return-Path: <linux-kernel+bounces-51318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9CB84895F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F021B2495B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457A413AF3;
	Sat,  3 Feb 2024 22:43:08 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597212E68;
	Sat,  3 Feb 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707000187; cv=none; b=ka+ZHxx2iG3zLs0+AlF6NR0qUeLwrhuPLgf00scoUeGJ6jbgk8sYuNomUvZbmITtTWy+BEWKpS0tazXc2OxTadQqn54lbhX+oBU+yheb3XlxPsZXshr9WruF0c6iec7HYTPOPboEJWEmYuSbNtGavuy2mkEy71NpHwyQCAaA1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707000187; c=relaxed/simple;
	bh=hVfYZuMJypX8SO8Q0Mz5apUsGqZEhj917+dlLvHNxhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=utKkSMz5L1WI/+6G0WPu76tNmyYdbS2qgRE0blbCvurNoAQCxOWowQEG2EA/zmiPQ+qiKHY8TVAbHL0zqs1j/zccv2CL5PrTcsFmG5e8iL0ATNrwlCs4aasS1vUHefcBvUXsldWf2/8bNsxAu7IOjgrPJFiSgZi7YMjxXfmCQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id D02BAA02B7;
	Sat,  3 Feb 2024 23:35:14 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibr8YHfAeCVX; Sat,  3 Feb 2024 23:35:14 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 399BEA022A;
	Sat,  3 Feb 2024 23:35:14 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rWObR-00000002MC2-3T4p;
	Sat, 03 Feb 2024 23:35:13 +0100
Date: Sat, 3 Feb 2024 23:35:13 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
	edumazet@google.com, gnault@redhat.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3] PPPoL2TP: Add more code snippets
Message-ID: <20240203223513.f2nfgaamgffz6dno@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
	edumazet@google.com, gnault@redhat.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)

The existing documentation was not telling that one has to create a PPP
channel and a PPP interface to get PPPoL2TP data offloading working.

Also, tunnel switching was not mentioned, so that people were thinking
it was not supported, while it actually is.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

---
Difference from v1:
- follow kernel coding style
- check for failures
- also mention netlink and ip for configuring the link
- fix bridging channels

Difference from v2:
- fix text alignment

 Documentation/networking/l2tp.rst |   99 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

--- a/Documentation/networking/l2tp.rst
+++ b/Documentation/networking/l2tp.rst
@@ -387,11 +387,16 @@ Sample userspace code:
   - Create session PPPoX data socket::
 
         struct sockaddr_pppol2tp sax;
-        int fd;
+        int session_fd;
+        int ret;
 
         /* Note, the tunnel socket must be bound already, else it
          * will not be ready
          */
+        session_fd = socket(AF_PPPOX, SOCK_DGRAM, PX_PROTO_OL2TP);
+        if (session_fd < 0)
+                return -errno;
+
         sax.sa_family = AF_PPPOX;
         sax.sa_protocol = PX_PROTO_OL2TP;
         sax.pppol2tp.fd = tunnel_fd;
@@ -406,11 +411,97 @@ Sample userspace code:
         /* session_fd is the fd of the session's PPPoL2TP socket.
          * tunnel_fd is the fd of the tunnel UDP / L2TPIP socket.
          */
-        fd = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
-        if (fd < 0 ) {
+        ret = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
+        if (ret < 0 ) {
+                close(session_fd);
+                return -errno;
+        }
+
+        return session_fd;
+
+L2TP control packets will still be available for read on `tunnel_fd`.
+
+  - Create PPP channel::
+
+        int chindx;
+        int ppp_chan_fd;
+
+        ret = ioctl(session_fd, PPPIOCGCHAN, &chindx);
+        if (ret < 0)
+                return -errno;
+
+        ppp_chan_fd = open("/dev/ppp", O_RDWR);
+        if (ppp_chan_fd < 0)
+                return -errno;
+
+        ret = ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx);
+        if (ret < 0) {
+                close(ppp_chan_fd);
+                return -errno;
+        }
+
+        return ppp_chan_fd;
+
+LCP PPP frames will be available for read on `ppp_chan_fd`.
+
+  - Create PPP interface::
+
+        int ppp_if_fd;
+        int ifunit = -1;
+
+        ppp_if_fd = open("/dev/ppp", O_RDWR);
+        if (ppp_chan_fd < 0)
+                return -errno;
+
+        ret = ioctl(ppp_if_fd, PPPIOCNEWUNIT, &ifunit);
+        if (ret < 0) {
+                close(ppp_if_fd);
+                return -errno;
+        }
+
+        ret = ioctl(ppp_chan_fd, PPPIOCCONNECT, ifunit);
+        if (ret < 0) {
+                close(ppp_if_fd);
+                return -errno;
+        }
+
+        return ppp_chan_fd;
+
+IPCP/IPv6CP PPP frames will be available for read on `ppp_if_fd`.
+
+The ppp<ifunit> interface can then be configured as usual with netlink's
+RTM_NEWLINK, RTM_NEWADDR, RTM_NEWROUTE, or ioctl's SIOCSIFMTU, SIOCSIFADDR,
+SIOCSIFDSTADDR, SIOCSIFNETMASK, SIOCSIFFLAGS, or with the `ip` command.
+
+  - L2TP session bridging (also called L2TP tunnel switching or L2TP multihop)
+    is supported by bridging the ppp channels of the two L2TP sessions to be
+    bridged::
+
+        int chindx1;
+        int chindx2;
+        int ppp_chan_fd;
+
+        ret = ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
+        if (ret < 0)
+                return -errno;
+
+        ret = ioctl(session_fd2, PPPIOCGCHAN, &chind2x);
+        if (ret < 0)
+                return -errno;
+
+        ppp_chan_fd = open("/dev/ppp", O_RDWR);
+        ret = ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
+        if (ret < 0) {
+                close(ppp_chan_fd);
                 return -errno;
         }
-        return 0;
+
+        ret = ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
+        close(ppp_chan_fd);
+        if (ret < 0)
+                return -errno;
+
+See more details for the PPP side in ppp_generic.rst.
 
 Old L2TPv2-only API
 -------------------

