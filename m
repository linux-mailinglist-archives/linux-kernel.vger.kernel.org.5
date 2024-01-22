Return-Path: <linux-kernel+bounces-33955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0661F8370C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DF1C29417
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FE46541;
	Mon, 22 Jan 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="asFTSnUv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B84653A;
	Mon, 22 Jan 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947445; cv=none; b=PtQqvQU/31MVrnsqSV+gKJP+Z9PXg5W+OQbh0Mbnvp+DkabaJy5hqkDCNtN0vlj+2YdGpf2uuqtF09p+mcmI7YC2NythethqlIXix8LVdKVO1adDMSx0n06QdfmeP+CmmyWW687GT9kMvFwCD8IQgufvRQKIw5mvwfnOgVGO8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947445; c=relaxed/simple;
	bh=cosRaykSzlaNE/xIMf6y8xZWCugy57DK7yvFXqv2wsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utqWGw57Erc2p1O2Thy8G2Jz8eR/AUq2i+Ty/28E+lkV24KVMcFeIeCWiP5rK9M/1CFdMjWE1ue0NC7j9Y8sG1zvPHoBXW2W+FgHfpngcu3Y5+B6IUDxp57ugGcE+wJrHgO/R8L5Nh/PIili8O1+6NbzJGXYV/XzwA/K8hjo89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=asFTSnUv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705947426; x=1706552226; i=erick.archer@gmx.com;
	bh=cosRaykSzlaNE/xIMf6y8xZWCugy57DK7yvFXqv2wsw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=asFTSnUvt7vOfO1EW2cykrwxv2DolQbZuOz3O+TJ1CwWvztMqMCQQHYkg+LttasR
	 nubKVaZDhhSFpx3bYUtx3hBCFU4uovVSvU0V9I8RGIpbmy1IZqrwkOadY7oiFMH+K
	 5yR8Q4VWJFOqK4Ju3tGmtBl+dSU23ghwEHGmmI/PkFfQaG22XZ2MlA8b1TtvsmDf1
	 9Ial8Yp9p8fV7jYLfCdhtELXKqJ4UvJl8IGD5Mr6c3zmEDlzJlLoHkeKLrmra5ycu
	 QZ5Ffuk9SeTIQUzAhQM5ZQc5vMc7eVimsHUIMOiD8Y+fcMMswpxEX+IaTMFsAc+NO
	 4/DA6kSvT22Iyt0V/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fnj-1rUzfK3gxz-006Qns; Mon, 22
 Jan 2024 19:17:06 +0100
Date: Mon, 22 Jan 2024 19:16:54 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use kcalloc() instead of kzalloc()
Message-ID: <20240122181654.GA2834@titan>
References: <20240119173900.11035-1-erick.archer@gmx.com>
 <a5d8a5f1-432d-46f0-84fe-7b5b22ff5f32@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d8a5f1-432d-46f0-84fe-7b5b22ff5f32@moroto.mountain>
X-Provags-ID: V03:K1:kGUntj6tvEvcPAKpBTFIgN0eg54Wxu/RZsRWwgOejcbTX86gVAE
 c+89FsizxElgdv2Q1wx7RPCiLqLqxGqic389bTiIbE09FGqxTnHjihUBgwd+KgCmrkHrQTJ
 xnbd6lmjVSHdhp80teC53hPi+Zkk3s1fbqe6MdKEg3VZo7BBll2oEGKifbZIJ8v1Is92sYx
 q9bLZOu5N8oCk7fUnzABA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UsolengSshc=;iH0T6UGqXMqk89ahnVw5eMaTrWO
 Yr8qNqI5zZBV9KGn7C30KszUZthd3jRUXDgx/Yk0Ft28ZxlmF0LPJ9zZBPiKbjl/eFWnFSiTY
 pDf6DYxOYaDHVmeAy14wYthaFg0hmS5NoAXjaLwZkiiGf5gz0ynGqYPnSxaUTa2lNGa5AJrKF
 apOd5cRSM3aljlqXBK944RpUAkfkahXL5Fvt/NWnYuZxYCE0VcLpOZaxFjD/yQM05fI8iEhTr
 UieHEXvzpWM9PV/0eaEbfidyIMYCydIx4kXvyDtb5L8iK0H1oLCWp9CUpuNrXFq9O5BcSdI3y
 Z/WW+jYH0YWaDtJugFFkq3vl2x0boNky4ovdMh76SY5UB3rF5EDHxRt9Zji2aR28iO1d+iBJH
 jNnlP1TSn2RRopQ2HGvtKaza0/Js3b2kiOVx/+YudnwrUbO+sYjk5g3LB/H1uPVsbI2PrgLoK
 MIKhIiG9Qv8zAaKbrZYf1gToUMdEdQwA0v338Hosxx3mPvsPPKm7aQBkXKLCsNxnizttK8YDr
 O/gC5EHKGu8WVsU4P4IAMwpEZ/lJ+Wq7cGHFBC2tTBEICoaLMgSyBW51MDGi3GHUZ7X9G97ju
 LLZYQZwU74N5ZnLXwvuQ1CisU2dW3VjSSxjVGDwdIEjueT/EQ/MTtG5QTtNMEgDt67q34OXc2
 v98+a/M/cXjKk8ScPfLv3WWegKkcU5j/rovtyvQcf8vTr5qMRkmqAK0eyslxVAkmci/LwK5kx
 6LCHU9P3iewRwGdjj4U26yL4vI8WVY0JpQI0JyoAahF20whb3SygHxHog5IPO1Mjj0Q5z1NaW
 jgtongx7dlOXwWBc4ptHU8VvNGVF6RrKpAxKOdrVZiIhgIjcu0kWgDzfuv3AJ8H5JBe08OONb
 l9joLlKR9+0zPVs9FG/yGbMHstpBPPZa0s4J02U+3PHjp8kyxSTd4HGC3Ti+Ueo2ule/3mBvM
 8cVJZ9qfdGfWIhDO6DSux0ph4SA=
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Mon, Jan 22, 2024 at 09:55:11AM +0300, Dan Carpenter wrote:
> On Fri, Jan 19, 2024 at 06:39:00PM +0100, Erick Archer wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or simila=
r)
> > function arguments due to the risk of them overflowing. This could lea=
d
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > So, use the purpose specific kcalloc() function instead of the argumen=
t
> > count * size in the kzalloc() function.
> >
> > Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> > due to the type of the variable can change and one needs not change th=
e
> > former (unlike the latter).
> >
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#ope=
n-coded-arithmetic-in-allocator-arguments [1]
> > Link: https://github.com/KSPP/linux/issues/162
> > Signed-off-by: Erick Archer <erick.archer@gmx.com>
>
> I quite often write responses to patches and then never send them.  I
> wrote this response and debated sending it but in the end I decided to
> send it because you have sent multiple patches.  If you had only sent
> one patch then I wouldn't have bothered.

My intention is not to bother anyone. I'm a linux kernel developer newbie
and I try to do my best.

> Generally, commit messages should say what the user visible effects of
> a patch are.  Sometimes with these sorts of commits, it's hard to
> determine the effect.  For example, Kees went through and changed dozens
> or hundreds of these allocations to use safer constructs and we don't
> necessarily expect him to audit all the code.  They should already have
> been fine, but it's better to be safe.
>
> However in this case obviously the patch is small and just by glancing
> at it we can see that it has no effect on rutime.
>
> But if someone is reviewing patches with "git log" instead of
> "git log -p" they aren't going to see the patch. I can almost always
> figure out what a commit does without looking at the commit message,
> that doesn't mean that the commit messages are unnecessary.
>
> So I really prefer if commit message say, "This commit is just to make
> static checkers happy and to make the code more readable.  It has no
> effect on runtime."  The commit message you wrote is way more scary than
> is warranted.  Here is my proposed commit message:
>
> "We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows.  Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability.  This patch has no effect on runtime behavior."
>

Understood. Thank you very much for your guidance and advices. I will
change the commit message and I will send a more appropiate v2 patch.

Best regards,
Erick

> regards,
> dan carpenter
>

