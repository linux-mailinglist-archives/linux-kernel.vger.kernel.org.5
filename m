Return-Path: <linux-kernel+bounces-164366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811AB8B7CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58251F21BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FC2179954;
	Tue, 30 Apr 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="16Axr43u"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC73173350
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494423; cv=none; b=DBrsvnXHCEkDZXfThLf/087oW6s3VfDoF9uT0+J2fEAkD6A/hsrB1oa7auDGsgBFzt3qdV9Vtvg2H+XfDXGNBIXPJJExpmLYxICYgNKaQJf2Y7J6yyN1Pgsd6z5B6UlhozdXMahb6WU9ZIopep6KdqbvqCqE8ewioE2qF6wBQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494423; c=relaxed/simple;
	bh=he8m3D8ERV3+ZM39Fi93bNF7eApo77thjOFwsQw02Jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlXXsXLUmFI0KMrQotjENSYUmBSbiqAnKKlWTV0Y1z4QKe0Lk7xv5/ycgI1WbJn4SnEgYKXJXcYOfGvaz5kWjTRRoWdGqJlB0SbEHjnyv2Zlo9t6Xkod7pVS4jxNe+aS4i2sjcZBSNfrWDeHidZDBR5ZGCkVv6SUMQJps01SD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=16Axr43u; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43ade9223c0so10192961cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714494421; x=1715099221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZC7KljP54si9I/OvR7p1QytBPv8oCv3FFtdLpBVVIEM=;
        b=16Axr43uV02MEX/z8YUk5KFhdk3HpMRW5WxcgKJE6GPHIhsUwc6D4ZLIfewbLLDV/O
         SbQNupHZd47oX2VD9H2bdrgwW4Ys96mNsbmb3XAm65O+/riJW9C/p2ilgYZJCCURjnd7
         0juX4UWBW7NCnZzUG2opJW4IPUY/RcoBiOF81uTpj+QLb3Oc5ZDU1eGUYctrjcaK2K+7
         wHkIb3vG/b9V5YhmexaH8VpJSCwkQC8zRU3qyfYeZ/iQqhwfI9ssoRO0NHuI1BxZ6cvF
         BF/zxruXcjizgRzZYzkcpZxOwdaPvML5Ywo9lYjP+64aTfWAp54dVcsB1bhkXxdlv9kg
         oOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494421; x=1715099221;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC7KljP54si9I/OvR7p1QytBPv8oCv3FFtdLpBVVIEM=;
        b=kLG/bEV4E0PGWLlD8wohDKAum5oROe7EJSwPKBs6lPl/JwnjLjUHduU1IAiKXMlHlT
         BZQHBD0VTjtLx0tFGcovjqQlO9ycAvPi0Z9Eo3y4hb+Cn9KDFEg1jjA48D9G8ssn8Hvz
         GVF5qYbjZhcyzPj4CyqIXERK7uAOxpW7QSSuLc+d1+MC4TCfohY8eDynAfo7732EQovr
         IoEu12lPcAAR6gmxnIPLm0lpthZ6C/hE4O98/194nLs/4STCLdyBEyv0/aj9juMJHbW8
         3vWnC32vhkCqdYpqLzSoGGi8+CT8oOPmKuj0i3xl+YB38+Z1wCai1RWoSsKW9cjYsZ1u
         FExw==
X-Forwarded-Encrypted: i=1; AJvYcCViWGDu+oN0kPxmt8ytsZo7K/9GFBpO5T3bZVEG2S1/42sLiE3hPrg/q0IIAOinzNbGTVJjdPal142pbpNj9BVzOR++69sP0EZ1sIOV
X-Gm-Message-State: AOJu0Yy3qLgijdXsXqY0MoHO4o3tknTpM+FK/E0Z+Jr9Cp1bbQaKOfba
	scRt6qDKZD5C0PU4egWRdl0xzYmYKS2f+FsMZ/YtlG232h5ojKG20bMHgQvJ1kY=
X-Google-Smtp-Source: AGHT+IH4i4XqXX+ome3EmdELyywbvX6TD934yBgrF6DZ4ror/4GM3Vhte1p+vjOEJwXaTd3AlXGjSg==
X-Received: by 2002:a05:622a:491:b0:43b:a44:f83c with SMTP id p17-20020a05622a049100b0043b0a44f83cmr5414263qtx.56.1714494420540;
        Tue, 30 Apr 2024 09:27:00 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id o15-20020ac8428f000000b0042f04e421d2sm11469789qtl.24.2024.04.30.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:27:00 -0700 (PDT)
Message-ID: <1ce1bcf60d8540f867b800816acecfff610ee948.camel@ndufresne.ca>
Subject: Re: [PATCH v7 1/2] dt-bindings: media: rockchip-vpu: Add rk3588
 vpu121 compatible string
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 mchehab@kernel.org,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de,  sebastian.reichel@collabora.com,
 sfr@canb.auug.org.au, sigmaris@gmail.com,  linkmauve@linkmauve.fr, Conor
 Dooley <conor.dooley@microchip.com>
Date: Tue, 30 Apr 2024 12:26:58 -0400
In-Reply-To: <59899cfa3d3245309ce6952ae1028dceae27b488.camel@ndufresne.ca>
References: <20240430024002.708227-1-liujianfeng1994@gmail.com>
	 <20240430024002.708227-2-liujianfeng1994@gmail.com>
	 <59899cfa3d3245309ce6952ae1028dceae27b488.camel@ndufresne.ca>
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

Sorry,


[...]
> > +          - const: rockchip,rk3568-vpu
>=20
> Sorry to come that late, but I'm noticing a big mistake here. You said yo=
u are
> enabling VDPU121, the JPEG decoder. But we don't have a JPEG decoder driv=
er
> mainline, is there some patches missing ?
>=20
> Nicolas

Ignore this part, just didn't read carefully. This is about getting H264, V=
P8
and MPEG2 out of these extra cores of course. I still would like to know ho=
w we
will express the grouping of these four cores, so a driver can know they ar=
e
identical G1 cores and not bound to be time sliced with an H1 core like the
fifth one? I want to see a plan that will work and will not cause headache =
for
future work on fully utilizing the HW resources.

Nicolas

