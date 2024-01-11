Return-Path: <linux-kernel+bounces-23824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B16182B258
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3EB22E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0B4F61E;
	Thu, 11 Jan 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5jmSUMP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767F4F5E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704988988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rvVCPW01Dzjo4BPhuO75nSETzwSq/CqyJjnh4//BiuE=;
	b=U5jmSUMP0Oop0b9+KOpXgPob2ifnuxBpETVKaPYAG6dVfcVXJ98GMLWkaZQ/KPqcI8IlWo
	WVhbSoy83k7Yfik2N6iohm1AJIBIxRus/Q2ljcN2BAahiZsH8zYUbswgF697Rq+CbK3T1/
	Tc72yXy2rjue3igwd2hf15AwOuYWxeA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-TyGL1Cg1MFmmWCJYEjl9aA-1; Thu, 11 Jan 2024 11:03:05 -0500
X-MC-Unique: TyGL1Cg1MFmmWCJYEjl9aA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d56d0a8f85so19643995ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704988984; x=1705593784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvVCPW01Dzjo4BPhuO75nSETzwSq/CqyJjnh4//BiuE=;
        b=vnoewhBFBfu8s2iLVNSWlOAoqpCmw2N7LWQU6FNvxPeALVFKtq6168bz+y/Jhd3N+E
         QRBrLX+xMQ6D3GFEMxyr5tKkoevnCjDAJcxpXTO4iuDXLxqrEKA8rxvzBYarAKLLPuYQ
         +HmMI1DvQzuGayZBZQ9Ppqu1oDmxZAvyp08ezk8t8iHqlBgwbtDYUnW08Hse1QL4NPFm
         8/48n72D0d3zbUG+JXy4lQMMV/PoHNGiTb1ahhoCLgzNzhPEyVj6hvPYQ4naWTR3MJ4F
         4H0Z7dCaf0LjrFOURoADAABFp/2Ck3ntbX38tgjx+BEeWdsZ6U4YKGVbaiGDwdJE+m+i
         4Hxw==
X-Gm-Message-State: AOJu0YwANGH2dhfTRdw7Ht6MS0jg0t5sNTWj6E11RHuM+dpWv0Bcxoeo
	kZNo2wA+AXaRMKox2dC0d/YWhXPhVjrg2DtiDwBD0C/YdBlHwk/ougkJt07+m9xVaYkLt9+esgQ
	9rHPMktvqBwgWVU8O+/8N3ts3LecwBYE=
X-Received: by 2002:a17:902:da8b:b0:1d4:3736:88b0 with SMTP id j11-20020a170902da8b00b001d4373688b0mr1229925plx.55.1704988983852;
        Thu, 11 Jan 2024 08:03:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNm+Rq2d75c77QJRbApZkO1GGpd0DVitdQaMbXSLARHJFGIKG0rtK2J7YJtyCFTBbajTf6Bw==
X-Received: by 2002:a17:902:da8b:b0:1d4:3736:88b0 with SMTP id j11-20020a170902da8b00b001d4373688b0mr1229908plx.55.1704988983482;
        Thu, 11 Jan 2024 08:03:03 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id jh18-20020a170903329200b001d4593a2e8fsm1343903plb.83.2024.01.11.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:03:02 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 0/1] fpga: improve protection against low-level control module unloading
Date: Thu, 11 Jan 2024 17:02:41 +0100
Message-ID: <20240111160242.149265-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a solution to keep protecting the fpga manager against
the unloading of the low-level control modules while addressing the
limitations of the current implementation. Currently, the code assumes
that the low-level module registers a driver for the parent device that
is later used to take the module's refcount. This proposal removes this
limitation by adding a module owner field to the fpga_manager struct
that can be set while registering the manager.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

v5:
- Updated the documentation
- Removed kernel-doc comments for helper macros
v4:
- Use helper macros to set the owner module
v3:
- Improved locking
v2:
- Fixed protection against races during module removal

Marco Pagani (1):
  fpga: add an owner and use it to take the low-level module's refcount

 Documentation/driver-api/fpga/fpga-mgr.rst | 34 ++++----
 drivers/fpga/fpga-mgr.c                    | 93 ++++++++++++++--------
 include/linux/fpga/fpga-mgr.h              | 28 +++++--
 3 files changed, 102 insertions(+), 53 deletions(-)


base-commit: c849ecb2ae8413f86c84627cb0af06dffce4e215
-- 
2.43.0


