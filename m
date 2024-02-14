Return-Path: <linux-kernel+bounces-65418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3297854CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DB0B27389
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3B5D732;
	Wed, 14 Feb 2024 15:29:00 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D885A0FB;
	Wed, 14 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924540; cv=none; b=PLKwn7BtqZQ2VPAyMnU9AqBCMh5VK2g2dzYwO3rzAl5N5VH+Cg4rUlKPbRhGwcBXpf7jL2vmpDOUzKEymYIz4B2GE1x7LE47mCnWpbwrzY7QkG24FmpNdQEKBNNFZhLGRcBMavrKMlpj9n1QMnjTZx8iu7Z6WdgEdEzHNhmTOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924540; c=relaxed/simple;
	bh=HJ8M9w8B9enPtzyI7aV4K+O7sIUZBEAoprl39Ku2W0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwHYC8Vndac/7s6WV/xga1oiRKJLCcYMjEoRlLWCrFk2zs1qeC9DXz8gmGVQOMuGDJur+CEq0pNjtTLeqU4Liy0wwvzuyVaaV0FSnfBcIxnEM9Ek95t/h3wqjjlX6f145txdBBh7igISvQNUaOpJPvELP5LIoTmR38xwFsbrIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so7799837a12.0;
        Wed, 14 Feb 2024 07:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924536; x=1708529336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YRPBt00zeX3ioIqNbX3DTIpovkCbTNA6gkJ2X0MmnE=;
        b=nHRDHNy58HLA6ztUFBd1ia4QFS8UUTN//RFFesibU2HeXeFIOEBTOM/p5NOaPXO/7f
         vW8fDa4QMMq5Oa8PMS3ZCxKXxhlNZUh6k0vyhW+OgtHYPtcGOosT7uOeOHlGgKnp03OU
         AhQ/cLjTZ1JasVPlVM8m+LXoI1i8aCpP8hy2tt7BdDDw2rJ0riGZdSX9hRUAPCH68w0H
         c8371z4EVWSTUHGq/HmFTR/P1ZLA2pD/VC8Ne8LAXc1UFb9QXsI1TnoUNsQntqjVDXW+
         4rtZ/Bv1iT7LYl54vqTdszZxmglqSUhzzmMThB/vy0Q12zeVyEBAwNBZhfq9RUZklh8c
         NkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9MsC/Nz+bi/4Abq2h3oAzJftzoTH8gP9MSsstpJNd7hFucR50MZzm4MMk+IIJWh3dlZRoiyepVpA6TUpiQlJUmBCgTXhGGuh1kjYk
X-Gm-Message-State: AOJu0YwP+yUoQSCWG1oraols1/Tqxyrgcz4LCo4aQ/t2D94nUjRaPcQZ
	n3qEwS51U95Vj8doBI3sXCNcNXB4u4CCh8jHjOsWg4DVrsG/JDgy
X-Google-Smtp-Source: AGHT+IFiuO/WHYeJatqxwvm2YCR/6jCsu8y64Y54o87oj38AW+A6Tfjo7RT+w2je11vddo1mbf+0kA==
X-Received: by 2002:aa7:c40c:0:b0:560:a95:5385 with SMTP id j12-20020aa7c40c000000b005600a955385mr2559441edq.24.1707924536425;
        Wed, 14 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeTqQIEOXdEm2o7aJq/l2+k4F2qOhzy3qMrG+E0VEVPUKk9IO7QyTWB4Q7Jc/eHgSiDBCdr9CTLXtHWeV42xk5kmNARwX0RChntFI/JF2AvRUjah+W1Mr+ouESa8L6cs3brAihn2YIz0uI9CfRcojY8Vz3FaSlQJuy5Nw1qnTklyUBgwWPuevCrTkEgYqLW2z9aSssfqjXh0nuIA==
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id ec9-20020a0564020d4900b00563918a48cfsm180054edb.40.2024.02.14.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:28:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2 0/7] Fix MODULE_DESCRIPTION() for net (p6)
Date: Wed, 14 Feb 2024 07:27:34 -0800
Message-Id: <20240214152741.670178-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few network modules left that misses MODULE_DESCRIPTION(),
causing a warnning when compiling with W=1. Example:

        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/....

This last patchset solves the problem for all the missing driver. It is
not expect to see any warning for the driver/net and net/ directory once
all these patches have landed.

Changeloge:

v1:
  * https://lore.kernel.org/all/20240213112122.404045-1-leitao@debian.org/

v2:
  * Rewrote mdio_devres description as suggested by Andrew Lunn
  * Added an acked-by from Paul Durrant in patch 1/7

Breno Leitao (7):
  net: fill in MODULE_DESCRIPTION()s for xen-netback
  net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
  net: fill in MODULE_DESCRIPTION()s for plip
  net: fill in MODULE_DESCRIPTION()s for fddik/skfp
  net: fill in MODULE_DESCRIPTION()s for ppp
  net: fill in MODULE_DESCRIPTION()s for mdio_devres
  net: fill in MODULE_DESCRIPTION()s for missing arcnet

 drivers/net/arcnet/arc-rawmode.c  | 1 +
 drivers/net/arcnet/arc-rimi.c     | 1 +
 drivers/net/arcnet/capmode.c      | 1 +
 drivers/net/arcnet/com20020-pci.c | 1 +
 drivers/net/arcnet/com20020.c     | 1 +
 drivers/net/arcnet/com20020_cs.c  | 1 +
 drivers/net/arcnet/com90io.c      | 1 +
 drivers/net/arcnet/com90xx.c      | 1 +
 drivers/net/arcnet/rfc1051.c      | 1 +
 drivers/net/arcnet/rfc1201.c      | 1 +
 drivers/net/fddi/skfp/skfddi.c    | 1 +
 drivers/net/ieee802154/fakelb.c   | 1 +
 drivers/net/phy/mdio_devres.c     | 1 +
 drivers/net/plip/plip.c           | 1 +
 drivers/net/ppp/bsd_comp.c        | 1 +
 drivers/net/ppp/ppp_async.c       | 1 +
 drivers/net/ppp/ppp_deflate.c     | 1 +
 drivers/net/ppp/ppp_generic.c     | 1 +
 drivers/net/ppp/ppp_synctty.c     | 1 +
 drivers/net/xen-netback/netback.c | 1 +
 20 files changed, 20 insertions(+)

-- 
2.39.3


Breno Leitao (7):
  net: fill in MODULE_DESCRIPTION()s for xen-netback
  net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
  net: fill in MODULE_DESCRIPTION()s for plip
  net: fill in MODULE_DESCRIPTION()s for fddik/skfp
  net: fill in MODULE_DESCRIPTION()s for ppp
  net: fill in MODULE_DESCRIPTION()s for mdio_devres
  net: fill in MODULE_DESCRIPTION()s for missing arcnet

 drivers/net/arcnet/arc-rawmode.c  | 1 +
 drivers/net/arcnet/arc-rimi.c     | 1 +
 drivers/net/arcnet/capmode.c      | 1 +
 drivers/net/arcnet/com20020-pci.c | 1 +
 drivers/net/arcnet/com20020.c     | 1 +
 drivers/net/arcnet/com20020_cs.c  | 1 +
 drivers/net/arcnet/com90io.c      | 1 +
 drivers/net/arcnet/com90xx.c      | 1 +
 drivers/net/arcnet/rfc1051.c      | 1 +
 drivers/net/arcnet/rfc1201.c      | 1 +
 drivers/net/fddi/skfp/skfddi.c    | 1 +
 drivers/net/ieee802154/fakelb.c   | 1 +
 drivers/net/phy/mdio_devres.c     | 1 +
 drivers/net/plip/plip.c           | 1 +
 drivers/net/ppp/bsd_comp.c        | 1 +
 drivers/net/ppp/ppp_async.c       | 1 +
 drivers/net/ppp/ppp_deflate.c     | 1 +
 drivers/net/ppp/ppp_generic.c     | 1 +
 drivers/net/ppp/ppp_synctty.c     | 1 +
 drivers/net/xen-netback/netback.c | 1 +
 20 files changed, 20 insertions(+)

-- 
2.39.3


