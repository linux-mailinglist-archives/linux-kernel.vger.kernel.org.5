Return-Path: <linux-kernel+bounces-35766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D7839633
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0111B1C27720
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026A7FBCD;
	Tue, 23 Jan 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rA0LXFpr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7997FBDD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030437; cv=none; b=a8ZFLD3qprQn2fDv36SCRZ34m5kegwF+nAh5KHRp81S59y+PlX8kUtRZDC5v6PqL9yHv0HvC8Ul09pII80+LhkpmNehthbq0ujzHq27PLdt3ZlnUtvmnsbGJEvo+kBsIJ8654OBkJN4bDMWIO5Kg3UHy/9zwz1w8sx2vz/10cGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030437; c=relaxed/simple;
	bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4RlSb3gBpKxPD+IbTp0Le3r8IcPIatIZY1+5PnOh6R4KeqWv3ylPoO/PxMOvXJawZX2dC2KZwMIQ48MvrM0bH+eMhuG4dUD8Ezrm/mw77elOSrRTzztj1MfbcT9chJo+tostkdgO5DV10lDY9IxJfyfJHvY2AitejA+dws5F1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rA0LXFpr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e80046246so27901655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706030433; x=1706635233; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
        b=rA0LXFprZhz8Z4Y6F0/C884hx/HCE+elxLKLv72xU+KwRRBViEU5csF3539WCvbxVy
         MaINguGrb7AnLQWg4CjkJQmYajl0O2qCtq4Rnhiz2b9uIzpwBEnQo6f9UiM1En4p0vUt
         cL9gFVRMZ4YwbK5mb+ugSoAdwpEpUDp5WMwHGMUoxjXsZCTWAeg4svvfBQxNYZK1pJOL
         fF5Yt3//8NPCeCfyAFgOPFrrvlH3O+DiVJ5XqH7bFRRaB39EnVjdrAucCUo1JL5iC8CI
         FBQOnqNgiJKauTwZe7z4lN58IiqOa14LcOWHnAoI66muRZ27W1YkgLMoWlvmODVUIJQA
         D8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030433; x=1706635233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqYXrsvbaMlrmoMHzhpki5Mt71I7zZeWsiDaURT2h3o=;
        b=HJ2k3KIzQXeP15Irr5oi5haD64WdXeJdTEg8zYyk1vbv3TuT8ZeyOGyz7zrlRvHfLR
         HoQItNIdOu4BDjCe2SvyAc5M8gdXgGr+3g6YA2oLN1GaqN33hZ/8BwYKgTUzkxUP7feG
         UhQgxj6vANTlI+CETx2Rmg0laga4mzRbK9c6eRJeOqKzhkjsORVGNjQz1fne2JQULvpc
         40E8zjDBqrXiG9jI8vfpGUMLCsCsn+Iob6gRWPj3UA+6MrDytRpXG0rfT9CCzLPOuBcl
         7/NoujUZE4xAW6CcNx4s/xS6e+2AFlYNsH03JV8JYrV2oNB5nYhUfCIrakZYEXNp3Gh6
         mb2A==
X-Gm-Message-State: AOJu0Yx8xvRLAKbPk9SejnsnqJVRh35LM3Rphpb6BJQLiCeoU3+JfOaC
	iS/7krVosBr/UlC0sTrSnpAtVXb/GigMW6ro39TSaniMBOx5OOdOmRs2bQPhaAY=
X-Google-Smtp-Source: AGHT+IE0+DZQGCS4EN1BBZgSwkTn7W+MJDfyHXzr6PStwtw6b5GaozKJv9t4TXOiNKfsBfmbOiSaIg==
X-Received: by 2002:a05:600c:2310:b0:40e:4c31:affa with SMTP id 16-20020a05600c231000b0040e4c31affamr329334wmo.138.1706030433353;
        Tue, 23 Jan 2024 09:20:33 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c35d400b0040d8eca092esm47199795wmq.47.2024.01.23.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:20:33 -0800 (PST)
Date: Tue, 23 Jan 2024 17:20:31 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] leds: ktd2692: move ExpressWire code to library
Message-ID: <20240123172031.GA263554@aspen.lan>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
 <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-ktd2801-v4-1-33c986a3eb68@skole.hr>

On Mon, Jan 22, 2024 at 08:50:57PM +0100, Duje Mihanović wrote:
> The ExpressWire protocol is shared between at least KTD2692 and KTD2801
> with slight differences such as timings and the former not having a
> defined set of pulses for enabling the protocol (possibly because it
> does not support PWM unlike KTD2801). Despite these differences the
> ExpressWire handling code can be shared between the two, so move it into
> a library in preparation for adding KTD2801 support.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

