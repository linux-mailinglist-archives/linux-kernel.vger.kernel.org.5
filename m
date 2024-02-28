Return-Path: <linux-kernel+bounces-84633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00386A943
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95100289619
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3125614;
	Wed, 28 Feb 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="G0dwp5Y7"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC025542
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106716; cv=none; b=Sn/jC1GLN58QgsDsg+r4m9eOBQSUyWSxaJm2qg6USxPCrkeo0Mu0F6GglqAZp3dv/Cjtqi3LAwpxeia1QW4WwQC+EP/ygIfCv+tmTJAVu1JpatEXK1oKnYHjq+pRG48I15BzUQfEqBe16x7EYaK8GPe03paygzvOxFrmxTSdQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106716; c=relaxed/simple;
	bh=EFyY82Ys/yVpN4kZpBD/0yBYrBRn8veUJKTesIAzz48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBFFiuPnkws24vSqbwAtVLVNkPeLiBYO50ZciZR9F2XSHMAK8JXOHcFPopkG5ajHNFsKMjVDdjY2Fasie6k5R+Uzmrc7eWPcKV/FKsPenAaOvsmYeRta0MfzmOivQHfY6XEtmOraTBAFHS8V5JFd7dxjMoF9v90iY0n1whBstC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=G0dwp5Y7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3f829cde6dso615900666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709106713; x=1709711513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAtlA/kS/1yjrODzNnvXMEbo1KoT3kbP7fHuE5JKJgo=;
        b=G0dwp5Y7c+u9/TN92qiM2+1+8Q1TePfcGV9zp8DCqzBr9BYyyoEZRlVRClIkdZMlCa
         qSxxw64rzKEyFiNbvimPNoAycenmFtgmia+bUt2OA+gIAUiO562EooSllpECATqJaSi4
         zOKlovygxMBpSutMlotxIzvBQBCzLbB41kpIt6hcz9S6JSiVoJg4xP0gXPcBtA2XyTqp
         gMOuaFeSpWVaY8cPTe5tA0ovww5QfzLIgNCCYbyZjPf1o+UijxUAi6Z+lLfAEHabjtNt
         INGKTt5z95fKLVCd/nN9+gRhXk3ob7JQyfFPk5d90sSkpHadazCEdV1wLypSW6pgCFx1
         ZKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106713; x=1709711513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAtlA/kS/1yjrODzNnvXMEbo1KoT3kbP7fHuE5JKJgo=;
        b=Q8kSf1WinJMnpl2QEomp6GlO43Y2I3reY70aVK4SuBLLyYVnT9lSnfyFTVEoIs50xe
         Tb3Phu9R86lIfdcsVnp3xC/9j9Yi3z/mGT1dYXLsvZDBnsNUMC6N7gDwtg1e2XYlTL+K
         TENIza4NihAdjVEr4WELRmIiNEeXLF1gr+4bOcKUc5rFgEwxGuPLwwrQa03AqxM81VKR
         QmJKjvhsVDkw7uz31py6J8A1MOt+QrjVduUvCHdCywJQwtT6JPQ5/0CrrM9VDEH8ghPR
         BO0Qi59TmnXQpuQqk8rQbWiWZLe2A0Dz+XLp7ecoFG9amDpJ1AyS2W/gxRjtBUr7gpj5
         oh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5QARBg4QUQUdBynrs48JU9gNDcZJ33T67JDK7FNe4s0e4rnYK8JNSnT9amIUPZLhixtr4d1wMZ0TeoqTsFZYKqtmvh4V7FPn4NNwc
X-Gm-Message-State: AOJu0YwnOfVYQybWGecgFFQB5Oo311u5ZSKFI/Q55fL1ADflpHU5YTVE
	PaHUv7rLTXmvpCWvtC3HBhhonevu6mUrniKqA5mgHGyPY5R//K0yOrbY6rKnGoo=
X-Google-Smtp-Source: AGHT+IFPr9ON0KIGYx74JKHiaaPAdKvkyKEZ4Fvnv37Yq5h537XaLhV/FJbYDW6gI/BWNQjThNmyaA==
X-Received: by 2002:a17:906:1949:b0:a43:3b2:bcf6 with SMTP id b9-20020a170906194900b00a4303b2bcf6mr7467544eje.14.1709106712780;
        Tue, 27 Feb 2024 23:51:52 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709061cc100b00a3efce660c2sm1561860ejh.198.2024.02.27.23.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:51:52 -0800 (PST)
Date: Wed, 28 Feb 2024 08:51:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fman: Use common error handling code in dtsec_init()
Message-ID: <Zd7mFe3-kbqjGpxh@nanopsycho>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
 <20240227184657.76ec4e82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227184657.76ec4e82@kernel.org>

Wed, Feb 28, 2024 at 03:46:57AM CET, kuba@kernel.org wrote:
>On Tue, 27 Feb 2024 14:14:52 +0100 Markus Elfring wrote:
>> Adjust jump targets so that a bit of exception handling can be better
>> reused at the end of this function implementation.
>
>Okay, but..
>
>>  .../net/ethernet/freescale/fman/fman_dtsec.c  | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>
>..you've added more lines than you've removed so what's the point.

To have cleaner error path? Not always lines of code is the correct
indicator of patch quality :)


>-- 
>pw-bot: reject
>

