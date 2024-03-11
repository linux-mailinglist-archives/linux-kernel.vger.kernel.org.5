Return-Path: <linux-kernel+bounces-98557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79165877BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34556281990
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754512E48;
	Mon, 11 Mar 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVsZEDEL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B514275;
	Mon, 11 Mar 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147255; cv=none; b=Wu6ouAWvz3zy1s2rOGVxN0/XGfvwpWsTrNxs7GaQuU3MrhHFKvMgYCUSEw0zuPT5RfnOQvQlnIntdz1lVKuRTNoYxNCfDMuTsNvhvZ6n/Kh7Jsd0yTyflQhj2jCb6kvQAK34wq3x20GQZNu91DqWZrRdBTkDGekWmnL6MdASwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147255; c=relaxed/simple;
	bh=zjl/ZMJ0u3UyGd8OiCAQ8mhecl2n7u9/YwXUtVa6vOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RbnSWLsT0wbEa1XUM6mRD7Bxozx76I6f3tE60+z23BlsYSn/1VR0NdaUhpGD7YuDTWMaiDKizo4Z3WsicS4WIcyFRtkaaNmkmSu8WkJ0WQlNtK6t2h9JVWxQe14VchLIoBzE0MWP2J2mCSWoAyXXecdcFxabquKgptaEoSFw6uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVsZEDEL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so400118366b.1;
        Mon, 11 Mar 2024 01:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710147252; x=1710752052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjl/ZMJ0u3UyGd8OiCAQ8mhecl2n7u9/YwXUtVa6vOM=;
        b=kVsZEDELK5TaNBxuNcI0KGlHzukrUW2BaUyS3+qL7Y26IGtwcRMKRGmWLdhG9fey5W
         zvxj2AqRP7QJhNA4mMFiJ3Z/vBXB6zLJywCVCu/WwFsZL1DS49r/MMdADmlI5s//i0nL
         b7eYsdkfT+Zvlq9VrG9SeJLdplqyQbIRW1f07VinpZgluoBRsjggNflrxPbab41CMHiC
         oJD8GgEuJ/xtgcKdTm5vzII6Ye+35COuztjrjd1HokVLa3IsLIRTS4XxhTwYQr2W66p/
         V2PymaxeUDcggzuWygy0xX8kHf4ZM0vCoqfdgJs2lq75k+DeJN+3sFasyiMqaZYiFL4k
         XZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147252; x=1710752052;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjl/ZMJ0u3UyGd8OiCAQ8mhecl2n7u9/YwXUtVa6vOM=;
        b=CdK8To704RUXsIvD3qCo3I6Tx6SInxuPkvIZNqqUpW5YGlQc9MCcb8w1fZdihNMh6f
         npTCbgoVlkRcCnB9pvwyF4wOjIxsuq7k/UdCxbsNvPS7OrBEjB/DhigNya7060BjwuWc
         u+t1x7em2HmYHZox8FTGOYfSPhgEOBDgd2JXq6XLlj2RFvLr0xW7A+1Dc1p1rtyQ9jcE
         D596fVmTAQDjhPtvmnDM0PuxbZI6VaiWuvFX+vzWr0KoTefHHt3JwK1ryVN1A8eMzdkN
         tYgODlAuH4mpA0jFFIDhrQnpo4rq4M7LnU99S1yZxDXyumAG+3H9Bc0I+ZktbhpO12Sl
         cpRw==
X-Forwarded-Encrypted: i=1; AJvYcCVDiX0MjdCi2Xl3xN4xV87Us6d4ZGKCL3s7f2ezmXnV7ZKN4H17eb4WdIYfO/TbYmYuobT0a7O/VUI13tRS9+HQhgIKtv5FudSHbjsQwtKgd15sHXjkyZCsCS62EUsOI916S2Qowr5hGUlJyy2/oPArDyR/yAVC97OTaKKS1ulsCqcdBSZ4C3AI
X-Gm-Message-State: AOJu0YylZArZwDYiMWOMb1kZLHE3baS3CVZ8BAuLvTX4uC1Wvi0A1Omy
	O7ov3bolGenhkh4AL/Ye5z2n2QlyH8RtD3SgrF3uE8QDwvpBKi5x
X-Google-Smtp-Source: AGHT+IFT6TXip3cIv42+mayOPyoOa3YQVhKoI3pYPvMAuNdvx1lgILjvxIdnpKJorYhPPnkmghxVmw==
X-Received: by 2002:a17:907:d40d:b0:a46:17dd:33da with SMTP id vi13-20020a170907d40d00b00a4617dd33damr3172904ejc.29.1710147248854;
        Mon, 11 Mar 2024 01:54:08 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709064bd300b00a44e2f3024bsm2649396ejv.68.2024.03.11.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 01:54:08 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:54:05 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: stano.jakubek@gmail.com
Cc: baolin.wang7@gmail.com, baolin.wang@linux.alibaba.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	orsonzhai@gmail.com, robh@kernel.org, wim@linux-watchdog.org,
	zhang.lyra@gmail.com
Subject: Re: [PATCH] dt-bindings: watchdog: sprd,sp9860-wdt: convert to YAML
Message-ID: <Ze7GreWtuUtMh6MK@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdDUlGdqH7Qv3SDu@standask-GA-A55M-S2HP>

Hi all,

I was about to remind people that this patch exists, but apparently it
already got applied without notice? Seems like it's in linux-next already.

Stanislav

