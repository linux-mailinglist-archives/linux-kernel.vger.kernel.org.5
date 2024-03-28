Return-Path: <linux-kernel+bounces-122845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E288FE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CB296739
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE47E789;
	Thu, 28 Mar 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dT5uxZjg"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BB2D792;
	Thu, 28 Mar 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626322; cv=none; b=L9KQcxLbaCnxymrUYEQpLMfaIeXYgRHVM2vWaMKONKAU4eLsOIlRQ+mlfZKZvcZ5C1FiA36tdtgwvEQuhHr4FIwE16AVjITEcOLfzUcsbjbW2H+EAr97/RDKLH9zom8GwVF07VsJ7AS7+8+d/n629i4ITAM85OASKP5Fg2CpODI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626322; c=relaxed/simple;
	bh=B/NLA0JqUu9nGEsxqIfEeqxUghyu4idtZeiguQk7wxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mD/mJV1EHa3wnaPjMin7c6f4z15qJYUlbqlTzPG9TiLnFE8NA5iIvPs9h4dgoMED2RKpj/tloC8i7uNWxboqgizUWhv5iyJxWDXdwPvIuouq1a7i1+LHpbjf6pOImShfS/HnfJJ/at2KeOMvpg8hrRPX89TlBEyKZX83bj3rubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dT5uxZjg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sWdWCgyZ6xlfuvIzR+ofSNpFmValQUTb1NvuAPBYTns=;
	t=1711626320; x=1712835920; b=dT5uxZjgz8i09sSqkEHIY9ZnZFnyW/x53aF4teYBjL1wSa7
	nuITPAcVfDj9g891BCdodZgryXfJnlqAUxYc5FKTo0NvECT3T/0wC4VlV2e8KBDj1+JrY+JHec7SI
	do5gT6iCOxBvwra1NUwJZVOFhGtH1fNsJCsQhBqkhEuJmeI9EHvf+la5oMgLvx+IGT+w2Oq5cSJka
	Hu1MYQE0cFJRspevDkB9QkuaV4cXVRVOlHwonUQ+kqt8av5R2p2L69/DXHWlh5pB+WNL2ac7LWgUW
	a47N1j51p2GnB1l3LpCdX3XrSqKZDG2uvcqaLMQSzXJPSzJ0sgnfBXNFccHnX4bQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpoBz-00000000vii-2O2d;
	Thu, 28 Mar 2024 12:45:11 +0100
Message-ID: <550cc81a3dffd07ec1235dc32fd7bbde22d9bf57.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] WARNING in kcov_remote_start (3)
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>,  Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 28 Mar 2024 12:45:10 +0100
In-Reply-To: <0000000000007b02500614b66e31@google.com>
References: <0000000000007b02500614b66e31@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 04:00 -0700, syzbot wrote:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 2400 at kernel/kcov.c:860 kcov_remote_start+0x549/0x=
7e0 kernel/kcov.c:860

This is

        /*
         * Check that kcov_remote_start() is not called twice in background
         * threads nor called by user tasks (with enabled kcov).
         */
        mode =3D READ_ONCE(t->kcov_mode);
        if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
                local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
                return;
        }

but I have no idea what that even means?

> Workqueue: events_unbound cfg80211_wiphy_work
> RIP: 0010:kcov_remote_start+0x549/0x7e0 kernel/kcov.c:860
..
> Call Trace:
>  <TASK>
>  kcov_remote_start_common include/linux/kcov.h:48 [inline]
>  ieee80211_iface_work+0x21f/0xf10 net/mac80211/iface.c:1654
>  cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380

It's a worker thread. Was this not intended to be called in threads?

johannes

