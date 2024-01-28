Return-Path: <linux-kernel+bounces-41559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D383F48C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B161C211C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CDD527;
	Sun, 28 Jan 2024 07:54:40 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8371D50F
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706428480; cv=none; b=R5VCCiV7E5ifHaltInCeQK5rTPuSeDhtk8DkwJ7k5BwOR2vr4zHjywgi8E3z1xokWx/6dOwTdysIMlv1KHimxbo90biYlnrM3RPI3AJRY84XWbm2eb972BAfwU21u6fq5HOhCSr25GvDi6HcFbAJQnp+VHPgSk7gnec2paQbwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706428480; c=relaxed/simple;
	bh=Da4WDq5HfuRP5KeCLqU386YWmOl7/PEp4QQBQqqilBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLBPEoyIf+DAAkr1+Xn3eLwlB+eeFfNF9z+TW4ULMZRGCO2t0OJif6dcANn7FCOjAD540rd8ewPWfZN8qcIdsExzOvxDxsWyKBfHr+5iU6oytzNSFl7oSwNROX/rwvHDPvEoIItX2xHte12NMSWnIJCCOzeKwXQh+QofUI4uzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.210])
	by sina.com (10.75.12.45) with ESMTP
	id 65B6080A000073EA; Sun, 28 Jan 2024 15:53:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 90553131457786
X-SMAIL-UIID: 751044471A7F4D6C9BC4786BB680DF9C-20240128-155349-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
Date: Sun, 28 Jan 2024 15:53:40 +0800
Message-Id: <20240128075340.1015-1-hdanton@sina.com>
In-Reply-To: <0000000000008efd70060ce21487@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 11:43:27 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

