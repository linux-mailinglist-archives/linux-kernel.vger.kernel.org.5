Return-Path: <linux-kernel+bounces-35262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BABC838ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B781B28896E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0005EE87;
	Tue, 23 Jan 2024 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZevWN0+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4C5C909
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014315; cv=none; b=Ue6zFEyBNAWNMlqK/nZiKJ2aAP+po+iI7V92W/3uLb4qpz2fCogBhNuR5/7ChiVYxIMFxWXv2NxHHguMz6zCEx57oZYIugRqk1nadvlXmQt19K2wpiwJbV9+wCq5ALFeV8oi5HjMT1GSDy8gjeYH0gY+qKZqBdtqZkv6RYZ+txQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014315; c=relaxed/simple;
	bh=sax3ws7XUZKyWXxJBC7b3ZD6Aa6CF5mlJzTwof2xdms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TOhtaxZuduvyTYa5lTfNLiDnj0EVlqCMOuwMAJTZUe5BQdLuuyhlIk5NgyQvQfGFhKlbsGipD3GaI0CgqJyzKcoBYUjP5F5dYGr6BGoZXrlffgIfWNnMtn77vR96qO8ksLznbGNiwm9PFOZAcp5/D47LJ/tPIxPyvPcoJtN8z+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZevWN0+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17638C433C7;
	Tue, 23 Jan 2024 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706014315;
	bh=sax3ws7XUZKyWXxJBC7b3ZD6Aa6CF5mlJzTwof2xdms=;
	h=From:To:Cc:Subject:Date:From;
	b=ZevWN0+iPQKKsn7lg02tsr18gh7ODMTlRGsilAwxwAsFItbLISX5tvqQeCEEwREqQ
	 FvA+stW9oaTkC4+C2m5eRqxEkZbRqQqgP7YBlQrnbWsD/X7ZxLvg4sxa4TH+AvI3FZ
	 BWFqHZVn7BQvbUeQvqkCwA4BiASl9RlRvYP9ze78nE5UJBcxi+HzxpWgibqQviTKO7
	 LFR+dgr3egejb0YxOO59CMtsLgRh4FVBx7DyKnINJZbkZ6cPnSr8aU/3YxkjfgGL3b
	 P7NoDEkAuFd+TZUh6cV+vjmfUBRk1owGP0fKfXNowMRhgzI+wlTHgNgHDzMOqWjg/m
	 CfyXW76vbZcbw==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: udbg_memcons: mark functions static
Date: Tue, 23 Jan 2024 13:51:41 +0100
Message-Id: <20240123125148.2004648-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

ppc64_book3e_allmodconfig has one more driver that triggeres a
few missing-prototypes warnings:

arch/powerpc/sysdev/udbg_memcons.c:44:6: error: no previous prototype for 'memcons_putc' [-Werror=missing-prototypes]
arch/powerpc/sysdev/udbg_memcons.c:57:5: error: no previous prototype for 'memcons_getc_poll' [-Werror=missing-prototypes]
arch/powerpc/sysdev/udbg_memcons.c:80:5: error: no previous prototype for 'memcons_getc' [-Werror=missing-prototypes]

Mark all these function static as there are no other users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/sysdev/udbg_memcons.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/udbg_memcons.c b/arch/powerpc/sysdev/udbg_memcons.c
index 5020044400dc..4de57ba52236 100644
--- a/arch/powerpc/sysdev/udbg_memcons.c
+++ b/arch/powerpc/sysdev/udbg_memcons.c
@@ -41,7 +41,7 @@ struct memcons memcons = {
 	.input_end = &memcons_input[CONFIG_PPC_MEMCONS_INPUT_SIZE],
 };
 
-void memcons_putc(char c)
+static void memcons_putc(char c)
 {
 	char *new_output_pos;
 
@@ -54,7 +54,7 @@ void memcons_putc(char c)
 	memcons.output_pos = new_output_pos;
 }
 
-int memcons_getc_poll(void)
+static int memcons_getc_poll(void)
 {
 	char c;
 	char *new_input_pos;
@@ -77,7 +77,7 @@ int memcons_getc_poll(void)
 	return -1;
 }
 
-int memcons_getc(void)
+static int memcons_getc(void)
 {
 	int c;
 
-- 
2.39.2


