Return-Path: <linux-kernel+bounces-14325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC5821B68
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457C5282DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45732EAF5;
	Tue,  2 Jan 2024 12:08:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82963EAE8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bb6983237fso401204139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 04:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704197283; x=1704802083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJSLwzoQ3cjWIUj72qDoZtcSeYaD0b5NPFqVPtLj3x0=;
        b=V7N+S4f8/IlCvg4H1YEGKIRQFOD6161stmYm24h4TmESXs8ptygZoSQBkoq6dmQpra
         JdtcegQtbCBegAHdg5FbmNUIzJJVDjX8c9NZq+GZShswLnAYII7yz0tKicp9CyHxs3Sv
         qAKY862BLhQLOfUxHVHNgFubcpqKaOmISM6H4mF6SV+YHUxbu2XRrlnMeAHhsROfgOfn
         JPq/tEXNtG1jJHtUS3u7OgCzyCkYHwPr4yDvpAkCOH38GhcITsx5tFihhRjLI0A6NOgX
         ndUb27oa9wxKRw1skswLzwbVlpEg68lXMbOVGHWi2FbmT2+VGsuDOQzrtwn9/dnQoLbI
         bMXg==
X-Gm-Message-State: AOJu0YzQp9iop6xNJfqLviABSHhAtcxDJxCWdRJA80n/kBfNsRHQZ1UN
	0uMggdXaG62eYxSclKpOp3eh6vCP0XZEJ8cQZ4GMlb9HSNV9
X-Google-Smtp-Source: AGHT+IEkNMbKthF6psz52EDBPhk8bDPxjfUF6HqVZ3QtXfuVDaqLaea/KysaaZv6JD22q4KrXbtVs8lF9CBB3+Yiu1sWcRV+U2rh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6917:b0:46d:6d47:925 with SMTP id
 gg23-20020a056638691700b0046d6d470925mr259981jab.4.1704197283693; Tue, 02 Jan
 2024 04:08:03 -0800 (PST)
Date: Tue, 02 Jan 2024 04:08:03 -0800
In-Reply-To: <tencent_17CEBA53BB6733599E5D1B6A4BB11B5A2508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8cb3f060df5592e@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
From: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com

Tested on:

commit:         610a9b8f Linux 6.7-rc8
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14649d81e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=41a88b825a315aac2254
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1031326ee80000

Note: testing is done by a robot and is best-effort only.

