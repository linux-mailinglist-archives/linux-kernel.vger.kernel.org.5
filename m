Return-Path: <linux-kernel+bounces-85492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F886B69B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE261C25DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CAA71EDA;
	Wed, 28 Feb 2024 17:59:40 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFD79B6B;
	Wed, 28 Feb 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143179; cv=none; b=ukG50MLY/+BEO27b6VaM7vu07ose5EeFR6b47pzKCUMwHEO09ftKIUXEEMKwfeHtFGF/fI6ZhGF0TVYkJ1xRhQAY2MM+CfO341XsNvWhD2cwC4+WgTUrKHc7CESMjRBwbdcqFRlF2+f+ucjTJ5TSEid0Mel7gvuU9xkd1vdM5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143179; c=relaxed/simple;
	bh=BtdiY7GCH4yy8PvIrl7nW0rMOW2H+SjTJyaN3RxoRoo=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=SEuRaAFBglBZSdfBePP7uvC7h+TkzE/v4zAYwHIMVZ/Brro9NdDfzZBvhpgkvWpyhMBPiQOGaTnaLsZUeoH8RimlaayZzHXXeJqFp89Yf+LxXYPtutPOM5syJXN+3kmMW13dZUCCtEWm1Cxw2OE0i6c+shKvIWVUaUVfx8lwuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id B488237820DA;
	Wed, 28 Feb 2024 17:59:35 +0000 (UTC)
From: "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgi_Y0a=XPtgdiA9KcsmMGxn=DjvLMmSq-UF8VQtZVTccg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240227215146.46487-1-daniel.almeida@collabora.com> <20240227215146.46487-2-daniel.almeida@collabora.com> <CAH5fLgi_Y0a=XPtgdiA9KcsmMGxn=DjvLMmSq-UF8VQtZVTccg@mail.gmail.com>
Date: Wed, 28 Feb 2024 17:59:35 +0000
Cc: wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, kernel@collabora.com
To: "Alice Ryhl" <aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <28f4-65df7480-b-5f6f8180@243208659>
Subject: =?utf-8?q?Re=3A?= [RFC PATCH 1/1] =?utf-8?q?v4l2-core=3A?= rewrite the VP9 
 library in Rust
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

Hi Alice!

On Wednesday, February 28, 2024 11:13 -03, Alice Ryhl <aliceryhl@google=
com> wrote:

> I recommend taking an `*mut u8` here instead of `&mut u8` if you're
> going to use `slice::from=5Fraw=5Fparts=5Fmut`. Or, if cbindgen allow=
s it,
> take an `&mut [u8; 8]` instead and eliminate the unsafe block.

You're right, the signature here can change to `&mut [u8; 8]` instead. =
This means no unsafe blocks at all.

Thanks for the tip,

-- Daniel


