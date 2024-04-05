Return-Path: <linux-kernel+bounces-132980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A83899CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20511C2268C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558816C871;
	Fri,  5 Apr 2024 12:22:59 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891318E1D;
	Fri,  5 Apr 2024 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319779; cv=none; b=bUxnWij643hBlHgjjYk0kwx0Zmzlq2Otz40JdLwhdL/QAdNtF3E3WZ7TmzNN33r9Yr8ciitbXO4kSNaNub4uX5+RnJ2/mzlMcYe4Tcf1UsSWvJWUtT3Q+UcXMd2gazw1zEUhBqPbduNN3Z++sFHS1KjMMYdOB6jIIzVko//fkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319779; c=relaxed/simple;
	bh=6N4uvMY7D8xaPZUR9V+vmaJIzOoTGAbIFj3vSm3k5v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDeKCiKxfMvRyWecIIaCKiizI4JavZSfBErd5NYTuQaYa7E7kCcqBgNfkRtMDRBMYqFtyThhXbskykqcDdjP3ynxIB3ztKzIyIP8lEkzGBOknlW3kI7ObcFe8hRPl8YBci8XUY/ThIPpq0E//lB1ePpIdxmK1t3vcssxNwSLqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e030624d1so3476702a12.2;
        Fri, 05 Apr 2024 05:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319775; x=1712924575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3/nt0HPMXG8aoNmtG875gZ5EQW+1CWKXZLRdkC3kPU=;
        b=V5C4GIXIRw56D0ImrQTkZcwv2m5TbRVfNCjudC1po7aYdq26mIlBOfNZ1Cet1MERTN
         RU+a3v0b3fQaX+mGuF2Mb9n9Btu/envsFRLv2gA1ANQuY5WtuHsT+V7ypEDXPlSStCgx
         lso71Vagwbxgv0O3wujvEUUo5Gg1esQzYK5HRUE5aT1gtU44Uu+MB78NxXiZeI/eFJ8c
         kr3ZF7NrEVYIAezGoYZsN58R+zV/V+qqXptmvUymBnqfNeo+KlR6H8gO/0O9uMAfbIxM
         m/fMOjkNbvBzv9OHxYOlJ7byIKh5RDdmie4SAFwkDFpiFHQ3Exh0AcD1bk0IyfxWi6Q/
         mD0g==
X-Forwarded-Encrypted: i=1; AJvYcCVMGrPYJmgqBzEV3ZFRDMEC4jJd2miMGgqL+jJQ+ADXjAGv3frV2C6pn4du6gZNBsG/fjpiEnT5ScejiDjGIrhVp8eAKdLT8pDOUfxIh0flBvM5U29EcTZsEXFN/Vq2k1lk6/A3ijM=
X-Gm-Message-State: AOJu0YxtDWua57rQH/5tQCzCMDDG2Sc1M+OYfq+2X7wq1VhNkCTm3FL8
	R2XTIq+VZ/WiEnNs+9K4lzIlHekCZYuKAl0BdrSY6FWqEBJSJUmY
X-Google-Smtp-Source: AGHT+IGzns9AtViEj1GDmp1+cwDZ17HecKDitxqIN0xXVXQF2dM+Tu6JfhMb2iexyCWmd+mYOw+N+w==
X-Received: by 2002:a17:906:cf90:b0:a51:97df:16fb with SMTP id um16-20020a170906cf9000b00a5197df16fbmr1013435ejb.41.1712319775282;
        Fri, 05 Apr 2024 05:22:55 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id jt2-20020a170906dfc200b00a4e1aa345f6sm770369ejc.115.2024.04.05.05.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:22:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	ath11k@lists.infradead.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	imitsyanko@quantenna.com,
	geomatsi@gmail.com,
	kvalo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
Date: Fri,  5 Apr 2024 05:21:15 -0700
Message-ID: <20240405122123.4156104-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device shouldn't be embedded into any structure, instead,
the owner should use the private space to embed their state into
net_device.

This patch set fixes the problem above for ath10k and ath11k. This also
fixes the conversion of qtnfmac driver to the new helper.

This patch set depends on a series that is still under review:
https://lore.kernel.org/all/20240404114854.2498663-1-leitao@debian.org/#t

If it helps, I've pushed the tree to
https://github.com/leitao/linux/tree/wireless-dummy

PS: Due to lack of hardware, unfortunately all these patches are
compiled tested only.

Breno Leitao (3):
  wifi: qtnfmac: Use netdev dummy allocator helper
  wifi: ath10k: allocate dummy net_device dynamically
  wifi: ath11k: allocate dummy net_device dynamically

 drivers/net/wireless/ath/ath10k/core.c        |  9 ++++++--
 drivers/net/wireless/ath/ath10k/core.h        |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c         |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c        |  2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |  4 ++--
 drivers/net/wireless/ath/ath10k/usb.c         |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.c         |  9 ++++++--
 drivers/net/wireless/ath/ath11k/core.h        |  2 +-
 drivers/net/wireless/ath/ath11k/pcic.c        | 21 +++++++++++++++----
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  3 +--
 10 files changed, 39 insertions(+), 17 deletions(-)

-- 
2.43.0


