Return-Path: <linux-kernel+bounces-60671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81D850840
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E81C20E26
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0465915E;
	Sun, 11 Feb 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV9MdKRd"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A259150;
	Sun, 11 Feb 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707641795; cv=none; b=WYulM+oIny2nsM7VbT2j8x5xn8g6XaB974lpS5+FVNev2VpvNPLUoItyhNi1e4YWC9cTYZ3v9hcdfLXhYRguGrYjy6rko6HigjzAB4XBRF94PyxE+fFQ7SzqPPz+i3MOsGK8Qf7USxDrAGmmxh2V2zIR7P4RBxpzu8bRwTPX0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707641795; c=relaxed/simple;
	bh=C5cwjj5OUPe+LMG1Ksz0so7LB9nLFK+4LEY2R17TIwM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ucjc5Kt8Xowbxtm2wIQSfbqjppJJ6xohiku2Xes4l1zeDEmWYAVIqlj2ba2hNBalHFYFfXY4aXhGqVTw0TTVXjsMK0LdNUKShtr8sxPAfFKW1LroNN0ELG0OnV3Vx06wc8l7Be3MQHPVQ9hLIGhMfeqFAk8enr42+OToUfjbyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV9MdKRd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-561519f8698so1972877a12.0;
        Sun, 11 Feb 2024 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707641792; x=1708246592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rrqZM2NRH92oN2Wcrr2Xkr2NlpWpuW2V/bIVMwXzFQ=;
        b=GV9MdKRdPNBlz6zFtJSCVlHIFQKi9vaVKyHrhf5hgJ/kJL8AJ8DOzv3gmQ9cliHT+L
         YpOm1+hKXMgBvf/qZduOrVQneQIfoSoY46F4+tF80gW9I053CV8rq6ynmVo3wnFLglF+
         xsYhZ3ijwYEsGYdiKBMhZiN1N2iGosyDeyaMqiM4WUBiqsNLDXJasc2jme8khHrEjkj1
         tk3YodljhpQRjqfTGL9ajxtV+QKWFEAQO7jwXjmeQ+gj9Hbv/PwKzF7p3McT+fab2quP
         YogFMLx4PNaKwe9CqEMrRMu7PAhtmmJMvRGR4q/SX09v57T/ZZ+a8qrCW09bCNOY2DNT
         wwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707641792; x=1708246592;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rrqZM2NRH92oN2Wcrr2Xkr2NlpWpuW2V/bIVMwXzFQ=;
        b=ejiVKa4i8W6tQWCfawC3ZweQd02Ls0Mv+ABAxAxMIF/3PlHs9A6iBoNcZGZljIVqzh
         kdPSvjpeCvyh05cHNSTZTiN+s7yzPOm+RE+eKbObJ92hrh4i/jVhoFxdCqWgu7hATdtA
         5DHu/pw+sW6dco7g+IKixeVXSQ+2XEcsMJI/q5hgYg5JFyhcKDVfx/0gHRgM946I03wX
         gRmfqy/WRaERK0rs+mRMg48qO78cLDuZpCjAsozh/n04EIRDM1dMyYZgL6iclTxIVDr5
         9cSzXVe+2wT7neW2OQ6vuHAOcqi7qUAHco2pVii6/X4spUjUUZ6B2aC4RwxFWJ1om9bQ
         bYUw==
X-Gm-Message-State: AOJu0YwfIFckD+aw5trvexSTka1UFxm2uYtu9hS2X694xRtqWwQFkLc3
	pWYCqm5RZyYJhw720Q+GjWRqS+0Thx8K8LKJ9dWvEVHt4v1dCVl5QldYVBtj99ja5lAv2W1vmY2
	IcFCMM+gRvoshdHw8w3o9gBYHtcc=
X-Google-Smtp-Source: AGHT+IHFLXwCdh+7ms8i3jH5bZF+recXJ3JXnbhk+7rGnwfbaDFqQwc/HKBtNfPimX3VKzfzYI/CruasgSUdUJ0VP58=
X-Received: by 2002:a05:6402:7c7:b0:561:a902:6bd7 with SMTP id
 u7-20020a05640207c700b00561a9026bd7mr128011edy.20.1707641791979; Sun, 11 Feb
 2024 00:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Biju Das <biju.das.au@gmail.com>
Date: Sun, 11 Feb 2024 08:56:20 +0000
Message-ID: <CADT+UeAfCTd8c+dHn3mgT=g6Boip=oRPdkODMN_j2KaROcT0AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, claudiu.beznea@tuxon.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Do not apply the RX checksum settings to hardware if the interface is
>>> down.
>>> In case runtime PM is enabled, and while the interface is down, the IP
>>> will be in reset mode (as for some platforms disabling the clocks will
>>> switch the IP to reset mode, which will lead to losing register
>>> contents) and applying settings in reset mode is not an option.
>>> Instead, cache the RX checksum settings and apply them in ravb_open()
>>> through ravb_emac_init().
>>> This has been solved by introducing pm_runtime_active() check. The
>>> device runtime PM usage counter has been incremented to avoid
>>> disabling the device clocks while the check is in progress (if any).
>>>
>>> Commit prepares for the addition of runtime PM.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> This will do the same job, without code duplication right?
>
>> static int ravb_set_features(struct net_device *ndev,
>>     netdev_features_t features)
>> {
>> struct ravb_private *priv = netdev_priv(ndev);
>> struct device *dev = &priv->pdev->dev;
>> const struct ravb_hw_info *info = priv->info;
>>
>> pm_runtime_get_noresume(dev);
>> if (!pm_runtime_active(dev)) {
>> pm_runtime_put_noidle(dev);
>> ndev->features = features;
>> return 0;
>> }
>>
>> return info->set_feature(ndev, features);

> We now leak the device reference by not calling pm_runtime_put_noidle()
>after this statement...

Oops. So this leak  can be fixed like [1]

>  The approach seems sane though -- Claudiu, please consider following it.

[1]
static int ravb_set_features(struct net_device *ndev,
    netdev_features_t features)
{
struct ravb_private *priv = netdev_priv(ndev);
const struct ravb_hw_info *info = priv->info;
struct device *dev = &priv->pdev->dev;
bool pm_active;

pm_runtime_get_noresume(dev);
pm_active = pm_runtime_active(dev);
pm_runtime_put_noidle(dev);
if (pm_active )
     return info->set_feature(ndev, features);

ndev->features = features;
return 0;
}

