Return-Path: <linux-kernel+bounces-154601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132248ADE32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451231C2186C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E446542;
	Tue, 23 Apr 2024 07:22:57 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE746521
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856977; cv=none; b=JZxbTRihDCu8+9RPZEktPGIASpkoMp8ed+V2xN75xdAFs+ovPTQdEO0r3j/CPqgEGxvJKbPPm6gcpBAUaukKbHQJzbRxukQt8n995EiJi2vnXQ0of84PucIDJF6jfwCCKukcyre5/PapFeOLzhwcGLz8VE++VIPyX2+vwcGR3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856977; c=relaxed/simple;
	bh=L4OcFr6Wq5nOJsUOvDaAmjOCMS9WVXFUfLPu4Nn2G+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USI7D5F46d9EC8qvN4CiYV2ZPBaMzW/nAlenaX/sbniEJxQSHMm1baLiLhbvYCOw37QXXHSge/EeBrlVph/XyjphbYQGmC+idtNTpIvKEDtLA+BWRgm4bWtEWCz2ZgaKK5ONPZFRLkauZdLH5Zukvf7/14yJ1EG71nb6iiv6/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VNtSh53Lhz9v7g7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:06:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AB0F01404A5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:22:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LBW6YSdmcLXMBg--.38603S2;
	Tue, 23 Apr 2024 08:22:42 +0100 (CET)
Message-ID: <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 23 Apr 2024 09:22:31 +0200
In-Reply-To: <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
	 <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3LBW6YSdmcLXMBg--.38603S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UKF47ur4rCryrJF43ZFb_yoW3JFgEgr
	4vk34fG3yDJrs2krs0k34qvr4vga18Kr13JwsIqrW3X34DurZ3JrWSyr9Yvw15G3W5JFZx
	GrZIgF9agr17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5iypgABs4

On Thu, 2024-03-28 at 09:25 +0100, Johannes Berg wrote:
> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Registering a winch IRQ is racy, an interrupt may occur before the winc=
h is
> > added to the winch_handlers list.
> >=20
> > If that happens, register_winch_irq() adds to that list a winch that is
> > scheduled to be (or has already been) freed, causing a panic later in
> > winch_cleanup().
> >=20
> > Avoid the race by adding the winch to the winch_handlers list before
> > registering the IRQ, and rolling back if um_request_irq() fails.
> >=20
>=20
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thank you! Richard, are you going to pick this up?

Thanks

Roberto


