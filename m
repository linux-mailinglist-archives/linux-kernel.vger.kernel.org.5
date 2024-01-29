Return-Path: <linux-kernel+bounces-43586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC68415F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CA61F21D43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005495103E;
	Mon, 29 Jan 2024 22:47:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A54F5ED;
	Mon, 29 Jan 2024 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568444; cv=none; b=dvfMK4Ji5p7cTGi8I+u0SIM+UqLTX3rDQx9YIFlrPxQjtWV10laFjuUXzbM/lGf5dIMqg2Fjo4xLX+WIXJ4faaQrzFbS8GKH+x2TmbnmRakBg81xx9fxmZxGBj2gDR68Z40WLnTQA0olIpAGP54RcWDHb4Rht0xpzU+mnViB0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568444; c=relaxed/simple;
	bh=R4OVOUbiceKRowUYWDKLn08CPB0ttMYSVtdFdQCnOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc0SysI0NyRZGGPWRn9dlsT2Me/OrHO2gBmqnIeV5EvaQiW7vLIziM0VhZBHtzbTMAiYF2dUOYe1XEUvd1KXJexmTFpyNicXLZQnytr07TWtlFspOnHWeI2XJXITpHwaak5s5wewykZvASetJreAFP4Du+6qpfdDLh+bpYtzG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54F9C433C7;
	Mon, 29 Jan 2024 22:47:22 +0000 (UTC)
Date: Mon, 29 Jan 2024 17:47:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240129174732.1cea0d69@gandalf.local.home>
In-Reply-To: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
	<20240129120125.605e97af@gandalf.local.home>
	<CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
	<CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
	<CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:35:37 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And I hope there aren't any other stupid things I missed like that.

Well the preliminary tests pass with this added to your patch:

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index cd6de3244442..ad11063bdd53 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -230,7 +230,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 
-	mutex_lock(&eventfs_mutex);
 	do {
 		// The parent is stable because we do not do renames
 		dentry = dentry->d_parent;
@@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		}
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-	mutex_unlock(&eventfs_mutex);
 
 	update_top_events_attr(ei, dentry->d_sb);
 
@@ -324,7 +322,7 @@ static struct dentry *lookup_file(struct dentry *dentry,
 	ti->flags = TRACEFS_EVENT_INODE;
 	ti->private = NULL;			// Directories have 'ei', files not
 
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
 	return eventfs_end_creating(dentry);
 };
@@ -365,7 +363,7 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
         ei->dentry = dentry;	// Remove me!
 
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	return eventfs_end_creating(dentry);

-- Steve

