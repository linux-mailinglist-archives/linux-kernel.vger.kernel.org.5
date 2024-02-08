Return-Path: <linux-kernel+bounces-57990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998784E009
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC082B288CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BADC6F535;
	Thu,  8 Feb 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HMIe6CKV"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007C6F07B;
	Thu,  8 Feb 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392950; cv=none; b=tcG6Mfd19o+adxGVzfy01zRXAs5O6wXRBxM3P/cbwx1noJTxx5MkIeP0KFl6v8ZWnNBqazi9SPUX/vVyhFbiXr1XaA1zRleOuEUb6Wcmvqtt6Z+PqfMxiRyUk3jUogX/4rr9KYc9SvpK2uvG+2pCk9U/Y3SNlJlAUuv51yAb1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392950; c=relaxed/simple;
	bh=VuFwjgSAbf+dr0FZrqLBZ8yK5NB/XhAxZze2d60h6ws=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HVaYj14HdG2hvnh0KDzvPMgOOtDIMPZb4vpuy3I9+nJRjunKktY3AlCAYPXN3jJcgTyAhnkfHAkJfoUshFGjIHD/dg5+a+BVMgVZutgSVlNPF62xloTQglVf4FU0v0Q3jAXbFdN/OGAKd050+Bsa+ArQw0IGzbqYZCyXGg7QZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HMIe6CKV; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707392641; bh=Gkj5XFeU5b5pKCS25vXKF7CydQoxzA6b2Os6pGuw5Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMIe6CKVRTJFkAoJR4uS2SoRNp+RkimsKjFcTZjXA5YWcDtmPJOL+ryGCM60DM6eZ
	 d+eR5hadbScbVTxNtVQNHYHxsWsKOLzMwmeDpKhEFVCQ27a29z+2+Qz9IBL4yC2mTf
	 fEcO3/PHclIPb7TIotJKC2aYEopgaRZNrotSAuWc=
Received: from pek-lxu-l1.wrs.com ([117.61.184.234])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 97824E67; Thu, 08 Feb 2024 19:37:56 +0800
X-QQ-mid: xmsmtpt1707392276twmcn2erk
Message-ID: <tencent_6C6ACF8878B26D482FE56F649498E90EEF0A@qq.com>
X-QQ-XMAILINFO: MtZ4zLDUQmWf9rinpoXhvRYK7PO+Za+NxaIR9gDee9WMiJAZEi0XVP7WEfXTLA
	 Uw5RLxWmvr6RKJf1GgzJs5fXQ3jd5bu1DXhz1t5zFhaWnet+M3E5SY5GLGPrxH6o4SwBj4Ab+3TG
	 6lwFcnxMldQqH7hzXw4MN3cezqfS1/EBNvjVJtch9frYYV4GA57uhOwo/jSiwo/M9PHbIffHicpz
	 buzwCJXliSscL8s6bZGXwzXfDYmtH3z/ijHAnz2c8XD4j4D0k1ahZXYNjPq1c5N0VRbrZV/6vwqL
	 OHBzDVCrSJQGke/+FJS+NvZCKoOQfKy98p5G720ByOmVvQxpb4tdmnCMZKhV2EeW/TBerFutdwAK
	 dwddubXl1P22ggsFR3VZoAP5kd4/D6cXp5yIuuSaXdsu50LAEUDOCwqVp1wsz0eUG2yvnF/k6R0Y
	 Ay5OVk0ehvAdP/osx9aqpPOjAfv04zHtODj7FLQi+d2CcHz7sk+KqsVXw7eUQXXymb6gEu9JQ6tX
	 qtvgwOBm8MmiYbzNXRAFq9Bgir4DAcufGkwTYIjKZVfOVGnz3AU8ehwnsBbbu6IqxNbnxmr18XHT
	 JGFy2JPHTipZORCrIv0hg8aNeFg7tAGUfz3JznaKCIHhRp/P80yau9KAjzhM5p2ZJ6tK8AL5WE9G
	 qMi3X/4QmI8et6UhK5cniqwgV8Vu8ylGDTmvzO2AsHpkkMq/bz2lA4D1GXQ069SNa2K09dLWx7yD
	 DGJYIbNFLfXApIiXKtWJsD5/XDAS2MW6YHQffLixjofiCbPOvd2WWxMnOxKVUYG5P8cmJQQ+M7KP
	 pcYMGNsGoTNNdo/IXBvoQKMdjtYgBREJQ63qdz5gRAwJWpWAuf8FaZiaNqFJKgHNf8mdqnMN+OCH
	 Y+xGTczJWUeN3APNH7LDPJ9+wQJiVnuZqN7H4lDH9CLD3YzjTy7Na+SPPEmlBnAslk0Z6+VaSFBW
	 m+1wOHv9wUf/Mr1B4H1ZDkWkNHrIkR23DjRqe8uVEP6r2kHKOOog==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Date: Thu,  8 Feb 2024 19:37:56 +0800
X-OQ-MSGID: <20240208113755.3815370-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024020812-snowbound-version-6bfa@gregkh>
References: <2024020812-snowbound-version-6bfa@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 10:56:00, Greg KH wrote:
> > The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
> > of data to env, which will result in insufficient memory allocated to the buf
> > members of env.
> 
> What is "env"?  And can you wrap your lines at 72 columns please?
env is an instance of struct kobj_uevent_env.
> 
> > Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  include/linux/kobject.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> > index c30affcc43b4..74b37b6459cd 100644
> > --- a/include/linux/kobject.h
> > +++ b/include/linux/kobject.h
> > @@ -30,7 +30,7 @@
> >
> >  #define UEVENT_HELPER_PATH_LEN		256
> >  #define UEVENT_NUM_ENVP			64	/* number of env pointers */
> > -#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
> > +#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
> 
> That's an odd number, why that?  Why not just a page?  What happens if
> some other path wants more?
An increase of 512 bytes is sufficient for the current issue. Do not consider
the problem of hypothetical existence.
> 
> And what's causing the input stack to have so many variables all of a
> sudden, what changed to cause this?  Is this a bugfix for a specific
> commit that needs to be backported to older kernels?  Why did this
> buffer size all of a sudden be too small?
The result of my analysis is that several members of struct input_dev are too
large, such as its member keybit.

thanks,
edward.


