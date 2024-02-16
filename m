Return-Path: <linux-kernel+bounces-69081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2F858440
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC462839BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648D132C29;
	Fri, 16 Feb 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKCfSaKb"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D219ED;
	Fri, 16 Feb 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105039; cv=none; b=DG5EXsv3xTyj0k9CDpSRzqAe3dHSKpcbVy6ZaVefYYhftv6f1Alo+y/bLtKAvUmitIJBvRFHd2bJdT+tYhg1uxK5xWyGLi/5e/PX+jacy0MLdxfkGkLXCQ/fd0PYeiRQPrRWMQ7od60O4xjuFfXQU1W17IDhER9Oqlb4+6bYB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105039; c=relaxed/simple;
	bh=K3ILZL73XsaCWQJVqqLCkkb+Rz4ec5sI85BBccikSU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LGX4v+SzWe5v2s3OchKqn7i2xmCtoi/tDJHrL7S0Yqq385I6fVk64TdF4FJEUQ+zkaeyNnQb0yNQKUkM+wBbloWCzr3PT07/RBUJIoHkPxgGb08zX5ZNmSb1aGjx87myf8aWVeWeHA9BpTUxhGsszqB4MkdFXiWAgFDzwE4zgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKCfSaKb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d26da3e15so188740f8f.1;
        Fri, 16 Feb 2024 09:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708105036; x=1708709836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PL5pjz0aQhfCwh8cDYpS+9GgpPQ8XWmRdLVnQ4KRRE=;
        b=NKCfSaKbl0BI6vej5f0CeS/QqE/B4BWPDXFVgbO+UU3gAOeGgZ4n8jyLofBCIe+PqR
         I4sNjgwYslIfCtFyim6YGjTTOg4EeFzCL+65t7bgpRwXpf1yEip8t6Ra7Z1+U1cexew4
         bI/G3LrUxa9dpiFJAbHfGC5uBrm0P9gKC87FCkBKqxjgJ6pvehb0FaMfzsGzShpC6p8C
         YQRX3Gqi3/muMV0wiEKpPPfLknt5Z04dFlj3rkwUuWJ+kDRGOlsEJ5WUcF5GSqMhny/D
         aF+zQ6iuqwkFVm9KrjXi0I4kJUAzK5AXAZ3HhEPw5DBbGyP04RGy3NC7NGlF4zDKyQAn
         5ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708105036; x=1708709836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PL5pjz0aQhfCwh8cDYpS+9GgpPQ8XWmRdLVnQ4KRRE=;
        b=B9NiXMy4wITj58HLSBIRcsGfQ2GvEOI5z/a+K1PhkJBvFLeTdmE02WQP1lAxrk5dZ+
         vNLfIf2WJZbo3bwamdK7haPchgYbX9Vh0hnByWI84TnLnLvOm78JR/Uqq+qT1QloXbDv
         EwhaBMjE9ZYJt1TbAvPhebpGgkl30QEkLwcIuoEfYrjsNAxB50KgZngj/P3jUIQnlNJR
         vh8u3QsOqdpA8hqUa/SFEOAVCWZlFESGTzIwQtonScG89w3pUD39QvM7n5TVTEb7r4ps
         CDiC6YMlibEp6zHCVERJxH6sZy7METpJmpPtGEfyU8zcizo5jwEmG1Kzw9KwStvmoykF
         IzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuu/bx9VxQCZ787Z6lERM4MiiZ8L/KydYRPXqG0iJQQmqIk9ev6kqLr0jQBI2uV8DhZ1JU6y9tKJfvSMXc6gXFEEKzD8j8oYrlvxe/
X-Gm-Message-State: AOJu0YwYt0snruea+iuoE9fieFwpXEN/t/aYf4WrOYO/RWEsA5D1S6Fi
	G8U3au0c1K0MifbO1h0w+rmniFAsBNFLF/m3G08DjGF9OhNJeR73EirTNu0a
X-Google-Smtp-Source: AGHT+IE4Pg4KOZFCvGbz9RS6Hr8h5JfxjxLesAYKmccGoAykkWg5lkM4U9fXR0qhVQka1c1+7hYq1Q==
X-Received: by 2002:a5d:6f19:0:b0:33d:2779:442a with SMTP id ay25-20020a5d6f19000000b0033d2779442amr570329wrb.9.1708105035546;
        Fri, 16 Feb 2024 09:37:15 -0800 (PST)
Received: from zambezi.redhat.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d5141000000b0033ce3311805sm2755864wrt.10.2024.02.16.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:37:14 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.8-rc5
Date: Fri, 16 Feb 2024 18:37:02 +0100
Message-ID: <20240216173705.1837988-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.8-rc5

for you to fetch changes up to dbc347ef7f0c53aa4a5383238a804d7ebbb0b5ca:

  ceph: add ceph_cap_unlink_work to fire check_caps() immediately (2024-02-13 11:22:54 +0100)

----------------------------------------------------------------
Additional cap handling fixes from Xiubo to avoid "client isn't
responding to mclientcaps(revoke)" stalls on the MDS side.

----------------------------------------------------------------
Xiubo Li (2):
      ceph: always queue a writeback when revoking the Fb caps
      ceph: add ceph_cap_unlink_work to fire check_caps() immediately

 fs/ceph/caps.c       | 65 ++++++++++++++++++++++++++++++++--------------------
 fs/ceph/mds_client.c | 48 ++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  5 ++++
 3 files changed, 93 insertions(+), 25 deletions(-)

