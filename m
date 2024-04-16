Return-Path: <linux-kernel+bounces-146546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040F8A66E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF77281C48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79284E0A;
	Tue, 16 Apr 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BShjayh1"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046185646
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259021; cv=none; b=n8lc501aWQAN7oD3+CAd5B/B9Cplx9ESQ16JDzH3CplYyfvM8PEKsFH3ibKIAf1pti1XGJ8x2bqpkqa92BtmaE2bIjLEDBZOmN1Xa2d2fnCzo15nFtSEMeBiE9Xj3PY3HUib033rMniOyrBx56X+4nJH/UQgq+N/fLyopZJxd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259021; c=relaxed/simple;
	bh=8jgLAUJob4komqyCXQnIuIoKS9Y6WNsjEipKGCag8BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4uR8NEgws3nn2UMU5rzmNRB6RmfUTo4WY2s1yNxCyKpI68POYJH4UCG6X7q4+lTjXY3VdPmKbRBNNpwJghjTprOlxSFmqgJa3dJ0f81n3xNnK0OVSUitsh5Zrl2latu+svNIquS8wxfGjmpgJbfYgI5rCtb4dVHbyB+fvHAOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BShjayh1; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e043f577c5so2115412241.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713259018; x=1713863818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVWn70QrmoA1ffZj2betPxocp2G4USrXC3Hf1knCx68=;
        b=BShjayh1AmE6jdkBKIq4GNbw2wzlvTUhJeadqPCRis1S7JuBmycqKKfs6mAkok7Zi1
         cP5vjBWE1Y/oSb9cmKYDe/p6vPcKng7VUbzNRZUETzBI+ZPKPinf1nOqH0VBOv3rUoIc
         AQeqIEVNwtb2mPNGoKAmtkmJ4+MbNoT/JAbrEkKFCk9Hb2GPYjI8ZDI/h2ejJz/oZGsR
         DICrwVovKJhN9/xZijxJhGD26Aabf6HcKvKXK4jk9XjE7didTBmMhEDQZb2UuaOe8OIB
         UJPOaxp6ceAvlMT+GvwEzSwOaMM2mKJQX8iq40348fVF/dX+lp3zGmXiCYq+Xbk47z4t
         wvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713259018; x=1713863818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVWn70QrmoA1ffZj2betPxocp2G4USrXC3Hf1knCx68=;
        b=G3cV/h+UEXjrOzmNFXRASy5TZGT1NTq9A0Djf6Z6c9j6T1Nm79TJWm+1NxADgVTu4q
         +XcLqcAU9l54inPw/5lLPPapEQuPv/SzwiC53uQAps9DlNwtrmQtEuKXgi3Si1DmzoZw
         o/JzwadN2WzG4uEoXiPjRMUUTvvoD3NAQsXwNmmskdyoo6qz/DlB4+cMry8Xpsoms72d
         mQ9WavV1fq6JUcv2MaxoFKFy0r6Ks9o6Gg9XTvDJUpUQaXU+2rdY8lhc+N4uTGOxngXY
         COMfoGtM6qxDKPpLZaVtK7OW/cAj0vEphwfIZcPBnBTouITIm0gRu4u0xhhWohyC3MNG
         8scw==
X-Forwarded-Encrypted: i=1; AJvYcCXNRs8aaXwa3+6vbUobQxNZpZSwmu20X0svMdFtsb24KN54p9SWuGL7C2QcxZYoXnEpkxIIFdHLZ/IlJj7BIf42ZzvdW/yYjVZQAUmD
X-Gm-Message-State: AOJu0YwYVbZn6gqmlD/gCNe+k8sBWpBumjN6crFMBJ49WWP5zh93Eto6
	ltgIX62a+guUFLXltbaApIvI6VfBNYTmWOEmE9l2ImbwZQVZiJsMVnptl3c8v8OZW5s1/p9pUap
	QVxNomt71Zfg/X3nopsNzwx7AwZsmJLmv1kESIg==
X-Google-Smtp-Source: AGHT+IGdpoYmKI9SqOv3iUlv9BkJT85Yzy6MJYOaIEGPqruTKs/l0Rq7SnWeRhl+jvwoE4tXiBJFHrIO7sIJV7KYpIc=
X-Received: by 2002:a05:6102:b0e:b0:47b:9d4e:e0c with SMTP id
 b14-20020a0561020b0e00b0047b9d4e0e0cmr154923vst.12.1713259018530; Tue, 16 Apr
 2024 02:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141953.365222063@linuxfoundation.org> <Zh3AywUqfBB5wQgp@finisterre.sirena.org.uk>
In-Reply-To: <Zh3AywUqfBB5wQgp@finisterre.sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Apr 2024 14:46:47 +0530
Message-ID: <CA+G9fYuxQemNR=6ypi681qMqg+szi+ZZL_Xdhz0Wg1BO0-7bjA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 05:35, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.28 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> I'm seeing boot breakage with this one on the Arm fast models, a bisect
> is running now, for slow values of run but should be done by the time I
> get back tonight.  It only seems to be affecting 6.6, the boot grinds to
> a halt shortly after getting to userspace apparently with some
> PCI/virtio issues:

LKFT also noticed the problem that Mark Brown reported.

>
> [    1.606075] VFS: Mounted root (ext4 filesystem) on device 254:1.
> [    1.608751] devtmpfs: mounted
> [    1.627412] Freeing unused kernel memory: 9152K
> [    1.627894] Run /sbin/init as init process
> [    1.627957]   with arguments:
> [    1.628009]     /sbin/init
> [    1.628064]     Image
> [    1.628117]   with environment:
> [    1.628169]     HOME=/
> [    1.628222]     TERM=linux
> [    1.628275]     user_debug=31
> [   11.764055] pci 0000:00:01.0: deferred probe pending
> [   11.764141] pci 0000:00:02.0: deferred probe pending
> [   11.764227] pci 0000:00:03.0: deferred probe pending
> [   11.764313] pci 0000:00:04.0: deferred probe pending
> [   11.764399] pci 0000:03:00.0: deferred probe pending
> [   11.764485] pci 0000:04:00.0: deferred probe pending
> [   11.764571] pci 0000:04:01.0: deferred probe pending
> [   11.764657] pci 0000:04:02.0: deferred probe pending
> [   11.764743] pci 0000:00:1f.0: deferred probe pending
> [   11.764829] pci 0000:01:00.0: deferred probe pending
> [   11.764915] pci 0000:05:00.0: deferred probe pending
>
> (no probe deferral happens for working boots.)


--
Linaro LKFT
https://lkft.linaro.org

