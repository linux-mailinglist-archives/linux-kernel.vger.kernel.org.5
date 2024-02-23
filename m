Return-Path: <linux-kernel+bounces-78943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF499861B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE41F23603
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CE142645;
	Fri, 23 Feb 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="S5orX8jO"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFF13B7B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711562; cv=none; b=XLuhS2VtPTZtghvbKSg2ThiOQeTDVw6v+Gu6bjh6S2CbnauhFOmRZTfzt7LGatRp3IMltAHF1hJEBbjwfwrsnUAQSE1aZ8jD9yMd/ovuNvVSctDXTlhxMLQG1iTSlbQ8Ve2hQemOsQakbH6TWVrIs2O0kVGxsdwtM22qp/tZUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711562; c=relaxed/simple;
	bh=Y5XUwzOEJHKS4yZKzHFPg/WPx2l+ZlQLK27C/DTc1VI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+K3jh/A10J253l/mfFwaBEGXgUOBSpbXahoj4JWdEWJMUH6GxD+yZlA63UkFPqPD4ZPB0b1m0xonJf0BKU4TWzRUSwomo2/EVZDmhqCYefYWqY6He+jLZIAX8mWywcbrEb0aN5z+yxfvH9WE7bj/hTjt5/nmtq/JJRC8j9UDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=S5orX8jO; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68fcedcf8aaso5051466d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1708711549; x=1709316349; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5XUwzOEJHKS4yZKzHFPg/WPx2l+ZlQLK27C/DTc1VI=;
        b=S5orX8jOIDzSIHA4dIoj4PTbmzBxalumC0GyU1MorQ+gnN3zK41Ph12tT6hf+vFBsu
         sfHGcp/HzRsUKpysFYyLA6eFTN0rUFlaksyTYv44oN+CwLSOYJf6bWgMI1na0qLQqHyJ
         NBtjepbqp6TYTd2pul+eyVVfTKV1/WKafIhFIQ8SerQwc0S8IN6NPDWhiLd6FXMvuYVK
         QnU2JhkOookv0oJ90ecShpaBj3yjDExmKxiBCiwrsl+Z/UL1SKFVUsH6sGnNRvEY/FhK
         0bPQuXBvq75soPxIwod568BLtdWcz8VZdrWvBU9AhJEpoa0vDa3A+3knPnO+P2Evnffk
         4OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711549; x=1709316349;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5XUwzOEJHKS4yZKzHFPg/WPx2l+ZlQLK27C/DTc1VI=;
        b=mFRhMs0I2Twbgz5yBrwBE0G118rCUzCt9XgbDc/sKcTq3Hb1fyZUE/fGB/yUdIICtL
         CFgEi1XoI5uHVgMND4cp001pUT6W9pxzPwPGd9kJPyQS59n7m7Fh7Bh2ZIPIRn3pqtDA
         bIlpWL9WBl7rDTEhz/KJevaH3JJQqeZXHf7lDC/B8Q7AouIOYeSR/0vbKgcIaA1ks6IK
         VUNJ6R4p2z/mbcWn3L2woPTqwwFNDEijn9d+5JaZPOpN1Y6dcW3VD3u6/PXgbPf2vkNq
         gw1LOhMNAAeyfL4PHbN5Pm1zA8ti7Uv9qEGfmWiPkRcBJkvBsZwaKaTW7wq78qANnwMb
         s4hg==
X-Forwarded-Encrypted: i=1; AJvYcCVWn7lin5/GFGwziVooQs06dx5n1jxQgDoLqZt1wgv90lzXRSMH1NNGe0C5AItv0lCXGRTP0fyFEPrIL9vWjOaoNnK/VRtNqRWbd84q
X-Gm-Message-State: AOJu0YxLXZxPopNYno2Z5Q29OXBaxvGNiK+uEVrqfMLRwJQ1BtI0zq5g
	3prVIaZgNS7PN8sKU467/kignHFgOpkBaqC6dv5zG5lh6zFwGcvtLcZgQaJjKVE=
X-Google-Smtp-Source: AGHT+IFg5tLSSZ1oj64RduOPnFb6tI+hSW0WnXDhrf61gIK0Tk2dJHHeNwXn5vd0st5KyWpzAoBboA==
X-Received: by 2002:a0c:df0c:0:b0:68e:e3be:5217 with SMTP id g12-20020a0cdf0c000000b0068ee3be5217mr573918qvl.30.1708711549489;
        Fri, 23 Feb 2024 10:05:49 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id qj9-20020a056214320900b0068f914ac80bsm4777919qvb.50.2024.02.23.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:05:49 -0800 (PST)
Message-ID: <f42f0eac57f8bd4ae7b1f126c351fbf6a44c6643.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	 <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
Cc: "lafley.kim" <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	 <b-brnich@ti.com>
Date: Fri, 23 Feb 2024 13:05:48 -0500
In-Reply-To: <SE1P216MB130310210B09C0EBE3B901C8ED552@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
	 <SE1P216MB1303CEEF6DFAB5FA7C69D645ED502@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d5546b48ea829316a8dbd2ecc27bbf05e70e8188.camel@ndufresne.ca>
	 <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <be5ce95b023bcff24f53fdae55763bf4a3f6b1d7.camel@ndufresne.ca>
	 <SE1P216MB13038F3890F8B4597465B394ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <SE1P216MB13035B8E53454881C87059B9ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <060d634c4c707c9ed93f0d97816407b0195daace.camel@ndufresne.ca>
	 <SE1P216MB130310210B09C0EBE3B901C8ED552@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le vendredi 23 f=C3=A9vrier 2024 =C3=A0 01:06 +0000, jackson.lee a =C3=A9cr=
it=C2=A0:
> Hello Nicolas
>=20
> There is nothing in your reply, can you send us your comment again ?

Thanks for the notification, I've suffered issues with my email client it s=
eems,
I will reply again and hope it will work this time.

Nicolas

>=20
>=20
> thanks
>=20
> > -----Original Message-----
> > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > Sent: Friday, February 23, 2024 5:56 AM
> > To: jackson.lee <jackson.lee@chipsnmedia.com>; mchehab@kernel.org; linu=
x-
> > media@vger.kernel.org; linux-kernel@vger.kernel.org; Nas Chung
> > <nas.chung@chipsnmedia.com>
> > Cc: lafley.kim <lafley.kim@chipsnmedia.com>; b-brnich@ti.com
> > Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resu=
me.
> >=20
>=20


