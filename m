Return-Path: <linux-kernel+bounces-28654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A0F830165
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705E9287485
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33611C86;
	Wed, 17 Jan 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwpjjwbL"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCC12B68;
	Wed, 17 Jan 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480695; cv=none; b=XJeoizpxWcEJUcVfXmecxiq82+AljflgGjTc8wmJNwDMPZC7qVoAhiZEgGQlSpBJ7hKDdrw7Pd1ozur9l9VkhBA/dfKVdA6B8ZKDbEfnC91jCyLxBJDSBp1MFf/DD/aUCHTqiaq8mw/9ToPSwuz9cMYdAkQG6jisdm79sIlW4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480695; c=relaxed/simple;
	bh=VtsiPGfRjMnW7iyF/uQYtjNk+z7EmslfrGX+3dSxVGA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=U/YeUqfd50joSIaZua156lgLfADmdChFVdMy7zTHhMLxQ0qCwQ9gZTYNa+l5UF+VixlWSJsl4iijD/YWSI30z6Z/+ibwr1+gSZVphbjeugegO4AFOhl6eGCz9ptPuIy59peJbZB2497Wc8uZWCQ7KqAL3scLU1+v3EpfLDGwRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwpjjwbL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5dfda4319so12639455ad.0;
        Wed, 17 Jan 2024 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705480693; x=1706085493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSOMGuUHrQxjLGHgZ49LUYPYZXjRbYJLosFfB3nja5M=;
        b=SwpjjwbLiD8OcWUkVHCz96i767ZURWlCM/52FGohPpELIEKlppVQWuBl/6wwfEAxQX
         Sy9+62L90qpyVvGBsy1f/CoX/SC7cmgGMsE6IxX47actBkIFM1LDysRr9d+1cWgcuZiA
         cmDxp4Gs5zMfNDbAOiOL5dG2YPY6wXfdg7ED2YSkHf2i37c55zJYpGOSiQrNh8P2l+f3
         Etnd3+i18Owp0PQWJXUmm1kY5Hd1m2GTunUgoSpQ5Gw2/mEYdfqtarqAzNbkM0e4Ih83
         C9y0RmImX8wK8Qa+QbG/4LstTwYxF5J6zKfGRkJMN1S5v3tFNszs6pDH9TnRrnphBEvv
         C55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705480693; x=1706085493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSOMGuUHrQxjLGHgZ49LUYPYZXjRbYJLosFfB3nja5M=;
        b=TioX3msOkDotW+X9nFdtPhMGslN1Tcj5zgvipiV4H24XKyjzba9bX3zuvU5CaTVJ7y
         SxcaPMTyngq77j+D1DnB8PWbcZqIJc4q3xz3Fu+4dYmRYZxErYROFkCqs5kVd2bghIRU
         mt+4vSxZgQhXpxKmE0iSOZ/spnx1GxhRpdakcAEhxVQZgyHvFcT03TneTDLNHhx/wzP7
         lWoMUtm1s59lu6JdZtflo99scXIE/IZ3X8ds4QSolkOOuIRZeZQIIHxX8xZLRWoIpDXV
         XBgSB/PWIyRQ1owtjXvaBPrSMX2I7HaTotRh0IcrWYo3rxfsykwEJ5ciaeXX1xoSEx+e
         ixlA==
X-Gm-Message-State: AOJu0Yw6+0dZaFyN+2GIQa1PVWJuu3XLtjmloZIAKWZYkf2oCvO6lboB
	j6GRrz+8a7z7m8thNCaMCTsQj/f2d1eCYMIqqOs=
X-Google-Smtp-Source: AGHT+IGF32Idn6WvEOYbmK6PJaSkBAoafsAJF85+7k2nFlGNaRGBxUZXUh5p5xDnV68gDxhKX4qDZA==
X-Received: by 2002:a17:903:11c3:b0:1d6:96b:5dd with SMTP id q3-20020a17090311c300b001d6096b05ddmr1440184plh.82.1705480693494;
        Wed, 17 Jan 2024 00:38:13 -0800 (PST)
Received: from localhost ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902ba8500b001d5b87ee67bsm6658912pls.186.2024.01.17.00.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:38:13 -0800 (PST)
From: nai lin <ayano2023th@gmail.com>
To: netdev@vger.kernel.org
Cc: nai lin <ayano2023th@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
	Li RongQing <lirongqing@baidu.com>,
	David Howells <dhowells@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netlink: fix potential race issue in netlink_native_seq_show()
Date: Wed, 17 Jan 2024 16:37:13 +0800
Message-Id: <20240117083715.7800-1-ayano2023th@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Access to the nlk group should be protected by netlink_lock_table() like
commit <f773608026ee> ("netlink: access nlk groups safely in netlink bind
and getname"), otherwise there will be potential race conditions.

Signed-off-by: nai lin <ayano2023th@gmail.com>
---
 net/netlink/af_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4ed8ffd58ff3..61ad81fb80f5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2693,6 +2693,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 		struct sock *s = v;
 		struct netlink_sock *nlk = nlk_sk(s);
 
+		netlink_lock_table();
 		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8lu\n",
 			   s,
 			   s->sk_protocol,
@@ -2705,7 +2706,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 			   atomic_read(&s->sk_drops),
 			   sock_i_ino(s)
 			);
-
+		netlink_unlock_table();
 	}
 	return 0;
 }
-- 
2.25.1


