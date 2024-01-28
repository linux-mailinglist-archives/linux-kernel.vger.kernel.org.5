Return-Path: <linux-kernel+bounces-41590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB8C83F50B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD963282D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5611EB29;
	Sun, 28 Jan 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mgKcICdk"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38069208A4;
	Sun, 28 Jan 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438752; cv=none; b=heX3mRLpSiW3eoUXId9QE5vNxmyLku9JRyehReGJzv4PvtNl4ErMuvUrdO0pmEqoWyYFFMbrzbPgl6UtvD/X65La0LS7amldxuzds2sVI9BNfTNivUU9Oy3Pl1TM4tID2rRHuftGE4WS7bsIvitoT7caKgBRQ41+cszqgkPClBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438752; c=relaxed/simple;
	bh=TGfLIz7HMLH6pmk9tTvIdpudfuLAD0Jt70AkMN1beNw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=L9w4J1i+q4zOkAQJ5c6AsUDig01zROeoDUK8Vpmwu0BlqemceePMIOm8wGEKMK5iqdx8eC6TyyR1XsL40v2Nxy7XInZSi8l5UUQhvES+jYmenKzaSJRkZO+kAimUIyYCYIT24VqGP9uH75n90Dl7n1EkZV1UC1GFrmDhfJetc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mgKcICdk; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706438715; x=1707043515; i=markus.elfring@web.de;
	bh=TGfLIz7HMLH6pmk9tTvIdpudfuLAD0Jt70AkMN1beNw=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=mgKcICdkIoZACzViS+Rag+u++ngicj1ppSBAaqqW8NUWsJevUKgnucuJSK2yKjM/
	 Ju0bSIbmuIdNh/GRYlTVTxfmR+RCu/ZtXIwEBPgMX/IbF3BxNReLfPJY/0VvOFnd5
	 xcikuoHz96XyuIPnSSbkNQsIihH3C65diCZMNCsdkzsw1uOrdXwYlqhcAuyOGvrMc
	 DOEfrGZBgtZcAaUVveYV5/kJ3OebjIGijzSblCXA3w+SyEOa10HRNALnAQf1Y4Zet
	 GEOoFSFllzFC1gNQ6UcsgUHpxwO2oGNIRaWExItXrboP/pGmEJKgpVLD7SpSs5S6d
	 QLb0HW7hplM3nbDjdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1r9LVe40vk-00ybyd; Sun, 28
 Jan 2024 11:45:15 +0100
Message-ID: <2b3b4754-4c20-48ef-9844-f5db6a7f527e@web.de>
Date: Sun, 28 Jan 2024 11:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hans de Goede <hdegoede@redhat.com>, Cong Liu <liucong2@kylinos.cn>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <901291c8-ca9c-47b2-8321-256b314690da@redhat.com>
Subject: Re: [v2] platform/x86/amd/pmf: Fix memory leak in
 amd_pmf_get_pb_data()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <901291c8-ca9c-47b2-8321-256b314690da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q9DjKMDDGy1EUUXq9c/+KRQt8G0u6NeSVNylibowMlt24Qfsewj
 8+MvK7pvTKmPqGkY8nMLmRZ7CrfmmsC/ejuCbFU1k+NHyZ9D2nHJBaTC15ubbMYy2vkrZtM
 qLcCUbhpSzjyId1Zwbw9dy35f4J9Fmf820n5fDMITVfEhty7zJJAUtWSri6WMzGzxAcSHEG
 T+soYN7/Gb9NFEWOr69Ew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jBxDDNaiqIA=;jHEzBPd1+9SJ8jRFyYz29Zh6blU
 tsIQtOiqjt4y5bbjq7nYca/AweVMsXT1u1d+TFCYvT2Ds6DjEaayK77hj3FY2sX90k66Iu+Ec
 9qtz+owHX0my+E375XXDNJzi+ko2r76iSFC2mlpmQGjQ/ppooGjhgltef0DHWpgjfH4/H37lO
 6bD+vDtACGr2vpvAB6/nMzlVGEUwSg6uogQObmqxXVSXMi158emXfrxCm2HjGG0YWg/soDeUk
 h7h8urdbU33KhheaZ+nIBsivoytfP7CnvX5/GLoIA9k/WZVpbQIv8DtOSAKp15JQX+UwNT+ex
 IVQHHZICMnbH6CUYrXjKRTUosNiQB/g7gBJw6kou/18I+NlcikdYSWQCV1C16knVFgEEzSjic
 AYgT+s0DRHjCiB1jKuznAnab6I4BE6yOup6KA8alIoQag6PpJOLrf7gaF3qWbVIunYHVlaq48
 qORyyeSQUFJ3Qvdx/I4Qvuea5DYy4gv9PU3Hhpljacyer4nZxZzv2BdmB1V73+rx/kydO4pKS
 BVciKgqDaVlj1ARr/9v3DPVyMMZf+Y8jeL/3CWg0NJkt7ztoczzWpIIm36uZ6xX2JZAsUBNAr
 lW2Y7a8ZSio+lZodVIvCVsmFFLMM8LOgL/cXsgSQWRZqxCPzGuOFIzi4sNSpjH1oo9bchHWki
 Ex0VW41s4sOKgCCmZklAZZ9znliSD3grDkjfhPJnn4fDb1p+Bpe7GauOEmj6haOIm99uDSBHR
 KFdQTBtxGEH2yxrjDg2FZrdIdu9rxJCzfNQE5He+SgKRCZfsM0ftqAZNWIK1KBcqSVy6QpupQ
 yy1PlOp1U59/nWPGyC+qoA9ZrD+XbhCeafgeuzBIjU95Amh/W5pJHLd2oR7hj1fuKUe8gfvRa
 udPnM5YYhPjuMe/kDA5c/ghGhwUzuma/X0QbMeds0W7JbG+yVCXe0ba2TV/raJVhH2XC0BlWi
 AyS9MA==

> Thank you for your patch/series, I've applied this patch
> (series) to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86.git/log/?h=3Dreview-hans
>
> Note it will show up in the pdx86 review-hans branch once I've
> pushed my local branch there, which might take a while.

Will development interests grow for the application of known scripts
also according to the semantic patch language?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.8-rc1#n71

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> make COCCI=3D=
scripts/coccinelle/api/memdup_user.cocci M=3Ddrivers/platform/x86/amd/pmf/=
 coccicheck
=E2=80=A6
drivers/platform/x86/amd/pmf/tee-if.c:297:18-25: WARNING opportunity for m=
emdup_user


Regards,
Markus

