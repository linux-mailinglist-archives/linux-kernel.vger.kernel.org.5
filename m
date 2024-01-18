Return-Path: <linux-kernel+bounces-29637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A0831122
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705931F21EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0611F4422;
	Thu, 18 Jan 2024 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W3m259+Y"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54423D8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542782; cv=none; b=BkQIe/ssoJ/+t4B0OnfwHnPKHVBwlLIvK263axy11ZqSo33gGAoCPxPJEFM7Dy6s0DGpJI/Na5HA5c6R7qOV4EQ+ujpT7RDLVqyFTf5fyPIuI+IYVcz89qxV/P/O1VdY2QvcssV2o1qDcS85o1zb3nU1/+1v5Xdc8sQKXYZLxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542782; c=relaxed/simple;
	bh=TbGKo9XwnaWFRnDaGJQYGEDB3n+mODCRkk1sjg7BuRA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version; b=Ngj1jQBHKg7irl9pBRrAwmDT8sRAYeZLC1o71Hm9bgO0ufOr90oiQqA/8sIFcwfAZUjxluCAaSVaB4mBtewAGwPZfizMI+bPFlVL9T2e8uYlPolRznSmLCijOiIRkshsGegg/QfK+0a2pxBBBQz5cHbsiFXBZZ+X3HQQhZ10jQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W3m259+Y; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccbc328744so142377851fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705542778; x=1706147578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=taCIpUJqzL+JyTaiMa3v4bP+c2WFVuuQ9gZ9COs9zu8=;
        b=W3m259+YmlnMuOAK6XKKmaoxzp5GGgx3fAtvpII5LF5lLztUFbWKPSw4hN78NgVby3
         kT5w/VsyaCVOv4qT5OnPO8r0Gevcgxl91/k89Z9nY9E0r9Qfj/23hwnb+577gamTuwiY
         4fpYgw+oVNniaB63cN/ZK8SclF6Ph3RZBkLdrn/AGFDwUj2cOuzkoxrNnpHBfhSUKrUc
         jgnK75bXS2guTzpXzDVKqgDemgPEnQ/jYPT6EuoF9/FdybTtSmzis6tdW7Joia7XjPJo
         F7e2HN73aiFt8eMRng1P5FYZfsj3wvMhWbiKfY4nqnbkw8bgI+reT1IVF9Nx4AjxkBN8
         WWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542778; x=1706147578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taCIpUJqzL+JyTaiMa3v4bP+c2WFVuuQ9gZ9COs9zu8=;
        b=gcdPbscD/lmgkZ50R4/IMseQob4SpRS0dEJXKWWlHKyvpB471gOgNqVA2+AZYwG/HZ
         fqFDtbjiBlDh7zKQp1HVQxbjLaqyRrjD4NQkX+UT82zhNeDCopx/F1syRtBkDRhPUujD
         fyEBbQfZ2n58PHB+D0nefURtIOH6VQw0dtS5K5tKNu+e4CqqBjnbnZSygjmUcbkNweor
         Ce2qHS3o96E5fiynOt1jdGRAqM+ZsUgKZd3UZYJTdEgu/IQ+nJdWaGt4iXAMwXY1hEub
         fG8pPIa3qZmGwFT4gaIBLSXjkwGbNQ9PgMdK7JoJrNn/rVc4OLtyq26mLxM3rHVd4nKt
         PHag==
X-Gm-Message-State: AOJu0Yzazsi1+ab/VvaLUEXbbuVbY5awYg2dhT6/E1IGACdEGn6/ZnvW
	ipIfXtQGosBVVuaErMWJ9kfevlkevUjQLRyQnT//5EwfzVDtGykzftyE3TC5LLk=
X-Google-Smtp-Source: AGHT+IGvzTuyC7iVwlQOSofeR6dJpAULy5A1d7eEifJUQAx27DALwNdCqveNkTX/dJSr0C9xl0HxDg==
X-Received: by 2002:a2e:9050:0:b0:2cc:a7b9:2fa0 with SMTP id n16-20020a2e9050000000b002cca7b92fa0mr66494ljg.12.1705542778479;
        Wed, 17 Jan 2024 17:52:58 -0800 (PST)
Received: from ?IPv6:2804:30c:974:ac00:1b02:e2fd:23be:79bc? ([2804:30c:974:ac00:1b02:e2fd:23be:79bc])
        by smtp.gmail.com with ESMTPSA id y2-20020a63e242000000b005cd78f13608sm338946pgj.13.2024.01.17.17.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:52:58 -0800 (PST)
Message-ID: <4aaa05fb405e921f25c907ca09ea29976ca0707c.camel@suse.com>
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
From: mpdesouza@suse.com
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,  Petr Mladek
 <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Wed, 17 Jan 2024 22:52:51 -0300
In-Reply-To: <Zaf08hx8fBj6TW5/@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
	 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
	 <Zaf08hx8fBj6TW5/@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 16:40 +0100, Alexander Gordeev wrote:
> On Fri, Jan 12, 2024 at 02:43:51PM -0300, Marcos Paulo de Souza
> wrote:
>=20
> Hi Marcos!

Hello!

>=20
> > Having the modules being built as out-of-modules requires changing
> > the
> > currently used 'modprobe' by 'insmod' and adapt the test scripts
> > that
> > check for the kernel message buffer.
>=20
> Please, correct me if I am wrong, but with this change one would
> require a configured build environment and kernel tree that matches
> running kernel in order to run tests. Is that correct?

You don't need a kernel tree in order to run the tests, you can build
the modules and use gen_tar to pack them, setting KDIR to the currently
built kernel:
		make KDIR=3D$(pwd) TARGETS=3Dlivepatch -C
tools/testing/selftests

This can be used when packaging the tests, like Joe showed when
reviewing the v4:

	mkdir /tmp/test-install
	make KDIR=3D$(pwd) INSTALL_PATH=3D/tmp/test-install
TARGETS=3Dlivepatch -C tools/testing/selftests install

In this case /tmp/test-install will contain the scripts and the modules
compiled targeting the same kernel version from the kernel built from
the kernel tree.

You can also run the tests from the kernel tree but targeting your
currently running system.
Using this approach you can run the tests on machines without kernel
tree and without build environment.

You can also pick the kernel source and run
	make kselftest TARGETS=3Dlivepatch

As KDIR wasn't set it builds the livepatch test modules targeting
/lib/modules/<current kernel version/build, and so you can run the
tests against your currently running kernel. This would require kernel-
devel package and gcc.

I hope this answer your question, and provides some info about how to
run the tests on different environments!

Thanks,
  Marcos

>=20
> Thanks!


