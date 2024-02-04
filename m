Return-Path: <linux-kernel+bounces-51907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6C84909B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEC2B21576
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AFD2C68D;
	Sun,  4 Feb 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvyYyRLP"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF442BD1C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081587; cv=none; b=OHvlVQ8EYemD7bRNnfRjHEgKgZEdw2X7vNNB5kM/1ztvpodO0gs+5ZLVnqodgl9DO9uVuIkrJ+kFY41jj9Q5gLcN/UCNfCIZgITwMkv8IVZugMPS4YPrhn0MjPGsw8xAgvTpeMRRyqv9RnS/1PE1ZIN6qwaFHYtcbJMaxmfw2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081587; c=relaxed/simple;
	bh=K6O9xdeVXuc0KxHbPw8STNojBfmlQnYeHBpVl06/yaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaSxUAgkVOCzQPj6BDuCAcTyEgZMAVfhTJR1BeE4MLvs/Mo6cPBkq3kxpoWCMFVqNOgxZIymiPII3/jOzasctL7oxZy+E3tGLx+B3IvBfOSAiRHp2l7raUR50UwORp8LLRJXrbyq49dN9Bf/Nr+Uz0YC1RuMSot3N8YlrSeEa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvyYyRLP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6daf694b439so2574883b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707081585; x=1707686385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6C2ukKtP7fnWmPbnTzxW/VY9dnM+0sU2VrTHO+9YVk=;
        b=DvyYyRLPr0oVXlGiGMQHVZayIgKGvSb58uiahFKrBdyj5Vq4o7UIVgqgNjlsWntwp/
         8fU5AVEMJR8YimVBYaz+AW5dhObKGp7TBmCeluOFpytGyswliMHD3QaK2nEhG1N4KH51
         bp9f31QysCJ9OKu8DCsGG0qB+piQN6wvX8ZnWjaxzAVHQAY6BZH4OManUvueNl0lTRr9
         PQ+v7Qdg3Hsp4X7kim/i9jt5dnDC2PIKpSBFvDUISgaDM9CUBBeYNFF4SAjvzVY5HMfT
         Jy8Bg1G7NTX5r6Zn1GDGa7ljHIBMSL4VdE7kjwkVZ2wsrI98mX2lznnam+gfuOeOXVom
         DZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707081585; x=1707686385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6C2ukKtP7fnWmPbnTzxW/VY9dnM+0sU2VrTHO+9YVk=;
        b=ZJZej5HlS/9nsJFhAsNn7rFPBBcPsdzgsJeqwlkrvhwIeCg3gw4tTosfNFmtX+CaHy
         f/+cbAQIQZJcvWnMfwfj5TPdO1wGpTe+pKNrax1u5Sk+nZL+3yEM+LISG6uHqNlhE882
         +apnlywGmb/ec1RM/9M3cK5C7M/EFOv3EfIyPFlpVP2BnCfn5Agc/X6XbVK2Xpjfep3U
         bUjCnfzC9C8yB2kzWBB921g0zG54LIBg1vamHcLL96NTOcgLPsShLegch0N2QK/hKuO5
         qFWTJFczvamyPD/BCldl7t+7U1aeq+U9q4SYFKtK4upjpUuqPPbdgZ6Dbh1xecBfPtm5
         3B0w==
X-Gm-Message-State: AOJu0YznbhFfwlqdDaTPelN/wgJqCWllKybCbIn+n+wctEKTi4+8cbTj
	MAsfC8cUYk3TZZ1C1Zc5qkiydgW6QMT1TqpAMF4vg54Iibvjk+SV
X-Google-Smtp-Source: AGHT+IFNW+yq4pBkMOqIHv9TaIMr/iyWxnn1MnSWaqrXkslLeyDW3voNiu3PzWGB6nvqqX7NgLLecg==
X-Received: by 2002:a05:6a00:4b4f:b0:6e0:3b40:e375 with SMTP id kr15-20020a056a004b4f00b006e03b40e375mr1654262pfb.31.1707081585471;
        Sun, 04 Feb 2024 13:19:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX++ijGAyWGwoauuBlNcpUdZYrFSnbYYCZ1HMXQngMaNRbeTgqB5JjsOmJYuum8j0Z75WzBKMD3O/LTrx6hO8UrCO2nJzLd+LZgBPaDkIf6iAzo9CGYL9IzZRGjyPDfMSqPZ0qIqSR7kOZxxMXuMme8n6SwX08GrVgkdU40iX/RU8N7cAwywkW8vkMXYj03i47DwZl1PCg89TZLhLXwLmwP
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id e7-20020a056a001a8700b006ddb83e5e47sm5310447pfv.90.2024.02.04.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:19:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Feb 2024 11:19:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: Workqueue regression
Message-ID: <Zb__cFpyP3B2N1hH@slm.duckdns.org>
References: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
 <ZbxK01xuA_FFWaE6@slm.duckdns.org>
 <17cae1aa-98a8-48f4-adf3-2ddfc451bef6@linaro.org>
 <Zb03LDPmMcBU0-Gj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb03LDPmMcBU0-Gj@slm.duckdns.org>

Hello,

There was a bug which could easily stall flush_workqueue() which just got
fixed (http://lkml.kernel.org/r/Zb_-LQLY7eRuakfe@slm.duckdns.org). Can you
please see whether the patch fixes the suspend problem? 

Thanks.

-- 
tejun

