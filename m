Return-Path: <linux-kernel+bounces-54890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12184B4D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93FA1F25D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE11384BC;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B4135A64;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221360; cv=none; b=eE1bhT2EqQggs58ogRq5zD55BAaUNLeyL8EN1lxOO6qW1HQ7Y5EUfSVAPueDk6yX53yB+He1cTME8jP5hHnpKR8HEpf1WplwXBxSUJlSkI71oGykFMFFIS2I3CPsmmnBWGvTTVM0uWGbGRnVZCu558hcsHM1gxWAgjSuBncyB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221360; c=relaxed/simple;
	bh=mublhVt1iAiu6WhkAvGlLcWbK2KJ7BEzK+6N7+17uqU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dY+2rUO2sOP1geTx8+ifAFzwgd4xSEcrpGrpMILQl3RRtdGZFy7xcUp1pJRqr6vmXr6ZG4Uwggk5nXl2qYZqwD9B9/YyVd6i2Y1d8N44g1H38i9+5kK2Ubvo/jW4NFH0eXYEdvCd2/fZg4t03puKA0tm6EwXhWYPOnzmNVHCp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3408BC433F1;
	Tue,  6 Feb 2024 12:09:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGq-00000006b7q-2fVT;
	Tue, 06 Feb 2024 07:09:48 -0500
Message-ID: <20240206120948.496559787@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 13/57] eventfs: Fix typo in eventfs_inode union comment
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It's eventfs_inode not eventfs_indoe. There's no deer involved!

Link: https://lore.kernel.org/linux-trace-kernel/20231024131024.5634c743@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit 29e06c10702e81a7d0b75020ca514d2f2962704a)
---
 fs/tracefs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 298d3ecaf621..64fde9490f52 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -37,7 +37,7 @@ struct eventfs_inode {
 	/*
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
-	 * @rcu:	eventfs_indoe to delete in RCU
+	 * @rcu:	eventfs_inode to delete in RCU
 	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
-- 
2.43.0



