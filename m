Return-Path: <linux-kernel+bounces-44021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D90841C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E91E1C24CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD40537F3;
	Tue, 30 Jan 2024 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="d33cUqbk"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583E524A2;
	Tue, 30 Jan 2024 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598201; cv=none; b=arZol4P6i2p2zviypZobaA966wJdYxrzR0c9TobYuOvAOREW25cZvBAaJFAb8obxq7ptM2KhfIosZsdDLtOB+JDQp1ePRvXk7QvzxCQnYa0eZM/ZJfsR96T6G+q/3RXb9rGzE60AS2AIsXd2FttOXmcFrXFAl4Fe4sry7HS3fYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598201; c=relaxed/simple;
	bh=+Go9x0USMVLJitv1KFTh9iA97peCWyRbi4bj2KxBThM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+BXyyVu4IzvNkIsSpUNkmRDp6wIHJngUWpU4W1wHBRkm/+uGzdAlgHWIzMulg1Q8DpsPDTXGdWu3VyrOSoEgydnn3y2TptEw7CySL8TUMQmH9W2RQZ7QPWUmIKHigtdRsuWIBJF4yE2oPwHMev2b3X4K+BS264HFKSOK7JxxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=d33cUqbk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706598189; x=1707202989; i=deller@gmx.de;
	bh=+Go9x0USMVLJitv1KFTh9iA97peCWyRbi4bj2KxBThM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d33cUqbkrGGS/vziIiyVcyn+UQazUr2lnJ+ZbT6S9MCAXWuDrD455bbeqL7DZPK2
	 dZ/II31r+rwwR6Lu5aaQCaLrO0CJLfS1iwKPyKL1hkJ9LIl68geJPTXErS5IAqiaz
	 cSncVJIOWYoycFtcv2Hio2h0zMSfOvvOG3bnvggy1HyP7X25vZ3hyIjRMq/lqKMpK
	 8uNlks8vOvS1ygCxv0l199Dlx8Bna8lC6O8hNBs1oLPAABFL2Cj8i8OK4EbD2rgCB
	 kJ30O5vS6BRHz4WBf5Yoa+2108APm2F+/QyZ7Gb5RMvYOuGdjFnm08SlXw+mTht4W
	 w1ntZMHUgkAJ/H7fng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.154.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFvp-1rNJcG2w9V-00ABWS; Tue, 30
 Jan 2024 08:03:09 +0100
Message-ID: <214411d1-f9e2-4611-93fe-223a020072da@gmx.de>
Date: Tue, 30 Jan 2024 08:03:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the bcachefs tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240130100723.323c19fc@canb.auug.org.au>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240130100723.323c19fc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iahIQ3TqTYI7rn2lpCs6b/R1U8fAKHrE5OND99A4uYuOvhawp5t
 2jCtQVow8rXiKy5+/uCPKn27sBOhMKFXLDXsCnXtttEz1fqlcOQKwB6oyhjpO3+jK0kSVE1
 Rgc801DlIoREGZ8vhprX7jplAFXBnwRdfVTDsqHZtu9xP+Y15qzVf1HaHnfsoatePAQJ2vg
 2eXRfcRinPwkYTD0Bh8og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MrPvVR5fEno=;kNxzHeerQyMUo5XfiRNu/adQFZX
 8s9A+EELI4Fq8wBtlZ8kEZQag9w3ah6U/lBm6cAzXlM2/7cuh7f53hQGPmFu2I8ywfOZ1JGdz
 EE/ZKIGdnxKKkOGnS3875uNpf1F0+1ZWC4PatYD05aFe6qfo09tOP9Xvyhp/kuxmNgY8Vq/OR
 eyT3czomOwgYoSOpZdhIQRLAwzUNnSYWQeQFd+rabXLxhAuAQ1D8jDwSmItDd+9vKi33oBHzX
 aXbvrgHrMKbjoCvlTezMpcW/uH7rd7F6p4+QX00xSU/RKoc1Cz/9UZRYBp/ea2daUx1vG46HP
 lKlpZbYU8jx9zm2IoZLr9mQlFC1WB/FziSfqYHiAm418W4JpT47zrGFtJnHGROjeDp0FxnT0x
 Gki9zxnVBNoRvT1lhkOvWabbatQEqoLx8NL1g7yUgo0b+WbZFsUVJ1nFnuhegv+SWxctnL6cb
 Adl433/0BfSyvcUxBxhZoojddkS4BUjlMiw9tWzX/7/21lBYWOILgRIXNwfKQ/wtVi1/AmbEa
 yOVMteAg27N+3yze0LcZ0rW0s6tIeSOltHD1MZo4LTyAAA7qDWFRh7naWjjhonY/MHS3Fo3dC
 0QzrWHY6cy8qROBhN0r8dg3OtqCJjaHAzGjxMcmGPk3yEzwSdoH68fTu+dhpaQZxcj3pLaA/U
 JBh97dPv1miuuJUuM+4ZR9cipZvvZ3dKKGBRUML13EPOC1aE+z0XKplDoEnWB+Ff+qDcVHVcf
 7KGlHv+E2sKKNjuwiib72K1c9OSlfwaKZoilFuQScnvTlkGW6rtsL5ihSL+dYWKN3taBch/rf
 N+v5hgwP4FMOoIeiIm/detzErqM2PpANYY5gnbPKHtG+2a7DleTuN/E0EPwtrArYiRjBKbYRU
 EzXQ9hf6gOvWlf3iAuJiTP0eRKWzEzZ5FFxaE1ovfPdJRLyL0ghR6YUogxOdzGScJM5CDDGTa
 lpvIZ5bXa6AyQPe0sIpxBEcJotI=

On 1/30/24 00:07, Stephen Rothwell wrote:
> The following commit is also in the parisc-hd tree as a different commit
> (but the same patch):
>
>    eba38cc7578b ("bcachefs: Fix build on parisc by avoiding __multi3()")
>
> This is commit
>
>    94a54e4eb439 ("bcachefs: Fix build for parisc by avoiding __multi3()"=
)
>
> in the parisc-hd tree.

Kent, I've dropped the patch from the parisc git tree.
Thanks for applying it to your tree!
Helge

