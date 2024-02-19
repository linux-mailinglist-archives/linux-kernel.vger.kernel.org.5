Return-Path: <linux-kernel+bounces-71615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71985A7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043B41F24C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6B3B1A8;
	Mon, 19 Feb 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D473HamS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6553A3D384;
	Mon, 19 Feb 2024 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357792; cv=none; b=PdDckWB4dhXy6dHYiZ0fTVgSQ98oZoCSQm7kNaM0BgMKaggu/UzVKySgDcajebwXZabJGes2WF+WXEuTJOtmIWbN/6KvgDSspzh846ARrySgOF2mXK5jeR8or356FpJTHnjUPFYbMVl8wGiHwV3BpUlN2//wYtSdJUu+yb9Z1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357792; c=relaxed/simple;
	bh=YvFC4xI4AtllwaPrtCPa62a3WM3IH2L8FS7AqLwAqog=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OCFFANUjexEgY+Wix4ckMjDpUgoO0ZT0+PIYU2+fIUIwA+Q2Ya5cy8dhSM+ZPtiIAgo89nO6k0KGbafoHdE8LkQN/jiKPYT1SwGXpys9u0zd0MO3n/kyocvCEoi2mW+rUOdByJJj4GdP/eYPEXff82mx82Q/6ri7D3A7N0p2WQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D473HamS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708357788;
	bh=YvFC4xI4AtllwaPrtCPa62a3WM3IH2L8FS7AqLwAqog=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D473HamSNqxxUwlodm4+NXMHH4i3et8L5Eanivq2TgH0na34j7OpM3+QBWz3hHv+x
	 udmmz4urcPqFJUoIwVmnJBJyk7oyoNpA14mPlKws/h22aMPfvmdMrxqdpDFQzTbsjd
	 xQc36rD6ccflLWlppJPb9q7/a1TvkcKqLV0BwQnVtbOwGZaR2cQ03e4Qzi6753VzOH
	 Ie7gq7yMqn8cv0DNTz61/Wac73yIjUTMREKPHne2rLC8vJ6WmZRtHdV3CrKSYdmrbG
	 h3wr5afdN1ynF8mGWTqO7AoPjg+6TJdtTWiP5K//7FEiKvAK+QpCcCFZoE42U02djw
	 y3TucHIaNzT3g==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7DBE3782080;
	Mon, 19 Feb 2024 15:49:47 +0000 (UTC)
Message-ID: <98b81fbf-4905-4b45-a8c0-33e7399ef84a@collabora.com>
Date: Mon, 19 Feb 2024 16:49:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] [media?] possible deadlock in
 vb2_video_unregister_device
To: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>,
 hdanton@sina.com, hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl,
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
 m.szyprowski@samsung.com, mchehab@kernel.org,
 syzkaller-bugs@googlegroups.com, tfiga@chromium.org
References: <000000000000cb40790611bbcffd@google.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <000000000000cb40790611bbcffd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 19/02/2024 à 14:10, syzbot a écrit :
> syzbot has bisected this issue to:
>
> commit c838530d230bc638d79b78737fc4488ffc28c1ee
> Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Date:   Thu Nov 9 16:34:59 2023 +0000
>
>      media: media videobuf2: Be more flexible on the number of queue stored buffers
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166dc872180000
> start commit:   b401b621758e Linux 6.8-rc5
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=156dc872180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=116dc872180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3b1d4b3d5f7a358bf9a9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ffaae8180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ef909c180000
>
> Reported-by: syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com
> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the number of queue stored buffers")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hans,
I think the issue occur because of this part of the commit:
@@ -1264,7 +1264,7 @@ void vb2_video_unregister_device(struct video_device *vdev)
          */
         get_device(&vdev->dev);
         video_unregister_device(vdev);
-       if (vdev->queue && vdev->queue->owner) {
+       if (vdev->queue) {
                 struct mutex *lock = vdev->queue->lock ?
                         vdev->queue->lock : vdev->lock;

but I wonder if the correction shouldn't be to remove usbtv->vb2q_lock mutex in usbtv_video_free().

Any opinion ?

Regards,
Benjamin

>

