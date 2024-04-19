Return-Path: <linux-kernel+bounces-151921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5D8AB5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B152819CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714F13C9D4;
	Fri, 19 Apr 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CLbRyo9d"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D5A23;
	Fri, 19 Apr 2024 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556651; cv=none; b=pozvm8iG8pMYRTgzG0eKm0hA+hMI+PWdhvXaXcxdvXD6AJSXwoobCgrM46rIT5m7PlrRwnp+HVTMO944IbL0Gfl7+ZL6b5sA3Z0vw/5N8C6dn0yeyYM3uQZsjrrLUIpA2IndDpn7IVHDqi6hW/JRHcRkRDFSKUin/5iFm+i88NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556651; c=relaxed/simple;
	bh=6Slvd9WP7U67G3VLT+aHOxvttY9ZS+l7ClciTen+Yuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCUbTZ31aeHj1RlhgEBhXwgENEsuZ3xa8D6Dp+zZt/9qEN7ClSMtUwtJG+UCi+UKarsDj3V6N17WLAiBrChuwAkjFYNW5cCv5jF4hHkaQLmn+yz573A9wn1HyWDNjgQ4vf79I+d4QtThLT7wi3h/gYVdJ8X7j2E0jNigKCaYbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CLbRyo9d; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713556618; x=1714161418; i=markus.elfring@web.de;
	bh=6Slvd9WP7U67G3VLT+aHOxvttY9ZS+l7ClciTen+Yuc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CLbRyo9dzVNhQ3oFILxFVfdLxwMaG3MUlxRpvJgCTD1G9ABfqDyZAaKKlca6DWgF
	 sUH440ZnySvzqm3nJtym8DEy0RYN0RnysfrYqmQFYQQ2FUNZak8cf43dZpbEU/bGr
	 VmzjnhSdI2yhmn+UpUdL/4LwsthQOrGwY62rWUTijMI7POVNa0bug5XwMvdQJe61z
	 rTOxqYltHt5eV/V6oKrIXMcAThdlRjAFsvSWgLhhOJ98EuDaafNAK1rFGqHQpvhZD
	 tgeFAz2X3LrfV+/HFE1+8Fen7LoGUnt3hpY+0v9VMgPNzhWvqCrQ1IHBHLijk2X89
	 D/+Re9p4sJeT8oC19w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1rtptb2Crx-00DV2a; Fri, 19
 Apr 2024 21:56:58 +0200
Message-ID: <0460d898-689f-4e9a-bd2a-a812ca54acc4@web.de>
Date: Fri, 19 Apr 2024 21:56:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: btusb: medaitek: fix double free of skb in coredump
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>,
 Sean Wang <sean.wang@kernel.org>, Chris Lu <chris.lu@mediatek.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Deren Wu <deren.wu@mediatek.com>,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 Manish Mandlik <mmandlik@google.com>, Miao-chen Chou <mcchou@chromium.org>,
 Michael Sun <michaelfsun@google.com>, shawnku@google.com,
 frankgor@google.com, jsiuda@google.com
References: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
 <cb593f2a-7dbe-44aa-b9ff-7fc57a4bd70a@web.de>
 <CABBYNZL1=RyzuXcDpAwcXyOe_8Bh4gJtDzKdS55-3ZF4rZRj7A@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABBYNZL1=RyzuXcDpAwcXyOe_8Bh4gJtDzKdS55-3ZF4rZRj7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S8WVsoPLtqYG/ykvrpdfXwxTb9GQ6ddC7R7zsOQbPfIOAPVg5bH
 cMPj7nuSOAH+vCBx5OH4wb42KGMA6DWS72RdGxaVQ6GogDsV6zx1u9KXKVPQ6WDqKqmppbs
 vxrwA7C9+GYDicbVt/kTg85dLhkoRSq0ycv2rJslHIS1PtxilV0j5WC27ds1+k8kIdd178e
 Uw04abQuIawH3E6PHXxXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0SfpuT7Zf8o=;uZUyp+Nr+hFB7lgbCA8xf5U6SOd
 G6jAFLKGPouMeLYW4ECJ9Nj3ptXypcKX5dsGcaY4cgMYcFcjmm1XlEuevFyYL99tscs8ucgsb
 2TCitR49unAcRFalK8OpUepLM+sxcAp8D85ZpEeiQjzGsQ09JyVdC7K3bOOX9azTYS+NJLuTH
 2QS0weenCJIYoUNbGo5ibW5MTm57SYaxyqTbbzPw03xkWt3Ocl5Ggl6GhNVhsusXSbuBZvK1D
 /edJ3mSUaeEwXQm+2slS9GfpYmCm4HQS/MCt8/1thcYEF7urQCd7pJNfYag4CpESUib3cwygn
 GE/kqPk41/7ldFc4gUhfLRce35yrIzXg9W44EfjQVkPsxYTdEBWxV68yshYOo+pfr6GVsTFbC
 h6mxd3WUJx3j7rZUIykxOLFxoVSFL2bTDPMdyhlstEV+IaxoW5fxKe4RCJKBmNi4qgxuHq6RA
 JqtZkeI80XrK5wiEb0KLHj/uapL9LgO/JTh8dVBNkRr0F+qnAnRtepTQpMODMIAEv+ovtVv5c
 kdqZJ7u/YqZflNTruCf63ZvkjsvDyel/8TqnZ496NZNXTft8Rb+zflWEzJgOOXmxACrI7kvoB
 7FidVNYsshtC2l+ebPjq7MB7ubEzlRtbIn6J86VKKkV2ST6v/fYbABAV47XHi1fHLg1X+EzPm
 ekgotMOoGSVlHZet9dCO4ydT7+Vc/dmku7qn2wBEV9r+sL3eV3L1XepaoYD4Yw8avZBtzV3VF
 ttrwDx8L+s3sQWwPHOOHeNgLe6LhEmT0YtDfRmwxl2b4yr7U9KHv4jv92Y25a3sbysuYYRbf/
 NNcKcS6YOo/M7ZUFUzPuFUuc4XphAToefC6dayaYh+mzw=

>> I hope that a typo will be avoided in the subsystem specification
>> for the final commit.
>
> Are you talking about medaitek

Yes.

Do you prefer references for mediatek here?


> or is there another typo?

Not yet.

Regards,
Markus

