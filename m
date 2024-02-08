Return-Path: <linux-kernel+bounces-58360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5F84E52C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282D928C935
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0E7EF1F;
	Thu,  8 Feb 2024 16:42:56 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA77E769;
	Thu,  8 Feb 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410575; cv=none; b=lV6L95A/DjYmE2Kb+ZbJrcLNF2+RKMEg7ZwK0+trhscUSQJW6t4NWQoBH/vzu2uRTlNOnnfz914a/41fc7fLZWnEnjZnbBsFtsQ6IxEVRz42PpzHge+813wd1izS0zgDy6zaU7fim7ZkReP0k5EoKgNv8Bxv5naotc2tfc8lpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410575; c=relaxed/simple;
	bh=gW0AFllNnEAQBVrgeTCj2rjFtP60DKD2E96OIeNnnQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5ooAsr5PdELMAbAz6tDwx+1V6E45SckSaed4AZdARQZNPse1p7NqYb3IEAXM5hUx78YlgU4azLi4bshTmWSWuNV7x+vMtsbCimoFxWLgNwIVQ1S0Slgy4b8pN8ioeKMJjTp6vaZAbs38a287TWdrJEfjwKD324TFbmPwiNG8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a34c5ca2537so273116866b.0;
        Thu, 08 Feb 2024 08:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410572; x=1708015372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OnoWkw6bx1OkNCR2tEaLZALGPAb99TEbSRwwoLobk8=;
        b=DJGdabf3W4/ZtoL4sNi+JZvdrkIZ7bhap7/FVIXlCSbSC9UFY+WhJzKxpjY+mUo7jv
         efeIj2zbYLoQWgDwaOUuOyZiFGlQjslb/yxsKJKucisNBfvipskibVT7bLoKuMxo9tKs
         qO6cctDFIVDoWSQyLov8g/0rNa8iOvI54v8irrnVDOFu6xvRWACAFyj0HyZDgEudHdSN
         MRif4dIpLomdYPQKxpXxvl4IiSeUrnyGVl2xXADeqqAmHg9Qkqj6JmdO32G8GQNlOSc7
         BC0mkPXGwac8vIJCFtYPu6TOlh1ueVCMe30l43pf5jpHobA1iY3eY2Y/dqSwr8EYrU4i
         wmvw==
X-Forwarded-Encrypted: i=1; AJvYcCVBdEaJetoJ1Wchvj9Qj7Wbou3UWCU3brpumGeU5/jk1eYu8jh3AgaQiLu1SIXvbCB3NllakU/saPChtzkqJaiUvz/5DhOVcqJ8tvGL
X-Gm-Message-State: AOJu0YzE4yizZNx6joLp2UN0ZNYdfqs1GcsuVR9hJjJkUfAGPEyCajNU
	aj/OYhhGdY6vo0S/3wUBqm8P6Ot+4IIbtjwxvXM/UZXq0UqLmH84
X-Google-Smtp-Source: AGHT+IFPFjoV+Z4TlXoIvx9wYXs5YsvGwxRFHDuZ8vfybjCK3Uf5qemj7892upamt5RX4TOBT3/mFA==
X-Received: by 2002:a17:907:2ccf:b0:a3b:bf98:fa21 with SMTP id hg15-20020a1709072ccf00b00a3bbf98fa21mr890878ejc.76.1707410571682;
        Thu, 08 Feb 2024 08:42:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULnOB7tdHQXSYCd1tpJwWowNCyvhcF2HXZcnmT5F9yxQPhHMQTX/shggx5gP4Q3joti63n0+fregJHOhWb3gyRShJ/nUh43JYLNA+JURkVhqxiBS2Lxf2+nKtKzgXzl5SKwHGZ7/dXANgPHEdrzdhAfMcCfx9S1wL5GjNJdJ4qC0UaXl/mjCxCG6nEpn5FjunF/b3sJ9KuZ9iD6WS1QCcFg4GR/uPalmvEykoFX1LgL4w0LPrQKGzYXdekmd0IpcJZBMe3Hx6JZ7IWdSh/VkqDsAul
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b00a3bbf725080sm224764ejc.55.2024.02.08.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:42:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	jhs@mojatatu.com
Subject: [PATCH net v3 0/9] net: Fix MODULE_DESCRIPTION() for net (p5)
Date: Thu,  8 Feb 2024 08:42:35 -0800
Message-Id: <20240208164244.3818498-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are hundreds of network modules that misses MODULE_DESCRIPTION(),
causing a warning when compiling with W=1. Example:

	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_cmp.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_nbyte.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_u32.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_meta.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_text.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_canid.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ipip.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_algo.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/esp6.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
	WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o

This part5 of the patchset focus on the missing net/ module, which
are now warning free.

Changelog:

v1:
 * https://lore.kernel.org/all/20240205101400.1480521-1-leitao@debian.org/

v2:
 * https://lore.kernel.org/all/20240207101929.484681-1-leitao@debian.org/
 * Remove the patch for the ieee802154 , since the fix is already in
   net-next. See discussion at:
   https://lore.kernel.org/all/ZcDs%2FGFkZ881bJR7@gmail.com/#t

v3:
 * Changed all descriptions of net/sched as suggested by Jamal Hadi
   Salim
 * Changed the description for dsa_loop_bdinfo as suggested by Florian
   Fainelli
 * Changed the description for IPv4 and IPv6 UDP tunnel description as
   suggested by Simon Horman.
 * Added a bunch of Reviewed-by

Breno Leitao (10):
  net: fill in MODULE_DESCRIPTION()s for xfrm
  net: fill in MODULE_DESCRIPTION()s for mpoa
  net: fill in MODULE_DESCRIPTION()s for af_key
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ipv6 modules
  net: fill in MODULE_DESCRIPTION()s for ipv4 modules
  net: fill in MODULE_DESCRIPTION()s for net/sched
  net: fill in MODULE_DESCRIPTION()s for ieee802154
  net: fill in MODULE_DESCRIPTION()s for ipvtap
  net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo

 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 drivers/net/ipvlan/ipvtap.c       | 1 +
 net/6lowpan/core.c                | 1 +
 net/atm/mpc.c                     | 1 +
 net/ieee802154/6lowpan/core.c     | 1 +
 net/ieee802154/socket.c           | 1 +
 net/ipv4/ah4.c                    | 1 +
 net/ipv4/esp4.c                   | 1 +
 net/ipv4/ip_gre.c                 | 1 +
 net/ipv4/ip_tunnel.c              | 1 +
 net/ipv4/ip_vti.c                 | 1 +
 net/ipv4/ipip.c                   | 1 +
 net/ipv4/tunnel4.c                | 1 +
 net/ipv4/udp_tunnel_core.c        | 1 +
 net/ipv4/xfrm4_tunnel.c           | 1 +
 net/ipv6/ah6.c                    | 1 +
 net/ipv6/esp6.c                   | 1 +
 net/ipv6/ip6_udp_tunnel.c         | 1 +
 net/ipv6/mip6.c                   | 1 +
 net/ipv6/sit.c                    | 1 +
 net/ipv6/tunnel6.c                | 1 +
 net/ipv6/xfrm6_tunnel.c           | 1 +
 net/key/af_key.c                  | 1 +
 net/sched/em_canid.c              | 1 +
 net/sched/em_cmp.c                | 1 +
 net/sched/em_meta.c               | 1 +
 net/sched/em_nbyte.c              | 1 +
 net/sched/em_text.c               | 1 +
 net/sched/em_u32.c                | 1 +
 net/xfrm/xfrm_algo.c              | 1 +
 net/xfrm/xfrm_user.c              | 1 +
 31 files changed, 31 insertions(+)

-- 
2.39.3


Breno Leitao (9):
  net: fill in MODULE_DESCRIPTION()s for xfrm
  net: fill in MODULE_DESCRIPTION()s for mpoa
  net: fill in MODULE_DESCRIPTION()s for af_key
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ipv6 modules
  net: fill in MODULE_DESCRIPTION()s for ipv4 modules
  net: fill in MODULE_DESCRIPTION()s for net/sched
  net: fill in MODULE_DESCRIPTION()s for ipvtap
  net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo

 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 drivers/net/ipvlan/ipvtap.c       | 1 +
 net/6lowpan/core.c                | 1 +
 net/atm/mpc.c                     | 1 +
 net/ipv4/ah4.c                    | 1 +
 net/ipv4/esp4.c                   | 1 +
 net/ipv4/ip_gre.c                 | 1 +
 net/ipv4/ip_tunnel.c              | 1 +
 net/ipv4/ip_vti.c                 | 1 +
 net/ipv4/ipip.c                   | 1 +
 net/ipv4/tunnel4.c                | 1 +
 net/ipv4/udp_tunnel_core.c        | 1 +
 net/ipv4/xfrm4_tunnel.c           | 1 +
 net/ipv6/ah6.c                    | 1 +
 net/ipv6/esp6.c                   | 1 +
 net/ipv6/ip6_udp_tunnel.c         | 1 +
 net/ipv6/mip6.c                   | 1 +
 net/ipv6/sit.c                    | 1 +
 net/ipv6/tunnel6.c                | 1 +
 net/ipv6/xfrm6_tunnel.c           | 1 +
 net/key/af_key.c                  | 1 +
 net/sched/em_canid.c              | 1 +
 net/sched/em_cmp.c                | 1 +
 net/sched/em_meta.c               | 1 +
 net/sched/em_nbyte.c              | 1 +
 net/sched/em_text.c               | 1 +
 net/sched/em_u32.c                | 1 +
 net/xfrm/xfrm_algo.c              | 1 +
 net/xfrm/xfrm_user.c              | 1 +
 29 files changed, 29 insertions(+)

-- 
2.39.3


*** BLURB HERE ***

Breno Leitao (9):
  net: fill in MODULE_DESCRIPTION()s for xfrm
  net: fill in MODULE_DESCRIPTION()s for mpoa
  net: fill in MODULE_DESCRIPTION()s for af_key
  net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
  net: fill in MODULE_DESCRIPTION()s for ipv6 modules
  net: fill in MODULE_DESCRIPTION()s for ipv4 modules
  net: fill in MODULE_DESCRIPTION()s for net/sched
  net: fill in MODULE_DESCRIPTION()s for ipvtap
  net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo

 drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
 drivers/net/ipvlan/ipvtap.c       | 1 +
 net/6lowpan/core.c                | 1 +
 net/atm/mpc.c                     | 1 +
 net/ipv4/ah4.c                    | 1 +
 net/ipv4/esp4.c                   | 1 +
 net/ipv4/ip_gre.c                 | 1 +
 net/ipv4/ip_tunnel.c              | 1 +
 net/ipv4/ip_vti.c                 | 1 +
 net/ipv4/ipip.c                   | 1 +
 net/ipv4/tunnel4.c                | 1 +
 net/ipv4/udp_tunnel_core.c        | 1 +
 net/ipv4/xfrm4_tunnel.c           | 1 +
 net/ipv6/ah6.c                    | 1 +
 net/ipv6/esp6.c                   | 1 +
 net/ipv6/ip6_udp_tunnel.c         | 1 +
 net/ipv6/mip6.c                   | 1 +
 net/ipv6/sit.c                    | 1 +
 net/ipv6/tunnel6.c                | 1 +
 net/ipv6/xfrm6_tunnel.c           | 1 +
 net/key/af_key.c                  | 1 +
 net/sched/em_canid.c              | 1 +
 net/sched/em_cmp.c                | 1 +
 net/sched/em_meta.c               | 1 +
 net/sched/em_nbyte.c              | 1 +
 net/sched/em_text.c               | 1 +
 net/sched/em_u32.c                | 1 +
 net/xfrm/xfrm_algo.c              | 1 +
 net/xfrm/xfrm_user.c              | 1 +
 29 files changed, 29 insertions(+)

-- 
2.39.3


