Return-Path: <linux-kernel+bounces-167836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F28BB008
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F202844AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DB315533D;
	Fri,  3 May 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vtP14qu2"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC2153816;
	Fri,  3 May 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750569; cv=none; b=AgkP1qx6RueuyJZCl6SrSHT93k1H5emX2w6Cal5IBeoZU1QYNSLXoJHvc/xZF351/8IKgQyNIBW+/WN+xGWNqnQaKTOnh7jtQ4GxUbIxT68LNjswOGtK8CMbE2HgbpFvePceHGeLSTWXC04TuSBVZwZkRlzRP6MMfJADoKuigv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750569; c=relaxed/simple;
	bh=NC+ejQiD1SuZYzI3BW/e8K3TbPUaN9KZRtfAdV7jXM4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sYdXhdwjFOYR9Hxhbn2oDba93yAd9sccH0Eu2FGue4E+kA3Cr73nJrO9kx/1wQqIlhDlUJ+yWYLNxX9lRxxSB++j/npQrUHfWn0SUFIw9ZhfqNa3XTp6Wq9JtW1ABa7Q7g6h50HKPP3ukq3wQDZczmEn1R5HmeC8bztY6es18Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vtP14qu2; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714750542; x=1715355342; i=markus.elfring@web.de;
	bh=IW4IvyC+ChUZFc2mEHb0vBR9MWXWnvhfDjc74j+oTc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vtP14qu2Z2nObc+Vmx09k8RQnk0Y745Z6dNGLWr6eQ9M/iM02vvaAiB1B0Cnmh4O
	 csNI3mxKLngtduSN/PxBclFbmyq1wfryDz1oNmJhoRG+HviMEbfljmcRx/1W3Six8
	 Q+pq4OO/jgZ8CeyREt2Gyop8xJaUohClUFsZ12vdk/kM0E2ZuHD4dgYfUynM3qAl0
	 Lcw6ldsc85ugJdgkFuiqM2IJuKjCd8iW6cOwQsivZzTDR+tWgXynRwnqfxg0cPc/3
	 T+XEKYDnYR/5p03SRsXHqdYNPmD5SxWBUbtU08mVaMab1Be19Ti2CFaztr9f8eMVr
	 YEVd73+PEpytdo6oaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALiL-1rwdgz0XuN-00COD1; Fri, 03
 May 2024 17:35:42 +0200
Message-ID: <96d63b0b-3258-4bf6-b75a-06eb4f4253bb@web.de>
Date: Fri, 3 May 2024 17:35:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Benson Leung <bleung@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jameson Thies <jthies@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prashant Malani <pmalani@chromium.org>,
 Rajaram Regupathy <rajaram.regupathy@intel.com>,
 Saranya Gopal <saranya.gopal@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240503003920.1482447-2-jthies@google.com>
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Fix null pointer dereference in
 trace
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240503003920.1482447-2-jthies@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yj/YW07USmuBV9MjkhzGBia+bcNaIJntKJXu9vumv+qYPlcJymr
 ZoqrvdMMkgwaHsRgTLO2/eTcDaZ8YbCbnHlTel4ERyla/sZ64tgqjOkp8yoUmvAuJJLnKk5
 OxZOFQhw3BPnPeNxZyz7yQciu0VkWvkorpyre/ySvGHlz1jAEFqC1frtvT5EG8X387V+4Px
 ZEwznUUpjHUfDWRbjRqFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iGCIxF3wQgg=;hsLjBZes9cVDUUiMSLTqZpV6b9d
 gg/rh1d/+tk1whg20rdA6HbtmbrGb3/j0hNyygr9DxJL5fu8p5bt5LVcJzKvNDtVy+FVV8j+9
 yIbxTTLw3BTS3lOIWpIZOJI+ZfruxLKsjctvs6Vld3dXi0WHAe/yWr8P10KVAq5vHTJlL4TEj
 d7WR+zzz4SwEYVHo23FrSDRqyBnpJyV1EoXWexCKUn2dC9ShiDdZzuvZesJMY8rRu26R0wQVV
 xuWD/Ui8NePxHyFdA0sBhm13f1e7P/51obmyip06R9qhDxxU+H4tOcQnejgiuO+DdEayh177i
 3+/MC73evmrqMTvaBuHPWxHs2foyeFbsBXgbMfeTMulFvois1V32A91nR4Fir/TwEi9x2Wge8
 ApnriYcK6sTkJtI2882nIzV1v41CuEnf1Xmogadg4CJ1Wj+ZcJeVAfg2PsyKGLfxK5TgJtQkL
 /d7YRIOMcFdooKFXGxA2KnFgmQKRLK04nTNp9/V8mp94ZbNsUsjGj+XC9xhoMkHN8eAHYRGD+
 wXF5WQaZuz2LSUz8GK4vu6bBURsV026oHa2qIGMjCRqTnpS6x8a2Sw+Bck9M/BsmDa8kFrBfZ
 sLrOebq5BhJqnQ+HolMfQzz3cP/X2QaadhzRr1bmNgMv8qUwr8XMhZ6UH2o+tPVNc3eEw1JzD
 QcOWGT2cI25IP1wcg39FeFuW8Dzad95L4zdCoZbujxWSEr7/ZgMnxnpPgTDXdVDB1cdJFGmGv
 8WQ7PZYXKnwbZkpZW2YHpUAPB5Lw0UvmKHmQ7WS2IRtrWUyOOuaVxnVvKKuwFqzDKDXhZMnFU
 m2v6CsbhidYaGCP5UDW5Z23f3zSt6TI8/TdebQUQARQJpQMNIBYIckjz5lpKR7r1Lj

>                                      =E2=80=A6 which causese a NULL poin=
ter
=E2=80=A6

I hope that a typo will be avoided in the change description for the final=
 commit.


=E2=80=A6
> ---
> Changes in V3:
=E2=80=A6

How do you think about to mention also adjustments for the commit message =
here?

Regards,
Markus

