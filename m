Return-Path: <linux-kernel+bounces-152209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87E8ABAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3B81F21322
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078A175AD;
	Sat, 20 Apr 2024 09:22:36 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10917592
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604956; cv=none; b=HuahNWsF9zE+O37n2LzB7u5Dtds4ItdMcRmlny1iMJKwKjg1guSsqOM2y4D4ub74izvJf2K4tcOZQMlotSZmayJfvs4Kiqr1Wu8Mv5qQI0wF14sri7Bvxu/fv3SuFDgCJWhKxS3WGCJxQjJ6ilH+O8/XacnjwJj2zhV0NlS3BtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604956; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lXyU/pXV2D9cfGiyEXFxWisDX+NlbGkviK0MZOubmWgDEs558U7vqXAli87FY92jXoCXXMxhNSjTq0/N0fUvUCUXXVMKCcuf5nfnLDTZHEizy/3CSpSk5JyJW5cFoD4eynCqbnVXeHlp+m4JBd3RL1Dcvz6vyEJEXs8Cb9DmXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43K9MSWC049972;
	Sat, 20 Apr 2024 18:22:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 20 Apr 2024 18:22:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43K9MSYC049968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 18:22:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <286337d2-accc-4ea0-bbe4-a88a923c598b@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 18:22:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] upstream test error: WARNING: refcount bug in
 __reset_page_owner
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+ed0599ef4b473503bc7f@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000080c82706140b9e5d@google.com>
 <2da018c8-23ac-4346-b038-4b04766bdcb3@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <2da018c8-23ac-4346-b038-4b04766bdcb3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: fix refcount imbalance


