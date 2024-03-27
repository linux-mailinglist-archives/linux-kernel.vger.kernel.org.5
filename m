Return-Path: <linux-kernel+bounces-120676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DB488DB56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EA71C23956
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FE26AC1;
	Wed, 27 Mar 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="uGwCT0Lq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381421A0B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535832; cv=none; b=p1fvrEhTMO1KTI3f+SvGLBCP0skMysXVgOBWsKLwIUdvuTVUPHe4T7Djr/OVTspP+G+fKUyxgJLOPYn1Nm8H6JK2MfJoGfCpaZn2jOE0zjvkZBNg/fQLtLx2mqQAXkFCf2RkQat0P7NzVOTYOmvqitze1yp4Et7w0GqNJEjd4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535832; c=relaxed/simple;
	bh=APeCfLoHjOUQ/c5+H6kqxFvrr2nTy7dCG35+pTLJAXw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=MGNIA+H28JdXyL+udj9rWYh2or59RJZnNAhphsAWxqm8W3V8Zjv4WjPVbOwg1pVuuODnMFB2cB40aaDEbNAUaPh80p+C/Zue6Op3nbFwkyGO2Z5gwLvf7fXkJ/VjI9Qqp3gcWhN3gjp5Iqa5QuRsgPdLH1vBEM2UyjhDNQ7Kk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=uGwCT0Lq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711535828; x=1712140628; i=aros@gmx.com;
	bh=APeCfLoHjOUQ/c5+H6kqxFvrr2nTy7dCG35+pTLJAXw=;
	h=X-UI-Sender-Class:Date:From:Subject:To;
	b=uGwCT0LqBNLo5HfJHyuTP0unurXfLoAM7fatqnD/vil0ykHjxFmVXH6ScYHjT9Nm
	 kgVzS6OQFEE/1gxVRMiP1y92ZjNfz2+PWWRFZRxwvl2iw1/PR0SDdGE6KTTMWYYNz
	 ro4JYnHPgFAalxQIQimumEPfys1yqkdb616fzabfq3jHxFCz62kkxtgyKrQy2o5AD
	 E9KfI/bOw9w+fSpDTsbVVUtuJdDus7o8PjOfDDteOt0IVb/HoH6bwA6uuGSbwVbNM
	 8bos1FfRvNv1YyXHBY0+Y1EJde/sN4zEJvviTCP37XNt/EEbXsb/3Igmx+0SCCe8X
	 J7qK1yucqk/+NTl3sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.54.110.16] ([89.149.39.14]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Wuq-1ruuIK0MeC-005ZoI for
 <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:37:08 +0100
Message-ID: <cb894653-6e20-4759-8dd1-7b03ae8614cf@gmx.com>
Date: Wed, 27 Mar 2024 10:37:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: workqueue: name exceeds WQ_NAME_LEN. Truncating to:
 events_freezable_power_efficien
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:efAKzF7z5a40k8qVRdGWYCsRarcoK/tKbegLxmMM7jRQv7an3J2
 pftqIOaK0XiSNc63Uxo3EGZAgQMBtxmaPVVxkbvyvEAj3k4ztqrfzCB/MCT7I0u8RoCOS/5
 ik+x58qqEGZIuKVDa32uJ3FVY8f6nAj07vl3uTdNXqqA75Vy5RYlwFOpKE7QwVw3T9IdJ5e
 j/hE7SkNtIdb22AuT69gQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8iXj5r0QmV8=;CwZfWpjBbOIbc3MfiDiHxNPGebL
 Zzy214Sr5qYXdc1/B93t/5uGK1W7wSgGI2hiec5dIKfCHRP7GK09Hj9jLFvhHiPYcdcoZa7gH
 +MMf5vkmLKGMiKjczlcwt5lsSCoVc47KCblH+DJeVRpCyBTrgbbPzR3VfBaBzn1s5EUryLuNz
 AuchBIzkVq6WWbiHeeeRTwA58uxYchHp6hJ6rKFTCMQ97LFRgcIgfJBkyxaV3bZg+7aeYrDzy
 qmvkXq3188vB5ScGnWKOjSLM1OfKG+YHD9f8cbFrLZ77pUYXMvT8p7OS4inhJ1fJUHmVyjMXX
 D1she44BVABCSzXXec0Egbs4Iw+zE0tQT1obX0tGe/PgKtMqfUm9mmlyaTexMVhu0Tb6bWijB
 CnjeAWWV9vcCvsLMidV0nNR62fW/IfONKcimrMR+mD4XnWZn7rDf8AxEtZ/Ljt6Q9XUwtMAYs
 ZRTfif7/toNi+2iXyOwQMzf1f15HMQ3/gc46hEUqkOqlOMpNjvrZ3EISQyknf7dwSe/Kvu5sv
 yUPZBMLiqnswaETwoxaenRQRowQZtOIQHLLYhEdLsjW9/F/UTWri6BenWUSHn95YyA47MADAQ
 ZkJ9y/jDpGLzd0rBqy731v6tAcTvLXaXAi9VIrfSLZ1NwcYXXGlUkU05LpmYCj+7jQ9bqvdqx
 5VWC6A8NaPBclDfL/RLvUlkIF/amBYd9cfM5Wpy8FyNrsKNr1A+SAFIOiegGF8U+R+VZhPVCo
 kk5UuLwNGaOP5HeRTJo0mXjg2oi4TNN+9UTHjXJOi0haWreDK2n3fTmRXQETk+5wp6xLqp2dS
 c4o247UwdqaOTg1vV954+E/84j+APgPdc9B1pQQ+6wU50=

Hello,

There's a new warning message in kernel 6.8 which I guess shouldn't be
there. Linux 6.7 did not have it.

No idea where it comes from:

workqueue: name exceeds WQ_NAME_LEN. Truncating to:
events_freezable_power_efficien

A relevant bug report: https://bugzilla.kernel.org/show_bug.cgi?id=3D21864=
9

Please fix.

Best regards,
Artem

