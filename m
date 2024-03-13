Return-Path: <linux-kernel+bounces-102498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2087B2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323931C25702
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40694E1CE;
	Wed, 13 Mar 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKiHump1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B2E629;
	Wed, 13 Mar 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710362380; cv=none; b=K1p2gH4/p4fHe0g1QCnoiLt03g2OOvCSNaiZ6UNNuTF+j+99gQJtQxFlMoLJHxksQASJMWnchEz2WG5cU98vz6S8Ij1zEtSNqk37hE+gc67TVSJJJzEY7zpS9xO0Cytjg2NoMVkUIjihSUxQctcfbjkQVp7bn8aixIoi/E7TH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710362380; c=relaxed/simple;
	bh=B5te+7bxzJ9qHExPAAMr7pHPWobOwgO9aT2CbAG1Vyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvOPk7w9R7VFSGsoo7/TPRkvLAxQA9EmWoUceCSU3arAW6GA9inKbScG7J1H0lMizaL4TWVuLUT+x+xexPmMpb+Tvv+zqvyBKXWLKKqxw1kU9iGvs+q552sSVmPYAfDa8XuB1q7lrx0ojZbToD3EYyJVbuNuEUo5lR9sMy400fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKiHump1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29c64ee87easo247369a91.3;
        Wed, 13 Mar 2024 13:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710362378; x=1710967178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyu5FEzeA37wRHOaDO/zzPay3cpygxvKSMTi6XiaofA=;
        b=kKiHump1g/4Vy66v43huHZ88ye7N3ljj38WZox/1DdxgjhVi2iYiaOcPQazTYfl28N
         5bbS2XUu/KX9VzEntSRgKRH6c54PB/Z5+rLlCijNczBUUyFuzsBIpC+zpkgK9ew/1Bpj
         JGlFV6SlncigL/j4FgyUip3W3RVIy3B2Jv480dmlG7gj8sBJnLWhgVcEpCpVRVSmhE/j
         cnt+SmJ91ZrEL2NDw4or3Ok6gkig7IFirW5lnLpRnBII0OxcdJyH8T4taDSiTlhxOY8M
         iVqy1Q7xw6Jg4U7E6VWk1wNjP7ciC9EjsFdg3VAFh94id4nuE3loxyx8OgIVocpbo+lM
         T9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710362378; x=1710967178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyu5FEzeA37wRHOaDO/zzPay3cpygxvKSMTi6XiaofA=;
        b=lhZTnMi+wwfyliclBAXRgopsv/7pIr6F9Zjz9bXvbrq5fcNTmCsxrxS1RK2C11wgas
         DkKuKEezRekdgfcv7ZgzdLyC1TrpBcaPKpUGqM5dP1zU7JNT/NXLRszQOFX2LACEpc7Z
         oUY00GzKqWHKTSmg+LechuIZwfEiIyNqh2BNEKEQ5JbqTGpojMp9HEoa+V7hB5E7qViW
         DnAk7xr9IFiqyPCgkTAakkWdFo20iTv/frh7w/0ewAst2NoMtSNaXSTgNxWVZo3I0Sde
         Z8rs7UT0daYqo07hKWOMHXy9DsnEtl71kXJD0mU3XWjuI4WibxjQHXKO3PAEkeRefiTF
         degQ==
X-Forwarded-Encrypted: i=1; AJvYcCXssp62+ejfIgUbLYim9NHV0sEPhv6s77+Yr7MAeAhV3veXTsHaPNbCrmaxtHJh6Asxegm70bcXdASL3oYbeDHPRbL0Kdw9l2esT4Ch0iq4XGNAq+WOvACvHjiwKXf9DVg3Dvcx
X-Gm-Message-State: AOJu0Yx59j2FYMjomFLcTJ8Cx48TS4O/kYM3JgXwOOyVwcoaCHZFTv98
	YJPagRFBDASJR/kJAgbaxTlXvZr0ZYShxRGD6/ecWO2Bqd1w+vCx
X-Google-Smtp-Source: AGHT+IG2GsiUnhBfNRqw3czUZr4DxvX56UPAronO4ziBqWbfsgzxWhVKJWg+wGbSnTm11egfkDTtqQ==
X-Received: by 2002:a17:90a:5647:b0:29b:c172:2c3d with SMTP id d7-20020a17090a564700b0029bc1722c3dmr4607969pji.39.1710362377725;
        Wed, 13 Mar 2024 13:39:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q66-20020a17090a17c800b0029bb1631819sm1677246pja.0.2024.03.13.13.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:39:36 -0700 (PDT)
Message-ID: <b4ab8f64-7b33-4365-9ad5-510171a7f9b8@gmail.com>
Date: Wed, 13 Mar 2024 13:39:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ronnie.Kunin@microchip.com, Raju.Lakkaraju@microchip.com,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
 richardcochran@gmail.com, UNGLinuxDriver@microchip.com
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
 <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
 <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
 <3e84e1c9-f680-47fa-aa59-615ce57b65da@gmail.com>
 <725e8182-50de-4469-9f87-fa58179f8922@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <725e8182-50de-4469-9f87-fa58179f8922@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 12:52, Andrew Lunn wrote:
> So i think we need to agree on best practices for new drivers and
> document what that is, probably in both the ethtool man page and
> include/uapi/linux/ethtool.h
> 
> * WAKE_MAGIC on its own is O.K.
> * WAKE_MAGICSECURE without WAKE_MAGIC is invalid. -EINVAL
> * WAKE_MAGIC + WAKE_MAGICSECURE means only secure magic WoL.
> * Each driver needs to enforce this, due to backwards compatibility.
>    Some may decide not to.
> 
> Can we agree on this?

Yes, that works for me as well.
-- 
Florian


