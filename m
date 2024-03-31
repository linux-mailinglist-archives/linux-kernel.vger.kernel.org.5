Return-Path: <linux-kernel+bounces-126250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36889343C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6BC28631C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19C6145FFA;
	Sun, 31 Mar 2024 16:42:03 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B7145B38
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903323; cv=fail; b=PfPgrlf09AKGF23u/VkSiKxhI46w+gcT53FOYeDEYa7/vWZlHGrkbg1ij1r9qToeDzBi2SZiSswrQeQHALJX0U2MxdU9kQt347v7gEUZWZmmqye1cnVDI+bEowvI3cCCHS5t/BpeauISvxEGP2fy5Ocwhw62lz7VgXnX9kENfE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903323; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gBtsx0p3TPs/wt4D/mDC35KaINk0p4CPkYRQLdT+gjhEVD6CgCw3TFdm8BJEWw/lXZbhQUHjbKKXn5iJzhUnAHfEEJilmtpoV+bVaoqBBPMQmnm5CaLePuIPfsxv6gyoFLMmwxiMlvcnI9SnlNV6fYZngZIHeQt5huHJ0u9j9Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=fail smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A0787208A2;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WeIlzEX4TdwR; Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 38E1E20184;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 38E1E20184
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2C0F980005E;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:08 +0000
X-sender: <linux-kernel+bounces-125913-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAmWgFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 6764
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125913-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com B3EBE2025D
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711845011; cv=none; b=nusLsNCJRb64YQpxplh0EQ60ZIjxwrEj74J4fPpe3vz+CWne0WdDPfl/ec/87VbWTxUNS6ij6uxDcfXIVdcUPlzi5SNk76AWtmweXj3vOlgYtx6W12LVhujxWkyIyWGzMp3S1zRi3c8pL07XuRAYiNzImYFPhS4eX3zwH1jpEBU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711845011; c=relaxed/simple;
	bh=HmvUXRk6KWF8pkj/3bMmqxGVWO5zIq4abz7LDPgnwg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hzNTbvUteehpGqxO/Me4yU4LqJ5Bon4p8sBJd5mHRfkTDceibz48/dVRDZB/VOSTXiVmtQRcKr8475D2SU6Koc70jm6GPiBVd4rGW0kQDCZ7xxtoedKOVMGCffe3vAqGnwJp7JkdQ8ofYwxU9d+vSwZwq/Z5SsvDs95SJzOo5J4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Message-ID: <3714dcca-7192-4e1c-858d-26ac6da24222@I-love.SAKURA.ne.jp>
Date: Sun, 31 Mar 2024 09:29:53 +0900
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] bpf boot error: WARNING: refcount bug
 in __free_pages_ok
Content-Language: en-US
To: syzbot <syzbot+689655a7402cc18ace0a@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
References: <0000000000002aea130614e28812@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000002aea130614e28812@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

#syz fix: mm,page_owner: fix refcount imbalance



