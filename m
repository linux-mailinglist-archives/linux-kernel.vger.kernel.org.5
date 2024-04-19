Return-Path: <linux-kernel+bounces-151723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1318AB2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD321F2244B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C85130E2A;
	Fri, 19 Apr 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEgQvc+N"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F02130AD4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542615; cv=none; b=JKJVxvlBcQD12iLLW/qtAk5PDMvV/7YNwLWHNAzONAt19pPi/VpV6WI6rM5eYaRaIKQcDtiVUn79Em5bSL8KFbn9iM8NACkEoHPX/UqOAhg6qjGibE3eRYLE/PgSopMdvmMsDwdMMTpFAedGzVO/qW27oYPVgCZ5q9cKrww5WMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542615; c=relaxed/simple;
	bh=/eXm0CTaLlshMmOpuJ+Hb0diIo+ynEWJIFTKEePjGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2PvDdQ4xFtYL+73/s75dH8/jvWG69NTHnrSMZ5163Ghe8BzljgKj9Xi+oeEQ92ZAbNuzDERtvlK5kOTdCEFtIEEk0Cgd5ifQu7+GXSN0Femt+R7kqCvU5OlDmP0uAzjnFlvcN7Atl7Hpz57C1JVkKJKeCgUs4KCLvTAx/v07pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEgQvc+N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so16339605e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713542612; x=1714147412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9K87eyQsJcPV+MjC9TGZ0b2ErIOF7s0I6KGHZUdEzoY=;
        b=zEgQvc+N88bX+glGqWa/yGXwTIooRIidFGDWBPF/SrkYef0Qa+2jEggM/ajYj+ukj3
         vLpbN4dp5Sinja6c9YNOOQiEhuW5L7NeLa1qQp3ENZVH9jQ7hkx7uOr66F5eFkeLByXi
         CTLcEM7PwTvt1XLm7iq6H7KNNR3n5uio7mdet26R8bM7Blt0RFXMnaVUreeV0+Q9CPMb
         lqshwqHiPAHMRGFQHQEgVRF39rQ/HoZLHfl/NFCI4hvVYRWgnxvMkORHfmYejWN9NbEO
         nfGA+VH6cSsD+gJcIvJhaDNa+5cOZYH1lKAY3tP1Wjm0ioi4lcT89F4UIzWfCuki1oc9
         BrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542612; x=1714147412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K87eyQsJcPV+MjC9TGZ0b2ErIOF7s0I6KGHZUdEzoY=;
        b=Dq4Ng+6Sm1g5p9UZCDWeDCwIR4kHTk0FjqYuxt7FER0pCYjUryjyFRo4ur+uguZ6GB
         HbAIhHYAJsKfPXj66eUc8A4aKChCzRjjWkz5h9FH62SgCt6s8V02YJcRJ4AyBdxXz7u3
         zMAdd6UflMz/zG43aTbQ2nt8L+g1YfhzEqjjNPQo472+PE+3xQ5Ynu7BkYhrZqJnooea
         pj3Vu5cC2WowtcYon1/GARUbiQ7LALHkxK0lI+AtemUkb9PZSE6Z9D9fHBI+00+92Hx8
         an8JCantmUZQWX1F9tHkVMO/IyjwaxYhH/Ir+6E38w+b4DIrPPcKe0i/ouRcvCU71gbX
         TYQg==
X-Forwarded-Encrypted: i=1; AJvYcCVjiMuuzp/63ViJI07g+cYr+cqlsbOXs9E7cr+JZWPK9pqvs5Q8lr6Zhc8bBWnuJTGh+G3MvNcXHGZp+rJsrPrEe/SFVGOEXfaZrN+m
X-Gm-Message-State: AOJu0Yzq8LUMRU87zE82XWhQQ71/WbiZoZToN1KZTXbv2V2Z0mPdbLNQ
	/JdOWhsYge8DF8x41kUT24GYrXkhnvmRGWvC/jjDq5UYLhxdfIH+t2gr/hXxNa8=
X-Google-Smtp-Source: AGHT+IF61j90FxwaOMyvxHlliptjSNEA5j4fWAYLAKVrzRuIp5qzebPKQLaE+h5oX2Q4HLOyia2QSA==
X-Received: by 2002:a05:600c:154f:b0:417:fbc2:caf8 with SMTP id f15-20020a05600c154f00b00417fbc2caf8mr1783059wmg.23.1713542612133;
        Fri, 19 Apr 2024 09:03:32 -0700 (PDT)
Received: from linaro.org ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b00419c4e85b54sm1405965wmq.16.2024.04.19.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:03:31 -0700 (PDT)
Date: Fri, 19 Apr 2024 19:03:30 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100: Drop the
 link-frequencies from mdss_dp3_in
Message-ID: <ZiKV0ube6J8pXXfU@linaro.org>
References: <20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org>
 <20240418-x1e80100-dts-fix-mdss-dp3-v1-1-9f8420e395d4@linaro.org>
 <ZiFC8d6cD35B+PaC@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFC8d6cD35B+PaC@hu-bjorande-lv.qualcomm.com>

On 24-04-18 08:57:37, Bjorn Andersson wrote:
> On Thu, Apr 18, 2024 at 01:22:18PM +0300, Abel Vesa wrote:
> > The link-frequences belong in mdss_dp3_out. Display is broken because of
> > this. Drop them from mdss_dp3_in.
> > 
> 
> Why is display broken because you have this property in the wrong node?
> Isn't it broken because you don't have it in &mdss_dp3_out and this is
> just a cleanup of an invalid property?
> 
> Perhaps that's what you're trying to say? Would be nice to have that
> clarified.

Will drop the "Display is broken because of this." part.

Thanks.

> 
> Regards,
> Bjorn
> 
> > Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index f5a3b39ae70e..0642b5e88639 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -4096,7 +4096,6 @@ port@0 {
> >  						mdss_dp3_in: endpoint {
> >  							remote-endpoint = <&mdss_intf5_out>;
> >  
> > -							link-frequencies = /bits/ 64 <8100000000>;
> >  						};
> >  					};
> >  
> > 
> > -- 
> > 2.34.1
> > 

