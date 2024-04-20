Return-Path: <linux-kernel+bounces-152205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297F8ABABE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2339B20E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FF91758E;
	Sat, 20 Apr 2024 09:20:04 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954A13ADC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604803; cv=none; b=BBN7vl2gN416H6+TI9nVz8FEari5+zRnKa3/tQI0Nxoz3Ydqv5LNv10kXVINGN8tLMs6WOmlCNvteXKkfuqTrKuq/3tIodRGGL9eiC9w4Wy+7IsL2uJKY5kJy3wRyw/rvgGaEDiiLefsKVT9E2kplU3q2PXYIhq9gqk7FXelPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604803; c=relaxed/simple;
	bh=+r7xumgUU3mNk+cE9uPjJ5rbwa0TPdjSPLtQ60kjzGo=;
	h=Message-ID:Date:MIME-Version:From:To:References:Subject:
	 In-Reply-To:Content-Type; b=dILKnkLI+kQ6UvPiUzfi9vvlO+5BryGvQkDaTiEng8mP0KEkwCYJSQHXCs9Nr6+T7K8/IHMy0x3YaOf2ypAQW8NApv+hMiDSOPN3uoQjjNqwOJSF9edae++tVDKtz9II+IdGH0pFpA/u9+HkfTxtiWXL/WWblN99CSSuYCD/ea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43K9Jn01047223;
	Sat, 20 Apr 2024 18:19:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 20 Apr 2024 18:19:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43K9JnWW047220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 18:19:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec3b8c52-6824-4bd1-848b-53eb36632d55@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 18:19:48 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+84f677a274bd8b05f6cb@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bdb4b9061497f2de@google.com>
 <c1b10906-7a2f-41cc-bff2-3aba07f8c3d1@I-love.SAKURA.ne.jp>
Content-Language: en-US
Subject: Re: [syzbot] [virtualization?] net boot error: WARNING: refcount bug
 in __free_pages_ok
In-Reply-To: <c1b10906-7a2f-41cc-bff2-3aba07f8c3d1@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/27 9:24, Tetsuo Handa wrote:
> #syz fix: mm,page_owner: Fix refcount imbalance

#syz fix: mm,page_owner: fix refcount imbalance


