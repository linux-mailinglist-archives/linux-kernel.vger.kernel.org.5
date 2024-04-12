Return-Path: <linux-kernel+bounces-143060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04EB8A33AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839EA280E18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17914BF98;
	Fri, 12 Apr 2024 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbjFlzhK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C94149016;
	Fri, 12 Apr 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938847; cv=none; b=oieCjVv+iHj4YAULvcAUd+EAQNSEp+bgSy3aGiXcWd+/kMWjeRlR6M0BlwWZUkASKANi1TLi08uRlE3RhNwaG0r871D/4SoE9Lz7sBZNUN2GyUWyfolpQZ9oiOmK0zJotQfUhL2/4PLr5dJ5cc+4AIVs7nXlKwOoClxW9otcWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938847; c=relaxed/simple;
	bh=eBjAc1QnHYXLeH29VZzSz5/+O9flS8D/PAA7XN38YGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azOEOPqFClc+sqbPtjTV17Tzrx3+Bbn0qJzmSQO7sFw1rbxCTjv6VzxwkFAbiPO9ou6khVni+LawVQcbI82ow+zNLgzllQN5uIVmoF4RXcwJxnNtIbZHs1xigfk0mona/47RDIlfQlfPrUzd2KcDxhjzFTKsyYI+L8NSmHd+aHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbjFlzhK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so6444165e9.0;
        Fri, 12 Apr 2024 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712938844; x=1713543644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9/w1K727Z6rHmZvSAQJjGDlFmk/+J/GPSglkwvTa3A=;
        b=kbjFlzhKgbk5FpPPmnTjbo9Ch/Gs3Wr54taonDoymq/rKQ8zY1js+zRxqg7q+97YsC
         Yp0LXT1AYG5Jhh4/U5sgc9DU3VkX8zUZpCLusxGuOXcYFMRQIpJX5VcAfK4SjuK9+uTg
         67vy5il1bc1E3fhBMBXItDdhjrmsmYLNRgzv/8yHghkiIwdQifGW3fWXfOIPRlxt5N20
         gOx95cGXvlVGcBW9SovazbplGhJec081AvRLygjC9u6tYt2rTlOaiuhDAZ+8ztCIWC6A
         YW4yKOz9sxCIZBiQ1+grTnLtLRLIp2WzeXZi0SR+qljHnkTLi1PcA2bzAzCPoWDDxPLK
         yzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938844; x=1713543644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9/w1K727Z6rHmZvSAQJjGDlFmk/+J/GPSglkwvTa3A=;
        b=Qgqo0GHl8LNpMigtAqeSR/X3LYf/Wu9oJJyOGvmJmONIl5pWWAol04mkK80kFIORVj
         0hrBVk1lOGdwgWwTWSOZHNNEYrkNEqH+oz2OfI4MUl0rhTcranRbtzmA7ECeslC4AGYz
         K7Ds1BgZRiRVv3wRVq28J4GN5IJFrO3DWTzkvwsUisgZcVfjlEj5MJ3Vih5r9yEEOcKy
         yIQ+Xphvy7FRJSYWOWzD+UXxvfrM51faEIDF68QzrLMlwmCd5HgKCKqRgQmsC49YKUWj
         XMI0AMUh22xxwSa9Xj2OwuMWHiKHC2eNtOmS8z3by0w75UjVb59enUxCXeOz0jh+NrsM
         fLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVZEtyUkVTkVMjb38sRz/8NOgQsbbldDTCHQD3Gj3BvX9ranjxyPfZqp60g8Whw9eJDhlHILQ/BdCpWL12q+93Kl8OW8o80xDEMjjZw
X-Gm-Message-State: AOJu0YyhGBWAuYgHgmzQlt1fsHNY7N6mh655RxKhJKi6ZzxaLdkBh8rC
	UKEPrl8zLA7kGP1r7UAct3gFBdx0SZG6RtO+x4yLykvUtFyf4ecnj6MxEA==
X-Google-Smtp-Source: AGHT+IH5jjP1wWZqDpw0dAgvQx37euPxQow/bOtATu4l4TggXccRq7DHV2UiUHhygH26BwjvwOaSXQ==
X-Received: by 2002:a05:600c:1d2a:b0:415:4379:d36d with SMTP id l42-20020a05600c1d2a00b004154379d36dmr6090204wms.2.1712938843839;
        Fri, 12 Apr 2024 09:20:43 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id q10-20020a05600c2e4a00b00418176845ddsm126355wmf.0.2024.04.12.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:20:42 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.9-rc4
Date: Fri, 12 Apr 2024 18:20:27 +0200
Message-ID: <20240412162028.2447687-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc4

for you to fetch changes up to d3e0469306793972fd2b1ea016fa7ab0658c9849:

  MAINTAINERS: remove myself as a Reviewer for Ceph (2024-04-11 22:56:54 +0200)

----------------------------------------------------------------
Two CephFS fixes marked for stable and a MAINTAINERS update.

----------------------------------------------------------------
Jeff Layton (1):
      MAINTAINERS: remove myself as a Reviewer for Ceph

NeilBrown (1):
      ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Xiubo Li (1):
      ceph: switch to use cap_delay_lock for the unlink delay list

 MAINTAINERS          | 2 --
 fs/ceph/addr.c       | 4 +++-
 fs/ceph/caps.c       | 4 ++--
 fs/ceph/mds_client.c | 9 ++++-----
 fs/ceph/mds_client.h | 3 +--
 5 files changed, 10 insertions(+), 12 deletions(-)

