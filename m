Return-Path: <linux-kernel+bounces-155102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2898AE54B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B673285B25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C713B7A9;
	Tue, 23 Apr 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhwQ9K3w"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C586254
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872976; cv=none; b=lqG7dIWMs5c6zp20rBXk+YZk8+RDDKLJcvg8EFtpBqahGGSrLNw3IIRF/v1a6JrC+Ew5SMBtjFUSwN5lNj03cCFk136wVkwxtycQ6CGrT5GNRrJx1eoCr6WutdddhzxLNh5SvXqOtgxI6zjY152ydD6zMYcRgO4KdSUpQ1OhWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872976; c=relaxed/simple;
	bh=1+tVFk2qh9vDf6i/oCpUf/iYwQSby1SpP3kGFsH83w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcXAvnpNkJg2dzyXYNNg5V3ZQXC02nuZO+bP5hWsj3ZGdxAlee9w7xlrQLTNgaURm5hVVr6/3NCxlUVlB7I74M03+Had0RtbjxoxkIx0ERs/vpVHu+RbxjNkAq4Ap8pdXDOK7J8YvBalPUNoH24YdU6AJjHRidAnAnIr1TDx6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PhwQ9K3w; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de54cb87998so785441276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713872974; x=1714477774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+tVFk2qh9vDf6i/oCpUf/iYwQSby1SpP3kGFsH83w8=;
        b=PhwQ9K3wTv/tOidR7xEmuzgYq++SQLqEFyu3P1moYEtakkdbIPpegV7720lNsMjdR5
         R5V/FFfs+I7IWOwntA+tpI8tgRNP4KLpzTt0D2BeMnksyvhl/beiQSEgR0VzPkVf1PZ5
         areFGS6O9iqucvJXSa09cdCdX5iOFDdNxHf51f+vAHvuyGr5gDBCK/OTY4q0evvyz/Cm
         GFM7GujyAJUF5mGIJsXkEDICYBihgdyUgsfqoVps3qGWXNq9hpGzAVwC54Fuzn2QhI5C
         Ihz8smdxyQZiKLkI1YU1JIcWAmnhg6yoOb7DtyNSKVTkuL6SndXPriP45b0SvI76Rw5G
         2tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872974; x=1714477774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+tVFk2qh9vDf6i/oCpUf/iYwQSby1SpP3kGFsH83w8=;
        b=QtSkudl9/xc0FqN84+KkkVPM2nlU6NhhvwaI4OrIxJL8/c0IrfDnm8/ZRXzk6JZNwD
         kUU/o3/6K4ZjNdqQ8we7Pq8aTuKOyJmiDzPeqiJHcZrlx28Z95iKmpDvIQLuZay8PAeX
         ZPMLBLhGWhlOMy4GLMaZFlwC8mcD85MiIO84+OB8eg8r50/bm3ZnEK3c5LvOWM3CqoSS
         5tIcRtLepEXqhqReKjjZ8OqdXkwL/Gqtrtey54eDGGHRGdFtyzhYdxj95PsupkFhPzFU
         WmCCNfmuWXQQzQvRv3ygeHmlVmuWfwf8v4BINt66EIHHuCit7Xs14ejvAl39SSW/+S+N
         MVbw==
X-Forwarded-Encrypted: i=1; AJvYcCXdsPyhZqSierzy+/5uSCtsGjfq4x7WtPgCQjCFLxvf+3PbsNWY1t0Rg0xqASk5FnItb9btMEU/t51LT7uLFF9CLHnGOiKVomuYlVZk
X-Gm-Message-State: AOJu0Yw5HikqX4Liy0oRLYi30E9iuRSeBXIEiE/KtThntFItNMgv5zth
	gZTxZIUE2xSaQ+uy0aSDnnjQEuvzRmozZcSPEQpXAXSypTdlo+hSTfJp2tw/qXYi7tJg/PQHt+q
	mEmC/lbRI9w2TXBAa1dP6WgNdFwR61NiiPxM6Hg==
X-Google-Smtp-Source: AGHT+IGjDBUQYz9+X6SyEzZZeSMEDVf6Wbxzl8++aRZfjMU/+beIUpWnIVO740sZRKFFSeYQTIPRPMPFIKoScm0kEdQ=
X-Received: by 2002:a5b:651:0:b0:de5:4a91:11c4 with SMTP id
 o17-20020a5b0651000000b00de54a9111c4mr2558198ybq.44.1713872974438; Tue, 23
 Apr 2024 04:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
 <20240423-for-soc-asus-rt-ac3200-ac5300-v3-4-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-4-23d33cfafe7a@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:49:23 +0200
Message-ID: <CACRpkdZQbromhiebf6-Dn5zYxu13RLfPjgUf2b5FYH3_FrjsHg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] ARM: dts: BCM5301X: Add DT for ASUS RT-AC5300
To: arinc.unal@arinc9.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:51=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 R=
elay
<devnull+arinc.unal.arinc9.com@kernel.org> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Add the device tree for ASUS RT-AC5300 which is an AC5300 router featurin=
g
> 5 Ethernet ports over the integrated Broadcom switch.
>
> Hardware info:
> * Processor: Broadcom BCM4709C0 dual-core @ 1.4 GHz
> * Switch: BCM53012 in BCM4709C0
> * DDR3 RAM: 512 MB
> * Flash: 128 MB
> * 2.4GHz: BCM4366 4x4 single chip 802.11b/g/n SoC
> * 5GHz: BCM4366 4x4 two chips 802.11a/n/ac SoC
> * Ports: 4 LAN Ports, 1 WAN Port
>
> Co-developed-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Tom Brautaset <tbrautaset@gmail.com>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

