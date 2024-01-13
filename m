Return-Path: <linux-kernel+bounces-25375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13882CEC8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08486B21DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CE16439;
	Sat, 13 Jan 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bqzdy+tG"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFF15AF9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso7888015a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705181519; x=1705786319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKoNNUqlg2Xe5jxTp3GCnMUwSPY8/bQZCKu1byOc4Gc=;
        b=bqzdy+tGH6VL2pBYE6u+as7QwNYLUJmtZTVbnI0604KxGMPpincJC3JcDRbRED9LAh
         X2d65WQ4NOwZcEmD/xgI5dY6/MISB2h8SfF4B7ndXf+ahpLi6ZOPxlTjGxR4qr8RQjFJ
         uOHwGN2QEbouGfcsnpZCDQUcOWjTqXM6ny2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705181519; x=1705786319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKoNNUqlg2Xe5jxTp3GCnMUwSPY8/bQZCKu1byOc4Gc=;
        b=Mb0/OazrT2dxRcbTpLILzNn0sLHJUM+S/BJlehV847d0s/2lsW7Pz/nOZcYmjLIB97
         DXYtb4+TzQBS83JSwOb9x7HHstLWC8RhswpKqYHxjdB+40qWh3C22X2p3roEhbOoYqbL
         G0Pym3XuoaJHQvMUJOyAg6+WBwxA+A/rN4oWOUHe4BIyqs+UO8sJWWIpsqUJ/uaJMAtL
         97evdhNiKrlpJ+i7mg68Eq1fZFY49yeRDUW6mX06rQ7f7ujPT4Ain8GfEpWCJJDJZcc7
         RIm0ejmSl73SwwwCxNQSqi3VyWfS8rwylrlA2+034wRank9QIpji2gRTQ5pI2SKMCAzs
         K5lA==
X-Gm-Message-State: AOJu0YyoGroMeffgdgpmiFFvINTHt9URLzQ14HtveEmNlByDJVmAp05N
	p5t1BuEukLmDKDKWcbo5nebLm4rDWlYqyxXuqp0CB0782VH1/D0/
X-Google-Smtp-Source: AGHT+IGbuVxc5YWqozuZakjbj7NG4iBRMyo3b8HDlawca6YNPUcUicXdGSTbDVoUXgJFS/GDKm+5sw==
X-Received: by 2002:a05:6402:2c4:b0:54c:4837:7583 with SMTP id b4-20020a05640202c400b0054c48377583mr1605745edx.47.1705181519265;
        Sat, 13 Jan 2024 13:31:59 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id e3-20020a50ec83000000b005585049ddc9sm3381705edr.45.2024.01.13.13.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 13:31:57 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-559058418faso487419a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 13:31:57 -0800 (PST)
X-Received: by 2002:a17:906:934e:b0:a2a:da46:3a82 with SMTP id
 p14-20020a170906934e00b00a2ada463a82mr1318644ejw.58.1705181517281; Sat, 13
 Jan 2024 13:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Jan 2024 13:31:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMWpmXtKeiN__vnNO4TcttZR-8dVvd_oBq+hjeSsWUwg@mail.gmail.com>
Message-ID: <CAHk-=wjMWpmXtKeiN__vnNO4TcttZR-8dVvd_oBq+hjeSsWUwg@mail.gmail.com>
Subject: Heads up - effectively offline for now
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a note to say that the merge window is paused as far as I'm
concerned, because we've lost power and internet thanks to a winter
storm. Of course, this is Oregon, so "storm" here is what some people
would probably consider "somewhat windy", and "winter" here means that
the temperature is approaching -10=C2=B0C.

There's apparently about 100k people without power, and I doubt our
neighborhood is the priority, so I expect to be without power for some
time still. I hope I'm wrong, but a few years ago it took more than a
week to restore power due to all the downed trees. It's hopefully
nowhere near that, but..

And before anybody says "just go to a Starbucks and work from there",
the scariest thing out there - apart from possibly downed trees and
power lines - is other drivers.  I'll stay put.

             Linus

