Return-Path: <linux-kernel+bounces-140280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D88A11EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CA28216A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5B146A90;
	Thu, 11 Apr 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C43m7CRK"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B879FD;
	Thu, 11 Apr 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832516; cv=none; b=ly7qf8F8Q+oqFuEKp7H/nVDGz6d4G4/4yzsKo/paqE1CqPoeaYBahc7TQnFlxzHSdeSIYhIhCSlKWbOz3l6uqyD7Ty4+SZzWZKHMzvUcuVtFXYDFdIOe3+IIHQk6HZLcj+7PDs1wyGmMIPoEo3iWD8sTAYKwVOpg7T+PWTXkLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832516; c=relaxed/simple;
	bh=e7NPqp72/MUBoV0GHkUqFvMV40LIoweJGWUQhXoaQKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXBiX2lq/F8QsUf7Zirt5tfi+R+9uzO2Jz7QqwrgbVx7gpV5lkCS1xH92DwMZ1tPhsOBJ9GwmC53/qgOXSn+YUeIlnHg+cs5ize7KaCl1iDqEmgis/R4wC2ue8awxXGpkfBZkHRV8Y8o5MZY8ZTfnzEgDCwuwggxqL2pMX25wTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C43m7CRK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1852665b3a.1;
        Thu, 11 Apr 2024 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712832515; x=1713437315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7NPqp72/MUBoV0GHkUqFvMV40LIoweJGWUQhXoaQKI=;
        b=C43m7CRKIKIgddD9wSJLmK9/H+Zzdc8ufe1a+UOONbKlaSIsrnnKJsLBPj6Hvy3+Fw
         AirfBF3ow8XJcedUVBMJxqoW9at/uazcBXHBpgvbW1bwkGur16gjwfWJW8mndsQ0BgIf
         cD6LJervif6XFn4ILXDDrGIMPkay0slfWDj5xnBqJaRvAqAd5rcwKjVDUIg99eqPXIaV
         OiUI3eet8WHKtMiLIn3QxbsfUmiEVj4ZKlPI5GBoZWlA9IUVDU9xr+XUEhPtwQgwqfYn
         BpnMUtdYLeor+SNTepu9fLUVHTrN3aeZLjyoBK1H4/bHyDFuXkbm9IvYId9Scl9ojXSy
         lZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832515; x=1713437315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7NPqp72/MUBoV0GHkUqFvMV40LIoweJGWUQhXoaQKI=;
        b=ljhJh6MALn7Hgdr1P+tsCJSAPhan2IWc+Ozpv8jDOUOEfEW/HDGL1FNo0ksyGqtpci
         l6/Jy9oW67dzsBiefdk/uwMjEMqtu/W1iEzBTsh+JiC10fyVYIxEI9aiRpaMzJOfAn/G
         YxhBncokxvBtbhkibt0fo3EReQhAhi+sO552YRXdpZKFaY1XV3TfdV2YEG7TgcgNuLlb
         N5wEcHyXtZ8eqCbkCFO/yV2Ykk1JHcEAp0IHi/w+hYLn0cnnIOAZAHGoqpEZI/o43COY
         O5DaeAiX7xWAivnuFXSaKip8V4IjglwmEogUY03v/yd+P1V2jC3+VQnf6yu4cjfzKkfn
         hYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1q4JdzVnuqvnKfiZY2Ft3eUy1+gtXn0KwfbLqOUwTbCsop1uM5RM9dvLN66unnkuxazhphcLTdZrAX7o9Y8aDcY9qpF0/yUiQHFk4W23QY/MbbOWqJUSkevXizwNpkkRtElQ2o7bXkQ==
X-Gm-Message-State: AOJu0Yz/JDdAdgvvxih89jOmZoFEYiCD/Z7QeOvZQKBwdCdBOM01VrJ+
	Yzg1tsbIvp5Zeg66fp021YHQvPT/IsqNozX7grRjzJ/tdijwhPJIrhNbF95IfpgwNyXWQyc+G5Z
	dYCQRgnryt5+EYPsjobit4HENMTc=
X-Google-Smtp-Source: AGHT+IERA60i9yvMCt4gbEJ4oS6/ANmDmTfEUJf3eg0xNuWcHUeOMgqvSODfWbV3ymxHAAoRj8TxfYW2VhHI60e/xIM=
X-Received: by 2002:a05:6a20:1050:b0:1a3:8e1d:16b8 with SMTP id
 gt16-20020a056a20105000b001a38e1d16b8mr5228297pzc.28.1712832514804; Thu, 11
 Apr 2024 03:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411094256.08b7d7b9@canb.auug.org.au>
In-Reply-To: <20240411094256.08b7d7b9@canb.auug.org.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Apr 2024 12:47:43 +0200
Message-ID: <CANiq72mdRgMuQVD53Kp=hqaoiSNwPVZVSrbbMxRYehi73FZf9A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the rust-fixes tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Bo-Wei Chen <tim.chenbw@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Gary Guo <gary@garyguo.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBBcHIgMTEsIDIwMjQgYXQgMTo0M+KAr0FNIFN0ZXBoZW4gUm90aHdlbGwgPHNmckBj
YW5iLmF1dWcub3JnLmF1PiB3cm90ZToNCj4NCj4gICA9PT09PT09PT09PT09ICA9PT09PT09PT09
PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+
ICAgYGBhcm02NGBgICAgICAgTWFpbnRhaW5lZCAgICAgICAgTGl0dGxlIEVuZGlhbiBvbmx5Lg0K
PiAgLWBgbG9vbmdhcmNoYGAgIE1haW50YWluZWQgICAgICAgIC0NCj4gICtgYGxvb25nYXJjaGBg
ICBNYWludGFpbmVkICAgICAgICBcLQ0KPiArIGBgcmlzY3ZgYCAgICAgIE1haW50YWluZWQgICAg
ICAgIGBgcmlzY3Y2NGBgIG9ubHkuDQo+ICAgYGB1bWBgICAgICAgICAgTWFpbnRhaW5lZCAgICAg
ICAgYGB4ODZfNjRgYCBvbmx5Lg0KPiAgIGBgeDg2YGAgICAgICAgIE1haW50YWluZWQgICAgICAg
IGBgeDg2XzY0YGAgb25seS4NCj4gICA9PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09ICA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCkxvb2tzIGdv
b2QsIG9mIGNvdXJzZSwgdGhhbmtzIQ0KDQpDaGVlcnMsDQpNaWd1ZWwNCg==

