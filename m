Return-Path: <linux-kernel+bounces-141866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D28A2465
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EA41C21EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B961799F;
	Fri, 12 Apr 2024 03:25:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65417579
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892355; cv=none; b=EsrVf5zza5OYFOUGTMiSvaf1gvdlIakXXeuWEZVKRYAExsIUr5PDmuYV2Yb1afyYsTw3g7piboYNsjh6MbcZ7GFB1eKS7O0ERPoVC6yJA9jNbQbNvQUAJ71POdaBPhIUbWQqqPzG5DcKdnR9+wQt1JiKZrkuqQsIKwl2DAGho3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892355; c=relaxed/simple;
	bh=nXNsIgydw8Zdl8kFL8pMfD2IYcL55ZSBNUsgHJ6RORk=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=hAD4U6kjqqC3MeqFmrUhpbsnbDnfHYTvfMHDsN4jdJutkew1bpndnOVdAXf6SynKmbzraCSBoPwg2OFLXUleRdqUCj49Qaum3IgDmk0UoH85dMxa1BVH3LzZ3d8R7OeKYWzSDZLwtKjrLcOcn1acrBXofaHDA8Kpych+3MVEcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VG25W0SDPz8XrRG;
	Fri, 12 Apr 2024 11:25:51 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 43C3PkOW095723;
	Fri, 12 Apr 2024 11:25:46 +0800 (+08)
	(envelope-from li.hao40@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 12 Apr 2024 11:25:47 +0800 (CST)
Date: Fri, 12 Apr 2024 11:25:47 +0800 (CST)
X-Zmail-TransId: 2afb6618a9bbffffffffab7-1093f
X-Mailer: Zmail v1.0
Message-ID: <20240412112547433nW9Ip0D2cBmiCc-YaWRru@zte.com.cn>
In-Reply-To: <2024041151-crewmate-entail-62a5@gregkh>
References: 20240411215017604oDcKsSipiLnfwd2SzAnsj@zte.com.cn,2024041151-crewmate-entail-62a5@gregkh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <li.hao40@zte.com.cn>
To: <gregkh@linuxfoundation.org>
Cc: <jirislaby@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdHR5OiBodmM6IHdha2V1cCBodmMgY29uc29sZSBpbW1lZGlhdGVseSB3aGVuIG5lZWRlZA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 43C3PkOW095723
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6618A9BF.000/4VG25W0SDPz8XrRG

sorry,the patch seems to be corrupt,I will resubmit the patch





------------------Original------------------
From: gregkh <gregkh@linuxfoundation.org>
To: li hao10307857;
Cc: jirislaby <jirislaby@kernel.org>;linuxppc-dev <linuxppc-dev@lists.ozlabs.org>;linux-kernel <linux-kernel@vger.kernel.org>;
Date: 2024/04/11 22:03
Subject: Re: [PATCH] tty: hvc: wakeup hvc console immediately when needed
On Thu, Apr 11, 2024 at 09:50:17PM +0800, li.hao40@zte.com.cn wrote:
> From: Li Hao <li.hao40@zte.com.cn>
>
> Cancel the do_wakeup flag in hvc_struct, and change it to immediately
> wake up tty when hp->n_outbuf is 0 in hvc_push().
>
> When we receive a key input character, the interrupt handling function
> hvc_handle_interrupt() will be executed, and the echo thread
> flush_to_ldisc() will be added to the queue.
>
> If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
> enters kernel and waits for hp->n_outbuf to become 0 via
> tty_wait_until_sent(). If the echo thread finishes executing before
> reaching tty_wait_until_sent (for example, put_chars() takes too long),
> it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
> tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
> this round&apos;s tty_poll). Unless the next key input character comes,
> hvc_poll will be executed, and tty_wakeup() will be performed through
> the do_wakeup flag.
>
> Signed-off-by: Li Hao
Did checkpatch say this was ok?

