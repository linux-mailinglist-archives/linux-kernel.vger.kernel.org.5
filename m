Return-Path: <linux-kernel+bounces-131998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC39898E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EB728239E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40271132C15;
	Thu,  4 Apr 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="f/TMKhGj"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707512D770
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257008; cv=none; b=C5hmm6snD5DHASKze6xuGn4gqq6SLkQsiyGaREDP0kqJ7CwxxYyE9tESKz68FlTpVzmp6pvgsKu6f2xmqCOHCAuq5gVgrpGO3VGQi5P/A2qQPYwDohazCab6CkntHDGHLPB3YopG+t1S7VYGGsq4/WqV/2/BfBNu7RZrpPnESGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257008; c=relaxed/simple;
	bh=rg3OgrxCT96ehDsWvlDmAIxCDxg1DhsRLeEA2xqhGms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuGqOOExsJpHHwOKiC2wsfXp3Z84mG5KE2rZelFqLpOfvqhO4Fltc24pSBn6OANQHuJGVWYcaorS5PVLpKk1fTyL0GFJiYO496OaQTHOm0Dbe19rY6CD8MatTSB/2MiVDY9A5+ZVBnS3jdfwKOq1mHoyDCjvYyOJv+2A72opfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=f/TMKhGj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789e209544eso75010085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1712257006; x=1712861806; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg3OgrxCT96ehDsWvlDmAIxCDxg1DhsRLeEA2xqhGms=;
        b=f/TMKhGjVivXjsCH5Au4O+9Z0oml7Qok5R21HnBfwir2o828Pm/Fbwhj/pIxwZUrcK
         1NrJW1927XOz0MOt2jiXL4dlSjV/o3TdZ2+PwvcMwPdFhaqWhyaloMGGTryhDer7v7Q5
         qOjcKB2Ew+H+XI+HhuliTXrNrsDzD9o4/BRkCVNVeWP8BF8go4j15i7gLVNxzQbedc8P
         8N2MrM9innguUWcu5yOufr2wCPBDGok1ibFAaKAVcVAEbWpA9GdIs3u5aEnqbLk9va9A
         /E4N6XQzDUu8/YoPDT6SeeRVPTe1iKHc0Kas+IUx6djLT7Wb7MQ2NBqRkEfcy0Ujypay
         N7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257006; x=1712861806;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg3OgrxCT96ehDsWvlDmAIxCDxg1DhsRLeEA2xqhGms=;
        b=jE2qljD2l0bauKD9zmS3noEleARFnGJEKPw5zDA1VWBAhFa9bis/HY0m1EonP1/23I
         NgecJbrVBm59WLOvx9kCwQdTgNj/du/N8EyLVWi10C9A4qtRzSKiiGawN5bL4N96omXc
         Yl2i0XuoswutdYFt5T6QuF9jkDalq48lNOMLiFP3+hyOIaXClrMAqFuaJZOkMu44armh
         q7my0oyyA+QyaRk62nIjKn8jL3qI4D2UIdyA7W9RlI2viSdgdw3C6aP8HdFCv5fa2k3N
         gdTZt+d6KG9a0pRZIu4sjJ3eSqEORq7TN3tuVgvrzASM40lhEQCrmyUyVxuSz3OL9rc7
         10wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXfjnLEnw5NtYrMsSUGwKFnw+uIzGrQc7pc+H7aPv60EqmVTD5LhPPG4AgAZuV3uGXqjVIA+c4c1aazlv/cbExD3EBLQPZ6PXmxPbL
X-Gm-Message-State: AOJu0YzMv7yLlo2TS+8GHurV73rdtg/z+W0SpBwwWmZAA+X96U30k4xU
	2VS74J+2mSXXdTTsAbYgCHsyL6h2Qwb+LLOvSgjRoj4p5+HsrUyrjt3r46EBfhc=
X-Google-Smtp-Source: AGHT+IFDpxHjnRtVnscIxV5KnbtsKl2UHalzV8sv+IBBsyy6TdnOYfoQDdjK02NCemTFPcWpMIQiVQ==
X-Received: by 2002:a05:620a:5a42:b0:78b:e6a3:8750 with SMTP id wx2-20020a05620a5a4200b0078be6a38750mr3708943qkn.38.1712257005875;
        Thu, 04 Apr 2024 11:56:45 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448:fa75:a4ff:fe45:b56])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05620a45ab00b00789e9bbf962sm6026679qkb.133.2024.04.04.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:56:45 -0700 (PDT)
Message-ID: <4f781313ddb2b7657fadc35dc04c0e3c3de3b27c.camel@ndufresne.ca>
Subject: Re: [PATCH v2 4/5] media: chips-media: wave5: drop "sram-size" DT
 prop
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>, Nas
	Chung <nas.chung@chipsnmedia.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jackson.lee" <jackson.lee@chipsnmedia.com>,  Mauro Carvalho Chehab
 <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 04 Apr 2024 14:56:44 -0400
In-Reply-To: <20240404080235.kab6taeimsxpjtr3@basti-XPS-13-9310>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
	 <20240325064102.9278-5-brnkv.i1@gmail.com>
	 <SL2P216MB1246537DD623B813453B28F9FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
	 <5hd7duzqhgdxpmvom3opkhwxkq55dmitk4gwdl4dy46q662in6@xxkmvdj6plqb>
	 <SL2P216MB1246499CC9FED9BFB5B11DA3FB3B2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
	 <7lro7ryzjajpzvkjdj5cndkmzmjkqvhts6dmer4pkkt7dluiii@wp7ael4ae7jd>
	 <SL2P216MB1246597E5880A5A590CE1DB2FB3F2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
	 <20240404080235.kab6taeimsxpjtr3@basti-XPS-13-9310>
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

Le jeudi 04 avril 2024 =C3=A0 10:02 +0200, sebastian.fricke@collabora.com a=
 =C3=A9crit=C2=A0:
> > > > > > Wave5 can enable/disable the sec_axi_info option for each insta=
nce.
> > > > > >=20
> > > > > > How about handle sram-size through match_data ?
> > > > > > I can find some drivers which use match_data to configure the s=
ram
> > > size.
> >=20
> > I proposed using match_data to allocate different sram size for each de=
vice.
> > Do you think this is a reasonable approach ?
>=20
> As discussed here:
> https://patchwork.linuxtv.org/project/linux-media/patch/20240201184238.25=
42695-1-b-brnich@ti.com/
>=20
> To quote Brandon Brnich from TI:
>=20
> If static SRAM allocation is the correct method to go, then this series
> can be ignored and I will add section in device tree and remove check
> for parameter in driver as that will now be a bug.
>=20
> I would like to adhere to that.

I feel your statement is a bit ambiguous. Can you clarify what you adhere t=
oo ?
That we should hardcode fixed sram size in the DT ?

When I read earlier today "How about handle sram-size through match_data ?"=
,
what I saw was a static C structure in the driver. Like what we do with HW
variants usually.

I was pretty convince that the right solution is to allocate sram when the
driver is used (open() seems appropriate), and drop it when its not used. W=
ith
the clear benefit that we can change our mind later if we find valid argume=
nts.

So with that in mind, dropping (cleaning up) that old code seems helpful to
create a clean slate to re-introduce a better version.

Nicolas

