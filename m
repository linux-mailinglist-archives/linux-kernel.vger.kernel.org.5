Return-Path: <linux-kernel+bounces-143645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F88A3BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C31C20DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325932E62D;
	Sat, 13 Apr 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECF8S3BW"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CA1CABD;
	Sat, 13 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712999875; cv=none; b=Yt2GNW4dj6ZwjIPmoWvwTUKWfUbGpcIlQbBq1nJul629rgxcflDr7oh3DifBPJBM/qz5VljNdUvYr5cKSxZ1gF5U2D8iMX97Xfa31hgfXy+xR+G1MRMuth1avQQOdMzvQq+aAjCFgH7Wrq1rvu8NiD77uTDlFe2czDMPBOocGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712999875; c=relaxed/simple;
	bh=wRNMwDiQIl7U6AyLLbQ9gUlDqOSjb+gZG5zBDbEdpAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhHeSf7IIu1AVVEXLwC07hPbz7xFe46DELGY/EK5ofq0dht1Gj/vAqmdHiIBRsyrQRoURC8ghbw7Xnx97UG3ysoXagjB5TwX7mbpUV4c4LuWCOAjrugB5BQMH34Jea5VVoGJ3MidPYE5pOuZdQnaki/qV57vAzzQI/X0CREcH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECF8S3BW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da08b07157so18341961fa.1;
        Sat, 13 Apr 2024 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712999872; x=1713604672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FprEdCtwRuo2/5Chsw2LoMvecKwl1NWN0nipJJWRa7E=;
        b=ECF8S3BWCva+yiJ2r/W2bQzWic3J6pS8rfo5evXtiB5DVS3Edt45+rRGMqNvoC9Hw7
         MUtiAOURDqF7er+zuSl56jGVVcIR0D79icSsuvnmQj5ukAwYCtsta3L8cjwFeYE2kJLP
         Qq5zUXV5UQSV/bO42hyL5GGNbSEWwutG2p04DrwHNPtydqAYSj1p7D/L56U8iTsGviP0
         ABtMIrLfKb5Dnm4Ffy7KO6ZFiC/ZfNr6SSIB1tw2XJdwndKxehUGMxAzWA5+aAK6schG
         Gi0vLUDhIcZ7342v268NCAxgZrsh55QrQrCdPdJ5n+sMcQFsPSHcM+OLIZx21R67L1vE
         IWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712999872; x=1713604672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FprEdCtwRuo2/5Chsw2LoMvecKwl1NWN0nipJJWRa7E=;
        b=K3+xkyk83zEBD2/9dUHXBIR5qPmg9mrshqqDabRD+u+8TTmxfogHnSvySKL2+cUfkB
         SRLkjCNH0wTLMCvH094wixbnR/eAdUrmRBCZRRQEATP6mE6fuZbXMh2FZqPtOs/RXd+Q
         Y7v5g+dwpVEdZG0tjjQ1BjdCatYuHO8H4/zxS0MS+zyCp47oKIlwVF/ZCzfKGuVqisBP
         kmx5GiiuKLNca42OGgPRCoEj5HZ3vcVIvKmC9iMSdpyiaBz3m/J7TV2/42ZjzIEVmbwO
         QjqC1q223HLW2ThuaTpbu9EKbkktYo5WpCLxSMF/llicvT5VaEDtFr/vFPB7edK8bKva
         KOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXuMkyzWoNk52s/UyvgFmPUdeG0mEDryIlTtF5yqb1scLqNZXi/lbUfGhSJVpdz8Tj14WnCNpQFTClck9O/6XYAQIl9r5OzgO7r9wteQe8MgUV6v7MP+df/+nlKOfbIhLUJ9t9yatKs
X-Gm-Message-State: AOJu0YzoaIsiDWva3Jj1OTn7uF8ZXfpO9+sP+iRp4KZE4VVcS1MRQQYh
	ShuXcpukwdKD35LREIhaI0nTLhFNCQHYx6Y8w+n/RPeH1b3KjkHG
X-Google-Smtp-Source: AGHT+IExR290cPBeWjD3hksC6EFfjbaKR9t2qJiYmoeyx3bC+LFUi42XhP4I/wP547zW8LI2gp04Yg==
X-Received: by 2002:a2e:9b8e:0:b0:2d4:676b:f591 with SMTP id z14-20020a2e9b8e000000b002d4676bf591mr3621367lji.45.1712999871741;
        Sat, 13 Apr 2024 02:17:51 -0700 (PDT)
Received: from foxbook (bfi40.neoplus.adsl.tpnet.pl. [83.28.46.40])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b00a51be2b75f3sm2751673ejq.35.2024.04.13.02.17.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 Apr 2024 02:17:51 -0700 (PDT)
Date: Sat, 13 Apr 2024 11:17:46 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Mathias Nyman
 <mathias.nyman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-usb@vger.kernel.org, Niklas Neronin <niklas.neronin@linux.intel.com>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240413111746.059dd4b7@foxbook>
In-Reply-To: <fca78115-209f-4090-b83b-acc684484587@molgen.mpg.de>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
	<20240405113247.743e34b2@foxbook>
	<7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
	<20240406183659.3daf4fa0@foxbook>
	<c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
	<20240407142542.036fb02f@foxbook>
	<1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
	<20240408210541.771253ff@foxbook>
	<82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
	<fca78115-209f-4090-b83b-acc684484587@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Thank you for the detailed analysis. Excuse my ignorance, but do you 
> have an idea, what this Sennheiser USB headset does differently than 
> other USB devices?
It uses isochronous out transfers, which off the top of my head are
almost only used for audio playback in the real world.

However, I don't know what it is doing differently from your other USB
headset. A few random hypotheses:
- the other is not a "full speed" device (but it most likely is)
- you haven't tried enough times to reproduce the bug
- you have some software which automatically starts playback to the
  Sennheiser when it's connected, but not to the other headset
- different playback format and different USB packet size, although
  192B/ms corresponds to 16 bit 48kHz stereo - the most comomn format.


As for your bugzilla comment and the list of other TRB mismatch errors
on linux-hardware - yes, these things happen due to a variety of bugs
in host controllers and the driver. They are not all the same bug and
they can't be analyzed or fixed if people don't report them and don't
cooperate in debugging. These messages alone don't provide information
about what specifically went wrong and under which circumstances.


Regards,
Michal

