Return-Path: <linux-kernel+bounces-87666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADA486D791
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242CB1F22BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAB35B1E4;
	Thu, 29 Feb 2024 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OoT6pFub"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FC1DFCF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248467; cv=none; b=Qc90/dFBRNgK9fQJ9COAWjfaoVQ7jsiE6T3c/73WTNbLJUBYrQOT6i5P+EU7XxZaMfxsEDwPPaUSuk2bdpkANg3Xhi71z5nMY73Yp79fgLUiPnc4Fg9ilgqMsghupD3INdlywHiJop6FpR9Z1HNup8jlU3LL758lmn1979aXq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248467; c=relaxed/simple;
	bh=mBOVl+zJ7BDiUMnGvvMRSX38gRn0i/b1iJBtbhHajKc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=tRvmItUy1li7oFojKLqKe/EFwyK1cQVhQ3/38LjpWy10+GBRQrf3DcYNwwxbsdfMSIXzLVLcmrlge79t/w3/MXkSzzzO/dEs7wJG3NVXgMiQddRcnmT4C54OCBBQLKr6I06gHZZo9AsY16pJQNq8qEO5CQf48QAIf2xWuq3PzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OoT6pFub; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id; bh=4EP8nnjo7NvEGFoileT5wdDJOy5gOk88KTfQtjsr7Dg=; b=O
	oT6pFubR/cy/DLbkLMJSDhYyA4JScDaZwP1IZIWebmO0grkJMJ2dTkKydjLBwFQX
	QM36F7ZqRwa2ccG3ubL2bvoRN2rrHNMbR85n9hto7P+uA9NHEgxEevdxlNmUn6be
	uvMLLuBaMU0rUCYn7WiC9lovOl0CBnJeYK5LFt0ZMg=
Received: from smtpclient.apple (unknown [43.245.196.50])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDnj4S6D+FlgpNtDg--.51423S2;
	Fri, 01 Mar 2024 07:14:03 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Hao Ge <gehao618@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/vmstat: Add order's information for extfrag_index and unusable_index
Date: Fri, 1 Mar 2024 07:13:51 +0800
Message-Id: <F38EE8B9-3C29-43DC-A471-3DF6242B9804@163.com>
References: <20240229104013.5ed8c1ca9c2dbd0bd5fb571f@linux-foundation.org>
Cc: Hao Ge <gehao@kylinos.cn>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240229104013.5ed8c1ca9c2dbd0bd5fb571f@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (21D61)
X-CM-TRANSID:_____wDnj4S6D+FlgpNtDg--.51423S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xZFyrWFW5XFyrurWDtwb_yoW8Xw4Up3
	yUKF18trs8Ary7Aws29F4rJr12y34DGF1UJFZ8Zr1UGr15AF15tF1ktryFvFsFqr4DG340
	yr1FqryUKryDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi_cTdUUUUU=
X-CM-SenderInfo: 5jhkt0qwryqiywtou0bp/1tbiyQOTFmV4ICdtBgAAs+


> On Mar 1, 2024, at 02:40, Andrew Morton <akpm@linux-foundation.org> wrote:=

>=20
> =EF=BB=BFOn Thu, 29 Feb 2024 22:14:43 +0800 Hao Ge <gehao@kylinos.cn> wrot=
e:
>=20
>> Current cat /sys/kernel/debug/extfrag/extfrag_index and
>> /sys/kernel/debug/extfrag/unusable_index is not friendly to userspace.
>>=20
>> We should add order's information so that users can clearly understand
>> the situation of each order at a glance like pagetypeinfo.
>>=20
>> before:
>> cat /sys/kernel/debug/extfrag/extfrag_index:
>> Node 0, zone    DMA32  ...... ...... ...... ......
>> Node 0, zone   Normal  ...... ...... ...... ......
>>=20
>> cat /sys/kernel/debug/extfrag/unusable_index:
>> Node 0, zone    DMA32 ..... ..... ..... .....
>> Node 0, zone   Normal ..... ..... ..... .....
>>=20
>> after:
>> cat /sys/kernel/debug/extfrag/extfrag_index:
>> Extfrag index at order:       0      1      2      3
>> Node 0, zone        DMA  ...... ...... ...... ......
>> Node 0, zone     Normal  ...... ...... ...... ......
>>=20
>> cat /sys/kernel/debug/extfrag/unusable_index:
>> Unusable index at order:     0     1     2     3
>> Node 0, zone         DMA ..... ..... ..... .....
>> Node 0, zone      Normal ..... ..... ..... .....
>>=20
>=20
> This may break existing parsers of this file.
>=20
> And that would be allowed if these files were under debugfs.  But
> they're under sysfs/debug, where the rules are less clear.
>=20
> Still, it's unclear to me that the benefit is worth this risk.  What do
> others think?

Thank you for your reply. This is something I didn't expect. I think it's be=
tter to keep it in its original condition to avoid compatibility issues with=
 some tools.=


