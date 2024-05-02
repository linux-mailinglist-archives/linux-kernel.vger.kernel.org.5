Return-Path: <linux-kernel+bounces-165881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14B8B92E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587E0B21CE4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF82101D5;
	Thu,  2 May 2024 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB7vXJ7w"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE2E576;
	Thu,  2 May 2024 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610577; cv=none; b=XYU46nbfDldzSYSS2BWFNn/igQorelqHSDZKfAFu2IjrS+vajzSo0m1+MET6dp00LE9ifMuNQ0/RqUcyQo4xuCvx7VlM4WGirmrfAOICXO70l3RLsfnFVA67gD/Z1r/Gw0HeF6HWcDjXv0b8qV+mvMG7pJn/3RoCIC/zLJYuZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610577; c=relaxed/simple;
	bh=8xutd1Kd9TzgYuGjE2JxA1mDGNk+iSNbTZCMFWv/sao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHJ2WFeItHjeMtBHX9Gri68SqR2XKn15BRpU6UhLKEpY+n2I1jGCb7Cxzr0AxRroQxHxUMqiuQycGU+ezsheDuF1JCsKDA3chFxWstTzbapXSliA4f3TlLPu0HgSDooELU07vpDX+IytUzoRR5Z5sJfsOXr7z8lJ+b7Xb0sctB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB7vXJ7w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eab16dcfd8so63215375ad.0;
        Wed, 01 May 2024 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714610576; x=1715215376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qazq7dFQkI73Ks0E6awp6FmAPNo9jsPf9ikQHfV99NU=;
        b=JB7vXJ7wCWOWPLvxr1UWT1P8CoeEQvZXj0nlmUvVm2GbTyWfdACMCN8xpbZeIgE1BB
         5fozZqFxzVM2guE33QQoFBqbTDtCq4nr4Inpa8OxODBNLh72/87T+9riVRtfIzMRyQ0P
         HeKJs575OPEOUHfofXFNLnqIvo1yRhZlBK11tevD4ENSHo9XRRXcoB3xZMcWjCtWZ/a3
         rPvtTa8TcnWXSh2sPU82aej1ZQRELR/yuUOmb1RA7SzMcarMylNc0E7UJs7JRgi6EX6d
         dvI+V3ZdSBrdx+Wp0uPwIuNIo6iu1XiojDSWIGWVXUQcXNsNAeyvsuNv6GF5tC+IV4Kc
         FmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714610576; x=1715215376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qazq7dFQkI73Ks0E6awp6FmAPNo9jsPf9ikQHfV99NU=;
        b=D0iOY822knCgyrf9OC/dOo8NKLLfJXLIpUPXLfExYJZFp1EYrwUwt1sNIIEQ9pKmGS
         hIT7Au/62QLdI2gf7LK6rLN1+le0lyzDeLR8Briz5UconNRcwruWNubJn7OcuRB5f0D2
         LSsQVmMhBfUgmyC9w+48Z9mOPLcIXsN7nFzPf3z+ZYkTFwUxl6d3LiUnZHJwMVDLlt2V
         DX41oCE+om+I/apLwazsDS0z5go6ycq91kfLy5phFYNOKszHOnaTPhGOnnLDjJ0QDasA
         3C3uhHhYjyU7k+CCHIfAxVdphDMcQwKa66aq11P6k7joUb2SLjPSjOeADY+eaUrlWeT1
         AZhw==
X-Forwarded-Encrypted: i=1; AJvYcCU+MBVDu8IVEAHUKOX8NLea2+cX7DXLS5J93ufVy1cJUO0l3ALOlqBocskVRMfwE5mmWCXaWsZ0U3srDIH0LJAwHCtQafKweqLGlCn+bRHU2BT9ZP1x/A6qoqgCrkWt9H7FPli2lBjJkjiau7r5nek/tIUoosrpb82fX39njseWKRA93Q==
X-Gm-Message-State: AOJu0YynTBWdH7BPOaF0Ju2mGde7g9B4bDktFjFV4jO2UVCfCEeV5kAi
	0MbBwMbTG1QdkO92lE6ciP6RMyrKN7GjmU5BsPrlz9iptAIDaM2Q
X-Google-Smtp-Source: AGHT+IFynEHS9WTmDNfWqHrfKpbGuzyobPnaK7GBDHBklXGOJyXN2fkeDZnLg3ggjkXCR3sAhoxz4g==
X-Received: by 2002:a17:902:ce84:b0:1e5:d021:cf02 with SMTP id f4-20020a170902ce8400b001e5d021cf02mr5822599plg.36.1714610575583;
        Wed, 01 May 2024 17:42:55 -0700 (PDT)
Received: from joaog-nb ([189.78.25.116])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001eb2e6b14e0sm9643668plh.126.2024.05.01.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:42:54 -0700 (PDT)
From: "=?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=" <jpaulo.silvagoncalves@gmail.com>
X-Google-Original-From: =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <jpgoncalves@joaog-nb>
Date: Wed, 1 May 2024 21:42:47 -0300
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Linux IIO <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	joao.goncalves@toradex.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <20240502004247.pfevxrxf3ephw2tm@joaog-nb>
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
 <ZjLe0yIpMyPRl-eZ@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjLe0yIpMyPRl-eZ@archie.me>

On Thu, May 02, 2024 at 07:31:15AM +0700, Bagas Sanjaya wrote:
> [also Cc: IIO and devicetree maintainers]
> What are these ohms and where do you get them?
> 
> Confused...

Ignore them. They are not real values. I got them from the
bidings example of iio-rescale devices. The DT draft is an 
example, not the final/correct form. 

Regards,
João Paulo Gonçalves

