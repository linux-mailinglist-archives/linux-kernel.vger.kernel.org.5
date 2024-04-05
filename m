Return-Path: <linux-kernel+bounces-132543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A289967A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681491C2150C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074D364DF;
	Fri,  5 Apr 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dow/cb3E"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC322E85B;
	Fri,  5 Apr 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712301820; cv=none; b=mmv6Mq8HfcSY0OAII3Wb+iff6oylxghCG9ZoEDqEamI/gThF7X2rgOOCe+zj9La1Hm8lYKtf1X1eFYuiePhBclwc19t8BXvYBmIM8D/qqZ1BuRkIoD2ndda6RCNF5fVFNt194BcsxVxP/PnptlCroi3nHsLLQqYR/SZ/8VKPASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712301820; c=relaxed/simple;
	bh=hRccm9m5vw0AKVSXM312iTTtd+u1p5KLAVUzpF/6FuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZLPBdBX/WNoKivne+ooUP7btIK5Z2PReftzTXh+U4rmcmeE+PGFlrgAi+CYJTuG9NG0MCRGTqZLH2BDpisySlkwj6ivyvEPyRzABTDnQ/ONUiXNGt+n8STFxvuO8GaoDHrBjn81jF2DxVLCQ5wegh+b5YHf7KdIsvdD9k94dIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dow/cb3E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf541e19aso966505b3a.1;
        Fri, 05 Apr 2024 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712301819; x=1712906619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+mKuwm9djI4v7qk8JQWHImQIu4bxchpuJ6L7UOd9pI=;
        b=dow/cb3EbiiSoEVrk4NexdvYrLRNVN+ISnKoIg6faGsxVUolReSkVKb7gFWlY4xmGZ
         ZWmOjzTrb927AHFgjKPNPKa++Q25JXJym1zlnRAgpJ/Y6KvbGfq0W+rN6EDZ1iqvaD6l
         d5hT4bDzLPWjI89cU1QBbEfrMzTEyQz4NW/lVj+qRJVwfza2vJtWG19lyR23ahv/oMSj
         xiSTIu5OFkpzIVAWVcMIjyLNwvyuZbhc1eiO2Xh/JGSz+siWyg9raEueUW4Z1vojmVSI
         i30IdG+tr0SW0yw0SccrFX6T01CnE1iNSvjU321iNCWiSHm9v8QjONxu7mhExNCfpz6o
         JP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712301819; x=1712906619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+mKuwm9djI4v7qk8JQWHImQIu4bxchpuJ6L7UOd9pI=;
        b=NS5K96RbcrKBTp9CYonzctROQIdVqdDTtOyhsZc0TV/dXVKEssJg8NCDBKaZSp9O2J
         dAlvYbQbJolHbnEhx+5YPBpIhbUxOcrEj4LAgYpA1apjBSRyCdtcVhEEeRpJJoYhW5sQ
         5DsgmmdeSn/4dFOm1OqDAwFUXcio0kMYUTPYR8p0dQSPL7O/1StZHpp87OEDr6OrKZ6R
         tfv5kG8mDYiLLW+wa874Ali2MDaLnecSU1aHNfwuinjDoLK+9jKqfQtmAuaEj2HPR1Uf
         R+3+3tK7WVjUtLLgiJlYL3HXLWOphh/QlHRAxNdjTcmXIRXRBtSVuvOWLLGPIHqwl69r
         xnJA==
X-Forwarded-Encrypted: i=1; AJvYcCVOCCD2e6sXRF7iBUI+ZuxXiUeKuo0u69n28UoDw6ShijSc8nlzsiQszhY9ci3mz0NRUj/byFT/O6G97znl8U2soB3phiJgOFY0FLTzKMIlqntQNrrrukh7heB1DTXl3gv6DTlobpwr4hk=
X-Gm-Message-State: AOJu0YzGrZ57FkkFFp0Gy0YqYoPaQy+Rt4GYmFAvesIip/NDeA+Ycazr
	uIWOEtzSZsw98cHQJw2bOOV2/dA4iYBodoaVgsgTjwAL3bcteS+q
X-Google-Smtp-Source: AGHT+IGJSLKP0itZDSdik+cHlihTao/IumfFcFee1CoOJS4jT5RPun8dKi1IyR0oEa7CmiT29jD4Yw==
X-Received: by 2002:a05:6a20:84a8:b0:1a5:6fde:7f28 with SMTP id u40-20020a056a2084a800b001a56fde7f28mr643980pzd.55.1712301818566;
        Fri, 05 Apr 2024 00:23:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 10-20020a056a00072a00b006e69cffc87dsm833559pfm.84.2024.04.05.00.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:23:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E777718483F59; Fri,  5 Apr 2024 14:23:33 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux bcachefs <linux-bcachefs@vger.kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/2] toctree fix for bcachefs docs
Date: Fri,  5 Apr 2024 14:23:17 +0700
Message-ID: <20240405072320.23416-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=713; i=bagasdotme@gmail.com; h=from:subject; bh=hRccm9m5vw0AKVSXM312iTTtd+u1p5KLAVUzpF/6FuM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDGn8y9T23E5eezBhvYv1upPWOie/by95mTbN0sry4p2Cz K3Lt5Z87ChlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBE5O4zMry5c/i66meje7/m ti9PETu8m3vb6bedd03UNVI9ZLhiKiMZ/oed+7sz2cQzLWZm34SzOpkeZ4pfn30TtVRJ5veqqEK neA4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi Kent,

Building htmldocs for current Linus's tree triggers a new warning, and
that is on your docs (missing toctree). Here's the fix + MAINTAINERS
entry for bcachefs docs.

Thanks.

Bagas Sanjaya (2):
  Documentation: filesystems: Add bcachefs toctree
  MAINTAINERS: Add entry for bcachefs documentation

 Documentation/filesystems/bcachefs/index.rst | 11 +++++++++++
 Documentation/filesystems/index.rst          |  1 +
 MAINTAINERS                                  |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 Documentation/filesystems/bcachefs/index.rst


base-commit: 09d4c2acbf4c864fef0f520bbcba256c9a19102e
-- 
An old man doll... just what I always wanted! - Clara


