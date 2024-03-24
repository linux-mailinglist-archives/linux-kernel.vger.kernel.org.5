Return-Path: <linux-kernel+bounces-112803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A33887E59
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3341328180E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3393BB46;
	Sun, 24 Mar 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNdlhvLj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846173A1D1
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304837; cv=none; b=rk3o4Rg5fT3KhsYnGHKbr49+kArDLKvlZG0CMvg4LgOGGiO/ZUYRbEjmanNYKz00Wv5i2zo87BqW1zCAweAN3+c/rgUFx/vob5uegADuJgGimIJfsmGtmQeqEoiGy5qUrz4DXk3e9RyHsWIKI4nbPXc4M/EP58pAF7mxqsIvnWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304837; c=relaxed/simple;
	bh=S4wwW9cn6LWhbIRaMDJKjos0xWCR4AxGV+X5wW+IRds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tq033cgPIlsC/K/Q+fOLKlbzEJAdevv8d8Oz4lFfuMJDJ9XlXtMYmFOoh07dG6ggcXBuDxbujW8zwCMBVCA835gCQ+ZRpcKcS9gSKeGfQdJSXRXWi6gi9+ZEm3cLNJmm4El09DoAL7uw+8OrLpk5fCtRudQQOBOszBx3sKcdLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNdlhvLj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so1060884f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711304834; x=1711909634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2AUEII76GawRGMPwgMrEb72tMFWD+SVsGrQj7LCN2I=;
        b=gNdlhvLjgC+zHTXlQFK3pT4tONwp3cxetO2vr/Eu1EeejcWwVjnoIUnBzNGqP0PHZ2
         tWteIRD749wce1QBwfDpRveWA/x0Pt3wHwBSp9BQHo4AsgbqoRWyo2i8GDIYwoPTT7EL
         C109uRB7lM7J/ls9TltNFpOa9eCq7O71b7eG6k7MOcOCHDIoGXAJhekCYqQUyRMpMFoj
         45MiQWEPPGZrVufu94MLEDgQQ3DmiBm2d0pSimg/vy1NYJ67eBvk+gCF8wwZ5359vfpW
         8Lr7ArGBG0iF117LLlMKNOQt6CC64tBhTnB26GUySDkAqSkREUQxLia8G2Jm+fujJgEP
         MeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711304834; x=1711909634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2AUEII76GawRGMPwgMrEb72tMFWD+SVsGrQj7LCN2I=;
        b=UrRHVU0rY1KQ9oanTXbg52qDTopX5Ki0XAnwDkspHpxZ19ZjBRye/x/JgtFKEWhCk/
         /GV8bLPyKILKpYCaNGrIoaPd9dLDEgWw49YDEpzb0wugPRru7LQuIfTOJMNs1n4vIOck
         BPfogN79k8CIx0Jk+xuKMow8POkSPjPL3VXNKkWinDoELnN2FCykb4ypZvXII53UU5uX
         SZjpjSGvSva2Ua00Q7RXO9Qz8X8MK6AcAgXd9KGPrPK3TJ7kuCrUDD1wC5njGQad4GxU
         vZwruiYvqi1laUotA17cCsXcGyU3/Esjy1THruf2rcILhmn9BoVeZQ6VKW/u421AJljf
         LYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqK2nE47fIkCqhGnT2fPwyDbgHhxxqOS2tKIZKUMbEvCdozHZ1pUhPNNuo23nV/6zCXa2fhMJ1shUGpai5kiKekYnpJFdkryIet3gv
X-Gm-Message-State: AOJu0Yym49Gr94qH7oDFN7C+9BDWvpC7mL7t/lAiu2TOp9d6TZbueIij
	87BhIrnOYz7BsmoKtX1y5cc1UzNjqEFbPUZFO7tsra59h5OG/CN+t5NOybSa
X-Google-Smtp-Source: AGHT+IG8PJoUf9SxBrM9M3HkDZiyi3YI7wqt/D7ThxmfZpHwHfG7A7LGLggr8r7WhRfxleKXExUQsA==
X-Received: by 2002:a05:600c:1f07:b0:414:85de:a02 with SMTP id bd7-20020a05600c1f0700b0041485de0a02mr1986250wmb.4.1711304833588;
        Sun, 24 Mar 2024 11:27:13 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id v12-20020a05600c444c00b0041487f70db7sm2304655wmn.29.2024.03.24.11.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 11:27:13 -0700 (PDT)
Message-ID: <c7c765cd-3f89-40a2-811a-b472abe7f7cd@gmail.com>
Date: Sun, 24 Mar 2024 19:27:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8712: Rename variable bw_40MHz_en
To: Lautaro Javier Fernandez Pricco <ljfp@ljfp.xyz>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 outreachy <outreachy@lists.linux.dev>,
 linux-staging <linux-staging@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <Zf4fhSomoYzCE4gW@ljfp.xyz>
 <9d8f35f6-2d23-43bf-9ac5-c88e4f65609e@gmail.com>
 <WH1VAS.9RZFLNEC6LFP3@ljfp.xyz>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <WH1VAS.9RZFLNEC6LFP3@ljfp.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/24 17:22, Lautaro Javier Fernandez Pricco wrote:
> Hi Philipp,
> Thanks for your time. Your suggestions are duly noted.
> I'll undo this commit and look for another task in the TODO file for 
> rtl8712and its checklists output.
> 
> Regards,
> Lautaro

Hi Lautaro,

you cannot undo it. The patch is only in the mailing list and will not 
be applied. So no need to do anything.

Or maybe I misunderstood you. Of course you need to reset your local git 
repo.

Thanks for your support.

Bye Philipp

