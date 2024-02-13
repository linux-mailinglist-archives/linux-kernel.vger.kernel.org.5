Return-Path: <linux-kernel+bounces-62770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F8852581
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E31CB2709F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6D1775F;
	Tue, 13 Feb 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TMfT4LRP"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E41772F;
	Tue, 13 Feb 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785019; cv=none; b=R+h8ppM4AR/1zWpqkeSRUUmlz+onjUNRIe6S1EudutJ/VxFXVNpgH62XJpQXUlU0GfKmalwndlHs9STjU6W2iT79GxH6jdjldG60In4BBprWnGmYvhywjDs/ZMKcPD2dR99AgVTv0T9NwMotkKITs6cAiWJ8I0mRDhLVNEC8pEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785019; c=relaxed/simple;
	bh=F7fpg2CdE0Wy2uPhD166DyADD4Ox3yGxvUgrFRhaQS8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5Mz0531/1v1HC617XetLO88zrAY5Q+f1InNgkBV2uFY2FCrwlLHjXS97p25hE8FaPegnOfdctFNlap5ZagJaSUg0QS/wDXiUwjM1w6cqEC0uWvaCE9GPMJMm9G5XegK1u+x7LdPv1RZkroIu1oulIEmjLfMNhxYipIiYl8shUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TMfT4LRP; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707785014; bh=wiPSfuRqZnFsMPwUv5OCFPjP7dEarDAicP/Tc9X1eiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMfT4LRP723MraUT+zeDVSZmPCpoKYyto74wxMY2nFnrpqhhEQgxK7tfeE7O1GJnD
	 SgikGKDTcTTB96Ekq7ISnRe8WMn0EiDzRWHFA4vDc/zsRD3M4dB4MGlI3o/IiTcyQB
	 l5JzBb0SONSLqHxuGqPi6Ilzu1IJU4deYTO2hUB4=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id ADEAEAC9; Tue, 13 Feb 2024 08:43:30 +0800
X-QQ-mid: xmsmtpt1707785010tdv1gnwzi
Message-ID: <tencent_DDCFB377C3642974A3A3A44D176B776DA605@qq.com>
X-QQ-XMAILINFO: NYqi3QrBgYD/lt5S161oxaFNxO1cjhRBqMoSxSpD2ZO9EBHtwOA/GjZsHF+gY7
	 cFEyXy2Qj/MoXLpeC8VlNIVt39aTWzMEiOq/QRE9PW4znfioaIQ1fRfAsoeOn7ZpSdlm0/XCS6Zk
	 QnA3kE1+sfeAk/yXaqpZdRtMJJJlzItwLkllhn0Xt5DhSXJGhZ5Ok64Gl22GTKqDVGWkREiFd7eK
	 nbYtLBEQMqdDzUMUOquukGX9FTwNsE9rSrtyvCbWrMWHGxlTDhAZV51AOCIMVVTnmXSgNaBxivdE
	 CUCHHlKK+YeTddMabu/P36lsmD0sKgXykDSblxU5xdornsoLVB6jqeAuTGIHJtxAKui8bSiWJQTC
	 72xExYCgnDSYK5q6JAQdhWRqayqmz+TJ2cuNEaldM+2wIBFzUn+GvyqnhnMv6FIhc550Bpm4vRS1
	 rkGlkogIeqRa5G7RGCfIU3UoamLK0I1OTUb5O9g5FhDdFpJldEbfZ6Et2iwK+wing6q1pQGWY2aU
	 DMQo0qOg5sX6NeQ/viAe5ovP0cAdKo3eS6TR4WYvrx68BtWZdPIrl31u//aMnHkj68erRTClxocv
	 cVvOSauFMtZ7jyG0ExBl9qo7jVjunKk7f6OdIFoi1CTlmCwi2EopoTBk45OOR59lg1ingdDARITL
	 yIvJ6rMSV45kMqyc10SXWDIdSK3VT0DKAkYLOo2ytLXkiq2CyBkQQNtvnB39JuV7vY1yYwa15gDV
	 6nwpqEO0UflBlZodEh4Q0B3DlR55DuiOcuNlvOP8f4aar4UH1D/vhT79RoIys60Vlvmd8PRs/z4i
	 HtMxIzUg4evzAsAX5xE1XojmI6E06Nt3aVVh7Kt9GlcKsJ0BOIX4mB91p2Mx1kNn4heT/73uXeDq
	 vSKQM+oCsh06zS7rrM1gGiggB9mq7GpY7U5SYJ3uiKVYoTFifJSYiNinGGp4Dn7w594hubAIJD
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Date: Tue, 13 Feb 2024 08:43:26 +0800
X-OQ-MSGID: <20240213004330.285237-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024020836-flypaper-relapse-5c97@gregkh>
References: <2024020836-flypaper-relapse-5c97@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 12:25:10 +0000, Greg KH wrote:
> On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > members of env.
> > >
> > > What is "env"?  And can you wrap your lines at 72 columns please?
> > env is an instance of struct kobj_uevent_env.
> 
> Ok, be specific please in your changelog text, otherwise we can't really
> understand what is happening.
> 
> > > > Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > >  include/linux/kobject.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > > > index c30affcc43b4..74b37b6459cd 100644
> > > > --- a/include/linux/kobject.h
> > > > +++ b/include/linux/kobject.h
> > > > @@ -30,7 +30,7 @@
> > > >
> > > >  #define UEVENT_HELPER_PATH_LEN		256
> > > >  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> > > > -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> > > > +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
> > >
> > > That's an odd number, why that?  Why not just a page?  What happens if
> > > some other path wants more?
> > An increase of 512 bytes is sufficient for the current issue. Do not consider
> > the problem of hypothetical existence.
> 
> Why is this 512 bytes sufficient now?  What changed to cause this?
There is the following code in input_print_modalias():

drivers/input/input.c
   1         len += input_print_modalias_bits(buf + len, size - len,
1403                                 'k', id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
This code will add up to 2608 bytes of data to env at most.
(KEY_MAX - KEY_MIN_INTERESTING) * 4 = (256 * 3 - 1 - 113 ) * 4 = (765 - 113) * 4 = 652 * 4 = 2608 bytes。
Note: In the expression, 4 represents 3 bytes of hexadecimal data and 1 byte of comma.

include/uapi/linux/input-event-codes.h
188 #define KEY_MUTE                113
807 #define KEY_MIN_INTERESTING     KEY_MUTE
808 #define KEY_MAX                 0x2ff
During my actual testing process, I found that a total of 1684 bytes were
contributed in input_print_modalias().
> 
> And how can we detect this automatically in the future?  Shouldn't we
> just be truncating the buffer instead of having an overflow?
> 
> > > And what's causing the input stack to have so many variables all of a
> > > sudden, what changed to cause this?  Is this a bugfix for a specific
> > > commit that needs to be backported to older kernels?  Why did this
> > > buffer size all of a sudden be too small?
> > The result of my analysis is that several members of struct input_dev are too
> > large, such as its member keybit.
> 
> And when did that change?  What commit id?  What prevents it from
> growing again and us needing to change this again?
The code that caused this issue has been introduced for a long time, and it is
speculated that it was due to the fact that the warning in add_uevent_var() was
returned directly to ENOMEM without being taken seriously.

lib/kobject_uevent.c
  2         if (len >= (sizeof(env->buf) - env->buflen)) { 
  1                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
672                 return -ENOMEM;                                                                                                                                                                        
  1         }

I believe that this issue was introduced by:
7eff2e7a8b65 - Driver core: change add_ueventvar to use a struct.

thanks,
edward.


