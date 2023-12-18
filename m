Return-Path: <linux-kernel+bounces-4155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF79817892
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5701C24042
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BF5D742;
	Mon, 18 Dec 2023 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfAB2A/H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F45A867;
	Mon, 18 Dec 2023 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b4563a03aso927175a91.0;
        Mon, 18 Dec 2023 09:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920090; x=1703524890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ+d8lXK8t7tOQUPKwNZqHs+rv31L7RvHxCGty4EDjQ=;
        b=BfAB2A/H2yDFX6dJgfiiISJ4I/auxguCWTmKfZI4t4s+TQD7foHIFtgoXapgbWJ+rQ
         zxDYabstJyzK4lZaXKk1ena+9z5QRuKUpBddkKRqDtDdk35qUlcVxP29okMLZXe7TEs/
         1jOOIJ5gFKqG1So7PJNiTE5vggbQuCR+JM17IYdjGncOw0AA3nXWIvol6L79OzeaFidr
         ummEMXPw/ScrUbZ/mGFSGO7tQr5xatS2G6WwKWreaUTHGa9jCr1XzJG4yv5vq/ITz94p
         9WByGpWEnYSXzhFWbZzG0r5fjkJrezeP3b2Z3qO6nBKJoyfGxkjalr6qMO6z0L/a65G1
         31FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920090; x=1703524890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ+d8lXK8t7tOQUPKwNZqHs+rv31L7RvHxCGty4EDjQ=;
        b=asAVnCW5EuDmf33HylUkiD1sPyer0C1e0VIWaxtrVfcbJz6ulz/rcDA1b906A+oWc/
         VAkCvV8Cj8B3AJds2JgtHxhd7WCMpzuG1KECzMFik9/3+DZu7mmIvL6ra6N99E5DCQWS
         YSXj5l599jGet/NkA/YAwkHJFnT307aHzk9daiKFSIRduVJO22aqvf0pa0rdxgrQ8Kh0
         IQsgjnn71vDFzo0hs90uN6wyCNehxuk3hhrRST2BSD0AWPYxS0NDH2iTP6zpMyL4sYDm
         wVpn9FsjI2O1siqMuoWEPecZklL2KhHy+TZvsxglRJMtCIOLR2TINI3gjfqxyeLSkJOB
         fKCg==
X-Gm-Message-State: AOJu0YwmVP8JTzG/QTd/VOtA4il/YXrEhe78fLiD3qs4dIsUK5iTdspe
	/P7ZozLnuPDamRk6H7RX6NQQyRP6Z/6fnIA0J8k=
X-Google-Smtp-Source: AGHT+IGJW2/B2t4Qp6LNhtCnwLtLP+FY/akR5Dr+slxmOtIJLVsP964rNYKe6kurtd9STJLyyUO3NKHkMR6dwVBC5Jw=
X-Received: by 2002:a17:90b:1495:b0:28b:4d97:e53c with SMTP id
 js21-20020a17090b149500b0028b4d97e53cmr978070pjb.99.1702920089836; Mon, 18
 Dec 2023 09:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com> <20231212131712.1816324-5-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-5-maxime.coquelin@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 Dec 2023 12:21:18 -0500
Message-ID: <CAEjxPJ6zMbM5jPkLC_wDHsXWXofWcDntHRDWQTS6hojECVJPTw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vduse: Add LSM hook to check Virtio device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:17=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch introduces a LSM hook for devices creation,
> destruction (ioctl()) and opening (open()) operations,
> checking the application is allowed to perform these
> operations for the Virtio device type.

Can you explain why the existing LSM hooks and SELinux implementation
are not sufficient? We already control the ability to open device
nodes via selinux_inode_permission() and selinux_file_open(), and can
support fine-grained per-cmd ioctl checking via selinux_file_ioctl().
And it should already be possible to label these nodes distinctly
through existing mechanisms (file_contexts if udev-created/labeled,
genfs_contexts if kernel-created). What exactly can't you do today
that this hook enables?

