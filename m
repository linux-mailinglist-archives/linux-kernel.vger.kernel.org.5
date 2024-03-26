Return-Path: <linux-kernel+bounces-118854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1F88C051
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DF71C311C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325734DA19;
	Tue, 26 Mar 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWzFEIh6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45814AB8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451586; cv=none; b=dNXBMxjMIsvgLSBAi0+a8MSc6bjZBdJjqHVp6cnxLeqDJtcDMQwG8bUPOTYqIVlO7abvILXRCh6fHJDhc9YlZVu2rHM9ttiB4z++Vbzhv+h+pB1w5B1oxMOndYkkR4sE/RkAvyncB/Smdar6F802qOPjD6bJmzqFM8vFwHw9Ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451586; c=relaxed/simple;
	bh=obuHcm/3xdOzAnj87UVbyqU27DBpx+x5xHMGLWBzQIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGYwanCMRTnhpvn3tFFbtPDxRBkU4lcuADAFlAJeV1mVscU+J/tnaxeZOD40tcaBtuQUy/9q/jh8VUKLvszXzfEVZ489M8+bhYnxlXVtYKLKDEMsk1O0I7K0H+RJdLqUGCa6/QiYTL4kIPrto6JnNM/hw3vJranwV/QP8cfqPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWzFEIh6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341ccef5058so1391279f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711451583; x=1712056383; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obuHcm/3xdOzAnj87UVbyqU27DBpx+x5xHMGLWBzQIs=;
        b=QWzFEIh6i8GZqoN++S2BWJG/xse+ekUgLf8c7ohCtExEQv5UWZ034M6KcFbK2Y7DBI
         SRv31gE/+k6XJaE+KyNMsK2o9Pq9lHkUPpGxhA8O3gb+Ij/1tr/YZ7xI0KDT4UTdQAnw
         +pKOyaSA6AYjOCvq1jACSTjk2sQ7+WPNDq34nQyP18J/c9WVBXhEWbkWikBm1WaW8Zh6
         c62TRWtVONILJVbyuTM/EJJrLJaFmfbnfl7ACcjbqLi+Na7gkw+5RwYz77ST6G0hI3Wr
         M8QWiL24Opl5lLoMJhaU583mbhXVfpltjcY2iv+kznXyR8XeYETJ7mhhUmHYjvuLOUhD
         qENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451583; x=1712056383;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obuHcm/3xdOzAnj87UVbyqU27DBpx+x5xHMGLWBzQIs=;
        b=k7j6xgARQ5/RomQOhn1J8TGKFDg4/4WvlvwnUF/5GLMxedkJUS7lDaacxM7MwO+knm
         8j2GB9QXdsrQQQU6bqAdnwjNhbuBcJKBGNSNiXSkXmpfWQWFkXdZ4hAf0jE2cI6qN7sB
         X8dy5xg1mzOTRhr/zUjz/2AaLapY5Hcp8/HUVleHkG/MWiU1ejQvYL9Dlq3EHrVEfXpB
         h9y9DX6n+fh6clgusDJqQz0L5yBV0bI26bHF5yHybMnHaAhKnslND5tF6X6dQ+hxp0LJ
         5a1Iw61PZRC2h7Bya8vKSlVTEpR6xtSYpTzVGMB6LVjK44mD+wjV10So2s9wGscoeDHH
         KP0A==
X-Forwarded-Encrypted: i=1; AJvYcCV9Swb2ku8VkihloA0PHLgbzOh1EBMr+immKJXJ4OtgKQKdGvfRyu2wSj0dVwQSxaC0Dn5VS09jAYDS273bX/uYmG7Oev70DV5chBLX
X-Gm-Message-State: AOJu0YwCzctGTPV26nXaFiz6zkZ5oSXHRgpXUm5uKpmQHsmAJ71TFAUg
	dk5lDMNYEhtGiZb9Ubhq/lbCG2W3hkKjwr1me2XMkbPZMTsJvnUyMhD0fR8v20w=
X-Google-Smtp-Source: AGHT+IGbgs8epz50aPlOWQHVksIvzA+lR3GutAL2nVRw5PemwOzalG1PtcF/Y6WO7R4P8gZsBDXvHQ==
X-Received: by 2002:a5d:4e8c:0:b0:33e:6d6c:8503 with SMTP id e12-20020a5d4e8c000000b0033e6d6c8503mr6765943wru.16.1711451583172;
        Tue, 26 Mar 2024 04:13:03 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d51ce000000b0033e9fca1e49sm11869966wrv.60.2024.03.26.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:13:02 -0700 (PDT)
Message-ID: <9f2c715e671de0c083355bfbece703936e14045a.camel@linaro.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: exynos: gs101: order pinctrl-* props
 alphabetically
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, willmcvicker@google.com,
 kernel-team@android.com
Date: Tue, 26 Mar 2024 11:13:01 +0000
In-Reply-To: <20240326103620.298298-3-tudor.ambarus@linaro.org>
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
	 <20240326103620.298298-3-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Tue, 2024-03-26 at 10:36 +0000, Tudor Ambarus wrote:
> Reverse pinctrl-* lines, first pinctrl-0 then pinctrl-names. Move the
> pinctrl-* properties after clocks so that we keep alphabetic order and
> align with the other similar definitions.

Krzysztof had requested to change not just the DTSI but all instances for G=
S101
here:
https://lore.kernel.org/all/98810c49-38e6-4402-bd47-05d8cbc99ef3@linaro.org=
/

Cheers,
Andre'


