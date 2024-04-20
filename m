Return-Path: <linux-kernel+bounces-152271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2D8ABBB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168C02818B2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007C20309;
	Sat, 20 Apr 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b7NmpL2p"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681D2563;
	Sat, 20 Apr 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618969; cv=none; b=iJtEt68i42qwcOHnR+4dkalqEbCWuP0jOjX+AUCHh2hTPQ9I/KAhihfDQ7Mh+xhnznSlktMEexYfiel7JxCQaJOQcbwARzbWO61n2nGlvPySj+hczkGtaJ5ZzeAEwj00ezPFCecQFamj5e77AJN6FJAAeybiuzCIECsqu9IRN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618969; c=relaxed/simple;
	bh=FT0t9HE1rL9H9A5o8oALgJBDzziSpKtzAEmi3ZmQPQI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RNnWdZRSs0M9clP4p+qdzRfZGu5RyuEbf2aHLyC0NFM+Dl1DscOgnZvm15c8kThR065UPnfwHEUjb4myfKsEJopSLag+xQqwYlOGm4FDp0iOuz9kkvujBCXgs0bZuC6PL+Oi72oT5EMyfTfBwAnP0MRgr54WKk+oWjqaJRRRnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b7NmpL2p; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713618937; x=1714223737; i=markus.elfring@web.de;
	bh=FT0t9HE1rL9H9A5o8oALgJBDzziSpKtzAEmi3ZmQPQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b7NmpL2p3KCnnc7yZjWSMP7LEmvQrWmdL/1xCLAmzm1gqzS6qBreXqlkzb0qp7BY
	 Rad7pexfjAibdoh55HuNPGpNTHK7Up98IJgWh2Kfpk3JGjJC+JIDAlkvzmz9sctop
	 PlwV/VgZxWEY2J4A6REZKWr/IIbthMvwkdUcBnFx++sP8vf413316i7F3p0imUWsS
	 PZ3x0kfOqjUhMMrPvv0lgqOHXfqKMRNGcWsIl23C9ccna40zdn9EgP8WSisj3S/b3
	 qm0BxyKgrlUdZmdiMnjdipIWEm1nDpMsOpPt8+0ujn0jyDDXPIFuA3bWXCMMNxA+P
	 rSPFB2mS/WnWo2bkvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1sRwvi06q3-00n772; Sat, 20
 Apr 2024 15:15:37 +0200
Message-ID: <aa12c80c-9769-424a-ba2b-8c0f68b1c1e6@web.de>
Date: Sat, 20 Apr 2024 15:15:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jameson Thies <jthies@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benson Leung <bleung@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rajaram Regupathy <rajaram.regupathy@intel.com>,
 Saranya Gopal <saranya.gopal@intel.com>
References: <20240419211650.2657096-2-jthies@google.com>
Subject: Re: [PATCH 1/4] usb: typec: ucsi: Fix null deref in trace
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419211650.2657096-2-jthies@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qEkpwmTHHNClAQiyVH7IIo+1fbIub7wek8hkarYTnw/srysoz5k
 FWCmqIdoeSWXqIduQee46hRETP3p4iClMdW7GLg12lgnSoQyYAnvKJ0a1FsaKbr7V0JqVpi
 zrTMd2/hMewDGPEX7cqNO5UvLgCim6bR52ciBEgk8s13HR7Dl85rX2YLfAAUZTzP10ugJyf
 6jhjvxVYMJpfQq4kPioTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bQJae6an96A=;Fp4WHDmZ9c/qvFFF+YpBx6n+1b6
 F09OD4Toyato74mg7EXqV9BEXI06hViIh00mBVxC/J+LNAnkU6ehTxAKHFuD1kl0a2AfV+Vw9
 SjqStQFE5AUZEadHUEVFwVwFYsWuo+ZQjO023V/5Tp1NeKI72Ehm8CY41BLQsLT/XmQoxZ8+x
 5bpLTWHIu6OzXPxpvSp5K3iTSoVdWPvCamN5pxHCbv7kpmADb4l/CYN0cqPThuZcpmeO4Uvxf
 1Kbmmg+f4orcM1wzOvCr1Hbw791lmLAIfhV9Wkh1PXK9Pzr1sG1PHz9dzW5X/DvFqYT5i+fCI
 wcFID7gcNoGEtBZOMFARHCzUnG3TxuBD0zASjtQv6KAXt1nglRcJFmGrvAYxANfxwglxXWku1
 KeWstBdzwSVxlNVPbOB5dbjmt1ejWlJuusIOQXk+KwW3nq8U9oewnarbqWqznAxyYCgSw1JPY
 a9U8xsQ6MJ8RdDC/BDBLde/KCEBJZtY3d0bG4uLNtvUyvjUVUsqqHP7uJDdmswYI/yJn9jPqo
 EchINxYZdeY59i9jWZX3vCBC1r+v6HTWimVe9F/9JnMke0ouVopFfmjzffatTbvd2/SjexByc
 ktEqoSdEFk1LH6jpNpuYRXONHyXURDsxuGFhnTRvFSok60FPKa+YuA77QR8yId1pSLf3Lf3dz
 rSmCpSCqZ9Adppx8D6XfzexnCEtQyX8JraCoQQsnD1rqyI/CbMLgrj7eMPEbbKbMPm8yjoQrB
 fLSCwvGHrXgWSWjBTO800ZEbRgl5Huv3YYrpf7lyp2M5YmMjnovs+fFeCu/oU8sbqRpp8246k
 oBdu1oLYKYVugPabk5g8bdqJtowYff0UZH4N3Hpp9KbEQ=

> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. This results in a null deref when
> trace_ucsi_register_altmode is called.

I find that the change description can be improved further.
Is another imperative wording desirable?

Can it be nicer to use the term =E2=80=9Cdereference=E2=80=9D for the fina=
l commit message?

Regards,
Markus

