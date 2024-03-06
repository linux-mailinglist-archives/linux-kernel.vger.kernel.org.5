Return-Path: <linux-kernel+bounces-93847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67068873595
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08F28728E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE5D7F7F8;
	Wed,  6 Mar 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="IMglP+Az"
Received: from outgoing1.flk.host-h.net (outgoing1.flk.host-h.net [188.40.0.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABA5FDB1;
	Wed,  6 Mar 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724499; cv=none; b=ucDjHNfjPBXuAMZOMlG9wZk2iP0BuKvqtqDNjCz+itgLWBrtJa1gEayLLQp1t5jq1Le5UZRe2zZOEPUPx7Jg79ahmF4066A1fdYWnAj6xEnhFBwYzOhfpPEzl9OdTjEq/82QwGcNs5GF/XeabwunAwNJKq1VFuLqan4hDykOhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724499; c=relaxed/simple;
	bh=qOxw6drcIJfHDzCp2HpmVZyrdkcdpvEnY/jp+2DnwyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+oAvguX6sMcNlyl/542wJDvh2NedRsn8Y0xizXugLdPNyZMh9b7Hx06LaBK7jWGbXSy/+paoDs6AefH5Odn04NmK6Sm+hWIPpaq++K8Rkr2G9+VNv8QkuYubOXD5sSmya2cNdWejsP4krnnp9w1tCXzflJW26w9P+BgrUa2agQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=IMglP+Az; arc=none smtp.client-ip=188.40.0.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc
	:content-type; bh=QX5O6bEJujg104O2+dobjhvnkWUNnNqoK2mKLqkQID4=; b=IMglP+Az3fj
	jBSh5lzkQQGJeUlKoZ5BTeFk++/ahRizcGAiJW2K/e9lbC7b3Fegkixdp3nqKK8QL8a1hNjM1LlLq
	ocQ1S2CCN3eq8Wm57ogBgFXcMSQZkDrM53SoyJ9DSEMzLLUN8wZBINwUuU8k7hlPpAArhJhVTg3lC
	tbtU94lq09P8SG1R+u0T1GXlKXoiGfyRYzqwT8s9ljZzDeUoOCAxs881TQOoZrQMU3TrZu7iFw/oK
	Ji8WuddkF93s6PzhljiTO7H8ZktLAO68GHY1zDOn1oH4oeOu4bcCOuQNp9xOofvLrmEqI3shctMia
	nRVuX58ttA/dfhOos+P8VWQ==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam3-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhpRG-00D1yl-0k; Wed, 06 Mar 2024 13:28:08 +0200
Received: from [41.144.0.96] (helo=localhost.localdomain)
	by www31.flk1.host-h.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rhpRE-0007Ve-8U; Wed, 06 Mar 2024 13:27:56 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Martin Schiller <ms@dev.tdt.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: x25: remove dead links from Kconfig
Date: Wed,  6 Mar 2024 13:26:59 +0200
Message-Id: <20240306112659.25375-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20240305193024.6bcfa98f@kernel.org>
References: <20240305193024.6bcfa98f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+1Xyj7RFlVodHdpUUkulxsPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w1OL79HMxE022P+rQy8YAdcSeERs4TOTnIH1kc1IWc5QvZ
 FNshWKOptDHV4rDuRrwD+zBJgS5HrOaXNfwbIcOpslpzQZPofqiTKbbOumrM1Ahcg0OQCe1UFSTL
 VX1PEI9kcFJ7mC+M3fkSvxOXcnIOjhh9biKiQoANZ/M+dhYIXxdYA5DCYv6MMCKeadXRzZkEvAAo
 NnFXprYbAz6gPUYKNm1gRFF2i3O7cygKtabI1caTYyXVRVReaTKIqXapBXQ6SEDiG08q6BgvyDW7
 3UBJk4145zaNGRdZhgkYldKBwo37lJC8G4ef8lY22yNyhLy8ZNBDpxcCl9WvEtu4BGz6+JKO/vS7
 EG2gDc+C8niViTuAVoxNXxfObDHTY9R9kOMB03AEjHq2zzYAxIiW6tWKEwBJ0Y5r/Ifw7gpxllqW
 qh1hAHI3nwCbzMT4k0hu17rkR2VEZyK4VXrfqC5ENAfcWEKt0SZ8melITUergkwVPYHrfa8GVwpl
 6YSPTJ8WKUKinFA3k5Tcj/1EShAL4PF2W+n8Hj6CJNEWfIqe3AMrex08L8pZyQFEYMQabfOl4Iov
 Pg1PsShbZub3egBhMSkddtGkzDoCDN7V/f3066scTAKJY9yeQo6mFj+oBoJpRlWX4vjTQlD7O6wn
 npQLJZtbVa3xvGXfp826J8a7DErOLhdzJn/v5xKkWSd0caeqJ/t2+3veilCAGrFXkXD4oI+vIK/1
 NH5THMtlYvyHAYGOGpsHxDkFVDWJ1kN9NA6enCQxN+y/AP7Hwkn5qe9DeggJMKBj3vp74dfVTxFt
 5O5oiyLWM/ONOO3o7I7qeta3MwIt1wTxeW5J+eu/5uYi9cxKzXK7YBu7usJ10X4+nRkO3HYOP+pS
 yxpciHfO4+QS8IwE7z4kCK74eEzERj8DODlNdNTe/+4bG5GHvx8kXQZ6KkM6Oo8fr3pIQE+Tur0x
 NxCuL8HoZUszBrq3huV3gkB+ALLd1kk/nKAaSrwOm55G9lHeRkIRCAe1wI3mSezkL0Odgl2TNyIR
 4pSaiLxpHpeYfKG7Yu4jBlczMx1L5jSK60OT80m7/tzraDBlV1d5K5bY3LlRuQAi2Cph2PK+Rfkf
 SFXnDC0qBXDCRyMmNkwa//frYBrnXOB0PHbQD6cgMnC5M1rshWxsw1/gXTMtnmqhmzF4KZUIm82X
 davERDHbcD5xFI4Tc4UvrRQcxVnmH7g=
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

Remove the "You can read more about X.25 at" links provided in
Kconfig as they have not pointed at any relevant pages for quite
a while.

An old copy of https://www.sangoma.com/tutorials/x25/ can be
retrieved via https://archive.org/web/ but nothing useful seems
to have been preserved for http://docwiki.cisco.com/wiki/X.25

For the sake of necromancy and those who really did want to
read more about X.25, a previous incarnation of Kconfig included
a link to:
http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm

Which can still be read at:
https://web.archive.org/web/20071013101232/http://cisco.com/en/US/docs/ios/11_0/router/configuration/guide/cx25.html

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 net/x25/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/x25/Kconfig b/net/x25/Kconfig
index 68729aa3a..dc72302cb 100644
--- a/net/x25/Kconfig
+++ b/net/x25/Kconfig
@@ -17,8 +17,6 @@ config X25
 	  if you want that) and the lower level data link layer protocol LAPB
 	  (say Y to "LAPB Data Link Driver" below if you want that).
 
-	  You can read more about X.25 at <https://www.sangoma.com/tutorials/x25/> and
-	  <http://docwiki.cisco.com/wiki/X.25>.
 	  Information about X.25 for Linux is contained in the files
 	  <file:Documentation/networking/x25.rst> and
 	  <file:Documentation/networking/x25-iface.rst>.
-- 
2.30.2


