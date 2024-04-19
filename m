Return-Path: <linux-kernel+bounces-151917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B244A8AB5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663701F22A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0E13C9BE;
	Fri, 19 Apr 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TAwcgaIr"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB913C904;
	Fri, 19 Apr 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713556121; cv=none; b=sFDeexaUAnqbydQTOGnVwyFSps1LBMKrPsat420iaEGhGsB4wezsx2WRXQrzw3izi28SnyGacZHLB+eqikkZVou4h6bdJIbGCFx+AA/eKYD9IXcnxZ8qxQ+85MNJYTybXEwkUCISHib2BEBHxxd+JNQ07LjPsUoswamJsRAy524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713556121; c=relaxed/simple;
	bh=lcYzSMtqXOjiD9TMdZ2hUP6czF1+f1hwlL9IUcWlkcY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=K+dzHOzFlBkeAplRpSwWmL7qqXHZBU5B/kHnZfqq8wqH4DeF6MPx99gXlwgh5oTtlcUm0G4+IZMgwYhc0s9ffFAnG02pGQ4pG95qH66TT/VgBET4dEQrVhksYaiZT3/aKInldghIS8DfMRnUFWYHmTRVQpUtmAKib56uPp9rc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TAwcgaIr; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713556065; x=1714160865; i=markus.elfring@web.de;
	bh=0Uhmvl5HH++g4NG6yHvutmuZjckI/vNIFAeTfiT5pCY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TAwcgaIrNVdSRhgld6TxOdBMpR9dXAZBz6UohtK4Z/yAIHwqBxI/PlKJ3AEvstFN
	 +nr71guGIJxqUf+b8edLprQioYOq6LuHVG6nZsQezfn7iw6KVc7nFXGCII++dvL2l
	 XPoHngYDlkNfqW9ENLe6SD2z4iUHvY6C187YIFp7809i3yDrso3DWKWTFXiLfKoro
	 iyjQJ/9F48pkETV2W02alPn5J1vXQd0QXZz2elFhb4sveF+0ocOQEFUl+4MX9/ehX
	 NXxyO7R27082E2R1ovBFdFF+Xmz/vwQP45RpXoPCIFjW5LNxznKsCfgoBojozxLQh
	 rB0orFaLTrOgfyRyxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1ruf5B2Vuu-00HBKU; Fri, 19
 Apr 2024 21:47:45 +0200
Message-ID: <4938c547-04c1-448a-8435-1193e9c37595@web.de>
Date: Fri, 19 Apr 2024 21:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Mishin <amishin@t-argos.ru>, dri-devel@lists.freedesktop.org,
 lvc-project@linuxtesting.org, kernel-janitors@vger.kernel.org,
 Robert Foss <rfoss@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jyri Sarha <jsarha@ti.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil Devshatwar <nikhil.nd@ti.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Rob Herring <robh@kernel.org>, Swapnil Jakhade <sjakhade@cadence.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Yuti Amonkar <yamonkar@cadence.com>, Zhu Wang <wangzhu9@huawei.com>
References: <20240419113637.25745-1-amishin@t-argos.ru>
Subject: Re: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on
 error path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240419113637.25745-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lLMzIzXyrO29Y4hG5MWHuBvr7iCi/ITtAQTGuj37Qq1b+mSzK7k
 LLRmjMVCsrJdk+Vx/D1rpDJN4vVbC0ucZdP/jBD+M6TyBlcHNntJdeiz4syK5VildrZszk5
 p6meGtq65UIbDm8ccaCA6nBhSau9XOec2PdFAFDJrsJqU/1asG4s8Dv5gSW/5/d6WSLGaLI
 LNRFLhW4NfSJslqxpnn4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:56fI1Z9/xMg=;4MPoBHay5UWyp6BGOVng1VQFd1C
 nuxzNn4tPSYOiKdI7QHjlj2+DShWuHk9rk6BIUg28B1ZBzNaZG/vf7aM+M4BzJfw3XnTHR4RP
 zIXUww/hja/+I9QIx0pYR/Z7KFOTsYUdbXRiphtfaF00zmYg1Lz6tfehgFdhZybgwJ0qHK/KF
 teS4xL5Gpwyl9K4ts3ijG3t3Sl8oVRyd9yCkmfsNYLDxTMeOPRIkVwALYDVCtuONduOMCA6VN
 TtTUQeTaWs96eesI6ShpdewfyvRZIn7M0nBWOtcfCITnocajHKn70d6+lRqq55bwVG4GiDYFC
 v/Khidfc0iUm4TCAF3Cw6ZtKk6f2zWbO7HiyaLpJYKgIvWovGkmRBe/U/Bf6kVc9YAq/3UjLd
 qfuwypqLZePdDBDmBg/QZGPkQKUpy+aUX6vNqrCEgEIuzSpxJVL3KrJhnjnHX2OAeMRUpwcFa
 IJpVVM0jgWCjRmMrlgw1bd5lxLhl+FJpfSEMl6Y0+uHJsEDZE/YStj7zWYPpKE+TRvhL5VSsS
 kfvoAa8RMSV+7dvHWFvObXWwXHJRmMU6hgaeZPX26wHHbzp6wPkUEK9ol/5uOjQvXBsATBi/r
 pghavEOyWe6lOqeuMKmiebYqWAK94l8OE3mKQriy+1Zy8mE6zjL5K41XQ1MAe2oiqEBnYX7Wm
 Ke2h6HTVjDyIFHu3jfvCvovoKR4voSwqMX3gQ0sXI1IuaZLI76BlJKkOsAbtLf8u6aOfS0lKb
 e5PxR4QIqT+Oaprj/PYAtOnk2iU7oev+9bxVkUzMyo1jYv5jfCJl5yxyMNN/uFlmxpGhC07bE
 sbbWwtvvdVEnZ8TtlfQTcOB0PJ8j5Q4gFcPDzcVd0SSB8=

=E2=80=A6
> Add a mutex unlock call.

How do you think about a wording variant like the following?

   Extend the exception handling so that the missed mutex_unlock() call
   will be performed finally.


Regards,
Markus

