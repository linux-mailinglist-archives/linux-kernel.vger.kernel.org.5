Return-Path: <linux-kernel+bounces-13992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC57821693
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCF51F21932
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17751EBF;
	Tue,  2 Jan 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t/NecNlM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32996EC0;
	Tue,  2 Jan 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704164292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQEpAwQnp/lG2slbdqN+vK4WuYoQ19RZhFnMHyiN9HI=;
	b=t/NecNlM1PdCZfaI2cAh+Jw4k6cM8fegwver6OA2PvMCslCj3XoOQvX1NB5JkSfIPcj9Cn
	Tbck3yucAharJPX4ryOS17WlbpKenZtwqWeWkcJuuAuQY4XbjBMbbiLsbYQUc6dj20aZes
	nGF9l8h9wMsdDNC8pUdyXW9ieu0umi0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/2] hugetlbfs: Improve a size determination in two
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <8c9488b0-4d91-48ac-bee7-6454e3045a9f@web.de>
Date: Tue, 2 Jan 2024 10:57:28 +0800
Cc: Linux-MM <linux-mm@kvack.org>,
 kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A772D968-B074-4354-BD04-A58255366D9A@linux.dev>
References: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
 <8c9488b0-4d91-48ac-bee7-6454e3045a9f@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Migadu-Flow: FLOW_OUT



> On Dec 29, 2023, at 19:37, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 11:32:07 +0100
>=20
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the =
corresponding size
> determination a bit safer according to the Linux coding style =
convention.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


