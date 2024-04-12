Return-Path: <linux-kernel+bounces-142175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CA8A2877
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACADEB212D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F724CE13;
	Fri, 12 Apr 2024 07:48:23 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FA482DA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908102; cv=none; b=KceSNnhkrgXEmt204gzgp/9MB8HyQlA/WfQOuMKo31J8Ek75qwsyJmzOT1yxJZlcmTIyb21y/siw5uTHiIw27yGFcb8jBfNnNSlS9NfDio16351UrtEZAt/zsTKLHL+Sl7VzjUGAEhkbJVc1bAdOGzIx4AvWLcdY9N6BPLDO0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908102; c=relaxed/simple;
	bh=B1uQVK0k0DZBtuOYjQrE7vq5W6eOZW3yvRW1Nld4Vsg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=XdnN4I9q5LASUZCznIQ8MPrC6vfImzRsuGiiUJ6SMVuNXz/vxH2L4sLrVAB/rPLPE+6g/a6BvwY4u3io3ccVLrJGi1lJAsN8fK8gMf7puLOUt7dsy8PBPhMzYnid9pO2N4XWY9gEJL4cguZhZPtoKsrzVNOWD4kA7F+E8LbC2/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VG7wL0YBBz8XrRK;
	Fri, 12 Apr 2024 15:48:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 43C7m3bH093870;
	Fri, 12 Apr 2024 15:48:03 +0800 (+08)
	(envelope-from li.hao40@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 12 Apr 2024 15:48:06 +0800 (CST)
Date: Fri, 12 Apr 2024 15:48:06 +0800 (CST)
X-Zmail-TransId: 2af96618e73623d-204a2
X-Mailer: Zmail v1.0
Message-ID: <20240412154806397beb4yGovKASnUXpyoxUJu@zte.com.cn>
In-Reply-To: <75dff5cd-7b0e-4039-9157-8bf10cf7ba29@kernel.org>
References: 20240412113848167egmP7kBg1Qm5sxfwGALG-@zte.com.cn,75dff5cd-7b0e-4039-9157-8bf10cf7ba29@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <li.hao40@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0hdIHR0eTogaHZjOiB3YWtldXAgaHZjIGNvbnNvbGUgaW1tZWRpYXRlbHkgd2hlbiBuZWVkZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 43C7m3bH093870
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6618E742.000/4VG7wL0YBBz8XrRK

> On 12. 04. 24, 5:38, li.hao40@zte.com.cn wrote:
> > From: Li Hao <li.hao40@zte.com.cn>
> > 
> > Cancel the do_wakeup flag in hvc_struct, and change it to immediately
> > wake up tty when hp->n_outbuf is 0 in hvc_push().
> > 
> > When we receive a key input character, the interrupt handling function
> > hvc_handle_interrupt() will be executed, and the echo thread
> > flush_to_ldisc() will be added to the queue.
> > 
> > If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
> > enters kernel and waits for hp->n_outbuf to become 0 via
> > tty_wait_until_sent(). If the echo thread finishes executing before
> > reaching tty_wait_until_sent (for example, put_chars() takes too long),
> > it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
> > tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
> > this round's tty_poll). Unless the next key input character comes,
> > hvc_poll will be executed, and tty_wakeup() will be performed through
> > the do_wakeup flag.
> > 
> > Signed-off-by: Li Hao <li.hao40@zte.com.cn>
> > ---
> >   drivers/tty/hvc/hvc_console.c | 12 +++++-------
> >   drivers/tty/hvc/hvc_console.h |  1 -
> >   2 files changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> > index cd1f657f7..2fa90d938 100644
> > --- a/drivers/tty/hvc/hvc_console.c
> > +++ b/drivers/tty/hvc/hvc_console.c
> > @@ -476,11 +476,13 @@ static void hvc_hangup(struct tty_struct *tty)
> >   static int hvc_push(struct hvc_struct *hp)
> >   {
> >       int n;
> > +    struct tty_struct *tty;
> > 
> >       n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
> > +    tty = tty_port_tty_get(&hp->port);
> >       if (n <= 0) {
> >           if (n == 0 || n == -EAGAIN) {
> > -            hp->do_wakeup = 1;
> > +            tty_wakeup(tty);
> 
> What if tty is NULL? Did you intent to use tty_port_tty_wakeup() instead?
> 
> thanks,
> -- 
> js
> suse labs

Thank you for your prompt reply.
tty_port_tty_wakeup() is better, it no longer check if tty is NULL in hvc_push()

Li Hao

