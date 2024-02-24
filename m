Return-Path: <linux-kernel+bounces-79341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19853862107
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E6428671C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40D623;
	Sat, 24 Feb 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kla+jAG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DCF383
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733422; cv=none; b=W+yOf5hItwYf+RQzBp3TVQaQFwx5IR8RFqJ72vbGEAdvI2KNCc06DdWiLqjy8taBw0+WHJaNrxmBzr4X/k5VHsRnRbOoOxastf/+ZdFegzyktVUmI17msBL8KD7ZXQipO75uiOGcvrVbKe8NhPcZAVnHhUP01+ca0Pcmx2NvTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733422; c=relaxed/simple;
	bh=u8QaGjwUNQzrXAdbEuMiKjIXuuZrH80J3g7kclepQS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XAIEFCkpnKNvsoecIYIYz7L6ZnvyaRx0JY2I8sbiw6ncP0TijT9GUsqeAxwdY7Zvpy7r3aFt0uZj+2DxMlQ0UU4s00kxBv/Tgtj3UqDPLxAmqq4wYUHYFwaMOogISPR1cu9/Cbf2RcUDKqck/0IRovNMBZMSGO5ENeL/22TV3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kla+jAG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28601C433F1;
	Sat, 24 Feb 2024 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708733421;
	bh=u8QaGjwUNQzrXAdbEuMiKjIXuuZrH80J3g7kclepQS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kla+jAG5xuzPBVlsb6s4+pulPCmimDeEs3LzG8slgazFEQ1bw9C5vaTILTZf+uuFe
	 FqzCh3eQymanazswSwneGlTd2I5re3GGiOqMY16fiBKUkRqmfOHYKXyXKXucbrIMJJ
	 D6qwHxw06isq4aQCaAhTbdbQjzpqyMdsYMp6Jw6k=
Date: Fri, 23 Feb 2024 16:10:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul =?ISO-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@tum.de>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vincenzo.frascino@arm.com, ryabinin.a.a@gmail.com,
 mark.rutland@arm.com, glider@google.com, elver@google.com,
 dvyukov@google.com, andreyknvl@gmail.com
Subject: Re: [merged mm-stable] kasan-add-atomic-tests.patch removed from
 -mm tree
Message-Id: <20240223161020.9b4184e1e74b35f906e0ec78@linux-foundation.org>
In-Reply-To: <xk3hvszpeg3ttyexcm5s7ztj64nx5gxfwp6ivmobvfzogqjwn4@wicwiqm4bw7z>
References: <20240222000304.8FA56C43390@smtp.kernel.org>
	<xk3hvszpeg3ttyexcm5s7ztj64nx5gxfwp6ivmobvfzogqjwn4@wicwiqm4bw7z>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Feb 2024 21:25:04 +0100 Paul Heidekr=FCger <paul.heidekrueger@tu=
m.de> wrote:

> I'm unsure what the protocol is now; do I send you a new patch for the di=
ff=20
> between the above patch and the v3 patch, or can you just use v3 instead =
of the=20
> above patch?

Yes please.

