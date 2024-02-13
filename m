Return-Path: <linux-kernel+bounces-63571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BB85318A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEA528B5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129755799;
	Tue, 13 Feb 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="inDrKRFm"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBE29CE4;
	Tue, 13 Feb 2024 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830154; cv=none; b=JWsSs/misDe5Sz+VTXn0zy3EENilIlZKzmZBwa5YKBV2Z0sUcVqJAeu1/61yNCw+/X1kKEl+B3KeCRqvp+oS1dR3N9s0hO3kl81s2QYG4gth6psq2edcPY7zqZBOoHKxw3sZNvuMFJzdhzfRD5GUPifMLVO7Q0uqlbMXHCqcbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830154; c=relaxed/simple;
	bh=gxpXc33c0/tivVgSIAJHqg/XR8543C4zbAojXjlXODA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka8ev9oXOYnrYPw8MZ4theyBZaejlPUy/tJ5YTcIW8kgQTF81Ed2lXTh7IXJ3LG5EOfPU5FLrXhX66/wyLfNT0Vu2z8OS6O5dor4HSTtrFwlcbkAlms9UCawCkaW7LV7FYPeELOOauzGxnxrIAgCiwpj3S+Mu7NIy6E1HroHhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=inDrKRFm; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707829841; bh=bkKyuqkAwr4sG3hZNQo0E5KcA8LMWQh9y91i0CS2DG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=inDrKRFmll8R+yYYY0ftDPrWIm0WucaYoqI0Ga56vMTs+tUBXBYsSF85WhFWWujeI
	 E3zyBYj+dlqwtryJCF18OLKniYpapYhRjQz1hCN6ahKl6bZlyhf+LUtV2Q29nOGYtp
	 eLoDTEn7wjQR+fo/10kRVQZDoJD0XSDKbwKVZQLc=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 2A63AECA; Tue, 13 Feb 2024 21:10:38 +0800
X-QQ-mid: xmsmtpt1707829838toask8lu6
Message-ID: <tencent_1755B769F77446DC1379E362296083BF0405@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69/VRWICJG/HVsVWgnLmPvroYF2fGmjhVx6dncrzPuT8+LDaDWSs
	 3n0h1nb2CVwyaCRYXwDloJFxK+8Mbd9TPKtbImqRzbFpZoInlh6STMyEm7Sd4yj6MhWH8pZZwNnv
	 8klZ6hpx70GfD4pokKZAsMqMVYJLS8NVLRsfSTpOZDH6SMmXWzPZ2PFkbE91gj+w4WTQ7P2suhb5
	 Ao30tj7jq5yjlUrJOxcwr7bUk7Sem7Ed8fkQ6pBlasdVI9igCitZuHRIB0AcRItpFFsOzwUD8FFG
	 PwbjzkFVHNt7JQ4YWCBg6ov5YOtlPMmw93bBHpm5O2KtaJbtpwxNC9l1VfqcMzzq/cFS71Jv1fnc
	 axXopahYqGGDcxPnx19xiGNVqevMUH80A5wIk9BF0U7nbV5lyNQxcvlOXBT1vdONXL9vifncrpKA
	 euauM5LGJEHnvz8u6D4MahEdC2ypHGbxftRehTROvY4aNXhyqBbLiXwKVbFAboU8+QoHMy+616+1
	 3NOue9/H6uZsurf/4LlUWKwTPUJizdfhD0Z/Z43hotake0W6RDdbtrIEjiGCrKvN2uqozDnx74dp
	 05kf12F0gMlLe9NQgH1NEcFaqu8owAzNTvK7xAw18jWkd3BxTo8MLQ3j6klN+YrOVgC/bEE1cJbz
	 bjZYJlpKZ5TQDLOCynsMfNDEofJWscVn1Rum+wvQ3uoA+fTY4K+xPtEtpTluvL2OsqJxa6v5LC5P
	 INN2bsw7o6PEYQ2PLd3JOZ6Hw3zsh7p7JkmhbjdEYqG+AjHl8zRSfXk338snhCstuLa1ZPiPZfe0
	 YVZmeAET7/D3uU7qDogfok5j7c1QAwKQm8pIT+Sh51vgayXpSs7V/ODhSl5CBGhEQ2AudKzpI6HM
	 hSQEIlcEoWUAhVZr+8Gqj+9bewIvmRHRhTs7caF7WKKYeuF4mWsJlaa/S6GptoRhOZbaPL1YcqRz
	 jx1YxZdqA=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rafael@kernel.org,
	syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH riscv64] kobject: fix WARNING in input_register_device
Date: Tue, 13 Feb 2024 21:10:37 +0800
X-OQ-MSGID: <20240213131037.1139171-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021316-nuclei-botany-5446@gregkh>
References: <2024021316-nuclei-botany-5446@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 08:20:52 +0100, Greg KH wrote:
> On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> On Tue, Feb 13, 2024 at 08:43:26AM +0800, Edward Adam Davis wrote:
> > On Thu, 8 Feb 2024 12:25:10 +0000, Greg KH wrote:
> > > On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > > > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > > > members of env.
> > > > >
> > > > > What is "env"?  And can you wrap your lines at 72 columns please?
> > > > env is an instance of struct kobj_uevent_env.
> > >
> > > Ok, be specific please in your changelog text, otherwise we can't really
> > > understand what is happening.
> > >
> > > > > > Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > > ---
> > > > > >  include/linux/kobject.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > > > > > index c30affcc43b4..74b37b6459cd 100644
> > > > > > --- a/include/linux/kobject.h
> > > > > > +++ b/include/linux/kobject.h
> > > > > > @@ -30,7 +30,7 @@
> > > > > >
> > > > > >  #define UEVENT_HELPER_PATH_LEN		256
> > > > > >  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> > > > > > -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> > > > > > +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
> > > > >
> > > > > That's an odd number, why that?  Why not just a page?  What happens if
> > > > > some other path wants more?
> > > > An increase of 512 bytes is sufficient for the current issue. Do not consider
> > > > the problem of hypothetical existence.
> > >
> > > Why is this 512 bytes sufficient now?  What changed to cause this?
> > There is the following code in input_print_modalias():
> >
> > drivers/input/input.c
> >    1         len += input_print_modalias_bits(buf + len, size - len,
> > 1403                                 'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
> > This code will add up to 2608 bytes of data to env at most.
> > (KEY_MAX - KEY_MIN_INTERESTING) * 4 = (256 * 3 - 1 - 113 ) * 4 = (765 - 113) * 4 = 652 * 4 = 2608 bytes。
> > Note: In the expression, 4 represents 3 bytes of hexadecimal data and 1 byte of comma.
> 
> So your change above is wrong and will not work for the max size?
Yes.
> 
> Why not restrict the modalias here to fit instead of overflowing?  Odds
> are we should be checking this properly no matter what the value is
> changed to, right?
Right.
It may be necessary to deepen our understanding of this piece of code before
fixing this issue internally.
> 
> > include/uapi/linux/input-event-codes.h
> > 188 #define KEY_MUTE                113
> > 807 #define KEY_MIN_INTERESTING     KEY_MUTE
> > 808 #define KEY_MAX                 0x2ff
> > During my actual testing process, I found that a total of 1684 bytes were
> > contributed in input_print_modalias().
> > >
> > > And how can we detect this automatically in the future?  Shouldn't we
> > > just be truncating the buffer instead of having an overflow?
> > >
> > > > > And what's causing the input stack to have so many variables all of a
> > > > > sudden, what changed to cause this?  Is this a bugfix for a specific
> > > > > commit that needs to be backported to older kernels?  Why did this
> > > > > buffer size all of a sudden be too small?
> > > > The result of my analysis is that several members of struct input_dev are too
> > > > large, such as its member keybit.
> > >
> > > And when did that change?  What commit id?  What prevents it from
> > > growing again and us needing to change this again?
> > The code that caused this issue has been introduced for a long time, and it is
> > speculated that it was due to the fact that the warning in add_uevent_var() was
> > returned directly to ENOMEM without being taken seriously.
> >
> > lib/kobject_uevent.c
> >   2         if (len >= (sizeof(env->buf) - env->buflen)) {
> >   1                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
> > 672                 return -ENOMEM;
> 
> Odd line numbers?
> 
> Anyway, we should get rid of the WARN() as that will cause crashes, and
> just handle it properly there.
> 
> 
> >   1         }
> >
> > I believe that this issue was introduced by:
> > 7eff2e7a8b65 - Driver core: change add_ueventvar to use a struct.
> 
> In 2007?  And never been actually hit since then?  So is this a real
> issue? :)
Yes. But as I mentioned earlier, in add_uevent_var(), it will exit directly after
a warning, so this issue has not been given enough attention, perhaps it has
happened many times.

thanks,
edward.


