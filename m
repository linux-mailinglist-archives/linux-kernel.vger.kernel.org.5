Return-Path: <linux-kernel+bounces-73811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0792485CBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E0F1C21E33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D862F154455;
	Tue, 20 Feb 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGq0h9Rz"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A076C99
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471077; cv=none; b=AkjueHQyiXP3aZTHBd7yDwCQyc9qf74tIXPJROi2X/20Y1CSKVb3gLU+VvX1hciaMS+lbAUStGro/MFKA6A+jc/Lj8ZxwD/nbJMR91s/TpE0ocyJ3XGgaH+3DodHnSRGmL/aPBnIlpxa3iefjM3FJZqUwdEwQVCg1vTXlMjXkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471077; c=relaxed/simple;
	bh=3oxOrolpFav1lXDBdahABpOqzElyqu/oXG1o5ff2lNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0jOMiPYW28bWvoG4jamgDJIO2hAm4+rcvI4NfQjoupOKAE5ciIILqqNcwCOPi8cQ/WQQgl1UsHlj+SF4jGYe/w2YwIsegS9Rzrb0I7Ym6FBG8HFnXUKXHXGDAbtCU0qfPqBaYc6yek55KlFJucDN+i9nTeMPkR4q7ISWS7mqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGq0h9Rz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4625306a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471075; x=1709075875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEImZ5lR83XSeffxFdtCU6Dhfg9WnM4aetn6qhHi+JM=;
        b=DGq0h9RzlVTPu4eBcz7Fgi167rNXPPs3zsWGvqS18JgaU1tx+Z0ms5z/W2mdI1T8gM
         rYytreIOg7e525cFPskU0dFZQOScw77QZtCvKOt993zabRL3RQaShNGBeNuq9TvjZGLd
         KTjagPkFXhTVvuGrzv48PXhPPYs8MUFpB+hEbkfXEn03BIbdiUQeHWzTOcyViwk3XVqY
         FT+65C2WxcqLD7ynYxQ4k4vYOuo9iVp+aw8TlQ6vDPqsnRVoIE7cd4Q9nL3m4cclnlaQ
         aUMUPf4o2pZXLUDb3kTZBAf5Mf48Uv5fTLfvGJ2Lck60ClXo5x60hAIfeyIYCS1pLlmK
         ZnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471075; x=1709075875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEImZ5lR83XSeffxFdtCU6Dhfg9WnM4aetn6qhHi+JM=;
        b=A3mnJgb3Yn7ASrOn7FsPP7pjKHcKRKArtQp8ETICawY2pfgRXismQqPejCxuh7PD88
         UK8zthR4ZRI6mzEXaJaVL59dQOLmLIepbmzzxN+eLj23LTH42N8qhSeRcEVGyOHRcpZM
         Z9zT7CtoTduZ37hCOtkD6G7y2m7apm0a4lT0ne8U2YfKLxPPmvDW67zY/xQhNVnejOYB
         qG/wAB4srArkjuGSF5YdWWFxp9FH5xUGfV47K0GlrRPseK6ya9xhYbVO1zlHC+XfLFUb
         JZ3RZW0CrTfZIDH1eDhoTvzgKVnML1NZhO3Tq/TrHir503yrcPeSuejJ30ji8DLXXCVK
         bXgw==
X-Gm-Message-State: AOJu0YzYPnob6cZCgG0vMUJaP052K6VIC92RqSVcvkCicb+8JVt2TShg
	tSYMBnZG5Hn++Q86kmW9ql/HSnV11JqUJrD5un9LKpI3tCWnOoGd
X-Google-Smtp-Source: AGHT+IGdkoBjMO3yErySlst0UzSsbUfTU42KzY543kxPwJ0g9QNSMF96r+yoYH8Jwu21RRzPwGXCUA==
X-Received: by 2002:a05:6a20:869d:b0:19e:cdaa:83a3 with SMTP id k29-20020a056a20869d00b0019ecdaa83a3mr13296774pze.30.1708471075036;
        Tue, 20 Feb 2024 15:17:55 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id x16-20020aa784d0000000b006e13a5ab1e5sm5317803pfn.73.2024.02.20.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:17:54 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/3] Handle hugetlb faults under the VMA lock
Date: Tue, 20 Feb 2024 15:14:21 -0800
Message-ID: <20240220231424.126600-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is generally safe to handle hugetlb faults under the VMA lock. The
only time this is unsafe is when no anon_vma has been allocated to this
vma yet, so we can use vmf_anon_prepare() instead of anon_vma_prepare()
to bailout if necessary. This may only happen for the first non-shared
hugetlb page in the vma.

-----
The last patch in this series may cause ltp hugemmap10 to "fail". This
is expected behavior - see the commit message for patch 3 in this series.
The rest of the ltp hugetlb tests pass.

This patchset applies cleanly ontop of mm-unstable.

Vishal Moola (Oracle) (3):
  mm/memory: Change vmf_anon_prepare() to be non-static
  hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
  hugetlb: Allow faults to be handled under the VMA lock

 include/linux/hugetlb.h |  1 +
 mm/hugetlb.c            | 33 +++++++++++++++++++++------------
 mm/memory.c             |  2 +-
 3 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.43.0


