Return-Path: <linux-kernel+bounces-52188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7584951B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443FD1C23CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D011183;
	Mon,  5 Feb 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="nBU44E1j"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5411197;
	Mon,  5 Feb 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120611; cv=none; b=L0c6iLjbCCdhopK99UemdxEhLEB/lBvZT3PKDuWSmUQP7MuViyUopxva33W8K/HYOdyffk2gzwTrHoNhdjiTt7KS//Y1bCknaTWNFmSH+mNKij5tPQVA7rD5EN7fmsMXiDmiq/u7yJTjeC3MXnH8ALHewp/U6cwJLEaJkC+1cOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120611; c=relaxed/simple;
	bh=Ddy/ljBytqvKFtjT6EJefVgfG8ZRmZ74N35MfnnBHWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMxitpZOSTv3khmS/wvdBc1+Cmtqrg08FSobP6061Z5RsaN4bSm7ZKxZk8SvYFRHeA/+npsNo9pp/PjWoc4gQKYdqLM95rE3W0hYtcIEAJUrQowjjfT3zIp04FlgSSsm7nTo16nNF6ZzojU/o+6Gt8lw5ZqDXkVYjBQVP8JTOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=nBU44E1j; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 8342C6033F;
	Mon,  5 Feb 2024 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707120608;
	bh=Ddy/ljBytqvKFtjT6EJefVgfG8ZRmZ74N35MfnnBHWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBU44E1jSf5dsBUZixtXnd9OqM8ocvHXbNyfwTOr/JN8uolMFfZYI1pw6QPgJyVAr
	 b7DgZJ4As+RqOGyERYM/uBAeCyOZbivdhTHK3xRoDv+ymw9NZ98rRQ1RyG+P5Jjfyi
	 08eLLrZvc2KTAeWaQDeZI+kcsVWa799+TFds1c8hEzasww2lqIBvfjACZKZMuX4JPF
	 FnQUl32RNQHEFH6cPhhS4HAEM1FWzjpWf/CsK4ZEmLuBGYvJX+CbRG2SlZGPrBcoNo
	 ag9HWtwCimr2NgAYaKhgp+vRISJZ4tPTxrQbyXGl59cT7V0b0u/L/xncfy0JesdhPf
	 9BoOhTdDB6y+A==
Date: Mon, 5 Feb 2024 10:09:53 +0200
From: Tony Lindgren <tony@atomide.com>
To: Hillf Danton <hdanton@sina.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+listbb8340e4e1f8191bee93@syzkaller.appspotmail.com>
Subject: Re: [syzbot] Monthly serial report (Feb 2024)
Message-ID: <20240205080953.GC31612@atomide.com>
References: <00000000000074375c06106c787f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000074375c06106c787f@google.com>

Hi Hillf,

* syzbot <syzbot+listbb8340e4e1f8191bee93@syzkaller.appspotmail.com> [700101 02:00]:
> <5> 73      Yes   general protection fault in serial8250_tx_chars
>                   https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8

Can you please send your earlier fix [0] to the linux-serial mailing list
so it can be applied?

Not quite sure what triggers the serial_port_remove().. But let's fix the
serial_port_runtime_resume() issue first.

Regards,

Tony

[0] https://groups.google.com/g/syzkaller-bugs/c/m3vOaJRjnMs

