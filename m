Return-Path: <linux-kernel+bounces-15541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E14822DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA362283461
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129B19BC0;
	Wed,  3 Jan 2024 12:55:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A69199D1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 28528626FB0A;
	Wed,  3 Jan 2024 13:55:35 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 7xvMlIEQrAr9; Wed,  3 Jan 2024 13:55:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 897A9626FB0F;
	Wed,  3 Jan 2024 13:55:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id feRsaCc2sddh; Wed,  3 Jan 2024 13:55:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 630CD622F598;
	Wed,  3 Jan 2024 13:55:34 +0100 (CET)
Date: Wed, 3 Jan 2024 13:55:34 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: david oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	Tudor Ambarus <Tudor.Ambarus@linaro.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <939427292.194880.1704286534231.JavaMail.zimbra@nod.at>
In-Reply-To: <cc6e93a3-3d3c-6bae-51d9-d8cdd8ca0e4c@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com> <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at> <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com> <642239519.177270.1703884138999.JavaMail.zimbra@nod.at> <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com> <535616666.192239.1704228332389.JavaMail.zimbra@nod.at> <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com> <cc6e93a3-3d3c-6bae-51d9-d8cdd8ca0e4c@huawei.com>
Subject: Re: [PATCH RFC 00/17] ubifs: Add filesystem repair support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Add filesystem repair support
Thread-Index: BXUjUihmAOjaNq4Zv4hi8fz+n/56vw==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> How about merging 3(a) and 3(b) as one mode(dangerous mode)? If fsck can
> get a good TNC(all non-leaf index nodes are valid), fsck executes as
> 3(a) describes. If fsck cannot find a good TNC, fsck executes as 3(b)
> and reminds user that "TNC is damaged, nodes dropping is not awared".

Well, you can make all modes combinable.
Right now I don't care much about the user interface.
But offering much flexibility is a worthwhile goal.

At the end it should be crystal clear to the user of fsck.ubifs whether
it fixed the file system by applying dangerous methods or not.

Want I want to avoid by all means is a tool which blindly alters
the filesystem just to stop UBIFS complaining about it.

Thanks,
//richard

