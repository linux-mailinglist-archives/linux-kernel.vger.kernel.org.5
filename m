Return-Path: <linux-kernel+bounces-140339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0538A1304
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EEF1F222C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB561487F1;
	Thu, 11 Apr 2024 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I6ZlEQ2J"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031A145B08;
	Thu, 11 Apr 2024 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835053; cv=none; b=VoX4WD+QhU+suzFmTQbBtOoDBvnUCAKdkPlUxii6x9F9CvtwNZhpLEs1o6aVUcuQLgM66kIC165Jseh/wvoqugxEhrNcvvAbDyirFUcMaaOzP9LHoexhmlfLGfSpbNzff2rxF6flcF9I22RLeYH0ncNxIaePrZ9R0wBQ/r0hYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835053; c=relaxed/simple;
	bh=4uxuOFC2LQMADBNRGOlEQBqFMMT+ww4A8mDJbPx4eGk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BYfPA+RpCzuIR2bvkq7tvUWIzc/l5d11f8AvyLdEeFo9rqMx8xDhmSKHntKFerMumiUtO6svOtUtU7+tcdihcD4+KDmUQFQm6BswA3P5ZhL93jQnD9TysO25fHZkrrqZz0BMqq3b2TPepKoXSKFVLGHVgTMdZTvIinlzqNY1B5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I6ZlEQ2J; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712835032; x=1713439832; i=markus.elfring@web.de;
	bh=1MsBQoKPQBvY56tmOKQbngcG97IfyuuH90Ag15As1m8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I6ZlEQ2JvSUikaceGmWfyc1DG7vRViPOuFxRwagGeKyzODQ8D2uybYbB+4aUFcgd
	 laELh9hB1A2CEjKNLRWm+Dg1dM6WTATFL1kTi8rNVb2/TPinmNvrk+FTP7vWFcb/r
	 T+vbA5bAw6UaS3IZ8NTeZfiPUzCEw670ZZzOetunK48vYAiq4yOx/80btN8fjSz++
	 Ja1QPuAWOmvvBKnatMsZAh2YOaqy0OMVcGf+KskdV7ipgPS0pAQWSbP11eRNFiXEm
	 dUjj0rkpjle0cFyxSts/qjPmcaEdap93vSs5GVj+sVMYezARcPEJ/ou/AONjcxRBg
	 xYZy+Rnx6ZSQ47ydYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1VF-1sUDBf1l3X-00dFah; Thu, 11
 Apr 2024 13:30:32 +0200
Message-ID: <505b6da5-93ca-481d-ab57-c246ad9a4eaf@web.de>
Date: Thu, 11 Apr 2024 13:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240411103724.54063-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: kunit: Fix memory leaks in gen_regmap() and
 gen_raw_regmap()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240411103724.54063-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G36xJVj5LcbfRx1/yNSc7IodjkuXRLfKxjiAdK0J1wkEvyjMcA7
 a0SCDCGKuf1a/dwgB4C0emJJ89KheufFpvauj6S9bJev4yaJZZmii5q9zpYGji4+CZKn2XM
 it3XzoHNSbkZrUDIHwqGoR8ncYxnjLhFXIkGFPGIyoTd2fHPbaXM4R9P4kx+xreGdSof93x
 iDGd9SlADc2eAfurdJ5RA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M614dYlKZ94=;o/oEVF9NGqD24Cfy52KMSmY5Qd9
 WZRy8PZlqsv7dnNRTROG+xZhf7PvxvfC9KgxF/U0/SHKv5kPjZbVBUHPoDZRFfTKQdono69kR
 DezKnsjGYrjC0unjqQIkRWzAjTw2fWhwTh0Dzvh8WakzG8XJ1uY7S0R87dTvbhPM3+JRzYn+s
 rGxoBkU7FHGYPaDDpDu/dpESrMRSRlSTNWYRFzSImNhujATfEiuOrjljM3pXyV6zJHDmwNgCa
 xIVkOVQ9sXR05/NOBu3fmLNQ7D5M655jIp4bJWard6BON3HNAUOz9jct+BpLsb8sWMjPCx1uv
 1bnk0obzE7UJgakmBvlRbu2Ylnm4duQrXKKnuP2As9qKr1ZIR4WIj3tOoLiQxNVsOMrQvCl6j
 K0+RNcpEfnP1IEDXwRBBnTdNLb55vdtEecy8RgGafAEK6bHuXkkKizyTMXTehfkfF6eXmg4Yv
 2rU6Y54r/U/Gyy3ROisyHJaaEcnp8wmMzUBZxP0RGdQpUdzPA7JSmT9LH4P4XD6J1lpoWFET8
 wWKR5htqpp+RwBlJW3dMP5LiQAJjUxDruB4djImsmvF408uSUdBTFjlxWNYYNhmtvLKGm1qGn
 DTvQJvsqoIHja375XJ2qYR+9V8v7A+qLvxJWjFn7G/dpolkTnKg8YbqhcuO8vQlNrPdpNa0OB
 J+DuX7BSYjBNdir56zNHwBlo4rzfyPdnkPY7ZJJnt5v7CMp/plZJVVxyHwJxHfXoOjRb+K313
 KdnZ5dWdaTiN5aSlARby4YclPLyfO5xcwRUH8gy2zUUKg/NSNRdVl4kjBqWOlhMuGZ9+I3GWh
 6rB0ACqdv9dlJ8FT6sSFLWTTEjykNA+XoeK2Er5IQTJtQ=

=E2=80=A6
> - kfree() the buf and *data buffers on the error paths.
=E2=80=A6

Will development interests grow for scope-based resource management?


=E2=80=A6
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -145,9 +145,9 @@ static struct regmap *gen_regmap(struct kunit *test,
=E2=80=A6
-	struct regmap *ret;
+	struct regmap *ret =3D ERR_PTR(-ENOMEM);
=E2=80=A6

How do you think about to use the statement =E2=80=9Creturn ERR_PTR(-ENOME=
M);=E2=80=9D at the end
instead of the extra variable initialisation?


=E2=80=A6
@@ -172,15 +172,17 @@ static struct regmap *gen_regmap(struct kunit *test,

 	*data =3D kzalloc(sizeof(**data), GFP_KERNEL);
 	if (!(*data))
-		return ERR_PTR(-ENOMEM);
+		goto out_free;
=E2=80=A6

I suggest to reconsider the label selection.

Regards,
Markus

