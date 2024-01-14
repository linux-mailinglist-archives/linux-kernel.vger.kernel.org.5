Return-Path: <linux-kernel+bounces-25541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7882D211
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C0A1F213AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856014010;
	Sun, 14 Jan 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="OqV6FvjD";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="AcJGB87P";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="Z3IkPjCm";
	dkim=neutral (0-bit key) header.d=automattic.com header.i=@automattic.com header.b="lsCbvzNq"
Received: from mx1.dfw.automattic.com (mx1.dfw.automattic.com [192.0.84.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A010796
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=automattic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=automattic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx1.dfw.automattic.com (Postfix) with ESMTP id C40121DBF3B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	 h=x-mailer:references:message-id:content-transfer-encoding:date
	:date:in-reply-to:subject:subject:mime-version:content-type
	:content-type:from:from:received:received:received:received
	:received:received; s=automattic1; t=1705264699; bh=JK7HNffr/C9T
	rH1PWI9+u9zScMQVF+0GyVoL3PqcCQM=; b=OqV6FvjDt1USCqae+o6qk/PRjEoX
	7XsyZn0Gtqmt1h83FJRjp0JPX7Qns5ogreKxoNtrPbkQdQiTbB7xcj6sItv91zL7
	xFjRwRggJ6zrC9vySI/pwMGPvkNf+8u1BkgUX1/5HdkwoaynGc2hhpO2MIVSr0vE
	ZnYhGuMEhjgAIiyB2OxV3CBkpj6DSP6H3zHnII+5SPPjWTECVMD6Nr2ebersmwXb
	oiapL0lMkkklXcW8ejDbQQ/oY/0W5AKECKibCYDsPzKMuCRhF3IDv/iPCN895rE5
	zkBvFq5z0Aa4sUMDqJ4N5gSYfQZtmqeyug2GARI18LlsDtsqw8F6OKdnBA==
X-Virus-Scanned: Debian amavisd-new at wordpress.com
Received: from mx1.dfw.automattic.com ([127.0.0.1])
	by localhost (mx1.dfw.automattic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0JgNE8njSbtO for <linux-kernel@vger.kernel.org>;
	Sun, 14 Jan 2024 20:38:19 +0000 (UTC)
Received: from smtp-gw.dca.automattic.com (smtp-gw.dca.automattic.com [192.0.97.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.dfw.automattic.com (Postfix) with ESMTPS id 258BD1DBF1B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:38:19 +0000 (UTC)
Authentication-Results: mail.automattic.com;
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="AcJGB87P";
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="Z3IkPjCm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="lsCbvzNq";
	dkim-atps=neutral
Received: from smtp-gw.dca.automattic.com (localhost.localdomain [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw.dca.automattic.com (Postfix) with ESMTPS id BE532A073B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1705264698;
	bh=JK7HNffr/C9TrH1PWI9+u9zScMQVF+0GyVoL3PqcCQM=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=AcJGB87PY7J7bgtdT6Ft28aXI7lHxeWCrVY0/nQtwk0l3IN+KWNKzKZLLJwSfNl4h
	 Ez5FULksF5Jti6xFAGVwx7du/T/sJreuiHWFpJu0GCls4SA3Q0b1haBFYqRkZfFSKs
	 TkotAB1eYmoHPRBeIgLgrck2lVg1iRzNdhYh6K5J5v5n5RtXd4GlqqqDTs+0A3gOu8
	 s5Puw5WKv7qq2gDXyS6EH7R1L5/fLpTB3YCMqqfbHEvk3Z9ent67EETsq8SfcaF5Ht
	 8/lRJmKv4uQ4kbq0a6SreXLZfJNYsQT0BiktUTY1aVcjrpehqR1Cn+0YJvd8Zyl1Kg
	 10nxd8ScieUeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic1; t=1705264698;
	bh=JK7HNffr/C9TrH1PWI9+u9zScMQVF+0GyVoL3PqcCQM=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=Z3IkPjCmJT8fsZmEadfr9N2xAH3YyoQYwq2nmZWYC4aw4oB1BD4OnqKEU4h1fBv6Z
	 ZiELs71zBJUsuB+83E7xBipyQGoqWQj39sXz7CJLX/dL9mrk5kHaVqDzzcjNM0qb5Y
	 B8tGPMNi56GmxdUHARWLRPkFbJtLCMfsxsS2CijVp1PtK6AmT4gC0882FtI3EV1hTi
	 xEs9o0WalnNYsNHYmk95pjnvRxqmYovYPS4Qo8Wc8gJK/nSOUNePvqA6pxKLpPb4xb
	 uQLuIUtPrtSpcs7UcJd4NCoR4Nl/v705uGQYiMm4Yi12YDoM3V3Z74ls4QKVw0WHNY
	 mzj5fIZ4J0qUA==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw.dca.automattic.com (Postfix) with ESMTPS id 9C1CCA025D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1705264698;
	bh=JK7HNffr/C9TrH1PWI9+u9zScMQVF+0GyVoL3PqcCQM=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=lsCbvzNqO64yKljNAOkvjrBNvWz5jD7CilTQhedoP7i1ns+fhKCMzAdkb2uE0XAWf
	 HVWz+1pvC7nRCA9UXoHdQMIcqhqVkUD1m/FZn0JtgrAYNw/EM8fT9PsVipAJHofkQN
	 VI+Af0m78URMzlt+SK9I40oaOYRXLUChzUP0sPbh5tBEHqXF2YnbRqZVcB85r1GZOr
	 9MxdEN1LybZNhcR0bwrkXHEDUFfinOCUi9MrDbEBRpKrqcrdvZ17AEPESjZKpZzN7e
	 RfaJzeULstTjWaoST+KqsmyTeosxctkGfIY+TLzV640UCK3OyanzuDNCmQ6YqhJVa0
	 6zir0W5WIDsng==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3368c707b03so4775483f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 12:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705264697; x=1705869497;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK7HNffr/C9TrH1PWI9+u9zScMQVF+0GyVoL3PqcCQM=;
        b=KCkBinuy4axOsEWu7KHDpwWnM9w7SB/MUaUpDKXBf6sd/bolShVdN7EaJE+yQ3b27a
         nWrCj3wBw7cIjv9yaqFDpg1boBCRC3Lw4vap2P5etdwUha/fs+tdCmGAocEgse+tfC6g
         StvZJqWk9Yi0kMiM9pA3Y0qg8fJIPdqX+0Kg5QyLCP+/MXaHsbelSb4pEixx/DzffPax
         GJFI3JJdKka9MGbf182RsDGzPt7WVLfIF+KrAj6ykGM0/rPYxkL/gGW8Vvy5dPeBVPo6
         skFI63ywG/OcEtN8PpJa2beihKUa1QgnoWfEG4sTydx0i6nqcS9wnO/x3YyrnA+45WH/
         TxBQ==
X-Gm-Message-State: AOJu0YyDaCtSASy/pnZxU/SykVRJZjG/Nh++p/PtxbNfa8hWXdRzDKc8
	C0y35K3WJGC4i3B17VA+WVwC/MMu3hjLc23dZiAu3glkXDU5cRkzP9mv/PtInoKu1t36sR6O5hN
	cdIi0zt0pAln7VV6lQ+RgwpxNuWu6voX4
X-Received: by 2002:a5d:6743:0:b0:337:989c:15c with SMTP id l3-20020a5d6743000000b00337989c015cmr2462788wrw.90.1705264697782;
        Sun, 14 Jan 2024 12:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI49B2lNvsFdpJLZUO65pJcLhGGni6QMQBRlh0oMxGwKa8sj9CemFXPIqh/9AI0Gb1S285jg==
X-Received: by 2002:a5d:6743:0:b0:337:989c:15c with SMTP id l3-20020a5d6743000000b00337989c015cmr2462782wrw.90.1705264697493;
        Sun, 14 Jan 2024 12:38:17 -0800 (PST)
Received: from smtpclient.apple (2-234-153-233.ip223.fastwebnet.it. [2.234.153.233])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b00336898daceasm9906403wrr.96.2024.01.14.12.38.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2024 12:38:17 -0800 (PST)
From: Ale Crismani <ale.crismani@automattic.com>
X-Google-Original-From: Ale Crismani <ale.crismani@automattic.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Performance regression in ip_set_swap on 6.7.0
X-Priority: 3
In-Reply-To: <41662e12.d59.18d0673507e.Coremail.00107082@163.com>
Date: Sun, 14 Jan 2024 21:38:05 +0100
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
 linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 xiaolinkui@kylinos.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2070167-F299-455C-AE4B-5D047ABD5B28@automattic.com>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
 <20240111145330.18474-1-00107082@163.com>
 <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu>
 <41662e12.d59.18d0673507e.Coremail.00107082@163.com>
To: David Wang <00107082@163.com>
X-Mailer: Apple Mail (2.3731.700.6)



> Il giorno 14 gen 2024, alle ore 06:30, David Wang <00107082@163.com> =
ha scritto:
>=20
>=20
> At 2024-01-14 02:24:07, "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu> =
wrote:
>> On Thu, 11 Jan 2024, David Wang wrote:
>>=20
>>> I tested the patch with code stressing swap->destroy->create->add =
10000=20
>>> times, the performance regression still happens, and now it is=20
>>> ip_set_destroy. (I pasted the test code at the end of this mail)
>=20
>>>=20
>>> They all call wait_for_completion, which may sleep on something on=20=

>>> purpose, I guess...
>>=20
>> That's OK because ip_set_destroy() calls rcu_barrier() which is =
needed to=20
>> handle flush in list type of sets.
>>=20
>> However, rcu_barrier() with call_rcu() together makes multiple =
destroys=20
>> one after another slow. But rcu_barrier() is needed for list type of =
sets=20
>> only and that can be handled separately. So could you test the patch=20=

>> below? According to my tests it is even a little bit faster than the=20=

>> original code before synchronize_rcu() was added to swap.
>=20
> Confirmed~! This patch does fix the performance regression in my case.
>=20
> Hope it can fix ale.crismani@automattic.com's original issue.
>=20
>=20
>=20
> Thanks~
> David


Thanks for all the help on this, I'll try the patch tomorrow hopefully =
and will report back!

best wishes,
Ale=

