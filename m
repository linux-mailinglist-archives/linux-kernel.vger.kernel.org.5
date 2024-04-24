Return-Path: <linux-kernel+bounces-156437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595AA8B02CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1501D285715
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EF158A01;
	Wed, 24 Apr 2024 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu4HIMX7"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F96157489;
	Wed, 24 Apr 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941961; cv=none; b=gZIXgX9hRD4icIzo8Chcab+SEaE6v0SKEK6tHwikKJBdwTpSKtMin9cWN44mgY5jaswod7LQaEZN0lap1hbYanr9mCWNstSthBSMMY1E2vWPu3kkwX2ji4AK7Mb2bYmrWviu0kv4nnUaLrrNul5Vj32swRLz9GqgcRDs7jon2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941961; c=relaxed/simple;
	bh=jAHDmzsFsjVVBqJnc/5HKSRpUTtI3iSAfhWByWRHiks=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s/d2VhGnH6giYYisXnQcrRebbYYBnW56CIpz/DaNhLAAbRXyHgpRQLbmPujie0VNMBkeR7GQKDbzaiZbDGfhvjj0/jsy6OHALyayeTs+uUNlMAn/LSkTA3bYvl35flwMbFhGKerDuUXvK77TzqoymhBnr2HB9daN/E77WrgqKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu4HIMX7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6eb86b69e65so3858405a34.3;
        Tue, 23 Apr 2024 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713941959; x=1714546759; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWZZ+dn7fNGUKxcBZFkHNk8wd/FNa/kDs6IcDRWi3xA=;
        b=iu4HIMX7C2FCi73z2vU2EpXkGiM9wSzdit0MBJMqHfCyRmpTJqcs/icntgTG/SJUIh
         Q8PSAOTbRWL5HGZTEmzU8t+1qOsvoVfP6DJi5JQWPMzagn1EtD/BQtrStackcHcFJUCd
         W4HSSp74M4fWwR4XbGc3ZcYfpsdeeJg0YkHnvG8ZB3ImIPpUAh0242Y4U2v+8quEhCcI
         L7l9vca89beStKD6VlCpGdSEG0nxM9ZHlSxM5RX8zkxh2rVFl8sNWUQhhnnPZU/hOo3v
         Hg654QXfTNDZ1YkibUx6Xug/EZoOQjKyuJtbt5SaH/lUXYc3sovzS+HwI7rW+fEDiuHV
         mMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941959; x=1714546759;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWZZ+dn7fNGUKxcBZFkHNk8wd/FNa/kDs6IcDRWi3xA=;
        b=iOcZZHx2o8zzMzdtxQKIUx6MRpT8nNdcWlvXPexSKVV6aJVGSxhk0bDm4H0bCYH5EH
         o028KjQ0yW+Uk8EaznblDcRoD2rZMdm/xrc+b4XKq/XYMEdUFxYhrpkWuZh3g7RWNBsn
         JRf1SIpViqt+pn3GxdTtKj0J3F9tvtFaYnbxow462hM9RRBFPxiOLB0HTLdQYlNRw0sr
         NQOjI4GvVrnoEwHKh5FH2E2UP/UWI+G6oBAebcjhVZ/KZJW+NJU+cZKeRqrKO7OmUlZX
         I9NQAJHuuGkQRHBFlkRQPEXKfglPYiDRtfTSCEzDKliYRhvO6vFwpo3GZaFPDu4zjfLc
         I/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRM6IIzGZiEtNNeV16ekEa5yoGmFJ0EFeH7Kah5R4tS6RUdhraS6Danf4qxvMI6NVToGI3DjnfZyIBoR+M7EPpdjR2vKxeWNuxbP1PBGvYNXOynFm7z+shWy4WNEQZrcn3S37/wez2N0gVov40Hnx8zzaUdfQPizS9qMKayOlgDaP5
X-Gm-Message-State: AOJu0YzhZIiR3sP3WTbCKm7QCNtqM978FCafQYGu2/LkJNkUHHPp8nS9
	DF18gQO70aw06A1yHmMpA50RP2+Q0BMfj9bdvHRoC1RP1H7BQxfc
X-Google-Smtp-Source: AGHT+IEOwg+BGEAz6/fsGPOw13LZuPP//HeGC7vsQd1OrWYlk42LFeKMCA0+u5KPiL1CSu6naAcP+A==
X-Received: by 2002:a05:6870:a3d1:b0:21f:412a:87a8 with SMTP id h17-20020a056870a3d100b0021f412a87a8mr1940555oak.41.1713941959153;
        Tue, 23 Apr 2024 23:59:19 -0700 (PDT)
Received: from smtpclient.apple (120-51-0-113.east.xps.vectant.ne.jp. [120.51.0.113])
        by smtp.gmail.com with ESMTPSA id x37-20020a056a000be500b006edcceffcb0sm10754234pfu.161.2024.04.23.23.59.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:59:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
Date: Wed, 24 Apr 2024 15:59:04 +0900
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 devicetree@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Kousik Sanagavarapu <five231003@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9A1C6C4-2B40-4769-9C9D-3A4DB2C27C95@gmail.com>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
 <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Adrian,

IMHO, this driver should go through the SH tree.  Thanks Rob, for =
testing the patch.

J.

> On Apr 24, 2024, at 3:48=E2=80=AFPM, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
>=20
> On Fri, 22 Mar 2024 07:42:21 +0100, Krzysztof Kozlowski wrote:
>> The J2 SPI controller bindings never allowed spi-max-frequency =
property
>> in the controller node.  Neither old spi-bus.txt bindings, nor new DT
>> schema allows it.  Linux driver does not parse that property from
>> controller node, thus drop it from DTS as incorrect hardware
>> description.  The SPI child device has already the same property with
>> the same value, so functionality should not be affected.
>>=20
>> [...]
>=20
> Month passed, no replies from maintainers about picking it up. Dunno, =
looks
> abandoned, so let me grab this. If anyone else wants to pick it up, =
let me
> know.
>=20
> Applied, thanks!
>=20
> [1/1] sh: j2: drop incorrect SPI controller max frequency property
>      =
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git/commit/?=
h=3Dnext/dt&id=3Dcc92bf017f7c66c8a4050c61a7d11ddfd43f5cee
>=20
> Best regards,
> --=20
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20


