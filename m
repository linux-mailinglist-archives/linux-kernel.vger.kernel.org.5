Return-Path: <linux-kernel+bounces-128209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DAC895792
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE9280F2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E900E12B16E;
	Tue,  2 Apr 2024 14:55:16 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13E8662E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069716; cv=none; b=nADGc6KhzqZH8VVAtIkpDUulcGO8IBD08LqB+p6f8Y45JPLHODhGzmLHYGXcqpuzIBeCMeuvmCzaK4Lb7ocWbvLnNjUOFdmD/ifRlW0HTYJBTuoQKPv5laQ3K/f5hus3yQFDo7b+tw/73VoXMNZMQZpyZXvD8N/0NV9LknlzSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069716; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l4hkNkdIq0wnyg0AZumiCBQLtbQ2L4MM4R0WaYmpfAD6BmO+rikXWPSjhG49H+UeMQFFjZxX34rlzpMI8dFljBRydRKYfWCeCiAXwm8lhIGgf3tToL0tAcKEr/9cWAEkOimVG1D0bM6YU9/WcutjzH4W1oC2jA6maIlApEZmnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 432Et2T7078334;
	Tue, 2 Apr 2024 23:55:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Tue, 02 Apr 2024 23:55:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 432Et2Qg078331
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Apr 2024 23:55:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <578d7908-c140-460f-92c9-f2a4e85f6f6d@I-love.SAKURA.ne.jp>
Date: Tue, 2 Apr 2024 23:54:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [reiserfs?] INFO: task hung in deactivate_super (2)
Content-Language: en-US
To: syzbot <syzbot+aa7397130ec6a8c2e2d9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000001ea9dc06151c9630@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000001ea9dc06151c9630@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: fs: Block writes to mounted block devices


