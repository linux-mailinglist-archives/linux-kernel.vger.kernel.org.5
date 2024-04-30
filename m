Return-Path: <linux-kernel+bounces-164181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BA8B7A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F91C2268C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE171176FC3;
	Tue, 30 Apr 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIHK3kjW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8115278D;
	Tue, 30 Apr 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487993; cv=none; b=i5ldPIQ6X0bSoEd5pJaUQ+RQ5mE7jYXtsN/SIwwR4zIpZxLImx0GD4KMDUZMU3teJNsE9L5BJ1qi8kILZQBMTrqC5yqM77IqRLeHkIJtkO/+t9lzHzyE2Iql75BSTcmxy1RQRjqckp3lLlOEoOBD/UfWM3abj8H3THVHqz3DA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487993; c=relaxed/simple;
	bh=KE2vEEEqA554ZgKHK7GBdCbKsPBwaTbJsb1ro1vix3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RM5ixRkrRAI8ovBPXkxYKpmkoH8jFXq4+1yV3WhRhVA4EV1wupMr3upz2fu/2AZW/EzNaxe6xKzE9bvhk5gTcA1ZkcP9nAlL4PDuxOVv9E3nWAfi/iICycTCMDRjUJ0fftrdCKP0Zwz/lhJRaPuRnnRwRUETFIwfOLYJRFSt1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIHK3kjW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34db22374f3so133769f8f.2;
        Tue, 30 Apr 2024 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714487990; x=1715092790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7DgcOTsA8UPpLRyL5kZXddV89o4d+7ihnZHszbkMxQ=;
        b=dIHK3kjWUzeIegTZg7xGnGxYksMoFpGvtqkhJHXSqrcIEU5IhynkFFQ/2hMNHfwRku
         EEGHvkNxnv6BLZWnBypc29CDnD4sLv442pabs5D7tHqP582o+0/XXd8UNealipkCM1gK
         97PKzufWLIR3eg/1IxMSQAZ/fyjtgF2HTmJ9kOlqU+aEiFsC6N6Q4jwWat4AMD3kluON
         kazCleQVgyB0Q2cJszSa88irCqkvrRUBKY7oBP+JQbf0biq/roRvSxWuZBtZKmmfXUTY
         qdWG4kcNQssedijb3hGJ2rvyVokmNqlj71HWFJZ2eIn4KZc6hCtH/f0TDC5ZW6RrL+Hx
         /Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714487990; x=1715092790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7DgcOTsA8UPpLRyL5kZXddV89o4d+7ihnZHszbkMxQ=;
        b=uK2bU2k2yS+Gq21E7v84tyq0rmIKejj/sAM8Opk72axyhlq4pPNmnZb1dgQBRFXll5
         gaE9+kP1HNwVHAKWOdzkadsk0Fp8CU25pPGYKINRsi5k9jxOszgamrb/p5vrlcxHtmaM
         PsjvdaHWI6ig7i5M9AidZwwhF8grTZ1VUzmMnKGiNQKFNfFYqwI9dDt1mZt74vHyUfS/
         6PAhhT+0rGNALkgeMlGiYTLZW3VRKvoZ+b1YShhS8hN8ahZpkCZJXue7GWWGTHusZhnb
         90MYsFCYGPuaT2rs54sw8p4IWQV068YYGOyFfTTZjt9UQRsQRSKDKLfxRecT33wPiA4r
         5LaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlbfiMe6VqVSlde0XNst+akRT5DuMz3c3rMB9Zg6F29+KfNiucyI2hnY1jLlMIjT4GK5ntFbYB3cmq99xxe8jL1iTdOBJsq1a0sLHJDPM9gn7h8TUkhM3orvI5j5VBUcpMiomF
X-Gm-Message-State: AOJu0YzmE4KWclA2KQjrsm5uSG3qJRrhxvxInFbOaTLeu5PeVTpTIIlN
	xYopkS+xihcVnE5kp8MnoY+hCcBvnBMWFb4jzpdi/pOWwr8N6nVR
X-Google-Smtp-Source: AGHT+IF0C0BjeadRleyUQcECX5eMDfFIkYrLdszT3O+rpxFT/ctb2bA3C54cL3VV3sBe4vx+7qAkyQ==
X-Received: by 2002:a05:6000:242:b0:34c:8b03:48b6 with SMTP id m2-20020a056000024200b0034c8b0348b6mr6209704wrz.23.1714487989431;
        Tue, 30 Apr 2024 07:39:49 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0034c8b0354a6sm9593289wru.106.2024.04.30.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:39:49 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v4 0/2] net: gro: add flush/flush_id checks and fix wrong offset in udp
Date: Tue, 30 Apr 2024 16:35:53 +0200
Message-Id: <20240430143555.126083-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to add network_offset and inner_network_offset to
napi_gro_cb and use these offsets for socket lookup.

In addition p->flush/flush_id should be checked in all UDP flows. The
same logic from tcp_gro_receive is applied for all flows in
udp_gro_receive_segment. This prevents packets with mismatching network
headers (flush/flush_id turned on) from merging in UDP GRO.

The original series includes a change to vxlan test which adds the local
parameter to prevent similar future bugs. I plan to submit it separately to
net-next.

This series is part of a previously submitted series to net-next:
https://lore.kernel.org/all/20240408141720.98832-1-richardbgobert@gmail.com/

v3 -> v4:
 - Store network offsets, and use them only in udp_gro_complete flows
 - Correct commit hash used in Fixes tag
 - v3:
 https://lore.kernel.org/netdev/20240424163045.123528-1-richardbgobert@gmail.com/

v2 -> v3:
 - Add network_offsets and fix udp bug in a single commit to make backporting easier
 - Write to inner_network_offset in {inet,ipv6}_gro_receive
 - Use network_offsets union in tcp[46]_gro_complete as well
 - v2:
 https://lore.kernel.org/netdev/20240419153542.121087-1-richardbgobert@gmail.com/

v1 -> v2:
 - Use network_offsets instead of p_poff param as suggested by Willem
 - Check flush before postpull, and for all UDP GRO flows
 - v1:
 https://lore.kernel.org/netdev/20240412152120.115067-1-richardbgobert@gmail.com/

Richard Gobert (2):
  net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
  net: gro: add flush check in udp_gro_receive_segment

 include/net/gro.h      |  9 +++++++++
 net/8021q/vlan_core.c  |  2 ++
 net/core/gro.c         |  1 +
 net/ipv4/af_inet.c     |  1 +
 net/ipv4/udp.c         |  3 ++-
 net/ipv4/udp_offload.c | 15 +++++++++++++--
 net/ipv6/ip6_offload.c |  1 +
 net/ipv6/udp.c         |  3 ++-
 net/ipv6/udp_offload.c |  3 ++-
 9 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.36.1


