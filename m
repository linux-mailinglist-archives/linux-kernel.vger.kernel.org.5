Return-Path: <linux-kernel+bounces-152300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F18ABC0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913B21C206A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297322EF5;
	Sat, 20 Apr 2024 14:49:22 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546BB669
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624561; cv=none; b=Dm4Q2765/th1/6BYlwknI0zaCaEziCjghoSrWq1qWHUPwP7YMHEM4X3Ekyi9xnMgCodNtNpRfXxTz1A5GklrYygXekH+GyaLcVRQkZi/xER1fJZs3vPfClmTvGijQ5RtyBOR1KuN+ixK1UkcaezmacNq2I3jZNAZqCY2AvxciuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624561; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TZtmsWpkXkcfZCBVmXUaevjKVRZQ2yD/HLE+OwwWSwA3VHCKlAThOqPoY4zaVLLZ2Z30HIT2ex0YvuL3p2OrEQLn2QDz+iL6U0rYTDt2VH4103qf5oQ3wHUlcK+kMDNOd98jURyhfnOVQjosyQ0Nq3ERmnCG4rzg2dquSlFr5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43KEnD4G036757;
	Sat, 20 Apr 2024 23:49:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 20 Apr 2024 23:49:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43KEnDIx036753
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 23:49:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <417c5714-b5b0-4559-98fe-0547a71a5d84@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 23:49:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_delete_elem
To: syzbot <syzbot+2f4f478b78801c186d39@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000dcb0e50613f17bfc@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000dcb0e50613f17bfc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem


