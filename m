Return-Path: <linux-kernel+bounces-92518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2187218B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC69C1C2162F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0352E86630;
	Tue,  5 Mar 2024 14:35:15 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC01F95E;
	Tue,  5 Mar 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649314; cv=none; b=a3zgjnqfEJc3XPEeFbE93qTVHx6K4ictGQpdBKKIB28gGeWO/CeruT7FhC1F9wVKSNoK+fQNpOaQYMMob518E4TSS8+PxfN9VNNuRGqSeVfGu1DwxT6EoLTtk7jnOmCOKDUP+6ZxobVH+CUYFTZ00iBBBafpS8Y49+sf0YbEoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649314; c=relaxed/simple;
	bh=6TfOkndwHjhQbu16832bNmwZ8uJQuWEE74QCPikoOHs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=huNMPRCMEpevzfhZXmHGUkCi+l/Cu9D75Kl6UiHDeTB+lkb7PXrXVwRdqdyEOeP1DSIVxihyHbgyipRye/jfigNg4JG4OBOD9Ia4/wOJV1leMg/S5MYbqi9LloE2XKQRkAlA0T20RqwELIcIAdRqLLb2BwoqJuojCDRt8M+kJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000075F3C.0000000065E72C67.001FBA26; Tue, 05 Mar 2024 15:29:59 +0100
Message-ID: <cea322c6acd3b3aec7e56c4b7b1ae7cb87ec3d15.camel@irl.hu>
Subject: Re: [PATCH v4] platform/x86: add lenovo generic wmi driver
From: Gergo Koteles <soyer@irl.hu>
To: Ai Chao <aichao@kylinos.cn>, hdegoede@redhat.com,
  ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
  platform-driver-x86@vger.kernel.org
Date: Tue, 05 Mar 2024 15:29:58 +0100
In-Reply-To: <20240305121315.1744363-1-aichao@kylinos.cn>
References: <20240305121315.1744363-1-aichao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ai,

On Tue, 2024-03-05 at 20:13 +0800, Ai Chao wrote:
>=20
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_id_table);
> +MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
> +MODULE_DESCRIPTION("Lenovo Generic WMI Driver");

This is forgotten.
It should be "Lenovo WMI Camera Button driver"

> +MODULE_LICENSE("GPL");

Thanks,
Gergo


