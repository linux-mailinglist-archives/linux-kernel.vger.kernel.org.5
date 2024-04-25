Return-Path: <linux-kernel+bounces-158296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCDB8B1DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CAD1C2101C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86084E13;
	Thu, 25 Apr 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qLWhGMKF"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F083CBE;
	Thu, 25 Apr 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037278; cv=none; b=W4Gzi0xd5qSb4134usYD4AUsKhBBzXf3kyjE1Kt57YZ7JZQ3al/jMz8aoKx6YcF5hIUdXQx+VtVYb8lByuWNAyiyM6TxXetGgeyFbg7hd8i0lLhxhX5/CD6ejbVUrhbMjNLLounGiAe5OnFbAWMdlEtnJUyw9ZrjAEN7Y7W2zhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037278; c=relaxed/simple;
	bh=CG/3877UELgCDWBuuRgZYINMib1453pKWIyDnNRgsDY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ktVzXFFyprTZfGrZlzVpyEEgVAHRDRI7r+qn3yFrEioEneXbeAAF24zAe1KMmE5UZbsl+hQsQFNUE52+neEcd7UWACYEmlEXnIlwfL6u55J+sMHL3bBM3S1xQ3Z/zLT2x12nn9C1sQuvT5v9XtpyVC8Q3OfYlTHfzi9zBt+EoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qLWhGMKF; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714037254; x=1714642054; i=markus.elfring@web.de;
	bh=CG/3877UELgCDWBuuRgZYINMib1453pKWIyDnNRgsDY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qLWhGMKFk1vuJWeSDEkhUSldFi+mY93F5Fxm8bjUgHCEoWrlPCu9DfEF90t6xrCl
	 GL7sol1xXFS5xA/87PxAGAVu4JMqBoyGsJZzJaAn9nXOr+7NDQCBr7Ym+ZNS42G20
	 nMfQs9Mee/vRdReQqBiCXezFcgp/4wqQ+pUJ4UEz9Hw3T7qWx7KvtakUo0TdfOWD+
	 mI8EmhZv8jjgqLs4ctyogrbvp+f2v7hC1PZ0gaU89lzFHt2jOjsyzTM7inmjAj/D1
	 /p7zTbR/JGbboyK9OWrii9IHXTwHZRduBrhFLSWlFfnxEJpOCMr1GceLY9LvbR65a
	 rG3ScKdMzYFlSARraw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1rotqQ2JKK-008f4O; Thu, 25
 Apr 2024 11:27:34 +0200
Message-ID: <fcbdbb5d-27f8-4ee9-aa28-5d12e292940c@web.de>
Date: Thu, 25 Apr 2024 11:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: llfl@linux.alibaba.com, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Xuchun Shang <xuchun.shang@linux.alibaba.com>
References: <92ff13341044a39953f0ba116cf7f9881488f8c8.1714034489.git.llfl@linux.alibaba.com>
Subject: Re: [PATCH] iommu/amd: Fix memory leak in alloc_pci_segment()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <92ff13341044a39953f0ba116cf7f9881488f8c8.1714034489.git.llfl@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D5sXQVJ7FGYoeOoNxgYPzj7pMSo5O/sN+BquYBN6YaJ2f75nm4E
 4pCyrflfI1xqLbgiTLt3QUAqeEc66mDV65cDApwR+F1DUV/oTsQbo/1koUo+KYoy3+fSoc5
 b8GMGYynirHKjAT5kPJ9LC/SzhlUmTNZwh5zfQlOXdL9oY3kCmuAdLrMdsxgVFNi4YOFffD
 1+0QLddQgUWHgxn81FNKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N8eLJEPZoGY=;fVzaMJBxH0eL8XznHY7A369k02G
 0PBpdW8CcwWhzUIDqwEL1HcSq5+nLXZBJjQXcRVfVPCdJowMzl0kMglEkQZN7T/gY5qj9ixzD
 SeLkWC4CwnSyEX3AZV94Hucq4GWgJxtq2tOaPTFd+Zu/5D2aUIY5AkPu4UHm1xR87J7KhpGlS
 FFMI9Yup0LkM/3uMN+pP2bjOgg1AbyQTi+90cvD3waA5Xi0RsvXsvG/fdHE9shB+9wYt68xt1
 rTD61yhfm+MuP7Tjpmc9K7LW3Ny7UAgR6oaoTmOD0M+h4L8Ohh8xnaGVbkqVNNjw08kl92Bai
 9vMia2QtRKocfRV+dYwkXaO6GUr0oK1eDzVuivFlM9ht0shCmtesLnEhJRzZd0jh48pDdYecZ
 BiFWikFvDIYei1ULQsb6FccizWhOv1MMqWTLltVfB6kgb1x8lE/DZndgbCkpTYJWfNJVXTi+S
 q90QqNiPzLTMwlWHxpm1MLwTsgUaTpFopaiC6QxYSZQtcoZXPFUj+2WYx98Nz/zTHwoiNzLV3
 taQtQPZkgM5uk92l3dninTJfvm4Cj57yQuOOt0nW+me64YJnua74r9gaymgni0Jhr8RT9dsbH
 XXetydw26XFEoasVzuRYdBoKwIDihWsJIHtmQy2KR1GB4WtD4TCKCNdq/rUCZUc4HStehxjR4
 kMJwjs+Lkzi608ny7cTaUKMCyKXwtBxZ+OaKNd4/aJqm9Abum3EztAAO8Kvse89b5wWqiVnnd
 oqYBSM91yabV5r/l4KsG2D6gSL3wPzRViRu6q5vgRvij5SuMUABwmuKNfv4Qjq7u26SJyjvAB
 n+kTgQAOLOQhCJuQboneRuGu6Gl7LoqyYwbP47Ns6+RVw=

> Fix the memory leak issue that occurs when resource allocation fails in
> alloc_pci_segment(). The dev_table, alias_table, and rlookup_table were
> introduced individually in commits 04230c119930, 99fc4ac3d297,
> and eda797a27795, but they all fail to release allocated resources
> when other allocations fail.
=E2=80=A6

Please refer not only to commit hashes.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n99

Would you like to extend the change description (with an enumeration)?

Regards,
Markus

