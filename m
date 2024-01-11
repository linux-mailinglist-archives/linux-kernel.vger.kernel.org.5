Return-Path: <linux-kernel+bounces-23020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094982A669
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EDA1F2410E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6DECD;
	Thu, 11 Jan 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6sCyQaU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D17EBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704943239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ySxIr9158TeBUa4+brfKytrmL8cNYEATrtS2LGdz8E=;
	b=V6sCyQaUqb0tVq30yQG91Tqe4V8QEP9j3WpM6d1rUFq2+fPUkov1D6Kh8v/toVmHn6D28i
	oo9rmKGC38bMLchRHhXkR1icDwtAl3PftPwx7Mhoqxsjov+2etF9Tlgor6/obdd7C85UP9
	A1R8+GaL/QT7UJf0hpmJ6XXVaUr1wfI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-nho-GnQmNQWnqAXcjjEE5Q-1; Wed, 10 Jan 2024 22:20:38 -0500
X-MC-Unique: nho-GnQmNQWnqAXcjjEE5Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6d9dfc1fc38so4133833b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704943236; x=1705548036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ySxIr9158TeBUa4+brfKytrmL8cNYEATrtS2LGdz8E=;
        b=h7/zWGUhbjdNy7A9mcMKhQonBTmu1QrlAqWT6t2iDHtW02M3wZ400zVmRoBjOQMfR0
         YeRKGlqgeR4SBqXw6FUGfoMd41KWoJSw5U3R+Ox7q2GVRKd1y/y58loHCF68yLyxuwD/
         m/svWMaSSwYvdbqneqH+WCu3uNsecsw8itqkPp2AkOpup2kfBdRYWwL5IFeCGSAT+ybR
         mY3amkTf8j+pILlIWbtCA4k2ulGY90zANNkcZctVUxiQAbcATVlfrSWXXGgp1TFOBw1V
         FkhDVmR8mxc9zhaxthvVOMIye6LrwwBo4FbC3tSk5gOPWAWstt/TrCV/Y3YSXYvamOmJ
         YbjQ==
X-Gm-Message-State: AOJu0YysF2axl0BrI0Uiu2WolK6sAZ/Myoz9Kb0/YnCrC8cRt/AOq16u
	aVkC7ylZBF2KJWlC0fpq8Ra+Z6w9mCX6phkvwJ4jAfdw+h0PrNUp7pQWEFjWBU5RFln5K16pIj2
	eVESLcLAThqpfMfgNnoaDvEQreP4SY7wZRKxjoJ4ZEavHsRGuww6XqF5P
X-Received: by 2002:a05:6a21:3b4a:b0:199:f3f7:1906 with SMTP id zy10-20020a056a213b4a00b00199f3f71906mr197808pzb.4.1704943236614;
        Wed, 10 Jan 2024 19:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb//iOIGwN9CPQkZdv0a02qYPN9GCk/FREn+oyN1EysZc3rGY+TX2fdifK8FhGRGGABtZPAG7pGCnTcjuBzA4=
X-Received: by 2002:a05:6a21:3b4a:b0:199:f3f7:1906 with SMTP id
 zy10-20020a056a213b4a00b00199f3f71906mr197798pzb.4.1704943236351; Wed, 10 Jan
 2024 19:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:20:25 +0800
Message-ID: <CACGkMEvqg3cqbPDvYe3qAh2BQKNbKYim27or08WsxCAMHmYO6g@mail.gmail.com>
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
To: Zheyun Shen <szy0127@sjtu.edu.cn>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	mst <mst@redhat.com>, david <david@redhat.com>, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:23=E2=80=AFPM Zheyun Shen <szy0127@sjtu.edu.cn> w=
rote:
>
> For now, SEV pins guest's memory to avoid swapping or
> moving ciphertext, but leading to the inhibition of
> Memory Ballooning.
>
> In Memory Ballooning, only guest's free pages will be relocated
> in balloon inflation and deflation, so the difference of plaintext
> doesn't matter to guest.

This seems only true if the page is zeroed, is this true here?

Thanks


