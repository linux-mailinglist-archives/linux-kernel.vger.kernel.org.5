Return-Path: <linux-kernel+bounces-12557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3281F6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEC61F22606
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F54363D6;
	Thu, 28 Dec 2023 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSXtzzPB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F311613C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9bc8939d0so1025613b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703758543; x=1704363343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXTkOgJPfVQI5vG1o+5LiyjL5egXWPndcvQFG/dAUGo=;
        b=LSXtzzPBNM6M2exlEzHep0a34JQmuKBB2Uu9B6vHXXsBJpYlXR8JdFMYY/o8j9jgBC
         QIi9eYNXP9IsIhvG4Mr+jBWz+ESE+Pa79ShEIjPUsV3hUzRKA+5uKOfyd0y9xU8ECZg9
         4CMMGjf0uLZsBuB60ENLFrQhFvv4vSaeCvxadJkBAEhT/D1XiSNfYrz0vPIMqNfhdf9O
         OJpnvBPV1zPwuX8WBEeVSW8H3xtCk4Qb+3/aDUoQssGnAJUyBW7u4cj5+nP4D39wNcW9
         hQNgud0ocsbHJG9gs7lmUWkmKibk8ZSIIMmtLY5iCkIXIiAOkZQKmBTxfODGlmoaCtRX
         gYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703758543; x=1704363343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXTkOgJPfVQI5vG1o+5LiyjL5egXWPndcvQFG/dAUGo=;
        b=jLDjbed6akcGpHmHk8ESs/1/Q5RARl+pr1H5ol1tbrNVMbPv1kmJqCK8GeFKT8lKiY
         Y8l2mH2hHhoFamtTLkAv1iu/Za8/WbvinKxzLDOFyAYwtr7BCZA0SeB4/TA/MzyzWkPi
         Q11PMnqO0HB8/tcDBGxoHFqR+zv/7zHQzJegtH//mz40AP7SA4i5CZ9QAwc2taUIEood
         PcpzmRgT/lqzZaBiUxZQOACjvTEa3RYSE+OBZ6xYltnGOU4EUL6i9IM10dMSFvyFI2w9
         7T2Qo0JQNqmnaQKXA5jtA5KMKueMmIoTZzASupvopgjyrCOMEd3sYIfMtYAv2vbaXIhC
         I+rQ==
X-Gm-Message-State: AOJu0YxzbKSU0Q9SKfUcZ2gsmZbwQohJ5L38DSymPoMlhvqg/qjhhtKy
	x+Ryhh1v+3xqiKW8JZR0kfw=
X-Google-Smtp-Source: AGHT+IEONUPNn4h8LWIhAs9KtyKLEahLLk7SOBfPE+iZhkSuQrCxxUDZ7IeQKl4A0zjWGWy6KhjPiA==
X-Received: by 2002:a05:6a21:3294:b0:190:5e28:ad52 with SMTP id yt20-20020a056a21329400b001905e28ad52mr5152269pzb.67.1703758543460;
        Thu, 28 Dec 2023 02:15:43 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.78])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001d3b7c5776asm13597207plb.160.2023.12.28.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 02:15:43 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: mahesh@linux.ibm.com,
	oohall@gmail.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix typos, grammatical errors and add units of function param
Date: Thu, 28 Dec 2023 15:45:17 +0530
Message-Id: <cover.1703756365.git.ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes spelling mistake in the word "auxillary",
fixes a grammatical error related to full stop and adds the units
of the size param in the description of eeh_set_pe_aux_size function.

Ghanshyam Agrawal (3):
  powerpc/eeh: Fix spelling of the word "auxillary"
  powerpc/eeh: Add full stop to fix a grammatical error
  powerpc/eeh: Add the units of size param in the description

 arch/powerpc/include/asm/eeh.h | 2 +-
 arch/powerpc/kernel/eeh_pe.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1


