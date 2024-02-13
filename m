Return-Path: <linux-kernel+bounces-63585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE618531D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4A428C0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B707855E7F;
	Tue, 13 Feb 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VvjfIvXG"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8955C1B;
	Tue, 13 Feb 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830751; cv=none; b=jF+ulyGFLMFI3LCGxRzC55TM3WRK0prjb2TM55lhV9D54moxvoCZwSvvB9X8/VVrj/URtJ11shOweVCFC5hP3V/9CKEooe/lt9KvHcZPUyZcZLW21GoEuoHL56jhmNDsJLNyETL5XGYv1qp2Z+nVC3u6p76Bsbt+FIkQqSbmYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830751; c=relaxed/simple;
	bh=o4q4idFOXlWoDV6VuRp7cNsxTYa7LjVZ6+fjE1ReYlo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ao626MKyqKd/bdFuXGCEtbhhP0Grk3A05j+gWjWMq9gpgyFZ1Sj3Z/+Za1LZ8tFQ7xub6qhO42OZ1t8vfm2UHKQ+3c/mGFVCSYSLLvqXEJL17Qaw3O6D1O+ZEMf2d2r4M0ZsARiUShktBpr1PC6Z26NrOCV+GFjdU3T2UDySbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VvjfIvXG; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707830740; bh=MgUZi6LLrZeC+JPb5EJtPgxLkCCIcv7DZEbn4x65e+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvjfIvXG89COCRomNIkpBIN7CP5zxx0C7aL6vggQXke8zS6iB43tnGQLQMxPAGW4g
	 2FkOysXh7AsICIpZRcgKAL6v2ndBbrqkww+u5H1UJLtdXIaxhwYT094/TClbLwmjl6
	 zzcifi/g08RGNmktr5eo+TOKlUkTdSxpBMBEagRo=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 344892C4; Tue, 13 Feb 2024 21:13:04 +0800
X-QQ-mid: xmsmtpt1707829984t7r71a128
Message-ID: <tencent_F11E964436F04BE4744377FD66903C7F3609@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvT29HpA7oOavs3KYUqRQrL4l3ZYkfpOOWNr69vyyOb+VXfbAUqKO
	 rtw1lIPHA96UA0W/zA5GYWQX8bySal4FU/u8hcW+sUUwtljwfLPjV4P8eFhiZWHYHGgHN6SApzjF
	 XJFYRgE5BaxCvkHF4xvtco6kTjmqlqSI6MKOUAWoml4QqrG/dc96oV1nrl37skT4qmEuMvRR7WGk
	 yfhd/gweogb7JM8AXfVRmUBZ6M6pSJQNUU26qZlFwSXMtHNbAL+FXA2YaFlnc03YtqWZyanEfS0N
	 04VsnOX80Uc9CWtL08CdhmlwQWUpvuEraji8NY9W1nMvPRrj/LULuW2SFYFqT+7iS6UIndVEaKz3
	 ls+4bNy5c8uWGd+HzwHEfKdASQp3J32pV4tdMRIfyQ1qfLIfhKopBYuT9xV+xkXMnOl90w76zpXZ
	 JlytCwI87m6ME8df/M75PRMwhq3bEMuDt1sotktzsV9Zn4no5ee3sjUkGS6u9dsc7Pd8vyClk4pq
	 t+WdwvJXRQJaDT64Sv3kgdtRNawLGI2/2sRAq6Uu/vGt28PO6EP7V+XBflyZ0tyhhzZTZUCQhVtr
	 W43WXo9dlqT43aP6/sc56MHS8flU8TUKUCA2fPim9e1x7fwLjP/xAb9efqCUw9s6DsRq2X31/tob
	 MD/0DRN/j7OlIVC20TLntk6FtQ+LA8bmjUu/p4lQ5S0j/FB4lB+fs6kwAWt1xL95z9fwnIDUga9X
	 PSN+rfWxDQMZF20GBEMPUAIt5iYlNeciR77S3JHHM366ZgV0BovIghJsjQgT4bai+fnpBM7Vccuz
	 sHn0a4ZRhZHyvPBOEAbmZ2NeTRtx9TDMMOv51ZL65xs5W3NRvJYtmU9VEILyNwxlL3fqa9b/cIar
	 /lzmQtDGzL8ZvDZKKuTc4NE1aPXN/Uy+67ggB9k30UKRK1nNbT7ZF9Bz9TY7zpUumgaYKC8y767w
	 1bpy5aE9kfBZ12yOObmq6pJLsmCXH4eo3qF7yQEVw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Date: Tue, 13 Feb 2024 21:13:05 +0800
X-OQ-MSGID: <20240213131304.1141134-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021356-unveiling-falcon-54db@gregkh>
References: <2024021356-unveiling-falcon-54db@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 08:21:18 +0100, Greg KH wrote:
> On Tue, Feb 13, 2024 at 08:50:01AM +0800, Edward Adam Davis wrote:
> > On Thu, 8 Feb 2024 12:25:35 +0000, Greg KH wrote:
> > > On Thu, Feb 08, 2024 at 07:37:56PM +0800, Edward Adam Davis wrote:
> > > > On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > > > > > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > > > > > of data to env, which will result in insufficient memory allocated to the buf
> > > > > > members of env.
> > > > >
> > > > > What is "env"?  And can you wrap your lines at 72 columns please?
> > > > env is an instance of struct kobj_uevent_env.
> > >
> > > Also, why is "risc64" in the subject line?
> > Because when syzbot reported this issue, it wrote "userspace arch: riscv64".
> > However, I actually tested it on the master branch of upstream.
> 
> Then of course, this was not correct in the subject line.
Got it.

thanks,
edward.


