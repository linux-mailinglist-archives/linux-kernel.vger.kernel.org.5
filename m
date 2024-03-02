Return-Path: <linux-kernel+bounces-89318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2B86EE46
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B37B22395
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB08BFD;
	Sat,  2 Mar 2024 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmIr4pis"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB526FC7;
	Sat,  2 Mar 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709348701; cv=none; b=UPds5TwgQCuwmiE1AY6RNZ0V8eIbtSoTR1h6xQs6hWg+3I8wAsKauJFBj14Ibgz/x2nqUaEiWJjcO6Wfj13Ku31Bo3jvbzRGNEyb3zwGsjQR2L1oOYg+XkM46qa4AK/oTLqlFVbuPGwjOqbgvgQMsulXopXO5Hyx9GxPgPabL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709348701; c=relaxed/simple;
	bh=LjRdtml+TWkAxLUN2QLF1D+9eq3HZY+GgDjZ4XrSTSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1KcRmNvL+/aT6QOdVnqiygWIrRX+pjhfskeiEodzxjrdpB+m8HbQI+rY0/cBxH9Eg7lxKYGV9OSXYPMkRkJ9hSulscSm7T1ERfPyLGZFhYNgwHwTLodL1A01A8zFcdgEhttYe1khejOMJ6QOsBdNhQPnrJkpC30qYs3j2rnVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmIr4pis; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29b2f10454aso543362a91.3;
        Fri, 01 Mar 2024 19:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709348699; x=1709953499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z6p65/mjNFQPH7dw5+cTMNx3ec1jAPgpJTpAMLhs/A=;
        b=mmIr4pisOMa+SPojjyr5XwjZ0MieduDYku+KzzyYdedC2QxBDnRSiYASU2jegxLGA4
         7v8vRpOVjSMARpcMe++TEmrwHCD9I2U7IozFn5KqPizIQ+RowXsa9D+5GRkwIZRLXTKM
         Z2mcPkhO3cb1fzIK+8BMZGmz9mqYAALtQxSeHgvnrlzJ/lJALgFzNOnlGGXjmahPfPUU
         hQXqdltkDLaLga+vCiM37wSTX24j/4qNcjoIuVWUCnz6UvdLmAyeXwALHsM5JQHFRSyl
         9EPkXCzufC8o+iSfi0baiyB83xT1adGX8MbjhBx0iuPldmv1n2ii4UEaPEYhaYcp9bWM
         lbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709348699; x=1709953499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z6p65/mjNFQPH7dw5+cTMNx3ec1jAPgpJTpAMLhs/A=;
        b=Efw96Kd4U12VmS0QkO6Z23sLcUwpEWbGxSL4hhw4zwR61DMeZzAUKXdc1PqUOB8g3v
         /TQVyWLSdn3erWQA2uWLfNiwNq57PuAlVwbnvm92CDor3RfkqeEmP1pqhFe52MbkoLhL
         Psajh8501OQschBcObSWF8MObw2ym/AERURUKqdLSff2zIo8j5GbeRG0sbsYFvXcbjf8
         Z2UXBKfvwM7gprbhfIkT1jJsc0CcRl0FLtnIciJ9ks3kohiyKq+GLluUkq0/0fJpERLW
         8y5sOUXzk+Q2LvS08aApUDdOpFGp/oN0hi5k+wX2V8xXlzZjWR/ZNXmyxEqB8/ds0Jeu
         lP2A==
X-Forwarded-Encrypted: i=1; AJvYcCWW8LUFz2WBZXLH3guWqaoUHCMYQyPvBr3vdMZACpI6dEuMYxfjbk0tP/NAb5PB7fbHGLRldZWJE5J4C5UzT/mk8jfVYXx6sE6a1JIydl6xdlxwBXcFOIYbUjR4qsPlOPMhXJxbEyUfKGe4iOaoEPKmdGzpQzeLM2wJOdLnnoB9Wp1qvywD9Fg=
X-Gm-Message-State: AOJu0YzWZo3hEFzJh3oGG5oDjEQEr5VeCviqoTh5RF9P/KxWCoOEBySe
	dc6GJkl8TXQq/8GCOM//JHwiFZJPePr9UiWNp3/6PuIzu8w0lar4ozpY0f3WdBtgGQ==
X-Google-Smtp-Source: AGHT+IGVEmDcDGBZB8FBm1UyVE1F5P3FauUqNd7CNcpFCUyzo1/wS7jz144FjWLtV/HlqgVh8Lw5xA==
X-Received: by 2002:a17:90a:df92:b0:29a:f9ad:a096 with SMTP id p18-20020a17090adf9200b0029af9ada096mr3092641pjv.35.1709348699363;
        Fri, 01 Mar 2024 19:04:59 -0800 (PST)
Received: from HP-Probook ([103.149.249.227])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001d9bd8fa492sm4152232plk.211.2024.03.01.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:04:58 -0800 (PST)
Date: Sat, 2 Mar 2024 11:05:05 +0800
From: Jianhua Lu <lujianhua000@gmail.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd
 negotiation support
Message-ID: <ZeKWc6rCJBLasn-h@HP-Probook>
References: <20240227124529.12926-1-lujianhua000@gmail.com>
 <2f6a5c83-69a4-480b-a235-c0d51feac31e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6a5c83-69a4-480b-a235-c0d51feac31e@linaro.org>

On Sat, Mar 02, 2024 at 12:58:57AM +0100, Konrad Dybcio wrote:
> On 27.02.2024 13:45, Jianhua Lu wrote:
> > Add usb pd negotiation, but charging is controlled by pm8150b pmic,
> > so it can only charge battery with 5W,
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > index 6f54f50a70b0..ed103b90f4e6 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> > @@ -636,7 +636,8 @@ &pm8150b_typec {
> >  	connector {
> >  		compatible = "usb-c-connector";
> >  
> > -		power-role = "source";
> > +		op-sink-microwatt = <10000000>;
> 
> Is 10W really the minimum value for this tablet to function as a sink?
> 
> Is that what the downstream kernel sets?

This value is taken from other device, I will adjust it to minimum
value in Patch v2.
> 
> > +		power-role = "dual";
> >  		data-role = "dual";
> >  		self-powered;
> >  
> > @@ -645,6 +646,12 @@ PDO_FIXED_DUAL_ROLE |
> >  					 PDO_FIXED_USB_COMM |
> >  					 PDO_FIXED_DATA_SWAP)>;
> >  
> > +		sink-pdos = <PDO_FIXED(5000, 3000,
> > +					 PDO_FIXED_DUAL_ROLE |
> 
> Please align the PDO_.. against the open brace

Acked
> 
> > +					 PDO_FIXED_USB_COMM |
> > +					 PDO_FIXED_DATA_SWAP)
> > +					 PDO_VAR(5000, 12000, 5000)>;
> 
> 60W max? This is not unheard of, but I'm just making sure you know..
downstream kernel's pd adapter allowance is 5v or 9v-12v and vendor
charger allowance is 5v-20v...6.2A-3.25A (67W max), so I set it to 60W.
> 
> Konrad
> 

