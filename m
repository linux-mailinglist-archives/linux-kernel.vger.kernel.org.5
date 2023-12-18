Return-Path: <linux-kernel+bounces-4038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C8817708
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76518B252B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069942042;
	Mon, 18 Dec 2023 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFjtoijR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BB3D546
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702915828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5R99au8NJbb079tj5U7lHEWAwHW7p8PGZmVQ7WmYCk=;
	b=GFjtoijRwUpTkbZ+f6VuM5VS2FzmhLCnktCDXO3Yr40nUZYD8K7fQvbuEZSLNiYPLagilJ
	DwGvjCDqc9fN8Ozi33d3Cjcm4PYHFVedisXWHN9PydzeLOfQMDhd7WCtESmsv1zGPNdrMb
	DCmtkpn+rDG7AZVILz6B0pTJLwM03ms=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-FGeGkfbHPQCbVCXN-5IZ_g-1; Mon, 18 Dec 2023 11:10:25 -0500
X-MC-Unique: FGeGkfbHPQCbVCXN-5IZ_g-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-203b9bbe7ccso1352351fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915825; x=1703520625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5R99au8NJbb079tj5U7lHEWAwHW7p8PGZmVQ7WmYCk=;
        b=sfskK+uFuJYfubJ1s7rWlwZpiJG1XGZ6FfkJNXfqppn/XEBHTXRiKPKVBdoO6fisSb
         VnUw/O/QbFsdLd7TTvEGM8fCrU0zaPgtSg/uNZf/tncKVz0w7lU3ifi26ENMYrLuNTu+
         RJlmpQEHegBzb+eREp2upkiqfUzBJkg2prSTZdaiz2GVYkHAMVA27QLtKV7CLc4u13wX
         AeLN6KsHr1EV7xXci90ow9nuKI5rxmJzgC9hLebnAyXdcZ/BPms5Vbs7GmKFgvu9h4fE
         Jh2bzbneNvjsAUAL+02tOFvx1jyQK8HuNaTalWNs5KomFUAqs/qQBW8pv2phxTr0zZDQ
         Fy1w==
X-Gm-Message-State: AOJu0Yy7bPrZz8naylJ6ZgxmqrJXhnm+zpH9SN64xgK7ak7kK6d4hUsa
	F+4QXAJM+p/w+hO4WFtJcppWA9SdVgeKJ49wORz9hwHv8x9G2KduTt4Up2I2AhPzDQA9he0p5cZ
	XE4IrCSwzUq2cn+1ueprEmCq+ixXi/uvobgq5xqKR
X-Received: by 2002:a05:6870:3d8e:b0:203:d297:a711 with SMTP id lm14-20020a0568703d8e00b00203d297a711mr1363185oab.66.1702915825210;
        Mon, 18 Dec 2023 08:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoAVPoEADCU6TjYtAWpqQGANggJfJXkSkO1I0bREZXjGczCKhZxkL4FRuwG2AyDJYAXsvzFVBo7hHGGAwxPRI=
X-Received: by 2002:a05:6870:3d8e:b0:203:d297:a711 with SMTP id
 lm14-20020a0568703d8e00b00203d297a711mr1363172oab.66.1702915824969; Mon, 18
 Dec 2023 08:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218153105.12717-1-dwagner@suse.de>
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 18 Dec 2023 17:10:13 +0100
Message-ID: <CAFL455mFwEfRF9VCCGHhHZVMt2tzr8f2qfFMAPGvufaU8zO4Gw@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] enable nvmet-fc for blktests
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 18. 12. 2023 v 16:34 odes=C3=ADlatel Daniel Wagner <dwagner@suse.de> nap=
sal:
>
> Apropos KASAN, it still reports the problem from [1], so anyone who want =
to run
> this series needs to revert ee6fdc5055e9 ("nvme-fc: fix race between erro=
r
> recovery and creating association").

We hit this regression in RHEL too and we were forced to revert that
commit, it's obviously buggy
because it calls blocking functions with interrupts disabled.
Please revert it.

Note: I have tried to fix it and close the race condition but it all
became a bit too complex, also,
I didn't have the opportunity to test it yet.
http://bsdbackstore.eu/misc/0001-nvme-fc-fix-races-and-scheduling-while-ato=
mic-bugs.patch

Maurizio


