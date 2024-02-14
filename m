Return-Path: <linux-kernel+bounces-64662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C173854135
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060E61F21EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B142BA28;
	Wed, 14 Feb 2024 01:21:15 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B2625;
	Wed, 14 Feb 2024 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873674; cv=none; b=VToUYbtA18d0umuJ/WTrCtcTNKo2S/Em692qMsXOJgLSanmFNTD6Ic8VsqOF5gWp0Zippfak0F8BnyHyD6Lp+NU3GqrtPiQr3aKsw8ZIyilcE245y2jdDrelvQdV4kUp7ltqDhLn3C4Ne4KHqJh/3PfqRmHzQGFVhpVrqoB/NEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873674; c=relaxed/simple;
	bh=bqLD3tjF3cL5EuZmq9uiOLaB1zZv48E4vPXoo12cUto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VeIDi7CabhM4ud5tOUXW5GDzjQPEWzXnzmJi0ZNqd7mUOYimpQg8iZMRrC/x8RcfJsMo+TwnDCX+8ppRj23/z7O6qQ+nC2So9kqOyyen9qcbwPmzYijYY4IRGFTMVLlBB/tFtgc9GjDJwJjwQmD6J7sofH9OCB5s32tTS7SQzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 11E0CA025B;
	Wed, 14 Feb 2024 02:21:04 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lKDa1_1_BEH5; Wed, 14 Feb 2024 02:21:03 +0100 (CET)
Received: from begin (aamiens-653-1-111-57.w83-192.abo.wanadoo.fr [83.192.234.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 504D0A019F;
	Wed, 14 Feb 2024 02:21:03 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ra3xO-00000008bfE-36y2;
	Wed, 14 Feb 2024 02:21:02 +0100
Date: Wed, 14 Feb 2024 02:21:02 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
	edumazet@google.com, gnault@redhat.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv5] PPPoL2TP: Add more code snippets
Message-ID: <20240214012102.dsdgcdgvwgfabzdi@begin>
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

Difference from v3:
- fix some variables references
- explicit inputs of the code snippets
- explicit that bridging is supported for l2tp with PPP pseudowire type.
- explicit that after bridging only the pppox sockets need to be kept
- explicit that bridging can also be done with other types of ppp
  channels

Difference from v4:
- Fix coding style
- Fix parameter of PPPIOCCONNECT ioctl.
- Describe the ppp frame bridging.

---
 Documentation/networking/l2tp.rst |  133 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 6 deletions(-)

--- a/Documentation/networking/l2tp.rst
+++ b/Documentation/networking/l2tp.rst
@@ -386,12 +386,19 @@ Sample userspace code:
 
   - Create session PPPoX data socket::
 
+        /* Input: the L2TP tunnel UDP socket `tunnel_fd`, which needs to be
+         * bound already (both sockname and peername), otherwise it will not be
+         * ready.
+         */
+
         struct sockaddr_pppol2tp sax;
-        int fd;
+        int session_fd;
+        int ret;
+
+        session_fd = socket(AF_PPPOX, SOCK_DGRAM, PX_PROTO_OL2TP);
+        if (session_fd < 0)
+                return -errno;
 
-        /* Note, the tunnel socket must be bound already, else it
-         * will not be ready
-         */
         sax.sa_family = AF_PPPOX;
         sax.sa_protocol = PX_PROTO_OL2TP;
         sax.pppol2tp.fd = tunnel_fd;
@@ -406,12 +413,126 @@ Sample userspace code:
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
+        /* Input: the session PPPoX data socket `session_fd` which was created
+         * as described above.
+         */
+
+        int ppp_chan_fd;
+        int chindx;
+        int ret;
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
                 return -errno;
         }
+
+        return ppp_chan_fd;
+
+LCP PPP frames will be available for read on `ppp_chan_fd`.
+
+  - Create PPP interface::
+
+        /* Input: the PPP channel `ppp_chan_fd` which was created as described
+         * above.
+         */
+
+        int ifunit = -1;
+        int ppp_if_fd;
+        int ret;
+
+        ppp_if_fd = open("/dev/ppp", O_RDWR);
+        if (ppp_if_fd < 0)
+                return -errno;
+
+        ret = ioctl(ppp_if_fd, PPPIOCNEWUNIT, &ifunit);
+        if (ret < 0) {
+                close(ppp_if_fd);
+                return -errno;
+        }
+
+        ret = ioctl(ppp_chan_fd, PPPIOCCONNECT, &ifunit);
+        if (ret < 0) {
+                close(ppp_if_fd);
+                return -errno;
+        }
+
+        return ppp_if_fd;
+
+IPCP/IPv6CP PPP frames will be available for read on `ppp_if_fd`.
+
+The ppp<ifunit> interface can then be configured as usual with netlink's
+RTM_NEWLINK, RTM_NEWADDR, RTM_NEWROUTE, or ioctl's SIOCSIFMTU, SIOCSIFADDR,
+SIOCSIFDSTADDR, SIOCSIFNETMASK, SIOCSIFFLAGS, or with the `ip` command.
+
+  - Bridging L2TP sessions which have PPP pseudowire types (this is also called
+    L2TP tunnel switching or L2TP multihop) is supported by bridging the PPP
+    channels of the two L2TP sessions to be bridged::
+
+        /* Input: the session PPPoX data sockets `session_fd1` and `session_fd2`
+         * which were created as described further above.
+         */
+
+        int ppp_chan_fd;
+        int chindx1;
+        int chindx2;
+        int ret;
+
+        ret = ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
+        if (ret < 0)
+                return -errno;
+
+        ret = ioctl(session_fd2, PPPIOCGCHAN, &chindx2);
+        if (ret < 0)
+                return -errno;
+
+        ppp_chan_fd = open("/dev/ppp", O_RDWR);
+        if (ppp_chan_fd < 0)
+                return -errno;
+
+        ret = ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
+        if (ret < 0) {
+                close(ppp_chan_fd);
+                return -errno;
+        }
+
+        ret = ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
+        close(ppp_chan_fd);
+        if (ret < 0)
+                return -errno;
+
         return 0;
 
+It can be noted that when bridging PPP channels, the PPP session is not locally terminated, and no local PPP interface is created.  PPP frames arriving on one channel are directly passed to the other channel, and vice versa.
+
+The PPP channel does not need to be kept open.  Only the session PPPoX data
+sockets need to be kept open.
+
+More generally, it is also possible in the same way to e.g. bridge a PPPoL2TP
+PPP channel with other types of PPP channels, such as PPPoE.
+
+See more details for the PPP side in ppp_generic.rst.
+
 Old L2TPv2-only API
 -------------------
 

