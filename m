Return-Path: <linux-kernel+bounces-91737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28A8715D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CEB1F221DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E37C0A1;
	Tue,  5 Mar 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U7NwhGUX"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91A46521
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619876; cv=none; b=ayVEz21tcodXfffFxhX7OvHkeck9I1n/JyoU2Wpd0sx2PPkJqeZOPBbMIScChb82+7ofS88trmppzPAn+J3q8pHJQ8EqN0b/VEHDvulZKZFDj1IzQrEdl/NWOznsC1U8QrxZSnK5qo/tK1EkEJXZMTZTGbV+VCEWlubRacOOfUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619876; c=relaxed/simple;
	bh=dE18vaGqW1u26WlxEwBm1HNfaT/R+phg+iUf/5S0VIs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aKQB7vSCCb2EfVqh7oHC4Cbx/vuJbRalmL9TnGrP9W2vh+QQtjk6N5A9/X1poYHUyGqbURoC2/C3WziaQHMPHSu5K0V7e9pVr3Tvhsv2v5+wskWi2JbDgIfpVM4VtYUrGMA7Fn4d/xY5KHIOzG5WTfxquLEt808EijEMUHbZlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U7NwhGUX; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709619869; bh=TsV7flYFQYG54yZpLUHZV0gHbA6RRacBo4I7EqORDTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7NwhGUXf2E7agNCE4dwFMQandCUit+6OKS/xpSD+Xk5SYkjiAGOfOhWoBsdcgMpa
	 zbqp7LF1nKsx6lcbVIC+4FHNd8F/TMVYiK+hTTeCOjxG6QeL/z9kqm/sncnPU6MKI5
	 cwkOfxyDmf9uruBbGzlTlA/4v1d0Xhuxzy4AxkpA=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 61A2EEB4; Tue, 05 Mar 2024 14:24:26 +0800
X-QQ-mid: xmsmtpt1709619866t469u5zqe
Message-ID: <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCdtIc/8eFoFNKi2PKd+Oqlq/n3MDP5GDeJ87TlIBfCoHPDh9Glp
	 fBOktgD+dCl5eaUITQ9mLy2lZHcw4GAcKv0wmVTYnvdPnJIJIYDiJbsAyav10zfQEvxfba91zfDH
	 znWVbomF+mDY8MX87v75eFa6iY3K9/BjMbNboq8OcE5yA1j/YavGCo6qhkPaQG4Cy7Tazpg9A+l7
	 LNa7IOmE8m64g+XF2wxhhVmfdmlMuGUk70p0c3dGN6HJivq6N6zAfr6rrlUGDoe6K7MdlKOysYOR
	 xSd+SSWObpeBk1pXY3KyljKrs6iWfMBOPiYaa2yBqjICc/wlkO/8ZNQMP8LF2U5XoAdXVweN3CS8
	 F+Zi4MX0xhvG1GM7dmky68xxmFD+ZN6LuCjFbwrM1O+hkgsR7dIx6GW3v2R2m4gpsdnTaRJIaj9F
	 KLQa72fMupC6CwWGfCxbWiNJZvs76Y8O2QG4BKMg+aM6ZPsD5M4LKwXpHBCkE1LpY2ze2ZV2fSDz
	 fxMjf0K9qBTn1fqQ2NXA4z+z0/MdGEXR+n3+V4faMV52bsMWh/GZRyQ0OUGbv5V48d+XkvfYTh+n
	 y7hL+4L0WBFHOLvQiyu50lo0WJxNFb0gLpnHCdB02kUoVUhfY/LusGJrJkGuvHlWA6B/Ejz0ptcN
	 lKwfuGXrgcPuP4iWbVW1wfbhI5+8foQp6S544i1HYczRqcdaPQHRORBIzaHl3itCI74FOg7Q+Nfw
	 4iy8L0tAG4pciNIZXSnbzDstGaxDeNK+nzLe6eoOmVKMernoYy63S/B35Koywk8pCCXj/MOd6EmG
	 BvUN6IHJFUPktijacAL5FY/jJUjVIxxpOZj2oO9nW+wuG2zoDGRcj1US2v0UWdVv0Sdgph4ir6+K
	 6MDnK11qsWrN1fFrYoZ2dwSLOVW82GXKNcNaXgFBjIHuqAfs5HIO6HUF2Y7o06QdWc+/MPnq88tb
	 P6LixdKzD8na3sAvkI0/bdwx9l143vn76pNjS6/kclPAnQOz/nF0HxMwyisOpvVJzGgZ8boKtIFJ
	 XdAUXlMIrBIe+fZJ4WLFZKCGCSc08=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: linke li <lilinke99@qq.com>
To: joel@joelfernandes.org
Cc: boqun.feng@gmail.com,
	dave@stgolabs.net,
	frederic@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency bug
Date: Tue,  5 Mar 2024 14:24:20 +0800
X-OQ-MSGID: <20240305062420.17398-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Anyway, a slightly related/different question:
> 
> Should that:
> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
> 
> Be:
> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
> 
> ?

Hi, Joel. Sorry, I am not very sure about this. I do a little research on
it.

I looked through all code in kernel that looks like this, both kinds are
used. I also try to compile this file with and without the READ_ONCE in
WRITE_ONCE using gcc-9. Their binary is just the same. 

Thus I think in the current compiler version, they do not have a big
difference, but if the compiler wants to optimize more, maybe the latter
one is better.


