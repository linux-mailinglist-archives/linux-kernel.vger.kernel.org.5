Return-Path: <linux-kernel+bounces-110022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DDD8858FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA9F1F2277B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C3768F7;
	Thu, 21 Mar 2024 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b="a1LXpSUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9ORNhDb"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82196762F3;
	Thu, 21 Mar 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023694; cv=none; b=NJTLEp5XC/9Qf7A5r+Dt/+o2BBWWDxIsj9vA1rqphncTDokmA8YDEmEFwTbiAlBzhq0ei4wSfkBLtVkMFp9fzeabgqlooj331okjfClHmDI+lRLF77bgQNEWqpWt4MSXowgpCnzFl8ZFdC6BRJefJwsSMNDJw9NkajpxmF19pPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023694; c=relaxed/simple;
	bh=h0OCYhTLwuSwPnc4GUkrDtFpzmlCkF3n8K6eXs2ulvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgjAqWq5x4XiNFC8pUjuVPI338KxxoeEIWeQDw1d4aPI2hakoYc+YUErC0HFHfc6DQrFMjFeM0VeAxDk/b+IkSXN2QzhyYqR4vP6QCsm+Oij3dUEBPp/b52xetZ/rqlVblDXcshsiSllD5RYVcSantYk3owKaf6cHaNR4gfaV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl; spf=pass smtp.mailfrom=yotsuba.nl; dkim=pass (2048-bit key) header.d=yotsuba.nl header.i=@yotsuba.nl header.b=a1LXpSUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9ORNhDb; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yotsuba.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yotsuba.nl
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 633951380147;
	Thu, 21 Mar 2024 08:21:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 08:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711023691; x=
	1711110091; bh=W9wJZQJR63Wvk/JDbjxC6995wg9TQBOr281LOEXEo7w=; b=a
	1LXpSUCdbfC3JZbq2LxJaNrdOnmcwGXM3cuUZk/w5d5jonJ3IZg+sl3SsSzKZXas
	W7WWVG1mDL9lbJ4Ozq6LQ0BLmHObJY7v2t0/LDqpHcFF55rWmkgf2SlZw9XJ135d
	D3F+jdEB03csO8pVBW+GOf32nnIJKcMQX20SmVX/latDMl/jDisZbqLM3Spm/U3s
	Gb+ugjfW1wY7+dzZtq8UWkjCMtQR1cfqyWTVotQbMGAwRD3RTsMWVtlRs6LwJs0m
	yLqUKqpK51bMG6DwcMB3SdzPBhFPla3GK3owft/eurVOpOKnW9AWjwHiiZo9s11c
	nSZX2CkXRLQfz8dIDUo1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711023691; x=
	1711110091; bh=W9wJZQJR63Wvk/JDbjxC6995wg9TQBOr281LOEXEo7w=; b=k
	9ORNhDbuzqeRIUjjb1hevH7JcSKpa5jn1oMxYsXXBemKjBokugpDpWNHj5FHG9F8
	ciezCVeh1mO019diLL1CzlAE2+p3kOCSJRLc0DQcwiGB/8tEKkaU0Q/yeMJobJW5
	L8N3UPpjaTJCH873581GWH15gZk61Ki315kCqbsN4AK2VsHHk92eGxJIJqmKKk3B
	WcAdc7obJ3IqxjMndFjPpuqN1uW7PMifTumCedhHKATKUDnSC72gxSzMiRW3gM7a
	cFG//7fnB1tIu+AJA8uYK0Gsh+HGUbbFcJ2765vXfQ/lbPkyGLsqFBMc93N0BuD5
	i4pzxPqLN9HvqpvAabcbw==
X-ME-Sender: <xms:Syb8ZaqYoi7d8graOOGdPJfbfvy64x9O3-bjh61iqa-CCDKb9nTGDA>
    <xme:Syb8ZYrYEWG178OhmSVJhewoCX_MRmSx5843vkFmF7MoaukAgTDCI8kn_K-4pUmN2
    kLMDTESgERO3ysu2Mc>
X-ME-Received: <xmr:Syb8ZfOGvZ-shQlV1vIjKtvUkG4dnAo4zUyGMA1RYVJbCUBVoYXIpc7YlV-ed2ReKTsgN_97nCLH4GWTIXbXcXbz6J8TxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcu
    vehilhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvg
    hrnhepueejkeffteeiueeiveevtdeftefgffdtfedtheeikeeukeegffeukeduhfeiveef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrh
    hkseihohhtshhusggrrdhnlh
X-ME-Proxy: <xmx:Syb8ZZ4z2LH02lCGF1PSuHKK7cw0UABcVl1EiMNBEAnPUZX8B72aqQ>
    <xmx:Syb8ZZ6yWc3URVZgjHOGxYEi5csCjkZvbLIjCivRKtuVYzfpH0SDhg>
    <xmx:Syb8ZZidOTTjteDzQqA7ywRtmAQU3x8MqCwacYx3H2w-9jNVvyrl7A>
    <xmx:Syb8ZT473IoExhxpQYdshSJw609dsGqm88OabUMQZqmRDsaAvw36GA>
    <xmx:Syb8ZRyHJblIAOxhOpmdFIDJyGEzvegSU7bKEhLfxq9slbStrFVHcA>
Feedback-ID: i85e1472c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:21:30 -0400 (EDT)
From: Mark Cilissen <mark@yotsuba.nl>
To: netdev@vger.kernel.org
Cc: Mark Cilissen <mark@yotsuba.nl>,
	Jakub Kicinski <kuba@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v2 2/2] selftests: add netpoll selftest
Date: Thu, 21 Mar 2024 13:20:01 +0100
Message-ID: <20240321122003.20089-2-mark@yotsuba.nl>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321122003.20089-1-mark@yotsuba.nl>
References: <20240321122003.20089-1-mark@yotsuba.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that netpoll supports more kinds of network interfaces it benefits
extra from being tested to monitor regressions. This test runs entirely in
userspace, adding a netconsole for the interface-under-test using configfs
and sending a kernel log message that is verified using socat.

To cover a mix of circumstances while keeping host tooling dependences
fairly minimal, the following interface scenarios are tested:
- Ethernet link layer, IPv4 and IPv6 (veth)
- No exposed link layer, IPv4 (gre, ipip, ip6tnl)
- No exposed link layer, IPv6 (gre, sit, ip6tnl)

As a sanity check the test was run on kernel release 6.7.9-200.fc39,
which does not include the expanded netpoll interface support,
and yielded the expected failures:

  PASS: netconsole (eth/ipv4)
  PASS: netconsole (eth/ipv6)
  FAIL: netconsole (ipv4/gre/ipv4): message did not arrive in time (124)
  FAIL: netconsole (ipv4/gre/ipv6): message did not arrive in time (124)
  FAIL: netconsole (ipv6/ip6gre/ipv4): message did not arrive in time (124)
  FAIL: netconsole (ipv6/ip6gre/ipv6): message did not arrive in time (124)
  FAIL: netconsole (ipv4/ipip/ipv4): message did not arrive in time (124)
  FAIL: netconsole (ipv4/sit/ipv6): message did not arrive in time (124)
  FAIL: netconsole (ipv6/ip6tnl/ipv4): message did not arrive in time (124)
  FAIL: netconsole (ipv6/ip6tnl/ipv6): message did not arrive in time (124)

Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
---
 tools/testing/selftests/net/Makefile   |   1 +
 tools/testing/selftests/net/config     |   1 +
 tools/testing/selftests/net/netpoll.sh | 226 +++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100755 tools/testing/selftests/net/netpoll.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7b6918d5f4af..e9908a976f5e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -93,6 +93,7 @@ TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
+TEST_PROGS += netpoll.sh
 
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 5e4390cac17e..bc3b6991b1aa 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -100,3 +100,4 @@ CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
 CONFIG_XFRM_USER=m
+CONFIG_NETCONSOLE=m
diff --git a/tools/testing/selftests/net/netpoll.sh b/tools/testing/selftests/net/netpoll.sh
new file mode 100755
index 000000000000..ab4acd756ca1
--- /dev/null
+++ b/tools/testing/selftests/net/netpoll.sh
@@ -0,0 +1,226 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test netpoll and netconsole in various interface scenarios:
+# ethernet (veth), raw IPv4 (gre, ipip, ip6tnl), raw IPv6 (gre, sit, ip6tnl)
+#
+# +-----------------------------------------+
+# | $NS1                                    |
+# |              $H1 +---+ $T1              |
+# |     192.0.2.1/30 |     192.0.2.65/30    |
+# | 2001:db8:1::1/64 |     2001:db8:2::1/64 |
+# +------------------|----------------------+
+#                    |
+# +------------------|----------------------+
+# | $NS2             |                      |
+# |              $H2 +---+ $T2              |
+# |     192.0.2.2/30       192.0.2.66/30    |
+# | 2001:db8:1::2/64       2001:db8:2::2/64 |
+# +-----------------------------------------+
+# shellcheck disable=SC3043 # allow 'local' keyword
+set -e
+
+readonly ksft_skip=4
+readonly H1A4=192.0.2.1/30
+readonly H1A6=2001:db8:1::1/64
+readonly H2A4=192.0.2.2/30
+readonly H2A6=2001:db8:1::2/64
+readonly T1A4=192.0.2.65/30
+readonly T1A6=2001:db8:2::1/64
+readonly T2A4=192.0.2.66/30
+readonly T2A6=2001:db8:2::2/64
+
+# shellcheck disable=SC2155 # declare and assign separately
+readonly BASE="ksft-$(mktemp -u XXXXXX)"
+readonly NS1="$BASE-n1"
+readonly NS2="$BASE-n2"
+readonly H1="$BASE-h1"
+readonly H2="$BASE-h2"
+readonly T1="$BASE-i1"
+readonly T2="$BASE-i2"
+
+
+# Utilities
+
+setup() {
+	ip netns add "$NS1"
+	ip netns exec "$NS1" sysctl -wq net.ipv4.ip_forward=1
+	ip netns exec "$NS1" sysctl -wq net.ipv6.conf.all.forwarding=1
+	ip netns exec "$NS1" sysctl -wq net.ipv6.conf.default.forwarding=1
+
+	ip netns add "$NS2"
+	ip netns exec "$NS2" sysctl -wq net.ipv4.ip_forward=1
+	ip netns exec "$NS2" sysctl -wq net.ipv6.conf.all.forwarding=1
+	ip netns exec "$NS2" sysctl -wq net.ipv6.conf.default.forwarding=1
+
+	ip link add "$H1" type veth peer name "$H2"
+
+	ip link set dev "$H1" netns "$NS1"
+	ip -n "$NS1" link set dev "$H1" up
+	ip -n "$NS1" addr add "$H1A4" dev "$H1"
+	ip -n "$NS1" addr add "$H1A6" dev "$H1" nodad
+
+	ip link set dev "$H2" netns "$NS2"
+	ip -n "$NS2" link set dev "$H2" up
+	ip -n "$NS2" addr add "$H2A4" dev "$H2"
+	ip -n "$NS2" addr add "$H2A6" dev "$H2" nodad
+
+	grep -q '^netcon' /proc/consoles || modprobe netconsole
+}
+
+cleanup() {
+	set +e
+	for d in /sys/kernel/config/netconsole/"$BASE"*; do
+		[ -d "$d" ] || continue
+		rmdir "$d"
+	done
+	for ns in "$NS1" "$NS2"; do
+		if ip -n "$ns" link show >/dev/null 2>&1; then
+			ip netns del "$ns"
+		fi
+	done
+	# In case we exit before the veth got moved into its namespace
+	if [ -e /sys/class/net/"$H1" ]; then
+		ip link del dev "$H1"
+	fi
+}
+
+trap cleanup EXIT
+
+if ! command -v socat >/dev/null 2>&1; then
+	echo "SKIP: netconsole tests need socat"
+	exit $ksft_skip
+fi
+
+
+test_netconsole() {
+	local name="$1"; shift
+	local outif="$1"; shift
+	local outip="$1"; shift
+	local inif="$1"; shift
+	local inip="$1"; shift
+	local ret=0
+
+	local msg="kselftest/net/netpoll: netconsole test message for $name"
+	# Setup logger and background it, it will exit when it receives the message
+	timeout 3s ip netns exec "$NS2" socat -u -S 0 \
+		udp6-recv:6666,reuseaddr,so-bindtodevice="$inif",ipv6only=0 \
+		system:"grep -m 1 -q \'$(printf '%s' "$msg" | sed -e 's/:/\\:/g')\$\'" &
+	# Setup netconsole
+	ip netns exec "$NS1" sh -s <<EOF
+set -e
+mount -t configfs none /sys/kernel/config
+cd /sys/kernel/config/netconsole
+mkdir "$outif" && cd "$outif"
+echo "$outif" > dev_name
+echo "${outip%%/*}" > local_ip
+echo "${inip%%/*}" > remote_ip
+echo 6666 > remote_port
+echo 1 > enabled
+EOF
+
+	# Send message and wait for it to arrive or timeout
+	echo "<1>$msg" > /dev/kmsg
+	if wait %+; then
+		echo "PASS: netconsole ($name)"
+	else
+		ret=$?
+		echo "FAIL: netconsole ($name): message did not arrive in time ($err)"
+	fi
+	rmdir /sys/kernel/config/netconsole/"$outif"
+	return $ret
+}
+
+
+# Test starts here
+
+ret=0
+mark_failed() {
+	# Make sure failure isn't overwritten by skip
+	if [ "$ret" = 0 ] || [ "$ret" = $ksft_skip ]; then
+		ret="$1"
+	fi
+}
+
+setup
+
+# Test ethernet interfaces
+
+test_netconsole eth/ipv4 "$H1" "$H1A4" "$H2" "$H2A4" || mark_failed $?
+test_netconsole eth/ipv6 "$H1" "$H1A6" "$H2" "$H2A6" || mark_failed $?
+
+# Test tunnel interfaces
+
+setup_tunnel() {
+	local type="$1"; shift
+	local h1a="${1%%/*}"; shift
+	local h2a="${1%%/*}"; shift
+	local t1a="$1"; shift
+	local t2a="$1"; shift
+
+	ip -n "$NS1" link add "$T1" type "$type" local "$h1a" remote "$h2a" "$@" \
+		|| return $ksft_skip # Skip test if tunnel type is not available
+	ip -n "$NS1" addr add "$t1a" dev "$T1"
+	ip -n "$NS1" link set "$T1" up
+
+	ip -n "$NS2" link add "$T2" type "$type" local "$h2a" remote "$h1a" "$@" \
+		|| return $ksft_skip # Skip test if tunnel type is not available
+	ip -n "$NS2" addr add "$t2a" dev "$T2"
+	ip -n "$NS2" link set "$T2" up
+}
+
+teardown_tunnel() {
+	ip -n "$NS1" link del dev "$T1"
+	ip -n "$NS2" link del dev "$T2"
+}
+
+test_tunnel_4in4() {
+	local type="$1"; shift
+	local ret=0
+	setup_tunnel "$type" "$H1A4" "$H2A4" "$T1A4" "$T2A4" "$@"
+	test_netconsole "ipv4/$type/ipv4" "$T1" "$T1A4" "$T2" "$T2A4" || ret=$?
+	teardown_tunnel
+	return $ret
+}
+
+test_tunnel_4in6() {
+	local type="$1"; shift
+	local ret=0
+	setup_tunnel "$type" "$H1A6" "$H2A6" "$T1A4" "$T2A4" "$@"
+	test_netconsole "ipv6/$type/ipv4" "$T1" "$T1A4" "$T2" "$T2A4" || ret=$?
+	teardown_tunnel
+	return $ret
+}
+
+test_tunnel_6in4() {
+	local type="$1"; shift
+	local ret=0
+	setup_tunnel "$type" "$H1A4" "$H2A4" "$T1A6" "$T2A6" "$@"
+	test_netconsole "ipv4/$type/ipv6" "$T1" "$T1A6" "$T2" "$T2A6" || ret=$?
+	teardown_tunnel
+	return $ret
+}
+
+test_tunnel_6in6() {
+	local type="$1"; shift
+	local ret=0
+	setup_tunnel "$type" "$H1A6" "$H2A6" "$T1A6" "$T2A6" "$@"
+	test_netconsole "ipv6/$type/ipv6" "$T1" "$T1A6" "$T2" "$T2A6" || ret=$?
+	teardown_tunnel
+	return $ret
+}
+
+test_tunnel_4in4 gre    || mark_failed $?
+test_tunnel_6in4 gre    || mark_failed $?
+test_tunnel_4in6 ip6gre || mark_failed $?
+test_tunnel_6in6 ip6gre || mark_failed $?
+test_tunnel_4in4 ipip   || mark_failed $?
+test_tunnel_6in4 sit    || mark_failed $?
+test_tunnel_4in6 ip6tnl mode ipip6  || mark_failed $?
+test_tunnel_6in6 ip6tnl mode ip6ip6 || mark_failed $?
+
+
+# Test done
+
+cleanup
+exit "$ret"
-- 
2.44.0


