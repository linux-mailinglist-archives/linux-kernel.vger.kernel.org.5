Return-Path: <linux-kernel+bounces-31307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89B832C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05611287CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E15479F;
	Fri, 19 Jan 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDNTrAwZ"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E54F1E3;
	Fri, 19 Jan 2024 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677781; cv=none; b=hon3pGdj+aH9A4RnYYqTmZ50PtBZimjG+/tZA59rnNAM6V2UQArPsPh+plAHW5ZQe7vWFpA9Kr5ppHwn10Qa2vBv3rAhOSL++tlhsLTLsDTJt1q2t2GojU9QpsonFQ3sHeeAu4Yr/SmDVWte+jKk4OU8K/kobGftsfGfn1mHSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677781; c=relaxed/simple;
	bh=EjLDBsomiU8ZngEwrnZy6rdj0TTiUVpTHRanJEZFcR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gKq7uu/mFNjLKR52XN7+ytNLEuKzyCyeUMh1wDj7dMZ6pxp2aHr8oN7KcbL2pa2AdF9g8j6rR7LzGNAcx8qH86eYDVRmmBWLspqLefy0XAjixA2v4m7acLzbxf7zWUYIEiFNgoPl8xHDjED63X02EtFHYxX62ZUr159bPTr48rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDNTrAwZ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21080bacc6fso497509fac.0;
        Fri, 19 Jan 2024 07:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705677779; x=1706282579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Myt403LL6AjEMnozelIwrs8mpGxi4XVDTkh5yb/uRI=;
        b=MDNTrAwZjjVaYO1CJtNNtM78A/Hob3d1dMFnKxN4Qdb3TzOhK9EGzecjAFz9FV/mEY
         IssfrlduYmm5+a3F68HXPGS2nkvnhEt5ffiojphVdDsgUoEa8OYQ4UoiKyAygtRfu9Fo
         ugLfFV/X5G2tOmRm3hPcw2TwsR1NgnPF4jK18nv0DNinQvmMchrPDIpsGsVe5uJn0om6
         DMVnehCp4FJGHYs15beew5VEtS5suF/1fpdyBYDSv4gNp7cunTgjsqHjxhhmtDrkCFhU
         pfH23ojsZZbV4+bWkSEyWOFM2wM9vX1zwYIytpHsZeKIBj2BCBVHnzbiNXJParDs9kgn
         u7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677779; x=1706282579;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Myt403LL6AjEMnozelIwrs8mpGxi4XVDTkh5yb/uRI=;
        b=T98BPFX6m5nPAf9/WHASTYczTr0je6XpZVZRGkAx5SQ3Ao3SwgqTm+TU2qC05dZQP9
         LRy7RdmoDWZKwT4b9baqN+qXSNwxS6T9jiO9LoQVH6tad7AVhAb0KGEfW1ED1RMXlJ4e
         K+tuHBbH6CoSAw+6uMKgVW0+4lxBJKO2XAlC27AQ4mpWgVDwQBHSlagsUav8HnrMUiLP
         gxzy/lOWXoP/Fs5G/fRFjPcZY8InJmziWXJGUm1tj+0EG2fc3yK6wmB0hOJow7qrzCBV
         Z2JJVa6C+YmpRQZ0U0AS2ESzr9qO+TW+Ons/Ej3NvFPfXSD+5NlyRTT8mJUm3qroZc4f
         DdlQ==
X-Gm-Message-State: AOJu0YxaxXE80mqaBv87bJFQRQxf24rTGjoyoJNVy4LSRndvU0kkrgI7
	P46eKZ8uKkYguj3ZoQhk0TExB+0frX8zqEXTWtJesHB8247cvvpc
X-Google-Smtp-Source: AGHT+IEOOnbGkhin0F8IWkLKeIucssZzpjGfghjb+Bpbj/TLysXdfncORqzoTWL+JCaKGpgbeHCfLA==
X-Received: by 2002:a05:6870:a114:b0:210:b34c:6ed4 with SMTP id m20-20020a056870a11400b00210b34c6ed4mr2828009oae.101.1705677779470;
        Fri, 19 Jan 2024 07:22:59 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id oo6-20020a056214450600b00683adba3316sm520457qvb.21.2024.01.19.07.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:22:59 -0800 (PST)
Date: Fri, 19 Jan 2024 10:22:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65aa93d2e13af_29ebd42945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
References: <1705659755-39828-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net 1/2] tun: fix missing dropped counter in tun_xdp_act
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> The commit 8ae1aff0b331 ("tuntap: split out XDP logic") includes
> dropped counter for XDP_DROP, XDP_ABORTED, and invalid XDP actions.
> Unfortunately, that commit missed the dropped counter when error
> occurs during XDP_TX and XDP_REDIRECT actions. This patch fixes
> this issue.
> 
> Fixes: 8ae1aff0b331 ("tuntap: split out XDP logic")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

