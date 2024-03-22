Return-Path: <linux-kernel+bounces-111425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D7886C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209DA1C210DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A153C4438E;
	Fri, 22 Mar 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pb/Z/h0q"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FE3FB96
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110939; cv=none; b=KBdp/Xpxx7hruoqfH5tOnhxl9LD1JThxBBdThLXuhekIrvm/4aRMHnuNB7jjovIlvKp4Kqk7HNl75m6gDGx/+PEaNkLexgSmRafw1J7IR9zI+yuazOqUtqyiIz8HoVhlsWiTGA5n1DGHj64gg+BIIZw99E5bfppCtA5OD0eQDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110939; c=relaxed/simple;
	bh=vXf4oistVLvkPyc/6m9dpyTFXPudu0cONm6C5paqSz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGfoiyDhIzCIadOs8ao6HQZAkJs6Jap7RSdvkAcDKmDbZvUHBI1uPK7qLNOOMVPRRrm9uh2u+x5lhRN5MLbAklk0ozZ76Kq/I2P1IxapB7bQzHnN6pvGTtSDKI+/yaUK5KlnKXHT5bclaEhOBDw+KVgNfa7v6G/0Y0X7AeD2wNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pb/Z/h0q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so1967357f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711110935; x=1711715735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaiT7un8HqnHgeFe5iogGWeHvRb9rIMP24UTadK+jiA=;
        b=pb/Z/h0qbxsL08FeZn/dHpkP2eO3kIiZ4v7XGgsx9dQIaXq+J6KoZHf53Wd9GCJcLH
         0EVyh3vSEg0Vps9ZpG+NdwSGjU/VohyBnZ2ejq+kk9TyJYBoxr9zZ8/Z7r7dU1PNi72j
         2aq4jEoNSqqhX2QaMSIB383rK6rUqURS1CMkoxPODaZDYVyLJ1uD6wTwoS9DQDxWJE4e
         NXQQPqcSjUHAjeKE8RwIugFZPvluwkZP84XGC6759yO/szKpk2Fq+f0FsciJYlBRCQUV
         bB3egH3zMBBhO3oxtBOiylX/exPqXShiiztiYNwIHtHW4gth0OgeqY/owVn/OMRIt0WO
         OuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110935; x=1711715735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaiT7un8HqnHgeFe5iogGWeHvRb9rIMP24UTadK+jiA=;
        b=cMvyVdYXW1xJKk/lxri0O2FItOoNYy/ai8xf7SuLT3SY5GnnpZl93mCGFdanW6IV23
         ajCSQAY09BrIDNFVumiH1EjQOlWOr0WgkbxElbja6fIzBcJlkbETg8NsWU2par6+3rRz
         8diRN0uzQnqM1GO3YxX9IMca1ppPGg4TU/6tVNfLNUDO+hFsXyofNcO+/xVKEkPQYBnP
         HOWco8hOUh75OLyiVYAI2nxHol2Z2irbPZ/z/Xr88FotSww/pgLe7gM8ASb7VaTDafUF
         ECZLVn8r6gM4y/uFqPnyvi2qQfEdzpxWiQf9NtJswqGSooTIqW/Sez+CGKcmSBGjzCZ3
         A/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj1FqdBYnrnu+73wtUSY3KMxY/Mp3rVbszP7lbJ9IARju/qItDBO2eAUTUJyikmUm0trCCJbizU7naJHsyYP68GKWJfvV60oETXdlg
X-Gm-Message-State: AOJu0YyuqtUwCuq7mrX8f+UjyAi6px7jm8K2JJeyaTlZeC4QPwP1ukO3
	9HcPXTgQ3kibI0ydHJnDLahFRcov+d3iCqouTGAGU7rfGNCwztpzNagPhem002Q=
X-Google-Smtp-Source: AGHT+IEr23lPjPBzHfm4e4fwAdjKbh+mxb36ENN4fFzUMtd+xvx1PD26UevBeCxTwHiEfO+ScZYTkA==
X-Received: by 2002:a5d:4047:0:b0:33e:5970:e045 with SMTP id w7-20020a5d4047000000b0033e5970e045mr1909894wrp.21.1711110935515;
        Fri, 22 Mar 2024 05:35:35 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id az27-20020adfe19b000000b0033ed84facdbsm1986781wrb.82.2024.03.22.05.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:35:35 -0700 (PDT)
Message-ID: <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
Date: Fri, 22 Mar 2024 12:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port
 description
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2024 11:52, Dmitry Baryshkov wrote:
> The PMIC Type-C controller doesn't have separate role-switching signal.
> Instead it has an HS signal connection between embedded USB-C connector
> node and the HS port of the USB controller.

I take your point on port as a signal but the way type-c determines 
data-role is via the DR_Swap message.

https://www.embedded.com/usb-type-c-and-power-delivery-101-power-delivery-protocol/

We receive an IRQ which is a packet containing DR_Swap - TCPM consumes 
that data and does a data-role switch.

The port then establishes the link between typec-port and redriver or PHY.

So, I think HS should be dropped from the commit logs and names in both 
series.

BTW for the GLINK devices I think the adsp firmware just notifies the 
APSS of the data-role switch so, these types of devices probably should 
have an epdoint with "usb_role_switch" in the name.

---
bod


