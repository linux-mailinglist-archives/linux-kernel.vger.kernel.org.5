Return-Path: <linux-kernel+bounces-89617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28986F31B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6241C21336
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096353E39;
	Sat,  2 Mar 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8WsILe/"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E981EB3F;
	Sat,  2 Mar 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709421588; cv=none; b=AzFRuI2MVDY/WYVv50KfZJuDI/YVfKSP3izAaKA1jIsCnweDiUlo6nntlIImqv6zLfkHPtRsCqRnQgCAmPoX0m8lwrYuYllQ0PhsUlodaYf/DVElPI9hZsCIlzg+Q+zTr435/joFZT3eJqu1P5UGNAo1yFdpvZSspfMoAeKPyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709421588; c=relaxed/simple;
	bh=vPP3p9GGRRGZegKNSobm2wNf5DV/YCF3ypsLBCmSIdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oD3U0fWO6G1+sYnaKxQUxROftZk7qo1jCsVgCQS9vzmiUlMwK+1w0VCuu3Mc/gsdn5wAtF0bLr3PcVPcMtoje3opjt2hCttQ94zUQMwm2XBajVS005p5uDms4Ol1pbuepRtkcQ49WG4kvQDbsxF/Z/tYQDqG2VTZ8jI2rkYGm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8WsILe/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e78c39ff0so39808111cf.0;
        Sat, 02 Mar 2024 15:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709421586; x=1710026386; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yl9YhJ9Pat9I4841GAOwQcUbovZDN591i7vJgihLH04=;
        b=J8WsILe/c0lxtcCKQQ/0R2OH3stc/HlsnH+PpbuTa3bzXSbYECsURyZ9OYW12x193e
         f0uR1c0q4NgkE0SrCDCWa9kKZLTvsiHVmkQ+n611oGCbAH0aQ3LRV/zVP0AzugW93MsE
         ybDVfU0BNnB2XZJUrzQhnZgWI5PmOmXMM3qy5w8OEPYFPIpZKt/wgssVnsUBi79mTi8r
         MZo0SiwfIu7C9HdwrQlV5LJRr8abFTPQnKabX3CwZC2bGoZpCozPzWahQLmirNGDtUkD
         97u2n6cqunBELdpH8ZaIgXuGI0h8wWxcxN2orgxPfu2CoDtZiLj9Lm6f8RPQ/hgz0Sas
         GNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709421586; x=1710026386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl9YhJ9Pat9I4841GAOwQcUbovZDN591i7vJgihLH04=;
        b=j6I6xnSKVPZNL29TptI0XvNw2fTmKReDia9KZLcO7xIXpNuWdcdQL1QimqiVicreWf
         MVC81wgHR1OBuofdmKMeHAZXqts7yJrhQ5WjT2mZkkm+H4dknm0YEnU12sTx9eL37ZgX
         DZJSbD4zPai9CdcfwftAKG6RzVdwSxTObZAf2/2uLtQRw+XpMKEVu1A9S8hFgQRXiQTY
         JTW3bCpph4I4DwysjPipOm53c/YNzdMK/ERfSHNMUdzMZlwpMyvPDtfChOBoxwKYSlim
         iMha+KEDtPCFy8Q+4YsCT8W8nHT8bMH8/KrR2F0felmzZVkMEGX5NBpJkW7Aryx28AE5
         UD2A==
X-Forwarded-Encrypted: i=1; AJvYcCX4rvRFQ2It8hC7Y4NzpLyGG7Gy9hvC+VK3O8pEX+yieGQ7tonRZI14MsxkNVx76Qdt/bLhVJuzZ+CyeT7Uu8FxzjEUHF9RxFAdd3wBh2Hdmto2YoRQUWMl7sCNZsqNBFfu
X-Gm-Message-State: AOJu0YwkOdO9kqhP1a9R8hRiQLrHMHhmNjePFLGjAFJVfoyT7UrT+KdC
	KNjtzYla7hI94F9+HDVHoE4jLQV3hxrJfMGHj8LK2JFNw3auySN9wmOYPAT7
X-Google-Smtp-Source: AGHT+IF2R0RJsIJvVpl1bvm8wghq1conzqkpFu40cOsz9Pou4iTg2Ord2Jc4YemBxx9LHR+Lm28KYA==
X-Received: by 2002:ac8:5a41:0:b0:42e:ca55:e89a with SMTP id o1-20020ac85a41000000b0042eca55e89amr8281122qta.34.1709421585966;
        Sat, 02 Mar 2024 15:19:45 -0800 (PST)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id nw5-20020a0562143a0500b0068f2d2f64d1sm3422697qvb.32.2024.03.02.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:19:45 -0800 (PST)
Date: Sat, 2 Mar 2024 13:19:42 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: alx@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It was not made clear in several socket options that they were not
supported by SOCK_STREAM; this patch fixes that.

Socket options not supported by SOCK_STREAM are handled in the
ip_cmsg_recv_offset function in net/ipv4/ip_sockglue.c. The function is
called for udp sockets, and indirectly by ping and raw sockets, but not
for TCP sockets, as they don't support these options.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 man7/ip.7 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/man7/ip.7 b/man7/ip.7
index 2b4b06324..104e65feb 100644
--- a/man7/ip.7
+++ b/man7/ip.7
@@ -828,6 +828,9 @@ is not zero, the primary local address of the interface specified by the
 index overwrites
 .I ipi_spec_dst
 for the routing table lookup.
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVERR " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.15
@@ -989,6 +992,9 @@ in which the kernel returns the original destination address
 of the datagram being received.
 The ancillary message contains a
 .IR "struct sockaddr_in" .
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVTOS " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
@@ -998,6 +1004,9 @@ ancillary message is passed with incoming packets.
 It contains a byte which specifies the Type of Service/Precedence
 field of the packet header.
 Expects a boolean integer flag.
+Not supported for
+.B SOCK_STREAM
+sockets.
 .TP
 .BR IP_RECVTTL " (since Linux 2.2)"
 .\" Precisely: since Linux 2.1.68
-- 
2.44.0


