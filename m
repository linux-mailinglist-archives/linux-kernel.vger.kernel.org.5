Return-Path: <linux-kernel+bounces-118774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D508B88BF25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906452A4A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D45D461;
	Tue, 26 Mar 2024 10:19:14 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE754916
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448353; cv=none; b=kMo8e7SGvvqaJLLUdIGYm286Ihf/HsNIC4aYYvhPHK9OR4GHWcuwvnRp1e+VLCNIxfwjyCGijAR2uOLMVXFaN25S6TiAE+QbeAlopjuwmbhItKsKD1xjxUMmb0qLsn2pXEZz43tQ0WNWkSndDEkK2sRGXNgBy28PbL1A+a4jqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448353; c=relaxed/simple;
	bh=fYqDdIXapUBE0MxV0rIK+zXf297Qb+0D5VWup0Hvs9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M+O1e42P4eNk5RvLiuxdJHpqNI9YWcW4TXQfaCQ08nprcTlGrSvqGr1/xlCxCExbwCNU5DZqYzP7y2DN1GNqeK8Q7cklgC2KXO305Nmef2TnDds6qzNZJCPYKG19shhX9hstPfUE+D+KKfHYSv87OX2425f7aZa/DYjsPd9/Q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42QAJ43O087100;
	Tue, 26 Mar 2024 19:19:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 26 Mar 2024 19:19:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42QAJ4gH087097
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 26 Mar 2024 19:19:04 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <460847f5-0ea7-4c23-ac23-c6dc5e2cc524@I-love.SAKURA.ne.jp>
Date: Tue, 26 Mar 2024 19:19:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] upstream boot error: WARNING: refcount bug in
 __reset_page_owner
Content-Language: en-US
To: syzbot <syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000090e8ff0613eda0e5@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000090e8ff0613eda0e5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: mm,page_owner: Fix refcount imbalance


