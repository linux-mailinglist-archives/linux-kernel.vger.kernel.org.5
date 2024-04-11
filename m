Return-Path: <linux-kernel+bounces-139990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD68A0A03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E721C22C56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ADE13E416;
	Thu, 11 Apr 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmhYHB3E"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5713E3F4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820901; cv=none; b=T1RphAtWSauwTmA8vIRtBDZx5o0lTsDz3PA9/ZlFTYgjI1D5ijHeGyjmEvfbrgi8e8Yh4sDXIoIyml+q3eeI8iqe4x+qKn+EiBT58SQNtjth6EhePIYCO09KEbRMIINg+24QxIMRH686GnMmp8Id8LCpp0EAqgSu4XvdIwQTKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820901; c=relaxed/simple;
	bh=nFZho7rY96MWaWXzu2H9upbtA//V7DIg919Lm0TOLF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5bUDqlaJuONphTfJEr0Z4IKQ/VqykNyWLnzEycx3ky8hBH7H/Q3gwF3eM6n71/nIq4EiXp4BIYrDB5hgKuZoTcArmShMWdKIk+lvEESDlH+fKFz2Mnz5Madk/HotcdGmzcbJ60qs+Efu8SE+4JC99/JcWG0BYJlXZg2QyYGQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmhYHB3E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so3161285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712820898; x=1713425698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wTRya9j/yXQ7exAn4Pr5Hz1sz42LnCmFHpD78fNycCM=;
        b=rmhYHB3EzTHRo0zi/RzU2+bsdPplPknTA48DLcne78psjYvrNpsXAjtnvsJIOMfojl
         JMc/bj9wDNra+AapYBLTSumXSDboiKZfJDN51vV7grPZxHT/R/31Tuqg5j5Yp45RVeC/
         riVvheL9OK5yM08xBYl7VcFEcZOKm7AYqRce0j/ABpGw84ApFyy1RESyWYgM2gu5JMbd
         nfO/A3n82iuTjDUeTyVZx/W+OAPl6ykVMg78gvHCKUN5NmTHeMcEuDdCcdQTcLbVtWVC
         Bjp0rN7qLuaaBoyqRM/1jFIbIh44VL3ADRZLyDmMmeobk5ytobkm+06K8kHrQLRVuIJU
         iKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820898; x=1713425698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTRya9j/yXQ7exAn4Pr5Hz1sz42LnCmFHpD78fNycCM=;
        b=QCXvpZNmUtxMkDGfJrIc80yG8Mj2LU0PiqlIjl7AZFYkk6tk1/aNC0OK/3ab4EbT4a
         Xba2h3uLCKm6t10I7N1W8T/88fv8xxRWINgBJPbhC3L8PSTPizwgelHFj/f9N8nOs8NS
         /TYN8YwVHx/7dXUT/uoi5a/IMWwvuNB6GRJBgRQCjgnL/N2xrSUxp7kPEdcoW0WGL/GI
         5nFtbAy4THOpZJeKE3o7uahu5mwbLnbjTK1V/I9FEFSqam4XvO+Gh8yM2a8Ej/WjBwRu
         HTtylHfTrP9zO9S8qdSXXe9KEWxcvQ+29f7bv5toZmVubsjEmKTXAM9EzcXuj1aD8BY5
         kglw==
X-Forwarded-Encrypted: i=1; AJvYcCXelyG86PnC9W2K2O5kJNkkjh4xliQFa5hgkgd1BsOACVT3Jt94tcf/TW/KcXkDYmngnYDcK+OfmaBa0VSIwhlIu8hFsGVxtrTnRLvK
X-Gm-Message-State: AOJu0Yy79dNNUIm8sYMwVwH7haASWhLyd2om4axnMDdfYT75B5iVVI3r
	C+G4H0gIj9QODlvNuPYq72WSQQ0xYgNF9shjLZFUJGwb44X+wRBiNGXGS1Ximtw=
X-Google-Smtp-Source: AGHT+IHHgtddy8hsKqgNf1eT8v4mskzXCqSoaeMsa5y52dj+JIU1VHHEx+e2FOCpQVeSg1zJ2+RVBg==
X-Received: by 2002:a05:600c:b8b:b0:417:e5c8:6964 with SMTP id fl11-20020a05600c0b8b00b00417e5c86964mr15688wmb.20.1712820897871;
        Thu, 11 Apr 2024 00:34:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b00416b2cbad06sm4648074wmo.41.2024.04.11.00.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:34:57 -0700 (PDT)
Message-ID: <37c5710a-426f-4054-8632-e24b9d920bcc@linaro.org>
Date: Thu, 11 Apr 2024 09:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Samsung Galaxy Z Fold5 initial support
To: Alexandru Serdeliuc <serdeliuk@yahoo.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410-samsung-galaxy-zfold5-q5q-v5-0-9311ee9a55f7@yahoo.com>
 <8f2c7963-c660-41b6-a93c-0ac19818ecda@linaro.org>
 <46bee5df-3d66-44c1-9d7a-86e32a2149dc@yahoo.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <46bee5df-3d66-44c1-9d7a-86e32a2149dc@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 08:36, Alexandru Serdeliuc wrote:
> Hi,
> 
> The list of changes  (changelog) from the cover is not what I should  add?
> 
> My patches received only two ACK tags, on V3 and on the initial request 
> (v1), I was not able to identify any other, I added them to their place 
> in the change log
> 
> ...
> - v3
>    . added b4 version 3
>    . removed address and size cells in device description
>    Acked-by: Rob Herring<robh@kernel.org>
> ...
> - v1
>    . The initial request was split in two patches sent due to the following checkpatch warning, was requested to re send them together:
>      WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>    Acked-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> 
> I suppose that adding them to their place in change log is wrong, I 
> should create a v6 and put them at the end of the cover letter? Or how 
> to proceed?

Please don't top post. If you add them to the changelog, how are they
going to be effective? Please apply your patch (e.g. b4 shazam) and look
for them...

Submitting patches explains where to add tags. Look at other mailings.
And finally: why even bothering about this if b4 does it for you?

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof


