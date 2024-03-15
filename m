Return-Path: <linux-kernel+bounces-104635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5736987D153
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6891F21EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886D45034;
	Fri, 15 Mar 2024 16:44:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD93C063
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521051; cv=none; b=jmIsWvSwYlDEtGHQhjExTpYMgp99rAOFfsak2INbhD8u1WRLziYCZ3RcBAasHxge+P+dzyz4eGhHWheK28pUcJHe5/tzsIVZwJnXVL5wz05QilcEM/1iA26BwkvtEFpkPqcNDqMj1y7+1OajbGE/iI52ms4UbDny21D99b/URMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521051; c=relaxed/simple;
	bh=z26HhC/QeuuTokuBDRou2ojzG4UKGZ91RC1V1k5EBC8=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kzDrVdn4d4a9ybMbEyQ1ctpkUZvxt7ylLAV2/vzWyC0Mh3dgdLzTYcmuf92INuWZ9tDcXocODJ6cmxUjC51L3ZXoopFG7RizWDM9yyEc6IwLtaW4XAIEIU78jNs7IYTBgV+arTDuAomlYTZTQbLK1MQHh+/xg02lkW/0+vZfAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391EAC433F1;
	Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rlAhN-000000033G4-0Ir1;
	Fri, 15 Mar 2024 12:46:25 -0400
Message-ID: <20240315164601.705819502@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Mar 2024 12:46:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/2] ktest: Updates for v6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


ktest updates for v6.9:

- Allow variables to contain variables. This makes the shell commands
  have a bit more flexibility to reuse existing variables.

- Have make_warnings_file in build-only mode require limited variables

  The make_warnings_file test will create a file with all existing
  warnings (which can be used to compare against in builds with
  new commits). Add it to the build-only list that doesn't require
  other variables (like how to reset a machine), as the make_warnings_file
  makes the most sense on build only tests.

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Steven Rostedt (1):
      ktest.pl: Process variables within variables

----
 tools/testing/ktest/ktest.pl | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

