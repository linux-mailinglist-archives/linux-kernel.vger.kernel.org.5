Return-Path: <linux-kernel+bounces-149828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC548A966D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EEB61C2215E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A000615CD60;
	Thu, 18 Apr 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JPtVj3UW"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469D15B98B;
	Thu, 18 Apr 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433272; cv=none; b=a0/Mf1cVq13CuOP/W7zWQS/UyYkkMahew3laPpK3cc5G43ahKUGwBoryqZO6dA31XuIhocuCQ4/EL5r0ir4iY+lw0AudeYoSsuMILSLkPZUMst1/P2mGpfVcPPvTAEJCax96efkucDzZsD4nZtvNWXWhicIcjeSF4ksv8L8xuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433272; c=relaxed/simple;
	bh=AdahcIlgWLXAJKCG0JqEYzoHe+XLbYJ/FlvNan0T5gk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=N32R0yevh8isoiaZZ06oylB1NJnnZBHmflr4RYugF4iBPbKdYhwrIhj+5OVyd7lwJiL7cmNaEnVX22g8gufykroM6ckHHK+k4RcP0Hz3MQGC54I4XwEoWHDh9VTXbRZIQdoXUhfUnJwH1z2qQTMbIPNcJprhsw2EGUf7aSyFIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JPtVj3UW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713433236; x=1714038036; i=markus.elfring@web.de;
	bh=AdahcIlgWLXAJKCG0JqEYzoHe+XLbYJ/FlvNan0T5gk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JPtVj3UWRH/zitJgTYSWJ+X7L03KL9m8sCF6aMYs+2ZvKbh09iQ2dkfMjsHQ8xCK
	 gjvci9uB1nxKSsluB4hxX2LkEiovi/0u4ySHwsCHPqkGvKj9ijCn8hOThfKJB4nEq
	 9LMOtAEKK5EFVW5MHxHIQ+UTw/04wknLuqpEB/PhKh2vFhZUlhsVTW4ZQrnF9OK+Q
	 gKHFLYah3X4Ac3+Y4E+41UzcV/jFNK0VlUleWib5oRwZdCzddZr4dCGocurRnGetp
	 IaO4gTL8h7IDPTTJInDxD9623zbwHyx9OphQ5HozNLF60H7z2XOXHvrBOSqii3SW1
	 0UTBDtuhKwXw6wb5nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODiX-1sLnxd2OXB-00OavU; Thu, 18
 Apr 2024 11:40:36 +0200
Message-ID: <cb593f2a-7dbe-44aa-b9ff-7fc57a4bd70a@web.de>
Date: Thu, 18 Apr 2024 11:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Chris Lu <chris.lu@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Deren Wu <deren.wu@mediatek.com>,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 Manish Mandlik <mmandlik@google.com>, Miao-chen Chou <mcchou@chromium.org>,
 Michael Sun <michaelfsun@google.com>, shawnku@google.com,
 frankgor@google.com, jsiuda@google.com
References: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
Subject: Re: [PATCH RESEND] Bluetooth: btusb: medaitek: fix double free of skb
 in coredump
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <da0859c4b24d314d9ff38179c26a58ee7e3f16d6.1713395895.git.sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:h60MNVHZTjz4/QmEHPXP1WbPwsusvY2fbKtPn9WCziwqPyptPlc
 ber44onTYjIxTlQrcfVbWexacjHT3eiioX3yg37VqYA/7nnuaSxwjFeHrhE74xvoYT64tc2
 3Bx7x0020sHYynWpPs7rIOean2NNYeeYHgu9W3V01FD3Ay/7lpgcnd4zXRE3rnBDqHddr7i
 JELSN8JHpN9EF8kXS488g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:41/oj+AA2Xs=;BgPgrSRQrxZusn4FIjnNLvOq+Zn
 Way5JznIXv0bGOXGZANPoP33fZwEyhiP+DOSSF0yK0z8jJqbR3cX9AChIL3SrlXTFm4DAcF9/
 tFk2IVrY5rnCwoxd5x2HigKs9h5/nX2uAYP52ITODcNEikAGbTQ4aAZIy8G1CX1eyHh9DelrR
 4nynCbeFHXqBLiB+yXNHLUBNWnOqgNJGVxLk03of5/Mk4WAkVAXUjogHa8J86rr7K9Eq8Whyr
 YapxCrQDUXJiHMUwKnJ3RuCugV7Ri5epnCKIXTY69hZoCKZ3tOaHAtiL7JvBsv/SGH+BCWwh6
 lEn9fBWqiLN5rkO5pKNUlzMCR01jJESrS2ct2uFraGLwYryaw7wD3YmrvSgl5LThotXpeQ/Hi
 FKwefg4ucDvQUrWqnLOTj1ANy8bLeQ4nTpN5GNxtNHAkIpOKqLAcI7P61Xsg1rNWfIkQcg7cc
 urlooCIzuygFbycqHrOB/XbPhyb4KuAJtuMpRJew4GaN9F/iOCHR1MP2v4TyHrdBp/C4lPIRT
 Jrk5o/Z0CQFBlIa01eGMNPwKA6j8TBDk9yyjWstfNhcppz3ylybstDNOtb4ae50fcDpF5vb6R
 BeN0GXDGYIzMietT+DZpVUicx1nnQFo9gZHvQjDZY2ntgUZTn9CVoGA7x7Vr/uarJTicehone
 PljgWkykcNWS5ph6B8uytPnv7tzNcRMpxaXBN0Wux4qziUggrqWsZhYLPYDC3b3rt+tdrDOiU
 A6HJhsAjKoGnvjYabnleJ+B3pvP/2ieQmU4d+mtuSzI9rf/a9cb8AcotaKHy/J1wqbbDAt+5A
 4FZhxvoQC0XbQrhJex5/2wk1KLUbc/lHwC8a4fD2CYjDU=

> hci_devcd_append() would free the skb on error so the caller don't
> have to free it again otherwise it would cause the double free of skb.

I hope that a typo will be avoided in the subsystem specification
for the final commit.

Regards,
Markus

