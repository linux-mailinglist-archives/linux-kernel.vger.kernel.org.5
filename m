Return-Path: <linux-kernel+bounces-65405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF1854C77
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5CF28AF89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B985D480;
	Wed, 14 Feb 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="m2mZoSiv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D35D47E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923945; cv=none; b=rlF78p62UjjxVOssi5CFI7XbLBvLVb9Qm0v9COHulvEDi8Log+ZLtn4PbCWHVzdtmUQGHg6Z5cfntPdhZ2u4kJ3G9xp48Ez3ybETCCP7B0DoNWk9xKzUoBW4CBAML5TCzvhvYSIkOawqEeFU1vneJeQOL6lhuRXbNN4XTDOkzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923945; c=relaxed/simple;
	bh=f6LGqLKTfyHrl0gV/UTttyU6vtM+nP7TZ9APBfG3Wwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gnzg2MsV+XsEU2r2OjHi5Tfm0a465UBXc7seB0X64MzbYpXtG5eVQ/OYBoju1GrTMEKs2cUjzbLFh8Tx4deDNlqptoKMu7lWRss6qjObnewyTZjpsx+QtHkUZqtebYfPICMugZ6T4aY2MxBjgobc4zlkTtlm+30XHLMKouEah6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=m2mZoSiv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707923937; x=1708528737; i=aros@gmx.com;
	bh=f6LGqLKTfyHrl0gV/UTttyU6vtM+nP7TZ9APBfG3Wwg=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=m2mZoSivpQG4gveWgkhW2ZyJIMVhgOsaNX1Y5MdY86ZCqynbve7Rqa97GsqZidjb
	 8DNCLVBuEQZYjSutrj4PXxj1j9j730G9RzQKoIuJrwoiHue41+S8X9OIbrJTo9SAO
	 keDXHLVWcIxL/sZTN4Dfs4IUumnAITWLTjm3qbRu61Z1SYR5aPoVI32YM9stsrBsj
	 LYd92qFPhsiUoV3H9llZbytcFtrSUM2PBYW2CVR28oUO91Fc3YDGyurxmlGs6xWB7
	 swhQhRsV7e8mxO4Zq4MYyoDq7lR1RdR3SMBXv5kNjR6r2nBBT5GXNC1L1cVjjf4MQ
	 j6TiulIBQ8EiQrSfGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.110.12] ([89.149.39.43]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1rkjpH20Hm-00H8oS; Wed, 14
 Feb 2024 16:18:57 +0100
Message-ID: <37c618c3-6b6e-445a-afc9-1a32c0f4e2f4@gmx.com>
Date: Wed, 14 Feb 2024 15:18:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Cirrus firmware installation warnings
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pUshQUIHxPgR3IdsugPHuyk0ZCgLx8vxqy9MRLx2l7Rg1Ss9k2j
 GCxp56dGJKyz5wGTcA9fBIjLQaGI8d3/Yl0niKIX+k685MEkAFQYxjYq256wxzVGtOyn6+j
 LzNV9dXkinzDvkAJ9qT7fLSUuKCZEuz8esjlrHvV9cl/tpX5tuykO2gsu5KyoltrGsI3ncz
 NBr7ZOHyStJJXsJteiQYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YET5Og+TeNU=;LoElIeNxHHDxYLErE4oYi5/WqM0
 qxvIh22bice5RxSAggXOTo9eOR4m8hYfWgh2EupgX1eebNBRaT/8Jub2cqjkgq2yKa7KP/F67
 k9t9eUB4CUQMmSL2FLadFIiEd2MQMm/GDiUt2MQxfLFXgOApaDud7i6DMGv9whNCBMM7P8SYq
 jc/yrXfXPyDvGBhRBH7Sa7m0TMS3xyKicrQlBif/Fd61sUU6pNPy7BFN/eb3He2EZPFxyLwEv
 VScyjqwQ24QjyV/7Hun9pv3SNiPx00KBTpJ/W2pCs3P033Dh/PMxn4rJjZoxss6fzVJT5bCiY
 XaseOQN9C8L/ELe13ZttOwDqvVmZqbuYzTNJl5B/Zq8PqrP9lXpcO5hqU33OgHGqDtlRk3r2r
 RGxgWzsD+A4ja35gVSt2UeBxB2Y11Y5PpQ3pPLWgy9a6qupBE0GhddCEuzXPNchKuXotVf6o9
 vRr9P5kkGGan8kGNUv68H1uxNSf6H64RH9A3OQDluy6DOZYw1AGDz0aWl0bo+TWoKmmKDVtnz
 fx/qF9GD/takAgqkzH6WHj/5DepVb35p64hpVVAKZ81IklBZqM4CtldVbWRDE9HERecPbRMbA
 y26il1Uz4Py68wi34WgHgMBKK5i+Brcfb4ERChjx+WyhXa1gAkS3ux5hR9VmY0MuElsqXpEkV
 xI5CjtLXAQHNv9VWKWcKdACwLAZdv0ztP7RTq/W8Rf326v0RqQzdJRVsgTJQTtDlaZ4NkJg9u
 if4agUJSgDaa7uo7nUGNGoYTyfkORW5wYSOAGZW3sk+0AVYwIAQf9ZdsuYusbafCmybZOPYZL
 3xUq9YhTKgPGIapoO6z8zrdv2i1BToUQPW3zOykWs0amA=

Hi,

I'd like to report an issue with installing Linux firmware:

$ make DESTDIR=3D/tmp/firmware install
install -d /tmp/firmware/lib/firmware
/copy-firmware.sh  /tmp/firmware/lib/firmware
ln: failed to create symbolic link
'/tmp/firmware/lib/firmware/cirrus/cs35l41-dsp1-spk-prot-103c8ca7.wmfw':
File exists
ln: failed to create symbolic link
'/tmp/firmware/lib/firmware/cirrus/cs35l41-dsp1-spk-cali-103c8ca7.wmfw':
File exists
ln: failed to create symbolic link
'/tmp/firmware/lib/firmware/cirrus/cs35l41-dsp1-spk-prot-103c8ca7.wmfw':
File exists
ln: failed to create symbolic link
'/tmp/firmware/lib/firmware/cirrus/cs35l41-dsp1-spk-cali-103c8ca7.wmfw':
File exists

Not sure if it's worth fixing or not, just pointing out.

Best regards,
Artem

