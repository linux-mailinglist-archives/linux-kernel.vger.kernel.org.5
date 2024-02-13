Return-Path: <linux-kernel+bounces-62827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F0852693
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5FB1C233EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD464627F2;
	Tue, 13 Feb 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zqg7XtTK"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5218B60255;
	Tue, 13 Feb 2024 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785718; cv=none; b=PrJ2ERIcTPgEkxoe7UenscbhN0+NNVMNF/ur+euJjtVuZlvssTN2wQg0wx9mVkFO5cEHB8SDXyPQdgCErwtLtzbL61URB9thHepHjIg5oI5PgvmqboqMf1JolS+XwfPMItcW3NcvHnHb7YUdm+8nzsYqK9sc7gNniOmC/teS5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785718; c=relaxed/simple;
	bh=2puoh82NlL7KgPajwOKr+RoT+y7OyuLuade3sdrbDg8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DCcdheM29r8jkWUFXax95gvDWN5i7vXfY60d7si3fXHZPLu2rukUPiAaaUhIa8lIyeK06SuCBI5kayE32Hta7Tds5Krt1UNvroi9lVxlvTH0GJborl4yeOOMrIoklcMH6e8/NfnIUlVr1cL2jG60jTNcArYRqT/BNQWHFJ4ctFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zqg7XtTK; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707785404; bh=0qDgLx5aQ2V4NWIxvN8S5gR/fmOBA2ONJsoUoqof8Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zqg7XtTKxpn7J1EBghb2yG2AceY9RHLJLb501V+cgoyuIRLjm6Qw4xPmANaw8/EVp
	 oMQjiC3z3u6psEpY/mbtDsozBxW3k7WgEF1yzJGJ/VzTpQ96JmbtPdf3QVueVJ4ZFH
	 Xh+fOS9QgQTfMDp7584aQQpqiBRa4TaqwIfKpekE=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id C8128AF5; Tue, 13 Feb 2024 08:50:01 +0800
X-QQ-mid: xmsmtpt1707785401tagud59b2
Message-ID: <tencent_9D9878866FF42C756D2C94DCEA36EC26CE0A@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/zfzQDSy+gE7tbtK5LFsNIopNlDffVWhTZ6+IQ3sUA9dXd5CznS
	 aqZHlhLaCglfakmfRepcF5fTYsXrABkghzNMGJa+p5dNPvtAoAhJdhYY1hJ0A6r7wbfOtHq+EmOH
	 ZV8RayrkepS9CFQ6HP8fRpRQirJ/IRb/2aD/QROyqv+Y0+tRCR3at3lpQyFBm+vkoyFchRup96di
	 MHyDGSp8fk42G01Yj4HrLB0CeV4foYN0wK+/V0plHLCKjbXgzibR3CjmPcK1mnjYRATpRajBlrNf
	 GqzSL1TcA4KojR7vu9t1fj+W0Tjv7UPNpEOqEdGEJANGcMKv83K0H2yfuCovU0zH3zG6voS3rhBf
	 UQW2pxglFM9SYE1xowuCUbHqSaR9+wovz2Yzo8kvwkKt6csLcv3JDB9Od+KUuhEwFY6T7biuE7Is
	 cX2z+nWjRXgWGRVuUKaNIyDRr1KxU8Jwx8/zAUqGS/gZUWqOLF4kzVo8jy2UUtD7tsx1cDNtqdv7
	 rXklwrQBUNeUKG2LfK9defmTEdddVMPnFZ2DQyKG2DQqVjBibEGiKtR+9kW402CwE4JFmoaPircA
	 LPCjKcoT+lPLaxjA/eAmMKajv8KZjNNFPiIURR4ag6h8do4IRaQ1Fq02mKu/t77EA1Duxk7VL0SU
	 YY2qCI046VWi/9n/9m26wAebm/I5iRHdpZM/34+t1Qr9eSy1iuJcR/Yb2CZ4HeMxOncnh9wUPwsG
	 mqqk/oZh00wpruBBsvnMqEjBtiZ7lfyC/PcdWhhGJGVN+Ss98a1/OoQYNlXnnfs0iUvxVVUQIyy0
	 xyeu5TQu0svzYv26fqGYVyW5GWgfMwWIJUNQesZCvBTQ/LJqzwKqR22ps5aQW5EklC6X0K+pasSy
	 M81TtS+xoANRKp9/gXeBz0xX6enrbeVake3NOP/p4RKCgHevb70Zo87NDuSE+0eQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Date: Tue, 13 Feb 2024 08:50:01 +0800
X-OQ-MSGID: <20240213005000.290327-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024020821-quintet-survival-54f4@gregkh>
References: <2024020821-quintet-survival-54f4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 12:25:35 +0000, Greg KH wrote:
> On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > members of env.
> > >
> > > What is "env"?  And can you wrap your lines at 72 columns please?
> > env is an instance of struct kobj_uevent_env.
> 
> Also, why is "risc64" in the subject line?
Because when syzbot reported this issue, it wrote "userspace arch: riscv64".
However, I actually tested it on the master branch of upstream.

thanks,
edward.


