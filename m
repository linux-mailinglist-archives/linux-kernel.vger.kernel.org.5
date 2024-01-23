Return-Path: <linux-kernel+bounces-34680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB53838615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95DC289E77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36107185A;
	Tue, 23 Jan 2024 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NErg9foy"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1071846;
	Tue, 23 Jan 2024 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980836; cv=none; b=jOEN6wtnzNIoPq+ZuUeN6VeOahNnnX1sP+dV0tDS7Z8tYz8hGkM9oN8qSPNeAglzBgIIcS9HcDAHRoSQ7sb05SU6teK1nhaHy+KS831docAJNwnVsQgIiJrKnNsYO7FyAmfcM2uhO9PFKGcztuyMhF06q4pnoiQTBqoVmgA/mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980836; c=relaxed/simple;
	bh=l3OzJx1tHOBmQO02sT2tNPr/PdKQ56BhECwBcWhlP68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bafi8jkcv9LyuDqS2u31gxDIsKv3kQey3Ao0BGGBcuPUC5s+WDRuoaSFfHwVt8r7dei/4iqojwlGhnIN0Ckw8BXMOR8QadF4n6MQHWpoUCFjQzlpoNejEzQo/KVImQ+dDtDXcAD1mkA7jwri2bK4SDdLtxCNaypaINJGkC6Y68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NErg9foy; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbc649c275so1277540b6e.0;
        Mon, 22 Jan 2024 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705980834; x=1706585634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJL5I+nGMoZkwtnGjpEDMfbOksb5ycAv+1Ffyi6VeZU=;
        b=NErg9foyVfJqyGOwMkCJb92XBeVr2l2eZhsH3KpUqFsb++V4PHnCE0MeElvFyFOtEu
         H0KhtyVNtctZ98eP0Szoc9GSAevL2BwgYH1PkBiJ2cWymH088DWhvO9XNVutOXzFTru0
         Er1E7Ywm+Wfe595l1M02is9KCPweAlwGWL8js7udsRqVFFa9z2kDUMlrhJEq02rpP4Av
         SGfCwV64tphn7LYYe8+jTivpjjdpvc3QNnEfwGFubH7MSyHZpw+F+MlJaXrXrJyd+sJ6
         kIQFegd1L2zLd1ifb0pMHDZ/hzEf8SwvM6eMbuLc4nJWwf3CH5qKFkT3BNPOoBqwbiuU
         eN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705980834; x=1706585634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJL5I+nGMoZkwtnGjpEDMfbOksb5ycAv+1Ffyi6VeZU=;
        b=Y12CNxCZVFcSnlt90TEN960foFBLDovQrIiqI1ovW0U+Mk9m8jhzGuKuCrRK+kIMvE
         CGS400M1ahocaJ+T//MTK+gfoAEil+Sgvr3ZO6+6bJPIwHOsljd1tQqh2rERGEK2vsss
         0CququrPXe6XHtYnvCd9cB+OC4wlihsKUp1aOLxWpG4mOoABnu8trtDHSUacpUG5dq/5
         WY4V9adR5HbRqy4vum/2P486IRJ/6g6MySEXLX591l8/0gZbxTn4Bdqf6DLTr0yt+dZ2
         Qb3mVyXBiBOSuKG78LxrjS0uLlCblqJL3zIODgFod+TTvrkxggH5E8I/93fx3j5EV2lq
         IlCg==
X-Gm-Message-State: AOJu0YyzMHjuv2Vv21cgcoPsUgVJkufESQ+IeVRtGA2e/arD0jJfcBVR
	vL88RwYCoFrAh7a8MF6XzIEjRmbZivvocsAP9j/cUVlYFf6lpRHF
X-Google-Smtp-Source: AGHT+IFgTGEcGpqPg1vbnLfvDKVdv+LdLVoqnOn3OMVCzmwZmfiL1XUYY5LU+U5Yi4wd4TkZKKuzQQ==
X-Received: by 2002:aca:281a:0:b0:3bd:a4f3:a3 with SMTP id 26-20020aca281a000000b003bda4f300a3mr2329875oix.36.1705980834064;
        Mon, 22 Jan 2024 19:33:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b644:a8c4:640a:70c6])
        by smtp.gmail.com with ESMTPSA id jw13-20020a056a00928d00b006dd738e9004sm163466pfb.172.2024.01.22.19.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 19:33:53 -0800 (PST)
Date: Mon, 22 Jan 2024 19:33:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryant Mairs <bryant@mai.rs>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH 1/7] dt-bindings: input: melfas,mms114: add MMS252
 compatible
Message-ID: <Za8znk7Lwqpl0Kor@google.com>
References: <20231105204759.37107-1-bryant@mai.rs>
 <20231105204759.37107-2-bryant@mai.rs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105204759.37107-2-bryant@mai.rs>

On Sun, Nov 05, 2023 at 09:46:16PM +0100, Bryant Mairs wrote:
> From: Luca Weiss <luca@z3ntu.xyz>
> 
> Add a compatible for MMS252 touchscreen which appears to work fine with
> the MMS114 driver.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Bryant Mairs <bryant@mai.rs>

Applied, thank you.

-- 
Dmitry

