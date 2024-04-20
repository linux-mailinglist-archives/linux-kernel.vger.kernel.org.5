Return-Path: <linux-kernel+bounces-152309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48B78ABC38
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E39C1F21046
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A9A29CFA;
	Sat, 20 Apr 2024 15:37:47 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B87F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713627467; cv=none; b=fXNQZpWIoUa1nVMGje/MRquELL0CDruerLGeCc4A50pekwlngZOifZDRoUjcU3hjXU2RZJSf4QQ22pzMI7ZNGOtM8uefRKtBx0cbReH9tFju2IExWJeYsKoH6P+96lfvOD34D1Ks6XnjEccPWuDREvQsTEfs/CjqK1HTSRUtt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713627467; c=relaxed/simple;
	bh=MrauLE7vTIJ56o0G5yI1/rmSGSVS4GvOYwtIC8oySNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YP5h1/7THVLHTQx9JhlHijTga1KJETkV+V7RbImypV3EbcyHnSwyd6K2iu4X6VL62/1RNJhSVPVwBS4H7Wih+xg6x/WWwNVXLN0OzjubuWNI4tEEFIZvjBpYky8wPb4HxXT90c6JRw3bezQAfXwdam7mIfLCskEIJaFTKae6QFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43KFbbvp049053;
	Sun, 21 Apr 2024 00:37:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 21 Apr 2024 00:37:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43KFbbKt049050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 21 Apr 2024 00:37:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e1e99c35-c032-4ac0-9eab-7182a1b51d40@I-love.SAKURA.ne.jp>
Date: Sun, 21 Apr 2024 00:37:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] WARNING in _prb_commit
To: syzbot <syzbot+f86f028ee75b0f7e6e5d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000d84c150616702f04@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d84c150616702f04@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: bpf, sockmap: Prevent lock inversion deadlock in map delete elem


