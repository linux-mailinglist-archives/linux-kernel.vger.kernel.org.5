Return-Path: <linux-kernel+bounces-3574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC48816E00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820481C23247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B97EFAD;
	Mon, 18 Dec 2023 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUXPgGem"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E747D5FE;
	Mon, 18 Dec 2023 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so2725535f8f.0;
        Mon, 18 Dec 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702903075; x=1703507875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HM2YjYNGvEtLLouvrheo9w1hxXY7VvcGwBup2U1JryU=;
        b=lUXPgGem1xVGOJQEWaE+UpHOQJJDyNOo+tgB4ZRAKvTmrDS0EXR4fihQ372ZH8Cuji
         5sKztHpE/2lesYUjCxF8cvNSk59v3tLuWQV9+Vope2wpQq/XBDud7NnesIKziZGV/eQx
         BLrPs9RYZz1myNWxxSfuD7vs0/1LToyoErFdwmD8B1VITsW2oWMcasm7ghVlMJMQQXPx
         ZL3h6R+q4y/J0FnWEcQltFjjEonXmINFCjkycEdMHnTRSkQ5pQ6OVl3O+S3LBmOmGBFY
         yhkZtSnRnIZSI5/VXNpDWvP/iGG+L6MWf3Hra0jTmHJnfxHZt+05n+ZGy51alq+6FqAp
         VKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903075; x=1703507875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HM2YjYNGvEtLLouvrheo9w1hxXY7VvcGwBup2U1JryU=;
        b=EnuZ9FFt4+x98oovg5XL0BpL6vB4EyWH/FYl1J0QwbaA6/Kf7HEZC/RAorYeu9Wg77
         Na+qrmz0pJyfXhBk/m9HiVJn3eUGYtQYZhSpcZ8AbBrOehHYGp9BiRYMCUXXbQxjvA2g
         sTopGmQFhuDFn84qEkawlPDu10vKrmyhNPl3LaKxprqmCHiEL88H58QnRIz3poTIHhQS
         lCikCB8DkPxsi7JMfVbQ383NRsb0+C5Bifgnht92y+ToUPsNlJPsiWoS7ANZYASQl0lK
         rpdmT/XLortNulb/QMXdOoodk1UAYCSsehEoVWLtYzaPwZRxLbBquyT/ZRgC51F6DT6+
         YZ+w==
X-Gm-Message-State: AOJu0Yx2bhviPpKhcB59yWjCPKrfSDQTR0FsVcS9Gnej+LSHLLcTcvbL
	cop+GJkYu5PTqsaLlcyeQmzty6DXp2pLdstAOg==
X-Google-Smtp-Source: AGHT+IFkOrBR4PMgdF6AOi6HEUA8Ymv+KiQWtgSZhsU6zR+yxmsyJTB3MUTKpyjeB+01bZBIitgYLTPtsUye29TPkAk=
X-Received: by 2002:a5d:678f:0:b0:336:5f04:bff3 with SMTP id
 v15-20020a5d678f000000b003365f04bff3mr1560149wru.81.1702903075329; Mon, 18
 Dec 2023 04:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218114222.283705-1-tomas.mudrunka@gmail.com>
 <c22997c9-6d99-4e1f-9015-b7f80be2a720@kernel.org> <CAH2-hcJe40e7LhrmQb5XjGpRfrUEp3RukqWUqn1p8UQSNkpisg@mail.gmail.com>
 <2023121858-aground-consent-cfe3@gregkh>
In-Reply-To: <2023121858-aground-consent-cfe3@gregkh>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Mon, 18 Dec 2023 13:37:44 +0100
Message-ID: <CAH2-hc+BO=oxt2faSqy4AJS6qPdjC+cAc+ONZrvYnCPJT1H61Q@mail.gmail.com>
Subject: Re: [PATCH] /proc/sysrq-trigger can now pause processing for one second
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What will kill it?  I feel like you are adding features to the kernel
> that can be done in userspace, which is generally not a good idea.

The mere act of writing "e" to /proc/sysrq-trigger kills everything
except for init, which is rather unfortunate when doing that through
remote access, like ssh (or other). I can surely block SIGTERM in
userspace by fixing all remote access software that exists to not exit
after SIGTERM, but if i want to do SIGKILL and then execute few more
sysrq actions (sync, unmount, reboot, ...) it surely is a problem
unless i am doing this from init process. which sometimes is just not
possible on remote system that have undergone some crash. and as linux
admin with 13 years of experience i can safely say that situations
with unresponsive init do happen every now and then. that is when i
usually have to resort to rebooting the system remotely via
sysrq-trigger. this process failing can be difference between me being
able to fix issue remotely with minimum downtime and me having to
physicaly visit datacenter during holidays.

BTW if still unclear, here is simple example of how running that
suggested code will not work:

$ ssh root@10.10.10.10
root@10.10.10.10's password:
Last login: Wed Oct  4 12:34:03 2023
root@debian-arm64:~#
root@debian-arm64:~# echo e > /proc/sysrq-trigger
Connection to 10.10.10.10 closed by remote host.
Connection to 10.10.10.10 closed.

