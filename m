Return-Path: <linux-kernel+bounces-71429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9A85A51C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDAA1F24747
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B341374D4;
	Mon, 19 Feb 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="ggz4Rure"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AF364AE;
	Mon, 19 Feb 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350526; cv=none; b=C1cQ5x+CrWON8IddHsVOaquo4PpNzpHwTZ3KlpVu4rUZpCkqMrpIZS0av1DDdaWHw5LU/k+khlBqz+x0IMYqqBowgR15hWLYkSEi3x4Oh6uA18g5s+Cg2tbFyuskYZi3HKi1THzaYwZPXXeqayQ7qbBoIwYCY7OhIbOQE6BJVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350526; c=relaxed/simple;
	bh=7zlMxKEMlRi2fMVorHFpbWy+YlGO3wP3+8xPvDrFk8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+cYKjA/LfslPXJvHfXEGADLoicuBBw+Ck4EE5+GWx7GZLLhbeJz61Ift8gtncjg0isJeDcvUhR0rFdd2KECbcL3tvdc0pr11j1yHpHPh1NOtSK59IgA+j69twEzMKWCfyd61CCw/Vj2+QNsvLbzT0pmkzy32aB7TXgGrXXHXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=ggz4Rure; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id A5DC5200EEA4;
	Mon, 19 Feb 2024 14:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be A5DC5200EEA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350522;
	bh=GdqClNP24oSb21PimU1rdj3YpRVP83hpGrMM7xmTrzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggz4RureEh/YkPtO/UgNnA85l5PSDSFI4GCySRPve79xvotTO0VtUv91O1y/rIl0M
	 JfrGMa8bKBCyrUXx0O3N+SQKTTQg44XUANCrv+rd+5wyWEEndtp+dFSaOh3qBdQj1c
	 8R+IQ9fs7Ix/2qm92tdINAPId+4xrvTxuXobo6dkZCGFDZQB68BfoymT2QEKxoTFFs
	 551NEGS3nVQvF8Zvy8pgLwjrmRvxHBFE1P7BYE0gsZ5GVVexLN4WVSAJ3N7wXab3C5
	 RS99THbSU6yngNDWNu2wvji6CcomSTP48iR/lfaZJLu449dymnjnsxae42yRsP1UgZ
	 4wsZXAHIjSntA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH 2/2] selftests: ioam: refactoring to align with the fix
Date: Mon, 19 Feb 2024 14:48:21 +0100
Message-Id: <20240219134821.14009-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219134821.14009-1-justin.iurman@uliege.be>
References: <20240219134821.14009-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioam6_parser uses a packet socket. After the fix to prevent writing to
cloned skb's, the receiver does not see its IOAM data anymore, which
makes input/forward ioam-selftests to fail. As a workaround,
ioam6_parser now uses an IPv6 raw socket and leverages ancillary data to
get hop-by-hop options. As a consequence, the hook is "after" the IOAM
data insertion by the receiver and all tests are working again.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 tools/testing/selftests/net/ioam6.sh       | 38 ++++-----
 tools/testing/selftests/net/ioam6_parser.c | 95 +++++++++++-----------
 2 files changed, 66 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index fe59ca3e5596..12491850ae98 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -367,14 +367,12 @@ run_test()
   local desc=$2
   local node_src=$3
   local node_dst=$4
-  local ip6_src=$5
-  local ip6_dst=$6
-  local if_dst=$7
-  local trace_type=$8
-  local ioam_ns=$9
-
-  ip netns exec $node_dst ./ioam6_parser $if_dst $name $ip6_src $ip6_dst \
-         $trace_type $ioam_ns &
+  local ip6_dst=$5
+  local trace_type=$6
+  local ioam_ns=$7
+  local type=$8
+
+  ip netns exec $node_dst ./ioam6_parser $name $trace_type $ioam_ns $type &
   local spid=$!
   sleep 0.1
 
@@ -489,7 +487,7 @@ out_undef_ns()
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0x800000 0
+         db01::1 0x800000 0 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -509,7 +507,7 @@ out_no_room()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -543,14 +541,14 @@ out_bits()
       if [ $cmd_res != 0 ]
       then
         npassed=$((npassed+1))
-        log_test_passed "$descr"
+        log_test_passed "$descr ($1 mode)"
       else
         nfailed=$((nfailed+1))
-        log_test_failed "$descr"
+        log_test_failed "$descr ($1 mode)"
       fi
     else
 	run_test "out_bit$i" "$descr ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
     fi
   done
 
@@ -574,7 +572,7 @@ out_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 100 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xfff002 123
+         db01::1 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -604,7 +602,7 @@ in_undef_ns()
          trace prealloc type 0x800000 ns 0 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0x800000 0
+         db01::1 0x800000 0 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -624,7 +622,7 @@ in_no_room()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -651,7 +649,7 @@ in_bits()
            dev veth0
 
     run_test "in_bit$i" "${desc/<n>/$i} ($1 mode)" $ioam_node_alpha \
-           $ioam_node_beta db01::2 db01::1 veth0 ${bit2type[$i]} 123
+           $ioam_node_beta db01::1 ${bit2type[$i]} 123 $1
   done
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
@@ -679,7 +677,7 @@ in_oflag()
          trace prealloc type 0xc00000 ns 123 size 4 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xc00000 123
+         db01::1 0xc00000 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 
@@ -703,7 +701,7 @@ in_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 80 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_beta \
-         db01::2 db01::1 veth0 0xfff002 123
+         db01::1 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_beta link set ip6tnl0 down
 }
@@ -731,7 +729,7 @@ fwd_full_supp_trace()
          trace prealloc type 0xfff002 ns 123 size 244 via db01::1 dev veth0
 
   run_test ${FUNCNAME[0]} "${desc} ($1 mode)" $ioam_node_alpha $ioam_node_gamma \
-         db01::2 db02::2 veth0 0xfff002 123
+         db02::2 0xfff002 123 $1
 
   [ "$1" = "encap" ] && ip -netns $ioam_node_gamma link set ip6tnl0 down
 }
diff --git a/tools/testing/selftests/net/ioam6_parser.c b/tools/testing/selftests/net/ioam6_parser.c
index d9d1d4190126..895e5bb5044b 100644
--- a/tools/testing/selftests/net/ioam6_parser.c
+++ b/tools/testing/selftests/net/ioam6_parser.c
@@ -8,7 +8,6 @@
 #include <errno.h>
 #include <limits.h>
 #include <linux/const.h>
-#include <linux/if_ether.h>
 #include <linux/ioam6.h>
 #include <linux/ipv6.h>
 #include <stdlib.h>
@@ -512,14 +511,6 @@ static int str2id(const char *tname)
 	return -1;
 }
 
-static int ipv6_addr_equal(const struct in6_addr *a1, const struct in6_addr *a2)
-{
-	return ((a1->s6_addr32[0] ^ a2->s6_addr32[0]) |
-		(a1->s6_addr32[1] ^ a2->s6_addr32[1]) |
-		(a1->s6_addr32[2] ^ a2->s6_addr32[2]) |
-		(a1->s6_addr32[3] ^ a2->s6_addr32[3])) == 0;
-}
-
 static int get_u32(__u32 *val, const char *arg, int base)
 {
 	unsigned long res;
@@ -603,70 +594,80 @@ static int (*func[__TEST_MAX])(int, struct ioam6_trace_hdr *, __u32, __u16) = {
 
 int main(int argc, char **argv)
 {
-	int fd, size, hoplen, tid, ret = 1;
-	struct in6_addr src, dst;
+	int fd, size, hoplen, tid, ret = 1, on = 1;
 	struct ioam6_hdr *opt;
-	struct ipv6hdr *ip6h;
-	__u8 buffer[400], *p;
-	__u16 ioam_ns;
+	struct cmsghdr *cmsg;
+	struct msghdr msg;
+	struct iovec iov;
+	__u8 buffer[512];
 	__u32 tr_type;
+	__u16 ioam_ns;
+	__u8 *ptr;
 
-	if (argc != 7)
+	if (argc != 5)
 		goto out;
 
-	tid = str2id(argv[2]);
+	tid = str2id(argv[1]);
 	if (tid < 0 || !func[tid])
 		goto out;
 
-	if (inet_pton(AF_INET6, argv[3], &src) != 1 ||
-	    inet_pton(AF_INET6, argv[4], &dst) != 1)
+	if (get_u32(&tr_type, argv[2], 16) ||
+	    get_u16(&ioam_ns, argv[3], 0))
 		goto out;
 
-	if (get_u32(&tr_type, argv[5], 16) ||
-	    get_u16(&ioam_ns, argv[6], 0))
+	fd = socket(PF_INET6, SOCK_RAW,
+		    !strcmp(argv[4], "encap") ? IPPROTO_IPV6 : IPPROTO_ICMPV6);
+	if (fd < 0)
 		goto out;
 
-	fd = socket(AF_PACKET, SOCK_DGRAM, __cpu_to_be16(ETH_P_IPV6));
-	if (!fd)
-		goto out;
+	setsockopt(fd, IPPROTO_IPV6, IPV6_RECVHOPOPTS,  &on, sizeof(on));
 
-	if (setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE,
-		       argv[1], strlen(argv[1])))
+	iov.iov_len = 1;
+	iov.iov_base = malloc(CMSG_SPACE(sizeof(buffer)));
+	if (!iov.iov_base)
 		goto close;
-
 recv:
-	size = recv(fd, buffer, sizeof(buffer), 0);
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = buffer;
+	msg.msg_controllen = CMSG_SPACE(sizeof(buffer));
+
+	size = recvmsg(fd, &msg, 0);
 	if (size <= 0)
 		goto close;
 
-	ip6h = (struct ipv6hdr *)buffer;
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != IPPROTO_IPV6 ||
+		    cmsg->cmsg_type != IPV6_HOPOPTS ||
+		    cmsg->cmsg_len < sizeof(struct ipv6_hopopt_hdr))
+			continue;
 
-	if (!ipv6_addr_equal(&ip6h->saddr, &src) ||
-	    !ipv6_addr_equal(&ip6h->daddr, &dst))
-		goto recv;
+		ptr = (__u8 *)CMSG_DATA(cmsg);
 
-	if (ip6h->nexthdr != IPPROTO_HOPOPTS)
-		goto close;
+		hoplen = (ptr[1] + 1) << 3;
+		ptr += sizeof(struct ipv6_hopopt_hdr);
 
-	p = buffer + sizeof(*ip6h);
-	hoplen = (p[1] + 1) << 3;
-	p += sizeof(struct ipv6_hopopt_hdr);
+		while (hoplen > 0) {
+			opt = (struct ioam6_hdr *)ptr;
 
-	while (hoplen > 0) {
-		opt = (struct ioam6_hdr *)p;
+			if (opt->opt_type == IPV6_TLV_IOAM &&
+			    opt->type == IOAM6_TYPE_PREALLOC) {
+				ptr += sizeof(*opt);
+				ret = func[tid](tid,
+						(struct ioam6_trace_hdr *)ptr,
+						tr_type, ioam_ns);
+				goto close;
+			}
 
-		if (opt->opt_type == IPV6_TLV_IOAM &&
-		    opt->type == IOAM6_TYPE_PREALLOC) {
-			p += sizeof(*opt);
-			ret = func[tid](tid, (struct ioam6_trace_hdr *)p,
-					   tr_type, ioam_ns);
-			break;
+			ptr += opt->opt_len + 2;
+			hoplen -= opt->opt_len + 2;
 		}
-
-		p += opt->opt_len + 2;
-		hoplen -= opt->opt_len + 2;
 	}
+
+	goto recv;
 close:
+	free(iov.iov_base);
 	close(fd);
 out:
 	return ret;
-- 
2.34.1


