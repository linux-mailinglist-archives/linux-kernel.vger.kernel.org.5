Return-Path: <linux-kernel+bounces-51241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB74848834
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BA028570D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6395F867;
	Sat,  3 Feb 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="UwoQqlAA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC88171A1;
	Sat,  3 Feb 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985518; cv=none; b=UvmHK9DALz32l6WQkmL7Zec0lmg5RDbDpIPw1lnhSh9dvqHGiU9Kn2q1OrRrrWAE8Fwcp3IX1bdUileBO+lS+plh1I55YEu7Rnc3u3FuYr/1gfNZdWAT56QZnvdjCq9gXh35s4V6kaOqHirdO4BeBXL1xc15OMU2mhlrHQmW6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985518; c=relaxed/simple;
	bh=55pC8PmmesMkkMcxKlBxnasiVv+JgYV9EVVd0EP8JS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uIi9aiUJor0ACYepQexWq/JWsZ3Lg/WFIzPaGpH37aVQdv8ghpN3jdKIXjk5KpjyhxLiAtRDe/SINIQe7U6inMkGR0H4sg8NBFCebWlWVdnk5GuuKBxvmscdKQ1Bhf6ShLgDkEbZt7xtAI2Ix+za2rOyy9xguO7qHGmk62Su8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=UwoQqlAA reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29661facbd0so490857a91.1;
        Sat, 03 Feb 2024 10:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706985516; x=1707590316;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rZMgjYPFP9Yzkc6R6Rytn+r1bio2ga/RF1ve70xIGPQ=;
        b=DYZPz7tvTO1X0KxdZtXDAX8hYX6OWm48eQGhj9+fmqw6iYD9ivDbjzM+MY0E5LfsoT
         FQUVYMDAPACuZUT7DEIW04V7vFqzZ4CtXzxPw2mEXEwAAnFkz0+feHuF28RTHAsL/nML
         bpm1921QtkwKkgx1xP9oXOyiXBbO3zzWbpWJJOipW8+pqTMgvlrcwhYiOgvPgCyVatgr
         qkOGo2FcjVSsKhUOFhcn9VUZwpRNKeLqbXA3swczlCtVWrW6u4YnglVFNt89/7KJuNab
         6EaMlYfkuyDXd9Bn8tcmlGzhDOPnKd0YdB3qY45EqHrJRT8zbMxmUWhDurQURfPo5Qyn
         vfrA==
X-Gm-Message-State: AOJu0YyzWFJ5EFbAbLg3IVNnrriFioeIezQOfcdMT5hFT5jI3fAn9lIA
	VwVceP0wWvvHovjo5ezv138jK3r/XfK1jzpNq+P7fY18QhPjYnRH
X-Google-Smtp-Source: AGHT+IGWVQb+q0wRfseVKHM3kLUKBXHC662fWVxnNfV6YxZXtonVerOVxIrTPpCQzgS1R7SeSoJqIQ==
X-Received: by 2002:a17:90a:bc81:b0:296:2afd:ead2 with SMTP id x1-20020a17090abc8100b002962afdead2mr2653208pjr.21.1706985516384;
        Sat, 03 Feb 2024 10:38:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW58McI3eZAtygN9z7x5wCbcYO9uQ2v1MpEc0q7eNkSzRJ2e9zOeRd9QvXagLQqIdJF5Db5OJReBUSmD0zKS7YfYXTXACUMaY8thU/MrDZOBkDeLztxxMtYurN4E5zE1grm9B5WjMaUeruTJLCfWdF/cgureQ51uoJe5gxS6MiYF/R+8odnsw10KRc3Zmc1OeoQLvtWiEOU0sZnoJzXj81hTFXRSPXiybEIn0n59eEGzhCmaVdR3KFkC2EMuWs3Yg+zeaZ2h22po7DTiaeGIJURyWnRhJ0mifEuOOT6BsJNQdrpymInDUQKu/J6BA+6DdjFXhpe4W0U
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id sz14-20020a17090b2d4e00b0029082d10fc4sm2123442pjb.39.2024.02.03.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:38:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706985514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rZMgjYPFP9Yzkc6R6Rytn+r1bio2ga/RF1ve70xIGPQ=;
	b=UwoQqlAAi5vIXM+Nmc95zavfTJbCIK8lKnx921XMc5KcWUxhEjUYlpwx1IUcu5Y+4rlWgY
	9AaFV0YUeZ5evnyU4MOllk1+NtjwVEW093pkdSqsmFnIeb7q8eATWGcT4kqGVR5xcJfs1Q
	6rGuWu4UJnIqj0pkq4rZun4pSRbtef4klNNNSi9cHC4G8s/sA1ZUratSqywMD/9NUgJacm
	1Zp0zl4FfBqEnxkBCianVa2nQDXU889d51/LrIdFO0vqJwekpwH+MAucBgEM/KF/WZQAFq
	In+mVX/SaVM6emn25nSprSDTNgiOvAEhYJvz5tnqMZQ+aFNvp5Ishe3GoCzDpA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/3] drivers: scsi: struct bus_type cleanup
Date: Sat, 03 Feb 2024 15:38:59 -0300
Message-Id: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOIvmUC/x3MQQqAIBBA0avIrBNsCoKuEhFqUw2EiYMRhHdPW
 r7F/y8IJSaBUb2Q6GbhK1S0jQJ/2LCT5rUa0GBv0HTaZVn8STbkqMUL68Ej0uqGzm491Cwm2vj
 5l9NcygcZvvw3YgAAAA==
To: Hannes Reinecke <hare@suse.de>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
 Mike Christie <michael.christie@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 open-iscsi@googlegroups.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=55pC8PmmesMkkMcxKlBxnasiVv+JgYV9EVVd0EP8JS4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvohGFcYaRf2nUJBLOgyYpdPWmVeYVByGz8TYk
 nnXehlU5XWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6IRgAKCRDJC4p8Y4ZY
 pi6eD/0bHQkKvpkpC43h27jU3hHRrsOaqdjcC3CbqCjn7mj5foWzWWOmaemJQ7zSAL+aOU06chB
 UC6MaqrFmdgoq3PD4FtPZFlE5M+nq8FlOuBwTX0Uhvk8PNW/YQwlCSusVrZeJehISj74w7oBY0Y
 J1Nme2JkDxpK6dfyyxrguIBfqD6HLd+CdSKaSGH39uWMxIGc0ar/ldpwj+acSl1ChHVcavUSSBu
 0cMcn/OJR2bLMHU9nZ0wTmJBJTGuhhcXuBgbzmZCbfEr59tnz7gSEAC1m685DXjE1RuadQEP7W9
 3InkxvxaR2bJopXYEYp5o97/cfGo9xmVcdLHQORRecTbo78e2QS7TBa155NIgsYyoIs0CD+t8uu
 9a5Tv6/A/GMJSniPUPkyo5ila8gAG6XL8kGlVB5tatV5ILJT4o9b2Xb0e1DzLugs7oAmbjpUHru
 D7YQr6qxnQIF132gk+rerAk5t7O7x/xGBY7j5WPgixqsZ8nNXU9hoS844wWif8JSu/KFP7XQaRj
 oLb2RnSeTjlPVxMXcQVwSstpjxagAuZDfDesWeIgrkiggYBAmSROlFaEfqI6QpPlggfMBRlpYXS
 H9rVa2nypLwWrfNKERhHuQvBOaYj1MRCH86K1/xMP/vVMJ1ntravwZQDGup3/SQU12FdtL0tYd3
 NoX12+WsQ2fZ+PQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (3):
      scsi: fcoe: make fcoe_bus_type const
      scsi: iscsi: make iscsi_flashnode_bus const
      scsi: scsi_debug: make pseudo_lld_bus const

 drivers/scsi/fcoe/fcoe_sysfs.c      | 4 ++--
 drivers/scsi/scsi_debug.c           | 4 ++--
 drivers/scsi/scsi_transport_iscsi.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 890d900e7fec7f7956c26bd47b4f0f07a0a507b1
change-id: 20240203-bus_cleanup-scsi-7c22edb73af4

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


