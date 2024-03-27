Return-Path: <linux-kernel+bounces-120154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DC88D35B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A77130219D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F72DDA0;
	Wed, 27 Mar 2024 00:24:22 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB236E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711499062; cv=none; b=GUXzf405IJu+uvYJYofMkKqgoDVlXEcUmOYgVyFbngTEg4TTM76RlHLQ1jsCawhhbe6ijtdUOhsOv7vtwySKc5SqnGMbQjssKViBrZ0KO2KcHZY4LJAeGki/gZ0YuXbb2++MZWC+CvsK1xAGa5DLHo+R77Sc3vJgPkANpc78AEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711499062; c=relaxed/simple;
	bh=fYqDdIXapUBE0MxV0rIK+zXf297Qb+0D5VWup0Hvs9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kEnqjk3k3O6FZBCZpMAYtqfl0nHr9rKwEGZthtfTAfJdQBYioT2U3MdfU59zUvZoWL9+319GM4X9hJCXYVPRK0DQO0C0c4+Hb/Y/7VKsLt9mXYEenE/voZCGmiDnmdSspwARM3HgzmKrpmAXXX6vEC04+ERa+l6D4lOkQK7HpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42R0OCpx041617;
	Wed, 27 Mar 2024 09:24:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 27 Mar 2024 09:24:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42R0OC0q041614
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 09:24:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c1b10906-7a2f-41cc-bff2-3aba07f8c3d1@I-love.SAKURA.ne.jp>
Date: Wed, 27 Mar 2024 09:24:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] net boot error: WARNING: refcount bug
 in __free_pages_ok
Content-Language: en-US
To: syzbot <syzbot+84f677a274bd8b05f6cb@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bdb4b9061497f2de@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000bdb4b9061497f2de@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: Fix refcount imbalance


