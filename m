Return-Path: <linux-kernel+bounces-86626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BC186C802
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F99EB23853
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA97B3E9;
	Thu, 29 Feb 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XunhVmMw"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712C7AE62
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205842; cv=none; b=Jb3cCuJyBRo5aI7kPmVsIxc5dYY0gAdbU35WpN9yXrRJbwqSFE3copTPMFmDKQIiT4EwjbscvG8PeMbs5tjIUmkNnhMuc6frD6d/lZMVgD7HegCSLHE/xilUEABTaUSAn04OGjosToVtzncrl4Q0JuK354YoWYJwzjz6vWlP2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205842; c=relaxed/simple;
	bh=Lw43WVRfx/Ig61s0twf8oAgY2tROhrU+dPuL5u7K74Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RRg68zbNWyVSTqWwllycv5cbTCPQMdfeacfX7cE7n/hvT2Kzj5vtycXzc1QElvhmiRWrJc1EVRt1Kj6CCk+pFBNsYNNamtaU6oZWyVTCkB14iW8o4nyBDQlU4EP9u7eh7+Pewxub4DAOP+i5CZPM7F7RthWerSc7L2pdvS4wIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XunhVmMw; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709205531; bh=dDkhUtUenMCvjbf5QUmcPYlkJERal+L3GzpBUKTc2uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XunhVmMwf7eEPDUYangGh0LnZ8BqrOC3/5rIlnmCQUkqnfr4gcMUyLWk7YvZaraWs
	 J3mcreyag9XVNwAECy3DMeGsMxpJfBW2UfMm4FM06LKj1O/RRNaAtkRjNlYUNHiB69
	 Tpi1t0wp1gfadal4tCw60jt13XwR/TUPjn6FY8dk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 4B123E98; Thu, 29 Feb 2024 19:18:49 +0800
X-QQ-mid: xmsmtpt1709205529t8co6ro2f
Message-ID: <tencent_66D84A6C740977ED66023CCD3716963E3709@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwjfAHDpPnwVSIrfaeba6ENSnlwGC5Yxfl8HdhHBJHAUPff5hd51
	 S3WsBEZb1c9z3+QyyNlIqTrciirIec3NWFiJDELpIhdqN1+2L6JxL9+kDzkRct8PUNyYEyvcU0+D
	 wg1i9NzQSqYB+62H6x0+slN3X5yX4pfabf7PYGrSFGGbStQRyqzs8Q5zlfGLHng3+MZ43WdIVXtL
	 SdXuppBRWaChyn0NUkbGEJOmO0xh4F+DocseT1AotRhumcKZ3nm80TWOvXWugGwYJ0KzM5YpgVQt
	 Yu3ckFEdPGcbjx/HC3lKxaBRtvlJKFGDxeyBzeWdIy0+9KyhvhRigqJZe8wyvCeb6UVOxQFwS1gR
	 YC7+UT2VYjuwDmXhWmXZTn2691C6ZGvJNS2yZj9wdny2vyfQE349lTGGWO2uLTIXatfKe8C+lPxJ
	 WEz62+Uyt3YTgANkMB+l5COq3FJoSGp3VUDf7X3YfINcwWeF9NnNmy+UhZcajugvgQqldpqTLi+U
	 oH9/Gdvy/GuscMGRhBRLk2jkLHdpf4KjfS15baahNXPN0KbuuoiEsBFPlG0L6f8Rt55LLmFivLBD
	 FlUAERvph30mo0R1QDBcmb3PYjuUUOJ12HenGIsHbpaGL5qQImUcI7ZisZBLCZrdVW+cSTfODiJ9
	 uJVqHjB7/nHrikq+N1qYaET+e8IU0GDyUou6o8QJpEJQWPdcUuOzOBm7izg5+CtYuVN4MSmUWof5
	 CkCSmmV1+s6i20fYBvWNljlOP3HIKUVG5BhxLfnc3NC2TRE0UFTfnqa7qQC+tjNDsTwr3o1kMxPv
	 ilnBHYNJW1QMDLTYJiW18IP3eELX5El78ejUxs73zFAHpxXs1dGmSi+z/cSdB7QV43q7RoBD4mv7
	 xBahOuzdaimDO3TpIXIRrW6gpUeMX2ujGjPF9wL9ssQvz+0GZeyn5NRtdKYYw2b+altPacgAj5
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2622b51b35f91a00ea18@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] [usb?] INFO: task hung in vb2_video_unregister_device
Date: Thu, 29 Feb 2024 19:18:50 +0800
X-OQ-MSGID: <20240229111849.917736-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008faf0a06126a0ffb@google.com>
References: <0000000000008faf0a06126a0ffb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in vb2_video_unregister_device

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 62a583040cd4..b55f432b44d4 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -963,7 +963,6 @@ int usbtv_video_init(struct usbtv *usbtv)
 
 void usbtv_video_free(struct usbtv *usbtv)
 {
-	mutex_lock(&usbtv->vb2q_lock);
 	mutex_lock(&usbtv->v4l2_lock);
 
 	usbtv_stop(usbtv);
@@ -971,7 +970,6 @@ void usbtv_video_free(struct usbtv *usbtv)
 	v4l2_device_disconnect(&usbtv->v4l2_dev);
 
 	mutex_unlock(&usbtv->v4l2_lock);
-	mutex_unlock(&usbtv->vb2q_lock);
 
 	v4l2_device_put(&usbtv->v4l2_dev);
 }


