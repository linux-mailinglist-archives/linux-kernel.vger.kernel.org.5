Return-Path: <linux-kernel+bounces-146706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF48A699B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ACD1C21396
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B611292F3;
	Tue, 16 Apr 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h1jUOVt8"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4553128377
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267057; cv=none; b=i0kDfTjAXiPcRcsjDT5Tm9aRT+WT2vBzdEuX5tZ1GZAhbmVcI0TOWoAJB/okyzqF+e7FBy29+z6r9bZ2dmYNMCwFCxKpkem7TiYMbkpZau/RTKMDw9WwURUeu3lbYtsI8XLG16yqnlmTA02I0GADObUVvgaEclap5EtoxRs766o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267057; c=relaxed/simple;
	bh=N888Vi2v/gIrRrGTwP+q0Ij5XcDW5hFV69u/W41eNl0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rtls+H08NuwAE3n0gHlr7wIT/OCVCh83D+FOLX0RUpv23s9hKArF7RluVc6DjknsscQsN8hCuu6uvygfKCpnWj9xfO7Sb0BQbMG2YxFjYW4qGMFAZ8d4KScsrjcXD4YQmorpGLNHloTjCPoXA+G/x3Gzus5Df/ZuZSqcev6lcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h1jUOVt8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713267032; x=1713871832; i=markus.elfring@web.de;
	bh=Ui7l+SaHrHq3cSvKjv3JWxTa8MuFN1eFiOWgpWl/TPk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h1jUOVt8p8foEsAuJlb0m9wGaFUYv/ABNZ8iizwoOTQpAgmqjmh3YY3pQNzfCrPW
	 tgw0L4FX/mAfqU+oZPlqM9EZnZkHiE8meZIjv3yB8TGDy2Vp2JFVgp0zAfaytxnNy
	 cuQPHfyuxte3alBtfwnC0J1W1rQb1Dw5YWxhfJF5BlHrOA1X2L+ZHXgcV7/1e8sPK
	 m0tHa8OSpEQYTKf+Ckg5MaO9uqkZtcoo/xmqEljCD4xq0aUNkhAbr+m1oxOTBhYIv
	 aKvDOxPYeH83tIALVHUCZTRuY8n7d4jiCFUV4cL+4j55JUWKs8phNH5wnI2nOzjwH
	 vnuGyy47qXy75dICNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sFx-1soNdf1ZEN-018KM9; Tue, 16
 Apr 2024 13:30:32 +0200
Message-ID: <fbf22b53-7b68-4e60-99c7-ab38a77a53c8@web.de>
Date: Tue, 16 Apr 2024 13:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Denis Efremov <efremov@linux.com>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Subject: Re: [PATCH] coccinelle: misc: minmax: Suppress reports for err
 returns
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240415-minimax-v1-1-5feb20d66a79@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AFMKKd2u0wM3PusYJITwpe/1FJ5meZooU3ZIXmvxEeBtK9lezd0
 6VFMRoMDB0EXqhsmrLaofR8hPVpNZ0FT6xdD9wRg9Byo1P13A6oNd1X+vFRcskTkLNgVx+h
 zL7s0ztZevVeEi9960bbTeXNMC/DI8BzZpXUMEFHAIKl9OHre/JzvN/VFy0v+kJV7oI7Vvr
 /I5Or6QYRl1IXVhRTQRTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/VhDKEAz9LQ=;NGRQehjoXDtUOn6caJ5wKhLZSgY
 9bSn4OQ/r7h2iqXjiwUJat6VipLNo5yIb3Nj3oGQU8jCVuxg3aifeN5cotH1F//nszHKWl4zq
 d3s+76i3jSh7s42B7uY/vWbRDKqTz+toI6iAQfkKUYX8yqfl2Xj+1ZXVjInvCHwNdJie1TRUe
 HJ66RMMdLr+8xmzojlAPdrSj1ZqlV9vK19smQvccbOH3HKJAvOkQ1/vSxNtmrFNFjbeKBj957
 7yDdqJfobRPHdANhWydeR/qlo+egV/7CJ/5Ht94PanFz2mMx9Tajr3aV8ccChvUuqiGGRrI9d
 sWZwVySkbB7P/YpcwcBeXIGobYqHiJkwI7HgALkJKOF/4LGVJbNmSeJ4k7MkYCXKhuqykEa0k
 3U+qRBI0UT+EDtsiXe1lq2c0vVCTUIxRAcWKz2zEPZifqKukPqj5BEj+7HCVUdktsmAz9tD3O
 g/bHXnOCeJhZZUyH9EGOlum7JYe0Yw2l417M5QLSehlNwXQr4gKL3ZQl/VLm3c1u2HkOwmzIr
 vPt0IbwCXSbJmdivC2ryqFiYgs7y8+CtRj8Cdxy6YwqSreZIC8dG5zF3hYa1xfp8rguvnDWI1
 SyociTTgQEL2aEXPlVc0U04HSJPlIPeaPOfZJPZBpQuIFCs1U320AcMfxwCDmBfjudNGb4AEB
 9HngDj1fCJZSRfcg57JEHvomgJXoWbJUs1OdwJyM7akDG9OuCAA556JoEm/5VMiy40j08koSl
 6Up6RNOMUXovjEvUU+9FyO34htIgKhe8eGIzqm3BXUmRMFiNi+B+xcvFNo28BUM290zyP4Pbu
 k8eODGJB4ie0YW4mdGvME87mUcdubV0LjBMFhMaEFBdFk=

=E2=80=A6
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -50,11 +50,26 @@ func(...)
>  	...>
>  }
>
> +// Ignore errcode returns.
> +@errcode@
=E2=80=A6

I see that you would like to omit the specification =E2=80=9Cdepends on pa=
tch=E2=80=9D
from the previous SmPL rule location.

Would you really like to influence and adjust SmPL code any more
according to affected coccicheck operation modes?

Regards,
Markus

