Return-Path: <linux-kernel+bounces-16602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAF8240E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15101F23865
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76E2110D;
	Thu,  4 Jan 2024 11:44:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15728210F5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bbc2d52f98so56729739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704368691; x=1704973491;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUs6DRjGoL/oKkphLAZhEnVXOYdk8DXdvKAuzQtGcUc=;
        b=UEZjhLRvH+euBeO4btHvIuOx/Mw0wK7jY6Xi8J5+8rultia83PpYIraW76j5dMdQ9S
         dJO30UGWu4oqCinny1mNYWBpzBOoFBsW6HacVGN1YEMitLteD9xqlM66rf3/CCsjVOzl
         wjSjxX9tVGICOOAKduhMWYF1tN+XhL9ui7rsUa8ieDInoNy6F4tcHZH1FOeLb7COYNBw
         wcanWx9unN4XuZQJUGFIO4gxPS1YzQbtU8wPrAMJO37TMKESzN0AgqxkXMZZj5KnehcF
         aMPXqIUIA5TlG75zrrZEQ6uhF0JByL4qItzmotgA5a0Z39sB2nOgO6I9Ow8J6zrxIqRG
         N8qA==
X-Gm-Message-State: AOJu0YyW8Mb+6jmOeTN8H9orgdlFKp+r6BMWvXp7pq+/86MxuqaXIeDs
	6Nl71ou6im9ObQWZ11+qXHt3k2stjhX/aivbZ5Kxgnk6fTb3WzY=
X-Google-Smtp-Source: AGHT+IFuxlhjIjvpAhYm65mIP5AU0+VIl561pxfzed4PJI/LL4kW5xf6QTZg5bv213LdyjpBiWwbsxWYebUdky1Nq3/Xjgww+5SU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1648:b0:46d:f174:5ec with SMTP id
 a8-20020a056638164800b0046df17405ecmr23300jat.3.1704368691248; Thu, 04 Jan
 2024 03:44:51 -0800 (PST)
Date: Thu, 04 Jan 2024 03:44:51 -0800
In-Reply-To: <0000000000007fbc8c060dcc3a5c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000688671060e1d42df@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
From: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] general protection fault in hfsc_tcf_block
Author: jiri@resnulli.us

#syz test: https://github.com/jpirko/linux_mlxsw.git wip_tc_block_fix

