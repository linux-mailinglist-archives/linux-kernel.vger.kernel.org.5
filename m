Return-Path: <linux-kernel+bounces-78559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDE861505
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4361C203BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3221364;
	Fri, 23 Feb 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJrTlg4Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29965B1F4;
	Fri, 23 Feb 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700404; cv=none; b=BRGdZpjru44PMYlkXGjEZno9Cb/SseqxefycKxMpnvgEOoz3jqBYyxOBIJTVvazy4oPgYpRFkd+58MAP/vNu4PvLLgwgLCHxhxwnOkVDuTDj5LZe/w/mY9XhtbZKuU6tkfAcMB3OBLY8y+lEFlAyD2it0IgpAaJh/il5cWKR904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700404; c=relaxed/simple;
	bh=hEvWxmJoI4SwZiEsJlf+y4dS3IVdXbZRwwgQK9fy+kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/nKJkFvclDIjFaI7RO9GDLNYKWvFSrPk+PhqttDZz0O1wwIu4P3MCKXbtNznPZ4VApu6VTpybz2xEXlsWow6B/IGPk8T/6ZNQja66p2s6yaiXwx8KPczqJl8PaUeG7V8d6PR2UegxA0f9Ve7F+IMV+UUDGgVk6coIGP55NjSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJrTlg4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01851C433F1;
	Fri, 23 Feb 2024 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708700403;
	bh=hEvWxmJoI4SwZiEsJlf+y4dS3IVdXbZRwwgQK9fy+kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJrTlg4YwOZXON1yNO1dp0yimr9cqO02rIfb4EmD5bDsw5upHbBreWnjcQ4vqy6CP
	 Nc5d+eDn7uxc0E+2KI6vSaGQ3g8OTnAVnWWXbo0jaU2s3oLGDp6mlk6Mg8vhAQtBhP
	 JvNqADlLE1GucVFCn8HL7lN9bS+PSgnNVpWVcZLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.210
Date: Fri, 23 Feb 2024 15:59:50 +0100
Message-ID: <2024022350-linguini-shawl-3f3c@gregkh>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024022350-lint-rascal-031e@gregkh>
References: <2024022350-lint-rascal-031e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 978b76358661..40d5aab8452d 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_cpus
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_cpus
 Date:		March 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -8,7 +8,7 @@ Description:
 		network device queue. Possible values depend on the number
 		of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_flow_cnt
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_flow_cnt
 Date:		April 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -16,7 +16,7 @@ Description:
 		Number of Receive Packet Steering flows being currently
 		processed by this particular network device receive queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_timeout
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_timeout
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -24,7 +24,7 @@ Description:
 		Indicates the number of transmit timeout events seen by this
 		network interface transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_maxrate
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
 Date:		March 2015
 KernelVersion:	4.1
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		A Mbps max-rate set for the queue, a value of zero means disabled,
 		default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_cpus
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_cpus
 Date:		November 2010
 KernelVersion:	2.6.38
 Contact:	netdev@vger.kernel.org
@@ -42,7 +42,7 @@ Description:
 		network device transmit queue. Possible vaules depend on the
 		number of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_rxqs
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_rxqs
 Date:		June 2018
 KernelVersion:	4.18.0
 Contact:	netdev@vger.kernel.org
@@ -53,7 +53,7 @@ Description:
 		number of available receive queue(s) in the network device.
 		Default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -62,7 +62,7 @@ Description:
 		of this particular network device transmit queue.
 		Default value is 1000.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -70,7 +70,7 @@ Description:
 		Indicates the number of bytes (objects) in flight on this
 		network device transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -79,7 +79,7 @@ Description:
 		on this network device transmit queue. This value is clamped
 		to be within the bounds defined by limit_max and limit_min.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -88,7 +88,7 @@ Description:
 		queued on this network device transmit queue. See
 		include/linux/dynamic_queue_limits.h for the default value.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-class-net-statistics b/Documentation/ABI/testing/sysfs-class-net-statistics
index 55db27815361..53e508c6936a 100644
--- a/Documentation/ABI/testing/sysfs-class-net-statistics
+++ b/Documentation/ABI/testing/sysfs-class-net-statistics
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/statistics/collisions
+What:		/sys/class/net/<iface>/statistics/collisions
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Indicates the number of collisions seen by this network device.
 		This value might not be relevant with all MAC layers.
 
-What:		/sys/class/<iface>/statistics/multicast
+What:		/sys/class/net/<iface>/statistics/multicast
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -14,7 +14,7 @@ Description:
 		Indicates the number of multicast packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/rx_bytes
+What:		/sys/class/net/<iface>/statistics/rx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -23,7 +23,7 @@ Description:
 		See the network driver for the exact meaning of when this
 		value is incremented.
 
-What:		/sys/class/<iface>/statistics/rx_compressed
+What:		/sys/class/net/<iface>/statistics/rx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		network device. This value might only be relevant for interfaces
 		that support packet compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/rx_crc_errors
+What:		/sys/class/net/<iface>/statistics/rx_crc_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -41,7 +41,7 @@ Description:
 		by this network device. Note that the specific meaning might
 		depend on the MAC layer used by the interface.
 
-What:		/sys/class/<iface>/statistics/rx_dropped
+What:		/sys/class/net/<iface>/statistics/rx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -51,7 +51,7 @@ Description:
 		packet processing. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_errors
+What:		/sys/class/net/<iface>/statistics/rx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -59,7 +59,7 @@ Description:
 		Indicates the number of receive errors on this network device.
 		See the network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/rx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -68,7 +68,7 @@ Description:
 		network device. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_frame_errors
+What:		/sys/class/net/<iface>/statistics/rx_frame_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -78,7 +78,7 @@ Description:
 		on the MAC layer protocol used. See the network driver for
 		the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_length_errors
+What:		/sys/class/net/<iface>/statistics/rx_length_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -87,7 +87,7 @@ Description:
 		error, oversized or undersized. See the network driver for the
 		exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_missed_errors
+What:		/sys/class/net/<iface>/statistics/rx_missed_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -96,7 +96,7 @@ Description:
 		due to lack of capacity in the receive side. See the network
 		driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_nohandler
+What:		/sys/class/net/<iface>/statistics/rx_nohandler
 Date:		February 2016
 KernelVersion:	4.6
 Contact:	netdev@vger.kernel.org
@@ -104,7 +104,7 @@ Description:
 		Indicates the number of received packets that were dropped on
 		an inactive device by the network core.
 
-What:		/sys/class/<iface>/statistics/rx_over_errors
+What:		/sys/class/net/<iface>/statistics/rx_over_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -114,7 +114,7 @@ Description:
 		(e.g: larger than MTU). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_packets
+What:		/sys/class/net/<iface>/statistics/rx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -122,7 +122,7 @@ Description:
 		Indicates the total number of good packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/tx_aborted_errors
+What:		/sys/class/net/<iface>/statistics/tx_aborted_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -132,7 +132,7 @@ Description:
 		a medium collision). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_bytes
+What:		/sys/class/net/<iface>/statistics/tx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -143,7 +143,7 @@ Description:
 		transmitted packets or all packets that have been queued for
 		transmission.
 
-What:		/sys/class/<iface>/statistics/tx_carrier_errors
+What:		/sys/class/net/<iface>/statistics/tx_carrier_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -152,7 +152,7 @@ Description:
 		because of carrier errors (e.g: physical link down). See the
 		network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_compressed
+What:		/sys/class/net/<iface>/statistics/tx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -161,7 +161,7 @@ Description:
 		this might only be relevant for devices that support
 		compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/tx_dropped
+What:		/sys/class/net/<iface>/statistics/tx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -170,7 +170,7 @@ Description:
 		See the driver for the exact reasons as to why the packets were
 		dropped.
 
-What:		/sys/class/<iface>/statistics/tx_errors
+What:		/sys/class/net/<iface>/statistics/tx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -179,7 +179,7 @@ Description:
 		a network device. See the driver for the exact reasons as to
 		why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/tx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -188,7 +188,7 @@ Description:
 		FIFO error. See the driver for the exact reasons as to why the
 		packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_heartbeat_errors
+What:		/sys/class/net/<iface>/statistics/tx_heartbeat_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -197,7 +197,7 @@ Description:
 		reported as heartbeat errors. See the driver for the exact
 		reasons as to why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_packets
+What:		/sys/class/net/<iface>/statistics/tx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -206,7 +206,7 @@ Description:
 		device. See the driver for whether this reports the number of all
 		attempted or successful transmissions.
 
-What:		/sys/class/<iface>/statistics/tx_window_errors
+What:		/sys/class/net/<iface>/statistics/tx_window_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index dccd61c7c5c3..193c22687851 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,13 +22,16 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
-parent and finds source and target.  We lock both (provided they exist).  If we
-need to lock two inodes of different type (dir vs non-dir), we lock directory
-first.  If we need to lock two inodes of the same type, lock them in inode
-pointer order.  Then call the method.  All locks are exclusive.
-NB: we might get away with locking the source (and target in exchange
-case) shared.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks
+the parent and finds source and target.  Then we decide which of the
+source and target need to be locked.  Source needs to be locked if it's a
+non-directory; target - if it's a non-directory or about to be removed.
+Take the locks that need to be taken, in inode pointer order if need
+to take both (that can happen only when both source and target are
+non-directories - the source because it wouldn't be locked otherwise
+and the target because mixing directory and non-directory is allowed
+only with RENAME_EXCHANGE, and that won't be removing the target).
+After the locks had been taken, call the method.  All locks are exclusive.
 
 5) link creation.  Locking rules:
 
@@ -44,20 +47,17 @@ rules:
 
 	* lock the filesystem
 	* lock parents in "ancestors first" order. If one is not ancestor of
-	  the other, lock them in inode pointer order.
+	  the other, lock the parent of source first.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* Lock both the source and the target provided they exist. If we
-	  need to lock two inodes of different type (dir vs non-dir), we lock
-	  the directory first. If we need to lock two inodes of the same type,
-	  lock them in inode pointer order.
+	* Lock subdirectories involved (source before target).
+	* Lock non-directories involved, in inode pointer order.
 	* call the method.
 
-All ->i_rwsem are taken exclusive.  Again, we might get away with locking
-the source (and target in exchange case) shared.
+All ->i_rwsem are taken exclusive.
 
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
@@ -67,6 +67,7 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
+[XXX: will be updated once we are done massaging the lock_rename()]
 	First of all, at any moment we have a linear ordering of the
 	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
         of A and ptr(A) < ptr(B)).
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531..fbd695d66905 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -95,7 +95,7 @@ symlink:	exclusive
 mkdir:		exclusive
 unlink:		exclusive (both)
 rmdir:		exclusive (both)(see below)
-rename:		exclusive (all)	(see below)
+rename:		exclusive (both parents, some children)	(see below)
 readlink:	no
 get_link:	no
 setattr:	exclusive
@@ -113,6 +113,9 @@ tmpfile:	no
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
 	exclusive on victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
+	involved.
+	->rename() has ->i_rwsem exclusive on any subdirectory that changes parent.
 
 See Documentation/filesystems/directory-locking.rst for more detailed discussion
 of the locking scheme for directory operations.
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 867036aa90b8..0a2d29d84419 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -865,3 +865,21 @@ no matter what.  Everything is handled by the caller.
 
 clone_private_mount() returns a longterm mount now, so the proper destructor of
 its result is kern_unmount() or kern_unmount_array().
+
+---
+
+**mandatory**
+
+If ->rename() update of .. on cross-directory move needs an exclusion with
+directory modifications, do *not* lock the subdirectory in question in your
+->rename() - it's done by the caller now [that item should've been added in
+28eceeda130f "fs: Lock moved directories"].
+
+---
+
+**mandatory**
+
+On same-directory ->rename() the (tautological) update of .. is not protected
+by any locks; just don't do it if the old parent is the same as the new one.
+We really can't lock two subdirectories in same-directory rename - not without
+deadlocks.
diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 8e44107933ab..c3154ce6e1b2 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -234,7 +234,7 @@ corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
 ::
 
-  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
+  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 This can be used to merge to signal paths together in software.
 
diff --git a/Makefile b/Makefile
index 613b25d330b0..6e9ee164b9df 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 209
+SUBLEVEL = 210
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index d186b93144e3..525618197197 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -464,6 +464,14 @@ vtcam_reg: LDO12 {
 				regulator-name = "VT_CAM_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				/*
+				 * Force-enable this regulator; otherwise the
+				 * kernel hangs very early in the boot process
+				 * for about 12 seconds, without apparent
+				 * reason.
+				 */
+				regulator-always-on;
 			};
 
 			vcclcd_reg: LDO13 {
diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index 5833fb6f15d8..2c817c4a4c68 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -65,7 +65,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <4>;
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index 77b21aa7a146..27e72b07b517 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -45,7 +45,7 @@ &weim {
 	pinctrl-0 = <&pinctrl_weim>;
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 9b940987864c..8d6e900a9081 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -268,9 +268,12 @@ weim: weim@220000 {
 			status = "disabled";
 		};
 
-		esram: esram@300000 {
+		esram: sram@300000 {
 			compatible = "mmio-sram";
 			reg = <0x00300000 0x20000>;
+			ranges = <0 0x00300000 0x20000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 46057d9bf555..c2efcc20ae80 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -175,10 +175,8 @@ i2c-0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@ i2c-1 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index ce3d6360a7ef..b236d23f8071 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -414,7 +414,7 @@ emi@80020000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx23-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <7 5 9 26
diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index 0703f62d10d1..93a6e4e680b4 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -27,7 +27,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 7d4301b22b90..1ed3fb7b9ce6 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -16,7 +16,7 @@ cmo_qvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&qvga_timings>;
-			qvga_timings: 320x240 {
+			qvga_timings: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
index 80a7f96de4c6..64b2ffac463b 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
@@ -16,7 +16,7 @@ dvi_svga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_svga_timings>;
-			dvi_svga_timings: 800x600 {
+			dvi_svga_timings: timing0 {
 				clock-frequency = <40000000>;
 				hactive = <800>;
 				vactive = <600>;
diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
index 24027a1fb46d..fb074bfdaa8d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
@@ -16,7 +16,7 @@ dvi_vga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&dvi_vga_timings>;
-			dvi_vga_timings: 640x480 {
+			dvi_vga_timings: timing0 {
 				clock-frequency = <31250000>;
 				hactive = <640>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index fb66884d8a2f..59b40d13a640 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -78,7 +78,7 @@ wvga: display {
 		bus-width = <18>;
 		display-timings {
 			native-mode = <&wvga_timings>;
-			wvga_timings: 640x480 {
+			wvga_timings: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <45>;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index d24b1da18766..99886ba36724 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -543,7 +543,7 @@ pwm1: pwm@53fe0000 {
 			};
 
 			iim: efuse@53ff0000 {
-				compatible = "fsl,imx25-iim", "fsl,imx27-iim";
+				compatible = "fsl,imx25-iim";
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <19>;
 				clocks = <&clks 99>;
diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
index 6f1e8ce9e76e..3d9bb7fc3be2 100644
--- a/arch/arm/boot/dts/imx27-apf27dev.dts
+++ b/arch/arm/boot/dts/imx27-apf27dev.dts
@@ -16,7 +16,7 @@ display: display {
 		fsl,pcr = <0xfae80083>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 800x480 {
+			timing0: timing0 {
 				clock-frequency = <33000033>;
 				hactive = <800>;
 				vactive = <480>;
@@ -47,7 +47,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio6 14 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
index 74110bbcd9d4..c7e923584878 100644
--- a/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
+++ b/arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
@@ -33,7 +33,7 @@ &i2c1 {
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	pcf8563@51 {
+	rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
@@ -90,7 +90,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
index 9c3ec82ec7e5..50fa0bd4c8a1 100644
--- a/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
+++ b/arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
@@ -16,7 +16,7 @@ display0: CMO-QVGA {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 320x240 {
+			timing0: timing0 {
 				clock-frequency = <6500000>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 188639738dc3..7f36af150a25 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -19,7 +19,7 @@ display: display {
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 640x480 {
+			timing0: timing0 {
 				hactive = <640>;
 				vactive = <480>;
 				hback-porch = <112>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 344e77790152..d133b9f08b3a 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -19,7 +19,7 @@ display0: LQ035Q7 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: 240x320 {
+			timing0: timing0 {
 				clock-frequency = <5500000>;
 				hactive = <240>;
 				vactive = <320>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 3d10273177e9..a5fdc2fd4ce5 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -322,7 +322,7 @@ &usbotg {
 &weim {
 	status = "okay";
 
-	nor: nor@0,0 {
+	nor: flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0 0x00000000 0x02000000>;
 		bank-width = <2>;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 7bc132737a37..8ae24c865521 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -588,6 +588,9 @@ weim: weim@d8002000 {
 		iram: sram@ffff4c00 {
 			compatible = "mmio-sram";
 			reg = <0xffff4c00 0xb400>;
+			ranges = <0 0xffff4c00 0xb400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6cab8b66db80..23ef4a322995 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -982,7 +982,7 @@ etm: etm@80022000 {
 				status = "disabled";
 			};
 
-			dma_apbx: dma-apbx@80024000 {
+			dma_apbx: dma-controller@80024000 {
 				compatible = "fsl,imx28-dma-apbx";
 				reg = <0x80024000 0x2000>;
 				interrupts = <78 79 66 0
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b0bcfa9094a3..8ad3e60fd7d1 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -209,9 +209,6 @@ pcie: pcie@33800000 {
 };
 
 &ca_funnel_in_ports {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port@1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 03bde2fb9bb1..b4cab6a21437 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -173,7 +173,11 @@ funnel@30041000 {
 			clock-names = "apb_pclk";
 
 			ca_funnel_in_ports: in-ports {
-				port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
 					ca_funnel_in_port0: endpoint {
 						remote-endpoint = <&etm0_out_port>;
 					};
@@ -769,7 +773,7 @@ csi_from_csi_mux: endpoint {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
@@ -1231,7 +1235,7 @@ dma_apbh: dma-controller@33000000 {
 		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 093567022386..5f47b638f532 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -336,12 +336,20 @@ hdmi: hdmi@20034000 {
 		pinctrl-0 = <&hdmi_ctl>;
 		status = "disabled";
 
-		hdmi_in: port {
+		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			hdmi_in_vop: endpoint@0 {
+
+			hdmi_in: port@0 {
 				reg = <0>;
-				remote-endpoint = <&vop_out_hdmi>;
+
+				hdmi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0bc5fefb7a49..d766f3b5c03e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -139,6 +139,19 @@ memory {
 		reg = <0 0 0 0>;
 	};
 
+	etm {
+		compatible = "qcom,coresight-remote-etm";
+
+		out-ports {
+			port {
+				modem_etm_out_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&funnel_in2_in_modem_etm>;
+				};
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -1374,6 +1387,14 @@ funnel@3023000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
+			in-ports {
+				port {
+					funnel_in2_in_modem_etm: endpoint {
+						remote-endpoint =
+						  <&modem_etm_out_funnel_in2>;
+					};
+				};
+			};
 
 			out-ports {
 				port {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 7c8d69ca91cf..ca8e7848769a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1577,9 +1577,11 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port{
-				etm4_out: endpoint {
-					remote-endpoint = <&apss_funnel_in4>;
+			out-ports {
+				port{
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -1594,9 +1596,11 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port{
-				etm5_out: endpoint {
-					remote-endpoint = <&apss_funnel_in5>;
+			out-ports {
+				port{
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -1611,9 +1615,11 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port{
-				etm6_out: endpoint {
-					remote-endpoint = <&apss_funnel_in6>;
+			out-ports {
+				port{
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -1628,9 +1634,11 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port{
-				etm7_out: endpoint {
-					remote-endpoint = <&apss_funnel_in7>;
+			out-ports {
+				port{
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index eb07a882d43b..be40821dfeb9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2688,10 +2688,10 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5c696ebf5c20..e3c6b05869e7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3565,10 +3565,10 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc_intc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc_intc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -3613,10 +3613,10 @@ usb_2: usb@a8f8800 {
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc_intc 10 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc_intc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a94acea770c7..020a455824be 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -431,7 +431,9 @@ SYM_CODE_END(__swpan_exit_el0)
 
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
-	scs_save tsk			// preserve the original shadow stack
+#ifdef CONFIG_SHADOW_CALL_STACK
+	mov	x24, scs_sp		// preserve the original shadow stack
+#endif
 
 	/*
 	 * Compare sp with the base of the task stack.
@@ -465,7 +467,9 @@ SYM_CODE_END(__swpan_exit_el0)
 	 */
 	.macro	irq_stack_exit
 	mov	sp, x19
-	scs_load_current
+#ifdef CONFIG_SHADOW_CALL_STACK
+	mov	scs_sp, x24
+#endif
 	.endm
 
 /* GPRs used by entry code */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index cdb3d4549b3a..8e428f8dd108 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -171,7 +171,11 @@ armv8pmu_events_sysfs_show(struct device *dev,
 	}).attr.attr)
 
 static struct attribute *armv8_pmuv3_event_attrs[] = {
-	ARMV8_EVENT_ATTR(sw_incr, ARMV8_PMUV3_PERFCTR_SW_INCR),
+	/*
+	 * Don't expose the sw_incr event in /sys. It's not usable as writes to
+	 * PMSWINC_EL0 will trap as PMUSERENR.{SW,EN}=={0,0} and event rotation
+	 * means we don't have a fixed event<->counter relationship regardless.
+	 */
 	ARMV8_EVENT_ATTR(l1i_cache_refill, ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL),
 	ARMV8_EVENT_ATTR(l1i_tlb_refill, ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL),
 	ARMV8_EVENT_ATTR(l1d_cache_refill, ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL),
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 5f80c28f5253..6c837a256cf6 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -242,7 +242,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	"	.set	pop"
 	: "=&r" (sum), "=&r" (tmp)
 	: "r" (saddr), "r" (daddr),
-	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
+	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
+	: "memory");
 
 	return csum_fold(sum);
 }
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 7b045d2a0b51..bbc6f07d8124 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -11,6 +11,7 @@
 
 #include <asm/cpu-features.h>
 #include <asm/cpu-info.h>
+#include <asm/fpu.h>
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
 
@@ -309,6 +310,11 @@ void mips_set_personality_nan(struct arch_elf_state *state)
 	struct cpuinfo_mips *c = &boot_cpu_data;
 	struct task_struct *t = current;
 
+	/* Do this early so t->thread.fpu.fcr31 won't be clobbered in case
+	 * we are preempted before the lose_fpu(0) in start_thread.
+	 */
+	lose_fpu(0);
+
 	t->thread.fpu.fcr31 = c->fpu_csr31;
 	switch (state->nan_2008) {
 	case 0:
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 07e84a774938..32e7b869a291 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -421,7 +421,12 @@ void __init paging_init(void)
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
+
+	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+#else
+	max_mapnr = max_low_pfn;
 #endif
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -457,16 +462,6 @@ void __init mem_init(void)
 	 */
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
 
-#ifdef CONFIG_HIGHMEM
-#ifdef CONFIG_DISCONTIGMEM
-#error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
-#endif
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
-#else
-	max_mapnr = max_low_pfn;
-#endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 	maar_init();
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */
diff --git a/arch/parisc/kernel/firmware.c b/arch/parisc/kernel/firmware.c
index 7ed28ddcaba7..25050b0ab6fd 100644
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -123,10 +123,10 @@ static unsigned long f_extend(unsigned long address)
 #ifdef CONFIG_64BIT
 	if(unlikely(parisc_narrow_firmware)) {
 		if((address & 0xff000000) == 0xf0000000)
-			return 0xf0f0f0f000000000UL | (u32)address;
+			return (0xfffffff0UL << 32) | (u32)address;
 
 		if((address & 0xf0000000) == 0xf0000000)
-			return 0xffffffff00000000UL | (u32)address;
+			return (0xffffffffUL << 32) | (u32)address;
 	}
 #endif
 	return address;
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 255a1837e9f7..3a5a27318a0e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -390,5 +390,9 @@ extern void *abatron_pteptrs[2];
 #include <asm/nohash/mmu.h>
 #endif
 
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 6cda76b57c5d..bd1a8d7256ff 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -42,9 +42,6 @@ u64 memory_hotplug_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
-#ifdef CONFIG_FA_DUMP
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern int create_section_mapping(unsigned long start, unsigned long end,
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5e5a2448ae79..b0e87dce2b9a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1432,10 +1432,12 @@ static int emulate_instruction(struct pt_regs *regs)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
 	return is_kernel_addr(addr);
 }
+#endif
 
 #ifdef CONFIG_MATH_EMULATION
 static int emulate_math(struct pt_regs *regs)
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 3dd58b4ee33e..5f6b3f80023d 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -250,7 +250,7 @@ int kvmppc_uvmem_slot_init(struct kvm *kvm, const struct kvm_memory_slot *slot)
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
-	p->pfns = vzalloc(array_size(slot->npages, sizeof(*p->pfns)));
+	p->pfns = vcalloc(slot->npages, sizeof(*p->pfns));
 	if (!p->pfns) {
 		kfree(p);
 		return -ENOMEM;
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 2d19655328f1..ca4733fbd02d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -512,6 +512,8 @@ static int do_fp_load(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -562,6 +564,8 @@ static int do_fp_store(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -606,6 +610,9 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u = {};
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
@@ -633,6 +640,9 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u;
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index e18ae50a275c..a86d932a7c30 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -446,6 +446,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * For hash translation mode, we use the deposited table to store hash slot
  * information and they are stored at PTRS_PER_PMD offset from related pmd
@@ -467,6 +468,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 
 	return true;
 }
+#endif
 
 /*
  * Does the CPU support tlbie?
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 8e0d792ac296..52a20c97e46e 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -111,7 +111,7 @@ void pgtable_cache_add(unsigned int shift)
 	 * as to leave enough 0 bits in the address to contain it. */
 	unsigned long minalign = max(MAX_PGTABLE_INDEX_SIZE + 1,
 				     HUGEPD_SHIFT_MASK + 1);
-	struct kmem_cache *new;
+	struct kmem_cache *new = NULL;
 
 	/* It would be nice if this was a BUILD_BUG_ON(), but at the
 	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
@@ -124,7 +124,8 @@ void pgtable_cache_add(unsigned int shift)
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
+	if (name)
+		new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
index f3e4d069e0ba..643fc525897d 100644
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -64,6 +64,7 @@ int __init __weak kasan_init_region(void *start, size_t size)
 	if (ret)
 		return ret;
 
+	k_start = k_start & PAGE_MASK;
 	block = memblock_alloc(k_end - k_start, PAGE_SIZE);
 	if (!block)
 		return -ENOMEM;
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 812730e6bfff..8ef4e5034765 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -600,7 +600,9 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
-		cpacf_kmctr(sctx->fc, sctx->key, buf, walk.src.virt.addr,
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
+		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
 			    AES_BLOCK_SIZE, walk.iv);
 		memcpy(walk.dst.virt.addr, buf, nbytes);
 		crypto_inc(walk.iv, AES_BLOCK_SIZE);
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index a6727ad58d65..6a0a22621671 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -676,9 +676,11 @@ static int ctr_paes_crypt(struct skcipher_request *req)
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
 	if (nbytes) {
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk.src.virt.addr, nbytes);
 		while (1) {
 			if (cpacf_kmctr(ctx->fc, &param, buf,
-					walk.src.virt.addr, AES_BLOCK_SIZE,
+					buf, AES_BLOCK_SIZE,
 					walk.iv) == AES_BLOCK_SIZE)
 				break;
 			if (__paes_convert_key(ctx))
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 3009bb527252..f381caddd905 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -411,6 +411,7 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if ((unsigned int) data != 0 ||
 		    test_fp_ctl(data >> (BITS_PER_LONG - 32)))
 			return -EINVAL;
@@ -771,6 +772,7 @@ static int __poke_user_compat(struct task_struct *child,
 		/*
 		 * floating point control reg. is in the thread structure
 		 */
+		save_fpu_regs();
 		if (test_fp_ctl(tmp))
 			return -EINVAL;
 		child->thread.fpu.fpc = data;
@@ -1010,9 +1012,7 @@ static int s390_fpregs_set(struct task_struct *target,
 	int rc = 0;
 	freg_t fprs[__NUM_FPRS];
 
-	if (target == current)
-		save_fpu_regs();
-
+	save_fpu_regs();
 	if (MACHINE_HAS_VX)
 		convert_vx_to_fp(fprs, target->thread.fpu.vxrs);
 	else
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7a326d03087a..f6c27b44766f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3649,10 +3649,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 	vcpu_load(vcpu);
 
-	if (test_fp_ctl(fpu->fpc)) {
-		ret = -EINVAL;
-		goto out;
-	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
@@ -3660,7 +3656,6 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
 
-out:
 	vcpu_put(vcpu);
 	return ret;
 }
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 1802cf4ef5a5..ee55333255d0 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 9c08e728a675..83171f9e0912 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -51,7 +51,7 @@ extern void do_uml_exitcalls(void);
  * Are we disallowed to sleep? Used to choose between GFP_KERNEL and
  * GFP_ATOMIC.
  */
-extern int __cant_sleep(void);
+extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern int cpu(void);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index e6c9b11b2033..76faaf1082ce 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -221,7 +221,7 @@ void arch_cpu_idle(void)
 	raw_local_irq_enable();
 }
 
-int __cant_sleep(void) {
+int __uml_cant_sleep(void) {
 	return in_atomic() || irqs_disabled() || in_interrupt();
 	/* Is in_interrupt() really needed? */
 }
diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 9fa6e4187d4f..57a27555092f 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -45,7 +45,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	unsigned long stack, sp;
 	int pid, fds[2], ret, n;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
@@ -69,7 +69,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 	data.pre_data = pre_data;
 	data.argv = argv;
 	data.fd = fds[1];
-	data.buf = __cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
+	data.buf = __uml_cant_sleep() ? uml_kmalloc(PATH_MAX, UM_GFP_ATOMIC) :
 					uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
 	pid = clone(helper_child, (void *) sp, CLONE_VM, &data);
 	if (pid < 0) {
@@ -116,7 +116,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	unsigned long stack, sp;
 	int pid, status, err;
 
-	stack = alloc_stack(0, __cant_sleep());
+	stack = alloc_stack(0, __uml_cant_sleep());
 	if (stack == 0)
 		return -ENOMEM;
 
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 07327425d06e..56d9589e1cd1 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -166,23 +166,38 @@ __uml_setup("quiet", quiet_cmd_param,
 "quiet\n"
 "    Turns off information messages during boot.\n\n");
 
+/*
+ * The os_info/os_warn functions will be called by helper threads. These
+ * have a very limited stack size and using the libc formatting functions
+ * may overflow the stack.
+ * So pull in the kernel vscnprintf and use that instead with a fixed
+ * on-stack buffer.
+ */
+int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+
 void os_info(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	if (quiet_info)
 		return;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
 
 void os_warn(const char *fmt, ...)
 {
+	char buf[256];
 	va_list list;
+	int len;
 
 	va_start(list, fmt);
-	vfprintf(stderr, fmt, list);
+	len = vscnprintf(buf, sizeof(buf), fmt, list);
+	fwrite(buf, len, 1, stderr);
 	va_end(list);
 }
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 814fe0d349b0..6f55609ba706 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -379,7 +379,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f4a2e6d373b2..1e4eb3894ec4 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -367,3 +367,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	add_identity_map(address, end);
 }
+
+void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Empty handler to ignore NMI during early boot */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 804a502ee0d2..eb30bb20c33b 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -45,6 +45,7 @@ void load_stage2_idt(void)
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_trap);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	set_idt_entry(X86_TRAP_VC, boot_stage2_vc);
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e199f5b..4d03c8562f63 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -70,6 +70,7 @@ SYM_FUNC_END(\name)
 	.code64
 
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
+EXCEPTION_HANDLER	boot_nmi_trap do_boot_nmi_trap error_code=0
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb		error_code=1
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index d9a631c5973c..0ccc32718483 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -156,6 +156,7 @@ extern struct desc_ptr boot_idt_desc;
 
 /* IDT Entry Points */
 void boot_page_fault(void);
+void boot_nmi_trap(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index a84333adeef2..a507be368927 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -58,12 +58,29 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		,,regs->di,,regs->si,,regs->dx				\
 		,,regs->r10,,regs->r8,,regs->r9)			\
 
+
+/* SYSCALL_PT_ARGS is Adapted from s390x */
+#define SYSCALL_PT_ARG6(m, t1, t2, t3, t4, t5, t6)			\
+	SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5), m(t6, (regs->bp))
+#define SYSCALL_PT_ARG5(m, t1, t2, t3, t4, t5)				\
+	SYSCALL_PT_ARG4(m, t1, t2, t3, t4),  m(t5, (regs->di))
+#define SYSCALL_PT_ARG4(m, t1, t2, t3, t4)				\
+	SYSCALL_PT_ARG3(m, t1, t2, t3),  m(t4, (regs->si))
+#define SYSCALL_PT_ARG3(m, t1, t2, t3)					\
+	SYSCALL_PT_ARG2(m, t1, t2), m(t3, (regs->dx))
+#define SYSCALL_PT_ARG2(m, t1, t2)					\
+	SYSCALL_PT_ARG1(m, t1), m(t2, (regs->cx))
+#define SYSCALL_PT_ARG1(m, t1) m(t1, (regs->bx))
+#define SYSCALL_PT_ARGS(x, ...) SYSCALL_PT_ARG##x(__VA_ARGS__)
+
+#define __SC_COMPAT_CAST(t, a)						\
+	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
+	(unsigned int)a
+
 /* Mapping of registers to parameters for syscalls on i386 */
 #define SC_IA32_REGS_TO_ARGS(x, ...)					\
-	__MAP(x,__SC_ARGS						\
-	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
-	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
-	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+	SYSCALL_PT_ARGS(x, __SC_COMPAT_CAST,				\
+			__MAP(x, __SC_TYPE, __VA_ARGS__))		\
 
 #define __SYS_STUB0(abi, name)						\
 	long __##abi##_##name(const struct pt_regs *regs);		\
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0b7c81389c50..18a6ed2afca0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -274,6 +275,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -329,6 +331,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		/*
+		 * Kdump skips the poisoned page in order to avoid
+		 * touching the error bits again. Poison the page even
+		 * if the error is fatal and the machine is about to
+		 * panic.
+		 */
+		if (kexec_crash_loaded()) {
+			if (final && (final->status & MCI_STATUS_ADDRV)) {
+				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				if (p)
+					SetPageHWPoison(p);
+			}
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 81cf4babbd0b..3c379335ea47 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -35,7 +35,7 @@ int kvm_page_track_create_memslot(struct kvm_memory_slot *slot,
 
 	for (i = 0; i < KVM_PAGE_TRACK_MAX; i++) {
 		slot->arch.gfn_track[i] =
-			kvcalloc(npages, sizeof(*slot->arch.gfn_track[i]),
+			__vcalloc(npages, sizeof(*slot->arch.gfn_track[i]),
 				 GFP_KERNEL_ACCOUNT);
 		if (!slot->arch.gfn_track[i])
 			goto track_free;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 13e4699a0744..6c2bf7cd7aec 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10826,14 +10826,14 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
 				      slot->base_gfn, level) + 1;
 
 		slot->arch.rmap[i] =
-			kvcalloc(lpages, sizeof(*slot->arch.rmap[i]),
+			__vcalloc(lpages, sizeof(*slot->arch.rmap[i]),
 				 GFP_KERNEL_ACCOUNT);
 		if (!slot->arch.rmap[i])
 			goto out_free;
 		if (i == 0)
 			continue;
 
-		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
+		linfo = __vcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
 			goto out_free;
 
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..f50cc210a981 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/block/bio.c b/block/bio.c
index 6d6e7b96b002..6f7a1aa9ea22 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -770,7 +770,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
@@ -954,7 +954,7 @@ void bio_release_pages(struct bio *bio, bool mark_dirty)
 		return;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (mark_dirty && !PageCompound(bvec->bv_page))
+		if (mark_dirty)
 			set_page_dirty_lock(bvec->bv_page);
 		put_page(bvec->bv_page);
 	}
@@ -1326,8 +1326,7 @@ void bio_set_pages_dirty(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+		set_page_dirty_lock(bvec->bv_page);
 	}
 }
 
@@ -1375,7 +1374,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+		if (!PageDirty(bvec->bv_page))
 			goto defer;
 	}
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7ba7c4e4e4c9..63a8fb456b28 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1296,6 +1296,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
+	/*
+	 * If the delay is set by another CPU, we may be in the past. No need to
+	 * change anything if so. This avoids decay calculation underflow.
+	 */
+	if (time_before64(now->now, iocg->delay_at))
+		return false;
+
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
 	if (iocg->delay)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e153a36c9ba3..a7a31d7090ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1188,6 +1188,22 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
 	__add_wait_queue(wq, wait);
 
+	/*
+	 * Add one explicit barrier since blk_mq_get_driver_tag() may
+	 * not imply barrier in case of failure.
+	 *
+	 * Order adding us to wait queue and allocating driver tag.
+	 *
+	 * The pair is the one implied in sbitmap_queue_wake_up() which
+	 * orders clearing sbitmap tag bits and waitqueue_active() in
+	 * __sbitmap_queue_wake_up(), since waitqueue_active() is lockless
+	 *
+	 * Otherwise, re-order of adding wait queue and getting driver tag
+	 * may cause __sbitmap_queue_wake_up() to wake up nothing because
+	 * the waitqueue_active() may not observe us in wait queue.
+	 */
+	smp_mb();
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 5d422e725b26..bb03bed14f74 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,6 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
+		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 088db2356998..0a84d5afd37c 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -308,9 +308,10 @@ static int __init extlog_init(void)
 static void __exit extlog_exit(void)
 {
 	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
 	if (elog_addr)
 		acpi_os_unmap_iomem(elog_addr, elog_size);
 	release_mem_region(elog_base, elog_size);
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 9d384656323a..b2364ac455f3 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -568,6 +568,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "COLORFUL X15 AT 23",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8678e162181f..160606af8b4f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -99,6 +99,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
 }
 
+/*
+ * A platform may describe one error source for the handling of synchronous
+ * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
+ * or External Interrupt). On x86, the HEST notifications are always
+ * asynchronous, so only SEA on ARM is delivered as a synchronous
+ * notification.
+ */
+static inline bool is_hest_sync_notify(struct ghes *ghes)
+{
+	u8 notify_type = ghes->generic->notify.type;
+
+	return notify_type == ACPI_HEST_NOTIFY_SEA;
+}
+
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -461,7 +475,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 }
 
 static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev)
+				       int sev, bool sync)
 {
 	int flags = -1;
 	int sec_sev = ghes_severity(gdata->error_severity);
@@ -475,7 +489,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
 		flags = MF_SOFT_OFFLINE;
 	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;
 
 	if (flags != -1)
 		return ghes_do_memory_failure(mem_err->physical_addr, flags);
@@ -483,9 +497,11 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 	return false;
 }
 
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
+static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+				       int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -510,7 +526,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int s
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
+			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -631,6 +647,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 	const guid_t *fru_id = &guid_null;
 	char *fru_text = "";
 	bool queued = false;
+	bool sync = is_hest_sync_notify(ghes);
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -648,13 +665,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev);
+			queued = ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev);
+			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 7db748cfcbc6..708c91215ec0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -836,6 +836,16 @@ binder_enqueue_thread_work_ilocked(struct binder_thread *thread,
 {
 	WARN_ON(!list_empty(&thread->waiting_thread_node));
 	binder_enqueue_work_ilocked(work, &thread->todo);
+
+	/* (e)poll-based threads require an explicit wakeup signal when
+	 * queuing their own work; they rely on these events to consume
+	 * messages without I/O block. Without it, threads risk waiting
+	 * indefinitely without handling the work.
+	 */
+	if (thread->looper & BINDER_LOOPER_STATE_POLL &&
+	    thread->pid == current->pid && !thread->process_todo)
+		wake_up_interruptible_sync(&thread->wait);
+
 	thread->process_todo = true;
 }
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2308c2be85a1..48130b254396 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1607,7 +1607,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	}
 
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
-		int ret = scsi_check_sense(qc->scsicmd);
+		enum scsi_disposition ret = scsi_check_sense(qc->scsicmd);
 		/*
 		 * SUCCESS here means that the sense code could be
 		 * evaluated and should be passed to the upper layers
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index a217b50439e7..e616e33c8a20 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2936,6 +2936,8 @@ open_card_ubr0(struct idt77252_dev *card)
 	vc->scq = alloc_scq(card, vc->class);
 	if (!vc->scq) {
 		printk("%s: can't get SCQ.\n", card->name);
+		kfree(card->vcs[0]);
+		card->vcs[0] = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8a90f08c9682..f5a032b6b8d6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -958,7 +958,7 @@ static int __init genpd_power_off_unused(void)
 
 	return 0;
 }
-late_initcall(genpd_power_off_unused);
+late_initcall_sync(genpd_power_off_unused);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1dbaaddf540e..fbc57c4fcdd0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -16,6 +16,7 @@
  */
 
 #define pr_fmt(fmt) "PM: " fmt
+#define dev_fmt pr_fmt
 
 #include <linux/device.h>
 #include <linux/export.h>
@@ -449,8 +450,8 @@ static void pm_dev_dbg(struct device *dev, pm_message_t state, const char *info)
 static void pm_dev_err(struct device *dev, pm_message_t state, const char *info,
 			int error)
 {
-	pr_err("Device %s failed to %s%s: error %d\n",
-	       dev_name(dev), pm_verb(state.event), info, error);
+	dev_err(dev, "failed to %s%s: error %d\n", pm_verb(state.event), info,
+		error);
 }
 
 static void dpm_show_time(ktime_t starttime, pm_message_t state, int error,
@@ -582,7 +583,7 @@ bool dev_pm_skip_resume(struct device *dev)
 }
 
 /**
- * device_resume_noirq - Execute a "noirq resume" callback for given device.
+ * __device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
@@ -590,7 +591,7 @@ bool dev_pm_skip_resume(struct device *dev)
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static int device_resume_noirq(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -658,7 +659,13 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 Out:
 	complete_all(&dev->power.completion);
 	TRACE_RESUME(error);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_noirq++;
+		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
+	}
 }
 
 static bool is_async(struct device *dev)
@@ -671,27 +678,35 @@ static bool dpm_async_fn(struct device *dev, async_func_t func)
 {
 	reinit_completion(&dev->power.completion);
 
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(func, dev);
+	if (!is_async(dev))
+		return false;
+
+	get_device(dev);
+
+	if (async_schedule_dev_nocall(func, dev))
 		return true;
-	}
+
+	put_device(dev);
 
 	return false;
 }
 
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_noirq(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	struct device *dev = data;
 
+	__device_resume_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_noirq(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_noirq))
+		return;
+
+	__device_resume_noirq(dev, pm_transition, false);
+}
+
 static void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
@@ -701,34 +716,18 @@ static void dpm_noirq_resume_devices(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
-		dpm_async_fn(dev, async_resume_noirq);
-
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
+
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
+		device_resume_noirq(dev);
 
-			error = device_resume_noirq(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_noirq++;
-				dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " noirq", error);
-			}
-		}
+		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
-		put_device(dev);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
@@ -754,14 +753,14 @@ void dpm_resume_noirq(pm_message_t state)
 }
 
 /**
- * device_resume_early - Execute an "early resume" callback for given device.
+ * __device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int device_resume_early(struct device *dev, pm_message_t state, bool async)
+static void __device_resume_early(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -814,21 +813,31 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 
 	pm_runtime_enable(dev);
 	complete_all(&dev->power.completion);
-	return error;
+
+	if (error) {
+		suspend_stats.failed_resume_early++;
+		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async early" : " early", error);
+	}
 }
 
 static void async_resume_early(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
-
-	error = device_resume_early(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	struct device *dev = data;
 
+	__device_resume_early(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume_early(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume_early))
+		return;
+
+	__device_resume_early(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume_early - Execute "early resume" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -842,33 +851,18 @@ void dpm_resume_early(pm_message_t state)
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
-	/*
-	 * Advanced the async threads upfront,
-	 * in case the starting of async threads is
-	 * delayed by non-async resuming devices.
-	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
-		dpm_async_fn(dev, async_resume_early);
-
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
+
 		mutex_unlock(&dpm_list_mtx);
 
-		if (!is_async(dev)) {
-			int error;
+		device_resume_early(dev);
 
-			error = device_resume_early(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume_early++;
-				dpm_save_failed_step(SUSPEND_RESUME_EARLY);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, " early", error);
-			}
-		}
-		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
+
+		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
@@ -888,12 +882,12 @@ void dpm_resume_start(pm_message_t state)
 EXPORT_SYMBOL_GPL(dpm_resume_start);
 
 /**
- * device_resume - Execute "resume" callbacks for given device.
+ * __device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being resumed asynchronously.
  */
-static int device_resume(struct device *dev, pm_message_t state, bool async)
+static void __device_resume(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -975,20 +969,30 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 	TRACE_RESUME(error);
 
-	return error;
+	if (error) {
+		suspend_stats.failed_resume++;
+		dpm_save_failed_step(SUSPEND_RESUME);
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async" : "", error);
+	}
 }
 
 static void async_resume(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
-	int error;
+	struct device *dev = data;
 
-	error = device_resume(dev, pm_transition, true);
-	if (error)
-		pm_dev_err(dev, pm_transition, " async", error);
+	__device_resume(dev, pm_transition, true);
 	put_device(dev);
 }
 
+static void device_resume(struct device *dev)
+{
+	if (dpm_async_fn(dev, async_resume))
+		return;
+
+	__device_resume(dev, pm_transition, false);
+}
+
 /**
  * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
  * @state: PM transition of the system being carried out.
@@ -1008,30 +1012,25 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
-		dpm_async_fn(dev, async_resume);
-
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
+
 		get_device(dev);
-		if (!is_async(dev)) {
-			int error;
 
-			mutex_unlock(&dpm_list_mtx);
+		mutex_unlock(&dpm_list_mtx);
 
-			error = device_resume(dev, state, false);
-			if (error) {
-				suspend_stats.failed_resume++;
-				dpm_save_failed_step(SUSPEND_RESUME);
-				dpm_save_failed_dev(dev_name(dev));
-				pm_dev_err(dev, state, "", error);
-			}
+		device_resume(dev);
+
+		mutex_lock(&dpm_list_mtx);
 
-			mutex_lock(&dpm_list_mtx);
-		}
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
+
+		mutex_unlock(&dpm_list_mtx);
+
 		put_device(dev);
+
+		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
@@ -1109,14 +1108,16 @@ void dpm_complete(pm_message_t state)
 		get_device(dev);
 		dev->power.is_prepared = false;
 		list_move(&dev->power.entry, &list);
+
 		mutex_unlock(&dpm_list_mtx);
 
 		trace_device_pm_callback_start(dev, "", state.event);
 		device_complete(dev, state);
 		trace_device_pm_callback_end(dev, 0);
 
-		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
+
+		mutex_lock(&dpm_list_mtx);
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
@@ -1262,7 +1263,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_noirq(dev, pm_transition, true);
@@ -1301,17 +1302,21 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
 		error = device_suspend_noirq(dev);
 
 		mutex_lock(&dpm_list_mtx);
+
 		if (error) {
 			pm_dev_err(dev, state, " noirq", error);
 			dpm_save_failed_dev(dev_name(dev));
-			put_device(dev);
-			break;
-		}
-		if (!list_empty(&dev->power.entry))
+		} else if (!list_empty(&dev->power.entry)) {
 			list_move(&dev->power.entry, &dpm_noirq_list);
+		}
+
+		mutex_unlock(&dpm_list_mtx);
+
 		put_device(dev);
 
-		if (async_error)
+		mutex_lock(&dpm_list_mtx);
+
+		if (error || async_error)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -1441,7 +1446,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 
 static void async_suspend_late(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend_late(dev, pm_transition, true);
@@ -1478,23 +1483,28 @@ int dpm_suspend_late(pm_message_t state)
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		get_device(dev);
+
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend_late(dev);
 
 		mutex_lock(&dpm_list_mtx);
+
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_late_early_list);
 
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
 			dpm_save_failed_dev(dev_name(dev));
-			put_device(dev);
-			break;
 		}
+
+		mutex_unlock(&dpm_list_mtx);
+
 		put_device(dev);
 
-		if (async_error)
+		mutex_lock(&dpm_list_mtx);
+
+		if (error || async_error)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -1712,7 +1722,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 
 static void async_suspend(void *data, async_cookie_t cookie)
 {
-	struct device *dev = (struct device *)data;
+	struct device *dev = data;
 	int error;
 
 	error = __device_suspend(dev, pm_transition, true);
@@ -1754,21 +1764,27 @@ int dpm_suspend(pm_message_t state)
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
+
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend(dev);
 
 		mutex_lock(&dpm_list_mtx);
+
 		if (error) {
 			pm_dev_err(dev, state, "", error);
 			dpm_save_failed_dev(dev_name(dev));
-			put_device(dev);
-			break;
-		}
-		if (!list_empty(&dev->power.entry))
+		} else if (!list_empty(&dev->power.entry)) {
 			list_move(&dev->power.entry, &dpm_suspended_list);
+		}
+
+		mutex_unlock(&dpm_list_mtx);
+
 		put_device(dev);
-		if (async_error)
+
+		mutex_lock(&dpm_list_mtx);
+
+		if (error || async_error)
 			break;
 	}
 	mutex_unlock(&dpm_list_mtx);
@@ -1881,10 +1897,11 @@ int dpm_prepare(pm_message_t state)
 	device_block_probing();
 
 	mutex_lock(&dpm_list_mtx);
-	while (!list_empty(&dpm_list)) {
+	while (!list_empty(&dpm_list) && !error) {
 		struct device *dev = to_device(dpm_list.next);
 
 		get_device(dev);
+
 		mutex_unlock(&dpm_list_mtx);
 
 		trace_device_pm_callback_start(dev, "", state.event);
@@ -1892,21 +1909,23 @@ int dpm_prepare(pm_message_t state)
 		trace_device_pm_callback_end(dev, error);
 
 		mutex_lock(&dpm_list_mtx);
-		if (error) {
-			if (error == -EAGAIN) {
-				put_device(dev);
-				error = 0;
-				continue;
-			}
-			pr_info("Device %s not prepared for power transition: code %d\n",
-				dev_name(dev), error);
-			put_device(dev);
-			break;
+
+		if (!error) {
+			dev->power.is_prepared = true;
+			if (!list_empty(&dev->power.entry))
+				list_move_tail(&dev->power.entry, &dpm_prepared_list);
+		} else if (error == -EAGAIN) {
+			error = 0;
+		} else {
+			dev_info(dev, "not prepared for power transition: code %d\n",
+				 error);
 		}
-		dev->power.is_prepared = true;
-		if (!list_empty(&dev->power.entry))
-			list_move_tail(&dev->power.entry, &dpm_prepared_list);
+
+		mutex_unlock(&dpm_list_mtx);
+
 		put_device(dev);
+
+		mutex_lock(&dpm_list_mtx);
 	}
 	mutex_unlock(&dpm_list_mtx);
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, false);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fbbc3ed143f2..f5c9e6629f0c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1479,6 +1479,28 @@ void pm_runtime_enable(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+static void pm_runtime_disable_action(void *data)
+{
+	pm_runtime_dont_use_autosuspend(data);
+	pm_runtime_disable(data);
+}
+
+/**
+ * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ *
+ * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
+ * you at driver exit time if needed.
+ *
+ * @dev: Device to handle.
+ */
+int devm_pm_runtime_enable(struct device *dev)
+{
+	pm_runtime_enable(dev);
+
+	return devm_add_action_or_reset(dev, pm_runtime_disable_action, dev);
+}
+EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
+
 /**
  * pm_runtime_forbid - Block runtime PM of a device.
  * @dev: Device to handle.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b0f7930524ba..5b102d333a41 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3517,14 +3517,15 @@ static bool rbd_lock_add_request(struct rbd_img_request *img_req)
 static void rbd_lock_del_request(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
-	bool need_wakeup;
+	bool need_wakeup = false;
 
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 	spin_lock(&rbd_dev->lock_lists_lock);
-	rbd_assert(!list_empty(&img_req->lock_item));
-	list_del_init(&img_req->lock_item);
-	need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
-		       list_empty(&rbd_dev->running_list));
+	if (!list_empty(&img_req->lock_item)) {
+		list_del_init(&img_req->lock_item);
+		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
+			       list_empty(&rbd_dev->running_list));
+	}
 	spin_unlock(&rbd_dev->lock_lists_lock);
 	if (need_wakeup)
 		complete(&rbd_dev->releasing_wait);
@@ -3907,14 +3908,19 @@ static void wake_lock_waiters(struct rbd_device *rbd_dev, int result)
 		return;
 	}
 
-	list_for_each_entry(img_req, &rbd_dev->acquiring_list, lock_item) {
+	while (!list_empty(&rbd_dev->acquiring_list)) {
+		img_req = list_first_entry(&rbd_dev->acquiring_list,
+					   struct rbd_img_request, lock_item);
 		mutex_lock(&img_req->state_mutex);
 		rbd_assert(img_req->state == RBD_IMG_EXCLUSIVE_LOCK);
+		if (!result)
+			list_move_tail(&img_req->lock_item,
+				       &rbd_dev->running_list);
+		else
+			list_del_init(&img_req->lock_item);
 		rbd_img_schedule(img_req, result);
 		mutex_unlock(&img_req->state_mutex);
 	}
-
-	list_splice_tail_init(&rbd_dev->acquiring_list, &rbd_dev->running_list);
 }
 
 static bool locker_equal(const struct ceph_locker *lhs,
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index e1bc8b4cd592..9c5d52335e17 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -591,6 +591,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 {
 	char *full_path;
 	char *a, *b;
+	int len;
 
 	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!full_path)
@@ -602,19 +603,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	 */
 	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
 	if (a) {
-		int len = a - dev_search_path;
+		len = a - dev_search_path;
 
 		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
 			       dev_search_path, srv_sess->sessname, dev_name);
-		if (len >= PATH_MAX) {
-			pr_err("Too long path: %s, %s, %s\n",
-			       dev_search_path, srv_sess->sessname, dev_name);
-			kfree(full_path);
-			return ERR_PTR(-EINVAL);
-		}
 	} else {
-		snprintf(full_path, PATH_MAX, "%s/%s",
-			 dev_search_path, dev_name);
+		len = snprintf(full_path, PATH_MAX, "%s/%s",
+			       dev_search_path, dev_name);
+	}
+	if (len >= PATH_MAX) {
+		pr_err("Too long path: %s, %s, %s\n",
+		       dev_search_path, srv_sess->sessname, dev_name);
+		kfree(full_path);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* eliminitate duplicated slashes */
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bc0850d3f7d2..6e0c0762fbab 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1814,6 +1814,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static void qca_power_shutdown(struct hci_uart *hu)
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 614dd287cb4f..49c0f5ad0b73 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -569,6 +569,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
 
+			read_unlock_bh(&mhi_chan->lock);
+
 			/* notify client */
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 
@@ -591,6 +593,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 					kfree(buf_info->cb_buf);
 				}
 			}
+
+			read_lock_bh(&mhi_chan->lock);
 		}
 		break;
 	} /* CC_EOT */
diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index b20fdcbd035b..34377195bf87 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -832,6 +832,12 @@ static int moxtet_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id moxtet_spi_ids[] = {
+	{ "moxtet" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
+
 static const struct of_device_id moxtet_dt_ids[] = {
 	{ .compatible = "cznic,moxtet" },
 	{},
@@ -843,6 +849,7 @@ static struct spi_driver moxtet_spi_driver = {
 		.name		= "moxtet",
 		.of_match_table = moxtet_dt_ids,
 	},
+	.id_table	= moxtet_spi_ids,
 	.probe		= moxtet_probe,
 	.remove		= moxtet_remove,
 };
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 5749998feaa4..6e2c1ba18012 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -24,10 +24,13 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
+#define RNG_BUFFER_SIZE (SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES)
+
 static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
@@ -59,7 +62,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 
 static size_t rng_buffer_size(void)
 {
-	return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
+	return RNG_BUFFER_SIZE;
 }
 
 static void add_early_randomness(struct hwrng *rng)
@@ -206,6 +209,7 @@ static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			    size_t size, loff_t *offp)
 {
+	u8 buffer[RNG_BUFFER_SIZE];
 	ssize_t ret = 0;
 	int err = 0;
 	int bytes_read, len;
@@ -233,34 +237,37 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (bytes_read < 0) {
 				err = bytes_read;
 				goto out_unlock_reading;
+			} else if (bytes_read == 0 &&
+				   (filp->f_flags & O_NONBLOCK)) {
+				err = -EAGAIN;
+				goto out_unlock_reading;
 			}
+
 			data_avail = bytes_read;
 		}
 
-		if (!data_avail) {
-			if (filp->f_flags & O_NONBLOCK) {
-				err = -EAGAIN;
-				goto out_unlock_reading;
-			}
-		} else {
-			len = data_avail;
+		len = data_avail;
+		if (len) {
 			if (len > size)
 				len = size;
 
 			data_avail -= len;
 
-			if (copy_to_user(buf + ret, rng_buffer + data_avail,
-								len)) {
+			memcpy(buffer, rng_buffer + data_avail, len);
+		}
+		mutex_unlock(&reading_mutex);
+		put_rng(rng);
+
+		if (len) {
+			if (copy_to_user(buf + ret, buffer, len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
-		put_rng(rng);
 
 		if (need_resched())
 			schedule_timeout_interruptible(1);
@@ -271,6 +278,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		}
 	}
 out:
+	memzero_explicit(buffer, sizeof(buffer));
 	return ret ? : err;
 
 out_unlock_reading:
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..eb9c139babc3 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -467,8 +467,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02e83cb..9674c6c06dca 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,18 +258,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 8e2672ec6e03..055cbb2ad75e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -304,10 +304,16 @@ EXPORT_SYMBOL_GPL(sev_platform_init);
 
 static int __sev_platform_shutdown_locked(int *error)
 {
-	struct sev_device *sev = psp_master->sev_data;
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
 	int ret;
 
-	if (!sev || sev->state == SEV_STATE_UNINIT)
+	if (!psp || !psp->sev_data)
+		return 0;
+
+	sev = psp->sev_data;
+
+	if (sev->state == SEV_STATE_UNINIT)
 		return 0;
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);
diff --git a/drivers/crypto/stm32/stm32-crc32.c b/drivers/crypto/stm32/stm32-crc32.c
index 90a920e7f664..c439be1650c8 100644
--- a/drivers/crypto/stm32/stm32-crc32.c
+++ b/drivers/crypto/stm32/stm32-crc32.c
@@ -104,7 +104,7 @@ static struct stm32_crc *stm32_crc_get_next_crc(void)
 	struct stm32_crc *crc;
 
 	spin_lock_bh(&crc_list.lock);
-	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
+	crc = list_first_entry_or_null(&crc_list.dev_list, struct stm32_crc, list);
 	if (crc)
 		list_move_tail(&crc->list, &crc_list.dev_list);
 	spin_unlock_bh(&crc_list.lock);
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 42c1eed44529..216594b86119 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -438,10 +438,14 @@ static void devfreq_monitor(struct work_struct *work)
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
+	if (devfreq->stop_polling)
+		goto out;
+
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
-	mutex_unlock(&devfreq->lock);
 
+out:
+	mutex_unlock(&devfreq->lock);
 	trace_devfreq_monitor(devfreq);
 }
 
@@ -459,6 +463,10 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (devfreq->governor->interrupt_driven)
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (delayed_work_pending(&devfreq->work))
+		goto out;
+
 	switch (devfreq->profile->timer) {
 	case DEVFREQ_TIMER_DEFERRABLE:
 		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -467,12 +475,16 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 		break;
 	default:
-		return;
+		goto out;
 	}
 
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+out:
+	devfreq->stop_polling = false;
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -489,6 +501,14 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
 	if (devfreq->governor->interrupt_driven)
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (devfreq->stop_polling) {
+		mutex_unlock(&devfreq->lock);
+		return;
+	}
+
+	devfreq->stop_polling = true;
+	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4ec7bb58c195..9559ebd61f3b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1108,6 +1108,9 @@ EXPORT_SYMBOL_GPL(dma_async_device_channel_register);
 static void __dma_async_device_channel_unregister(struct dma_device *device,
 						  struct dma_chan *chan)
 {
+	if (chan->local == NULL)
+		return;
+
 	WARN_ONCE(!device->device_release && chan->client_count,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 4ae057922ef1..2d905f0633d5 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -38,15 +38,17 @@ static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
 	if (!dpaa2_chan->fd_pool)
 		goto err;
 
-	dpaa2_chan->fl_pool = dma_pool_create("fl_pool", dev,
-					      sizeof(struct dpaa2_fl_entry),
-					      sizeof(struct dpaa2_fl_entry), 0);
+	dpaa2_chan->fl_pool =
+		dma_pool_create("fl_pool", dev,
+				 sizeof(struct dpaa2_fl_entry) * 3,
+				 sizeof(struct dpaa2_fl_entry), 0);
+
 	if (!dpaa2_chan->fl_pool)
 		goto err_fd;
 
 	dpaa2_chan->sdd_pool =
 		dma_pool_create("sdd_pool", dev,
-				sizeof(struct dpaa2_qdma_sd_d),
+				sizeof(struct dpaa2_qdma_sd_d) * 2,
 				sizeof(struct dpaa2_qdma_sd_d), 0);
 	if (!dpaa2_chan->sdd_pool)
 		goto err_fl;
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 045ead46ec8f..69385f32e275 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -514,11 +514,11 @@ static struct fsl_qdma_queue
 			queue_temp = queue_head + i + (j * queue_num);
 
 			queue_temp->cq =
-			dma_alloc_coherent(&pdev->dev,
-					   sizeof(struct fsl_qdma_format) *
-					   queue_size[i],
-					   &queue_temp->bus_addr,
-					   GFP_KERNEL);
+			dmam_alloc_coherent(&pdev->dev,
+					    sizeof(struct fsl_qdma_format) *
+					    queue_size[i],
+					    &queue_temp->bus_addr,
+					    GFP_KERNEL);
 			if (!queue_temp->cq)
 				return NULL;
 			queue_temp->block_base = fsl_qdma->block_base +
@@ -563,11 +563,11 @@ static struct fsl_qdma_queue
 	/*
 	 * Buffer for queue command
 	 */
-	status_head->cq = dma_alloc_coherent(&pdev->dev,
-					     sizeof(struct fsl_qdma_format) *
-					     status_size,
-					     &status_head->bus_addr,
-					     GFP_KERNEL);
+	status_head->cq = dmam_alloc_coherent(&pdev->dev,
+					      sizeof(struct fsl_qdma_format) *
+					      status_size,
+					      &status_head->bus_addr,
+					      GFP_KERNEL);
 	if (!status_head->cq) {
 		devm_kfree(&pdev->dev, status_head);
 		return NULL;
@@ -1272,8 +1272,6 @@ static void fsl_qdma_cleanup_vchan(struct dma_device *dmadev)
 
 static int fsl_qdma_remove(struct platform_device *pdev)
 {
-	int i;
-	struct fsl_qdma_queue *status;
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_qdma_engine *fsl_qdma = platform_get_drvdata(pdev);
 
@@ -1282,11 +1280,6 @@ static int fsl_qdma_remove(struct platform_device *pdev)
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_qdma->dma_dev);
 
-	for (i = 0; i < fsl_qdma->block_number; i++) {
-		status = fsl_qdma->status[i];
-		dma_free_coherent(&pdev->dev, sizeof(struct fsl_qdma_format) *
-				status->n_cq, status->cq, status->bus_addr);
-	}
 	return 0;
 }
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index d3902784cae2..15eecb757619 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2877,6 +2877,7 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 {
 	struct udma_chan *uc = to_udma_chan(&vc->chan);
 	struct udma_desc *d;
+	u8 status;
 
 	if (!vd)
 		return;
@@ -2886,12 +2887,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 	if (d->metadata_size)
 		udma_fetch_epib(uc, d);
 
-	/* Provide residue information for the client */
 	if (result) {
 		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
 
 		if (cppi5_desc_get_type(desc_vaddr) ==
 		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
+			/* Provide residue information for the client */
 			result->residue = d->residue -
 					  cppi5_hdesc_get_pktlen(desc_vaddr);
 			if (result->residue)
@@ -2900,7 +2901,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 				result->result = DMA_TRANS_NOERROR;
 		} else {
 			result->residue = 0;
-			result->result = DMA_TRANS_NOERROR;
+			/* Propagate TR Response errors to the client */
+			status = d->hwdesc[0].tr_resp_base->status;
+			if (status)
+				result->result = DMA_TRANS_ABORTED;
+			else
+				result->result = DMA_TRANS_NOERROR;
 		}
 	}
 }
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 94ae27865b9e..9bc181865ecc 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -100,10 +100,9 @@ static int textual_leaf_to_string(const u32 *block, char *buf, size_t size)
  * @buf:	where to put the string
  * @size:	size of @buf, in bytes
  *
- * The string is taken from a minimal ASCII text descriptor leaf after
- * the immediate entry with @key.  The string is zero-terminated.
- * An overlong string is silently truncated such that it and the
- * zero byte fit into @size.
+ * The string is taken from a minimal ASCII text descriptor leaf just after the entry with the
+ * @key. The string is zero-terminated. An overlong string is silently truncated such that it
+ * and the zero byte fit into @size.
  *
  * Returns strlen(buf) or a negative error code.
  */
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 865ab2b34fdd..3dfb8b6c6c71 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -318,20 +318,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IEV, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_DBNC_IC, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_DBNC_IEV, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_DBNC_IC, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -343,20 +350,27 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		switch (flow_type) {
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTCLR, 1);
 			break;
 		case IRQ_TYPE_EDGE_RISING:
 		case IRQ_TYPE_EDGE_FALLING:
 		case IRQ_TYPE_EDGE_BOTH:
 			state = sprd_eic_get(chip, offset);
-			if (state)
+			if (state) {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 0);
-			else
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			} else {
 				sprd_eic_update(chip, offset,
 						SPRD_EIC_LATCH_INTPOL, 1);
+				sprd_eic_update(chip, offset,
+						SPRD_EIC_LATCH_INTCLR, 1);
+			}
 			break;
 		default:
 			return -ENOTSUPP;
@@ -370,29 +384,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_ASYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
@@ -405,29 +424,34 @@ static int sprd_eic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_FALLING:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_EDGE_BOTH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_edge_irq);
 			break;
 		case IRQ_TYPE_LEVEL_HIGH:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 1);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		case IRQ_TYPE_LEVEL_LOW:
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTBOTH, 0);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTMODE, 1);
 			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTPOL, 0);
+			sprd_eic_update(chip, offset, SPRD_EIC_SYNC_INTCLR, 1);
 			irq_set_handler_locked(data, handle_level_irq);
 			break;
 		default:
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 44ee319da1b3..12012e1645d7 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1479,6 +1479,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 0.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "PNP0C50:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 3107b9575929..eef7517c9d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -88,7 +88,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a093f1b27724..e833c02fabff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1184,6 +1184,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 8ea6c49529e7..6a22bc41c205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -241,7 +241,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 
 		/* Never sync to VM updates either. */
 		if (fence_owner == AMDGPU_FENCE_OWNER_VM &&
-		    owner != AMDGPU_FENCE_OWNER_UNDEFINED)
+		    owner != AMDGPU_FENCE_OWNER_UNDEFINED &&
+	    owner != AMDGPU_FENCE_OWNER_KFD)
 			continue;
 
 		/* Ignore fences depending on the sync mode */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 36a9e9c84ed4..272252cd0500 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1440,6 +1440,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	context->stream_mask = get_stream_mask(dc, context);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index b760f95e7fa7..5998c78ad536 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -204,7 +204,7 @@ static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
 		ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
-	struct phm_ppm_table *ptr = kzalloc(sizeof(ATOM_Tonga_PPM_Table), GFP_KERNEL);
+	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index e941c1132598..eebb2dece768 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -54,13 +54,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
 	int ret;
 
 	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
 
 	ret = i2c_master_recv(ptn_bridge->client, buf, len);
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to recv i2c data, ret=%d\n", ret);
 		return ret;
 	}
@@ -78,7 +78,7 @@ static int ptn3460_write_byte(struct ptn3460_bridge *ptn_bridge, char addr,
 	buf[1] = val;
 
 	ret = i2c_master_send(ptn_bridge->client, buf, ARRAY_SIZE(buf));
-	if (ret <= 0) {
+	if (ret < 0) {
 		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
 		return ret;
 	}
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 537e7de8e9c3..93da7b5d785b 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -411,7 +411,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 2f5b0c2bb0fe..e490ef42441f 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -570,7 +570,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	struct drm_mode_fb_cmd2 *r = data;
 	struct drm_framebuffer *fb;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0c806e99e869..83918ac1f608 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -300,7 +300,8 @@ static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	mipi_dsi_detach(dsi);
+	if (dsi->attached)
+		mipi_dsi_detach(dsi);
 	mipi_dsi_device_unregister(dsi);
 
 	return 0;
@@ -323,11 +324,18 @@ EXPORT_SYMBOL(mipi_dsi_host_unregister);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+	int ret;
 
 	if (!ops || !ops->attach)
 		return -ENOSYS;
 
-	return ops->attach(dsi->host, dsi);
+	ret = ops->attach(dsi->host, dsi);
+	if (ret)
+		return ret;
+
+	dsi->attached = true;
+
+	return 0;
 }
 EXPORT_SYMBOL(mipi_dsi_attach);
 
@@ -339,9 +347,14 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
+	if (WARN_ON(!dsi->attached))
+		return -EINVAL;
+
 	if (!ops || !ops->detach)
 		return -ENOSYS;
 
+	dsi->attached = false;
+
 	return ops->detach(dsi->host, dsi);
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24f643982903..79249568bdec 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1213,6 +1213,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 out:
 	if (fb)
 		drm_framebuffer_put(fb);
+	fb = NULL;
 	if (plane->old_fb)
 		drm_framebuffer_put(plane->old_fb);
 	plane->old_fb = NULL;
diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index c277d2fc50c6..e43dfea09527 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -318,9 +318,9 @@ static void decon_win_set_bldmod(struct decon_context *ctx, unsigned int win,
 static void decon_win_set_pixfmt(struct decon_context *ctx, unsigned int win,
 				 struct drm_framebuffer *fb)
 {
-	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane *plane = &ctx->planes[win];
 	struct exynos_drm_plane_state *state =
-		to_exynos_plane_state(plane.base.state);
+		to_exynos_plane_state(plane->base.state);
 	unsigned int alpha = state->base.alpha;
 	unsigned int pixel_alpha;
 	unsigned long val;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index dbd80f1e4c78..7e13c1550083 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -344,6 +344,7 @@ static int exynos_drm_bind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	exynos_drm_cleanup_dma(drm);
 	kfree(private);
+	dev_set_drvdata(dev, NULL);
 err_free_drm:
 	drm_dev_put(drm);
 
@@ -358,6 +359,7 @@ static void exynos_drm_unbind(struct device *dev)
 
 	exynos_drm_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -395,9 +397,18 @@ static int exynos_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void exynos_drm_platform_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (drm)
+		drm_atomic_helper_shutdown(drm);
+}
+
 static struct platform_driver exynos_drm_platform_driver = {
 	.probe	= exynos_drm_platform_probe,
 	.remove	= exynos_drm_platform_remove,
+	.shutdown = exynos_drm_platform_shutdown,
 	.driver	= {
 		.name	= "exynos-drm",
 		.pm	= &exynos_drm_pm_ops,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index bb67cad8371f..c045330f9c48 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -637,9 +637,9 @@ static void fimd_win_set_bldmod(struct fimd_context *ctx, unsigned int win,
 static void fimd_win_set_pixfmt(struct fimd_context *ctx, unsigned int win,
 				struct drm_framebuffer *fb, int width)
 {
-	struct exynos_drm_plane plane = ctx->planes[win];
+	struct exynos_drm_plane *plane = &ctx->planes[win];
 	struct exynos_drm_plane_state *state =
-		to_exynos_plane_state(plane.base.state);
+		to_exynos_plane_state(plane->base.state);
 	uint32_t pixel_format = fb->format->format;
 	unsigned int alpha = state->base.alpha;
 	u32 val = WINCONx_ENWIN;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 45e9aee8366a..bcf830c5b8ea 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1344,7 +1344,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ret = clk_prepare_enable(ctx->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(ctx->clocks[i]);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 408fc6c8a6df..44033a639419 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -45,6 +45,9 @@
 		(p) ? ((p)->hw_pp ? (p)->hw_pp->idx - PINGPONG_0 : -1) : -1, \
 		##__VA_ARGS__)
 
+#define DPU_ERROR_ENC_RATELIMITED(e, fmt, ...) DPU_ERROR_RATELIMITED("enc%d " fmt,\
+		(e) ? (e)->base.base.id : -1, ##__VA_ARGS__)
+
 /*
  * Two to anticipate panels that can do cmd/vid dynamic switching
  * plan is to create all possible physical encoder types, and switch between
@@ -2135,7 +2138,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 		return;
 	}
 
-	DPU_ERROR_ENC(dpu_enc, "frame done timeout\n");
+	DPU_ERROR_ENC_RATELIMITED(dpu_enc, "frame done timeout\n");
 
 	event = DPU_ENCODER_FRAME_EVENT_ERROR;
 	trace_dpu_enc_frame_done_timeout(DRMID(drm_enc), event);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 1c0e4c0c9ffb..bb7c7e437242 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -52,6 +52,7 @@
 	} while (0)
 
 #define DPU_ERROR(fmt, ...) pr_err("[dpu error]" fmt, ##__VA_ARGS__)
+#define DPU_ERROR_RATELIMITED(fmt, ...) pr_err_ratelimited("[dpu error]" fmt, ##__VA_ARGS__)
 
 /**
  * ktime_compare_safe - compare two ktime structures
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index be986da78c4a..172a33e8fd8f 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_print.h>
 
+#include "dp_reg.h"
 #include "dp_link.h"
 #include "dp_panel.h"
 
@@ -1078,7 +1079,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 {
-	u32 cc;
+	u32 cc = DP_MISC0_COLORIMERY_CFG_LEGACY_RGB;
 	struct dp_link_private *link;
 
 	if (!dp_link) {
@@ -1092,10 +1093,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 	 * Unless a video pattern CTS test is ongoing, use RGB_VESA
 	 * Only RGB_VESA and RGB_CEA supported for now
 	 */
-	if (dp_link_is_video_pattern_requested(link))
-		cc = link->dp_link.test_video.test_dyn_range;
-	else
-		cc = DP_TEST_DYNAMIC_RANGE_VESA;
+	if (dp_link_is_video_pattern_requested(link)) {
+		if (link->dp_link.test_video.test_dyn_range &
+					DP_TEST_DYNAMIC_RANGE_CEA)
+			cc = DP_MISC0_COLORIMERY_CFG_CEA_RGB;
+	}
 
 	return cc;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 268602803d9a..176a503ece9c 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -129,6 +129,9 @@
 #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
 #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
 
+#define DP_MISC0_COLORIMERY_CFG_LEGACY_RGB	(0)
+#define DP_MISC0_COLORIMERY_CFG_CEA_RGB		(0x04)
+
 #define REG_DP_VALID_BOUNDARY			(0x00000030)
 #define REG_DP_VALID_BOUNDARY_2			(0x00000034)
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 10eacfd95fb1..b49135f38583 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -710,6 +710,10 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
 			goto fail;
 	}
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	/* PLL init will call into clk_register which requires
 	 * register access, so we need to enable power and ahb clock.
 	 */
diff --git a/drivers/gpu/drm/nouveau/nouveau_vmm.c b/drivers/gpu/drm/nouveau/nouveau_vmm.c
index a49e88129c92..ce1d53b8597f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vmm.c
@@ -108,6 +108,9 @@ nouveau_vma_new(struct nouveau_bo *nvbo, struct nouveau_vmm *vmm,
 	} else {
 		ret = nvif_vmm_get(&vmm->vmm, PTES, false, mem->mem.page, 0,
 				   mem->mem.size, &tmp);
+		if (ret)
+			goto done;
+
 		vma->addr = tmp.addr;
 	}
 
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ee01b61a6baf..51470020ba61 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3635,6 +3635,7 @@ static const struct panel_desc tianma_tm070jdhg30 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct panel_desc tianma_tm070jvhg33 = {
@@ -3647,6 +3648,7 @@ static const struct panel_desc tianma_tm070jvhg33 = {
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
 static const struct display_timing tianma_tm070rvhg71_timing = {
diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 3c5744a91d4a..26fd2761e80d 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -168,13 +168,13 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct tidss_device *tidss = to_tidss(ddev);
 	unsigned long flags;
 
-	dev_dbg(ddev->dev,
-		"%s: %s enabled %d, needs modeset %d, event %p\n", __func__,
-		crtc->name, drm_atomic_crtc_needs_modeset(crtc->state),
-		crtc->state->enable, crtc->state->event);
+	dev_dbg(ddev->dev, "%s: %s is %sactive, %s modeset, event %p\n",
+		__func__, crtc->name, crtc->state->active ? "" : "not ",
+		drm_atomic_crtc_needs_modeset(crtc->state) ? "needs" : "doesn't need",
+		crtc->state->event);
 
 	/* There is nothing to do if CRTC is not going to be enabled. */
-	if (!crtc->state->enable)
+	if (!crtc->state->active)
 		return;
 
 	/*
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index e5d2e7e9541b..0dc55465b452 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -70,6 +70,28 @@ struct apple_key_translation {
 	u8 flags;
 };
 
+static const struct apple_key_translation apple2021_fn_keys[] = {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
+	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
+	{ KEY_F4,	KEY_SEARCH,         APPLE_FLAG_FKEY },
+	{ KEY_F5,	KEY_MICMUTE,        APPLE_FLAG_FKEY },
+	{ KEY_F6,	KEY_SLEEP,          APPLE_FLAG_FKEY },
+	{ KEY_F7,	KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
+	{ KEY_F8,	KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
+	{ KEY_F9,	KEY_NEXTSONG,       APPLE_FLAG_FKEY },
+	{ KEY_F10,	KEY_MUTE,           APPLE_FLAG_FKEY },
+	{ KEY_F11,	KEY_VOLUMEDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F12,	KEY_VOLUMEUP,       APPLE_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static const struct apple_key_translation macbookair_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -204,7 +226,9 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
+		if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021)
+			table = apple2021_fn_keys;
+		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
 		else if (hid->product < 0x21d || hid->product >= 0x300)
@@ -363,6 +387,9 @@ static void apple_setup_input(struct input_dev *input)
 	for (trans = apple_iso_keyboard; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
 
+	for (trans = apple2021_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
 	if (swap_fn_leftctrl) {
 		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
 			set_bit(trans->to, input->keybit);
@@ -624,6 +651,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY),
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
+		.driver_data = APPLE_HAS_FN },
 
 	{ }
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6273ab615af8..0732fe6c7a85 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -173,6 +173,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL3	0x8241
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 1b3a83fa7616..67953cdae31c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -309,6 +309,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021) },
 #endif
 #if IS_ENABLED(CONFIG_HID_APPLEIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1a7e1d3e7a37..eacbd7eae2e6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2088,7 +2088,7 @@ static int wacom_allocate_inputs(struct wacom *wacom)
 	return 0;
 }
 
-static int wacom_register_inputs(struct wacom *wacom)
+static int wacom_setup_inputs(struct wacom *wacom)
 {
 	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
@@ -2107,10 +2107,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pen_input_dev);
 		wacom_wac->pen_input = NULL;
 		pen_input_dev = NULL;
-	} else {
-		error = input_register_device(pen_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_touch_input_capabilities(touch_input_dev, wacom_wac);
@@ -2119,10 +2115,6 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(touch_input_dev);
 		wacom_wac->touch_input = NULL;
 		touch_input_dev = NULL;
-	} else {
-		error = input_register_device(touch_input_dev);
-		if (error)
-			goto fail;
 	}
 
 	error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
@@ -2131,7 +2123,34 @@ static int wacom_register_inputs(struct wacom *wacom)
 		input_free_device(pad_input_dev);
 		wacom_wac->pad_input = NULL;
 		pad_input_dev = NULL;
-	} else {
+	}
+
+	return 0;
+}
+
+static int wacom_register_inputs(struct wacom *wacom)
+{
+	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	int error = 0;
+
+	pen_input_dev = wacom_wac->pen_input;
+	touch_input_dev = wacom_wac->touch_input;
+	pad_input_dev = wacom_wac->pad_input;
+
+	if (pen_input_dev) {
+		error = input_register_device(pen_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (touch_input_dev) {
+		error = input_register_device(touch_input_dev);
+		if (error)
+			goto fail;
+	}
+
+	if (pad_input_dev) {
 		error = input_register_device(pad_input_dev);
 		if (error)
 			goto fail;
@@ -2381,6 +2400,20 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
+	error = wacom_setup_inputs(wacom);
+	if (error)
+		goto fail;
+
+	if (features->type == HID_GENERIC)
+		connect_mask |= HID_CONNECT_DRIVER;
+
+	/* Regular HID work starts now */
+	error = hid_hw_start(hdev, connect_mask);
+	if (error) {
+		hid_err(hdev, "hw start failed\n");
+		goto fail;
+	}
+
 	error = wacom_register_inputs(wacom);
 	if (error)
 		goto fail;
@@ -2395,16 +2428,6 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 			goto fail;
 	}
 
-	if (features->type == HID_GENERIC)
-		connect_mask |= HID_CONNECT_DRIVER;
-
-	/* Regular HID work starts now */
-	error = hid_hw_start(hdev, connect_mask);
-	if (error) {
-		hid_err(hdev, "hw start failed\n");
-		goto fail;
-	}
-
 	if (!wireless) {
 		/* Note that if query fails it is not a hard failure */
 		wacom_query_tablet_data(wacom);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 726a5d76615d..c454768ffb49 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2540,7 +2540,14 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
-			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			/*
+			 * xf86-input-wacom does not accept a serial number
+			 * of '0'. Report the low 32 bits if possible, but
+			 * if they are zero, report the upper ones instead.
+			 */
+			__u32 serial_lo = wacom_wac->serial[0] & 0xFFFFFFFFu;
+			__u32 serial_hi = wacom_wac->serial[0] >> 32;
+			input_event(input, EV_MSC, MSC_SERIAL, (int)(serial_lo ? serial_lo : serial_hi));
 			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3d8239fd66ed..3dc97041a704 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -194,6 +194,8 @@ struct aspeed_pwm_tacho_data {
 	u8 fan_tach_ch_source[16];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
+	/* protects access to shared ASPEED_PTCR_RESULT */
+	struct mutex tach_lock;
 };
 
 enum type { TYPEM, TYPEN, TYPEO };
@@ -528,6 +530,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 	u8 fan_tach_ch_source, type, mode, both;
 	int ret;
 
+	mutex_lock(&priv->tach_lock);
+
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0x1 << fan_tach_ch);
 
@@ -545,6 +549,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 		ASPEED_RPM_STATUS_SLEEP_USEC,
 		usec);
 
+	mutex_unlock(&priv->tach_lock);
+
 	/* return -ETIMEDOUT if we didn't get an answer. */
 	if (ret)
 		return ret;
@@ -904,6 +910,7 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	mutex_init(&priv->tach_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
 			&aspeed_pwm_tacho_regmap_config);
 	if (IS_ERR(priv->regmap))
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5b2057ce5a59..d67d972d18aa 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -380,7 +380,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int attr_no)
+			     int index)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -392,13 +392,20 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		/*
+		 * We map the attr number to core id of the CPU
+		 * The attr number is always core id + 2
+		 * The Pkgtemp will always show up as temp1_*, if available
+		 */
+		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = attr_no;
+		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -456,27 +463,22 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, index;
 
 	/*
-	 * Find attr number for sysfs:
-	 * We map the attr number to core id of the CPU
-	 * The attr number is always core id + 2
-	 * The Pkgtemp will always show up as temp1_*, if available
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
 	 */
 	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
+		index = PKG_SYSFS_ATTR_NO;
 	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
-		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
-	}
 
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
+		pdata->cpu_map[index] = topology_core_id(cpu);
+		index += BASE_SYSFS_ATTR_NO;
 	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -508,20 +510,20 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		}
 	}
 
-	pdata->core_data[attr_no] = tdata;
+	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
 	if (err)
 		goto exit_free;
 
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
+	pdata->core_data[index] = NULL;
 	kfree(tdata);
 ida_free:
 	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 	return err;
 }
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index cb8f56022592..d6b945f5b887 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -540,12 +540,13 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
+	/* Set block buffer mode */
+	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
 
-	/* Use 32-byte buffer to process this transaction */
 	if (read_write == I2C_SMBUS_WRITE) {
 		len = data->block[0];
 		outb_p(len, SMBHSTDAT0(priv));
+		inb_p(SMBHSTCNT(priv));	/* reset the data buffer index */
 		for (i = 0; i < len; i++)
 			outb_p(data->block[i+1], SMBBLKDAT(priv));
 	}
@@ -561,6 +562,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 			return -EPROTO;
 
 		data->block[0] = len;
+		inb_p(SMBHSTCNT(priv));	/* reset the data buffer index */
 		for (i = 0; i < len; i++)
 			data->block[i + 1] = inb_p(SMBBLKDAT(priv));
 	}
@@ -780,14 +782,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	return i801_check_post(priv, status);
 }
 
-static int i801_set_block_buffer_mode(struct i801_priv *priv)
-{
-	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
-	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) == 0)
-		return -EIO;
-	return 0;
-}
-
 /* Block transaction function */
 static int i801_block_transaction(struct i801_priv *priv,
 				  union i2c_smbus_data *data, char read_write,
@@ -817,9 +811,8 @@ static int i801_block_transaction(struct i801_priv *priv,
 	/* Experience has shown that the block buffer can only be used for
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
-	if ((priv->features & FEATURE_BLOCK_BUFFER)
-	 && command != I2C_SMBUS_I2C_BLOCK_DATA
-	 && i801_set_block_buffer_mode(priv) == 0)
+	if ((priv->features & FEATURE_BLOCK_BUFFER) &&
+	    command != I2C_SMBUS_I2C_BLOCK_DATA)
 		result = i801_block_transaction_by_block(priv, data,
 							 read_write,
 							 command, hwpec);
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 6b9df33ac561..6b126fce5a9e 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -77,7 +77,8 @@
 #define PRESCL_CTRL0			0x14
 #define PRESCL_CTRL0_I2C(x)		((x) << 16)
 #define PRESCL_CTRL0_I3C(x)		(x)
-#define PRESCL_CTRL0_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I3C_MAX		GENMASK(9, 0)
+#define PRESCL_CTRL0_I2C_MAX		GENMASK(15, 0)
 
 #define PRESCL_CTRL1			0x18
 #define PRESCL_CTRL1_PP_LOW_MASK	GENMASK(15, 8)
@@ -1234,7 +1235,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 
 	pres = DIV_ROUND_UP(sysclk_rate, (bus->scl_rate.i3c * 4)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I3C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i3c = sysclk_rate / ((pres + 1) * 4);
@@ -1247,7 +1248,7 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	max_i2cfreq = bus->scl_rate.i2c;
 
 	pres = (sysclk_rate / (max_i2cfreq * 5)) - 1;
-	if (pres > PRESCL_CTRL0_MAX)
+	if (pres > PRESCL_CTRL0_I2C_MAX)
 		return -ERANGE;
 
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 8acf277b8b25..1c82840ac32a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -128,10 +128,12 @@ config BMA400
 
 config BMA400_I2C
 	tristate
+	select REGMAP_I2C
 	depends on BMA400
 
 config BMA400_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA400
 
 config BMC150_ACCEL
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 811f04448d8d..76002b91c86a 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -28,6 +29,7 @@
 #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
 
 /* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
 #define AD7091R_REG_CONF_AUTO   BIT(8)
 #define AD7091R_REG_CONF_CMD    BIT(10)
 
@@ -49,6 +51,27 @@ struct ad7091r_state {
 	struct mutex lock; /*lock to prevent concurent reads */
 };
 
+const struct iio_event_spec ad7091r_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+EXPORT_SYMBOL_NS_GPL(ad7091r_events, IIO_AD7091R);
+
 static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
 {
 	int ret, conf;
@@ -168,8 +191,142 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 	return ret;
 }
 
+static int ad7091r_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_HIGH_LIMIT;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+				  &val);
+		if (ret)
+			return ret;
+		return val != AD7091R_LOW_LIMIT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, int state)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	if (state) {
+		return regmap_set_bits(st->map, AD7091R_REG_CONF,
+				       AD7091R_REG_CONF_ALERT_EN);
+	} else {
+		/*
+		 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to
+		 * prevent alerts and thus disable event generation.
+		 */
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    AD7091R_HIGH_LIMIT);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    AD7091R_LOW_LIMIT);
+		default:
+			return -EINVAL;
+		}
+	}
+}
+
+static int ad7091r_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(st->map,
+					  AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					  val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = regmap_read(st->map,
+				  AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				  val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7091r_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val, int val2)
+{
+	struct ad7091r_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_HIGH_LIMIT(chan->channel),
+					    val);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->map,
+					    AD7091R_REG_CH_LOW_LIMIT(chan->channel),
+					    val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		return regmap_write(st->map,
+				    AD7091R_REG_CH_HYSTERESIS(chan->channel),
+				    val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad7091r_info = {
 	.read_raw = ad7091r_read_raw,
+	.read_event_config = &ad7091r_read_event_config,
+	.write_event_config = &ad7091r_write_event_config,
+	.read_event_value = &ad7091r_read_event_value,
+	.write_event_value = &ad7091r_write_event_value,
 };
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
@@ -232,6 +389,11 @@ int ad7091r_probe(struct device *dev, const char *name,
 	iio_dev->channels = chip_info->channels;
 
 	if (irq) {
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
+		if (ret)
+			return ret;
+
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
@@ -243,7 +405,14 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+
 		st->vref = NULL;
+		/* Enable internal vref */
+		ret = regmap_set_bits(st->map, AD7091R_REG_CONF,
+				      AD7091R_REG_CONF_INT_VREF);
+		if (ret)
+			return dev_err_probe(st->dev, ret,
+					     "Error on enable internal reference\n");
 	} else {
 		ret = regulator_enable(st->vref);
 		if (ret)
@@ -260,7 +429,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	return devm_iio_device_register(dev, iio_dev);
 }
-EXPORT_SYMBOL_GPL(ad7091r_probe);
+EXPORT_SYMBOL_NS_GPL(ad7091r_probe, IIO_AD7091R);
 
 static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
@@ -290,7 +459,7 @@ const struct regmap_config ad7091r_regmap_config = {
 	.writeable_reg = ad7091r_writeable_reg,
 	.volatile_reg = ad7091r_volatile_reg,
 };
-EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
+EXPORT_SYMBOL_NS_GPL(ad7091r_regmap_config, IIO_AD7091R);
 
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 509748aef9b1..b9e1c8bf3440 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,12 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_CONF_INT_VREF	BIT(0)
+
+/* AD7091R_REG_CH_LIMIT */
+#define AD7091R_HIGH_LIMIT		0xFFF
+#define AD7091R_LOW_LIMIT		0x0
+
 struct device;
 struct ad7091r_state;
 
@@ -17,6 +23,8 @@ struct ad7091r_chip_info {
 	unsigned int vref_mV;
 };
 
+extern const struct iio_event_spec ad7091r_events[3];
+
 extern const struct regmap_config ad7091r_regmap_config;
 
 int ad7091r_probe(struct device *dev, const char *name,
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 9665679c3ea6..12d475463945 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -12,26 +12,6 @@
 
 #include "ad7091r-base.h"
 
-static const struct iio_event_spec ad7091r5_events[] = {
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE),
-	},
-	{
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
-	},
-};
-
 #define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
 	.type = IIO_VOLTAGE, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
@@ -44,10 +24,10 @@ static const struct iio_event_spec ad7091r5_events[] = {
 	.scan_type.realbits = bits, \
 }
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
-	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
-	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(0, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r_events, ARRAY_SIZE(ad7091r_events)),
 };
 
 static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
@@ -111,3 +91,4 @@ module_i2c_driver(ad7091r5_driver);
 MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD7091R);
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 720234a91db1..e7690d38621a 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -538,6 +538,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	struct rm3100_data *data;
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -596,9 +597,14 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
 	/* Initializing max wait time, which is double conversion time. */
-	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
-				* 2;
+	data->conversion_time = rm3100_samp_rates[samp_rate_index][2] * 2;
 
 	/* Cycle count values may not be what we want. */
 	if ((tmp - RM3100_TMRC_OFFSET) == 0)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 86e4ed64e4e2..e009123c703b 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -542,21 +542,18 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 			/* SM supports sendonly-fullmember, otherwise fallback to full-member */
 			rec.join_state = SENDONLY_FULLMEMBER_JOIN;
 	}
-	spin_unlock_irq(&priv->lock);
 
 	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
-					 &rec, comp_mask, GFP_KERNEL,
+					 &rec, comp_mask, GFP_ATOMIC,
 					 ipoib_mcast_join_complete, mcast);
-	spin_lock_irq(&priv->lock);
 	if (IS_ERR(multicast)) {
 		ret = PTR_ERR(multicast);
 		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
 		/* Requeue this join task with a backoff delay */
 		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
-		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
-		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 4912582c54da..3e73eb465e18 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -802,7 +802,6 @@ static int atkbd_probe(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
-	bool skip_getid;
 
 /*
  * Some systems, where the bit-twiddling when testing the io-lines of the
@@ -816,6 +815,11 @@ static int atkbd_probe(struct atkbd *atkbd)
 				 "keyboard reset failed on %s\n",
 				 ps2dev->serio->phys);
 
+	if (atkbd_skip_getid(atkbd)) {
+		atkbd->id = 0xab83;
+		return 0;
+	}
+
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
  * Some keyboards report different values, but the first byte is always 0xab or
@@ -824,18 +828,17 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	skip_getid = atkbd_skip_getid(atkbd);
-	if (skip_getid || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command was skipped or failed, we check if we can at least set
+ * If the get ID command failed, we check if we can at least set
  * the LEDs on the keyboard. This should work on every keyboard out there.
  * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
-		atkbd->id = skip_getid ? 0xab83 : 0xabba;
+		atkbd->id = 0xabba;
 		return 0;
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 124ab98ea43a..cd21c92a6b2c 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1179,6 +1179,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
 					SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index a4aee16db531..a46a4f83682f 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -2,7 +2,7 @@
 /*
  * Generic Broadcom Set Top Box Level 2 Interrupt controller driver
  *
- * Copyright (C) 2014-2017 Broadcom
+ * Copyright (C) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME	": " fmt
@@ -113,6 +113,9 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 		generic_handle_irq(irq_linear_revmap(b->domain, irq));
 	} while (status);
 out:
+	/* Don't ack parent before all device writes are done */
+	wmb();
+
 	chained_irq_exit(chip, desc);
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f1fa98e5ea13..c1f3cd82caf3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3782,8 +3782,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int from, cpu = cpumask_first(mask_val);
+	struct cpumask common, *table_mask;
 	unsigned long flags;
+	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3799,19 +3800,22 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
 	 */
 	from = vpe_to_cpuid_lock(vpe, &flags);
-	if (from == cpu)
-		goto out;
-
-	vpe->col_idx = cpu;
+	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
 	/*
-	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
-	 * is sharing its VPE table with the current one.
+	 * If we are offered another CPU in the same GICv4.1 ITS
+	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
-	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+	if (table_mask && cpumask_and(&common, mask_val, table_mask))
+		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (from == cpu)
 		goto out;
 
+	vpe->col_idx = cpu;
+
 	its_send_vmovp(vpe);
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
diff --git a/drivers/leds/trigger/ledtrig-panic.c b/drivers/leds/trigger/ledtrig-panic.c
index 5751cd032f9d..4bf232465dfd 100644
--- a/drivers/leds/trigger/ledtrig-panic.c
+++ b/drivers/leds/trigger/ledtrig-panic.c
@@ -63,10 +63,13 @@ static long led_panic_blink(int state)
 
 static int __init ledtrig_panic_init(void)
 {
+	led_trigger_register_simple("panic", &trigger);
+	if (!trigger)
+		return -ENOMEM;
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &led_trigger_panic_nb);
 
-	led_trigger_register_simple("panic", &trigger);
 	panic_blink = led_panic_blink;
 	return 0;
 }
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3db92d9a030b..ff73b2c17be5 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -19,6 +19,8 @@
 #include "dm.h"
 
 #define DM_RESERVED_MAX_IOS		1024
+#define DM_MAX_TARGETS			1048576
+#define DM_MAX_TARGET_PARAMS		1024
 
 struct dm_kobject_holder {
 	struct kobject kobj;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 5f9b9178c647..4184c8a2d497 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1760,7 +1760,8 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	if (copy_from_user(param_kernel, user, minimum_data_size))
 		return -EFAULT;
 
-	if (param_kernel->data_size < minimum_data_size)
+	if (unlikely(param_kernel->data_size < minimum_data_size) ||
+	    unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS))
 		return -EINVAL;
 
 	secure_data = param_kernel->flags & DM_SECURE_DATA_FLAG;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5c590895c14c..31bcdcd93c7a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -144,7 +144,12 @@ static int alloc_targets(struct dm_table *t, unsigned int num)
 int dm_table_create(struct dm_table **result, fmode_t mode,
 		    unsigned num_targets, struct mapped_device *md)
 {
-	struct dm_table *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	struct dm_table *t;
+
+	if (num_targets > DM_MAX_TARGETS)
+		return -EOVERFLOW;
+
+	t = kzalloc(sizeof(*t), GFP_KERNEL);
 
 	if (!t)
 		return -ENOMEM;
@@ -158,7 +163,7 @@ int dm_table_create(struct dm_table **result, fmode_t mode,
 
 	if (!num_targets) {
 		kfree(t);
-		return -ENOMEM;
+		return -EOVERFLOW;
 	}
 
 	if (alloc_targets(t, num_targets)) {
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6efe49f7bdf5..03d2e31dda2f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1179,6 +1179,7 @@ struct super_type  {
 					  struct md_rdev *refdev,
 					  int minor_version);
 	int		    (*validate_super)(struct mddev *mddev,
+					      struct md_rdev *freshest,
 					      struct md_rdev *rdev);
 	void		    (*sync_super)(struct mddev *mddev,
 					  struct md_rdev *rdev);
@@ -1317,8 +1318,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 
 /*
  * validate_super for 0.90.0
+ * note: we are not using "freshest" for 0.9 superblock
  */
-static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = page_address(rdev->sb_page);
@@ -1833,7 +1835,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	return ret;
 }
 
-static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
@@ -1929,13 +1931,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count) */
-		++ev1;
+		 * spares (which don't need an event count).
+		 * Similar to mdadm, we allow event counter difference of 1
+		 * from the freshest device.
+		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
 		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
 		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
-			if (ev1 < mddev->events)
+			if (ev1 + 1 < mddev->events)
 				return -EINVAL;
 	} else if (mddev->bitmap) {
 		/* If adding to array with a bitmap, then we can accept an
@@ -1956,8 +1960,38 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
 			role = MD_DISK_ROLE_SPARE;
 			rdev->desc_nr = -1;
-		} else
+		} else if (mddev->pers == NULL && freshest && ev1 < mddev->events) {
+			/*
+			 * If we are assembling, and our event counter is smaller than the
+			 * highest event counter, we cannot trust our superblock about the role.
+			 * It could happen that our rdev was marked as Faulty, and all other
+			 * superblocks were updated with +1 event counter.
+			 * Then, before the next superblock update, which typically happens when
+			 * remove_and_add_spares() removes the device from the array, there was
+			 * a crash or reboot.
+			 * If we allow current rdev without consulting the freshest superblock,
+			 * we could cause data corruption.
+			 * Note that in this case our event counter is smaller by 1 than the
+			 * highest, otherwise, this rdev would not be allowed into array;
+			 * both kernel and mdadm allow event counter difference of 1.
+			 */
+			struct mdp_superblock_1 *freshest_sb = page_address(freshest->sb_page);
+			u32 freshest_max_dev = le32_to_cpu(freshest_sb->max_dev);
+
+			if (rdev->desc_nr >= freshest_max_dev) {
+				/* this is unexpected, better not proceed */
+				pr_warn("md: %s: rdev[%pg]: desc_nr(%d) >= freshest(%pg)->sb->max_dev(%u)\n",
+						mdname(mddev), rdev->bdev, rdev->desc_nr,
+						freshest->bdev, freshest_max_dev);
+				return -EUCLEAN;
+			}
+
+			role = le16_to_cpu(freshest_sb->dev_roles[rdev->desc_nr]);
+			pr_debug("md: %s: rdev[%pg]: role=%d(0x%x) according to freshest %pg\n",
+				     mdname(mddev), rdev->bdev, role, role, freshest->bdev);
+		} else {
 			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+		}
 		switch(role) {
 		case MD_DISK_ROLE_SPARE: /* spare */
 			break;
@@ -2896,7 +2930,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 * and should be added immediately.
 		 */
 		super_types[mddev->major_version].
-			validate_super(mddev, rdev);
+			validate_super(mddev, NULL/*freshest*/, rdev);
 		if (add_journal)
 			mddev_suspend(mddev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
@@ -3814,7 +3848,7 @@ static int analyze_sbs(struct mddev *mddev)
 	}
 
 	super_types[mddev->major_version].
-		validate_super(mddev, freshest);
+		validate_super(mddev, NULL/*freshest*/, freshest);
 
 	i = 0;
 	rdev_for_each_safe(rdev, tmp, mddev) {
@@ -3829,7 +3863,7 @@ static int analyze_sbs(struct mddev *mddev)
 		}
 		if (rdev != freshest) {
 			if (super_types[mddev->major_version].
-			    validate_super(mddev, rdev)) {
+			    validate_super(mddev, freshest, rdev)) {
 				pr_warn("md: kicking non-fresh %s from array!\n",
 					bdevname(rdev->bdev,b));
 				md_kick_rdev_from_array(rdev);
@@ -6817,7 +6851,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 			rdev->saved_raid_disk = rdev->raid_disk;
 		} else
 			super_types[mddev->major_version].
-				validate_super(mddev, rdev);
+				validate_super(mddev, NULL/*freshest*/, rdev);
 		if ((info->state & (1<<MD_DISK_SYNC)) &&
 		     rdev->raid_disk != info->raid_disk) {
 			/* This was a hot-add request, but events doesn't
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9f114b9d8dc6..00995e60d46b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6520,18 +6519,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..bb7fb6402d6e 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -247,7 +247,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index 36109c324cb6..3519c2252ae8 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -977,13 +977,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	if (ret < 0)
 		goto dec_end;
 
-	schedule_delayed_work(&jpeg->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
-
 	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
 	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
 		goto dec_end;
 
+	schedule_delayed_work(&jpeg->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index e3246344fb72..bcbbd1408b36 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -187,25 +187,16 @@ static int rga_setup_ctrls(struct rga_ctx *ctx)
 static struct rga_fmt formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_ARGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
+		.color_swap = RGA_COLOR_ALPHA_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
 		.y_div = 1,
 		.x_div = 1,
 	},
-	{
-		.fourcc = V4L2_PIX_FMT_XRGB32,
-		.color_swap = RGA_COLOR_RB_SWAP,
-		.hw_format = RGA_COLOR_FMT_XBGR8888,
-		.depth = 32,
-		.uv_factor = 1,
-		.y_div = 1,
-		.x_div = 1,
-	},
 	{
 		.fourcc = V4L2_PIX_FMT_ABGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_ABGR8888,
 		.depth = 32,
 		.uv_factor = 1,
@@ -214,7 +205,7 @@ static struct rga_fmt formats[] = {
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_XBGR32,
-		.color_swap = RGA_COLOR_ALPHA_SWAP,
+		.color_swap = RGA_COLOR_RB_SWAP,
 		.hw_format = RGA_COLOR_FMT_XBGR8888,
 		.depth = 32,
 		.uv_factor = 1,
diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index afae0afe3f81..a8c55e4bfaee 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -249,7 +249,7 @@ int lirc_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (attr->attach_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
@@ -274,7 +274,7 @@ int lirc_prog_detach(const union bpf_attr *attr)
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
 
-	rcdev = rc_dev_get_from_fd(attr->target_fd);
+	rcdev = rc_dev_get_from_fd(attr->target_fd, true);
 	if (IS_ERR(rcdev)) {
 		bpf_prog_put(prog);
 		return PTR_ERR(rcdev);
@@ -299,7 +299,7 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (attr->query.query_flags)
 		return -EINVAL;
 
-	rcdev = rc_dev_get_from_fd(attr->query.target_fd);
+	rcdev = rc_dev_get_from_fd(attr->query.target_fd, false);
 	if (IS_ERR(rcdev))
 		return PTR_ERR(rcdev);
 
diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 7f394277478b..cd2fddf003bd 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -324,6 +324,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_EXIT), STATE_RESET);
 	if (err) {
 		dev_err(irtoy->dev, "exit sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
@@ -331,6 +332,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_ENTER), STATE_COMMAND);
 	if (err) {
 		dev_err(irtoy->dev, "enter sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 9c888047fa99..14243ce03b46 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -826,7 +826,7 @@ void __exit lirc_dev_exit(void)
 	unregister_chrdev_region(lirc_base_dev, RC_DEV_MAX);
 }
 
-struct rc_dev *rc_dev_get_from_fd(int fd)
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 {
 	struct fd f = fdget(fd);
 	struct lirc_fh *fh;
@@ -840,6 +840,9 @@ struct rc_dev *rc_dev_get_from_fd(int fd)
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (write && !(f.file->f_mode & FMODE_WRITE))
+		return ERR_PTR(-EPERM);
+
 	fh = f.file->private_data;
 	dev = fh->rc;
 
diff --git a/drivers/media/rc/rc-core-priv.h b/drivers/media/rc/rc-core-priv.h
index 62f032dffd33..dfe0352c0f0a 100644
--- a/drivers/media/rc/rc-core-priv.h
+++ b/drivers/media/rc/rc-core-priv.h
@@ -325,7 +325,7 @@ void lirc_raw_event(struct rc_dev *dev, struct ir_raw_event ev);
 void lirc_scancode_event(struct rc_dev *dev, struct lirc_scancode *lsc);
 int lirc_register(struct rc_dev *dev);
 void lirc_unregister(struct rc_dev *dev);
-struct rc_dev *rc_dev_get_from_fd(int fd);
+struct rc_dev *rc_dev_get_from_fd(int fd, bool write);
 #else
 static inline int lirc_dev_init(void) { return 0; }
 static inline void lirc_dev_exit(void) {}
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 202b084f65a2..4cf540d1b250 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/*
 	 * TODO: These stk1160_dbg are very spammy!
-	 * We should 1) check why we are getting them
-	 * and 2) add ratelimit.
+	 * We should check why we are getting them.
 	 *
 	 * UPDATE: One of the reasons (the only one?) for getting these
 	 * is incorrect standard (mismatch between expected and configured).
@@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 
 	/* Let the bug hunt begin! sanity checks! */
 	if (lencopy < 0) {
-		stk1160_dbg("copy skipped: negative lencopy\n");
+		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
 		return;
 	}
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b8847ae04d93..c5c6608ccc84 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1382,6 +1382,7 @@ config MFD_DAVINCI_VOICECODEC
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9822efdc6cc2..af050cfdcb8f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1592,7 +1592,7 @@ static int fastrpc_cb_remove(struct platform_device *pdev)
 	int i;
 
 	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 1; i < FASTRPC_MAX_SESSIONS; i++) {
+	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
 		if (cctx->session[i].sid == sess->sid) {
 			cctx->session[i].valid = false;
 			cctx->sesscount--;
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8d842ff241b2..2058f31a1bce 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -346,6 +346,10 @@ struct mmc_blk_ioc_data {
 	struct mmc_ioc_cmd ic;
 	unsigned char *buf;
 	u64 buf_bytes;
+	unsigned int flags;
+#define MMC_BLK_IOC_DROP	BIT(0)	/* drop this mrq */
+#define MMC_BLK_IOC_SBC	BIT(1)	/* use mrq.sbc */
+
 	struct mmc_rpmb_data *rpmb;
 };
 
@@ -447,7 +451,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 }
 
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
-			       struct mmc_blk_ioc_data *idata)
+			       struct mmc_blk_ioc_data **idatas, int i)
 {
 	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {};
@@ -455,10 +459,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct scatterlist sg;
 	int err;
 	unsigned int target_part;
+	struct mmc_blk_ioc_data *idata = idatas[i];
+	struct mmc_blk_ioc_data *prev_idata = NULL;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
 
+	if (idata->flags & MMC_BLK_IOC_DROP)
+		return 0;
+
+	if (idata->flags & MMC_BLK_IOC_SBC)
+		prev_idata = idatas[i - 1];
+
 	/*
 	 * The RPMB accesses comes in from the character device, so we
 	 * need to target these explicitly. Else we just target the
@@ -525,7 +537,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (idata->rpmb) {
+	if (idata->rpmb || prev_idata) {
 		sbc.opcode = MMC_SET_BLOCK_COUNT;
 		/*
 		 * We don't do any blockcount validation because the max size
@@ -533,6 +545,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * 'Reliable Write' bit here.
 		 */
 		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		if (prev_idata)
+			sbc.arg = prev_idata->ic.arg;
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
@@ -544,6 +558,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 
+	if (prev_idata) {
+		memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc.resp));
+		if (sbc.error) {
+			dev_err(mmc_dev(card->host), "%s: sbc error %d\n",
+							__func__, sbc.error);
+			return sbc.error;
+		}
+	}
+
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
@@ -985,6 +1008,20 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
 	md->reset_done &= ~type;
 }
 
+static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq)
+{
+	struct mmc_blk_ioc_data **idata = mq_rq->drv_op_data;
+	int i;
+
+	for (i = 1; i < mq_rq->ioc_count; i++) {
+		if (idata[i - 1]->ic.opcode == MMC_SET_BLOCK_COUNT &&
+		    mmc_op_multi(idata[i]->ic.opcode)) {
+			idata[i - 1]->flags |= MMC_BLK_IOC_DROP;
+			idata[i]->flags |= MMC_BLK_IOC_SBC;
+		}
+	}
+}
+
 /*
  * The non-block commands come back from the block layer after it queued it and
  * processed it with all other requests and then they get issued in this
@@ -1012,11 +1049,14 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 			if (ret)
 				break;
 		}
+
+		mmc_blk_check_sbc(mq_rq);
+
 		fallthrough;
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata, i);
 			if (ret)
 				break;
 		}
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 05e907451df9..681653d097ef 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -62,11 +62,15 @@ int mmc_gpio_alloc(struct mmc_host *host)
 int mmc_gpio_get_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int cansleep;
 
 	if (!ctx || !ctx->ro_gpio)
 		return -ENOSYS;
 
-	return gpiod_get_value_cansleep(ctx->ro_gpio);
+	cansleep = gpiod_cansleep(ctx->ro_gpio);
+	return cansleep ?
+		gpiod_get_value_cansleep(ctx->ro_gpio) :
+		gpiod_get_value(ctx->ro_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_ro);
 
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 1d814919eb6b..a1fb5d0e9553 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bio.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direction.h>
 #include <linux/crc7.h>
 #include <linux/crc-itu-t.h>
 #include <linux/scatterlist.h>
@@ -119,19 +119,14 @@ struct mmc_spi_host {
 	struct spi_transfer	status;
 	struct spi_message	readback;
 
-	/* underlying DMA-aware controller, or null */
-	struct device		*dma_dev;
-
 	/* buffer used for commands and for message "overhead" */
 	struct scratch		*data;
-	dma_addr_t		data_dma;
 
 	/* Specs say to write ones most of the time, even when the card
 	 * has no need to read its input data; and many cards won't care.
 	 * This is our source of those ones.
 	 */
 	void			*ones;
-	dma_addr_t		ones_dma;
 };
 
 
@@ -147,11 +142,8 @@ static inline int mmc_cs_off(struct mmc_spi_host *host)
 	return spi_setup(host->spi);
 }
 
-static int
-mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
+static int mmc_spi_readbytes(struct mmc_spi_host *host, unsigned int len)
 {
-	int status;
-
 	if (len > sizeof(*host->data)) {
 		WARN_ON(1);
 		return -EIO;
@@ -159,19 +151,7 @@ mmc_spi_readbytes(struct mmc_spi_host *host, unsigned len)
 
 	host->status.len = len;
 
-	if (host->dma_dev)
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_FROM_DEVICE);
-
-	status = spi_sync_locked(host->spi, &host->readback);
-
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_FROM_DEVICE);
-
-	return status;
+	return spi_sync_locked(host->spi, &host->readback);
 }
 
 static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
@@ -513,23 +493,11 @@ mmc_spi_command_send(struct mmc_spi_host *host,
 	t = &host->t;
 	memset(t, 0, sizeof(*t));
 	t->tx_buf = t->rx_buf = data->status;
-	t->tx_dma = t->rx_dma = host->data_dma;
 	t->len = cp - data->status;
 	t->cs_change = 1;
 	spi_message_add_tail(t, &host->m);
 
-	if (host->dma_dev) {
-		host->m.is_dma_mapped = 1;
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
-	}
 	status = spi_sync_locked(host->spi, &host->m);
-
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
 	if (status < 0) {
 		dev_dbg(&host->spi->dev, "  ... write returned %d\n", status);
 		cmd->error = status;
@@ -547,9 +515,6 @@ mmc_spi_command_send(struct mmc_spi_host *host,
  * We always provide TX data for data and CRC.  The MMC/SD protocol
  * requires us to write ones; but Linux defaults to writing zeroes;
  * so we explicitly initialize it to all ones on RX paths.
- *
- * We also handle DMA mapping, so the underlying SPI controller does
- * not need to (re)do it for each message.
  */
 static void
 mmc_spi_setup_data_message(
@@ -559,11 +524,8 @@ mmc_spi_setup_data_message(
 {
 	struct spi_transfer	*t;
 	struct scratch		*scratch = host->data;
-	dma_addr_t		dma = host->data_dma;
 
 	spi_message_init(&host->m);
-	if (dma)
-		host->m.is_dma_mapped = 1;
 
 	/* for reads, readblock() skips 0xff bytes before finding
 	 * the token; for writes, this transfer issues that token.
@@ -577,8 +539,6 @@ mmc_spi_setup_data_message(
 		else
 			scratch->data_token = SPI_TOKEN_SINGLE;
 		t->tx_buf = &scratch->data_token;
-		if (dma)
-			t->tx_dma = dma + offsetof(struct scratch, data_token);
 		spi_message_add_tail(t, &host->m);
 	}
 
@@ -588,7 +548,6 @@ mmc_spi_setup_data_message(
 	t = &host->t;
 	memset(t, 0, sizeof(*t));
 	t->tx_buf = host->ones;
-	t->tx_dma = host->ones_dma;
 	/* length and actual buffer info are written later */
 	spi_message_add_tail(t, &host->m);
 
@@ -598,14 +557,9 @@ mmc_spi_setup_data_message(
 	if (direction == DMA_TO_DEVICE) {
 		/* the actual CRC may get written later */
 		t->tx_buf = &scratch->crc_val;
-		if (dma)
-			t->tx_dma = dma + offsetof(struct scratch, crc_val);
 	} else {
 		t->tx_buf = host->ones;
-		t->tx_dma = host->ones_dma;
 		t->rx_buf = &scratch->crc_val;
-		if (dma)
-			t->rx_dma = dma + offsetof(struct scratch, crc_val);
 	}
 	spi_message_add_tail(t, &host->m);
 
@@ -628,10 +582,7 @@ mmc_spi_setup_data_message(
 		memset(t, 0, sizeof(*t));
 		t->len = (direction == DMA_TO_DEVICE) ? sizeof(scratch->status) : 1;
 		t->tx_buf = host->ones;
-		t->tx_dma = host->ones_dma;
 		t->rx_buf = scratch->status;
-		if (dma)
-			t->rx_dma = dma + offsetof(struct scratch, status);
 		t->cs_change = 1;
 		spi_message_add_tail(t, &host->m);
 	}
@@ -660,23 +611,13 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
 
 	if (host->mmc->use_spi_crc)
 		scratch->crc_val = cpu_to_be16(crc_itu_t(0, t->tx_buf, t->len));
-	if (host->dma_dev)
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
 
 	status = spi_sync_locked(spi, &host->m);
-
 	if (status != 0) {
 		dev_dbg(&spi->dev, "write error (%d)\n", status);
 		return status;
 	}
 
-	if (host->dma_dev)
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-
 	/*
 	 * Get the transmission data-response reply.  It must follow
 	 * immediately after the data block we transferred.  This reply
@@ -725,8 +666,6 @@ mmc_spi_writeblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	t->tx_buf += t->len;
-	if (host->dma_dev)
-		t->tx_dma += t->len;
 
 	/* Return when not busy.  If we didn't collect that status yet,
 	 * we'll need some more I/O.
@@ -790,30 +729,12 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 	leftover = status << 1;
 
-	if (host->dma_dev) {
-		dma_sync_single_for_device(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-		dma_sync_single_for_device(host->dma_dev,
-				t->rx_dma, t->len,
-				DMA_FROM_DEVICE);
-	}
-
 	status = spi_sync_locked(spi, &host->m);
 	if (status < 0) {
 		dev_dbg(&spi->dev, "read error %d\n", status);
 		return status;
 	}
 
-	if (host->dma_dev) {
-		dma_sync_single_for_cpu(host->dma_dev,
-				host->data_dma, sizeof(*scratch),
-				DMA_BIDIRECTIONAL);
-		dma_sync_single_for_cpu(host->dma_dev,
-				t->rx_dma, t->len,
-				DMA_FROM_DEVICE);
-	}
-
 	if (bitshift) {
 		/* Walk through the data and the crc and do
 		 * all the magic to get byte-aligned data.
@@ -848,8 +769,6 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	t->rx_buf += t->len;
-	if (host->dma_dev)
-		t->rx_dma += t->len;
 
 	return 0;
 }
@@ -864,7 +783,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		struct mmc_data *data, u32 blk_size)
 {
 	struct spi_device	*spi = host->spi;
-	struct device		*dma_dev = host->dma_dev;
 	struct spi_transfer	*t;
 	enum dma_data_direction	direction;
 	struct scatterlist	*sg;
@@ -891,31 +809,8 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	 */
 	for_each_sg(data->sg, sg, data->sg_len, n_sg) {
 		int			status = 0;
-		dma_addr_t		dma_addr = 0;
 		void			*kmap_addr;
 		unsigned		length = sg->length;
-		enum dma_data_direction	dir = direction;
-
-		/* set up dma mapping for controller drivers that might
-		 * use DMA ... though they may fall back to PIO
-		 */
-		if (dma_dev) {
-			/* never invalidate whole *shared* pages ... */
-			if ((sg->offset != 0 || length != PAGE_SIZE)
-					&& dir == DMA_FROM_DEVICE)
-				dir = DMA_BIDIRECTIONAL;
-
-			dma_addr = dma_map_page(dma_dev, sg_page(sg), 0,
-						PAGE_SIZE, dir);
-			if (dma_mapping_error(dma_dev, dma_addr)) {
-				data->error = -EFAULT;
-				break;
-			}
-			if (direction == DMA_TO_DEVICE)
-				t->tx_dma = dma_addr + sg->offset;
-			else
-				t->rx_dma = dma_addr + sg->offset;
-		}
 
 		/* allow pio too; we don't allow highmem */
 		kmap_addr = kmap(sg_page(sg));
@@ -951,8 +846,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		if (direction == DMA_FROM_DEVICE)
 			flush_kernel_dcache_page(sg_page(sg));
 		kunmap(sg_page(sg));
-		if (dma_dev)
-			dma_unmap_page(dma_dev, dma_addr, PAGE_SIZE, dir);
 
 		if (status < 0) {
 			data->error = status;
@@ -989,21 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
 
 		host->early_status.tx_buf = host->early_status.rx_buf;
-		host->early_status.tx_dma = host->early_status.rx_dma;
 		host->early_status.len = statlen;
 
-		if (host->dma_dev)
-			dma_sync_single_for_device(host->dma_dev,
-					host->data_dma, sizeof(*scratch),
-					DMA_BIDIRECTIONAL);
-
 		tmp = spi_sync_locked(spi, &host->m);
-
-		if (host->dma_dev)
-			dma_sync_single_for_cpu(host->dma_dev,
-					host->data_dma, sizeof(*scratch),
-					DMA_BIDIRECTIONAL);
-
 		if (tmp < 0) {
 			if (!data->error)
 				data->error = tmp;
@@ -1278,52 +1159,6 @@ mmc_spi_detect_irq(int irq, void *mmc)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_HAS_DMA
-static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
-{
-	struct spi_device *spi = host->spi;
-	struct device *dev;
-
-	if (!spi->master->dev.parent->dma_mask)
-		return 0;
-
-	dev = spi->master->dev.parent;
-
-	host->ones_dma = dma_map_single(dev, host->ones, MMC_SPI_BLOCKSIZE,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, host->ones_dma))
-		return -ENOMEM;
-
-	host->data_dma = dma_map_single(dev, host->data, sizeof(*host->data),
-					DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev, host->data_dma)) {
-		dma_unmap_single(dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
-				 DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	dma_sync_single_for_cpu(dev, host->data_dma, sizeof(*host->data),
-				DMA_BIDIRECTIONAL);
-
-	host->dma_dev = dev;
-	return 0;
-}
-
-static void mmc_spi_dma_free(struct mmc_spi_host *host)
-{
-	if (!host->dma_dev)
-		return;
-
-	dma_unmap_single(host->dma_dev, host->ones_dma, MMC_SPI_BLOCKSIZE,
-			 DMA_TO_DEVICE);
-	dma_unmap_single(host->dma_dev, host->data_dma,	sizeof(*host->data),
-			 DMA_BIDIRECTIONAL);
-}
-#else
-static inline int mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
-static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
-#endif
-
 static int mmc_spi_probe(struct spi_device *spi)
 {
 	void			*ones;
@@ -1415,24 +1250,17 @@ static int mmc_spi_probe(struct spi_device *spi)
 
 	dev_set_drvdata(&spi->dev, mmc);
 
-	/* preallocate dma buffers */
+	/* Preallocate buffers */
 	host->data = kmalloc(sizeof(*host->data), GFP_KERNEL);
 	if (!host->data)
 		goto fail_nobuf1;
 
-	status = mmc_spi_dma_alloc(host);
-	if (status)
-		goto fail_dma;
-
 	/* setup message for status/busy readback */
 	spi_message_init(&host->readback);
-	host->readback.is_dma_mapped = (host->dma_dev != NULL);
 
 	spi_message_add_tail(&host->status, &host->readback);
 	host->status.tx_buf = host->ones;
-	host->status.tx_dma = host->ones_dma;
 	host->status.rx_buf = &host->data->status;
-	host->status.rx_dma = host->data_dma + offsetof(struct scratch, status);
 	host->status.cs_change = 1;
 
 	/* register card detect irq */
@@ -1477,9 +1305,8 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (!status)
 		has_ro = true;
 
-	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
+	dev_info(&spi->dev, "SD/MMC host %s%s%s%s\n",
 			dev_name(&mmc->class_dev),
-			host->dma_dev ? "" : ", no DMA",
 			has_ro ? "" : ", no WP",
 			(host->pdata && host->pdata->setpower)
 				? "" : ", no poweroff",
@@ -1490,8 +1317,6 @@ static int mmc_spi_probe(struct spi_device *spi)
 fail_gpiod_request:
 	mmc_remove_host(mmc);
 fail_glue_init:
-	mmc_spi_dma_free(host);
-fail_dma:
 	kfree(host->data);
 fail_nobuf1:
 	mmc_free_host(mmc);
@@ -1513,7 +1338,6 @@ static int mmc_spi_remove(struct spi_device *spi)
 
 	mmc_remove_host(mmc);
 
-	mmc_spi_dma_free(host);
 	kfree(host->data);
 	kfree(host->ones);
 
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 64ba465741a7..81a5e7622ea7 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -971,7 +971,8 @@ static int alb_upper_dev_walk(struct net_device *upper,
 	if (netif_is_macvlan(upper) && !strict_match) {
 		tags = bond_verify_device_path(bond->dev, upper, 0);
 		if (IS_ERR_OR_NULL(tags))
-			BUG();
+			return -ENOMEM;
+
 		alb_send_lp_vid(slave, upper->dev_addr,
 				tags[0].vlan_proto, tags[0].vlan_id);
 		kfree(tags);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 51a7ff44478e..67e52c481504 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -536,8 +536,8 @@ struct mv88e6xxx_ops {
 	int (*serdes_get_sset_count)(struct mv88e6xxx_chip *chip, int port);
 	int (*serdes_get_strings)(struct mv88e6xxx_chip *chip,  int port,
 				  uint8_t *data);
-	int (*serdes_get_stats)(struct mv88e6xxx_chip *chip,  int port,
-				uint64_t *data);
+	size_t (*serdes_get_stats)(struct mv88e6xxx_chip *chip, int port,
+				   uint64_t *data);
 
 	/* SERDES registers for ethtool */
 	int (*serdes_get_regs_len)(struct mv88e6xxx_chip *chip,  int port);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 6920e62c864d..9494d75eec62 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -314,8 +314,8 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	return val;
 }
 
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
@@ -631,8 +631,8 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	return reg[0] | ((u64)reg[1] << 16) | ((u64)reg[2] << 32);
 }
 
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6390_serdes_hw_stat *stat;
 	int lane;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 14315f26228a..035688659b50 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -116,13 +116,13 @@ irqreturn_t mv88e6390_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
 int mv88e6352_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 int mv88e6390_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 
 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 584f365de563..059552f4154d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11331,6 +11331,11 @@ static int bnxt_fw_init_one_p1(struct bnxt *bp)
 
 	bp->fw_cap = 0;
 	rc = bnxt_hwrm_ver_get(bp);
+	/* FW may be unresponsive after FLR. FLR must complete within 100 msec
+	 * so wait before continuing with recovery.
+	 */
+	if (rc)
+		msleep(100);
 	bnxt_try_map_fw_health_reg(bp);
 	if (rc) {
 		if (bp->fw_health && bp->fw_health->status_reliable) {
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 8edf12077e66..ed0589a1a00d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1244,7 +1244,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1264,7 +1265,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (enable)
+	if (tx_lpi_enabled)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1285,6 +1286,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	priv->eee.eee_enabled = enable;
 	priv->eee.eee_active = enable;
+	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
@@ -1300,6 +1302,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 
 	e->eee_enabled = p->eee_enabled;
 	e->eee_active = p->eee_active;
+	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1309,7 +1312,6 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_eee *p = &priv->eee;
-	int ret = 0;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1320,16 +1322,11 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	p->eee_enabled = e->eee_enabled;
 
 	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false);
+		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		ret = phy_init_eee(dev->phydev, 0);
-		if (ret) {
-			netif_err(priv, hw, dev, "EEE initialization failed\n");
-			return ret;
-		}
-
+		p->eee_active = phy_init_eee(dev->phydev, false) >= 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, true);
+		bcmgenet_eee_enable_set(dev, p->eee_active, e->tx_lpi_enabled);
 	}
 
 	return phy_ethtool_set_eee(dev->phydev, e);
@@ -4217,9 +4214,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	if (priv->eee.eee_enabled)
-		bcmgenet_eee_enable_set(dev, true);
-
 	bcmgenet_netif_start(dev);
 
 	netif_device_attach(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index f6ca01da141d..c7853d5304b0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -756,4 +756,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			       enum bcmgenet_power_mode mode);
 
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled);
+
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 2b0538f2af63..becc717aad13 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -25,6 +25,7 @@
 
 #include "bcmgenet.h"
 
+
 /* setup netdev link state when PHY link status change and
  * update UMAC and RGMII block when link up
  */
@@ -102,6 +103,11 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			reg |= CMD_TX_EN | CMD_RX_EN;
 		}
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+		bcmgenet_eee_enable_set(dev,
+					priv->eee.eee_enabled && priv->eee.eee_active,
+					priv->eee.tx_lpi_enabled);
 	} else {
 		/* done if nothing has changed */
 		if (!status_changed)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4ce913559c91..fe29769cb158 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1766,6 +1766,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
@@ -1775,6 +1776,7 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		}
 	} else {
 		if (fep->link) {
+			netif_stop_queue(ndev);
 			napi_disable(&fep->napi);
 			netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d83b96aa3e42..135acd74497f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5153,7 +5153,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
 {
 	int v, ret = 0;
 
-	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
+	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v]) {
 			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
 			if (ret)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7b0ed15f4df3..f79795cc9152 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2545,6 +2545,14 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i;
 
+	if (vf->is_disabled_from_host) {
+		aq_ret = -EPERM;
+		dev_info(&pf->pdev->dev,
+			 "Admin has disabled VF %d, will not enable queues\n",
+			 vf->vf_id);
+		goto error_param;
+	}
+
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -4587,9 +4595,12 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	struct i40e_pf *pf = np->vsi->back;
 	struct virtchnl_pf_event pfe;
 	struct i40e_hw *hw = &pf->hw;
+	struct i40e_vsi *vsi;
+	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
 	int ret = 0;
+	int tmp;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4612,6 +4623,9 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	switch (link) {
 	case IFLA_VF_LINK_STATE_AUTO:
 		vf->link_forced = false;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		pfe.event_data.link_event.link_status =
 			pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP;
 		pfe.event_data.link_event.link_speed =
@@ -4621,6 +4635,9 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	case IFLA_VF_LINK_STATE_ENABLE:
 		vf->link_forced = true;
 		vf->link_up = true;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		pfe.event_data.link_event.link_status = true;
 		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
 		break;
@@ -4629,6 +4646,21 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_up = false;
 		pfe.event_data.link_event.link_status = false;
 		pfe.event_data.link_event.link_speed = 0;
+
+		vsi = pf->vsi[vf->lan_vsi_idx];
+		q_map = BIT(vsi->num_queue_pairs) - 1;
+
+		vf->is_disabled_from_host = true;
+
+		/* Try to stop both Tx&Rx rings even if one of the calls fails
+		 * to ensure we stop the rings even in case of errors.
+		 * If any of them returns with an error then the first
+		 * error that occurred will be returned.
+		 */
+		tmp = i40e_ctrl_vf_tx_rings(vsi, q_map, false);
+		ret = i40e_ctrl_vf_rx_rings(vsi, q_map, false);
+
+		ret = tmp ? tmp : ret;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index bd497cc5303a..97e9c34d7c6c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -98,6 +98,7 @@ struct i40e_vf {
 	bool link_forced;
 	bool link_up;		/* only valid if VF link is forced */
 	bool spoofchk;
+	bool is_disabled_from_host; /* PF ctrl of VF enable/disable */
 	u16 num_vlan;
 
 	/* ADq related variables */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 95c92fe890a1..ed35e06537a0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -123,14 +123,14 @@ static s32 ixgbe_init_phy_ops_82598(struct ixgbe_hw *hw)
 		if (ret_val)
 			return ret_val;
 		if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 
 		/* Check to see if SFP+ module is supported */
 		ret_val = ixgbe_get_sfp_init_sequence_offsets(hw,
 							    &list_offset,
 							    &data_offset);
 		if (ret_val)
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		break;
 	default:
 		break;
@@ -213,7 +213,7 @@ static s32 ixgbe_get_link_capabilities_82598(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -283,7 +283,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -292,7 +292,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -369,7 +369,7 @@ static s32 ixgbe_fc_enable_82598(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -438,7 +438,7 @@ static s32 ixgbe_start_mac_link_82598(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autonegotiation did not complete.\n");
 			}
 		}
@@ -478,7 +478,7 @@ static s32 ixgbe_validate_link_ready(struct ixgbe_hw *hw)
 
 	if (timeout == IXGBE_VALIDATE_LINK_READY_TIMEOUT) {
 		hw_dbg(hw, "Link was indicated but link is down\n");
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	return 0;
@@ -594,7 +594,7 @@ static s32 ixgbe_setup_mac_link_82598(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Set KX4/KX support according to speed requested */
 	else if (link_mode == IXGBE_AUTOC_LMS_KX4_AN ||
@@ -701,9 +701,9 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 
 		/* Init PHY and function pointers, perform SFP setup */
 		phy_status = hw->phy.ops.init(hw);
-		if (phy_status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+		if (phy_status == -EOPNOTSUPP)
 			return phy_status;
-		if (phy_status == IXGBE_ERR_SFP_NOT_PRESENT)
+		if (phy_status == -ENOENT)
 			goto mac_reset_top;
 
 		hw->phy.ops.reset(hw);
@@ -727,7 +727,7 @@ static s32 ixgbe_reset_hw_82598(struct ixgbe_hw *hw)
 		udelay(1);
 	}
 	if (ctrl & IXGBE_CTRL_RST) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -789,7 +789,7 @@ static s32 ixgbe_set_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -814,7 +814,7 @@ static s32 ixgbe_clear_vmdq_82598(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(rar));
@@ -845,7 +845,7 @@ static s32 ixgbe_set_vfta_82598(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	u32 vftabyte;
 
 	if (vlan > 4095)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Determine 32-bit word position in array */
 	regindex = (vlan >> 5) & 0x7F;   /* upper seven bits */
@@ -964,7 +964,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 		gssr = IXGBE_GSSR_PHY0_SM;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	if (hw->phy.type == ixgbe_phy_nl) {
 		/*
@@ -993,7 +993,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		if (sfp_stat != IXGBE_I2C_EEPROM_STATUS_PASS) {
 			hw_dbg(hw, "EEPROM read did not pass.\n");
-			status = IXGBE_ERR_SFP_NOT_PRESENT;
+			status = -ENOENT;
 			goto out;
 		}
 
@@ -1003,7 +1003,7 @@ static s32 ixgbe_read_i2c_phy_82598(struct ixgbe_hw *hw, u8 dev_addr,
 
 		*eeprom_data = (u8)(sfp_data >> 8);
 	} else {
-		status = IXGBE_ERR_PHY;
+		status = -EIO;
 	}
 
 out:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 8d3798a32f0e..46ed20005d67 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -117,7 +117,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 							IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		if (hw->eeprom.ops.read(hw, ++data_offset, &data_value))
 			goto setup_sfp_err;
@@ -144,7 +144,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 
 		if (ret_val) {
 			hw_dbg(hw, " sfp module setup not complete\n");
-			return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+			return -EIO;
 		}
 	}
 
@@ -159,7 +159,7 @@ static s32 ixgbe_setup_sfp_modules_82599(struct ixgbe_hw *hw)
 	usleep_range(hw->eeprom.semaphore_delay * 1000,
 		     hw->eeprom.semaphore_delay * 2000);
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_SFP_SETUP_NOT_COMPLETE;
+	return -EIO;
 }
 
 /**
@@ -184,7 +184,7 @@ static s32 prot_autoc_read_82599(struct ixgbe_hw *hw, bool *locked,
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		*locked = true;
 	}
@@ -219,7 +219,7 @@ static s32 prot_autoc_write_82599(struct ixgbe_hw *hw, u32 autoc, bool locked)
 		ret_val = hw->mac.ops.acquire_swfw_sync(hw,
 					IXGBE_GSSR_MAC_CSR_SM);
 		if (ret_val)
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		locked = true;
 	}
@@ -400,7 +400,7 @@ static s32 ixgbe_get_link_capabilities_82599(struct ixgbe_hw *hw,
 		break;
 
 	default:
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 	}
 
 	if (hw->phy.multispeed_fiber) {
@@ -541,7 +541,7 @@ static s32 ixgbe_start_mac_link_82599(struct ixgbe_hw *hw,
 				msleep(100);
 			}
 			if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-				status = IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+				status = -EIO;
 				hw_dbg(hw, "Autoneg did not complete.\n");
 			}
 		}
@@ -794,7 +794,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 	speed &= link_capabilities;
 
 	if (speed == IXGBE_LINK_SPEED_UNKNOWN)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 
 	/* Use stored value (EEPROM defaults) of AUTOC to find KR/KX4 support*/
 	if (hw->mac.orig_link_settings_stored)
@@ -861,8 +861,7 @@ static s32 ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
 					msleep(100);
 				}
 				if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
-					status =
-						IXGBE_ERR_AUTONEG_NOT_COMPLETE;
+					status = -EIO;
 					hw_dbg(hw, "Autoneg did not complete.\n");
 				}
 			}
@@ -927,7 +926,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	/* Identify PHY and related function pointers */
 	status = hw->phy.ops.init(hw);
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Setup SFP module if there is one present. */
@@ -936,7 +935,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -974,7 +973,7 @@ static s32 ixgbe_reset_hw_82599(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -1093,7 +1092,7 @@ static s32 ixgbe_fdir_check_cmd_complete(struct ixgbe_hw *hw, u32 *fdircmd)
 		udelay(10);
 	}
 
-	return IXGBE_ERR_FDIR_CMD_INCOMPLETE;
+	return -EIO;
 }
 
 /**
@@ -1155,7 +1154,7 @@ s32 ixgbe_reinit_fdir_tables_82599(struct ixgbe_hw *hw)
 	}
 	if (i >= IXGBE_FDIR_INIT_DONE_POLL) {
 		hw_dbg(hw, "Flow Director Signature poll time exceeded!\n");
-		return IXGBE_ERR_FDIR_REINIT_FAILED;
+		return -EIO;
 	}
 
 	/* Clear FDIR statistics registers (read to clear) */
@@ -1387,7 +1386,7 @@ s32 ixgbe_fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type input\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* configure FDIRCMD register */
@@ -1546,7 +1545,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on vm pool mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (input_mask->formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) {
@@ -1555,13 +1554,13 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		if (input_mask->formatted.dst_port ||
 		    input_mask->formatted.src_port) {
 			hw_dbg(hw, " Error on src/dst port mask\n");
-			return IXGBE_ERR_CONFIG;
+			return -EIO;
 		}
 	case IXGBE_ATR_L4TYPE_MASK:
 		break;
 	default:
 		hw_dbg(hw, " Error on flow type mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (ntohs(input_mask->formatted.vlan_id) & 0xEFFF) {
@@ -1582,7 +1581,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on VLAN mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
@@ -1594,7 +1593,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 		break;
 	default:
 		hw_dbg(hw, " Error on flexible byte mask\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
@@ -1823,7 +1822,7 @@ static s32 ixgbe_identify_phy_82599(struct ixgbe_hw *hw)
 
 	/* Return error if SFP module has been detected but is not supported */
 	if (hw->phy.type == ixgbe_phy_sfp_unsupported)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	return status;
 }
@@ -1862,13 +1861,13 @@ static s32 ixgbe_enable_rx_dma_82599(struct ixgbe_hw *hw, u32 regval)
  *  Verifies that installed the firmware version is 0.6 or higher
  *  for SFI devices. All 82599 SFI devices should have version 0.6 or higher.
  *
- *  Returns IXGBE_ERR_EEPROM_VERSION if the FW is not present or
- *  if the FW version is not supported.
+ *  Return: -EACCES if the FW is not present or if the FW version is
+ *  not supported.
  **/
 static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_EEPROM_VERSION;
 	u16 fw_offset, fw_ptp_cfg_offset;
+	s32 status = -EACCES;
 	u16 offset;
 	u16 fw_version = 0;
 
@@ -1882,7 +1881,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_offset == 0 || fw_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the offset to the Pass Through Patch Configuration block */
 	offset = fw_offset + IXGBE_FW_PASSTHROUGH_PATCH_CONFIG_PTR;
@@ -1890,7 +1889,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 		goto fw_version_err;
 
 	if (fw_ptp_cfg_offset == 0 || fw_ptp_cfg_offset == 0xFFFF)
-		return IXGBE_ERR_EEPROM_VERSION;
+		return -EACCES;
 
 	/* get the firmware version */
 	offset = fw_ptp_cfg_offset + IXGBE_FW_PATCH_VERSION_4;
@@ -1904,7 +1903,7 @@ static s32 ixgbe_verify_fw_version_82599(struct ixgbe_hw *hw)
 
 fw_version_err:
 	hw_err(hw, "eeprom read at offset %d failed\n", offset);
-	return IXGBE_ERR_EEPROM_VERSION;
+	return -EACCES;
 }
 
 /**
@@ -2037,7 +2036,7 @@ static s32 ixgbe_reset_pipeline_82599(struct ixgbe_hw *hw)
 
 	if (!(anlp1_reg & IXGBE_ANLP1_AN_STATE_MASK)) {
 		hw_dbg(hw, "auto negotiation not completed\n");
-		ret_val = IXGBE_ERR_RESET_FAILED;
+		ret_val = -EIO;
 		goto reset_pipeline_out;
 	}
 
@@ -2086,7 +2085,7 @@ static s32 ixgbe_read_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
@@ -2140,7 +2139,7 @@ static s32 ixgbe_write_i2c_byte_82599(struct ixgbe_hw *hw, u8 byte_offset,
 
 		if (!timeout) {
 			hw_dbg(hw, "Driver can't access resource, acquiring I2C bus timeout.\n");
-			status = IXGBE_ERR_I2C;
+			status = -EIO;
 			goto release_i2c_access;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 62ddb452f862..22595d22167d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -30,7 +30,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 					     u16 words, u16 *data);
 static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
 						 u16 offset);
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw);
 
 /* Base table for registers values that change by MAC */
 const u32 ixgbe_mvals_8259X[IXGBE_MVALS_IDX_LIMIT] = {
@@ -123,7 +123,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 	 */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_dbg(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/*
@@ -214,7 +214,7 @@ s32 ixgbe_setup_fc_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	if (hw->mac.type != ixgbe_mac_X540) {
@@ -499,7 +499,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (pba_num == NULL) {
 		hw_dbg(hw, "PBA string buffer was null\n");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	ret_val = hw->eeprom.ops.read(hw, IXGBE_PBANUM0_PTR, &data);
@@ -525,7 +525,7 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 		/* we will need 11 characters to store the PBA */
 		if (pba_num_size < 11) {
 			hw_dbg(hw, "PBA string buffer too small\n");
-			return IXGBE_ERR_NO_SPACE;
+			return -ENOSPC;
 		}
 
 		/* extract hex string from data and pba_ptr */
@@ -562,13 +562,13 @@ s32 ixgbe_read_pba_string_generic(struct ixgbe_hw *hw, u8 *pba_num,
 
 	if (length == 0xFFFF || length == 0) {
 		hw_dbg(hw, "NVM PBA number section invalid length\n");
-		return IXGBE_ERR_PBA_SECTION;
+		return -EIO;
 	}
 
 	/* check if pba_num buffer is big enough */
 	if (pba_num_size  < (((u32)length * 2) - 1)) {
 		hw_dbg(hw, "PBA string buffer too small\n");
-		return IXGBE_ERR_NO_SPACE;
+		return -ENOSPC;
 	}
 
 	/* trim pba length from start of string */
@@ -745,10 +745,10 @@ s32 ixgbe_stop_adapter_generic(struct ixgbe_hw *hw)
 	usleep_range(1000, 2000);
 
 	/*
-	 * Prevent the PCI-E bus from from hanging by disabling PCI-E master
+	 * Prevent the PCI-E bus from hanging by disabling PCI-E primary
 	 * access and verify no pending requests
 	 */
-	return ixgbe_disable_pcie_master(hw);
+	return ixgbe_disable_pcie_primary(hw);
 }
 
 /**
@@ -804,7 +804,7 @@ s32 ixgbe_led_on_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -825,7 +825,7 @@ s32 ixgbe_led_off_generic(struct ixgbe_hw *hw, u32 index)
 	u32 led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn off the LED, set mode to OFF. */
 	led_reg &= ~IXGBE_LED_MODE_MASK(index);
@@ -903,11 +903,8 @@ s32 ixgbe_write_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * The EEPROM page size cannot be queried from the chip. We do lazy
@@ -961,7 +958,7 @@ static s32 ixgbe_write_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1027,7 +1024,7 @@ s32 ixgbe_write_eeprom_generic(struct ixgbe_hw *hw, u16 offset, u16 data)
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_write_eeprom_buffer_bit_bang(hw, offset, 1, &data);
 }
@@ -1049,11 +1046,8 @@ s32 ixgbe_read_eeprom_buffer_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset + words > hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || (offset + words > hw->eeprom.word_size))
+		return -EINVAL;
 
 	/*
 	 * We cannot hold synchronization semaphores for too long
@@ -1098,7 +1092,7 @@ static s32 ixgbe_read_eeprom_buffer_bit_bang(struct ixgbe_hw *hw, u16 offset,
 
 	if (ixgbe_ready_eeprom(hw) != 0) {
 		ixgbe_release_eeprom(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	for (i = 0; i < words; i++) {
@@ -1141,7 +1135,7 @@ s32 ixgbe_read_eeprom_bit_bang_generic(struct ixgbe_hw *hw, u16 offset,
 	hw->eeprom.ops.init_params(hw);
 
 	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+		return -EINVAL;
 
 	return ixgbe_read_eeprom_buffer_bit_bang(hw, offset, 1, data);
 }
@@ -1164,11 +1158,8 @@ s32 ixgbe_read_eerd_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eerd = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1261,11 +1252,8 @@ s32 ixgbe_write_eewr_buffer_generic(struct ixgbe_hw *hw, u16 offset,
 
 	hw->eeprom.ops.init_params(hw);
 
-	if (words == 0)
-		return IXGBE_ERR_INVALID_ARGUMENT;
-
-	if (offset >= hw->eeprom.word_size)
-		return IXGBE_ERR_EEPROM;
+	if (words == 0 || offset >= hw->eeprom.word_size)
+		return -EINVAL;
 
 	for (i = 0; i < words; i++) {
 		eewr = ((offset + i) << IXGBE_EEPROM_RW_ADDR_SHIFT) |
@@ -1327,7 +1315,7 @@ static s32 ixgbe_poll_eerd_eewr_done(struct ixgbe_hw *hw, u32 ee_reg)
 		}
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -1343,7 +1331,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 	u32 i;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM) != 0)
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	eec = IXGBE_READ_REG(hw, IXGBE_EEC(hw));
 
@@ -1365,7 +1353,7 @@ static s32 ixgbe_acquire_eeprom(struct ixgbe_hw *hw)
 		hw_dbg(hw, "Could not acquire EEPROM grant\n");
 
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Setup EEPROM for Read/Write */
@@ -1418,7 +1406,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 		swsm = IXGBE_READ_REG(hw, IXGBE_SWSM(hw));
 		if (swsm & IXGBE_SWSM_SMBI) {
 			hw_dbg(hw, "Software semaphore SMBI between device drivers not granted.\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 	}
 
@@ -1446,7 +1434,7 @@ static s32 ixgbe_get_eeprom_semaphore(struct ixgbe_hw *hw)
 	if (i >= timeout) {
 		hw_dbg(hw, "SWESMBI Software EEPROM semaphore not granted.\n");
 		ixgbe_release_eeprom_semaphore(hw);
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1502,7 +1490,7 @@ static s32 ixgbe_ready_eeprom(struct ixgbe_hw *hw)
 	 */
 	if (i >= IXGBE_EEPROM_MAX_RETRY_SPI) {
 		hw_dbg(hw, "SPI EEPROM Status error\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	return 0;
@@ -1714,7 +1702,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 	for (i = IXGBE_PCIE_ANALOG_PTR; i < IXGBE_FW_PTR; i++) {
 		if (hw->eeprom.ops.read(hw, i, &pointer)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		/* If the pointer seems invalid */
@@ -1723,7 +1711,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 
 		if (hw->eeprom.ops.read(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		if (length == 0xFFFF || length == 0)
@@ -1732,7 +1720,7 @@ s32 ixgbe_calc_eeprom_checksum_generic(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (hw->eeprom.ops.read(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -1785,7 +1773,7 @@ s32 ixgbe_validate_eeprom_checksum_generic(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum)
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 
 	/* If the user cares, return the calculated checksum */
 	if (checksum_val)
@@ -1844,7 +1832,7 @@ s32 ixgbe_set_rar_generic(struct ixgbe_hw *hw, u32 index, u8 *addr, u32 vmdq,
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/* setup VMDq pool selection before this RAR gets enabled */
@@ -1896,7 +1884,7 @@ s32 ixgbe_clear_rar_generic(struct ixgbe_hw *hw, u32 index)
 	/* Make sure we are using a valid rar index range */
 	if (index >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", index);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	/*
@@ -2145,7 +2133,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 
 	/* Validate the water mark configuration. */
 	if (!hw->fc.pause_time)
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 
 	/* Low water mark of zero causes XOFF floods */
 	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
@@ -2154,7 +2142,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 			if (!hw->fc.low_water[i] ||
 			    hw->fc.low_water[i] >= hw->fc.high_water[i]) {
 				hw_dbg(hw, "Invalid water mark configuration\n");
-				return IXGBE_ERR_INVALID_LINK_SETTINGS;
+				return -EINVAL;
 			}
 		}
 	}
@@ -2211,7 +2199,7 @@ s32 ixgbe_fc_enable_generic(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_dbg(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	/* Set 802.3x based flow control settings. */
@@ -2268,7 +2256,7 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm)
 {
 	if ((!(adv_reg)) ||  (!(lp_reg)))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EINVAL;
 
 	if ((adv_reg & adv_sym) && (lp_reg & lp_sym)) {
 		/*
@@ -2320,7 +2308,7 @@ static s32 ixgbe_fc_autoneg_fiber(struct ixgbe_hw *hw)
 	linkstat = IXGBE_READ_REG(hw, IXGBE_PCS1GLSTA);
 	if ((!!(linkstat & IXGBE_PCS1GLSTA_AN_COMPLETE) == 0) ||
 	    (!!(linkstat & IXGBE_PCS1GLSTA_AN_TIMED_OUT) == 1))
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	pcs_anadv_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANA);
 	pcs_lpab_reg = IXGBE_READ_REG(hw, IXGBE_PCS1GANLP);
@@ -2352,12 +2340,12 @@ static s32 ixgbe_fc_autoneg_backplane(struct ixgbe_hw *hw)
 	 */
 	links = IXGBE_READ_REG(hw, IXGBE_LINKS);
 	if ((links & IXGBE_LINKS_KX_AN_COMP) == 0)
-		return IXGBE_ERR_FC_NOT_NEGOTIATED;
+		return -EIO;
 
 	if (hw->mac.type == ixgbe_mac_82599EB) {
 		links2 = IXGBE_READ_REG(hw, IXGBE_LINKS2);
 		if ((links2 & IXGBE_LINKS2_AN_SUPPORTED) == 0)
-			return IXGBE_ERR_FC_NOT_NEGOTIATED;
+			return -EIO;
 	}
 	/*
 	 * Read the 10g AN autoc and LP ability registers and resolve
@@ -2406,8 +2394,8 @@ static s32 ixgbe_fc_autoneg_copper(struct ixgbe_hw *hw)
  **/
 void ixgbe_fc_autoneg(struct ixgbe_hw *hw)
 {
-	s32 ret_val = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 ret_val = -EIO;
 	bool link_up;
 
 	/*
@@ -2505,15 +2493,15 @@ static u32 ixgbe_pcie_timeout_poll(struct ixgbe_hw *hw)
 }
 
 /**
- *  ixgbe_disable_pcie_master - Disable PCI-express master access
+ *  ixgbe_disable_pcie_primary - Disable PCI-express primary access
  *  @hw: pointer to hardware structure
  *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests. IXGBE_ERR_MASTER_REQUESTS_PENDING is returned if master disable
- *  bit hasn't caused the master requests to be disabled, else 0
- *  is returned signifying master requests disabled.
+ *  Disables PCI-Express primary access and verifies there are no pending
+ *  requests. -EALREADY is returned if primary disable
+ *  bit hasn't caused the primary requests to be disabled, else 0
+ *  is returned signifying primary requests disabled.
  **/
-static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
+static s32 ixgbe_disable_pcie_primary(struct ixgbe_hw *hw)
 {
 	u32 i, poll;
 	u16 value;
@@ -2522,23 +2510,23 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
 
 	/* Poll for bit to read as set */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
 			break;
 		usleep_range(100, 120);
 	}
-	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
+	if (i >= IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT) {
 		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
 		goto gio_disable_fail;
 	}
 
-	/* Exit if master requests are blocked */
+	/* Exit if primary requests are blocked */
 	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
 	    ixgbe_removed(hw->hw_addr))
 		return 0;
 
-	/* Poll for master request bit to clear */
-	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+	/* Poll for primary request bit to clear */
+	for (i = 0; i < IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT; i++) {
 		udelay(100);
 		if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO))
 			return 0;
@@ -2546,13 +2534,13 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 
 	/*
 	 * Two consecutive resets are required via CTRL.RST per datasheet
-	 * 5.2.5.3.2 Master Disable.  We set a flag to inform the reset routine
-	 * of this need.  The first reset prevents new master requests from
+	 * 5.2.5.3.2 Primary Disable.  We set a flag to inform the reset routine
+	 * of this need.  The first reset prevents new primary requests from
 	 * being issued by our device.  We then must wait 1usec or more for any
 	 * remaining completions from the PCIe bus to trickle in, and then reset
 	 * again to clear out any effects they may have had on our device.
 	 */
-	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
+	hw_dbg(hw, "GIO Primary Disable bit didn't clear - requesting resets\n");
 gio_disable_fail:
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
@@ -2574,7 +2562,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	}
 
 	hw_dbg(hw, "PCIe transaction pending bit also did not clear.\n");
-	return IXGBE_ERR_MASTER_REQUESTS_PENDING;
+	return -EALREADY;
 }
 
 /**
@@ -2599,7 +2587,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_eeprom_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		gssr = IXGBE_READ_REG(hw, IXGBE_GSSR);
 		if (!(gssr & (fwmask | swmask))) {
@@ -2619,7 +2607,7 @@ s32 ixgbe_acquire_swfw_sync(struct ixgbe_hw *hw, u32 mask)
 		ixgbe_release_swfw_sync(hw, gssr & (fwmask | swmask));
 
 	usleep_range(5000, 10000);
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -2756,7 +2744,7 @@ s32 ixgbe_blink_led_start_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * Link must be up to auto-blink the LEDs;
@@ -2802,7 +2790,7 @@ s32 ixgbe_blink_led_stop_generic(struct ixgbe_hw *hw, u32 index)
 	s32 ret_val;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	ret_val = hw->mac.ops.prot_autoc_read(hw, &locked, &autoc_reg);
 	if (ret_val)
@@ -2962,7 +2950,7 @@ s32 ixgbe_clear_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	mpsar_lo = IXGBE_READ_REG(hw, IXGBE_MPSAR_LO(rar));
@@ -3013,7 +3001,7 @@ s32 ixgbe_set_vmdq_generic(struct ixgbe_hw *hw, u32 rar, u32 vmdq)
 	/* Make sure we are using a valid rar index range */
 	if (rar >= rar_entries) {
 		hw_dbg(hw, "RAR index %d is out of range.\n", rar);
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	if (vmdq < 32) {
@@ -3090,7 +3078,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	 * will simply bypass the VLVF if there are no entries present in the
 	 * VLVF that contain our VLAN
 	 */
-	first_empty_slot = vlvf_bypass ? IXGBE_ERR_NO_SPACE : 0;
+	first_empty_slot = vlvf_bypass ? -ENOSPC : 0;
 
 	/* add VLAN enable bit for comparison */
 	vlan |= IXGBE_VLVF_VIEN;
@@ -3114,7 +3102,7 @@ static s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass)
 	if (!first_empty_slot)
 		hw_dbg(hw, "No space in VLVF.\n");
 
-	return first_empty_slot ? : IXGBE_ERR_NO_SPACE;
+	return first_empty_slot ? : -ENOSPC;
 }
 
 /**
@@ -3134,7 +3122,7 @@ s32 ixgbe_set_vfta_generic(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 	s32 vlvf_index;
 
 	if ((vlan > 4095) || (vind > 63))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/*
 	 * this is a 2 part operation - first the VFTA, then the
@@ -3595,7 +3583,8 @@ u8 ixgbe_calculate_checksum(u8 *buffer, u32 length)
  *
  *  Communicates with the manageability block. On success return 0
  *  else returns semaphore error when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  semaphore, -EINVAL when incorrect parameters passed or -EIO when
+ *  command fails.
  *
  *  This function assumes that the IXGBE_GSSR_SW_MNG_SM semaphore is held
  *  by the caller.
@@ -3608,7 +3597,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 
 	/* Set bit 9 of FWSTS clearing FW reset indication */
@@ -3619,13 +3608,13 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	hicr = IXGBE_READ_REG(hw, IXGBE_HICR);
 	if (!(hicr & IXGBE_HICR_EN)) {
 		hw_dbg(hw, "IXGBE_HOST_EN bit disabled.\n");
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 	}
 
 	/* Calculate length in DWORDs. We must be DWORD aligned */
 	if (length % sizeof(u32)) {
 		hw_dbg(hw, "Buffer length failure, not aligned to dword");
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 	}
 
 	dword_len = length >> 2;
@@ -3650,7 +3639,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
 	/* Check command successful completion. */
 	if ((timeout && i == timeout) ||
 	    !(IXGBE_READ_REG(hw, IXGBE_HICR) & IXGBE_HICR_SV))
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EIO;
 
 	return 0;
 }
@@ -3670,7 +3659,7 @@ s32 ixgbe_hic_unlocked(struct ixgbe_hw *hw, u32 *buffer, u32 length,
  *  in these cases.
  *
  *  Communicates with the manageability block.  On success return 0
- *  else return IXGBE_ERR_HOST_INTERFACE_COMMAND.
+ *  else return -EIO or -EINVAL.
  **/
 s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 				 u32 length, u32 timeout,
@@ -3687,7 +3676,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (!length || length > IXGBE_HI_MAX_BLOCK_BYTE_LENGTH) {
 		hw_dbg(hw, "Buffer length failure buffersize-%d.\n", length);
-		return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		return -EINVAL;
 	}
 	/* Take management host interface semaphore */
 	status = hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_SW_MNG_SM);
@@ -3717,7 +3706,7 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
 
 	if (length < round_up(buf_len, 4) + hdr_size) {
 		hw_dbg(hw, "Buffer not large enough for reply message.\n");
-		status = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+		status = -EIO;
 		goto rel_out;
 	}
 
@@ -3748,8 +3737,8 @@ s32 ixgbe_host_interface_command(struct ixgbe_hw *hw, void *buffer,
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore or -EIO when command fails.
  **/
 s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 				 u8 build, u8 sub, __always_unused u16 len,
@@ -3785,7 +3774,7 @@ s32 ixgbe_set_fw_drv_ver_generic(struct ixgbe_hw *hw, u8 maj, u8 min,
 		    FW_CEM_RESP_STATUS_SUCCESS)
 			ret_val = 0;
 		else
-			ret_val = IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			ret_val = -EIO;
 
 		break;
 	}
@@ -3883,14 +3872,14 @@ static s32 ixgbe_get_ets_data(struct ixgbe_hw *hw, u16 *ets_cfg,
 		return status;
 
 	if ((*ets_offset == 0x0000) || (*ets_offset == 0xFFFF))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = hw->eeprom.ops.read(hw, *ets_offset, ets_cfg);
 	if (status)
 		return status;
 
 	if ((*ets_cfg & IXGBE_ETS_TYPE_MASK) != IXGBE_ETS_TYPE_EMC_SHIFTED)
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
@@ -3913,7 +3902,7 @@ s32 ixgbe_get_thermal_sensor_data_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
@@ -3973,7 +3962,7 @@ s32 ixgbe_init_thermal_sensor_thresh_generic(struct ixgbe_hw *hw)
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if ((IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_LAN_ID_1))
-		return IXGBE_NOT_IMPLEMENTED;
+		return -EOPNOTSUPP;
 
 	status = ixgbe_get_ets_data(hw, &ets_cfg, &ets_offset);
 	if (status)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2eb133183473..93532f3a3fb9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3346,7 +3346,7 @@ static int ixgbe_get_module_eeprom(struct net_device *dev,
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	s32 status = IXGBE_ERR_PHY_ADDR_INVALID;
+	s32 status = -EFAULT;
 	u8 databyte = 0xFF;
 	int i = 0;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5829d81f2cb1..b16cb2365d96 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2766,7 +2766,6 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 eicr = adapter->interrupt_event;
-	s32 rc;
 
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
@@ -2800,14 +2799,13 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 		}
 
 		/* Check if this is not due to overtemp */
-		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 
 		break;
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
-		rc = hw->phy.ops.check_overtemp(hw);
-		if (rc != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 		break;
 	default:
@@ -5520,7 +5518,7 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
 {
 	u32 speed;
 	bool autoneg, link_up = false;
-	int ret = IXGBE_ERR_LINK_SETUP;
+	int ret = -EIO;
 
 	if (hw->mac.ops.check_link)
 		ret = hw->mac.ops.check_link(hw, &speed, &link_up, false);
@@ -5946,13 +5944,13 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
 	err = hw->mac.ops.init_hw(hw);
 	switch (err) {
 	case 0:
-	case IXGBE_ERR_SFP_NOT_PRESENT:
-	case IXGBE_ERR_SFP_NOT_SUPPORTED:
+	case -ENOENT:
+	case -EOPNOTSUPP:
 		break;
-	case IXGBE_ERR_MASTER_REQUESTS_PENDING:
-		e_dev_err("master disable timed out\n");
+	case -EALREADY:
+		e_dev_err("primary disable timed out\n");
 		break;
-	case IXGBE_ERR_EEPROM_VERSION:
+	case -EACCES:
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated with "
@@ -7735,10 +7733,10 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	adapter->sfp_poll_time = jiffies + IXGBE_SFP_POLL_JIFFIES - 1;
 
 	err = hw->phy.ops.identify_sfp(hw);
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		/* If no cable is present, then we need to reset
 		 * the next time we find a good cable. */
 		adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
@@ -7764,7 +7762,7 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	else
 		err = hw->mac.ops.setup_sfp(hw);
 
-	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (err == -EOPNOTSUPP)
 		goto sfp_out;
 
 	adapter->flags |= IXGBE_FLAG_NEED_LINK_CONFIG;
@@ -7773,8 +7771,8 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 sfp_out:
 	clear_bit(__IXGBE_IN_SFP_INIT, &adapter->state);
 
-	if ((err == IXGBE_ERR_SFP_NOT_SUPPORTED) &&
-	    (adapter->netdev->reg_state == NETREG_REGISTERED)) {
+	if (err == -EOPNOTSUPP &&
+	    adapter->netdev->reg_state == NETREG_REGISTERED) {
 		e_dev_err("failed to initialize because an unsupported "
 			  "SFP+ module type was detected.\n");
 		e_dev_err("Reload the driver after installing a "
@@ -7844,7 +7842,7 @@ static void ixgbe_service_timer(struct timer_list *t)
 static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 status;
+	bool overtemp;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
 		return;
@@ -7854,11 +7852,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 	if (!hw->phy.ops.handle_lasi)
 		return;
 
-	status = hw->phy.ops.handle_lasi(&adapter->hw);
-	if (status != IXGBE_ERR_OVERTEMP)
-		return;
-
-	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
+	if (overtemp)
+		e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
@@ -10796,9 +10792,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = hw->mac.ops.reset_hw(hw);
 	hw->phy.reset_if_overtemp = false;
 	ixgbe_set_eee_capable(adapter);
-	if (err == IXGBE_ERR_SFP_NOT_PRESENT) {
+	if (err == -ENOENT) {
 		err = 0;
-	} else if (err == IXGBE_ERR_SFP_NOT_SUPPORTED) {
+	} else if (err == -EOPNOTSUPP) {
 		e_dev_err("failed to load because an unsupported SFP+ or QSFP module type was detected.\n");
 		e_dev_err("Reload the driver after installing a supported module.\n");
 		goto err_sw_init;
@@ -11015,7 +11011,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* reset the hardware with the new settings */
 	err = hw->mac.ops.start_hw(hw);
-	if (err == IXGBE_ERR_EEPROM_VERSION) {
+	if (err == -EACCES) {
 		/* We are running on a pre-production device, log a warning */
 		e_dev_warn("This device is a pre-production adapter/LOM. "
 			   "Please be aware there may be issues associated "
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
index 5679293e53f7..fe7ef5773369 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
@@ -24,7 +24,7 @@ s32 ixgbe_read_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 		size = mbx->size;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->read(hw, msg, size, mbx_id);
 }
@@ -43,10 +43,10 @@ s32 ixgbe_write_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (size > mbx->size)
-		return IXGBE_ERR_MBX;
+		return -EINVAL;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->write(hw, msg, size, mbx_id);
 }
@@ -63,7 +63,7 @@ s32 ixgbe_check_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_msg(hw, mbx_id);
 }
@@ -80,7 +80,7 @@ s32 ixgbe_check_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_ack(hw, mbx_id);
 }
@@ -97,7 +97,7 @@ s32 ixgbe_check_for_rst(struct ixgbe_hw *hw, u16 mbx_id)
 	struct ixgbe_mbx_info *mbx = &hw->mbx;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	return mbx->ops->check_for_rst(hw, mbx_id);
 }
@@ -115,12 +115,12 @@ static s32 ixgbe_poll_for_msg(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_msg(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -140,12 +140,12 @@ static s32 ixgbe_poll_for_ack(struct ixgbe_hw *hw, u16 mbx_id)
 	int countdown = mbx->timeout;
 
 	if (!countdown || !mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	while (mbx->ops->check_for_ack(hw, mbx_id)) {
 		countdown--;
 		if (!countdown)
-			return IXGBE_ERR_MBX;
+			return -EIO;
 		udelay(mbx->usec_delay);
 	}
 
@@ -169,7 +169,7 @@ static s32 ixgbe_read_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 	s32 ret_val;
 
 	if (!mbx->ops)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	ret_val = ixgbe_poll_for_msg(hw, mbx_id);
 	if (ret_val)
@@ -197,7 +197,7 @@ static s32 ixgbe_write_posted_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size,
 
 	/* exit if either we can't write or there isn't a defined timeout */
 	if (!mbx->ops || !mbx->timeout)
-		return IXGBE_ERR_MBX;
+		return -EIO;
 
 	/* send msg */
 	ret_val = mbx->ops->write(hw, msg, size, mbx_id);
@@ -217,7 +217,7 @@ static s32 ixgbe_check_for_bit_pf(struct ixgbe_hw *hw, u32 mask, s32 index)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -238,7 +238,7 @@ static s32 ixgbe_check_for_msg_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -259,7 +259,7 @@ static s32 ixgbe_check_for_ack_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -295,7 +295,7 @@ static s32 ixgbe_check_for_rst_pf(struct ixgbe_hw *hw, u16 vf_number)
 		return 0;
 	}
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
@@ -317,7 +317,7 @@ static s32 ixgbe_obtain_mbx_lock_pf(struct ixgbe_hw *hw, u16 vf_number)
 	if (p2v_mailbox & IXGBE_PFMAILBOX_PFU)
 		return 0;
 
-	return IXGBE_ERR_MBX;
+	return -EIO;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
index a148534d7256..def067b15873 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h
@@ -7,7 +7,6 @@
 #include "ixgbe_type.h"
 
 #define IXGBE_VFMAILBOX_SIZE        16 /* 16 32 bit words - 64 bytes */
-#define IXGBE_ERR_MBX               -100
 
 #define IXGBE_VFMAILBOX             0x002FC
 #define IXGBE_VFMBMEM               0x00200
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index b0413904b798..9d8b018b4f23 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -102,7 +102,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -150,7 +150,7 @@ s32 ixgbe_read_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte read combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -179,7 +179,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 	csum = ~csum;
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 		ixgbe_i2c_start(hw);
 		/* Device Address and write indication */
 		if (ixgbe_out_i2c_byte_ack(hw, addr))
@@ -215,7 +215,7 @@ s32 ixgbe_write_i2c_combined_generic_int(struct ixgbe_hw *hw, u8 addr,
 			hw_dbg(hw, "I2C byte write combined error.\n");
 	} while (retry < max_retry);
 
-	return IXGBE_ERR_I2C;
+	return -EIO;
 }
 
 /**
@@ -262,8 +262,8 @@ static bool ixgbe_probe_phy(struct ixgbe_hw *hw, u16 phy_addr)
  **/
 s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 {
+	u32 status = -EFAULT;
 	u32 phy_addr;
-	u32 status = IXGBE_ERR_PHY_ADDR_INVALID;
 
 	if (!hw->phy.phy_semaphore_mask) {
 		if (hw->bus.lan_id)
@@ -282,7 +282,7 @@ s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 		if (ixgbe_probe_phy(hw, phy_addr))
 			return 0;
 		else
-			return IXGBE_ERR_PHY_ADDR_INVALID;
+			return -EFAULT;
 	}
 
 	for (phy_addr = 0; phy_addr < IXGBE_MAX_PHY_ADDR; phy_addr++) {
@@ -405,8 +405,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 		return status;
 
 	/* Don't reset PHY if it's shut down due to overtemp. */
-	if (!hw->phy.reset_if_overtemp &&
-	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
+	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
 		return 0;
 
 	/* Blocked by MNG FW so bail */
@@ -454,7 +453,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 
 	if (ctrl & MDIO_CTRL1_RESET) {
 		hw_dbg(hw, "PHY reset polling failed to complete.\n");
-		return IXGBE_ERR_RESET_FAILED;
+		return -EIO;
 	}
 
 	return 0;
@@ -496,7 +495,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address command did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Address cycle complete, setup and write the read
@@ -523,7 +522,7 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY read command didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Read operation is complete.  Get the data
@@ -555,7 +554,7 @@ s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -600,7 +599,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY address cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/*
@@ -628,7 +627,7 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 	if ((command & IXGBE_MSCA_MDI_COMMAND) != 0) {
 		hw_dbg(hw, "PHY write cmd didn't complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -653,7 +652,7 @@ s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 						 phy_data);
 		hw->mac.ops.release_swfw_sync(hw, gssr);
 	} else {
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	return status;
@@ -1299,7 +1298,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 	if ((phy_data & MDIO_CTRL1_RESET) != 0) {
 		hw_dbg(hw, "PHY reset did not complete.\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	/* Get init offsets */
@@ -1356,12 +1355,12 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 				hw_dbg(hw, "SOL\n");
 			} else {
 				hw_dbg(hw, "Bad control value\n");
-				return IXGBE_ERR_PHY;
+				return -EIO;
 			}
 			break;
 		default:
 			hw_dbg(hw, "Bad control type\n");
-			return IXGBE_ERR_PHY;
+			return -EIO;
 		}
 	}
 
@@ -1369,7 +1368,7 @@ s32 ixgbe_reset_phy_nl(struct ixgbe_hw *hw)
 
 err_eeprom:
 	hw_err(hw, "eeprom read at offset %d failed\n", data_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -1387,10 +1386,10 @@ s32 ixgbe_identify_module_generic(struct ixgbe_hw *hw)
 		return ixgbe_identify_qsfp_module_generic(hw);
 	default:
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1415,7 +1414,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1430,7 +1429,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_SFP) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	status = hw->phy.ops.read_i2c_eeprom(hw,
 					     IXGBE_SFF_1GBE_COMP_CODES,
@@ -1621,7 +1620,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1)) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	/* Anything else 82598-based is supported */
@@ -1645,7 +1644,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		}
 		hw_dbg(hw, "SFP+ module not supported\n");
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 	return 0;
 
@@ -1655,7 +1654,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
 		hw->phy.id = 0;
 		hw->phy.type = ixgbe_phy_unknown;
 	}
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1682,7 +1681,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_fiber_qsfp) {
 		hw->phy.sfp_type = ixgbe_sfp_type_not_present;
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	}
 
 	/* LAN ID is needed for sfp_type determination */
@@ -1696,7 +1695,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 
 	if (identifier != IXGBE_SFF_IDENTIFIER_QSFP_PLUS) {
 		hw->phy.type = ixgbe_phy_sfp_unsupported;
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	hw->phy.id = identifier;
@@ -1764,7 +1763,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 		} else {
 			/* unsupported module type */
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 	}
 
@@ -1824,7 +1823,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 			}
 			hw_dbg(hw, "QSFP module not supported\n");
 			hw->phy.type = ixgbe_phy_sfp_unsupported;
-			return IXGBE_ERR_SFP_NOT_SUPPORTED;
+			return -EOPNOTSUPP;
 		}
 		return 0;
 	}
@@ -1835,7 +1834,7 @@ static s32 ixgbe_identify_qsfp_module_generic(struct ixgbe_hw *hw)
 	hw->phy.id = 0;
 	hw->phy.type = ixgbe_phy_unknown;
 
-	return IXGBE_ERR_SFP_NOT_PRESENT;
+	return -ENOENT;
 }
 
 /**
@@ -1855,14 +1854,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	u16 sfp_type = hw->phy.sfp_type;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_unknown)
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	if (hw->phy.sfp_type == ixgbe_sfp_type_not_present)
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 
 	if ((hw->device_id == IXGBE_DEV_ID_82598_SR_DUAL_PORT_EM) &&
 	    (hw->phy.sfp_type == ixgbe_sfp_type_da_cu))
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 
 	/*
 	 * Limiting active cables and 1G Phys must be initialized as
@@ -1883,11 +1882,11 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 	if (hw->eeprom.ops.read(hw, IXGBE_PHY_INIT_OFFSET_NL, list_offset)) {
 		hw_err(hw, "eeprom read at %d failed\n",
 		       IXGBE_PHY_INIT_OFFSET_NL);
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 	}
 
 	if ((!*list_offset) || (*list_offset == 0xFFFF))
-		return IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT;
+		return -EIO;
 
 	/* Shift offset to first ID word */
 	(*list_offset)++;
@@ -1906,7 +1905,7 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 				goto err_phy;
 			if ((!*data_offset) || (*data_offset == 0xFFFF)) {
 				hw_dbg(hw, "SFP+ module not supported\n");
-				return IXGBE_ERR_SFP_NOT_SUPPORTED;
+				return -EOPNOTSUPP;
 			} else {
 				break;
 			}
@@ -1919,14 +1918,14 @@ s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 
 	if (sfp_id == IXGBE_PHY_INIT_END_NL) {
 		hw_dbg(hw, "No matching SFP+ module found\n");
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
 
 err_phy:
 	hw_err(hw, "eeprom read at offset %d failed\n", *list_offset);
-	return IXGBE_ERR_PHY;
+	return -EIO;
 }
 
 /**
@@ -2021,7 +2020,7 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 
 	do {
 		if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		ixgbe_i2c_start(hw);
 
@@ -2137,7 +2136,7 @@ static s32 ixgbe_write_i2c_byte_generic_int(struct ixgbe_hw *hw, u8 byte_offset,
 	u32 swfw_mask = hw->phy.phy_semaphore_mask;
 
 	if (lock && hw->mac.ops.acquire_swfw_sync(hw, swfw_mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	do {
 		ixgbe_i2c_start(hw);
@@ -2379,7 +2378,7 @@ static s32 ixgbe_get_i2c_ack(struct ixgbe_hw *hw)
 
 	if (ack == 1) {
 		hw_dbg(hw, "I2C ack was not received.\n");
-		status = IXGBE_ERR_I2C;
+		status = -EIO;
 	}
 
 	ixgbe_lower_i2c_clk(hw, &i2cctl);
@@ -2451,7 +2450,7 @@ static s32 ixgbe_clock_out_i2c_bit(struct ixgbe_hw *hw, bool data)
 		udelay(IXGBE_I2C_T_LOW);
 	} else {
 		hw_dbg(hw, "I2C data was not set to %X\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2547,7 +2546,7 @@ static s32 ixgbe_set_i2c_data(struct ixgbe_hw *hw, u32 *i2cctl, bool data)
 	*i2cctl = IXGBE_READ_REG(hw, IXGBE_I2CCTL(hw));
 	if (data != ixgbe_get_i2c_data(hw, i2cctl)) {
 		hw_dbg(hw, "Error - I2C data was not set to %X.\n", data);
-		return IXGBE_ERR_I2C;
+		return -EIO;
 	}
 
 	return 0;
@@ -2617,22 +2616,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Checks if the LASI temp alarm status was triggered due to overtemp
+ *
+ *  Return true when an overtemp event detected, otherwise false.
  **/
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
+	u32 status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
-		return 0;
+		return false;
 
 	/* Check that the LASI temp alarm status was triggered */
-	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
-			     MDIO_MMD_PMAPMD, &phy_data);
-
-	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
-		return 0;
+	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
+				      MDIO_MMD_PMAPMD, &phy_data);
+	if (status)
+		return false;
 
-	return IXGBE_ERR_OVERTEMP;
+	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM);
 }
 
 /** ixgbe_set_copper_phy_power - Control power for copper phy
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 6544c4539c0d..ef72729d7c93 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -155,7 +155,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 					u16 *list_offset,
 					u16 *data_offset);
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
 s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 5eba086690ef..0cd8bec6ae5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1279,7 +1279,7 @@ static int ixgbe_rcv_msg_from_vf(struct ixgbe_adapter *adapter, u32 vf)
 		break;
 	default:
 		e_err(drv, "Unhandled Msg %8.8x\n", msgbuf[0]);
-		retval = IXGBE_ERR_MBX;
+		retval = -EIO;
 		break;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2be1c4c72435..e84dbf6a3cb8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1247,7 +1247,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_PSRTYPE_RQPL_SHIFT    29
 
 /* CTRL Bit Masks */
-#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Master Disable bit */
+#define IXGBE_CTRL_GIO_DIS      0x00000004 /* Global IO Primary Disable bit */
 #define IXGBE_CTRL_LNK_RST      0x00000008 /* Link Reset. Resets everything. */
 #define IXGBE_CTRL_RST          0x04000000 /* Reset (SW) */
 #define IXGBE_CTRL_RST_MASK     (IXGBE_CTRL_LNK_RST | IXGBE_CTRL_RST)
@@ -1810,7 +1810,7 @@ enum {
 /* STATUS Bit Masks */
 #define IXGBE_STATUS_LAN_ID         0x0000000C /* LAN ID */
 #define IXGBE_STATUS_LAN_ID_SHIFT   2          /* LAN ID Shift*/
-#define IXGBE_STATUS_GIO            0x00080000 /* GIO Master Enable Status */
+#define IXGBE_STATUS_GIO            0x00080000 /* GIO Primary Enable Status */
 
 #define IXGBE_STATUS_LAN_ID_0   0x00000000 /* LAN ID 0 */
 #define IXGBE_STATUS_LAN_ID_1   0x00000004 /* LAN ID 1 */
@@ -2192,8 +2192,8 @@ enum {
 #define IXGBE_PCIDEVCTRL2_4_8s		0xd
 #define IXGBE_PCIDEVCTRL2_17_34s	0xe
 
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define IXGBE_PCI_MASTER_DISABLE_TIMEOUT	800
+/* Number of 100 microseconds we wait for PCI Express primary disable */
+#define IXGBE_PCI_PRIMARY_DISABLE_TIMEOUT	800
 
 /* RAH */
 #define IXGBE_RAH_VIND_MASK     0x003C0000
@@ -3505,10 +3505,10 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*check_overtemp)(struct ixgbe_hw *);
+	bool (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
-	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
 	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
@@ -3661,45 +3661,6 @@ struct ixgbe_info {
 	const u32			*mvals;
 };
 
-
-/* Error Codes */
-#define IXGBE_ERR_EEPROM                        -1
-#define IXGBE_ERR_EEPROM_CHECKSUM               -2
-#define IXGBE_ERR_PHY                           -3
-#define IXGBE_ERR_CONFIG                        -4
-#define IXGBE_ERR_PARAM                         -5
-#define IXGBE_ERR_MAC_TYPE                      -6
-#define IXGBE_ERR_UNKNOWN_PHY                   -7
-#define IXGBE_ERR_LINK_SETUP                    -8
-#define IXGBE_ERR_ADAPTER_STOPPED               -9
-#define IXGBE_ERR_INVALID_MAC_ADDR              -10
-#define IXGBE_ERR_DEVICE_NOT_SUPPORTED          -11
-#define IXGBE_ERR_MASTER_REQUESTS_PENDING       -12
-#define IXGBE_ERR_INVALID_LINK_SETTINGS         -13
-#define IXGBE_ERR_AUTONEG_NOT_COMPLETE          -14
-#define IXGBE_ERR_RESET_FAILED                  -15
-#define IXGBE_ERR_SWFW_SYNC                     -16
-#define IXGBE_ERR_PHY_ADDR_INVALID              -17
-#define IXGBE_ERR_I2C                           -18
-#define IXGBE_ERR_SFP_NOT_SUPPORTED             -19
-#define IXGBE_ERR_SFP_NOT_PRESENT               -20
-#define IXGBE_ERR_SFP_NO_INIT_SEQ_PRESENT       -21
-#define IXGBE_ERR_NO_SAN_ADDR_PTR               -22
-#define IXGBE_ERR_FDIR_REINIT_FAILED            -23
-#define IXGBE_ERR_EEPROM_VERSION                -24
-#define IXGBE_ERR_NO_SPACE                      -25
-#define IXGBE_ERR_OVERTEMP                      -26
-#define IXGBE_ERR_FC_NOT_NEGOTIATED             -27
-#define IXGBE_ERR_FC_NOT_SUPPORTED              -28
-#define IXGBE_ERR_SFP_SETUP_NOT_COMPLETE        -30
-#define IXGBE_ERR_PBA_SECTION                   -31
-#define IXGBE_ERR_INVALID_ARGUMENT              -32
-#define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
-#define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
-#define IXGBE_ERR_FW_RESP_INVALID		-39
-#define IXGBE_ERR_TOKEN_RETRY			-40
-#define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
-
 #define IXGBE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
 #define IXGBE_FUSES0_300MHZ		BIT(5)
 #define IXGBE_FUSES0_REV_MASK		(3u << 6)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index 4b93ba149ec5..fb4ced963c88 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -84,7 +84,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl = IXGBE_CTRL_RST;
@@ -103,7 +103,7 @@ s32 ixgbe_reset_hw_X540(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 	msleep(100);
@@ -220,7 +220,7 @@ static s32 ixgbe_read_eerd_X540(struct ixgbe_hw *hw, u16 offset, u16 *data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_generic(hw, offset, data);
 
@@ -243,7 +243,7 @@ static s32 ixgbe_read_eerd_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_read_eerd_buffer_generic(hw, offset, words, data);
 
@@ -264,7 +264,7 @@ static s32 ixgbe_write_eewr_X540(struct ixgbe_hw *hw, u16 offset, u16 data)
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_generic(hw, offset, data);
 
@@ -287,7 +287,7 @@ static s32 ixgbe_write_eewr_buffer_X540(struct ixgbe_hw *hw,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_eewr_buffer_generic(hw, offset, words, data);
 
@@ -324,7 +324,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	for (i = 0; i < checksum_last_word; i++) {
 		if (ixgbe_read_eerd_generic(hw, i, &word)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 		checksum += word;
 	}
@@ -349,7 +349,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 
 		if (ixgbe_read_eerd_generic(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
-			return IXGBE_ERR_EEPROM;
+			return -EIO;
 		}
 
 		/* Skip pointer section if length is invalid. */
@@ -360,7 +360,7 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		for (j = pointer + 1; j <= pointer + length; j++) {
 			if (ixgbe_read_eerd_generic(hw, j, &word)) {
 				hw_dbg(hw, "EEPROM read failed\n");
-				return IXGBE_ERR_EEPROM;
+				return -EIO;
 			}
 			checksum += word;
 		}
@@ -397,7 +397,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -418,7 +418,7 @@ static s32 ixgbe_validate_eeprom_checksum_X540(struct ixgbe_hw *hw,
 	 */
 	if (read_checksum != checksum) {
 		hw_dbg(hw, "Invalid EEPROM checksum");
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 	}
 
 	/* If the user cares, return the calculated checksum */
@@ -455,7 +455,7 @@ static s32 ixgbe_update_eeprom_checksum_X540(struct ixgbe_hw *hw)
 	}
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, IXGBE_GSSR_EEP_SM))
-		return  IXGBE_ERR_SWFW_SYNC;
+		return  -EBUSY;
 
 	status = hw->eeprom.ops.calc_checksum(hw);
 	if (status < 0)
@@ -490,7 +490,7 @@ static s32 ixgbe_update_flash_X540(struct ixgbe_hw *hw)
 	s32 status;
 
 	status = ixgbe_poll_flash_update_done_X540(hw);
-	if (status == IXGBE_ERR_EEPROM) {
+	if (status == -EIO) {
 		hw_dbg(hw, "Flash update time out\n");
 		return status;
 	}
@@ -540,7 +540,7 @@ static s32 ixgbe_poll_flash_update_done_X540(struct ixgbe_hw *hw)
 			return 0;
 		udelay(5);
 	}
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -575,7 +575,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 		 * SW_FW_SYNC bits (not just NVM)
 		 */
 		if (ixgbe_get_swfw_sync_semaphore(hw))
-			return IXGBE_ERR_SWFW_SYNC;
+			return -EBUSY;
 
 		swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 		if (!(swfw_sync & (fwmask | swmask | hwmask))) {
@@ -599,7 +599,7 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 	 * bits in the SW_FW_SYNC register.
 	 */
 	if (ixgbe_get_swfw_sync_semaphore(hw))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	swfw_sync = IXGBE_READ_REG(hw, IXGBE_SWFW_SYNC(hw));
 	if (swfw_sync & (fwmask | hwmask)) {
 		swfw_sync |= swmask;
@@ -622,11 +622,11 @@ s32 ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 			rmask |= IXGBE_GSSR_I2C_MASK;
 		ixgbe_release_swfw_sync_X540(hw, rmask);
 		ixgbe_release_swfw_sync_semaphore(hw);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 	ixgbe_release_swfw_sync_semaphore(hw);
 
-	return IXGBE_ERR_SWFW_SYNC;
+	return -EBUSY;
 }
 
 /**
@@ -680,7 +680,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	if (i == timeout) {
 		hw_dbg(hw,
 		       "Software semaphore SMBI between device drivers not granted.\n");
-		return IXGBE_ERR_EEPROM;
+		return -EIO;
 	}
 
 	/* Now get the semaphore between SW/FW through the REGSMP bit */
@@ -697,7 +697,7 @@ static s32 ixgbe_get_swfw_sync_semaphore(struct ixgbe_hw *hw)
 	 */
 	hw_dbg(hw, "REGSMP Software NVM semaphore not granted\n");
 	ixgbe_release_swfw_sync_semaphore(hw);
-	return IXGBE_ERR_EEPROM;
+	return -EIO;
 }
 
 /**
@@ -768,7 +768,7 @@ s32 ixgbe_blink_led_start_X540(struct ixgbe_hw *hw, u32 index)
 	bool link_up;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Link should be up in order for the blink bit in the LED control
 	 * register to work. Force link and speed in the MAC if link is down.
@@ -804,7 +804,7 @@ s32 ixgbe_blink_led_stop_X540(struct ixgbe_hw *hw, u32 index)
 	u32 ledctl_reg;
 
 	if (index > 3)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* Restore the LED to its default value. */
 	ledctl_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 37f2bc6de4b6..9347dc786b5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -206,13 +206,13 @@ static s32 ixgbe_reset_cs4227(struct ixgbe_hw *hw)
 	}
 	if (retry == IXGBE_CS4227_RETRIES) {
 		hw_err(hw, "CS4227 reset did not complete\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	status = ixgbe_read_cs4227(hw, IXGBE_CS4227_EEPROM_STATUS, &value);
 	if (status || !(value & IXGBE_CS4227_EEPROM_LOAD_OK)) {
 		hw_err(hw, "CS4227 EEPROM did not load successfully\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -350,13 +350,13 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 static s32 ixgbe_read_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				     u32 device_type, u16 *phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 static s32 ixgbe_write_phy_reg_x550em(struct ixgbe_hw *hw, u32 reg_addr,
 				      u32 device_type, u16 phy_data)
 {
-	return IXGBE_NOT_IMPLEMENTED;
+	return -EOPNOTSUPP;
 }
 
 /**
@@ -463,7 +463,7 @@ s32 ixgbe_fw_phy_activity(struct ixgbe_hw *hw, u16 activity,
 		--retries;
 	} while (retries > 0);
 
-	return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+	return -EIO;
 }
 
 static const struct {
@@ -511,7 +511,7 @@ static s32 ixgbe_get_phy_id_fw(struct ixgbe_hw *hw)
 	hw->phy.id |= phy_id_lo & IXGBE_PHY_REVISION_MASK;
 	hw->phy.revision = phy_id_lo & ~IXGBE_PHY_REVISION_MASK;
 	if (!hw->phy.id || hw->phy.id == IXGBE_PHY_REVISION_MASK)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	hw->phy.autoneg_advertised = hw->phy.speeds_supported;
 	hw->phy.eee_speeds_supported = IXGBE_LINK_SPEED_100_FULL |
@@ -568,7 +568,7 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	switch (hw->fc.requested_mode) {
@@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
 	if (rc)
 		return rc;
+
 	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
-		return IXGBE_ERR_OVERTEMP;
+		return -EIO;
+
 	return 0;
 }
 
@@ -675,7 +677,7 @@ static s32 ixgbe_iosf_wait(struct ixgbe_hw *hw, u32 *ctrl)
 		*ctrl = command;
 	if (i == IXGBE_MDIO_COMMAND_TIMEOUT) {
 		hw_dbg(hw, "IOSF wait timed out\n");
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 	return 0;
@@ -715,7 +717,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to read, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (!ret)
@@ -750,9 +753,9 @@ static s32 ixgbe_get_phy_token(struct ixgbe_hw *hw)
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
 	if (token_cmd.hdr.cmd_or_resp.ret_status != FW_PHY_TOKEN_RETRY)
-		return IXGBE_ERR_FW_RESP_INVALID;
+		return -EIO;
 
-	return IXGBE_ERR_TOKEN_RETRY;
+	return -EAGAIN;
 }
 
 /**
@@ -778,7 +781,7 @@ static s32 ixgbe_put_phy_token(struct ixgbe_hw *hw)
 		return status;
 	if (token_cmd.hdr.cmd_or_resp.ret_status == FW_PHY_TOKEN_OK)
 		return 0;
-	return IXGBE_ERR_FW_RESP_INVALID;
+	return -EIO;
 }
 
 /**
@@ -942,7 +945,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 		local_buffer = buf;
 	} else {
 		if (buffer_size < ptr)
-			return  IXGBE_ERR_PARAM;
+			return  -EINVAL;
 		local_buffer = &buffer[ptr];
 	}
 
@@ -960,7 +963,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 	}
 
 	if (buffer && ((u32)start + (u32)length > buffer_size))
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	for (i = start; length; i++, length--) {
 		if (i == bufsz && !buffer) {
@@ -1012,7 +1015,7 @@ static s32 ixgbe_calc_checksum_X550(struct ixgbe_hw *hw, u16 *buffer,
 		local_buffer = eeprom_ptrs;
 	} else {
 		if (buffer_size < IXGBE_EEPROM_LAST_WORD)
-			return IXGBE_ERR_PARAM;
+			return -EINVAL;
 		local_buffer = buffer;
 	}
 
@@ -1148,7 +1151,7 @@ static s32 ixgbe_validate_eeprom_checksum_X550(struct ixgbe_hw *hw,
 	 * calculated checksum
 	 */
 	if (read_checksum != checksum) {
-		status = IXGBE_ERR_EEPROM_CHECKSUM;
+		status = -EIO;
 		hw_dbg(hw, "Invalid EEPROM checksum");
 	}
 
@@ -1203,7 +1206,7 @@ static s32 ixgbe_write_ee_hostif_X550(struct ixgbe_hw *hw, u16 offset, u16 data)
 		hw->mac.ops.release_swfw_sync(hw, IXGBE_GSSR_EEP_SM);
 	} else {
 		hw_dbg(hw, "write ee hostif failed to get semaphore");
-		status = IXGBE_ERR_SWFW_SYNC;
+		status = -EBUSY;
 	}
 
 	return status;
@@ -1415,7 +1418,7 @@ static s32 ixgbe_write_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
 		error = (command & IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK) >>
 			 IXGBE_SB_IOSF_CTRL_CMPL_ERR_SHIFT;
 		hw_dbg(hw, "Failed to write, error %x\n", error);
-		return IXGBE_ERR_PHY;
+		return -EIO;
 	}
 
 out:
@@ -1558,7 +1561,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 
 	/* iXFI is only supported with X552 */
 	if (mac->type != ixgbe_mac_X550EM_x)
-		return IXGBE_ERR_LINK_SETUP;
+		return -EIO;
 
 	/* Disable AN and force speed to 10G Serial. */
 	status = ixgbe_read_iosf_sb_reg_x550(hw,
@@ -1580,7 +1583,7 @@ static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal KR PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = ixgbe_write_iosf_sb_reg_x550(hw,
@@ -1611,7 +1614,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 {
 	switch (hw->phy.sfp_type) {
 	case ixgbe_sfp_type_not_present:
-		return IXGBE_ERR_SFP_NOT_PRESENT;
+		return -ENOENT;
 	case ixgbe_sfp_type_da_cu_core0:
 	case ixgbe_sfp_type_da_cu_core1:
 		*linear = true;
@@ -1630,7 +1633,7 @@ static s32 ixgbe_supported_sfp_modules_X550em(struct ixgbe_hw *hw, bool *linear)
 	case ixgbe_sfp_type_1g_cu_core0:
 	case ixgbe_sfp_type_1g_cu_core1:
 	default:
-		return IXGBE_ERR_SFP_NOT_SUPPORTED;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -1660,7 +1663,7 @@ ixgbe_setup_mac_link_sfp_x550em(struct ixgbe_hw *hw,
 	 * there is no reason to configure CS4227 and SFP not present error is
 	 * not accepted in the setup MAC link flow.
 	 */
-	if (status == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (status == -ENOENT)
 		return 0;
 
 	if (status)
@@ -1718,7 +1721,7 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		break;
 	default:
 		/* Other link speeds are not supported by internal PHY. */
-		return IXGBE_ERR_LINK_SETUP;
+		return -EINVAL;
 	}
 
 	status = mac->ops.write_iosf_sb_reg(hw,
@@ -1753,7 +1756,7 @@ ixgbe_setup_mac_link_sfp_n(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1803,7 +1806,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* If no SFP module present, then return success. Return success since
 	 * SFP not present error is not excepted in the setup MAC link flow.
 	 */
-	if (ret_val == IXGBE_ERR_SFP_NOT_PRESENT)
+	if (ret_val == -ENOENT)
 		return 0;
 
 	if (ret_val)
@@ -1813,7 +1816,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	ixgbe_setup_kr_speed_x550em(hw, speed);
 
 	if (hw->phy.mdio.prtad == MDIO_PRTAD_NONE)
-		return IXGBE_ERR_PHY_ADDR_INVALID;
+		return -EFAULT;
 
 	/* Get external PHY SKU id */
 	ret_val = hw->phy.ops.read_reg(hw, IXGBE_CS4227_EFUSE_PDF_SKU,
@@ -1912,7 +1915,7 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	status = ixgbe_check_mac_link_generic(hw, speed, link_up,
 					      link_up_wait_to_complete);
@@ -2095,9 +2098,9 @@ static s32 ixgbe_setup_sgmii_fw(struct ixgbe_hw *hw, ixgbe_link_speed speed,
  */
 static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 {
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	u32 info[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2115,7 +2118,7 @@ static void ixgbe_fc_autoneg_sgmii_x550em_a(struct ixgbe_hw *hw)
 	/* Check if auto-negotiation has completed */
 	status = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &info);
 	if (status || !(info[0] & FW_PHY_ACT_GET_LINK_INFO_AN_COMPLETE)) {
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -2319,18 +2322,18 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  * @hw: pointer to hardware structure
  * @lsc: pointer to boolean flag which indicates whether external Base T
  *	 PHY interrupt is lsc
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Determime if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
+static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
+				       bool *is_overtemp)
 {
 	u32 status;
 	u16 reg;
 
+	*is_overtemp = false;
 	*lsc = false;
 
 	/* Vendor alarm triggered */
@@ -2362,7 +2365,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
 		/* power down the PHY in case the PHY FW didn't already */
 		ixgbe_set_copper_phy_power(hw, false);
-		return IXGBE_ERR_OVERTEMP;
+		*is_overtemp = true;
+		return -EIO;
 	}
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
 		/*  device fault alarm triggered */
@@ -2376,7 +2380,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
 			/* power down the PHY in case the PHY FW didn't */
 			ixgbe_set_copper_phy_power(hw, false);
-			return IXGBE_ERR_OVERTEMP;
+			*is_overtemp = true;
+			return -EIO;
 		}
 	}
 
@@ -2412,12 +2417,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
  **/
 static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
+	bool lsc, overtemp;
 	u32 status;
 	u16 reg;
-	bool lsc;
 
 	/* Clear interrupt flags */
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
 
 	/* Enable link status change alarm */
 
@@ -2496,21 +2501,20 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 /**
  * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
  * @hw: pointer to hardware structure
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Handle external Base T PHY interrupt. If high temperature
  * failure alarm then return error, else if link status change
  * then setup internal/external PHY link
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
+					  bool *is_overtemp)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
 	u32 status;
 
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
 		return status;
 
@@ -2642,7 +2646,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	u16 speed;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 
 	if (!(hw->mac.type == ixgbe_mac_X550EM_x &&
 	      !(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE))) {
@@ -2685,7 +2689,7 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		/* Internal PHY does not support anything else */
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	return ixgbe_setup_ixfi_x550em(hw, &force_speed);
@@ -2717,7 +2721,7 @@ static s32 ixgbe_led_on_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2739,7 +2743,7 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
 	u16 phy_data;
 
 	if (led_idx >= IXGBE_X557_MAX_LED_INDEX)
-		return IXGBE_ERR_PARAM;
+		return -EINVAL;
 
 	/* To turn on the LED, set mode to ON. */
 	hw->phy.ops.read_reg(hw, IXGBE_X557_LED_PROVISIONING + led_idx,
@@ -2763,8 +2767,9 @@ static s32 ixgbe_led_off_t_x550em(struct ixgbe_hw *hw, u32 led_idx)
  *
  *  Sends driver version number to firmware through the manageability
  *  block.  On success return 0
- *  else returns IXGBE_ERR_SWFW_SYNC when encountering an error acquiring
- *  semaphore or IXGBE_ERR_HOST_INTERFACE_COMMAND when command fails.
+ *  else returns -EBUSY when encountering an error acquiring
+ *  semaphore, -EIO when command fails or -ENIVAL when incorrect
+ *  params passed.
  **/
 static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 				     u8 build, u8 sub, u16 len,
@@ -2775,7 +2780,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 	int i;
 
 	if (!len || !driver_ver || (len > sizeof(fw_cmd.driver_string)))
-		return IXGBE_ERR_INVALID_ARGUMENT;
+		return -EINVAL;
 
 	fw_cmd.hdr.cmd = FW_CEM_CMD_DRIVER_INFO;
 	fw_cmd.hdr.buf_len = FW_CEM_CMD_DRIVER_INFO_LEN + len;
@@ -2800,7 +2805,7 @@ static s32 ixgbe_set_fw_drv_ver_x550(struct ixgbe_hw *hw, u8 maj, u8 min,
 
 		if (fw_cmd.hdr.cmd_or_resp.ret_status !=
 		    FW_CEM_RESP_STATUS_SUCCESS)
-			return IXGBE_ERR_HOST_INTERFACE_COMMAND;
+			return -EIO;
 		return 0;
 	}
 
@@ -2857,7 +2862,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	/* 10gig parts do not have a word in the EEPROM to determine the
@@ -2892,7 +2897,7 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	switch (hw->device_id) {
@@ -2936,8 +2941,8 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 {
 	u32 link_s1, lp_an_page_low, an_cntl_1;
-	s32 status = IXGBE_ERR_FC_NOT_NEGOTIATED;
 	ixgbe_link_speed speed;
+	s32 status = -EIO;
 	bool link_up;
 
 	/* AN should have completed when the cable was plugged in.
@@ -2963,7 +2968,7 @@ static void ixgbe_fc_autoneg_backplane_x550em_a(struct ixgbe_hw *hw)
 
 	if (status || (link_s1 & IXGBE_KRM_LINK_S1_MAC_AN_COMPLETE) == 0) {
 		hw_dbg(hw, "Auto-Negotiation did not complete\n");
-		status = IXGBE_ERR_FC_NOT_NEGOTIATED;
+		status = -EIO;
 		goto out;
 	}
 
@@ -3137,21 +3142,23 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
 /**
  * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
  * @hw: pointer to hardware structure
+ *
+ * Return true when an overtemp event detected, otherwise false.
  */
-static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
+static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
 {
 	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	s32 rc;
 
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
 	if (rc)
-		return rc;
+		return false;
 
 	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
 		ixgbe_shutdown_fw_phy(hw);
-		return IXGBE_ERR_OVERTEMP;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
@@ -3201,8 +3208,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 
 	/* Identify the PHY or SFP module */
 	ret_val = phy->ops.identify(hw);
-	if (ret_val == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    ret_val == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (ret_val == -EOPNOTSUPP || ret_val == -EFAULT)
 		return ret_val;
 
 	/* Setup function pointers based on detected hardware */
@@ -3410,8 +3416,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 
 	/* PHY ops must be identified and initialized prior to reset */
 	status = hw->phy.ops.init(hw);
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED ||
-	    status == IXGBE_ERR_PHY_ADDR_INVALID)
+	if (status == -EOPNOTSUPP || status == -EFAULT)
 		return status;
 
 	/* start the external PHY */
@@ -3427,7 +3432,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 		hw->phy.sfp_setup_needed = false;
 	}
 
-	if (status == IXGBE_ERR_SFP_NOT_SUPPORTED)
+	if (status == -EOPNOTSUPP)
 		return status;
 
 	/* Reset PHY */
@@ -3451,7 +3456,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	status = hw->mac.ops.acquire_swfw_sync(hw, swfw_mask);
 	if (status) {
 		hw_dbg(hw, "semaphore failed with %d", status);
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 	}
 
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
@@ -3469,7 +3474,7 @@ static s32 ixgbe_reset_hw_X550em(struct ixgbe_hw *hw)
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
-		status = IXGBE_ERR_RESET_FAILED;
+		status = -EIO;
 		hw_dbg(hw, "Reset polling failed to complete.\n");
 	}
 
@@ -3565,7 +3570,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 	/* Validate the requested mode */
 	if (hw->fc.strict_ieee && hw->fc.requested_mode == ixgbe_fc_rx_pause) {
 		hw_err(hw, "ixgbe_fc_rx_pause not valid in strict IEEE mode\n");
-		return IXGBE_ERR_INVALID_LINK_SETTINGS;
+		return -EINVAL;
 	}
 
 	if (hw->fc.requested_mode == ixgbe_fc_default)
@@ -3622,7 +3627,7 @@ static s32 ixgbe_setup_fc_backplane_x550em_a(struct ixgbe_hw *hw)
 		break;
 	default:
 		hw_err(hw, "Flow control param set incorrectly\n");
-		return IXGBE_ERR_CONFIG;
+		return -EIO;
 	}
 
 	status = hw->mac.ops.write_iosf_sb_reg(hw,
@@ -3718,7 +3723,7 @@ static s32 ixgbe_acquire_swfw_sync_x550em_a(struct ixgbe_hw *hw, u32 mask)
 			return 0;
 		if (hmask)
 			ixgbe_release_swfw_sync_X540(hw, hmask);
-		if (status != IXGBE_ERR_TOKEN_RETRY)
+		if (status != -EAGAIN)
 			return status;
 		msleep(FW_PHY_TOKEN_DELAY);
 	}
@@ -3762,7 +3767,7 @@ static s32 ixgbe_read_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = hw->phy.ops.read_reg_mdi(hw, reg_addr, device_type, phy_data);
 
@@ -3788,7 +3793,7 @@ static s32 ixgbe_write_phy_reg_x550a(struct ixgbe_hw *hw, u32 reg_addr,
 	s32 status;
 
 	if (hw->mac.ops.acquire_swfw_sync(hw, mask))
-		return IXGBE_ERR_SWFW_SYNC;
+		return -EBUSY;
 
 	status = ixgbe_write_phy_reg_mdi(hw, reg_addr, device_type, phy_data);
 	hw->mac.ops.release_swfw_sync(hw, mask);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index e0e6275b3e20..e4e80c2b1ce4 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -581,12 +581,38 @@ static int mvpp2_bm_pools_init(struct device *dev, struct mvpp2 *priv)
 	return err;
 }
 
+/* Cleanup pool before actual initialization in the OS */
+static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
+{
+	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
+	u32 val;
+	int i;
+
+	/* Drain the BM from all possible residues left by firmware */
+	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
+		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));
+
+	put_cpu();
+
+	/* Stop the BM pool */
+	val = mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
+	val |= MVPP2_BM_STOP_MASK;
+	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
+}
+
 static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 {
 	enum dma_data_direction dma_dir = DMA_FROM_DEVICE;
 	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
 	struct mvpp2_port *port;
 
+	if (priv->percpu_pools)
+		poolnum = mvpp2_get_nrxqs(priv) * 2;
+
+	/* Clean up the pool state in case it contains stale state */
+	for (i = 0; i < poolnum; i++)
+		mvpp2_bm_pool_cleanup(priv, i);
+
 	if (priv->percpu_pools) {
 		for (i = 0; i < priv->port_count; i++) {
 			port = priv->port_list[i];
@@ -596,7 +622,6 @@ static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
 			}
 		}
 
-		poolnum = mvpp2_get_nrxqs(priv) * 2;
 		for (i = 0; i < poolnum; i++) {
 			/* the pool in use */
 			int pn = i / (poolnum / 2);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 39475f6565c7..7c436bdcf5b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -208,11 +208,13 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 
 	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
 			sizeof(*ft->g), GFP_KERNEL);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if  (!in || !ft->g) {
-		kfree(ft->g);
-		kvfree(in);
+	if (!ft->g)
 		return -ENOMEM;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_free_g;
 	}
 
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
@@ -232,7 +234,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	switch (type) {
@@ -254,7 +256,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
@@ -263,7 +265,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	memset(in, 0, inlen);
@@ -272,18 +274,20 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	kvfree(in);
 	return 0;
 
-err:
+err_clean_group:
 	err = PTR_ERR(ft->g[ft->num_groups]);
 	ft->g[ft->num_groups] = NULL;
-out:
+err_free_in:
 	kvfree(in);
-
+err_free_g:
+	kfree(ft->g);
+	ft->g = NULL;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index df1363a34a42..9721fe58eb7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -667,6 +667,7 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 		switch (action_type) {
 		case DR_ACTION_TYP_DROP:
 			attr.final_icm_addr = nic_dmn->drop_icm_addr;
+			attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
 			break;
 		case DR_ACTION_TYP_FT:
 			dest_action = action;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 088ceac07b80..08d74d001aca 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -927,7 +927,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 	u16 nfp_mac_idx = 0;
 
 	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
-	if (entry && nfp_tunnel_is_mac_idx_global(entry->index)) {
+	if (entry && (nfp_tunnel_is_mac_idx_global(entry->index) || netif_is_lag_port(netdev))) {
 		if (entry->bridge_count ||
 		    !nfp_flower_is_supported_bridge(netdev)) {
 			nfp_tunnel_offloaded_macs_inc_ref_and_link(entry,
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 252fe06f58aa..4c513e7755f7 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -542,11 +542,13 @@ static int enable_bars(struct nfp6000_pcie *nfp, u16 interface)
 	const u32 barcfg_msix_general =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_GENERAL) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT;
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT);
 	const u32 barcfg_msix_xpb =
 		NFP_PCIE_BAR_PCIE2CPP_MapType(
 			NFP_PCIE_BAR_PCIE2CPP_MapType_BULK) |
-		NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT |
+		NFP_PCIE_BAR_PCIE2CPP_LengthSelect(
+			NFP_PCIE_BAR_PCIE2CPP_LengthSelect_32BIT) |
 		NFP_PCIE_BAR_PCIE2CPP_Target_BaseAddress(
 			NFP_CPP_TARGET_ISLAND_XPB);
 	const u32 barcfg_explicit[4] = {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index dc5fbc2704f3..b5f681918f6e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -200,6 +200,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 64d27e8e0772..1ce0d307a9d0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -136,6 +136,7 @@ struct ionic_dev {
 	unsigned long last_hb_time;
 	u32 last_hb;
 	u8 last_fw_status;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 00b6985edea0..694e710244e6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -333,7 +333,7 @@ int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds)
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	do {
 		done = ionic_dev_cmd_done(idev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index af4303523929..0bc345aff1cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -189,6 +189,7 @@ struct stmmac_safety_stats {
 	unsigned long mac_errors[32];
 	unsigned long mtl_errors[32];
 	unsigned long dma_errors[32];
+	unsigned long dma_dpp_errors[32];
 };
 
 /* Number of fields in Safety Stats */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index eee58e051387..4426cb923ac8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -282,6 +282,8 @@
 #define XGMAC_RXCEIE			BIT(4)
 #define XGMAC_TXCEIE			BIT(0)
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
+#define XGMAC_MTL_DPP_CONTROL		0x000010e0
+#define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_TQS_SHIFT			16
@@ -364,6 +366,7 @@
 #define XGMAC_DCEIE			BIT(1)
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
+#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index b06066746302..9a5dc5fde24a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -788,6 +788,44 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
+#define DPP_RX_ERR "Read Rx Descriptor Parity checker Error"
+#define DPP_TX_ERR "Read Tx Descriptor Parity checker Error"
+
+static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
+	{ true, "TDPES0", DPP_TX_ERR },
+	{ true, "TDPES1", DPP_TX_ERR },
+	{ true, "TDPES2", DPP_TX_ERR },
+	{ true, "TDPES3", DPP_TX_ERR },
+	{ true, "TDPES4", DPP_TX_ERR },
+	{ true, "TDPES5", DPP_TX_ERR },
+	{ true, "TDPES6", DPP_TX_ERR },
+	{ true, "TDPES7", DPP_TX_ERR },
+	{ true, "TDPES8", DPP_TX_ERR },
+	{ true, "TDPES9", DPP_TX_ERR },
+	{ true, "TDPES10", DPP_TX_ERR },
+	{ true, "TDPES11", DPP_TX_ERR },
+	{ true, "TDPES12", DPP_TX_ERR },
+	{ true, "TDPES13", DPP_TX_ERR },
+	{ true, "TDPES14", DPP_TX_ERR },
+	{ true, "TDPES15", DPP_TX_ERR },
+	{ true, "RDPES0", DPP_RX_ERR },
+	{ true, "RDPES1", DPP_RX_ERR },
+	{ true, "RDPES2", DPP_RX_ERR },
+	{ true, "RDPES3", DPP_RX_ERR },
+	{ true, "RDPES4", DPP_RX_ERR },
+	{ true, "RDPES5", DPP_RX_ERR },
+	{ true, "RDPES6", DPP_RX_ERR },
+	{ true, "RDPES7", DPP_RX_ERR },
+	{ true, "RDPES8", DPP_RX_ERR },
+	{ true, "RDPES9", DPP_RX_ERR },
+	{ true, "RDPES10", DPP_RX_ERR },
+	{ true, "RDPES11", DPP_RX_ERR },
+	{ true, "RDPES12", DPP_RX_ERR },
+	{ true, "RDPES13", DPP_RX_ERR },
+	{ true, "RDPES14", DPP_RX_ERR },
+	{ true, "RDPES15", DPP_RX_ERR },
+};
+
 static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 				    void __iomem *ioaddr, bool correctable,
 				    struct stmmac_safety_stats *stats)
@@ -799,6 +837,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 
 	dwxgmac3_log_error(ndev, value, correctable, "DMA",
 			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
+
+	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+
+	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
+			   dwxgmac3_dma_dpp_errors,
+			   STAT_OFF(dma_dpp_errors), stats);
 }
 
 static int dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp)
@@ -835,6 +880,12 @@ static int dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp)
 	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
 
+	/* 5. Enable Data Path Parity Protection */
+	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
+	/* already enabled by default, explicit enable it again */
+	value &= ~XGMAC_DPP_DISABLE;
+	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
+
 	return 0;
 }
 
@@ -868,7 +919,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
 		ret |= !corr;
 	}
 
-	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
+	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
+	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
+	 * Parity Errors here
+	 */
+	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
 	corr = dma & XGMAC_DECIS;
 	if (err) {
 		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
@@ -884,6 +939,7 @@ static const struct dwxgmac3_error {
 	{ dwxgmac3_mac_errors },
 	{ dwxgmac3_mtl_errors },
 	{ dwxgmac3_dma_errors },
+	{ dwxgmac3_dma_dpp_errors },
 };
 
 static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index 065bb0a40b1d..a1405a3e294c 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -220,21 +220,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 	mem_size = FJES_DEV_REQ_BUF_SIZE(hw->max_epid);
 	hw->hw_info.req_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.req_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.req_buf)) {
+		result = -ENOMEM;
+		goto free_ep_info;
+	}
 
 	hw->hw_info.req_buf_size = mem_size;
 
 	mem_size = FJES_DEV_RES_BUF_SIZE(hw->max_epid);
 	hw->hw_info.res_buf = kzalloc(mem_size, GFP_KERNEL);
-	if (!(hw->hw_info.res_buf))
-		return -ENOMEM;
+	if (!(hw->hw_info.res_buf)) {
+		result = -ENOMEM;
+		goto free_req_buf;
+	}
 
 	hw->hw_info.res_buf_size = mem_size;
 
 	result = fjes_hw_alloc_shared_status_region(hw);
 	if (result)
-		return result;
+		goto free_res_buf;
 
 	hw->hw_info.buffer_share_bit = 0;
 	hw->hw_info.buffer_unshare_reserve_bit = 0;
@@ -245,11 +249,11 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->tx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			result = fjes_hw_alloc_epbuf(&buf_pair->rx);
 			if (result)
-				return result;
+				goto free_epbuf;
 
 			spin_lock_irqsave(&hw->rx_status_lock, flags);
 			fjes_hw_setup_epbuf(&buf_pair->tx, mac,
@@ -272,6 +276,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
 	fjes_hw_init_command_registers(hw, &param);
 
 	return 0;
+
+free_epbuf:
+	for (epidx = 0; epidx < hw->max_epid ; epidx++) {
+		if (epidx == hw->my_epid)
+			continue;
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].tx);
+		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].rx);
+	}
+	fjes_hw_free_shared_status_region(hw);
+free_res_buf:
+	kfree(hw->hw_info.res_buf);
+	hw->hw_info.res_buf = NULL;
+free_req_buf:
+	kfree(hw->hw_info.req_buf);
+	hw->hw_info.req_buf = NULL;
+free_ep_info:
+	kfree(hw->ep_shm_info);
+	hw->ep_shm_info = NULL;
+	return result;
 }
 
 static void fjes_hw_cleanup(struct fjes_hw *hw)
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index d15da8287df3..3eae31c0f97a 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -654,7 +654,10 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Disable NAPI and disassociate its context from the device. */
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
-		napi_disable(&net_device->chan_table[i].napi);
+		/* only disable enabled NAPI channel */
+		if (i < ndev->real_num_rx_queues)
+			napi_disable(&net_device->chan_table[i].napi);
+
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index f14a9d190de9..aada8a3c1821 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -471,6 +471,10 @@ ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2fd5d2b7a209..4029c56dfcf0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2819,10 +2819,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -2859,8 +2860,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		callbacks[rxq2vq(i)] = skb_recv_done;
 		callbacks[txq2vq(i)] = skb_xmit_done;
-		sprintf(vi->rq[i].name, "input.%d", i);
-		sprintf(vi->sq[i].name, "output.%d", i);
+		sprintf(vi->rq[i].name, "input.%u", i);
+		sprintf(vi->sq[i].name, "output.%u", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 622fc7f17040..5037142c5a82 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -647,9 +647,10 @@ void ath9k_htc_txstatus(struct ath9k_htc_priv *priv, void *wmi_event)
 	struct ath9k_htc_tx_event *tx_pend;
 	int i;
 
-	for (i = 0; i < txs->cnt; i++) {
-		WARN_ON(txs->cnt > HTC_MAX_TX_STATUS);
+	if (WARN_ON_ONCE(txs->cnt > HTC_MAX_TX_STATUS))
+		return;
 
+	for (i = 0; i < txs->cnt; i++) {
 		__txs = &txs->txstatus[i];
 
 		skb = ath9k_htc_tx_get_packet(priv, __txs);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fdf2c6ea41d9..bcaec8a184cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -876,7 +876,7 @@ static int iwl_dbg_tlv_override_trig_node(struct iwl_fw_runtime *fwrt,
 		node_trig = (void *)node_tlv->data;
 	}
 
-	memcpy(node_trig->data + offset, trig->data, trig_data_len);
+	memcpy((u8 *)node_trig->data + offset, trig->data, trig_data_len);
 	node_tlv->length = cpu_to_le32(size);
 
 	if (policy & IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index b04f76551ca4..be3c153ab3b0 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -101,6 +101,7 @@ void rt2x00lib_disable_radio(struct rt2x00_dev *rt2x00dev)
 	rt2x00link_stop_tuner(rt2x00dev);
 	rt2x00queue_stop_queues(rt2x00dev);
 	rt2x00queue_flush_queues(rt2x00dev, true);
+	rt2x00queue_stop_queue(rt2x00dev->bcn);
 
 	/*
 	 * Disable radio.
@@ -1272,6 +1273,7 @@ int rt2x00lib_start(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 
 	/* Enable the radio */
 	retval = rt2x00lib_enable_radio(rt2x00dev);
@@ -1298,6 +1300,7 @@ void rt2x00lib_stop(struct rt2x00_dev *rt2x00dev)
 	rt2x00dev->intf_ap_count = 0;
 	rt2x00dev->intf_sta_count = 0;
 	rt2x00dev->intf_associated = 0;
+	rt2x00dev->intf_beaconing = 0;
 }
 
 static inline void rt2x00lib_set_if_combinations(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 2f68a31072ae..795bd3b0ebd8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -599,6 +599,17 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 	 */
 	if (changes & BSS_CHANGED_BEACON_ENABLED) {
 		mutex_lock(&intf->beacon_skb_mutex);
+
+		/*
+		 * Clear the 'enable_beacon' flag and clear beacon because
+		 * the beacon queue has been stopped after hardware reset.
+		 */
+		if (test_bit(DEVICE_STATE_RESET, &rt2x00dev->flags) &&
+		    intf->enable_beacon) {
+			intf->enable_beacon = false;
+			rt2x00queue_clear_beacon(rt2x00dev, vif);
+		}
+
 		if (!bss_conf->enable_beacon && intf->enable_beacon) {
 			rt2x00dev->intf_beaconing--;
 			intf->enable_beacon = false;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 004778faf3d0..3051fb358fdd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6973,6 +6973,18 @@ static const struct usb_device_id dev_table[] = {
 	.driver_info = (unsigned long)&rtl8192eu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x818c, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* D-Link DWA-131 rev C1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3312, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* TP-Link TL-WN8200ND V2 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0126, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UM */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0100, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
+/* Mercusys MW300UH */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0104, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192eu_fops},
 #endif
 { }
 };
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index fa0eed434d4f..d26dda8e46fd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -49,7 +49,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 							    rfpath, regaddr);
 	}
 
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -80,7 +80,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 			original_value = rtl8723_phy_rf_serial_read(hw,
 								    rfpath,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
@@ -89,7 +89,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 		rtl8723_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	} else {
 		if (bitmask != RFREG_OFFSET_MASK) {
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data =
 			    ((original_value & (~bitmask)) |
 			     (data << bitshift));
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index f09f55b0468a..35dfea54ae9c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -41,7 +41,7 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	spin_lock(&rtlpriv->locks.rf_lock);
 
 	original_value = rtl8723_phy_rf_serial_read(hw, rfpath, regaddr);
-	bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+	bitshift = calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
@@ -68,7 +68,7 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 	if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = rtl8723_phy_rf_serial_read(hw, path,
 								    regaddr);
-			bitshift = rtl8723_phy_calculate_bit_shift(bitmask);
+			bitshift = calculate_bit_shift(bitmask);
 			data = ((original_value & (~bitmask)) |
 				(data << bitshift));
 		}
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index d25bb5b9a54c..f5c5cf650b48 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -104,13 +104,12 @@ bool provides_xdp_headroom = true;
 module_param(provides_xdp_headroom, bool, 0644);
 
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status);
+			       s8 status);
 
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st);
-static void push_tx_responses(struct xenvif_queue *queue);
+			     s8 status);
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx);
 
@@ -208,13 +207,9 @@ static void xenvif_tx_err(struct xenvif_queue *queue,
 			  unsigned int extra_count, RING_IDX end)
 {
 	RING_IDX cons = queue->tx.req_cons;
-	unsigned long flags;
 
 	do {
-		spin_lock_irqsave(&queue->response_lock, flags);
 		make_tx_response(queue, txp, extra_count, XEN_NETIF_RSP_ERROR);
-		push_tx_responses(queue);
-		spin_unlock_irqrestore(&queue->response_lock, flags);
 		if (cons == end)
 			break;
 		RING_COPY_REQUEST(&queue->tx, cons++, txp);
@@ -465,12 +460,7 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
 	     nr_slots--) {
 		if (unlikely(!txp->size)) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&queue->response_lock, flags);
 			make_tx_response(queue, txp, 0, XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
-			spin_unlock_irqrestore(&queue->response_lock, flags);
 			++txp;
 			continue;
 		}
@@ -496,14 +486,8 @@ static void xenvif_get_requests(struct xenvif_queue *queue,
 
 		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots; ++txp) {
 			if (unlikely(!txp->size)) {
-				unsigned long flags;
-
-				spin_lock_irqsave(&queue->response_lock, flags);
 				make_tx_response(queue, txp, 0,
 						 XEN_NETIF_RSP_OKAY);
-				push_tx_responses(queue);
-				spin_unlock_irqrestore(&queue->response_lock,
-						       flags);
 				continue;
 			}
 
@@ -997,7 +981,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 					 (ret == 0) ?
 					 XEN_NETIF_RSP_OKAY :
 					 XEN_NETIF_RSP_ERROR);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1009,7 +992,6 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
 
 			make_tx_response(queue, &txreq, extra_count,
 					 XEN_NETIF_RSP_OKAY);
-			push_tx_responses(queue);
 			continue;
 		}
 
@@ -1444,8 +1426,35 @@ int xenvif_tx_action(struct xenvif_queue *queue, int budget)
 	return work_done;
 }
 
+static void _make_tx_response(struct xenvif_queue *queue,
+			     const struct xen_netif_tx_request *txp,
+			     unsigned int extra_count,
+			     s8 status)
+{
+	RING_IDX i = queue->tx.rsp_prod_pvt;
+	struct xen_netif_tx_response *resp;
+
+	resp = RING_GET_RESPONSE(&queue->tx, i);
+	resp->id     = txp->id;
+	resp->status = status;
+
+	while (extra_count-- != 0)
+		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+
+	queue->tx.rsp_prod_pvt = ++i;
+}
+
+static void push_tx_responses(struct xenvif_queue *queue)
+{
+	int notify;
+
+	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
+	if (notify)
+		notify_remote_via_irq(queue->tx_irq);
+}
+
 static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
-			       u8 status)
+			       s8 status)
 {
 	struct pending_tx_info *pending_tx_info;
 	pending_ring_idx_t index;
@@ -1455,8 +1464,8 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 
 	spin_lock_irqsave(&queue->response_lock, flags);
 
-	make_tx_response(queue, &pending_tx_info->req,
-			 pending_tx_info->extra_count, status);
+	_make_tx_response(queue, &pending_tx_info->req,
+			  pending_tx_info->extra_count, status);
 
 	/* Release the pending index before pusing the Tx response so
 	 * its available before a new Tx request is pushed by the
@@ -1470,32 +1479,19 @@ static void xenvif_idx_release(struct xenvif_queue *queue, u16 pending_idx,
 	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
-
 static void make_tx_response(struct xenvif_queue *queue,
-			     struct xen_netif_tx_request *txp,
+			     const struct xen_netif_tx_request *txp,
 			     unsigned int extra_count,
-			     s8       st)
+			     s8 status)
 {
-	RING_IDX i = queue->tx.rsp_prod_pvt;
-	struct xen_netif_tx_response *resp;
-
-	resp = RING_GET_RESPONSE(&queue->tx, i);
-	resp->id     = txp->id;
-	resp->status = st;
-
-	while (extra_count-- != 0)
-		RING_GET_RESPONSE(&queue->tx, ++i)->status = XEN_NETIF_RSP_NULL;
+	unsigned long flags;
 
-	queue->tx.rsp_prod_pvt = ++i;
-}
+	spin_lock_irqsave(&queue->response_lock, flags);
 
-static void push_tx_responses(struct xenvif_queue *queue)
-{
-	int notify;
+	_make_tx_response(queue, txp, extra_count, status);
+	push_tx_responses(queue);
 
-	RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&queue->tx, notify);
-	if (notify)
-		notify_remote_via_irq(queue->tx_irq);
+	spin_unlock_irqrestore(&queue->response_lock, flags);
 }
 
 static void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
diff --git a/drivers/of/property.c b/drivers/of/property.c
index a411460d2b21..758d6db590aa 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1306,7 +1306,7 @@ DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
-DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f9083c868a36..a334c68db339 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -48,6 +48,12 @@ static struct unittest_results {
 	failed; \
 })
 
+#ifdef CONFIG_OF_KOBJ
+#define OF_KREF_READ(NODE) kref_read(&(NODE)->kobj.kref)
+#else
+#define OF_KREF_READ(NODE) 1
+#endif
+
 /*
  * Expected message may have a message level other than KERN_INFO.
  * Print the expected message only if the current loglevel will allow
@@ -561,7 +567,7 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 			pr_err("missing testcase data\n");
 			return;
 		}
-		prefs[i] = kref_read(&p[i]->kobj.kref);
+		prefs[i] = OF_KREF_READ(p[i]);
 	}
 
 	rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
@@ -684,9 +690,9 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	for (i = 0; i < ARRAY_SIZE(p); ++i) {
-		unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
+		unittest(prefs[i] == OF_KREF_READ(p[i]),
 			 "provider%d: expected:%d got:%d\n",
-			 i, prefs[i], kref_read(&p[i]->kobj.kref));
+			 i, prefs[i], OF_KREF_READ(p[i]));
 		of_node_put(p[i]);
 	}
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 95ed719402d7..339318e790e2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/kernel.h>
 #include <linux/of.h>
 
 #include "pcie-designware.h"
@@ -593,6 +594,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 
 	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
+	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
 	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys,  msg_addr,
 				  epc->mem->window.page_size);
 	if (ret)
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 23548b517e4b..ea91d63c8be1 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -620,14 +620,20 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 		if (status & MSI_STATUS){
 			unsigned long imsi_status;
 
+			/*
+			 * The interrupt status can be cleared even if the
+			 * MSI status remains pending. As such, given the
+			 * edge-triggered interrupt type, its status should
+			 * be cleared before being dispatched to the
+			 * handler of the underlying device.
+			 */
+			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
 					virq = irq_find_mapping(port->inner_domain, bit);
 					generic_handle_irq(virq);
 				}
 			}
-			/* Clear MSI interrupt status */
-			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
 		}
 	}
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9564b74003f0..d58b02237075 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -741,7 +741,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -926,7 +926,12 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
+		u8 bus = e_info->id >> 8;
+		u8 devfn = e_info->id & 0xff;
+
+		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
+			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 		return false;
 	}
 	return true;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 21661feeeeb6..b67aea8d8f19 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -609,10 +609,13 @@ static void quirk_amd_dwc_class(struct pci_dev *pdev)
 {
 	u32 class = pdev->class;
 
-	/* Use "USB Device (not host controller)" class */
-	pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
-	pci_info(pdev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
-		 class, pdev->class);
+	if (class != PCI_CLASS_SERIAL_USB_DEVICE) {
+		/* Use "USB Device (not host controller)" class */
+		pdev->class = PCI_CLASS_SERIAL_USB_DEVICE;
+		pci_info(pdev,
+			"PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+			class, pdev->class);
+	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_dwc_class);
@@ -3638,6 +3641,19 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
 			       PCI_CLASS_DISPLAY_VGA, 8, quirk_no_pm_reset);
 
+/*
+ * Spectrum-{1,2,3,4} devices report that a D3hot->D0 transition causes a reset
+ * (i.e., they advertise NoSoftRst-). However, this transition does not have
+ * any effect on the device: It continues to be operational and network ports
+ * remain up. Advertising this support makes it seem as if a PM reset is viable
+ * for these devices. Mark it as unavailable to skip it when testing reset
+ * methods.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcb84, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf6c, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf70, quirk_no_pm_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0xcf80, quirk_no_pm_reset);
+
 /*
  * Thunderbolt controllers with broken MSI hotplug signaling:
  * Entire 1st generation (Light Ridge, Eagle Ridge, Light Peak) and part
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index ba52459928f7..5cea3ad290c5 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1251,13 +1251,6 @@ static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	if (stdev->dma_mrpc) {
-		iowrite32(0, &stdev->mmio_mrpc->dma_en);
-		flush_wc_buf(stdev);
-		writeq(0, &stdev->mmio_mrpc->dma_addr);
-		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
-				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
-	}
 	kfree(stdev);
 }
 
@@ -1301,7 +1294,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1335,6 +1328,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	return stdev;
 
 err_put:
+	pci_dev_put(stdev->pdev);
 	put_device(&stdev->dev);
 	return ERR_PTR(rc);
 }
@@ -1587,6 +1581,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static void switchtec_exit_pci(struct switchtec_dev *stdev)
+{
+	if (stdev->dma_mrpc) {
+		iowrite32(0, &stdev->mmio_mrpc->dma_en);
+		flush_wc_buf(stdev);
+		writeq(0, &stdev->mmio_mrpc->dma_addr);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+		stdev->dma_mrpc = NULL;
+	}
+}
+
 static int switchtec_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -1646,6 +1652,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
+	switchtec_exit_pci(stdev);
+	pci_dev_put(stdev->pdev);
+	stdev->pdev = NULL;
 	put_device(&stdev->dev);
 }
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 2cb949f931b6..c0802152f30b 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -633,8 +633,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
-		int ret;
-
 		channel->is_otg_channel = true;
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
 							"renesas,no-otg-pins");
@@ -693,8 +691,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		ret = PTR_ERR(provider);
 		goto error;
 	} else if (channel->is_otg_channel) {
-		int ret;
-
 		ret = device_create_file(dev, &dev_attr_role);
 		if (ret < 0)
 			goto error;
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index f77ac041d836..95e72f7a3199 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -116,7 +116,7 @@ static int omap_usb_set_vbus(struct usb_otg *otg, bool enabled)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->set_vbus)
 		return -ENODEV;
 
 	return phy->comparator->set_vbus(phy->comparator, enabled);
@@ -126,7 +126,7 @@ static int omap_usb_start_srp(struct usb_otg *otg)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->start_srp)
 		return -ENODEV;
 
 	return phy->comparator->start_srp(phy->comparator);
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index da78dc77aed3..9879deb4dc0b 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -151,13 +151,13 @@ static int vendor_resource_matches(struct pnp_dev *dev,
 static void pnpacpi_parse_allocated_vendor(struct pnp_dev *dev,
 				    struct acpi_resource_vendor_typed *vendor)
 {
-	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid, 16)) {
-		u64 start, length;
+	struct { u64 start, length; } range;
 
-		memcpy(&start, vendor->byte_data, sizeof(start));
-		memcpy(&length, vendor->byte_data + 8, sizeof(length));
-
-		pnp_add_mem_resource(dev, start, start + length - 1, 0);
+	if (vendor_resource_matches(dev, vendor, &hp_ccsr_uuid,
+				    sizeof(range))) {
+		memcpy(&range, vendor->byte_data, sizeof(range));
+		pnp_add_mem_resource(dev, range.start, range.start +
+				     range.length - 1, 0);
 	}
 }
 
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 51c4f604d3b2..54330eb0d03b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2768,7 +2768,8 @@ static int _regulator_enable(struct regulator *regulator)
 		/* Fallthrough on positive return values - already enabled */
 	}
 
-	rdev->use_count++;
+	if (regulator->enable_count == 1)
+		rdev->use_count++;
 
 	return 0;
 
@@ -2846,37 +2847,40 @@ static int _regulator_disable(struct regulator *regulator)
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
-	if (WARN(rdev->use_count <= 0,
+	if (WARN(regulator->enable_count == 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
 		return -EIO;
 
-	/* are we the last user and permitted to disable ? */
-	if (rdev->use_count == 1 &&
-	    (rdev->constraints && !rdev->constraints->always_on)) {
-
-		/* we are last user */
-		if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
-			ret = _notifier_call_chain(rdev,
-						   REGULATOR_EVENT_PRE_DISABLE,
-						   NULL);
-			if (ret & NOTIFY_STOP_MASK)
-				return -EINVAL;
-
-			ret = _regulator_do_disable(rdev);
-			if (ret < 0) {
-				rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
-				_notifier_call_chain(rdev,
-						REGULATOR_EVENT_ABORT_DISABLE,
+	if (regulator->enable_count == 1) {
+	/* disabling last enable_count from this regulator */
+		/* are we the last user and permitted to disable ? */
+		if (rdev->use_count == 1 &&
+		    (rdev->constraints && !rdev->constraints->always_on)) {
+
+			/* we are last user */
+			if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS)) {
+				ret = _notifier_call_chain(rdev,
+							   REGULATOR_EVENT_PRE_DISABLE,
+							   NULL);
+				if (ret & NOTIFY_STOP_MASK)
+					return -EINVAL;
+
+				ret = _regulator_do_disable(rdev);
+				if (ret < 0) {
+					rdev_err(rdev, "failed to disable: %pe\n", ERR_PTR(ret));
+					_notifier_call_chain(rdev,
+							REGULATOR_EVENT_ABORT_DISABLE,
+							NULL);
+					return ret;
+				}
+				_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
 						NULL);
-				return ret;
 			}
-			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
-					NULL);
-		}
 
-		rdev->use_count = 0;
-	} else if (rdev->use_count > 1) {
-		rdev->use_count--;
+			rdev->use_count = 0;
+		} else if (rdev->use_count > 1) {
+			rdev->use_count--;
+		}
 	}
 
 	if (ret == 0)
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 7d7ed4e5cce7..a8b5d10880c0 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -387,6 +387,7 @@ static void virtio_rpmsg_release_device(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
+	kfree(rpdev->driver_override);
 	kfree(vch);
 }
 
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7f560937bf7c..2c4ccab6e462 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -292,7 +292,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
 
 	/* This not only a rtc_op, but also called directly */
 	if (!is_valid_irq(cmos->irq))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	/* Basic alarms only support hour, minute, and seconds fields.
 	 * Some also support day and month, for alarms up to a year in
@@ -557,7 +557,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	 * Use mc146818_avoid_UIP() to avoid this.
 	 */
 	if (!mc146818_avoid_UIP(cmos_set_alarm_callback, &p))
-		return -EIO;
+		return -ETIMEDOUT;
 
 	cmos->alarm_expires = rtc_tm_to_time64(&t->time);
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d8cdf9024126..fee7b09ebc22 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -257,9 +257,10 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 		if (!recover) {
 			hash_del(&addr->hnode);
 			kfree(addr);
-			continue;
+		} else {
+			/* prepare for recovery */
+			addr->disp_flag = QETH_DISP_ADDR_ADD;
 		}
-		addr->disp_flag = QETH_DISP_ADDR_ADD;
 	}
 
 	mutex_unlock(&card->ip_lock);
@@ -280,9 +281,11 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			rc = qeth_l3_register_addr_entry(card, addr);
 
-			if (!rc) {
+			if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
+				/* keep it in the records */
 				addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			} else {
+				/* bad address */
 				hash_del(&addr->hnode);
 				kfree(addr);
 			}
diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 5d054d5c70a5..f2e587e66e19 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -77,9 +77,13 @@ struct device_attribute;
 #ifndef PCI_DEVICE_ID_ARECA_1203
 #define PCI_DEVICE_ID_ARECA_1203	0x1203
 #endif
+#ifndef PCI_DEVICE_ID_ARECA_1883
+#define PCI_DEVICE_ID_ARECA_1883	0x1883
+#endif
 #ifndef PCI_DEVICE_ID_ARECA_1884
 #define PCI_DEVICE_ID_ARECA_1884	0x1884
 #endif
+#define PCI_DEVICE_ID_ARECA_1886_0	0x1886
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 9294a2c677b3..199b102f31a2 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -208,8 +208,12 @@ static struct pci_device_id arcmsr_device_id_table[] = {
 		.driver_data = ACB_ADAPTER_TYPE_A},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1880),
 		.driver_data = ACB_ADAPTER_TYPE_C},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1883),
+		.driver_data = ACB_ADAPTER_TYPE_C},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1884),
 		.driver_data = ACB_ADAPTER_TYPE_E},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886_0),
+		.driver_data = ACB_ADAPTER_TYPE_F},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886),
 		.driver_data = ACB_ADAPTER_TYPE_F},
 	{0, 0}, /* Terminating entry */
@@ -4701,9 +4705,11 @@ static const char *arcmsr_info(struct Scsi_Host *host)
 	case PCI_DEVICE_ID_ARECA_1680:
 	case PCI_DEVICE_ID_ARECA_1681:
 	case PCI_DEVICE_ID_ARECA_1880:
+	case PCI_DEVICE_ID_ARECA_1883:
 	case PCI_DEVICE_ID_ARECA_1884:
 		type = "SAS/SATA";
 		break;
+	case PCI_DEVICE_ID_ARECA_1886_0:
 	case PCI_DEVICE_ID_ARECA_1886:
 		type = "NVMe/SAS/SATA";
 		break;
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index bf0b3178f84d..4371d8b00656 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -405,8 +405,8 @@ static char print_alua_state(unsigned char state)
 	}
 }
 
-static int alua_check_sense(struct scsi_device *sdev,
-			    struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition alua_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
 {
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
diff --git a/drivers/scsi/device_handler/scsi_dh_emc.c b/drivers/scsi/device_handler/scsi_dh_emc.c
index caa685cfe3d4..bd28ec6cfb72 100644
--- a/drivers/scsi/device_handler/scsi_dh_emc.c
+++ b/drivers/scsi/device_handler/scsi_dh_emc.c
@@ -280,8 +280,8 @@ static int send_trespass_cmd(struct scsi_device *sdev,
 	return res;
 }
 
-static int clariion_check_sense(struct scsi_device *sdev,
-				struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition clariion_check_sense(struct scsi_device *sdev,
+					struct scsi_sense_hdr *sense_hdr)
 {
 	switch (sense_hdr->sense_key) {
 	case NOT_READY:
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 85a71bafaea7..66652ab409cc 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -656,8 +656,8 @@ static blk_status_t rdac_prep_fn(struct scsi_device *sdev, struct request *req)
 	return BLK_STS_OK;
 }
 
-static int rdac_check_sense(struct scsi_device *sdev,
-				struct scsi_sense_hdr *sense_hdr)
+static enum scsi_disposition rdac_check_sense(struct scsi_device *sdev,
+					      struct scsi_sense_hdr *sense_hdr)
 {
 	struct rdac_dh_data *h = sdev->handler_data;
 
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index a2d60ad2a683..bbc5d6b9be73 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,17 +319,16 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -700,7 +699,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -734,11 +732,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1715,11 +1713,10 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1730,7 +1727,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1747,9 +1744,8 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1776,7 +1772,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index b6d68d871b6c..a4129e456efa 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -3398,7 +3398,7 @@ static enum sci_status isci_io_request_build(struct isci_host *ihost,
 		return SCI_FAILURE;
 	}
 
-	return SCI_SUCCESS;
+	return status;
 }
 
 static struct isci_request *isci_request_from_tag(struct isci_host *ihost, u16 tag)
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 7cfeb6886237..61c12dde967e 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -270,6 +270,11 @@ static int fc_fcp_send_abort(struct fc_fcp_pkt *fsp)
 	if (!fsp->seq_ptr)
 		return -EINVAL;
 
+	if (fsp->state & FC_SRB_ABORT_PENDING) {
+		FC_FCP_DBG(fsp, "abort already pending\n");
+		return -EBUSY;
+	}
+
 	per_cpu_ptr(fsp->lp->stats, get_cpu())->FcpPktAborts++;
 	put_cpu();
 
@@ -1681,7 +1686,7 @@ static void fc_fcp_rec_error(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		if (fsp->recov_retry++ < FC_MAX_RECOV_RETRY)
 			fc_fcp_rec(fsp);
 		else
-			fc_fcp_recovery(fsp, FC_ERROR);
+			fc_fcp_recovery(fsp, FC_TIMED_OUT);
 		break;
 	}
 	fc_fcp_unlock_pkt(fsp);
@@ -1700,11 +1705,12 @@ static void fc_fcp_recovery(struct fc_fcp_pkt *fsp, u8 code)
 	fsp->status_code = code;
 	fsp->cdb_status = 0;
 	fsp->io_status = 0;
-	/*
-	 * if this fails then we let the scsi command timer fire and
-	 * scsi-ml escalate.
-	 */
-	fc_fcp_send_abort(fsp);
+	if (!fsp->cmd)
+		/*
+		 * Only abort non-scsi commands; otherwise let the
+		 * scsi command timer fire and scsi-ml escalate.
+		 */
+		fc_fcp_send_abort(fsp);
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 03bc472f302a..cf69f831a725 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -32,6 +32,7 @@
 struct lpfc_sli2_slim;
 
 #define ELX_MODEL_NAME_SIZE	80
+#define ELX_FW_NAME_SIZE	84
 
 #define LPFC_PCI_DEV_LP		0x1
 #define LPFC_PCI_DEV_OC		0x2
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 1bb3c96a04bd..5f2009327a59 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13026,7 +13026,7 @@ lpfc_write_firmware(const struct firmware *fw, void *context)
 int
 lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 {
-	uint8_t file_name[ELX_MODEL_NAME_SIZE];
+	char file_name[ELX_FW_NAME_SIZE] = {0};
 	int ret;
 	const struct firmware *fw;
 
@@ -13035,7 +13035,7 @@ lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
 	    LPFC_SLI_INTF_IF_TYPE_2)
 		return -EPERM;
 
-	snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
+	scnprintf(file_name, sizeof(file_name), "%s.grp", phba->ModelName);
 
 	if (fw_upgrade == INT_FW_UPGRADE) {
 		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3d3d139127ee..ffc6f3031e82 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -60,14 +60,14 @@ static void scsi_eh_done(struct scsi_cmnd *scmd);
 #define HOST_RESET_SETTLE_TIME  (10)
 
 static int scsi_eh_try_stu(struct scsi_cmnd *scmd);
-static int scsi_try_to_abort_cmd(struct scsi_host_template *,
-				 struct scsi_cmnd *);
+static enum scsi_disposition scsi_try_to_abort_cmd(struct scsi_host_template *,
+						   struct scsi_cmnd *);
 
-void scsi_eh_wakeup(struct Scsi_Host *shost)
+void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy)
 {
 	lockdep_assert_held(shost->host_lock);
 
-	if (scsi_host_busy(shost) == shost->host_failed) {
+	if (busy == shost->host_failed) {
 		trace_scsi_eh_wakeup(shost);
 		wake_up_process(shost->ehandler);
 		SCSI_LOG_ERROR_RECOVERY(5, shost_printk(KERN_INFO, shost,
@@ -90,7 +90,7 @@ void scsi_schedule_eh(struct Scsi_Host *shost)
 	if (scsi_host_set_state(shost, SHOST_RECOVERY) == 0 ||
 	    scsi_host_set_state(shost, SHOST_CANCEL_RECOVERY) == 0) {
 		shost->host_eh_scheduled++;
-		scsi_eh_wakeup(shost);
+		scsi_eh_wakeup(shost, scsi_host_busy(shost));
 	}
 
 	spin_unlock_irqrestore(shost->host_lock, flags);
@@ -140,7 +140,7 @@ scmd_eh_abort_handler(struct work_struct *work)
 	struct scsi_cmnd *scmd =
 		container_of(work, struct scsi_cmnd, abort_work.work);
 	struct scsi_device *sdev = scmd->device;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	if (scsi_host_eh_past_deadline(sdev->host)) {
 		SCSI_LOG_ERROR_RECOVERY(3,
@@ -241,11 +241,12 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
+	unsigned int busy = scsi_host_busy(shost);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost);
+	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
@@ -478,7 +479,7 @@ static void scsi_report_sense(struct scsi_device *sdev,
  *	When a deferred error is detected the current command has
  *	not been executed and needs retrying.
  */
-int scsi_check_sense(struct scsi_cmnd *scmd)
+enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 {
 	struct scsi_device *sdev = scmd->device;
 	struct scsi_sense_hdr sshdr;
@@ -492,7 +493,7 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 		return NEEDS_RETRY;
 
 	if (sdev->handler && sdev->handler->check_sense) {
-		int rc;
+		enum scsi_disposition rc;
 
 		rc = sdev->handler->check_sense(sdev, &sshdr);
 		if (rc != SCSI_RETURN_NOT_HANDLED)
@@ -703,7 +704,7 @@ static void scsi_handle_queue_full(struct scsi_device *sdev)
  *    don't allow for the possibility of retries here, and we are a lot
  *    more restrictive about what we consider acceptable.
  */
-static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_eh_completed_normally(struct scsi_cmnd *scmd)
 {
 	/*
 	 * first check the host byte, to see if there is anything in there
@@ -784,10 +785,10 @@ static void scsi_eh_done(struct scsi_cmnd *scmd)
  * scsi_try_host_reset - ask host adapter to reset itself
  * @scmd:	SCSI cmd to send host reset.
  */
-static int scsi_try_host_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_host_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -814,10 +815,10 @@ static int scsi_try_host_reset(struct scsi_cmnd *scmd)
  * scsi_try_bus_reset - ask host to perform a bus reset
  * @scmd:	SCSI cmd to send bus reset.
  */
-static int scsi_try_bus_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_bus_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -856,10 +857,10 @@ static void __scsi_report_device_reset(struct scsi_device *sdev, void *data)
  *    timer on it, and set the host back to a consistent state prior to
  *    returning.
  */
-static int scsi_try_target_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_target_reset(struct scsi_cmnd *scmd)
 {
 	unsigned long flags;
-	int rtn;
+	enum scsi_disposition rtn;
 	struct Scsi_Host *host = scmd->device->host;
 	struct scsi_host_template *hostt = host->hostt;
 
@@ -887,9 +888,9 @@ static int scsi_try_target_reset(struct scsi_cmnd *scmd)
  *    timer on it, and set the host back to a consistent state prior to
  *    returning.
  */
-static int scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
 {
-	int rtn;
+	enum scsi_disposition rtn;
 	struct scsi_host_template *hostt = scmd->device->host->hostt;
 
 	if (!hostt->eh_device_reset_handler)
@@ -918,8 +919,8 @@ static int scsi_try_bus_device_reset(struct scsi_cmnd *scmd)
  *    if the device is temporarily unavailable (eg due to a
  *    link down on FibreChannel)
  */
-static int scsi_try_to_abort_cmd(struct scsi_host_template *hostt,
-				 struct scsi_cmnd *scmd)
+static enum scsi_disposition
+scsi_try_to_abort_cmd(struct scsi_host_template *hostt, struct scsi_cmnd *scmd)
 {
 	if (!hostt->eh_abort_handler)
 		return FAILED;
@@ -1052,8 +1053,8 @@ EXPORT_SYMBOL(scsi_eh_restore_cmnd);
  * Return value:
  *    SUCCESS or FAILED or NEEDS_RETRY
  */
-static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
-			     int cmnd_size, int timeout, unsigned sense_bytes)
+static enum scsi_disposition scsi_send_eh_cmnd(struct scsi_cmnd *scmd,
+	unsigned char *cmnd, int cmnd_size, int timeout, unsigned sense_bytes)
 {
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
@@ -1161,12 +1162,13 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
  *    that we obtain it on our own. This function will *not* return until
  *    the command either times out, or it completes.
  */
-static int scsi_request_sense(struct scsi_cmnd *scmd)
+static enum scsi_disposition scsi_request_sense(struct scsi_cmnd *scmd)
 {
 	return scsi_send_eh_cmnd(scmd, NULL, 0, scmd->device->eh_timeout, ~0);
 }
 
-static int scsi_eh_action(struct scsi_cmnd *scmd, int rtn)
+static enum scsi_disposition
+scsi_eh_action(struct scsi_cmnd *scmd, enum scsi_disposition rtn)
 {
 	if (!blk_rq_is_passthrough(scmd->request)) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
@@ -1219,7 +1221,7 @@ int scsi_eh_get_sense(struct list_head *work_q,
 {
 	struct scsi_cmnd *scmd, *next;
 	struct Scsi_Host *shost;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * If SCSI_EH_ABORT_SCHEDULED has been set, it is timeout IO,
@@ -1297,7 +1299,8 @@ EXPORT_SYMBOL_GPL(scsi_eh_get_sense);
 static int scsi_eh_tur(struct scsi_cmnd *scmd)
 {
 	static unsigned char tur_command[6] = {TEST_UNIT_READY, 0, 0, 0, 0, 0};
-	int retry_cnt = 1, rtn;
+	int retry_cnt = 1;
+	enum scsi_disposition rtn;
 
 retry_tur:
 	rtn = scsi_send_eh_cmnd(scmd, tur_command, 6,
@@ -1385,7 +1388,8 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd)
 	static unsigned char stu_command[6] = {START_STOP, 0, 0, 0, 1, 0};
 
 	if (scmd->device->allow_restart) {
-		int i, rtn = NEEDS_RETRY;
+		int i;
+		enum scsi_disposition rtn = NEEDS_RETRY;
 
 		for (i = 0; rtn == NEEDS_RETRY && i < 2; i++)
 			rtn = scsi_send_eh_cmnd(scmd, stu_command, 6, scmd->device->request_queue->rq_timeout, 0);
@@ -1479,7 +1483,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *bdr_scmd, *next;
 	struct scsi_device *sdev;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	shost_for_each_device(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
@@ -1546,7 +1550,7 @@ static int scsi_eh_target_reset(struct Scsi_Host *shost,
 
 	while (!list_empty(&tmp_list)) {
 		struct scsi_cmnd *next, *scmd;
-		int rtn;
+		enum scsi_disposition rtn;
 		unsigned int id;
 
 		if (scsi_host_eh_past_deadline(shost)) {
@@ -1604,7 +1608,7 @@ static int scsi_eh_bus_reset(struct Scsi_Host *shost,
 	struct scsi_cmnd *scmd, *chan_scmd, *next;
 	LIST_HEAD(check_list);
 	unsigned int channel;
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * we really want to loop over the various channels, and do this on
@@ -1675,7 +1679,7 @@ static int scsi_eh_host_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *next;
 	LIST_HEAD(check_list);
-	int rtn;
+	enum scsi_disposition rtn;
 
 	if (!list_empty(work_q)) {
 		scmd = list_entry(work_q->next,
@@ -1781,9 +1785,9 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
  *    doesn't require the error handler read (i.e. we don't need to
  *    abort/reset), this function should return SUCCESS.
  */
-int scsi_decide_disposition(struct scsi_cmnd *scmd)
+enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 {
-	int rtn;
+	enum scsi_disposition rtn;
 
 	/*
 	 * if the device is offline, then we clearly just pass the result back
@@ -2339,7 +2343,8 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	struct Scsi_Host *shost = dev->host;
 	struct request *rq;
 	unsigned long flags;
-	int error = 0, rtn, val;
+	int error = 0, val;
+	enum scsi_disposition rtn;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 99b90031500b..14dec86ff749 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -310,9 +310,11 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
+		unsigned int busy = scsi_host_busy(shost);
+
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost);
+			scsi_eh_wakeup(shost, busy);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
@@ -1426,7 +1428,7 @@ static bool scsi_mq_lld_busy(struct request_queue *q)
 static void scsi_softirq_done(struct request *rq)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
-	int disposition;
+	enum scsi_disposition disposition;
 
 	INIT_LIST_HEAD(&cmd->eh_entry);
 
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982..1183dbed687c 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -73,8 +73,8 @@ extern void scsi_exit_devinfo(void);
 extern void scmd_eh_abort_handler(struct work_struct *work);
 extern enum blk_eh_timer_return scsi_times_out(struct request *req);
 extern int scsi_error_handler(void *host);
-extern int scsi_decide_disposition(struct scsi_cmnd *cmd);
-extern void scsi_eh_wakeup(struct Scsi_Host *shost);
+extern enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *cmd);
+extern void scsi_eh_wakeup(struct Scsi_Host *shost, unsigned int busy);
 extern void scsi_eh_scmd_add(struct scsi_cmnd *);
 void scsi_eh_ready_devs(struct Scsi_Host *shost,
 			struct list_head *work_q,
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 2c734ea0784b..898658ab1dcd 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -19,7 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include "spi-bcm-qspi.h"
@@ -1048,7 +1048,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	/* non-aligned and very short transfers are handled by MSPI */
 	if (!IS_ALIGNED((uintptr_t)addr, 4) || !IS_ALIGNED((uintptr_t)buf, 4) ||
-	    len < 4)
+	    len < 4 || op->cmd.opcode == SPINOR_OP_RDSFDP)
 		mspi_read = true;
 
 	if (!has_bspi(qspi) || mspi_read)
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d8ee363fb714..4200b12fc347 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -166,10 +166,8 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	int scr;
 	u8 cdm = 0;
 	u32 speed;
-	u8 bits_per_word;
 
 	/* Start with the generic configuration for this device. */
-	bits_per_word = spi->bits_per_word;
 	speed = spi->max_speed_hz;
 
 	/*
@@ -177,9 +175,6 @@ static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
 	 * the transfer to overwrite the generic configuration with zeros.
 	 */
 	if (t) {
-		if (t->bits_per_word)
-			bits_per_word = t->bits_per_word;
-
 		if (t->speed_hz)
 			speed = min(t->speed_hz, spi->max_speed_hz);
 	}
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index dba78896ea8f..7d91d64b26f3 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -625,7 +625,7 @@ static void ad5933_work(struct work_struct *work)
 		struct ad5933_state, work.work);
 	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
 	__be16 buf[2];
-	int val[2];
+	u16 val[2];
 	unsigned char status;
 	int ret;
 
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 43f2eed6df78..355ee338d752 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,6 +1026,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.throttle	= up->port.throttle;
 		uart->port.unthrottle	= up->port.unthrottle;
 		uart->port.rs485_config	= up->port.rs485_config;
+		uart->port.rs485_supported = up->port.rs485_supported;
 		uart->port.rs485	= up->port.rs485;
 		uart->rs485_start_tx	= up->rs485_start_tx;
 		uart->rs485_stop_tx	= up->rs485_stop_tx;
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 5c2adf14049b..6e33c74e569f 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -123,6 +123,7 @@ struct exar8250;
 
 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	const struct serial_rs485 *rs485_supported;
 	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
 };
 
@@ -423,9 +424,14 @@ static int generic_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static const struct serial_rs485 generic_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+};
+
 static const struct exar8250_platform exar8250_default_platform = {
 	.register_gpio = xr17v35x_register_gpio,
 	.rs485_config = generic_rs485_config,
+	.rs485_supported = &generic_rs485_supported,
 };
 
 static int iot2040_rs485_config(struct uart_port *port,
@@ -461,6 +467,11 @@ static int iot2040_rs485_config(struct uart_port *port,
 	return generic_rs485_config(port, rs485);
 }
 
+static const struct serial_rs485 iot2040_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+};
+
 static const struct property_entry iot2040_gpio_properties[] = {
 	PROPERTY_ENTRY_U32("exar,first-pin", 10),
 	PROPERTY_ENTRY_U32("ngpios", 1),
@@ -485,6 +496,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 
 static const struct exar8250_platform iot2040_platform = {
 	.rs485_config = iot2040_rs485_config,
+	.rs485_supported = &iot2040_rs485_supported,
 	.register_gpio = iot2040_register_gpio,
 };
 
@@ -522,6 +534,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 	port->port.uartclk = baud * 16;
 	port->port.rs485_config = platform->rs485_config;
+	port->port.rs485_supported = platform->rs485_supported;
 
 	/*
 	 * Setup the UART clock for the devices on expansion slot to
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5bf8dd6198bb..14537878f985 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -235,6 +235,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Crystal-related definitions */
+#define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
 
@@ -610,12 +614,19 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 	/* Wait for crystal */
 	if (xtal) {
-		unsigned int val;
-		msleep(10);
-		regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
-		if (!(val & MAX310X_STS_CLKREADY_BIT)) {
+		bool stable = false;
+		unsigned int try = 0, val = 0;
+
+		do {
+			msleep(MAX310X_XTAL_WAIT_DELAY_MS);
+			regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
+
+			if (val & MAX310X_STS_CLKREADY_BIT)
+				stable = true;
+		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
+
+		if (!stable)
 			dev_warn(dev, "clock is not stable yet\n");
-		}
 	}
 
 	return (int)bestfreq;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index fd9be81bcfd8..31e0c5c3ddea 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -24,6 +24,7 @@
 #include <linux/tty_flip.h>
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 #include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
@@ -1449,9 +1450,12 @@ static int sc16is7xx_spi_probe(struct spi_device *spi)
 
 	/* Setup SPI bus */
 	spi->bits_per_word	= 8;
-	/* only supports mode 0 on SC16IS762 */
+	/* For all variants, only mode 0 is supported */
+	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
+		return dev_err_probe(&spi->dev, -EINVAL, "Unsupported SPI mode\n");
+
 	spi->mode		= spi->mode ? : SPI_MODE_0;
-	spi->max_speed_hz	= spi->max_speed_hz ? : 15000000;
+	spi->max_speed_hz	= spi->max_speed_hz ? : 4 * HZ_PER_MHZ;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 12a30329abdb..7ae2630cb750 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -763,7 +763,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -780,7 +780,7 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios_1(&kterm,
diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index 30d3516c7f98..4241c513b9f6 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -364,7 +364,7 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
 		return -EINVAL;
 
-	if (!(ctrl->wIndex & ~USB_DIR_IN))
+	if (!(le16_to_cpu(ctrl->wIndex) & ~USB_DIR_IN))
 		return 0;
 
 	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
@@ -790,7 +790,7 @@ int cdns3_gadget_ep_set_wedge(struct usb_ep *ep)
 	return 0;
 }
 
-const struct usb_ep_ops cdns3_gadget_ep0_ops = {
+static const struct usb_ep_ops cdns3_gadget_ep0_ops = {
 	.enable = cdns3_gadget_ep0_enable,
 	.disable = cdns3_gadget_ep0_disable,
 	.alloc_request = cdns3_gadget_ep_alloc_request,
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 210c1d615082..8a1f0a636848 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1118,6 +1118,8 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	dma_addr_t trb_dma;
 	u32 togle_pcs = 1;
 	int sg_iter = 0;
+	int num_trb_req;
+	int trb_burst;
 	int num_trb;
 	int address;
 	u32 control;
@@ -1126,15 +1128,13 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	struct scatterlist *s = NULL;
 	bool sg_supported = !!(request->num_mapped_sgs);
 
+	num_trb_req = sg_supported ? request->num_mapped_sgs : 1;
+
+	/* ISO transfer require each SOF have a TD, each TD include some TRBs */
 	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
-		num_trb = priv_ep->interval;
+		num_trb = priv_ep->interval * num_trb_req;
 	else
-		num_trb = sg_supported ? request->num_mapped_sgs : 1;
-
-	if (num_trb > priv_ep->free_trbs) {
-		priv_ep->flags |= EP_RING_FULL;
-		return -ENOBUFS;
-	}
+		num_trb = num_trb_req;
 
 	priv_req = to_cdns3_request(request);
 	address = priv_ep->endpoint.desc->bEndpointAddress;
@@ -1183,14 +1183,31 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 
 		link_trb->control = cpu_to_le32(((priv_ep->pcs) ? TRB_CYCLE : 0) |
 				    TRB_TYPE(TRB_LINK) | TRB_TOGGLE | ch_bit);
+
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
+			/*
+			 * ISO require LINK TRB must be first one of TD.
+			 * Fill LINK TRBs for left trb space to simply software process logic.
+			 */
+			while (priv_ep->enqueue) {
+				*trb = *link_trb;
+				trace_cdns3_prepare_trb(priv_ep, trb);
+
+				cdns3_ep_inc_enq(priv_ep);
+				trb = priv_ep->trb_pool + priv_ep->enqueue;
+				priv_req->trb = trb;
+			}
+		}
+	}
+
+	if (num_trb > priv_ep->free_trbs) {
+		priv_ep->flags |= EP_RING_FULL;
+		return -ENOBUFS;
 	}
 
 	if (priv_dev->dev_ver <= DEV_VER_V2)
 		togle_pcs = cdns3_wa1_update_guard(priv_ep, trb);
 
-	if (sg_supported)
-		s = request->sg;
-
 	/* set incorrect Cycle Bit for first trb*/
 	control = priv_ep->pcs ? 0 : TRB_CYCLE;
 	trb->length = 0;
@@ -1200,7 +1217,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 		td_size = DIV_ROUND_UP(request->length,
 				       priv_ep->endpoint.maxpacket);
 		if (priv_dev->gadget.speed == USB_SPEED_SUPER)
-			trb->length = TRB_TDL_SS_SIZE(td_size);
+			trb->length = cpu_to_le32(TRB_TDL_SS_SIZE(td_size));
 		else
 			control |= TRB_TDL_HS_SIZE(td_size);
 	}
@@ -1208,6 +1225,9 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	do {
 		u32 length;
 
+		if (!(sg_iter % num_trb_req) && sg_supported)
+			s = request->sg;
+
 		/* fill TRB */
 		control |= TRB_TYPE(TRB_NORMAL);
 		if (sg_supported) {
@@ -1222,7 +1242,36 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			total_tdl += DIV_ROUND_UP(length,
 					       priv_ep->endpoint.maxpacket);
 
-		trb->length |= cpu_to_le32(TRB_BURST_LEN(priv_ep->trb_burst_size) |
+		trb_burst = priv_ep->trb_burst_size;
+
+		/*
+		 * Supposed DMA cross 4k bounder problem should be fixed at DEV_VER_V2, but still
+		 * met problem when do ISO transfer if sg enabled.
+		 *
+		 * Data pattern likes below when sg enabled, package size is 1k and mult is 2
+		 *       [UVC Header(8B) ] [data(3k - 8)] ...
+		 *
+		 * The received data at offset 0xd000 will get 0xc000 data, len 0x70. Error happen
+		 * as below pattern:
+		 *	0xd000: wrong
+		 *	0xe000: wrong
+		 *	0xf000: correct
+		 *	0x10000: wrong
+		 *	0x11000: wrong
+		 *	0x12000: correct
+		 *	...
+		 *
+		 * But it is still unclear about why error have not happen below 0xd000, it should
+		 * cross 4k bounder. But anyway, the below code can fix this problem.
+		 *
+		 * To avoid DMA cross 4k bounder at ISO transfer, reduce burst len according to 16.
+		 */
+		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_dev->dev_ver <= DEV_VER_V2)
+			if (ALIGN_DOWN(trb->buffer, SZ_4K) !=
+			    ALIGN_DOWN(trb->buffer + length, SZ_4K))
+				trb_burst = 16;
+
+		trb->length |= cpu_to_le32(TRB_BURST_LEN(trb_burst) |
 					TRB_LEN(length));
 		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
 
@@ -1247,10 +1296,10 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			priv_req->trb->control = cpu_to_le32(control);
 
 		if (sg_supported) {
-			trb->control |= TRB_ISP;
+			trb->control |= cpu_to_le32(TRB_ISP);
 			/* Don't set chain bit for last TRB */
-			if (sg_iter < num_trb - 1)
-				trb->control |= TRB_CHAIN;
+			if ((sg_iter % num_trb_req) < num_trb_req - 1)
+				trb->control |= cpu_to_le32(TRB_CHAIN);
 
 			s = sg_next(s);
 		}
@@ -1507,6 +1556,12 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 
 		/* The TRB was changed as link TRB, and the request was handled at ep_dequeue */
 		while (TRB_FIELD_TO_TYPE(le32_to_cpu(trb->control)) == TRB_LINK) {
+
+			/* ISO ep_traddr may stop at LINK TRB */
+			if (priv_ep->dequeue == cdns3_get_dma_pos(priv_dev, priv_ep) &&
+			    priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				break;
+
 			trace_cdns3_complete_trb(priv_ep, trb);
 			cdns3_ep_inc_deq(priv_ep);
 			trb = priv_ep->trb_pool + priv_ep->dequeue;
@@ -1539,6 +1594,10 @@ static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 			}
 
 			if (request_handled) {
+				/* TRBs are duplicated by priv_ep->interval time for ISO IN */
+				if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir)
+					request->actual /= priv_ep->interval;
+
 				cdns3_gadget_giveback(priv_ep, priv_req, 0);
 				request_handled = false;
 				transfer_end = false;
@@ -2034,11 +2093,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
 	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
 	u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
-	u32 max_packet_size = 0;
-	u8 maxburst = 0;
+	u32 max_packet_size = priv_ep->wMaxPacketSize;
+	u8 maxburst = priv_ep->bMaxBurst;
 	u32 ep_cfg = 0;
 	u8 buffering;
-	u8 mult = 0;
 	int ret;
 
 	buffering = priv_dev->ep_buf_size - 1;
@@ -2060,8 +2118,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = priv_dev->ep_iso_burst - 1;
-		buffering = mult + 1;
+		buffering = (priv_ep->bMaxBurst + 1) * (priv_ep->mult + 1) - 1;
 	}
 
 	switch (priv_dev->gadget.speed) {
@@ -2072,17 +2129,8 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		max_packet_size = is_iso_ep ? 1024 : 512;
 		break;
 	case USB_SPEED_SUPER:
-		/* It's limitation that driver assumes in driver. */
-		mult = 0;
-		max_packet_size = 1024;
-		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = priv_dev->ep_iso_burst - 1;
-			buffering = (mult + 1) *
-				    (maxburst + 1);
-
-			if (priv_ep->interval > 1)
-				buffering++;
-		} else {
+		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+			max_packet_size = 1024;
 			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
@@ -2111,7 +2159,6 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	if (priv_dev->dev_ver < DEV_VER_V2)
 		priv_ep->trb_burst_size = 16;
 
-	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
 
@@ -2145,7 +2192,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	}
 
 	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
-		  EP_CFG_MULT(mult) |
+		  EP_CFG_MULT(priv_ep->mult) |			/* must match EP setting */
 		  EP_CFG_BUFFERING(buffering) |
 		  EP_CFG_MAXBURST(maxburst);
 
@@ -2235,6 +2282,13 @@ usb_ep *cdns3_gadget_match_ep(struct usb_gadget *gadget,
 	priv_ep->type = usb_endpoint_type(desc);
 	priv_ep->flags |= EP_CLAIMED;
 	priv_ep->interval = desc->bInterval ? BIT(desc->bInterval - 1) : 0;
+	priv_ep->wMaxPacketSize =  usb_endpoint_maxp(desc);
+	priv_ep->mult = USB_EP_MAXP_MULT(priv_ep->wMaxPacketSize);
+	priv_ep->wMaxPacketSize &= USB_ENDPOINT_MAXP_MASK;
+	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && comp_desc) {
+		priv_ep->mult =  USB_SS_MULT(comp_desc->bmAttributes) - 1;
+		priv_ep->bMaxBurst = comp_desc->bMaxBurst;
+	}
 
 	spin_unlock_irqrestore(&priv_dev->lock, flags);
 	return &priv_ep->endpoint;
@@ -3001,23 +3055,43 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 static int cdns3_gadget_check_config(struct usb_gadget *gadget)
 {
 	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct cdns3_endpoint *priv_ep;
 	struct usb_ep *ep;
 	int n_in = 0;
+	int iso = 0;
+	int out = 1;
 	int total;
+	int n;
 
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-		if (ep->claimed && (ep->address & USB_DIR_IN))
-			n_in++;
+		priv_ep = ep_to_cdns3_ep(ep);
+		if (!(priv_ep->flags & EP_CLAIMED))
+			continue;
+
+		n = (priv_ep->mult + 1) * (priv_ep->bMaxBurst + 1);
+		if (ep->address & USB_DIR_IN) {
+			/*
+			 * ISO transfer: DMA start move data when get ISO, only transfer
+			 * data as min(TD size, iso). No benefit for allocate bigger
+			 * internal memory than 'iso'.
+			 */
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				iso += n;
+			else
+				n_in++;
+		} else {
+			if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
+				out = max_t(int, out, n);
+		}
 	}
 
 	/* 2KB are reserved for EP0, 1KB for out*/
-	total = 2 + n_in + 1;
+	total = 2 + n_in + out + iso;
 
 	if (total > priv_dev->onchip_buffers)
 		return -ENOMEM;
 
-	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
-			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+	priv_dev->ep_buf_size = (priv_dev->onchip_buffers - 2 - iso) / (n_in + out);
 
 	return 0;
 }
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 32825477edd3..aeb2211228c1 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1167,6 +1167,9 @@ struct cdns3_endpoint {
 	u8			dir;
 	u8			num;
 	u8			type;
+	u8			mult;
+	u8			bMaxBurst;
+	u16			wMaxPacketSize;
 	int			interval;
 
 	int			free_trbs;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 331f41c6cc75..91b974aa59bf 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -46,8 +46,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
@@ -2367,17 +2367,25 @@ static int usb_enumerate_device_otg(struct usb_device *udev)
 			}
 		} else if (desc->bLength == sizeof
 				(struct usb_otg_descriptor)) {
-			/* Set a_alt_hnp_support for legacy otg device */
-			err = usb_control_msg(udev,
-				usb_sndctrlpipe(udev, 0),
-				USB_REQ_SET_FEATURE, 0,
-				USB_DEVICE_A_ALT_HNP_SUPPORT,
-				0, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
-			if (err < 0)
-				dev_err(&udev->dev,
-					"set a_alt_hnp_support failed: %d\n",
-					err);
+			/*
+			 * We are operating on a legacy OTP device
+			 * These should be told that they are operating
+			 * on the wrong port if we have another port that does
+			 * support HNP
+			 */
+			if (bus->otg_port != 0) {
+				/* Set a_alt_hnp_support for legacy otg device */
+				err = usb_control_msg(udev,
+					usb_sndctrlpipe(udev, 0),
+					USB_REQ_SET_FEATURE, 0,
+					USB_DEVICE_A_ALT_HNP_SUPPORT,
+					0, NULL, 0,
+					USB_CTRL_SET_TIMEOUT);
+				if (err < 0)
+					dev_err(&udev->dev,
+						"set a_alt_hnp_support failed: %d\n",
+						err);
+			}
 		}
 	}
 #endif
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 553547f12fd2..d20ca5974907 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -575,21 +575,37 @@ static int start_transfer(struct fsg_dev *fsg, struct usb_ep *ep,
 
 static bool start_in_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_SENDING;
-	if (start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_in, bh->inreq);
+	if (rc) {
 		bh->state = BUF_STATE_EMPTY;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
 static bool start_out_transfer(struct fsg_common *common, struct fsg_buffhd *bh)
 {
+	int rc;
+
 	if (!fsg_is_set(common))
 		return false;
 	bh->state = BUF_STATE_RECEIVING;
-	if (start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq))
+	rc = start_transfer(common->fsg, common->fsg->bulk_out, bh->outreq);
+	if (rc) {
 		bh->state = BUF_STATE_FULL;
+		if (rc == -ESHUTDOWN) {
+			common->running = 0;
+			return false;
+		}
+	}
 	return true;
 }
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index e56a1fb9715a..83c7dffa945c 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -323,6 +323,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
+			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 045e24174e1a..d161b64416a4 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -150,6 +150,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
+	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
 	{ USB_DEVICE(0x10C4, 0x8856) },	/* CEL EM357 ZigBee USB Stick - LR */
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 6be7358ca1af..43e8cb17b4c7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2269,6 +2269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index b1e844bf31f8..703a9c563557 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -184,6 +184,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
 	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
+	{DEVICE_SWI(0x413c, 0x8217)},	/* Dell Wireless DW5826e */
+	{DEVICE_SWI(0x413c, 0x8218)},	/* Dell Wireless DW5826e QDL */
 
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 04976435ad73..0c88d5bf09ca 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -70,9 +70,13 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
 	int ret;
 
-	set_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		set_bit(ACK_PENDING, &ua->flags);
+	else
+		set_bit(COMMAND_PENDING, &ua->flags);
 
 	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
 	if (ret)
@@ -82,7 +86,10 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
 		ret = -ETIMEDOUT;
 
 out_clear_bit:
-	clear_bit(COMMAND_PENDING, &ua->flags);
+	if (ack)
+		clear_bit(ACK_PENDING, &ua->flags);
+	else
+		clear_bit(COMMAND_PENDING, &ua->flags);
 
 	return ret;
 }
@@ -106,8 +113,10 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(COMMAND_PENDING, &ua->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
+		complete(&ua->complete);
+	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
+	    test_bit(COMMAND_PENDING, &ua->flags))
 		complete(&ua->complete);
 }
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index de110363af52..ab67160f7284 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2577,12 +2577,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 /* Create a new message. */
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
+	/* Make sure all padding within the structure is initialized. */
+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-	/* Make sure all padding within the structure is initialized. */
-	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 2b4831842162..6340ca058f89 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -263,6 +263,7 @@ static struct watchdog_device wdt_dev = {
 static int __init it87_wdt_init(void)
 {
 	u8  chip_rev;
+	u8 ctrl;
 	int rc;
 
 	rc = superio_enter();
@@ -321,7 +322,18 @@ static int __init it87_wdt_init(void)
 
 	superio_select(GPIO);
 	superio_outb(WDT_TOV1, WDTCFG);
-	superio_outb(0x00, WDTCTRL);
+
+	switch (chip_type) {
+	case IT8784_ID:
+	case IT8786_ID:
+		ctrl = superio_inb(WDTCTRL);
+		ctrl &= 0x08;
+		superio_outb(ctrl, WDTCTRL);
+		break;
+	default:
+		superio_outb(0x00, WDTCTRL);
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 4c13cbc99896..398ea69c176c 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-direct.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -56,7 +57,7 @@ struct gntdev_dmabuf {
 
 	/* Number of pages this buffer has. */
 	int nr_pages;
-	/* Pages of this buffer. */
+	/* Pages of this buffer (only for dma-buf export). */
 	struct page **pages;
 };
 
@@ -490,7 +491,7 @@ static int dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
 /* DMA buffer import support. */
 
 static int
-dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
+dmabuf_imp_grant_foreign_access(unsigned long *gfns, u32 *refs,
 				int count, int domid)
 {
 	grant_ref_t priv_gref_head;
@@ -513,7 +514,7 @@ dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
 		}
 
 		gnttab_grant_foreign_access_ref(cur_ref, domid,
-						xen_page_to_gfn(pages[i]), 0);
+						gfns[i], 0);
 		refs[i] = cur_ref;
 	}
 
@@ -535,7 +536,6 @@ static void dmabuf_imp_end_foreign_access(u32 *refs, int count)
 
 static void dmabuf_imp_free_storage(struct gntdev_dmabuf *gntdev_dmabuf)
 {
-	kfree(gntdev_dmabuf->pages);
 	kfree(gntdev_dmabuf->u.imp.refs);
 	kfree(gntdev_dmabuf);
 }
@@ -555,12 +555,6 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 	if (!gntdev_dmabuf->u.imp.refs)
 		goto fail;
 
-	gntdev_dmabuf->pages = kcalloc(count,
-				       sizeof(gntdev_dmabuf->pages[0]),
-				       GFP_KERNEL);
-	if (!gntdev_dmabuf->pages)
-		goto fail;
-
 	gntdev_dmabuf->nr_pages = count;
 
 	for (i = 0; i < count; i++)
@@ -582,7 +576,8 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 	struct dma_buf *dma_buf;
 	struct dma_buf_attachment *attach;
 	struct sg_table *sgt;
-	struct sg_page_iter sg_iter;
+	struct sg_dma_page_iter sg_iter;
+	unsigned long *gfns;
 	int i;
 
 	dma_buf = dma_buf_get(fd);
@@ -630,26 +625,31 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
 
 	gntdev_dmabuf->u.imp.sgt = sgt;
 
-	/* Now convert sgt to array of pages and check for page validity. */
+	gfns = kcalloc(count, sizeof(*gfns), GFP_KERNEL);
+	if (!gfns) {
+		ret = ERR_PTR(-ENOMEM);
+		goto fail_unmap;
+	}
+
+	/*
+	 * Now convert sgt to array of gfns without accessing underlying pages.
+	 * It is not allowed to access the underlying struct page of an sg table
+	 * exported by DMA-buf, but since we deal with special Xen dma device here
+	 * (not a normal physical one) look at the dma addresses in the sg table
+	 * and then calculate gfns directly from them.
+	 */
 	i = 0;
-	for_each_sgtable_page(sgt, &sg_iter, 0) {
-		struct page *page = sg_page_iter_page(&sg_iter);
-		/*
-		 * Check if page is valid: this can happen if we are given
-		 * a page from VRAM or other resources which are not backed
-		 * by a struct page.
-		 */
-		if (!pfn_valid(page_to_pfn(page))) {
-			ret = ERR_PTR(-EINVAL);
-			goto fail_unmap;
-		}
+	for_each_sgtable_dma_page(sgt, &sg_iter, 0) {
+		dma_addr_t addr = sg_page_iter_dma_address(&sg_iter);
+		unsigned long pfn = bfn_to_pfn(XEN_PFN_DOWN(dma_to_phys(dev, addr)));
 
-		gntdev_dmabuf->pages[i++] = page;
+		gfns[i++] = pfn_to_gfn(pfn);
 	}
 
-	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gntdev_dmabuf->pages,
+	ret = ERR_PTR(dmabuf_imp_grant_foreign_access(gfns,
 						      gntdev_dmabuf->u.imp.refs,
 						      count, domid));
+	kfree(gfns);
 	if (IS_ERR(ret))
 		goto fail_end_access;
 
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 7d9b23d981bf..229308c7f744 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -70,13 +70,14 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 0;
+	int seq = 1;
 
 	do {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&cell->volume_lock, &seq);
 
 		p = rcu_dereference_raw(cell->volumes.rb_node);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a59d6293a32b..0b927736ca72 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -418,6 +418,14 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
+		/* Don't expose silly rename entries to userspace. */
+		if (nlen > 6 &&
+		    dire->u.name[0] == '.' &&
+		    ctx->actor != afs_lookup_filldir &&
+		    ctx->actor != afs_lookup_one_filldir &&
+		    memcmp(dire->u.name, ".__afs", 6) == 0)
+			continue;
+
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 684a2b02b9ff..733e3c470f7e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -27,7 +27,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 1, diff;
 
 	rcu_read_lock();
 
@@ -35,6 +35,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		if (srx->transport.family == AF_INET6) {
@@ -90,7 +91,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq = 1;
 
 	_enter("%pU", uuid);
 
@@ -102,7 +103,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		if (server)
 			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
-
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
 
 		p = net->fs_servers.rb_node;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e25a3f64b2e..019f0925fa73 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1553,8 +1553,17 @@ static struct btrfs_root *btrfs_get_root_ref(struct btrfs_fs_info *fs_info,
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
-		/* Shouldn't get preallocated anon_dev for cached roots */
-		ASSERT(!anon_dev);
+		/*
+		 * Some other caller may have read out the newly inserted
+		 * subvolume already (for things like backref walk etc).  Not
+		 * that common but still possible.  In that case, we just need
+		 * to free the anon_dev.
+		 */
+		if (unlikely(anon_dev)) {
+			free_anon_bdev(anon_dev);
+			anon_dev = 0;
+		}
+
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8f62e171053b..3ba43a40032c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1202,7 +1202,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	u64 bytes_left, end;
 	u64 aligned_start = ALIGN(start, 1 << 9);
 
-	if (WARN_ON(start != aligned_start)) {
+	/* Adjust the range to be aligned to 512B sectors if necessary. */
+	if (start != aligned_start) {
 		len -= aligned_start - start;
 		len = round_down(len, 1 << 9);
 		start = aligned_start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c900a39666e3..250b6064876d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4007,7 +4007,8 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	struct btrfs_block_rsv block_rsv;
 	u64 root_flags;
 	int ret;
-	int err;
+
+	down_write(&fs_info->subvol_sem);
 
 	/*
 	 * Don't allow to delete a subvolume with send in progress. This is
@@ -4020,25 +4021,25 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu during send",
 			   dest->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	if (atomic_read(&dest->nr_swapfiles)) {
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
 			   root->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	root_flags = btrfs_root_flags(&dest->root_item);
 	btrfs_set_root_flags(&dest->root_item,
 			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
 	spin_unlock(&dest->root_item_lock);
 
-	down_write(&fs_info->subvol_sem);
-
-	err = may_destroy_subvol(dest);
-	if (err)
-		goto out_up_write;
+	ret = may_destroy_subvol(dest);
+	if (ret)
+		goto out_undead;
 
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
@@ -4046,13 +4047,13 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	 * two for dir entries,
 	 * two for root ref/backref.
 	 */
-	err = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
-	if (err)
-		goto out_up_write;
+	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
+	if (ret)
+		goto out_undead;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_release;
 	}
 	trans->block_rsv = &block_rsv;
@@ -4062,7 +4063,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 
 	ret = btrfs_unlink_subvol(trans, dir, dentry);
 	if (ret) {
-		err = ret;
 		btrfs_abort_transaction(trans, ret);
 		goto out_end_trans;
 	}
@@ -4080,7 +4080,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 					dest->root_key.objectid);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		}
 	}
@@ -4090,7 +4089,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 				  dest->root_key.objectid);
 	if (ret && ret != -ENOENT) {
 		btrfs_abort_transaction(trans, ret);
-		err = ret;
 		goto out_end_trans;
 	}
 	if (!btrfs_is_empty_uuid(dest->root_item.received_uuid)) {
@@ -4100,7 +4098,6 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 					  dest->root_key.objectid);
 		if (ret && ret != -ENOENT) {
 			btrfs_abort_transaction(trans, ret);
-			err = ret;
 			goto out_end_trans;
 		}
 	}
@@ -4111,20 +4108,20 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
 	ret = btrfs_end_transaction(trans);
-	if (ret && !err)
-		err = ret;
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
-out_up_write:
-	up_write(&fs_info->subvol_sem);
-	if (err) {
+out_undead:
+	if (ret) {
 		spin_lock(&dest->root_item_lock);
 		root_flags = btrfs_root_flags(&dest->root_item);
 		btrfs_set_root_flags(&dest->root_item,
 				root_flags & ~BTRFS_ROOT_SUBVOL_DEAD);
 		spin_unlock(&dest->root_item_lock);
-	} else {
+	}
+out_up_write:
+	up_write(&fs_info->subvol_sem);
+	if (!ret) {
 		d_invalidate(dentry);
 		btrfs_prune_dentries(dest);
 		ASSERT(dest->send_in_progress == 0);
@@ -4136,7 +4133,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
-	return err;
+	return ret;
 }
 
 static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f06824bea468..049b837934e5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -798,6 +798,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_trans_handle *trans;
 	int ret;
 
+	if (btrfs_root_refs(&root->root_item) == 0)
+		return -ENOENT;
+
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return -EINVAL;
 
@@ -3190,6 +3193,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				kfree(range);
 				goto out;
 			}
+			if (range->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_SUPP) {
+				ret = -EOPNOTSUPP;
+				goto out;
+			}
 			/* compression requires us to start the IO */
 			if ((range->flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
 				range->flags |= BTRFS_DEFRAG_RANGE_START_IO;
@@ -4318,6 +4325,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && is_fstree(sa->qgroupid)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a67323c2d41f..7f849310303b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1608,6 +1608,15 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+{
+	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
+		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+}
+
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1627,6 +1636,11 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 		goto out;
 	}
 
+	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Check if there are no children of this qgroup */
 	if (!list_empty(&qgroup->members)) {
 		ret = -EBUSY;
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index bd3bb94cc56b..c3711598a9be 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -899,8 +899,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 out_unlock:
 	spin_unlock(&fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		btrfs_free_ref_cache(fs_info);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }
 
@@ -1029,8 +1031,8 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		}
 	}
 	if (ret) {
-		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		btrfs_free_ref_cache(fs_info);
+		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 	}
 	btrfs_free_path(path);
 	return ret;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index af9701afcab7..0b04adfd4a4a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7285,7 +7285,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 32f1b15b25dc..c0eda3816f68 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1334,7 +1334,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		if (ptr + btrfs_extent_inline_ref_size(inline_type) > end) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
-				   ptr, inline_type, end);
+				   ptr, btrfs_extent_inline_ref_size(inline_type), end);
 			return -EUCLEAN;
 		}
 
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 432dc2a16e28..8e43d07ffa8b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1402,7 +1402,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
 		arg->old_xattr_buf = __ceph_build_xattrs_blob(ci);
 		arg->xattr_version = ci->i_xattrs.version;
-		arg->xattr_buf = ci->i_xattrs.blob;
+		arg->xattr_buf = ceph_buffer_get(ci->i_xattrs.blob);
 	} else {
 		arg->xattr_buf = NULL;
 		arg->old_xattr_buf = NULL;
@@ -1468,6 +1468,7 @@ static void __send_cap(struct cap_msg_args *arg, struct ceph_inode_info *ci)
 	encode_cap_msg(msg, arg);
 	ceph_con_send(&arg->session->s_con, msg);
 	ceph_buffer_put(arg->old_xattr_buf);
+	ceph_buffer_put(arg->xattr_buf);
 	if (arg->wake)
 		wake_up_all(&ci->i_cap_wq);
 }
@@ -4598,12 +4599,14 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
 	int ret;
 
+	/* This shouldn't happen */
+	BUG_ON(!dir);
+
 	/*
 	 * force an record for the directory caps if we have a dentry lease.
 	 * this is racy (can't take i_ceph_lock and d_lock together), but it
@@ -4613,14 +4616,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	if (!dir) {
-		parent = dget(dentry->d_parent);
-		dir = d_inode(parent);
-	}
 	spin_unlock(&dentry->d_lock);
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
-	dput(parent);
 
 	spin_lock(&dentry->d_lock);
 	if (ret && di->lease_session && di->lease_session->s_mds == mds) {
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index b98bba887f84..660e00eb4206 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -117,7 +117,7 @@ static __u32 get_neg_ctxt_len(struct smb2_sync_hdr *hdr, __u32 len,
 	} else if (nc_offset + 1 == non_ctxlen) {
 		cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
 		size_of_pad_before_neg_ctxts = 0;
-	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE)
+	} else if (non_ctxlen == SMB311_NEGPROT_BASE_SIZE + 1)
 		/* has padding, but no SPNEGO blob */
 		size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen + 1;
 	else
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 26edaeb4245d..84850a55c8b7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5561,7 +5561,7 @@ struct smb_version_values smb20_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5583,7 +5583,7 @@ struct smb_version_values smb21_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5604,7 +5604,7 @@ struct smb_version_values smb3any_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5625,7 +5625,7 @@ struct smb_version_values smbdefault_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5646,7 +5646,7 @@ struct smb_version_values smb30_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5667,7 +5667,7 @@ struct smb_version_values smb302_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
@@ -5688,7 +5688,7 @@ struct smb_version_values smb311_values = {
 	.header_size = sizeof(struct smb2_sync_hdr),
 	.header_preamble_size = 0,
 	.max_header_size = MAX_SMB2_HDR_SIZE,
-	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.read_rsp_size = sizeof(struct smb2_read_rsp),
 	.lock_cmd = SMB2_LOCK,
 	.cap_unix = 0,
 	.cap_nt_find = SMB2_NT_FIND,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 76679dc4e632..4aec01841f0f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1261,7 +1261,7 @@ SMB2_sess_sendreceive(struct SMB2_sess_data *sess_data)
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
 	req->SecurityBufferOffset =
-		cpu_to_le16(sizeof(struct smb2_sess_setup_req) - 1 /* pad */);
+		cpu_to_le16(sizeof(struct smb2_sess_setup_req));
 	req->SecurityBufferLength = cpu_to_le16(sess_data->iov[1].iov_len);
 
 	memset(&rqst, 0, sizeof(struct smb_rqst));
@@ -1760,8 +1760,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	iov[0].iov_len = total_len - 1;
 
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req)
-			- 1 /* pad */);
+	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
 	req->PathLength = cpu_to_le16(unc_path_len - 2);
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
@@ -4676,7 +4675,7 @@ int SMB2_query_directory_init(const unsigned int xid,
 	memcpy(bufptr, &asteriks, len);
 
 	req->FileNameOffset =
-		cpu_to_le16(sizeof(struct smb2_query_directory_req) - 1);
+		cpu_to_le16(sizeof(struct smb2_query_directory_req));
 	req->FileNameLength = cpu_to_le16(len);
 	/*
 	 * BB could be 30 bytes or so longer if we used SMB2 specific
@@ -4873,7 +4872,7 @@ SMB2_set_info_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 	req->AdditionalInformation = cpu_to_le32(additional_info);
 
 	req->BufferOffset =
-			cpu_to_le16(sizeof(struct smb2_set_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_set_info_req));
 	req->BufferLength = cpu_to_le32(*size);
 
 	memcpy(req->Buffer, *data, *size);
@@ -5105,9 +5104,9 @@ build_qfs_info_req(struct kvec *iov, struct cifs_tcon *tcon,
 	req->VolatileFileId = volatile_fid;
 	/* 1 for pad */
 	req->InputBufferOffset =
-			cpu_to_le16(sizeof(struct smb2_query_info_req) - 1);
+			cpu_to_le16(sizeof(struct smb2_query_info_req));
 	req->OutputBufferLength = cpu_to_le32(
-		outbuf_len + sizeof(struct smb2_query_info_rsp) - 1);
+		outbuf_len + sizeof(struct smb2_query_info_rsp));
 
 	iov->iov_base = (char *)req;
 	iov->iov_len = total_len;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 89a732b31390..eaa873175318 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -220,7 +220,7 @@ struct smb2_err_rsp {
 	__le16 StructureSize;
 	__le16 Reserved; /* MBZ */
 	__le32 ByteCount;  /* even if zero, at least one byte follows */
-	__u8   ErrorData[1];  /* variable length */
+	__u8   ErrorData[];  /* variable length */
 } __packed;
 
 #define SYMLINK_ERROR_TAG 0x4c4d5953
@@ -464,7 +464,7 @@ struct smb2_negotiate_rsp {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Flags */
@@ -481,7 +481,7 @@ struct smb2_sess_setup_req {
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
 	__u64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 /* Currently defined SessionFlags */
@@ -494,7 +494,7 @@ struct smb2_sess_setup_rsp {
 	__le16 SessionFlags;
 	__le16 SecurityBufferOffset;
 	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
+	__u8   Buffer[];	/* variable length GSS security buffer */
 } __packed;
 
 struct smb2_logoff_req {
@@ -520,7 +520,7 @@ struct smb2_tree_connect_req {
 	__le16 Flags; /* Reserved MBZ for dialects prior to SMB3.1.1 */
 	__le16 PathOffset;
 	__le16 PathLength;
-	__u8   Buffer[1];	/* variable length */
+	__u8   Buffer[];	/* variable length */
 } __packed;
 
 /* See MS-SMB2 section 2.2.9.2 */
@@ -828,7 +828,7 @@ struct smb2_create_rsp {
 	__u64  VolatileFileId; /* opaque endianness */
 	__le32 CreateContextsOffset;
 	__le32 CreateContextsLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct create_context {
@@ -1289,7 +1289,7 @@ struct smb2_read_plain_req {
 	__le32 RemainingBytes;
 	__le16 ReadChannelInfoOffset;
 	__le16 ReadChannelInfoLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Read flags */
@@ -1304,7 +1304,7 @@ struct smb2_read_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* For write request Flags field below the following flags are defined: */
@@ -1324,7 +1324,7 @@ struct smb2_write_req {
 	__le16 WriteChannelInfoOffset;
 	__le16 WriteChannelInfoLength;
 	__le32 Flags;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_write_rsp {
@@ -1335,7 +1335,7 @@ struct smb2_write_rsp {
 	__le32 DataLength;
 	__le32 DataRemaining;
 	__u32  Reserved2;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* notify flags */
@@ -1371,7 +1371,7 @@ struct smb2_change_notify_rsp {
 	__le16	StructureSize;  /* Must be 9 */
 	__le16	OutputBufferOffset;
 	__le32	OutputBufferLength;
-	__u8	Buffer[1]; /* array of file notify structs */
+	__u8	Buffer[]; /* array of file notify structs */
 } __packed;
 
 #define SMB2_LOCKFLAG_SHARED_LOCK	0x0001
@@ -1394,7 +1394,10 @@ struct smb2_lock_req {
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
 	/* Followed by at least one */
-	struct smb2_lock_element locks[1];
+	union {
+		struct smb2_lock_element lock;
+		DECLARE_FLEX_ARRAY(struct smb2_lock_element, locks);
+	};
 } __packed;
 
 struct smb2_lock_rsp {
@@ -1434,7 +1437,7 @@ struct smb2_query_directory_req {
 	__le16 FileNameOffset;
 	__le16 FileNameLength;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_directory_rsp {
@@ -1442,7 +1445,7 @@ struct smb2_query_directory_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /* Possible InfoType values */
@@ -1483,7 +1486,7 @@ struct smb2_query_info_req {
 	__le32 Flags;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_query_info_rsp {
@@ -1491,7 +1494,7 @@ struct smb2_query_info_rsp {
 	__le16 StructureSize; /* Must be 9 */
 	__le16 OutputBufferOffset;
 	__le32 OutputBufferLength;
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 /*
@@ -1514,7 +1517,7 @@ struct smb2_set_info_req {
 	__le32 AdditionalInformation;
 	__u64  PersistentFileId; /* opaque endianness */
 	__u64  VolatileFileId; /* opaque endianness */
-	__u8   Buffer[1];
+	__u8   Buffer[];
 } __packed;
 
 struct smb2_set_info_rsp {
@@ -1716,7 +1719,10 @@ struct smb2_file_all_info { /* data block encoding of response to level 18 */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char   FileName[1];
+	union {
+		char __pad;     /* Legacy structure padding */
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __packed; /* level 18 Query */
 
 struct smb2_file_eof_info { /* encoding of request for level 10 */
diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..976c7474d62a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -759,12 +759,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
-		return false;
+		dentry->d_lockref.count--;
+		goto locked;
 	}
 
 	/*
@@ -815,6 +815,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
+locked:
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
 		return true;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..c867a0d62f36 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -76,6 +76,14 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 
 	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
 		return ERR_PTR(-EXDEV);
+
+	/* Reject dealing with casefold directories. */
+	if (IS_CASEFOLDED(lower_inode)) {
+		pr_err_ratelimited("%s: Can't handle casefolded directory.\n",
+				   __func__);
+		return ERR_PTR(-EREMOTE);
+	}
+
 	if (!igrab(lower_inode))
 		return ERR_PTR(-ESTALE);
 	inode = iget5_locked(sb, (unsigned long)lower_inode,
diff --git a/fs/exec.c b/fs/exec.c
index 983295c0b8ac..2006e245b8f3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1392,6 +1392,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 out_unlock:
 	up_write(&me->signal->exec_update_lock);
+	if (!bprm->cred)
+		mutex_unlock(&me->signal->cred_guard_mutex);
+
 out:
 	return retval;
 }
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3babc07ae613..9bec75847b85 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5895,11 +5895,16 @@ __acquires(bitlock)
 static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 					   ext4_group_t grp)
 {
-	if (grp < ext4_get_groups_count(sb))
-		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
-		ext4_group_first_block_no(sb, grp) - 1) >>
-					EXT4_CLUSTER_BITS(sb);
+	unsigned long nr_clusters_in_group;
+
+	if (grp < (ext4_get_groups_count(sb) - 1))
+		nr_clusters_in_group = EXT4_CLUSTERS_PER_GROUP(sb);
+	else
+		nr_clusters_in_group = (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+					ext4_group_first_block_no(sb, grp))
+				       >> EXT4_CLUSTER_BITS(sb);
+
+	return nr_clusters_in_group - 1;
 }
 
 static bool ext4_trim_interrupted(void)
@@ -5911,13 +5916,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, last, origin_start;
 	bool set_trimmed = false;
 	void *bitmap;
 
+	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
-	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+	if (start == 0 && max >= last)
 		set_trimmed = true;
+	origin_start = start;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -5926,7 +5933,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		next = mb_find_next_bit(bitmap, last + 1, start);
+		if (origin_start == 0 && next >= last)
+			set_trimmed = true;
 
 		if ((next - start) >= minblocks) {
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 64a579734f93..f8dd5d972c33 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -615,6 +615,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		goto out;
 	o_end = o_start + len;
 
+	*moved_len = 0;
 	while (o_start < o_end) {
 		struct ext4_extent *ex;
 		ext4_lblk_t cur_blk, next_blk;
@@ -670,7 +671,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-		move_extent_per_page(o_filp, donor_inode,
+		*moved_len += move_extent_per_page(o_filp, donor_inode,
 				     orig_page_index, donor_page_index,
 				     offset_in_page, cur_len,
 				     unwritten, &ret);
@@ -680,9 +681,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		o_start += cur_len;
 		d_start += cur_len;
 	}
-	*moved_len = o_start - orig_blk;
-	if (*moved_len > len)
-		*moved_len = len;
 
 out:
 	if (*moved_len) {
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 9b4199a1e039..06e0eaf2ea4e 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -227,17 +227,24 @@ struct ext4_new_flex_group_data {
 						   in the flex group */
 	__u16 *bg_flags;			/* block group flags of groups
 						   in @groups */
+	ext4_group_t resize_bg;			/* number of allocated
+						   new_group_data */
 	ext4_group_t count;			/* number of groups in @groups
 						 */
 };
 
+/*
+ * Avoiding memory allocation failures due to too many groups added each time.
+ */
+#define MAX_RESIZE_BG				16384
+
 /*
  * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
  * @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
-static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
+static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
 {
 	struct ext4_new_flex_group_data *flex_gd;
 
@@ -245,17 +252,18 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (flexbg_size >= UINT_MAX / sizeof(struct ext4_new_group_data))
-		goto out2;
-	flex_gd->count = flexbg_size;
+	if (unlikely(flexbg_size > MAX_RESIZE_BG))
+		flex_gd->resize_bg = MAX_RESIZE_BG;
+	else
+		flex_gd->resize_bg = flexbg_size;
 
-	flex_gd->groups = kmalloc_array(flexbg_size,
+	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
 	if (flex_gd->groups == NULL)
 		goto out2;
 
-	flex_gd->bg_flags = kmalloc_array(flexbg_size, sizeof(__u16),
+	flex_gd->bg_flags = kmalloc_array(flex_gd->resize_bg, sizeof(__u16),
 					  GFP_NOFS);
 	if (flex_gd->bg_flags == NULL)
 		goto out1;
@@ -292,7 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
  */
 static int ext4_alloc_group_tables(struct super_block *sb,
 				struct ext4_new_flex_group_data *flex_gd,
-				int flexbg_size)
+				unsigned int flexbg_size)
 {
 	struct ext4_new_group_data *group_data = flex_gd->groups;
 	ext4_fsblk_t start_blk;
@@ -393,12 +401,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
 		group = group_data[0].group;
 
 		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
-		       "%d groups, flexbg size is %d:\n", flex_gd->count,
+		       "%u groups, flexbg size is %u:\n", flex_gd->count,
 		       flexbg_size);
 
 		for (i = 0; i < flex_gd->count; i++) {
 			ext4_debug(
-			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
+			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
 			       ext4_bg_has_super(sb, group + i) ? "normal" :
 			       "no-super", group + i,
 			       group_data[i].blocks_count,
@@ -1562,8 +1570,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 static int ext4_setup_next_flex_gd(struct super_block *sb,
 				    struct ext4_new_flex_group_data *flex_gd,
-				    ext4_fsblk_t n_blocks_count,
-				    unsigned long flexbg_size)
+				    ext4_fsblk_t n_blocks_count)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
@@ -1587,7 +1594,7 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
 	BUG_ON(last);
 	ext4_get_group_no_and_offset(sb, n_blocks_count - 1, &n_group, &last);
 
-	last_group = group | (flexbg_size - 1);
+	last_group = group | (flex_gd->resize_bg - 1);
 	if (last_group > n_group)
 		last_group = n_group;
 
@@ -1941,8 +1948,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	ext4_fsblk_t o_blocks_count;
 	ext4_fsblk_t n_blocks_count_retry = 0;
 	unsigned long last_update_time = 0;
-	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
+	int err = 0;
 	int meta_bg;
+	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
 
 	/* See if the device is actually as big as what was requested */
 	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
@@ -2083,8 +2091,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	/* Add flex groups. Note that a regular group is a
 	 * flex group with 1 group.
 	 */
-	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
-					      flexbg_size)) {
+	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count)) {
 		if (jiffies - last_update_time > HZ * 10) {
 			if (last_update_time)
 				ext4_msg(sb, KERN_INFO,
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c3c527afdd07..cd56af93df42 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -641,7 +641,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -649,12 +658,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
@@ -844,6 +855,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 7bcc60091287..b2d06f016ec6 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -799,8 +799,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (!f.file)
 		return -EBADF;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out;
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 72eb5ed54c2a..9b6849b9bfdb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -63,10 +63,10 @@
  */
 static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			int nblocks);
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
-static int dbBackSplit(dmtree_t * tp, int leafno);
-static int dbJoin(dmtree_t * tp, int leafno, int newval);
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl);
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl);
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl);
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl);
 static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
 		    int level);
 static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
@@ -2171,7 +2171,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
 		 * system.
 		 */
 		if (dp->tree.stree[word] == NOFREE)
-			dbBackSplit((dmtree_t *) & dp->tree, word);
+			dbBackSplit((dmtree_t *)&dp->tree, word, false);
 
 		dbAllocBits(bmp, dp, blkno, nblocks);
 	}
@@ -2257,7 +2257,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			 * the binary system of the leaves if need be.
 			 */
 			dbSplit(tp, word, BUDMIN,
-				dbMaxBud((u8 *) & dp->wmap[word]));
+				dbMaxBud((u8 *)&dp->wmap[word]), false);
 
 			word += 1;
 		} else {
@@ -2297,7 +2297,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 				 * system of the leaves to reflect the current
 				 * allocation (size).
 				 */
-				dbSplit(tp, word, size, NOFREE);
+				dbSplit(tp, word, size, NOFREE, false);
 
 				/* get the number of dmap words handled */
 				nw = BUDSIZE(size, BUDMIN);
@@ -2404,7 +2404,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 			/* update the leaf for this dmap word.
 			 */
 			rc = dbJoin(tp, word,
-				    dbMaxBud((u8 *) & dp->wmap[word]));
+				    dbMaxBud((u8 *)&dp->wmap[word]), false);
 			if (rc)
 				return rc;
 
@@ -2437,7 +2437,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
 
 				/* update the leaf.
 				 */
-				rc = dbJoin(tp, word, size);
+				rc = dbJoin(tp, word, size, false);
 				if (rc)
 					return rc;
 
@@ -2589,14 +2589,14 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 		 * that it is at the front of a binary buddy system.
 		 */
 		if (oldval == NOFREE) {
-			rc = dbBackSplit((dmtree_t *) dcp, leafno);
+			rc = dbBackSplit((dmtree_t *)dcp, leafno, true);
 			if (rc)
 				return rc;
 			oldval = dcp->stree[ti];
 		}
-		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
+		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
 	} else {
-		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
+		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
 		if (rc)
 			return rc;
 	}
@@ -2625,7 +2625,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 				 */
 				if (alloc) {
 					dbJoin((dmtree_t *) dcp, leafno,
-					       oldval);
+					       oldval, true);
 				} else {
 					/* the dbJoin() above might have
 					 * caused a larger binary buddy system
@@ -2635,9 +2635,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
 					 */
 					if (dcp->stree[ti] == NOFREE)
 						dbBackSplit((dmtree_t *)
-							    dcp, leafno);
+							    dcp, leafno, true);
 					dbSplit((dmtree_t *) dcp, leafno,
-						dcp->budmin, oldval);
+						dcp->budmin, oldval, true);
 				}
 
 				/* release the buffer and return the error.
@@ -2685,7 +2685,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
+static void dbSplit(dmtree_t *tp, int leafno, int splitsz, int newval, bool is_ctl)
 {
 	int budsz;
 	int cursz;
@@ -2707,7 +2707,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 		while (cursz >= splitsz) {
 			/* update the buddy's leaf with its new value.
 			 */
-			dbAdjTree(tp, leafno ^ budsz, cursz);
+			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
 
 			/* on to the next size and buddy.
 			 */
@@ -2719,7 +2719,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
 	/* adjust the dmap tree to reflect the specified leaf's new
 	 * value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 }
 
 
@@ -2750,7 +2750,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
  *
  * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
  */
-static int dbBackSplit(dmtree_t * tp, int leafno)
+static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
 {
 	int budsz, bud, w, bsz, size;
 	int cursz;
@@ -2801,7 +2801,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
 				 * system in two.
 				 */
 				cursz = leaf[bud] - 1;
-				dbSplit(tp, bud, cursz, cursz);
+				dbSplit(tp, bud, cursz, cursz, is_ctl);
 				break;
 			}
 		}
@@ -2829,7 +2829,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
  *
  * RETURN VALUES: none
  */
-static int dbJoin(dmtree_t * tp, int leafno, int newval)
+static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int budsz, buddy;
 	s8 *leaf;
@@ -2884,12 +2884,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 			if (leafno < buddy) {
 				/* leafno is the left buddy.
 				 */
-				dbAdjTree(tp, buddy, NOFREE);
+				dbAdjTree(tp, buddy, NOFREE, is_ctl);
 			} else {
 				/* buddy is the left buddy and becomes
 				 * leafno.
 				 */
-				dbAdjTree(tp, leafno, NOFREE);
+				dbAdjTree(tp, leafno, NOFREE, is_ctl);
 				leafno = buddy;
 			}
 
@@ -2902,7 +2902,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
 
 	/* update the leaf value.
 	 */
-	dbAdjTree(tp, leafno, newval);
+	dbAdjTree(tp, leafno, newval, is_ctl);
 
 	return 0;
 }
@@ -2923,15 +2923,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
  *
  * RETURN VALUES: none
  */
-static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
+static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
 	int lp, pp, k;
-	int max;
+	int max, size;
+
+	size = is_ctl ? CTLTREESIZE : TREESIZE;
 
 	/* pick up the index of the leaf for this leafno.
 	 */
 	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
 
+	if (WARN_ON_ONCE(lp >= size || lp < 0))
+		return;
+
 	/* is the current value the same as the old value ?  if so,
 	 * there is nothing to do.
 	 */
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 837d42f61464..a222a9d71887 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -633,6 +633,11 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
 			index = base + (lim >> 1);
 
+			if (stbl[index] < 0) {
+				rc = -EIO;
+				goto out;
+			}
+
 			if (p->header.flag & BT_LEAF) {
 				/* uppercase leaf name to compare */
 				cmp =
@@ -1970,7 +1975,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 14f918a4831d..b0965f3ef186 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2181,6 +2181,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index aa4ff7bcaff2..55702b31ab3c 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -172,15 +172,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c91ee05cce74..0ba056e06e48 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -696,6 +696,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs
+		 */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
diff --git a/fs/namei.c b/fs/namei.c
index 3ff954a2bbd1..cb37d7c477e0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2771,20 +2771,14 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
 		return p;
 	}
 
 	p = d_ancestor(p1, p2);
-	if (p) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
-		return p;
-	}
-
-	lock_two_inodes(p1->d_inode, p2->d_inode,
-			I_MUTEX_PARENT, I_MUTEX_PARENT2);
-	return NULL;
+	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	return p;
 }
 EXPORT_SYMBOL(lock_rename);
 
@@ -4260,11 +4254,12 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *
  *	a) we can get into loop creation.
  *	b) race potential - two innocent renames can create a loop together.
- *	   That's where 4.4 screws up. Current fix: serialization on
+ *	   That's where 4.4BSD screws up. Current fix: serialization on
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
- *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source.
+ *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
+ *	   and source (if it's a non-directory or a subdirectory that moves to
+ *	   different parent).
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4293,6 +4288,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
+	bool lock_old_subdir, lock_new_subdir;
 
 	if (source == target)
 		return 0;
@@ -4342,15 +4338,32 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
 	/*
-	 * Lock all moved children. Moved directories may need to change parent
-	 * pointer so they need the lock to prevent against concurrent
-	 * directory changes moving parent pointer. For regular files we've
-	 * historically always done this. The lockdep locking subclasses are
-	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
-	 * regular files and directories so it's difficult to tell which
-	 * subclasses to use.
+	 * Lock children.
+	 * The source subdirectory needs to be locked on cross-directory
+	 * rename or cross-directory exchange since its parent changes.
+	 * The target subdirectory needs to be locked on cross-directory
+	 * exchange due to parent change and on any rename due to becoming
+	 * a victim.
+	 * Non-directories need locking in all cases (for NFS reasons);
+	 * they get locked after any subdirectories (in inode address order).
+	 *
+	 * NOTE: WE ONLY LOCK UNRELATED DIRECTORIES IN CROSS-DIRECTORY CASE.
+	 * NEVER, EVER DO THAT WITHOUT ->s_vfs_rename_mutex.
 	 */
-	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
+	lock_old_subdir = new_dir != old_dir;
+	lock_new_subdir = new_dir != old_dir || !(flags & RENAME_EXCHANGE);
+	if (is_dir) {
+		if (lock_old_subdir)
+			inode_lock_nested(source, I_MUTEX_CHILD);
+		if (target && (!new_is_dir || lock_new_subdir))
+			inode_lock(target);
+	} else if (new_is_dir) {
+		if (lock_new_subdir)
+			inode_lock_nested(target, I_MUTEX_CHILD);
+		inode_lock(source);
+	} else {
+		lock_two_nondirectories(source, target);
+	}
 
 	error = -EBUSY;
 	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
@@ -4394,8 +4407,9 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	inode_unlock(source);
-	if (target)
+	if (!is_dir || lock_old_subdir)
+		inode_unlock(source);
+	if (target && (!new_is_dir || lock_new_subdir))
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 8fedc7104320..22b1ca5c379d 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -40,8 +40,21 @@ static inline struct nilfs_dat_info *NILFS_DAT_I(struct inode *dat)
 static int nilfs_dat_prepare_entry(struct inode *dat,
 				   struct nilfs_palloc_req *req, int create)
 {
-	return nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
-					    create, &req->pr_entry_bh);
+	int ret;
+
+	ret = nilfs_palloc_get_entry_block(dat, req->pr_entry_nr,
+					   create, &req->pr_entry_bh);
+	if (unlikely(ret == -ENOENT)) {
+		nilfs_err(dat->i_sb,
+			  "DAT doesn't have a block to manage vblocknr = %llu",
+			  (unsigned long long)req->pr_entry_nr);
+		/*
+		 * Return internal code -EINVAL to notify bmap layer of
+		 * metadata corruption.
+		 */
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 static void nilfs_dat_commit_entry(struct inode *dat,
@@ -123,11 +136,7 @@ static void nilfs_dat_commit_free(struct inode *dat,
 
 int nilfs_dat_prepare_start(struct inode *dat, struct nilfs_palloc_req *req)
 {
-	int ret;
-
-	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	WARN_ON(ret == -ENOENT);
-	return ret;
+	return nilfs_dat_prepare_entry(dat, req, 0);
 }
 
 void nilfs_dat_commit_start(struct inode *dat, struct nilfs_palloc_req *req,
@@ -154,10 +163,8 @@ int nilfs_dat_prepare_end(struct inode *dat, struct nilfs_palloc_req *req)
 	int ret;
 
 	ret = nilfs_dat_prepare_entry(dat, req, 0);
-	if (ret < 0) {
-		WARN_ON(ret == -ENOENT);
+	if (ret < 0)
 		return ret;
-	}
 
 	kaddr = kmap_atomic(req->pr_entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, req->pr_entry_nr,
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index e1bd592ce700..5611a35344a7 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -105,7 +105,13 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	wait_for_stable_page(page);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	wait_on_page_writeback(page);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return block_page_mkwrite_return(ret);
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 2217f904a7cf..188b8cc52e2b 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -472,9 +472,10 @@ static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
 
 static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 				     struct nilfs_recovery_block *rb,
-				     struct page *page)
+				     loff_t pos, struct page *page)
 {
 	struct buffer_head *bh_org;
+	size_t from = pos & ~PAGE_MASK;
 	void *kaddr;
 
 	bh_org = __bread(nilfs->ns_bdev, rb->blocknr, nilfs->ns_blocksize);
@@ -482,7 +483,7 @@ static int nilfs_recovery_copy_block(struct the_nilfs *nilfs,
 		return -EIO;
 
 	kaddr = kmap_atomic(page);
-	memcpy(kaddr + bh_offset(bh_org), bh_org->b_data, bh_org->b_size);
+	memcpy(kaddr + from, bh_org->b_data, bh_org->b_size);
 	kunmap_atomic(kaddr);
 	brelse(bh_org);
 	return 0;
@@ -521,7 +522,7 @@ static int nilfs_recover_dsync_blocks(struct the_nilfs *nilfs,
 			goto failed_inode;
 		}
 
-		err = nilfs_recovery_copy_block(nilfs, rb, page);
+		err = nilfs_recovery_copy_block(nilfs, rb, pos, page);
 		if (unlikely(err))
 			goto failed_page;
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 418055ac910b..be0ca35b8aa4 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1707,7 +1707,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
@@ -1718,6 +1717,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_begin_page_io(fs_page);
 				fs_page = bh->b_page;
@@ -1803,7 +1803,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
@@ -1812,6 +1811,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, err);
 				fs_page = bh->b_page;
@@ -1899,8 +1899,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
@@ -1908,6 +1909,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, 0);
 				fs_page = bh->b_page;
diff --git a/fs/pipe.c b/fs/pipe.c
index dbb090e1b026..588fe37d8d95 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -435,12 +435,10 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue) {
+	if (pipe_has_watch_queue(pipe)) {
 		ret = -EXDEV;
 		goto out;
 	}
-#endif
 
 	/*
 	 * If it wasn't empty we try to merge new data into
@@ -1302,6 +1300,11 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
+	if (!pipe_has_watch_queue(pipe)) {
+		pipe->max_usage = nr_slots;
+		pipe->nr_accounted = nr_slots;
+	}
+
 	spin_unlock_irq(&pipe->rd_wait.lock);
 
 	/* This might have made more room for writers */
@@ -1319,10 +1322,8 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	unsigned int nr_slots, size;
 	long ret = 0;
 
-#ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe_has_watch_queue(pipe))
 		return -EBUSY;
-#endif
 
 	size = round_pipe_size(arg);
 	nr_slots = size >> PAGE_SHIFT;
@@ -1355,8 +1356,6 @@ static long pipe_set_size(struct pipe_inode_info *pipe, unsigned long arg)
 	if (ret < 0)
 		goto out_revert_acct;
 
-	pipe->max_usage = nr_slots;
-	pipe->nr_accounted = nr_slots;
 	return pipe->max_usage * PAGE_SIZE;
 
 out_revert_acct:
@@ -1375,10 +1374,8 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice)
 
 	if (file->f_op != &pipefifo_fops || !pipe)
 		return NULL;
-#ifdef CONFIG_WATCH_QUEUE
-	if (for_splice && pipe->watch_queue)
+	if (for_splice && pipe_has_watch_queue(pipe))
 		return NULL;
-#endif
 	return pipe;
 }
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 98e579ce0d63..44fc3b396288 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -519,6 +519,7 @@ static int ramoops_init_przs(const char *name,
 	}
 
 	zone_sz = mem_sz / *cnt;
+	zone_sz = ALIGN_DOWN(zone_sz, 2);
 	if (!zone_sz) {
 		dev_err(dev, "%s zone size == 0\n", name);
 		goto fail;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index bc562b1072d3..11cd921df6da 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1198,6 +1198,8 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	dir_ui->ui_size = dir->i_size;
 	mutex_unlock(&dir_ui->ui_mutex);
 out_inode:
+	/* Free inode->i_link before inode is marked as bad. */
+	fscrypt_free_inode(inode);
 	make_bad_inode(inode);
 	iput(inode);
 out_fname:
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c..6b5eec10c3db 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -24,6 +24,7 @@
 #define __DRM_COLOR_MGMT_H__
 
 #include <linux/ctype.h>
+#include <linux/math64.h>
 #include <drm/drm_property.h>
 
 struct drm_crtc;
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 31ba85a4110a..3c0d1495c062 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -161,6 +161,7 @@ struct mipi_dsi_device_info {
  * struct mipi_dsi_device - DSI peripheral device
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
+ * @attached: the DSI device has been successfully attached
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -176,6 +177,7 @@ struct mipi_dsi_device_info {
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
+	bool attached;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;
diff --git a/include/linux/async.h b/include/linux/async.h
index 0a17cd27f348..d5496a520a38 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -90,6 +90,8 @@ async_schedule_dev(async_func_t func, struct device *dev)
 	return async_schedule_node(func, dev, dev_to_node(dev));
 }
 
+bool async_schedule_dev_nocall(async_func_t func, struct device *dev);
+
 /**
  * async_schedule_dev_domain - A device specific version of async_schedule_domain
  * @func: function to execute asynchronously
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f4379e93ad4..bfdf40be5360 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -82,7 +82,11 @@ struct bpf_map_ops {
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
 				int fd);
-	void (*map_fd_put_ptr)(void *ptr);
+	/* If need_defer is true, the implementation should guarantee that
+	 * the to-be-put element is still alive before the bpf program, which
+	 * may manipulate it, exists.
+	 */
+	void (*map_fd_put_ptr)(struct bpf_map *map, void *ptr, bool need_defer);
 	int (*map_gen_lookup)(struct bpf_map *map, struct bpf_insn *insn_buf);
 	u32 (*map_fd_sys_lookup_elem)(void *ptr);
 	void (*map_seq_show_elem)(struct bpf_map *map, void *key,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index dd357a747780..4e4cce0ad4d7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -949,7 +949,8 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
-	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
+	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM) ||
+	       (direction == DMA_DEV_TO_DEV);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index a88be8bd4e1d..54a3ad7bff58 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -197,6 +197,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -219,7 +220,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 693ed9c614b6..92a76ce0c382 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -158,6 +158,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
+	 unsigned long arg)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b2e4599b8883..ffae2b330818 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1188,6 +1188,7 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+	struct rcu_head rcu;
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
 #endif
@@ -1353,7 +1354,7 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
 
-	return test_bit(idx, ms->usage->subsection_map);
+	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
@@ -1366,17 +1367,24 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
 	struct mem_section *ms;
+	int ret;
 
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	ms = __nr_to_section(pfn_to_section_nr(pfn));
-	if (!valid_section(ms))
+	ms = __pfn_to_section(pfn);
+	rcu_read_lock();
+	if (!valid_section(ms)) {
+		rcu_read_unlock();
 		return 0;
+	}
 	/*
 	 * Traditionally early sections always returned pfn_valid() for
 	 * the entire section-sized span.
 	 */
-	return early_section(ms) || pfn_section_valid(ms, pfn);
+	ret = early_section(ms) || pfn_section_valid(ms, pfn);
+	rcu_read_unlock();
+
+	return ret;
 }
 #endif
 
@@ -1384,7 +1392,7 @@ static inline int pfn_in_present_section(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
+	return present_section(__pfn_to_section(pfn));
 }
 
 static inline unsigned long next_present_section_nr(unsigned long section_nr)
diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
index 62f7e7e257c1..f27894e50ef1 100644
--- a/include/linux/netfilter/ipset/ip_set.h
+++ b/include/linux/netfilter/ipset/ip_set.h
@@ -188,6 +188,8 @@ struct ip_set_type_variant {
 	/* Return true if "b" set is the same as "a"
 	 * according to the create set parameters */
 	bool (*same_set)(const struct ip_set *a, const struct ip_set *b);
+	/* Cancel ongoing garbage collectors before destroying the set*/
+	void (*cancel_gc)(struct ip_set *set);
 	/* Region-locking is used */
 	bool region_lock;
 };
@@ -239,6 +241,8 @@ extern void ip_set_type_unregister(struct ip_set_type *set_type);
 
 /* A generic IP set */
 struct ip_set {
+	/* For call_cru in destroy */
+	struct rcu_head rcu;
 	/* The name of the set */
 	char name[IPSET_MAXNAMELEN];
 	/* Lock protecting the set data */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1a41147b22e8..80744a7b5e33 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3020,6 +3020,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
+#define PCI_DEVICE_ID_INTEL_HDA_ARL	0x7728
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_E6XX_CU	0x8183
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index ef236dbaa294..7b72d93c2653 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -124,6 +124,22 @@ struct pipe_buf_operations {
 	bool (*get)(struct pipe_inode_info *, struct pipe_buffer *);
 };
 
+/**
+ * pipe_has_watch_queue - Check whether the pipe is a watch_queue,
+ * i.e. it was created with O_NOTIFICATION_PIPE
+ * @pipe: The pipe to check
+ *
+ * Return: true if pipe is a watch queue, false otherwise.
+ */
+static inline bool pipe_has_watch_queue(const struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_WATCH_QUEUE
+	return pipe->watch_queue != NULL;
+#else
+	return false;
+#endif
+}
+
 /**
  * pipe_empty - Return true if the pipe is empty
  * @head: The pipe ring head pointer
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 718600e83020..ca856e582914 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -60,6 +60,8 @@ extern void pm_runtime_new_link(struct device *dev);
 extern void pm_runtime_drop_link(struct device_link *link);
 extern void pm_runtime_release_supplier(struct device_link *link);
 
+extern int devm_pm_runtime_enable(struct device *dev);
+
 /**
  * pm_runtime_get_if_in_use - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
@@ -254,6 +256,8 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline int devm_pm_runtime_enable(struct device *dev) { return 0; }
+
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
@@ -535,6 +539,10 @@ static inline void pm_runtime_disable(struct device *dev)
  * Allow the runtime PM autosuspend mechanism to be used for @dev whenever
  * requested (or "autosuspend" will be handled as direct runtime-suspend for
  * it).
+ *
+ * NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
+ * at driver exit time unless your driver initially enabled pm_runtime
+ * with devm_pm_runtime_enable() (which handles it for you).
  */
 static inline void pm_runtime_use_autosuspend(struct device *dev)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index e9b4b5410614..e388b1666bcf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -368,6 +368,8 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -925,6 +927,13 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_file_ioctl_compat(struct file *file,
+					     unsigned int cmd,
+					     unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6df4c3356ae6..46a21984c0b2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -254,6 +254,7 @@ struct uart_port {
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
+	const struct serial_rs485	*rs485_supported;	/* Supported mask for serial_rs485 */
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e1d88630ff24..ab7747549d23 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -171,6 +171,7 @@ struct spi_device {
 #define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
+#define	SPI_MODE_X_MASK	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 938216f8ab7e..31fdbb784c24 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -84,4 +84,17 @@ enum {
 #define struct_group_tagged(TAG, NAME, MEMBERS...) \
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
+/**
+ * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define DECLARE_FLEX_ARRAY(TYPE, NAME) \
+	__DECLARE_FLEX_ARRAY(TYPE, NAME)
+
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a058c96cf213..17a24e1180da 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -119,6 +119,7 @@ struct open_how;
 #define __TYPE_IS_LL(t) (__TYPE_AS(t, 0LL) || __TYPE_AS(t, 0ULL))
 #define __SC_LONG(t, a) __typeof(__builtin_choose_expr(__TYPE_IS_LL(t), 0LL, 0L)) a
 #define __SC_CAST(t, a)	(__force t) a
+#define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
 
diff --git a/include/linux/units.h b/include/linux/units.h
index 3457179f7116..b61e3f6d5099 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -20,9 +20,13 @@
 #define PICO	1000000000000ULL
 #define FEMTO	1000000000000000ULL
 
-#define MILLIWATT_PER_WATT	1000L
-#define MICROWATT_PER_MILLIWATT	1000L
-#define MICROWATT_PER_WATT	1000000L
+#define HZ_PER_KHZ		1000UL
+#define KHZ_PER_MHZ		1000UL
+#define HZ_PER_MHZ		1000000UL
+
+#define MILLIWATT_PER_WATT	1000UL
+#define MICROWATT_PER_MILLIWATT	1000UL
+#define MICROWATT_PER_WATT	1000000UL
 
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 76dad53a410a..0fd47f2f39eb 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -112,6 +112,11 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller);
 
+extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags);
+extern void *vmalloc_array(size_t n, size_t size);
+extern void *__vcalloc(size_t n, size_t size, gfp_t flags);
+extern void *vcalloc(size_t n, size_t size);
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index f42fdddecd41..a6b6ce8b918b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -47,12 +47,6 @@ struct scm_stat {
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-#define unix_state_lock_nested(s) \
-				spin_lock_nested(&unix_sk(s)->lock, \
-				SINGLE_DEPTH_NESTING)
-
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -77,6 +71,20 @@ static inline struct unix_sock *unix_sk(const struct sock *sk)
 	return (struct unix_sock *)sk;
 }
 
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+enum unix_socket_lock_class {
+	U_LOCK_NORMAL,
+	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
+	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+};
+
+static inline void unix_state_lock_nested(struct sock *sk,
+				   enum unix_socket_lock_class subclass)
+{
+	spin_lock_nested(&unix_sk(sk)->lock, subclass);
+}
+
 #define peer_wait peer_wq.wait
 
 long unix_inq_len(struct sock *sk);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ff901aade442..568121fa0965 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -339,4 +339,12 @@ static inline bool inet_csk_has_ulp(struct sock *sk)
 	return inet_sk(sk)->is_icsk && !!inet_csk(sk)->icsk_ulp_ops;
 }
 
+static inline void inet_init_csk_locks(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
+	spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
+}
+
 #endif /* _INET_CONNECTION_SOCK_H */
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 49aa79c7b278..581cd37aa98b 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,8 +262,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
+	memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
 /**
@@ -275,8 +274,7 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
-		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
+	memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
 /**
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2237657514e1..2da11d8c0f45 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -142,9 +142,9 @@ static inline u16 nft_reg_load16(const u32 *sreg)
 	return *(u16 *)sreg;
 }
 
-static inline void nft_reg_store64(u32 *dreg, u64 val)
+static inline void nft_reg_store64(u64 *dreg, u64 val)
 {
-	put_unaligned(val, (u64 *)dreg);
+	put_unaligned(val, dreg);
 }
 
 static inline u64 nft_reg_load64(const u32 *sreg)
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 5339baadc082..39c7a36cd6ce 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -178,16 +178,17 @@ static inline int scsi_is_wlun(u64 lun)
 /*
  * Internal return values.
  */
-
-#define NEEDS_RETRY     0x2001
-#define SUCCESS         0x2002
-#define FAILED          0x2003
-#define QUEUED          0x2004
-#define SOFT_ERROR      0x2005
-#define ADD_TO_MLQUEUE  0x2006
-#define TIMEOUT_ERROR   0x2007
-#define SCSI_RETURN_NOT_HANDLED   0x2008
-#define FAST_IO_FAIL	0x2009
+enum scsi_disposition {
+	NEEDS_RETRY		= 0x2001,
+	SUCCESS			= 0x2002,
+	FAILED			= 0x2003,
+	QUEUED			= 0x2004,
+	SOFT_ERROR		= 0x2005,
+	ADD_TO_MLQUEUE		= 0x2006,
+	TIMEOUT_ERROR		= 0x2007,
+	SCSI_RETURN_NOT_HANDLED	= 0x2008,
+	FAST_IO_FAIL		= 0x2009,
+};
 
 /*
  * Midlevel queue return values.
diff --git a/include/scsi/scsi_dh.h b/include/scsi/scsi_dh.h
index 2852e470a8ed..47ccf2f11d89 100644
--- a/include/scsi/scsi_dh.h
+++ b/include/scsi/scsi_dh.h
@@ -52,7 +52,8 @@ struct scsi_device_handler {
 	/* Filled by the hardware handler */
 	struct module *module;
 	const char *name;
-	int (*check_sense)(struct scsi_device *, struct scsi_sense_hdr *);
+	enum scsi_disposition (*check_sense)(struct scsi_device *,
+					     struct scsi_sense_hdr *);
 	int (*attach)(struct scsi_device *);
 	void (*detach)(struct scsi_device *);
 	int (*activate)(struct scsi_device *, activate_complete, void *);
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 6bd5ed695a5e..468094254b3c 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -17,7 +17,7 @@ extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
 extern int scsi_block_when_processing_errors(struct scsi_device *);
 extern bool scsi_command_normalize_sense(const struct scsi_cmnd *cmd,
 					 struct scsi_sense_hdr *sshdr);
-extern int scsi_check_sense(struct scsi_cmnd *);
+extern enum scsi_disposition scsi_check_sense(struct scsi_cmnd *);
 
 static inline bool scsi_sense_is_deferred(const struct scsi_sense_hdr *sshdr)
 {
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e65300d63d7c..cf4431b748c2 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -576,6 +576,9 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_START_IO)
+
 struct btrfs_ioctl_defrag_range_args {
 	/* start of the defrag operation */
 	__u64 start;
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 163b7ec577e7..f93ffb1b6739 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -262,9 +262,11 @@ enum nft_rule_attributes {
 /**
  * enum nft_rule_compat_flags - nf_tables rule compat flags
  *
+ * @NFT_RULE_COMPAT_F_UNUSED: unused
  * @NFT_RULE_COMPAT_F_INV: invert the check result
  */
 enum nft_rule_compat_flags {
+	NFT_RULE_COMPAT_F_UNUSED = (1 << 0),
 	NFT_RULE_COMPAT_F_INV	= (1 << 1),
 	NFT_RULE_COMPAT_F_MASK	= NFT_RULE_COMPAT_F_INV,
 };
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index c3725b492263..46c7bab501cb 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -28,4 +28,27 @@
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
 	}
+
+#ifdef __cplusplus
+/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
+#define __DECLARE_FLEX_ARRAY(T, member)	\
+	T member[0]
+#else
+/**
+ * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
+ *
+ * @TYPE: The type of each flexible array element
+ * @NAME: The name of the flexible array member
+ *
+ * In order to have a flexible array member in a union or alone in a
+ * struct, it needs to be wrapped in an anonymous struct with at least 1
+ * named member, but that member can be empty.
+ */
+#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
+	struct { \
+		struct { } __empty_ ## NAME; \
+		TYPE NAME[]; \
+	}
+#endif
+
 #endif
diff --git a/kernel/async.c b/kernel/async.c
index 1746cd65e271..5dba7461fc75 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -145,6 +145,39 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
+static async_cookie_t __async_schedule_node_domain(async_func_t func,
+						   void *data, int node,
+						   struct async_domain *domain,
+						   struct async_entry *entry)
+{
+	async_cookie_t newcookie;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&entry->domain_list);
+	INIT_LIST_HEAD(&entry->global_list);
+	INIT_WORK(&entry->work, async_run_entry_fn);
+	entry->func = func;
+	entry->data = data;
+	entry->domain = domain;
+
+	spin_lock_irqsave(&async_lock, flags);
+
+	/* allocate cookie and queue */
+	newcookie = entry->cookie = next_cookie++;
+
+	list_add_tail(&entry->domain_list, &domain->pending);
+	if (domain->registered)
+		list_add_tail(&entry->global_list, &async_global_pending);
+
+	atomic_inc(&entry_count);
+	spin_unlock_irqrestore(&async_lock, flags);
+
+	/* schedule for execution */
+	queue_work_node(node, system_unbound_wq, &entry->work);
+
+	return newcookie;
+}
+
 /**
  * async_schedule_node_domain - NUMA specific version of async_schedule_domain
  * @func: function to execute asynchronously
@@ -186,29 +219,8 @@ async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
 		func(data, newcookie);
 		return newcookie;
 	}
-	INIT_LIST_HEAD(&entry->domain_list);
-	INIT_LIST_HEAD(&entry->global_list);
-	INIT_WORK(&entry->work, async_run_entry_fn);
-	entry->func = func;
-	entry->data = data;
-	entry->domain = domain;
-
-	spin_lock_irqsave(&async_lock, flags);
-
-	/* allocate cookie and queue */
-	newcookie = entry->cookie = next_cookie++;
-
-	list_add_tail(&entry->domain_list, &domain->pending);
-	if (domain->registered)
-		list_add_tail(&entry->global_list, &async_global_pending);
-
-	atomic_inc(&entry_count);
-	spin_unlock_irqrestore(&async_lock, flags);
-
-	/* schedule for execution */
-	queue_work_node(node, system_unbound_wq, &entry->work);
 
-	return newcookie;
+	return __async_schedule_node_domain(func, data, node, domain, entry);
 }
 EXPORT_SYMBOL_GPL(async_schedule_node_domain);
 
@@ -231,6 +243,35 @@ async_cookie_t async_schedule_node(async_func_t func, void *data, int node)
 }
 EXPORT_SYMBOL_GPL(async_schedule_node);
 
+/**
+ * async_schedule_dev_nocall - A simplified variant of async_schedule_dev()
+ * @func: function to execute asynchronously
+ * @dev: device argument to be passed to function
+ *
+ * @dev is used as both the argument for the function and to provide NUMA
+ * context for where to run the function.
+ *
+ * If the asynchronous execution of @func is scheduled successfully, return
+ * true. Otherwise, do nothing and return false, unlike async_schedule_dev()
+ * that will run the function synchronously then.
+ */
+bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
+{
+	struct async_entry *entry;
+
+	entry = kzalloc(sizeof(struct async_entry), GFP_KERNEL);
+
+	/* Give up if there is no memory or too much work. */
+	if (!entry || atomic_read(&entry_count) > MAX_WORK) {
+		kfree(entry);
+		return false;
+	}
+
+	__async_schedule_node_domain(func, dev, dev_to_node(dev),
+				     &async_dfl_domain, entry);
+	return true;
+}
+
 /**
  * async_synchronize_full - synchronize all asynchronous function calls
  *
diff --git a/kernel/audit.c b/kernel/audit.c
index aeec86ed4708..2ab04e0a7441 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -490,15 +490,19 @@ static void auditd_conn_free(struct rcu_head *rcu)
  * @pid: auditd PID
  * @portid: auditd netlink portid
  * @net: auditd network namespace pointer
+ * @skb: the netlink command from the audit daemon
+ * @ack: netlink ack flag, cleared if ack'd here
  *
  * Description:
  * This function will obtain and drop network namespace references as
  * necessary.  Returns zero on success, negative values on failure.
  */
-static int auditd_set(struct pid *pid, u32 portid, struct net *net)
+static int auditd_set(struct pid *pid, u32 portid, struct net *net,
+		      struct sk_buff *skb, bool *ack)
 {
 	unsigned long flags;
 	struct auditd_connection *ac_old, *ac_new;
+	struct nlmsghdr *nlh;
 
 	if (!pid || !net)
 		return -EINVAL;
@@ -510,6 +514,13 @@ static int auditd_set(struct pid *pid, u32 portid, struct net *net)
 	ac_new->portid = portid;
 	ac_new->net = get_net(net);
 
+	/* send the ack now to avoid a race with the queue backlog */
+	if (*ack) {
+		nlh = nlmsg_hdr(skb);
+		netlink_ack(skb, nlh, 0, NULL);
+		*ack = false;
+	}
+
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
@@ -1203,7 +1214,8 @@ static int audit_replace(struct pid *pid)
 	return auditd_send_unicast_skb(skb);
 }
 
-static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
+			     bool *ack)
 {
 	u32			seq;
 	void			*data;
@@ -1296,7 +1308,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 				/* register a new auditd connection */
 				err = auditd_set(req_pid,
 						 NETLINK_CB(skb).portid,
-						 sock_net(NETLINK_CB(skb).sk));
+						 sock_net(NETLINK_CB(skb).sk),
+						 skb, ack);
 				if (audit_enabled != AUDIT_OFF)
 					audit_log_config_change("audit_pid",
 								new_pid,
@@ -1541,9 +1554,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
 {
 	struct nlmsghdr *nlh;
+	bool ack;
 	/*
 	 * len MUST be signed for nlmsg_next to be able to dec it below 0
 	 * if the nlmsg_len was not aligned
@@ -1556,9 +1570,12 @@ static void audit_receive(struct sk_buff  *skb)
 
 	audit_ctl_lock();
 	while (nlmsg_ok(nlh, len)) {
-		err = audit_receive_msg(skb, nlh);
-		/* if err or if this message says it wants a response */
-		if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+		ack = nlh->nlmsg_flags & NLM_F_ACK;
+		err = audit_receive_msg(skb, nlh, &ack);
+
+		/* send an ack if the user asked for one and audit_receive_msg
+		 * didn't already do it, or if there was an error. */
+		if (ack || err)
 			netlink_ack(skb, nlh, err, NULL);
 
 		nlh = nlmsg_next(nlh, &len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index f241bda2679d..5102338129d5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -764,7 +764,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	}
 
 	if (old_ptr)
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 	return 0;
 }
 
@@ -787,7 +787,7 @@ static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
 	}
 
 	if (old_ptr) {
-		map->ops->map_fd_put_ptr(old_ptr);
+		map->ops->map_fd_put_ptr(map, old_ptr, true);
 		return 0;
 	} else {
 		return -ENOENT;
@@ -811,8 +811,9 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	return prog;
 }
 
-static void prog_fd_array_put_ptr(void *ptr)
+static void prog_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_prog is freed after one RCU or tasks trace grace period */
 	bpf_prog_put(ptr);
 }
 
@@ -1139,8 +1140,9 @@ static void *perf_event_fd_array_get_ptr(struct bpf_map *map,
 	return ee;
 }
 
-static void perf_event_fd_array_put_ptr(void *ptr)
+static void perf_event_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
+	/* bpf_perf_event is freed after one RCU grace period */
 	bpf_event_entry_free_rcu(ptr);
 }
 
@@ -1195,7 +1197,7 @@ static void *cgroup_fd_array_get_ptr(struct bpf_map *map,
 	return cgroup_get_from_fd(fd);
 }
 
-static void cgroup_fd_array_put_ptr(void *ptr)
+static void cgroup_fd_array_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* cgroup_put free cgrp after a rcu grace period */
 	cgroup_put(ptr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0ce445aadfdf..ec8497314272 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -786,7 +786,7 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 
 	if (map->ops->map_fd_put_ptr) {
 		ptr = fd_htab_map_get_ptr(map, l);
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, true);
 	}
 }
 
@@ -2023,7 +2023,7 @@ static void fd_htab_map_free(struct bpf_map *map)
 		hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 			void *ptr = fd_htab_map_get_ptr(map, l);
 
-			map->ops->map_fd_put_ptr(ptr);
+			map->ops->map_fd_put_ptr(map, ptr, false);
 		}
 	}
 
@@ -2064,7 +2064,7 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 
 	ret = htab_map_update_elem(map, key, &ptr, map_flags);
 	if (ret)
-		map->ops->map_fd_put_ptr(ptr);
+		map->ops->map_fd_put_ptr(map, ptr, false);
 
 	return ret;
 }
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 39ab0b68cade..0cf4cb685810 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -100,7 +100,7 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	return inner_map;
 }
 
-void bpf_map_fd_put_ptr(void *ptr)
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer)
 {
 	/* ptr->ops->map_free() has to go through one
 	 * rcu grace period by itself.
diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
index bcb7534afb3c..7d61602354de 100644
--- a/kernel/bpf/map_in_map.h
+++ b/kernel/bpf/map_in_map.h
@@ -13,7 +13,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd);
 void bpf_map_meta_free(struct bpf_map *map_meta);
 void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
 			 int ufd);
-void bpf_map_fd_put_ptr(void *ptr);
+void bpf_map_fd_put_ptr(struct bpf_map *map, void *ptr, bool need_defer);
 u32 bpf_map_fd_sys_lookup_elem(void *ptr);
 
 #endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aaad2dce2be6..16affa09db5c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1285,6 +1285,9 @@ int generic_map_delete_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
@@ -1343,6 +1346,9 @@ int generic_map_update_batch(struct bpf_map *map,
 	if (!max_count)
 		return 0;
 
+	if (put_user(0, &uattr->batch.count))
+		return -EFAULT;
+
 	key = kmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
 	if (!key)
 		return -ENOMEM;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index afedd008e0af..bd569cf23569 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10855,9 +10855,30 @@ static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_nr_addr_filters.attr,
+	NULL,
+};
+
+static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (n == 2 && !pmu->nr_addr_filters)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group pmu_dev_attr_group = {
+	.is_visible = pmu_dev_is_visible,
+	.attrs = pmu_dev_attrs,
+};
+
+static const struct attribute_group *pmu_dev_groups[] = {
+	&pmu_dev_attr_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmu_dev);
 
 static int pmu_bus_running;
 static struct bus_type pmu_bus = {
@@ -10893,18 +10914,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
-	/* For PMUs with address filters, throw in an extra attribute: */
-	if (pmu->nr_addr_filters)
-		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
-
-	if (ret)
-		goto del_dev;
-
-	if (pmu->attr_update)
+	if (pmu->attr_update) {
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
-
-	if (ret)
-		goto del_dev;
+		if (ret)
+			goto del_dev;
+	}
 
 out:
 	return ret;
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 25e7cb96bb88..b288aba8040c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -603,11 +603,11 @@ static int crc32_threadfn(void *data)
 	unsigned i;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -616,7 +616,7 @@ static int crc32_threadfn(void *data)
 		for (i = 0; i < d->run_threads; i++)
 			*d->crc32 = crc32_le(*d->crc32,
 			                     d->unc[i], *d->unc_len[i]);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -646,12 +646,12 @@ static int lzo_compress_threadfn(void *data)
 	struct cmp_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -660,7 +660,7 @@ static int lzo_compress_threadfn(void *data)
 		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
 		                          d->cmp + LZO_HEADER, &d->cmp_len,
 		                          d->wrk);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -798,7 +798,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 			data[thr].unc_len = off;
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -806,12 +806,12 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			break;
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -850,7 +850,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			}
 		}
 
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 
@@ -1132,12 +1132,12 @@ static int lzo_decompress_threadfn(void *data)
 	struct dec_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -1150,7 +1150,7 @@ static int lzo_decompress_threadfn(void *data)
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
 
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -1338,7 +1338,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read(&crc->stop));
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));
 			atomic_set(&crc->stop, 0);
 			crc->run_threads = 0;
 		}
@@ -1374,7 +1374,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 					pg = 0;
 			}
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -1393,7 +1393,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -1424,7 +1424,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				ret = snapshot_write_next(snapshot);
 				if (ret <= 0) {
 					crc->run_threads = thr + 1;
-					atomic_set(&crc->ready, 1);
+					atomic_set_release(&crc->ready, 1);
 					wake_up(&crc->go);
 					goto out_finish;
 				}
@@ -1432,13 +1432,13 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 	}
 
 out_finish:
 	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index cc7cd512e4e3..1b7c3bdba8f7 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -34,6 +34,8 @@
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK		\
 	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
 
+static DEFINE_MUTEX(membarrier_ipi_mutex);
+
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
@@ -119,6 +121,7 @@ static int membarrier_global_expedited(void)
 	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -165,6 +168,8 @@ static int membarrier_global_expedited(void)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
+
 	return 0;
 }
 
@@ -208,6 +213,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 
 	if (cpu_id >= 0) {
@@ -280,6 +286,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }
@@ -321,6 +328,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
 	 */
+	mutex_lock(&membarrier_ipi_mutex);
 	cpus_read_lock();
 	rcu_read_lock();
 	for_each_online_cpu(cpu) {
@@ -337,6 +345,7 @@ static int sync_runqueues_membarrier_state(struct mm_struct *mm)
 
 	free_cpumask_var(tmpmask);
 	cpus_read_unlock();
+	mutex_unlock(&membarrier_ipi_mutex);
 
 	return 0;
 }
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 86e0fbe583f2..754e93edb2f7 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -118,6 +118,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -136,6 +137,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -324,8 +326,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -395,6 +397,27 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_interval) {
+				watchdog_max_interval = interval;
+				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
+					cs_nsec, wd_nsec);
+			}
+			watchdog_timer.expires = jiffies;
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ede09dda36e9..2b2a6e29219d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -980,6 +980,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2078,6 +2079,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2145,6 +2147,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
@@ -2161,7 +2164,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2188,6 +2191,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2207,7 +2217,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2215,7 +2225,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index bc00ab0118e6..d1693c26958f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1440,6 +1440,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1448,9 +1449,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 041b91c2ba10..4a43b8846b49 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1008,7 +1008,7 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		full = 0;
 	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -EINVAL;
+			return EPOLLERR;
 
 		cpu_buffer = buffer->buffers[cpu];
 		work = &cpu_buffer->irq_work;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 548f694fc857..22e1e5711869 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/kmemleak.h>
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
@@ -2239,7 +2240,7 @@ struct saved_cmdlines_buffer {
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	char *saved_cmdlines;
+	char saved_cmdlines[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
@@ -2253,47 +2254,60 @@ static inline void set_cmdline(int idx, const char *cmdline)
 	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
-static int allocate_cmdlines_buffer(unsigned int val,
-				    struct saved_cmdlines_buffer *s)
+static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 {
+	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+
+	kfree(s->map_cmdline_to_pid);
+	kmemleak_free(s);
+	free_pages((unsigned long)s, order);
+}
+
+static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
+{
+	struct saved_cmdlines_buffer *s;
+	struct page *page;
+	int orig_size, size;
+	int order;
+
+	/* Figure out how much is needed to hold the given number of cmdlines */
+	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	order = get_order(orig_size);
+	size = 1 << (order + PAGE_SHIFT);
+	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return NULL;
+
+	s = page_address(page);
+	kmemleak_alloc(s, size, 1, GFP_KERNEL);
+	memset(s, 0, sizeof(*s));
+
+	/* Round up to actual allocation */
+	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	s->cmdline_num = val;
+
 	s->map_cmdline_to_pid = kmalloc_array(val,
 					      sizeof(*s->map_cmdline_to_pid),
 					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid)
-		return -ENOMEM;
-
-	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
-	if (!s->saved_cmdlines) {
-		kfree(s->map_cmdline_to_pid);
-		return -ENOMEM;
+	if (!s->map_cmdline_to_pid) {
+		free_saved_cmdlines_buffer(s);
+		return NULL;
 	}
 
 	s->cmdline_idx = 0;
-	s->cmdline_num = val;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
 	       val * sizeof(*s->map_cmdline_to_pid));
 
-	return 0;
+	return s;
 }
 
 static int trace_create_savedcmd(void)
 {
-	int ret;
-
-	savedcmd = kmalloc(sizeof(*savedcmd), GFP_KERNEL);
-	if (!savedcmd)
-		return -ENOMEM;
+	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
 
-	ret = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT, savedcmd);
-	if (ret < 0) {
-		kfree(savedcmd);
-		savedcmd = NULL;
-		return -ENOMEM;
-	}
-
-	return 0;
+	return savedcmd ? 0 : -ENOMEM;
 }
 
 int is_tracing_stopped(void)
@@ -5603,26 +5617,14 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-{
-	kfree(s->saved_cmdlines);
-	kfree(s->map_cmdline_to_pid);
-	kfree(s);
-}
-
 static int tracing_resize_saved_cmdlines(unsigned int val)
 {
 	struct saved_cmdlines_buffer *s, *savedcmd_temp;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = allocate_cmdlines_buffer(val);
 	if (!s)
 		return -ENOMEM;
 
-	if (allocate_cmdlines_buffer(val, s) < 0) {
-		kfree(s);
-		return -ENOMEM;
-	}
-
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4bc90965abb2..e4340958da2d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1140,8 +1140,10 @@ register_snapshot_trigger(char *glob, struct event_trigger_ops *ops,
 			  struct event_trigger_data *data,
 			  struct trace_event_file *file)
 {
-	if (tracing_alloc_snapshot_instance(file->tr) != 0)
-		return 0;
+	int ret = tracing_alloc_snapshot_instance(file->tr);
+
+	if (ret < 0)
+		return ret;
 
 	return register_trigger(glob, ops, data, file);
 }
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 51a9d1185033..d47641f9740b 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -574,7 +574,12 @@ __tracing_map_insert(struct tracing_map *map, void *key, bool lookup_only)
 				}
 
 				memcpy(elt->key, key, map->key_size);
-				entry->val = elt;
+				/*
+				 * Ensure the initialization is visible and
+				 * publish the elt.
+				 */
+				smp_wmb();
+				WRITE_ONCE(entry->val, elt);
 				atomic64_inc(&map->hits);
 
 				return entry->val;
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4dd9283f6fea..b055741a5a4d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -612,9 +612,8 @@ static void debug_objects_fill_pool(void)
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	debug_objects_fill_pool();
@@ -635,24 +634,18 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
-		break;
-
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
-		debug_object_fixup(descr->fixup_init, addr, state);
-		return;
-
-	case ODEBUG_STATE_DESTROYED:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "init");
 		return;
 	default:
 		break;
 	}
 
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "init");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_init, addr, o.state);
 }
 
 /**
@@ -693,11 +686,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
-	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	int ret;
 
 	if (!debug_objects_enabled)
 		return 0;
@@ -709,49 +700,38 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object_or_alloc(addr, db, descr, false, true);
-	if (likely(!IS_ERR_OR_NULL(obj))) {
-		bool print_object = false;
-
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return 0;
+	} else if (likely(!IS_ERR(obj))) {
 		switch (obj->state) {
-		case ODEBUG_STATE_INIT:
-		case ODEBUG_STATE_INACTIVE:
-			obj->state = ODEBUG_STATE_ACTIVE;
-			ret = 0;
-			break;
-
 		case ODEBUG_STATE_ACTIVE:
-			state = obj->state;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_print_object(obj, "activate");
-			ret = debug_object_fixup(descr->fixup_activate, addr, state);
-			return ret ? 0 : -EINVAL;
-
 		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			ret = -EINVAL;
+			o = *obj;
 			break;
+		case ODEBUG_STATE_INIT:
+		case ODEBUG_STATE_INACTIVE:
+			obj->state = ODEBUG_STATE_ACTIVE;
+			fallthrough;
 		default:
-			ret = 0;
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return 0;
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		if (print_object)
-			debug_print_object(obj, "activate");
-		return ret;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "activate");
 
-	/* If NULL the allocation has hit OOM */
-	if (!obj) {
-		debug_objects_oom();
-		return 0;
+	switch (o.state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_NOTAVAILABLE:
+		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
+			return 0;
+		fallthrough;
+	default:
+		return -EINVAL;
 	}
-
-	/* Object is neither static nor tracked. It's not initialized */
-	debug_print_object(&o, "activate");
-	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
-	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -762,10 +742,10 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  */
 void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -777,33 +757,24 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 	obj = lookup_object(addr, db);
 	if (obj) {
 		switch (obj->state) {
+		case ODEBUG_STATE_DESTROYED:
+			break;
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
-			if (!obj->astate)
-				obj->state = ODEBUG_STATE_INACTIVE;
-			else
-				print_object = true;
-			break;
-
-		case ODEBUG_STATE_DESTROYED:
-			print_object = true;
-			break;
+			if (obj->astate)
+				break;
+			obj->state = ODEBUG_STATE_INACTIVE;
+			fallthrough;
 		default:
-			break;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "deactivate");
-	} else if (print_object) {
-		debug_print_object(obj, "deactivate");
-	}
+	debug_print_object(&o, "deactivate");
 }
 EXPORT_SYMBOL_GPL(debug_object_deactivate);
 
@@ -814,11 +785,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  */
 void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -828,32 +797,31 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
+	case ODEBUG_STATE_ACTIVE:
+	case ODEBUG_STATE_DESTROYED:
+		break;
 	case ODEBUG_STATE_NONE:
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_DESTROYED;
-		break;
-	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
+		fallthrough;
+	default:
 		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "destroy");
-		debug_object_fixup(descr->fixup_destroy, addr, state);
 		return;
-
-	case ODEBUG_STATE_DESTROYED:
-		print_object = true;
-		break;
-	default:
-		break;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (print_object)
-		debug_print_object(obj, "destroy");
+	debug_print_object(&o, "destroy");
+
+	if (o.state == ODEBUG_STATE_ACTIVE)
+		debug_object_fixup(descr->fixup_destroy, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_destroy);
 
@@ -864,9 +832,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  */
 void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
-	enum debug_obj_state state;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
-	struct debug_obj *obj;
 	unsigned long flags;
 
 	if (!debug_objects_enabled)
@@ -877,24 +844,26 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 	raw_spin_lock_irqsave(&db->lock, flags);
 
 	obj = lookup_object(addr, db);
-	if (!obj)
-		goto out_unlock;
+	if (!obj) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		return;
+	}
 
 	switch (obj->state) {
 	case ODEBUG_STATE_ACTIVE:
-		state = obj->state;
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		debug_print_object(obj, "free");
-		debug_object_fixup(descr->fixup_free, addr, state);
-		return;
+		break;
 	default:
 		hlist_del(&obj->node);
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		free_object(obj);
 		return;
 	}
-out_unlock:
+
+	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+	debug_print_object(&o, "free");
+
+	debug_object_fixup(descr->fixup_free, addr, o.state);
 }
 EXPORT_SYMBOL_GPL(debug_object_free);
 
@@ -946,10 +915,10 @@ void
 debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
-	bool print_object = false;
 
 	if (!debug_objects_enabled)
 		return;
@@ -962,28 +931,19 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 	if (obj) {
 		switch (obj->state) {
 		case ODEBUG_STATE_ACTIVE:
-			if (obj->astate == expect)
-				obj->astate = next;
-			else
-				print_object = true;
-			break;
-
+			if (obj->astate != expect)
+				break;
+			obj->astate = next;
+			raw_spin_unlock_irqrestore(&db->lock, flags);
+			return;
 		default:
-			print_object = true;
 			break;
 		}
+		o = *obj;
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		debug_print_object(&o, "active_state");
-	} else if (print_object) {
-		debug_print_object(obj, "active_state");
-	}
+	debug_print_object(&o, "active_state");
 }
 EXPORT_SYMBOL_GPL(debug_object_active_state);
 
@@ -991,12 +951,10 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	const struct debug_obj_descr *descr;
-	enum debug_obj_state state;
+	int cnt, objs_checked = 0;
+	struct debug_obj *obj, o;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
-	struct debug_obj *obj;
-	int cnt, objs_checked = 0;
 
 	saddr = (unsigned long) address;
 	eaddr = saddr + size;
@@ -1018,12 +976,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
-				descr = obj->descr;
-				state = obj->state;
+				o = *obj;
 				raw_spin_unlock_irqrestore(&db->lock, flags);
-				debug_print_object(obj, "free");
-				debug_object_fixup(descr->fixup_free,
-						   (void *) oaddr, state);
+				debug_print_object(&o, "free");
+				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
 			default:
 				hlist_del(&obj->node);
diff --git a/lib/mpi/ec.c b/lib/mpi/ec.c
index c21470122dfc..941ba0b0067e 100644
--- a/lib/mpi/ec.c
+++ b/lib/mpi/ec.c
@@ -584,6 +584,9 @@ void mpi_ec_init(struct mpi_ec_ctx *ctx, enum gcry_mpi_ec_models model,
 	ctx->a = mpi_copy(a);
 	ctx->b = mpi_copy(b);
 
+	ctx->d = NULL;
+	ctx->t.two_inv_p = NULL;
+
 	ctx->t.p_barrett = use_barrett > 0 ? mpi_barrett_init(ctx->p, 0) : NULL;
 
 	mpi_ec_get_reset(ctx);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eb34d204d4ee..e8d7d3c2bfcb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1524,7 +1524,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
diff --git a/mm/sparse.c b/mm/sparse.c
index 33406ea2ecc4..db0a7c53775b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -809,6 +809,13 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
+		/*
+		 * Mark the section invalid so that valid_section()
+		 * return false. This prevents code from dereferencing
+		 * ms->usage array.
+		 */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
+
 		/*
 		 * When removing an early section, the usage map is kept (as the
 		 * usage maps of other sections fall into the same page). It
@@ -817,16 +824,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		 * was allocated during boot.
 		 */
 		if (!PageReserved(virt_to_page(ms->usage))) {
-			kfree(ms->usage);
-			ms->usage = NULL;
+			kfree_rcu(ms->usage, rcu);
+			WRITE_ONCE(ms->usage, NULL);
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-		/*
-		 * Mark the section invalid so that valid_section()
-		 * return false. This prevents code from dereferencing
-		 * ms->usage array.
-		 */
-		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
 	/*
diff --git a/mm/util.c b/mm/util.c
index 25bfda774f6f..7fd3c2bb3e4f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,6 +686,56 @@ static inline void *__page_rmapping(struct page *page)
 	return (void *)mapping;
 }
 
+/**
+ * __vmalloc_array - allocate memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate (see kmalloc).
+ */
+void *__vmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+	return __vmalloc(bytes, flags);
+}
+EXPORT_SYMBOL(__vmalloc_array);
+
+/**
+ * vmalloc_array - allocate memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ */
+void *vmalloc_array(size_t n, size_t size)
+{
+	return __vmalloc_array(n, size, GFP_KERNEL);
+}
+EXPORT_SYMBOL(vmalloc_array);
+
+/**
+ * __vcalloc - allocate and zero memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate (see kmalloc).
+ */
+void *__vcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return __vmalloc_array(n, size, flags | __GFP_ZERO);
+}
+EXPORT_SYMBOL(__vcalloc);
+
+/**
+ * vcalloc - allocate and zero memory for a virtually contiguous array.
+ * @n: number of elements.
+ * @size: element size.
+ */
+void *vcalloc(size_t n, size_t size)
+{
+	return __vmalloc_array(n, size, GFP_KERNEL | __GFP_ZERO);
+}
+EXPORT_SYMBOL(vcalloc);
+
 /* Neutral page->mapping pointer to address_space or anon_vma or other */
 void *page_rmapping(struct page *page)
 {
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 0db85aeb119b..99b277775257 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -118,12 +118,16 @@ static int vlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 	if (data[IFLA_VLAN_INGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_INGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			vlan_dev_set_ingress_priority(dev, m->to, m->from);
 		}
 	}
 	if (data[IFLA_VLAN_EGRESS_QOS]) {
 		nla_for_each_nested(attr, data[IFLA_VLAN_EGRESS_QOS], rem) {
+			if (nla_type(attr) != IFLA_VLAN_QOS_MAPPING)
+				continue;
 			m = nla_data(attr);
 			err = vlan_dev_set_egress_priority(dev, m->from, m->to);
 			if (err)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cf78a48085ed..a752032e12fc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6522,7 +6522,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
 			l2cap_sig_send_rej(conn, cmd->ident);
-			break;
+			skb_pull(skb, len > skb->len ? skb->len : len);
+			continue;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cea712fb2a9e..9ac2a10b1826 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -297,6 +297,7 @@ struct j1939_sock {
 
 	int ifindex;
 	struct j1939_addr addr;
+	spinlock_t filters_lock;
 	struct j1939_filter *filters;
 	int nfilters;
 	pgn_t pgn_rx_filter;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 906a08d38c1c..c216c60f572b 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -262,12 +262,17 @@ static bool j1939_sk_match_dst(struct j1939_sock *jsk,
 static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 				  const struct j1939_sk_buff_cb *skcb)
 {
-	const struct j1939_filter *f = jsk->filters;
-	int nfilter = jsk->nfilters;
+	const struct j1939_filter *f;
+	int nfilter;
+
+	spin_lock_bh(&jsk->filters_lock);
+
+	f = jsk->filters;
+	nfilter = jsk->nfilters;
 
 	if (!nfilter)
 		/* receive all when no filters are assigned */
-		return true;
+		goto filter_match_found;
 
 	for (; nfilter; ++f, --nfilter) {
 		if ((skcb->addr.pgn & f->pgn_mask) != f->pgn)
@@ -276,9 +281,15 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 			continue;
 		if ((skcb->addr.src_name & f->name_mask) != f->name)
 			continue;
-		return true;
+		goto filter_match_found;
 	}
+
+	spin_unlock_bh(&jsk->filters_lock);
 	return false;
+
+filter_match_found:
+	spin_unlock_bh(&jsk->filters_lock);
+	return true;
 }
 
 static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
@@ -401,6 +412,7 @@ static int j1939_sk_init(struct sock *sk)
 	atomic_set(&jsk->skb_pending, 0);
 	spin_lock_init(&jsk->sk_session_queue_lock);
 	INIT_LIST_HEAD(&jsk->sk_session_queue);
+	spin_lock_init(&jsk->filters_lock);
 
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -703,9 +715,11 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		lock_sock(&jsk->sk);
+		spin_lock_bh(&jsk->filters_lock);
 		ofilters = jsk->filters;
 		jsk->filters = filters;
 		jsk->nfilters = count;
+		spin_unlock_bh(&jsk->filters_lock);
 		release_sock(&jsk->sk);
 		kfree(ofilters);
 		return 0;
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index f35c2e998406..63de5c635842 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -33,9 +33,6 @@
 
 void reqsk_queue_alloc(struct request_sock_queue *queue)
 {
-	spin_lock_init(&queue->rskq_lock);
-
-	spin_lock_init(&queue->fastopenq.lock);
 	queue->fastopenq.rskq_rst_head = NULL;
 	queue->fastopenq.rskq_rst_tail = NULL;
 	queue->fastopenq.qlen = 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 196278a137c0..50261f3aec82 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3877,8 +3877,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
+		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = len / mss;
+		partial_segs = min(len, GSO_BY_FRAGS - 1U) / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 84e6ef4f3525..c5a4c5fb7293 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -291,7 +291,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "HSR: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
 		return;
 	}
 
@@ -338,7 +338,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "PRP: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
 	}
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index acb4887351da..5f1b334e64b3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -327,6 +327,9 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
 
@@ -1597,10 +1600,12 @@ EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 {
-	if (sk->sk_family == AF_INET)
+	unsigned int family = READ_ONCE(sk->sk_family);
+
+	if (family == AF_INET)
 		return ip_recv_error(sk, msg, len, addr_len);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	if (family == AF_INET6)
 		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
 #endif
 	return -EINVAL;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5f71a1c74e7e..b15c9ad0095a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -536,6 +536,10 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 	}
 	if (req)
 		reqsk_put(req);
+
+	if (newsk)
+		inet_init_csk_locks(newsk);
+
 	return newsk;
 out_err:
 	newsk = NULL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a99c374101fc..12ee857d6cfe 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1260,6 +1260,12 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 	if (unlikely(!rt))
 		return -EFAULT;
 
+	cork->fragsize = ip_sk_use_pmtu(sk) ?
+			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+
+	if (!inetdev_valid_mtu(cork->fragsize))
+		return -ENETUNREACH;
+
 	/*
 	 * setup for corking.
 	 */
@@ -1276,12 +1282,6 @@ static int ip_setup_cork(struct sock *sk, struct inet_cork *cork,
 		cork->addr = ipc->addr;
 	}
 
-	cork->fragsize = ip_sk_use_pmtu(sk) ?
-			 dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
-
-	if (!inetdev_valid_mtu(cork->fragsize))
-		return -ENETUNREACH;
-
 	cork->gso_size = ipc->gso_size;
 
 	cork->dst = &rt->dst;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index da9a55c68e11..ba1388ba6c6e 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -332,7 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	};
 	skb_reset_network_header(skb);
 
-	csum = csum_partial(icmp6h, len, 0);
+	csum = skb_checksum(skb, skb_transport_offset(skb), len, 0);
 	icmp6h->icmp6_cksum = csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr, len,
 					      IPPROTO_ICMPV6, csum);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3dd9b76f4055..a5c15e2d193f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
 		if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTOCORKING);
 			set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
+			smp_mb__after_atomic();
 		}
 		/* It is possible TX completion already happened
 		 * before we set TSQ_THROTTLED.
@@ -1777,6 +1778,36 @@ static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 	return frag;
 }
 
+static bool can_map_frag(const skb_frag_t *frag)
+{
+	struct page *page;
+
+	if (skb_frag_size(frag) != PAGE_SIZE || skb_frag_off(frag))
+		return false;
+
+	page = skb_frag_page(frag);
+
+	if (PageCompound(page) || page->mapping)
+		return false;
+
+	return true;
+}
+
+static int find_next_mappable_frag(const skb_frag_t *frag,
+				   int remaining_in_skb)
+{
+	int offset = 0;
+
+	if (likely(can_map_frag(frag)))
+		return 0;
+
+	while (offset < remaining_in_skb && !can_map_frag(frag)) {
+		offset += skb_frag_size(frag);
+		++frag;
+	}
+	return offset;
+}
+
 static int tcp_copy_straggler_data(struct tcp_zerocopy_receive *zc,
 				   struct sk_buff *skb, u32 copylen,
 				   u32 *offset, u32 *seq)
@@ -1902,6 +1933,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	ret = 0;
 	curr_addr = address;
 	while (length + PAGE_SIZE <= zc->length) {
+		int mappable_offset;
+
 		if (zc->recv_skip_hint < PAGE_SIZE) {
 			u32 offset_frag;
 
@@ -1929,15 +1962,11 @@ static int tcp_zerocopy_receive(struct sock *sk,
 			if (!frags || offset_frag)
 				break;
 		}
-		if (skb_frag_size(frags) != PAGE_SIZE || skb_frag_off(frags)) {
-			int remaining = zc->recv_skip_hint;
 
-			while (remaining && (skb_frag_size(frags) != PAGE_SIZE ||
-					     skb_frag_off(frags))) {
-				remaining -= skb_frag_size(frags);
-				frags++;
-			}
-			zc->recv_skip_hint -= remaining;
+		mappable_offset = find_next_mappable_frag(frags,
+							  zc->recv_skip_hint);
+		if (mappable_offset) {
+			zc->recv_skip_hint = mappable_offset;
 			break;
 		}
 		pages[pg_idx] = skb_frag_page(frags);
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index c70c192bc91b..5e0e2b5ba34e 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -213,19 +213,26 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
-const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
+const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LOOPBACK_INIT;
 EXPORT_SYMBOL(in6addr_loopback);
-const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_any __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_ANY_INIT;
 EXPORT_SYMBOL(in6addr_any);
-const struct in6_addr in6addr_linklocal_allnodes = IN6ADDR_LINKLOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
-const struct in6_addr in6addr_linklocal_allrouters = IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allrouters);
-const struct in6_addr in6addr_interfacelocal_allnodes = IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
-const struct in6_addr in6addr_interfacelocal_allrouters = IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
-const struct in6_addr in6addr_sitelocal_allrouters = IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 4247997077bf..329b3b36688a 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -197,6 +197,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index edf4a842506f..d1f819238414 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -829,9 +829,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
-	struct pcpu_sw_netstats *tstats;
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	int err;
+	const struct ipv6hdr *ipv6h;
+	int nh, err;
 
 	if ((!(tpi->flags & TUNNEL_CSUM) &&
 	     (tunnel->parms.i_flags & TUNNEL_CSUM)) ||
@@ -863,14 +862,29 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 			goto drop;
 		}
 
-		ipv6h = ipv6_hdr(skb);
 		skb->protocol = eth_type_trans(skb, tunnel->dev);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	} else {
 		skb->dev = tunnel->dev;
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	ipv6h = (struct ipv6hdr *)(skb->head + nh);
+
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 
 	__skb_tunnel_rx(skb, tunnel->dev, tunnel->net);
@@ -888,11 +902,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		}
 	}
 
-	tstats = this_cpu_ptr(tunnel->dev->tstats);
-	u64_stats_update_begin(&tstats->syncp);
-	tstats->rx_packets++;
-	tstats->rx_bytes += skb->len;
-	u64_stats_update_end(&tstats->syncp);
+	dev_sw_netstats_rx_add(tunnel->dev, skb->len);
 
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(tunnel->dev)));
 
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index e14368ced21f..7c73faa5336c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2310,7 +2310,7 @@ static int __init afiucv_init(void)
 {
 	int err;
 
-	if (MACHINE_IS_VM) {
+	if (MACHINE_IS_VM && IS_ENABLED(CONFIG_IUCV)) {
 		cpcmd("QUERY USERID", iucv_userid, sizeof(iucv_userid), &err);
 		if (unlikely(err)) {
 			WARN_ON(err);
@@ -2318,11 +2318,7 @@ static int __init afiucv_init(void)
 			goto out;
 		}
 
-		pr_iucv = try_then_request_module(symbol_get(iucv_if), "iucv");
-		if (!pr_iucv) {
-			printk(KERN_WARNING "iucv_if lookup failed\n");
-			memset(&iucv_userid, 0, sizeof(iucv_userid));
-		}
+		pr_iucv = &iucv_if;
 	} else {
 		memset(&iucv_userid, 0, sizeof(iucv_userid));
 		pr_iucv = NULL;
@@ -2356,17 +2352,13 @@ static int __init afiucv_init(void)
 out_proto:
 	proto_unregister(&iucv_proto);
 out:
-	if (pr_iucv)
-		symbol_put(iucv_if);
 	return err;
 }
 
 static void __exit afiucv_exit(void)
 {
-	if (pr_iucv) {
+	if (pr_iucv)
 		afiucv_iucv_exit();
-		symbol_put(iucv_if);
-	}
 
 	unregister_netdevice_notifier(&afiucv_netdev_notifier);
 	dev_remove_pack(&iucv_packet_type);
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 01e26698285a..dae978badd26 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -227,6 +227,8 @@ static int llc_ui_release(struct socket *sock)
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
+	sock_orphan(sk);
+	sock->sk = NULL;
 	llc_sk_free(sk);
 out:
 	return 0;
@@ -927,14 +929,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  */
 static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
+	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc = llc_sk(sk);
-	DECLARE_SOCKADDR(struct sockaddr_llc *, addr, msg->msg_name);
 	int flags = msg->msg_flags;
 	int noblock = flags & MSG_DONTWAIT;
+	int rc = -EINVAL, copied = 0, hdrlen, hh_len;
 	struct sk_buff *skb = NULL;
+	struct net_device *dev;
 	size_t size = 0;
-	int rc = -EINVAL, copied = 0, hdrlen;
 
 	dprintk("%s: sending from %02X to %02X\n", __func__,
 		llc->laddr.lsap, llc->daddr.lsap);
@@ -954,22 +957,29 @@ static int llc_ui_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		if (rc)
 			goto out;
 	}
-	hdrlen = llc->dev->hard_header_len + llc_ui_header_len(sk, addr);
+	dev = llc->dev;
+	hh_len = LL_RESERVED_SPACE(dev);
+	hdrlen = llc_ui_header_len(sk, addr);
 	size = hdrlen + len;
-	if (size > llc->dev->mtu)
-		size = llc->dev->mtu;
+	size = min_t(size_t, size, READ_ONCE(dev->mtu));
 	copied = size - hdrlen;
 	rc = -EINVAL;
 	if (copied < 0)
 		goto out;
 	release_sock(sk);
-	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
+	skb = sock_alloc_send_skb(sk, hh_len + size, noblock, &rc);
 	lock_sock(sk);
 	if (!skb)
 		goto out;
-	skb->dev      = llc->dev;
+	if (sock_flag(sk, SOCK_ZAPPED) ||
+	    llc->dev != dev ||
+	    hdrlen != llc_ui_header_len(sk, addr) ||
+	    hh_len != LL_RESERVED_SPACE(dev) ||
+	    size > READ_ONCE(dev->mtu))
+		goto out;
+	skb->dev      = dev;
 	skb->protocol = llc_proto_type(addr->sllc_arphrd);
-	skb_reserve(skb, hdrlen);
+	skb_reserve(skb, hh_len + hdrlen);
 	rc = memcpy_from_msg(skb_put(skb, copied), msg, copied);
 	if (rc)
 		goto out;
diff --git a/net/llc/llc_core.c b/net/llc/llc_core.c
index 64d4bef04e73..4900a27b5176 100644
--- a/net/llc/llc_core.c
+++ b/net/llc/llc_core.c
@@ -135,22 +135,15 @@ static struct packet_type llc_packet_type __read_mostly = {
 	.func = llc_rcv,
 };
 
-static struct packet_type llc_tr_packet_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_TR_802_2),
-	.func = llc_rcv,
-};
-
 static int __init llc_init(void)
 {
 	dev_add_pack(&llc_packet_type);
-	dev_add_pack(&llc_tr_packet_type);
 	return 0;
 }
 
 static void __exit llc_exit(void)
 {
 	dev_remove_pack(&llc_packet_type);
-	dev_remove_pack(&llc_tr_packet_type);
 }
 
 module_init(llc_init);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 788b6a3c1419..55abc06214c4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3721,6 +3721,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			goto begin;
 
 		skb = __skb_dequeue(&tx.skbs);
+		info = IEEE80211_SKB_CB(skb);
 
 		if (!skb_queue_empty(&tx.skbs)) {
 			spin_lock_bh(&fq->lock);
@@ -3765,7 +3766,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 encap_out:
-	IEEE80211_SKB_CB(skb)->control.vif = vif;
+	info->control.vif = vif;
 
 	if (vif &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 26ab0e9612d8..9523104a90da 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -28,6 +28,7 @@
 #define mtype_del		IPSET_TOKEN(MTYPE, _del)
 #define mtype_list		IPSET_TOKEN(MTYPE, _list)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype			MTYPE
 
 #define get_ext(set, map, id)	((map)->extensions + ((set)->dsize * (id)))
@@ -57,9 +58,6 @@ mtype_destroy(struct ip_set *set)
 {
 	struct mtype *map = set->data;
 
-	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
-
 	if (set->dsize && set->extensions & IPSET_EXT_DESTROY)
 		mtype_ext_cleanup(set);
 	ip_set_free(map->members);
@@ -288,6 +286,15 @@ mtype_gc(struct timer_list *t)
 	add_timer(&map->gc);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct mtype *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		del_timer_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant mtype = {
 	.kadt	= mtype_kadt,
 	.uadt	= mtype_uadt,
@@ -301,6 +308,7 @@ static const struct ip_set_type_variant mtype = {
 	.head	= mtype_head,
 	.list	= mtype_list,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 };
 
 #endif /* __IP_SET_BITMAP_IP_GEN_H */
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 24f81826ed4a..cc04c4d7956c 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1158,6 +1158,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 	return ret;
 
 cleanup:
+	set->variant->cancel_gc(set);
 	set->variant->destroy(set);
 put_out:
 	module_put(set->type->me);
@@ -1186,6 +1187,14 @@ ip_set_destroy_set(struct ip_set *set)
 	kfree(set);
 }
 
+static void
+ip_set_destroy_set_rcu(struct rcu_head *head)
+{
+	struct ip_set *set = container_of(head, struct ip_set, rcu);
+
+	ip_set_destroy_set(set);
+}
+
 static int ip_set_destroy(struct net *net, struct sock *ctnl,
 			  struct sk_buff *skb, const struct nlmsghdr *nlh,
 			  const struct nlattr * const attr[],
@@ -1199,8 +1208,6 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
 
-	/* Must wait for flush to be really finished in list:set */
-	rcu_barrier();
 
 	/* Commands are serialized and references are
 	 * protected by the ip_set_ref_lock.
@@ -1212,8 +1219,10 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 	 * counter, so if it's already zero, we can proceed
 	 * without holding the lock.
 	 */
-	read_lock_bh(&ip_set_ref_lock);
 	if (!attr[IPSET_ATTR_SETNAME]) {
+		/* Must wait for flush to be really finished in list:set */
+		rcu_barrier();
+		read_lock_bh(&ip_set_ref_lock);
 		for (i = 0; i < inst->ip_set_max; i++) {
 			s = ip_set(inst, i);
 			if (s && (s->ref || s->ref_netlink)) {
@@ -1227,12 +1236,17 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 			s = ip_set(inst, i);
 			if (s) {
 				ip_set(inst, i) = NULL;
+				/* Must cancel garbage collectors */
+				s->variant->cancel_gc(s);
 				ip_set_destroy_set(s);
 			}
 		}
 		/* Modified by ip_set_destroy() only, which is serialized */
 		inst->is_destroyed = false;
 	} else {
+		u16 features = 0;
+
+		read_lock_bh(&ip_set_ref_lock);
 		s = find_set_and_id(inst, nla_data(attr[IPSET_ATTR_SETNAME]),
 				    &i);
 		if (!s) {
@@ -1242,10 +1256,16 @@ static int ip_set_destroy(struct net *net, struct sock *ctnl,
 			ret = -IPSET_ERR_BUSY;
 			goto out;
 		}
+		features = s->type->features;
 		ip_set(inst, i) = NULL;
 		read_unlock_bh(&ip_set_ref_lock);
-
-		ip_set_destroy_set(s);
+		if (features & IPSET_TYPE_NAME) {
+			/* Must wait for flush to be really finished  */
+			rcu_barrier();
+		}
+		/* Must cancel garbage collectors */
+		s->variant->cancel_gc(s);
+		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
 	}
 	return 0;
 out:
@@ -1404,9 +1424,6 @@ static int ip_set_swap(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
-	/* Make sure all readers of the old set pointers are completed. */
-	synchronize_rcu();
-
 	return 0;
 }
 
@@ -2397,6 +2414,7 @@ ip_set_net_exit(struct net *net)
 		set = ip_set(inst, i);
 		if (set) {
 			ip_set(inst, i) = NULL;
+			set->variant->cancel_gc(set);
 			ip_set_destroy_set(set);
 		}
 	}
@@ -2444,8 +2462,11 @@ ip_set_fini(void)
 {
 	nf_unregister_sockopt(&so_set);
 	nfnetlink_subsys_unregister(&ip_set_netlink_subsys);
-
 	unregister_pernet_subsys(&ip_set_net_ops);
+
+	/* Wait for call_rcu() in destroy */
+	rcu_barrier();
+
 	pr_debug("these are the famous last words\n");
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index b0670388da49..093ec5214008 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -235,6 +235,7 @@ htable_size(u8 hbits)
 #undef mtype_gc_do
 #undef mtype_gc
 #undef mtype_gc_init
+#undef mtype_cancel_gc
 #undef mtype_variant
 #undef mtype_data_match
 
@@ -279,6 +280,7 @@ htable_size(u8 hbits)
 #define mtype_gc_do		IPSET_TOKEN(MTYPE, _gc_do)
 #define mtype_gc		IPSET_TOKEN(MTYPE, _gc)
 #define mtype_gc_init		IPSET_TOKEN(MTYPE, _gc_init)
+#define mtype_cancel_gc		IPSET_TOKEN(MTYPE, _cancel_gc)
 #define mtype_variant		IPSET_TOKEN(MTYPE, _variant)
 #define mtype_data_match	IPSET_TOKEN(MTYPE, _data_match)
 
@@ -444,7 +446,7 @@ mtype_ahash_destroy(struct ip_set *set, struct htable *t, bool ext_destroy)
 	u32 i;
 
 	for (i = 0; i < jhash_size(t->htable_bits); i++) {
-		n = __ipset_dereference(hbucket(t, i));
+		n = (__force struct hbucket *)hbucket(t, i);
 		if (!n)
 			continue;
 		if (set->extensions & IPSET_EXT_DESTROY && ext_destroy)
@@ -464,10 +466,7 @@ mtype_destroy(struct ip_set *set)
 	struct htype *h = set->data;
 	struct list_head *l, *lt;
 
-	if (SET_WITH_TIMEOUT(set))
-		cancel_delayed_work_sync(&h->gc.dwork);
-
-	mtype_ahash_destroy(set, ipset_dereference_nfnl(h->table), true);
+	mtype_ahash_destroy(set, (__force struct htable *)h->table, true);
 	list_for_each_safe(l, lt, &h->ad) {
 		list_del(l);
 		kfree(l);
@@ -613,6 +612,15 @@ mtype_gc_init(struct htable_gc *gc)
 	queue_delayed_work(system_power_efficient_wq, &gc->dwork, HZ);
 }
 
+static void
+mtype_cancel_gc(struct ip_set *set)
+{
+	struct htype *h = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		cancel_delayed_work_sync(&h->gc.dwork);
+}
+
 static int
 mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	  struct ip_set_ext *mext, u32 flags);
@@ -1433,6 +1441,7 @@ static const struct ip_set_type_variant mtype_variant = {
 	.uref	= mtype_uref,
 	.resize	= mtype_resize,
 	.same_set = mtype_same_set,
+	.cancel_gc = mtype_cancel_gc,
 	.region_lock = true,
 };
 
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 5a67f7966574..6bc7019982b0 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -426,9 +426,6 @@ list_set_destroy(struct ip_set *set)
 	struct list_set *map = set->data;
 	struct set_elem *e, *n;
 
-	if (SET_WITH_TIMEOUT(set))
-		del_timer_sync(&map->gc);
-
 	list_for_each_entry_safe(e, n, &map->members, list) {
 		list_del(&e->list);
 		ip_set_put_byindex(map->net, e->id);
@@ -545,6 +542,15 @@ list_set_same_set(const struct ip_set *a, const struct ip_set *b)
 	       a->extensions == b->extensions;
 }
 
+static void
+list_set_cancel_gc(struct ip_set *set)
+{
+	struct list_set *map = set->data;
+
+	if (SET_WITH_TIMEOUT(set))
+		del_timer_sync(&map->gc);
+}
+
 static const struct ip_set_type_variant set_variant = {
 	.kadt	= list_set_kadt,
 	.uadt	= list_set_uadt,
@@ -558,6 +564,7 @@ static const struct ip_set_type_variant set_variant = {
 	.head	= list_set_head,
 	.list	= list_set_list,
 	.same_set = list_set_same_set,
+	.cancel_gc = list_set_cancel_gc,
 };
 
 static void
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 6cb9f9474b05..28c6cb5cff0e 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -203,11 +203,12 @@ void nf_logger_put(int pf, enum nf_log_type type)
 		return;
 	}
 
-	BUG_ON(loggers[pf][type] == NULL);
-
 	rcu_read_lock();
 	logger = rcu_dereference(loggers[pf][type]);
-	module_put(logger->me);
+	if (!logger)
+		WARN_ON_ONCE(1);
+	else
+		module_put(logger->me);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nf_logger_put);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fca8f9a36063..f586e8b3c6cf 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -25,6 +25,7 @@
 #include <net/sock.h>
 
 #define NFT_MODULE_AUTOLOAD_LIMIT (MODULE_NAME_LEN - sizeof("nft-expr-255-"))
+#define NFT_SET_MAX_ANONLEN 16
 
 unsigned int nf_tables_net_id __read_mostly;
 
@@ -3930,6 +3931,9 @@ static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
 		if (p[1] != 'd' || strchr(p + 2, '%'))
 			return -EINVAL;
 
+		if (strnlen(name, NFT_SET_MAX_ANONLEN) >= NFT_SET_MAX_ANONLEN)
+			return -EINVAL;
+
 		inuse = (unsigned long *)get_zeroed_page(GFP_KERNEL);
 		if (inuse == NULL)
 			return -ENOMEM;
@@ -9336,16 +9340,10 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
-	default:
-		switch (data->verdict.code & NF_VERDICT_MASK) {
-		case NF_ACCEPT:
-		case NF_DROP:
-		case NF_QUEUE:
-			break;
-		default:
-			return -EINVAL;
-		}
-		fallthrough;
+	case NF_ACCEPT:
+	case NF_DROP:
+	case NF_QUEUE:
+		break;
 	case NFT_CONTINUE:
 	case NFT_BREAK:
 	case NFT_RETURN:
@@ -9380,6 +9378,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 		data->verdict.chain = chain;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	desc->len = sizeof(data->verdict);
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 7b0b8fecb220..9d250bd60bb8 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -38,20 +38,21 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst[i], be64_to_cpu(src64));
+				nft_reg_store64(&dst64[i], be64_to_cpu(src64));
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = (__force __u64)
 					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst[i], src64);
+				nft_reg_store64(&dst64[i], src64);
 			}
 			break;
 		}
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 7a9aa57b195b..a18582a4ecf3 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -358,9 +358,10 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 				  unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct nft_base_chain *basechain;
 	struct nftables_pernet *nft_net;
-	struct nft_table *table;
 	struct nft_chain *chain, *nr;
+	struct nft_table *table;
 	struct nft_ctx ctx = {
 		.net	= dev_net(dev),
 	};
@@ -372,7 +373,8 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 	nft_net = net_generic(ctx.net, nf_tables_net_id);
 	mutex_lock(&nft_net->commit_mutex);
 	list_for_each_entry(table, &nft_net->tables, list) {
-		if (table->family != NFPROTO_NETDEV)
+		if (table->family != NFPROTO_NETDEV &&
+		    table->family != NFPROTO_INET)
 			continue;
 
 		ctx.family = table->family;
@@ -381,6 +383,11 @@ static int nf_tables_netdev_event(struct notifier_block *this,
 			if (!nft_is_base_chain(chain))
 				continue;
 
+			basechain = nft_base_chain(chain);
+			if (table->family == NFPROTO_INET &&
+			    basechain->ops.hooknum != NF_INET_INGRESS)
+				continue;
+
 			ctx.chain = chain;
 			nft_netdev_event(event, dev, &ctx);
 		}
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index b8dbd20a6a4c..77c7362a7db8 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -192,6 +192,7 @@ static const struct nla_policy nft_rule_compat_policy[NFTA_RULE_COMPAT_MAX + 1]
 static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 {
 	struct nlattr *tb[NFTA_RULE_COMPAT_MAX+1];
+	u32 l4proto;
 	u32 flags;
 	int err;
 
@@ -204,12 +205,18 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 		return -EINVAL;
 
 	flags = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_FLAGS]));
-	if (flags & ~NFT_RULE_COMPAT_F_MASK)
+	if (flags & NFT_RULE_COMPAT_F_UNUSED ||
+	    flags & ~NFT_RULE_COMPAT_F_MASK)
 		return -EINVAL;
 	if (flags & NFT_RULE_COMPAT_F_INV)
 		*inv = true;
 
-	*proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	l4proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	if (l4proto > U16_MAX)
+		return -EINVAL;
+
+	*proto = l4proto;
+
 	return 0;
 }
 
@@ -327,6 +334,12 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -569,6 +582,12 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 14093d86e682..2b15dbbca98b 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -482,6 +482,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFT_CT_ID:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+
 		len = sizeof(u32);
 		break;
 	default:
@@ -1182,7 +1185,31 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_CT_EXPECT_L3PROTO])
 		priv->l3num = ntohs(nla_get_be16(tb[NFTA_CT_EXPECT_L3PROTO]));
 
+	switch (priv->l3num) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+		if (priv->l3num != ctx->family)
+			return -EINVAL;
+
+		fallthrough;
+	case NFPROTO_INET:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	priv->l4proto = nla_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
+	switch (priv->l4proto) {
+	case IPPROTO_TCP:
+	case IPPROTO_UDP:
+	case IPPROTO_UDPLITE:
+	case IPPROTO_DCCP:
+	case IPPROTO_SCTP:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
 	priv->dport = nla_get_be16(tb[NFTA_CT_EXPECT_DPORT]);
 	priv->timeout = nla_get_u32(tb[NFTA_CT_EXPECT_TIMEOUT]);
 	priv->size = nla_get_u8(tb[NFTA_CT_EXPECT_SIZE]);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index a44340dd3ce6..c2a5d05f501f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -150,6 +150,11 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 {
 	unsigned int hook_mask = (1 << NF_INET_FORWARD);
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
 }
 
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 44d9b38e5f90..cb5bb0e21b66 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -63,7 +63,7 @@ nft_meta_get_eval_time(enum nft_meta_keys key,
 {
 	switch (key) {
 	case NFT_META_TIME_NS:
-		nft_reg_store64(dest, ktime_get_real_ns());
+		nft_reg_store64((u64 *)dest, ktime_get_real_ns());
 		break;
 	case NFT_META_TIME_DAY:
 		nft_reg_store8(dest, nft_meta_weekday());
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index cd4eb4996aff..2e1ee7d9d9c3 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -142,6 +142,11 @@ static int nft_nat_validate(const struct nft_ctx *ctx,
 	struct nft_nat *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	err = nft_chain_validate_dependency(ctx->chain, NFT_CHAIN_T_NAT);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index bcd01a63e38f..f4a96164a5a1 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -166,6 +166,11 @@ static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *exp
 	const struct nft_rt *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->key) {
 	case NFT_RT_NEXTHOP4:
 	case NFT_RT_NEXTHOP6:
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index bc30bd121ff2..70a59a35d176 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,9 +342,6 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_scratch_index);
-
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -412,6 +409,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
@@ -422,15 +420,17 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 	local_bh_disable();
 
-	map_index = raw_cpu_read(nft_pipapo_scratch_index);
-
 	m = rcu_dereference(priv->match);
 
 	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
 		goto out;
 
-	res_map  = *raw_cpu_ptr(m->scratch) + (map_index ? m->bsize_max : 0);
-	fill_map = *raw_cpu_ptr(m->scratch) + (map_index ? 0 : m->bsize_max);
+	scratch = *raw_cpu_ptr(m->scratch);
+
+	map_index = scratch->map_index;
+
+	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
 
@@ -460,7 +460,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
 				  last);
 		if (b < 0) {
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return false;
@@ -477,7 +477,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 * current inactive bitmap is clean and can be reused as
 			 * *next* bitmap (not initial) for the next packet.
 			 */
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return true;
@@ -1101,6 +1101,25 @@ static void pipapo_map(struct nft_pipapo_match *m,
 		f->mt[map[i].to + j].e = e;
 }
 
+/**
+ * pipapo_free_scratch() - Free per-CPU map at original (not aligned) address
+ * @m:		Matching data
+ * @cpu:	CPU number
+ */
+static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int cpu)
+{
+	struct nft_pipapo_scratch *s;
+	void *mem;
+
+	s = *per_cpu_ptr(m->scratch, cpu);
+	if (!s)
+		return;
+
+	mem = s;
+	mem -= s->align_off;
+	kfree(mem);
+}
+
 /**
  * pipapo_realloc_scratch() - Reallocate scratch maps for partial match results
  * @clone:	Copy of matching data with pending insertions and deletions
@@ -1114,12 +1133,13 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	int i;
 
 	for_each_possible_cpu(i) {
-		unsigned long *scratch;
+		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
-		unsigned long *scratch_aligned;
+		void *scratch_aligned;
+		u32 align_off;
 #endif
-
-		scratch = kzalloc_node(bsize_max * sizeof(*scratch) * 2 +
+		scratch = kzalloc_node(struct_size(scratch, map,
+						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
 				       GFP_KERNEL, cpu_to_node(i));
 		if (!scratch) {
@@ -1133,14 +1153,25 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 			return -ENOMEM;
 		}
 
-		kfree(*per_cpu_ptr(clone->scratch, i));
-
-		*per_cpu_ptr(clone->scratch, i) = scratch;
+		pipapo_free_scratch(clone, i);
 
 #ifdef NFT_PIPAPO_ALIGN
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(scratch);
-		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
+		/* Align &scratch->map (not the struct itself): the extra
+		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
+		 * above guarantee we can waste up to those bytes in order
+		 * to align the map field regardless of its offset within
+		 * the struct.
+		 */
+		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
+
+		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
+		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
+		align_off = scratch_aligned - (void *)scratch;
+
+		scratch = scratch_aligned;
+		scratch->align_off = align_off;
 #endif
+		*per_cpu_ptr(clone->scratch, i) = scratch;
 	}
 
 	return 0;
@@ -1294,11 +1325,6 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	if (!new->scratch)
 		goto out_scratch;
 
-#ifdef NFT_PIPAPO_ALIGN
-	new->scratch_aligned = alloc_percpu(*new->scratch_aligned);
-	if (!new->scratch_aligned)
-		goto out_scratch;
-#endif
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(new->scratch, i) = NULL;
 
@@ -1350,10 +1376,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	}
 out_scratch_realloc:
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(new->scratch, i));
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(new->scratch_aligned);
-#endif
+		pipapo_free_scratch(new, i);
 out_scratch:
 	free_percpu(new->scratch);
 	kfree(new);
@@ -1635,13 +1658,9 @@ static void pipapo_free_match(struct nft_pipapo_match *m)
 	int i;
 
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(m->scratch, i));
+		pipapo_free_scratch(m, i);
 
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
-
 	pipapo_free_fields(m);
 
 	kfree(m);
@@ -2118,7 +2137,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 	m->field_count = field_count;
 	m->bsize_max = 0;
 
-	m->scratch = alloc_percpu(unsigned long *);
+	m->scratch = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch) {
 		err = -ENOMEM;
 		goto out_scratch;
@@ -2126,16 +2145,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
-#ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(unsigned long *);
-	if (!m->scratch_aligned) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-	for_each_possible_cpu(i)
-		*per_cpu_ptr(m->scratch_aligned, i) = NULL;
-#endif
-
 	rcu_head_init(&m->rcu);
 
 	nft_pipapo_for_each_field(f, i, m) {
@@ -2166,9 +2175,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	return 0;
 
 out_free:
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
 out_scratch:
 	kfree(m);
@@ -2222,11 +2228,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 
 		nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(m->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(m->scratch, cpu));
+			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
 		pipapo_free_fields(m);
 		kfree(m);
@@ -2239,11 +2242,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		if (priv->dirty)
 			nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(priv->clone->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(priv->clone->scratch, cpu));
+			pipapo_free_scratch(priv->clone, cpu);
 		free_percpu(priv->clone->scratch);
 
 		pipapo_free_fields(priv->clone);
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index d84afb8fa79a..2e709ae01924 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -130,21 +130,29 @@ struct nft_pipapo_field {
 	union nft_pipapo_map_bucket *mt;
 };
 
+/**
+ * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @map_index:	Current working bitmap index, toggled between field matches
+ * @align_off:	Offset to get the originally allocated address
+ * @map:	store partial matching results during lookup
+ */
+struct nft_pipapo_scratch {
+	u8 map_index;
+	u32 align_off;
+	unsigned long map[];
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
  * @scratch:		Preallocated per-CPU maps for partial matching results
- * @scratch_aligned:	Version of @scratch aligned to NFT_PIPAPO_ALIGN bytes
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
  * @f:			Fields, with lookup and mapping tables
  */
 struct nft_pipapo_match {
 	int field_count;
-#ifdef NFT_PIPAPO_ALIGN
-	unsigned long * __percpu *scratch_aligned;
-#endif
-	unsigned long * __percpu *scratch;
+	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[];
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 10332178da8c..60fb8bc0fdcc 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -71,9 +71,6 @@
 #define NFT_PIPAPO_AVX2_ZERO(reg)					\
 	asm volatile("vpxor %ymm" #reg ", %ymm" #reg ", %ymm" #reg)
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_avx2_scratch_index);
-
 /**
  * nft_pipapo_avx2_prepare() - Prepare before main algorithm body
  *
@@ -1123,11 +1120,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			    const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	unsigned long *res, *fill, *scratch;
+	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
+	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
@@ -1139,15 +1137,16 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	/* This also protects access to all data related to scratch maps */
 	kernel_fpu_begin();
 
-	scratch = *raw_cpu_ptr(m->scratch_aligned);
+	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		return false;
 	}
-	map_index = raw_cpu_read(nft_pipapo_avx2_scratch_index);
 
-	res  = scratch + (map_index ? m->bsize_max : 0);
-	fill = scratch + (map_index ? 0 : m->bsize_max);
+	map_index = scratch->map_index;
+
+	res  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	/* Starting map doesn't need to be set for this implementation */
 
@@ -1219,7 +1218,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	if (i % 2)
-		raw_cpu_write(nft_pipapo_avx2_scratch_index, !map_index);
+		scratch->map_index = !map_index;
 	kernel_fpu_end();
 
 	return ret >= 0;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 12d9d0d0c602..18c0d163dc76 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -237,7 +237,7 @@ static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
 
 static const struct nft_rbtree_elem *
 nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
-		   struct nft_rbtree_elem *rbe, u8 genmask)
+		   struct nft_rbtree_elem *rbe)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
@@ -256,7 +256,7 @@ nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev) &&
-		    nft_set_elem_active(&rbe_prev->ext, genmask))
+		    nft_set_elem_active(&rbe_prev->ext, NFT_GENMASK_ANY))
 			break;
 
 		prev = rb_prev(prev);
@@ -367,7 +367,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
-			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			removed_end = nft_rbtree_gc_elem(set, priv, rbe);
 			if (IS_ERR(removed_end))
 				return PTR_ERR(removed_end);
 
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index f6d517185d9c..826e5f8c78f3 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -166,6 +166,11 @@ static int nft_socket_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_PRE_ROUTING) |
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 1133e06f3c40..0806813d3a76 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -186,7 +186,6 @@ static int nft_synproxy_do_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		err = nf_synproxy_ipv4_init(snet, ctx->net);
 		if (err)
 			goto nf_ct_failure;
@@ -219,7 +218,6 @@ static void nft_synproxy_do_destroy(const struct nft_ctx *ctx)
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		nf_synproxy_ipv4_fini(snet, ctx->net);
 		nf_synproxy_ipv6_fini(snet, ctx->net);
 		break;
@@ -253,6 +251,11 @@ static int nft_synproxy_validate(const struct nft_ctx *ctx,
 				 const struct nft_expr *expr,
 				 const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
 						    (1 << NF_INET_FORWARD));
 }
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index f8d277e05ef4..6b606e83cdb6 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -293,6 +293,11 @@ static int nft_tproxy_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, 1 << NF_INET_PRE_ROUTING);
 }
 
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index cbbbc4ecad3a..7f762fc42891 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -233,6 +233,11 @@ static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *e
 	const struct nft_xfrm *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->dir) {
 	case XFRM_POLICY_IN:
 		hooks = (1 << NF_INET_FORWARD) |
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 901358a5b593..359f07a53ecc 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -366,7 +366,7 @@ static void netlink_skb_destructor(struct sk_buff *skb)
 	if (is_vmalloc_addr(skb->head)) {
 		if (!skb->cloned ||
 		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-			vfree(skb->head);
+			vfree_atomic(skb->head);
 
 		skb->head = NULL;
 	}
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 4c931bd1c174..5bfaf06f7be7 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1197,6 +1197,10 @@ void nci_free_device(struct nci_dev *ndev)
 {
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
+
+	/* drop partial rx data packet if present */
+	if (ndev->rx_data_reassembly)
+		kfree_skb(ndev->rx_data_reassembly);
 	kfree(ndev);
 }
 EXPORT_SYMBOL(nci_free_device);
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 293a798e89f4..cff18a5bbf38 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -47,6 +47,7 @@ struct ovs_len_tbl {
 
 #define OVS_ATTR_NESTED -1
 #define OVS_ATTR_VARIABLE -2
+#define OVS_COPY_ACTIONS_MAX_DEPTH 16
 
 static bool actions_may_change_flow(const struct nlattr *actions)
 {
@@ -2514,13 +2515,15 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log);
+				  u32 mpls_label_count, bool log,
+				  u32 depth);
 
 static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    const struct sw_flow_key *key,
 				    struct sw_flow_actions **sfa,
 				    __be16 eth_type, __be16 vlan_tci,
-				    u32 mpls_label_count, bool log, bool last)
+				    u32 mpls_label_count, bool log, bool last,
+				    u32 depth)
 {
 	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
 	const struct nlattr *probability, *actions;
@@ -2571,7 +2574,8 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -2586,7 +2590,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 				     const struct sw_flow_key *key,
 				     struct sw_flow_actions **sfa,
 				     __be16 eth_type, __be16 vlan_tci,
-				     u32 mpls_label_count, bool log)
+				     u32 mpls_label_count, bool log,
+				     u32 depth)
 {
 	const struct nlattr *attrs[OVS_DEC_TTL_ATTR_MAX + 1];
 	int start, action_start, err, rem;
@@ -2619,7 +2624,8 @@ static int validate_and_copy_dec_ttl(struct net *net,
 		return action_start;
 
 	err = __ovs_nla_copy_actions(net, actions, key, sfa, eth_type,
-				     vlan_tci, mpls_label_count, log);
+				     vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -2633,7 +2639,8 @@ static int validate_and_copy_clone(struct net *net,
 				   const struct sw_flow_key *key,
 				   struct sw_flow_actions **sfa,
 				   __be16 eth_type, __be16 vlan_tci,
-				   u32 mpls_label_count, bool log, bool last)
+				   u32 mpls_label_count, bool log, bool last,
+				   u32 depth)
 {
 	int start, err;
 	u32 exec;
@@ -2653,7 +2660,8 @@ static int validate_and_copy_clone(struct net *net,
 		return err;
 
 	err = __ovs_nla_copy_actions(net, attr, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 	if (err)
 		return err;
 
@@ -3022,7 +3030,7 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 					   struct sw_flow_actions **sfa,
 					   __be16 eth_type, __be16 vlan_tci,
 					   u32 mpls_label_count,
-					   bool log, bool last)
+					   bool log, bool last, u32 depth)
 {
 	const struct nlattr *acts_if_greater, *acts_if_lesser_eq;
 	struct nlattr *a[OVS_CHECK_PKT_LEN_ATTR_MAX + 1];
@@ -3070,7 +3078,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_lesser_eq, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3083,7 +3092,8 @@ static int validate_and_copy_check_pkt_len(struct net *net,
 		return nested_acts_start;
 
 	err = __ovs_nla_copy_actions(net, acts_if_greater, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log);
+				     eth_type, vlan_tci, mpls_label_count, log,
+				     depth + 1);
 
 	if (err)
 		return err;
@@ -3111,12 +3121,16 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  const struct sw_flow_key *key,
 				  struct sw_flow_actions **sfa,
 				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log)
+				  u32 mpls_label_count, bool log,
+				  u32 depth)
 {
 	u8 mac_proto = ovs_key_mac_proto(key);
 	const struct nlattr *a;
 	int rem, err;
 
+	if (depth > OVS_COPY_ACTIONS_MAX_DEPTH)
+		return -EOVERFLOW;
+
 	nla_for_each_nested(a, attr, rem) {
 		/* Expected argument lengths, (u32)-1 for variable length. */
 		static const u32 action_lens[OVS_ACTION_ATTR_MAX + 1] = {
@@ -3311,7 +3325,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_sample(net, a, key, sfa,
 						       eth_type, vlan_tci,
 						       mpls_label_count,
-						       log, last);
+						       log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3382,7 +3396,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			err = validate_and_copy_clone(net, a, key, sfa,
 						      eth_type, vlan_tci,
 						      mpls_label_count,
-						      log, last);
+						      log, last, depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3396,7 +3410,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 							      eth_type,
 							      vlan_tci,
 							      mpls_label_count,
-							      log, last);
+							      log, last,
+							      depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3406,7 +3421,8 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 		case OVS_ACTION_ATTR_DEC_TTL:
 			err = validate_and_copy_dec_ttl(net, a, key, sfa,
 							eth_type, vlan_tci,
-							mpls_label_count, log);
+							mpls_label_count, log,
+							depth);
 			if (err)
 				return err;
 			skip_copy = true;
@@ -3446,7 +3462,8 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 
 	(*sfa)->orig_len = nla_len(attr);
 	err = __ovs_nla_copy_actions(net, attr, key, sfa, key->eth.type,
-				     key->eth.vlan.tci, mpls_label_count, log);
+				     key->eth.vlan.tci, mpls_label_count, log,
+				     0);
 	if (err)
 		ovs_nla_free_flow_actions(*sfa);
 
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index b239120dd9ca..0ec0ae148349 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -419,7 +419,7 @@ static int rds_recv_track_latency(struct rds_sock *rs, sockptr_t optval,
 
 	rs->rs_rx_traces = trace.rx_traces;
 	for (i = 0; i < rs->rs_rx_traces; i++) {
-		if (trace.rx_trace_pos[i] > RDS_MSG_RX_DGRAM_TRACE_MAX) {
+		if (trace.rx_trace_pos[i] >= RDS_MSG_RX_DGRAM_TRACE_MAX) {
 			rs->rs_rx_traces = 0;
 			return -EFAULT;
 		}
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index aff184145ffa..9081e8429584 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -41,6 +41,14 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	_enter("%d", conn->debug_id);
 
+	if (sp && sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+				  &pkt.ack, sizeof(pkt.ack)) < 0)
+			return;
+		if (pkt.ack.reason == RXRPC_ACK_PING_RESPONSE)
+			return;
+	}
+
 	chan = &conn->channels[channel];
 
 	/* If the last call got moved on whilst we were waiting to run, just
diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 68508166bbc0..af0e95ef992d 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -31,7 +31,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq = 1;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -41,6 +41,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index f15fca59b4b2..7c921760dce7 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -177,7 +177,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	}
 	if (smc->conn.lgr && smc->conn.lgr->is_smcd &&
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
-	    !list_empty(&smc->conn.lgr->list)) {
+	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
 		struct smc_connection *conn = &smc->conn;
 		struct smcd_diag_dmbinfo dinfo;
 
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a68c04..a11e80d17830 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -253,8 +253,9 @@ struct rpc_xprt *xprt_iter_current_entry(struct rpc_xprt_iter *xpi)
 	return xprt_switch_find_current_entry(head, xpi->xpi_cursor);
 }
 
-bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
-			      const struct sockaddr *sap)
+static
+bool __rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+				const struct sockaddr *sap)
 {
 	struct list_head *head;
 	struct rpc_xprt *pos;
@@ -273,6 +274,18 @@ bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
 	return false;
 }
 
+bool rpc_xprt_switch_has_addr(struct rpc_xprt_switch *xps,
+			      const struct sockaddr *sap)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = __rpc_xprt_switch_has_addr(xps, sap);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static
 struct rpc_xprt *xprt_switch_find_next_entry(struct list_head *head,
 		const struct rpc_xprt *cur)
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index df6aba2246fa..2511718b8f3f 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1072,6 +1072,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 237488b1b58b..b003d0597f4b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1126,13 +1126,11 @@ static void unix_state_double_lock(struct sock *sk1, struct sock *sk2)
 		unix_state_lock(sk1);
 		return;
 	}
-	if (sk1 < sk2) {
-		unix_state_lock(sk1);
-		unix_state_lock_nested(sk2);
-	} else {
-		unix_state_lock(sk2);
-		unix_state_lock_nested(sk1);
-	}
+	if (sk1 > sk2)
+		swap(sk1, sk2);
+
+	unix_state_lock(sk1);
+	unix_state_lock_nested(sk2, U_LOCK_SECOND);
 }
 
 static void unix_state_double_unlock(struct sock *sk1, struct sock *sk2)
@@ -1352,7 +1350,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk);
+	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
 	if (sk->sk_state != st) {
 		unix_state_unlock(sk);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 951b33fa8f5c..2975e7a061d0 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -83,7 +83,7 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 			 * queue lock. With the other's queue locked it's
 			 * OK to lock the state.
 			 */
-			unix_state_lock_nested(req);
+			unix_state_lock_nested(req, U_LOCK_DIAG);
 			peer = unix_sk(req)->peer;
 			buf[i++] = (peer ? sock_i_ino(peer) : 0);
 			unix_state_unlock(req);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1e6dfe204ff3..a6c289a61d30 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1801,8 +1801,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_access_pointer(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 90398347e366..3463f0f6c3f4 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -9,6 +9,29 @@ if [[ $# < 1 ]]; then
 	exit 1
 fi
 
+# Try to find a Rust demangler
+if type llvm-cxxfilt >/dev/null 2>&1 ; then
+	cppfilt=llvm-cxxfilt
+elif type c++filt >/dev/null 2>&1 ; then
+	cppfilt=c++filt
+	cppfilt_opts=-i
+fi
+
+UTIL_SUFFIX=
+if [[ -z ${LLVM:-} ]]; then
+	UTIL_PREFIX=${CROSS_COMPILE:-}
+else
+	UTIL_PREFIX=llvm-
+	if [[ ${LLVM} == */ ]]; then
+		UTIL_PREFIX=${LLVM}${UTIL_PREFIX}
+	elif [[ ${LLVM} == -* ]]; then
+		UTIL_SUFFIX=${LLVM}
+	fi
+fi
+
+READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
+ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -33,13 +56,18 @@ else
 	release=""
 fi
 
-declare -A cache
-declare -A modcache
+declare aarray_support=true
+declare -A cache 2>/dev/null
+if [[ $? != 0 ]]; then
+	aarray_support=false
+else
+	declare -A modcache
+fi
 
 find_module() {
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if readelf -WS "$fn" | grep -qwF .debug_line ; then
+			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
 				echo $fn
 				return
 			fi
@@ -51,7 +79,7 @@ find_module() {
 	find_module && return
 
 	if [[ $release == "" ]] ; then
-		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" | sed -n 's/\$1 = "\(.*\)".*/\1/p')
+		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
 	fi
 
 	for dn in {/usr/lib/debug,}/lib/modules/$release ; do
@@ -74,7 +102,7 @@ parse_symbol() {
 
 	if [[ $module == "" ]] ; then
 		local objfile=$vmlinux
-	elif [[ "${modcache[$module]+isset}" == "isset" ]]; then
+	elif [[ $aarray_support == true && "${modcache[$module]+isset}" == "isset" ]]; then
 		local objfile=${modcache[$module]}
 	else
 		local objfile=$(find_module)
@@ -82,7 +110,9 @@ parse_symbol() {
 			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
-		modcache[$module]=$objfile
+		if [[ $aarray_support == true ]]; then
+			modcache[$module]=$objfile
+		fi
 	fi
 
 	# Remove the englobing parenthesis
@@ -102,15 +132,17 @@ parse_symbol() {
 	# Use 'nm vmlinux' to figure out the base address of said symbol.
 	# It's actually faster to call it every time than to load it
 	# all into bash.
-	if [[ "${cache[$module,$name]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
 		if [[ $base_addr == "" ]] ; then
 			# address not found
 			return
 		fi
-		cache[$module,$name]="$base_addr"
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$name]="$base_addr"
+		fi
 	fi
 	# Let's start doing the math to get the exact address into the
 	# symbol. First, strip out the symbol total length.
@@ -126,11 +158,13 @@ parse_symbol() {
 
 	# Pass it to addr2line to get filename and line number
 	# Could get more than one result
-	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address")
-		cache[$module,$address]=$code
+		local code=$(${ADDR2LINE} -i -e "$objfile" "$address" 2>/dev/null)
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$address]=$code
+		fi
 	fi
 
 	# addr2line doesn't return a proper error code if it fails, so
@@ -146,6 +180,12 @@ parse_symbol() {
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
 
+	# Demangle if the name looks like a Rust symbol and if
+	# we got a Rust demangler
+	if [[ $name =~ ^_R && $cppfilt != "" ]] ; then
+		name=$("$cppfilt" "$cppfilt_opts" "$name")
+	fi
+
 	# Replace old address with pretty line numbers
 	symbol="$segment$name ($code)"
 }
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 92d9aa6cc4f5..db6098c42fa6 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -75,7 +75,7 @@ sub parse_abi {
 	$name =~ s,.*/,,;
 
 	my $fn = $file;
-	$fn =~ s,Documentation/ABI/,,;
+	$fn =~ s,.*Documentation/ABI/,,;
 
 	my $nametag = "File $fn";
 	$data{$nametag}->{what} = "File $name";
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 19af6dd160e6..7a04d4c05326 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1232,7 +1232,8 @@ sub dump_struct($$) {
 	$members =~ s/DECLARE_KFIFO\s*\(([^,)]+),\s*([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
-
+	# replace DECLARE_FLEX_ARRAY
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index acd07a70a2f4..3a1ffd84eac2 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -171,8 +171,13 @@ gen_btf()
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
 		--strip-all ${1} ${2} 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
-	# Unlike GNU ld, lld does not allow an ET_EXEC input.
-	printf '\1' | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
+	if [ -n "${CONFIG_CPU_BIG_ENDIAN}" ]; then
+		et_rel='\0\1'
+	else
+		et_rel='\1\0'
+	fi
+	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
 }
 
 # Create ${2} .S file with all symbols from the ${1} object file
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index d587f40f1117..b6eda411be15 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -328,7 +328,12 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
 
 	/* Sum all files in the same dir or subdirs. */
 	while ((line = get_line(&pos))) {
-		char* p = line;
+		char* p;
+
+		/* trim the leading spaces away */
+		while (isspace(*line))
+			line++;
+		p = line;
 
 		if (strncmp(line, "source_", sizeof("source_")-1) == 0) {
 			p = strrchr(line, ' ');
diff --git a/security/security.c b/security/security.c
index f9157d5023c6..269c3965393f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1498,6 +1498,24 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit
+ * processes running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
@@ -2080,7 +2098,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc;
+
+	/*
+	 * Only one module will provide a security context.
+	 */
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, ctx, ctxlen);
+		if (rc != LSM_RET_DEFAULT(inode_getsecctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(inode_getsecctx);
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f545321d96dc..50d3ddfe15fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3662,6 +3662,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to
+	 * make sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec __ro_after_init;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -7049,6 +7076,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 814518ad4402..e1669759403a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4767,6 +4767,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 1f3cd432d830..a8dc3ae938f9 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -548,6 +548,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 5570722458ca..e510bf09967d 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -605,17 +605,15 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 	struct hdac_stream *s;
 	bool inited = false;
 	u64 cycle_last = 0;
-	int i = 0;
 
 	list_for_each_entry(s, &bus->stream_list, list) {
-		if (streams & (1 << i)) {
+		if ((streams & (1 << s->index))) {
 			azx_timecounter_init(s, inited, cycle_last);
 			if (!inited) {
 				inited = true;
 				cycle_last = s->tc.cycle_last;
 			}
 		}
-		i++;
 	}
 
 	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
@@ -660,14 +658,13 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams)
 {
 	struct hdac_bus *bus = azx_dev->bus;
-	int i, nwait, timeout;
+	int nwait, timeout;
 	struct hdac_stream *s;
 
 	for (timeout = 5000; timeout; timeout--) {
 		nwait = 0;
-		i = 0;
 		list_for_each_entry(s, &bus->stream_list, list) {
-			if (!(streams & (1 << i++)))
+			if (!(streams & (1 << s->index)))
 				continue;
 
 			if (start) {
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 48c78388c1d2..ea0a2b1d23a3 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -372,6 +372,16 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x7e28,
 	},
+	/* ArrowLake-S */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL_S,
+	},
+	/* ArrowLake */
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ARL,
+	},
 #endif
 
 /* Lunar Lake */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 12c6eb76fca3..a3c6a5eeba3a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2581,6 +2581,8 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	{ PCI_DEVICE(0x8086, 0x4b58),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e35c470eb481..5b37f5f14bc9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -235,6 +235,7 @@ enum {
 	CXT_FIXUP_HP_ZBOOK_MUTE_LED,
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
+	CXT_PINCFG_SWS_JS201D,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -732,6 +733,17 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* SuoWoSi/South-holding JS201D with sn6140 */
+static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
+	{ 0x16, 0x03211040 }, /* hp out */
+	{ 0x17, 0x91170110 }, /* SPK/Class_D */
+	{ 0x18, 0x95a70130 }, /* Internal mic */
+	{ 0x19, 0x03a11020 }, /* Headset Mic */
+	{ 0x1a, 0x40f001f0 }, /* Not used */
+	{ 0x21, 0x40f001f0 }, /* Not used */
+	{}
+};
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -887,6 +899,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.chained = true,
 		.chain_id = CXT_FIXUP_HEADSET_MIC,
 	},
+	[CXT_PINCFG_SWS_JS201D] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_sws_js201d,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -960,6 +976,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
+	SND_PCI_QUIRK(0x14f1, 0x0265, "SWS JS201D", CXT_PINCFG_SWS_JS201D),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo T410", CXT_PINCFG_LENOVO_TP410),
@@ -1000,6 +1017,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_ZBOOK_MUTE_LED, .name = "hp-zbook-mute-led" },
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
+	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 412fbe098e0c..233449d98237 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8841,6 +8841,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1269, "Acer SWIFT SF314-54", ALC256_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x126a, "Acer Swift SF114-32", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
@@ -9025,6 +9026,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
@@ -9331,6 +9333,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
+	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7dc80183921e..04457cbed5b4 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3276,6 +3276,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_HEADPHONE);
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
+		mutex_unlock(&rt5645->jd_mutex);
 		return;
 	case 4:
 		val = snd_soc_component_read(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..42f57b640f11 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -50,11 +50,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 28d22265b825..cbdc2839904e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4611,6 +4611,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testing/selftests/bpf/progs/pyperf180.c
index c39f559d3100..42c4a8b62e36 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at clang18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some branch
+ * target distance exceeded 16bit representation which is the maximum for
+ * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang18
+ * to specify which cpu version is used for compilation. So a smaller
+ * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
+ * reduced some branch target distances and resolved the compilation failure.
+ *
+ * To capture the case where a developer/ci uses clang18 but the corresponding
+ * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_count
+ * will be set as well to prevent potential compilation failures.
+ */
+#ifdef __BPF_CPU_VERSION__
+#if __BPF_CPU_VERSION__ < 4
+#define UNROLL_COUNT 90
+#endif
+#elif __clang_major__ == 18
+#define UNROLL_COUNT 90
+#endif
+
 #include "pyperf.h"
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 1b08e042cf94..185b02d2d4cd 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -269,6 +269,7 @@ for port in 0 1; do
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
+    ifconfig $NSIM_NETDEV up
 
     msg="new NIC device created"
     exp0=( 0 0 0 0 )
@@ -430,6 +431,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -487,6 +489,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "overflow NIC table"
@@ -543,6 +546,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     overflow_table0 "destroy NIC"
@@ -572,6 +576,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -632,6 +637,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     echo 110 > $NSIM_DEV_DFS/ports/$port/udp_ports_inject_error
@@ -687,6 +693,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -746,6 +753,7 @@ for port in 0 1; do
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
+    NSIM_NETDEV=`get_netdev_name old_netdevs`
     ifconfig $NSIM_NETDEV up
 
     msg="create VxLANs v6"
@@ -876,6 +884,7 @@ msg="re-add a port"
 
 echo 2 > $NSIM_DEV_SYS/del_port
 echo 2 > $NSIM_DEV_SYS/new_port
+NSIM_NETDEV=`get_netdev_name old_netdevs`
 check_tables
 
 msg="replace VxLAN in overflow table"
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 3253fdc780d6..9cd5cf800a5b 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1583,6 +1583,13 @@ check_command() {
 	return 0
 }
 
+check_running() {
+	pid=${1}
+	cmd=${2}
+
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+}
+
 test_cleanup_vxlanX_exception() {
 	outer="${1}"
 	encap="vxlan"
@@ -1613,11 +1620,12 @@ test_cleanup_vxlanX_exception() {
 
 	${ns_a} ip link del dev veth_A-R1 &
 	iplink_pid=$!
-	sleep 1
-	if [ "$(cat /proc/${iplink_pid}/cmdline 2>/dev/null | tr -d '\0')" = "iplinkdeldevveth_A-R1" ]; then
-		err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
-		return 1
-	fi
+	for i in $(seq 1 20); do
+		check_running ${iplink_pid} "iplinkdeldevveth_A-R1" || return 0
+		sleep 0.1
+	done
+	err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
+	return 1
 }
 
 test_cleanup_ipv6_exception() {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 356fd5d1a428..b7638c3c9eb7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1008,9 +1008,9 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
  */
 static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
-	unsigned long dirty_bytes = 2 * kvm_dirty_bitmap_bytes(memslot);
+	unsigned long dirty_bytes = kvm_dirty_bitmap_bytes(memslot);
 
-	memslot->dirty_bitmap = kvzalloc(dirty_bytes, GFP_KERNEL_ACCOUNT);
+	memslot->dirty_bitmap = __vcalloc(2, dirty_bytes, GFP_KERNEL_ACCOUNT);
 	if (!memslot->dirty_bitmap)
 		return -ENOMEM;
 

