Return-Path: <linux-kernel+bounces-41320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810E83EEC2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBF5284C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A42C6A4;
	Sat, 27 Jan 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVwuKA6Q"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864929431
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706373903; cv=none; b=fVkz0Hx0lY03wSK3HO8ItCAUKQomhCy4/Dh8kp071cf63rZruhZyEFpWPAzHdnIqiT0or0hS4Bt62y3DNuRjA6/VI1Hz8opo92Pvcs2tAO9wG7mdGeBrg6y8tRzI4I/a5zOUkAeonWHn6fsynoeHcz6XpAWy77uBxd27ZIPADmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706373903; c=relaxed/simple;
	bh=vlJSya6kj6cZK+MaTAsZGZUCQE+8ZFDxHmkcOPqrWSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHnngZJnXzaqw6jyeX/qM31PPRFnaEl/DlHAZ2BuU6TA9kfhkbv8ER2Ezlw7eiS5QaQ1d8pppnuWn132JmYv2YxX7dThtPGHpgJoE2MqA8Yh8RToeyCKj6mxgXF7Pk+QUAH10JWCFddOE5sJ7EhbLTf2MWK62E/13hzzCWyo0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVwuKA6Q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30e898db99so43001966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706373900; x=1706978700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+rNic9k0UXeI7BVMKejsL/vLfG93AW2nOVjIf/o5qc=;
        b=PVwuKA6QWXYiqKqhKUX2lMGDOmm14+nVXgkRJSCJ7S/6iIK2vEokLtQKzSw0qx/lpy
         Pfl1oP0Ri07w2xCwMUxpeY3U4FwMCx3XcCzEwJyDYxJVcvTDvR9qZlzZqOyoVc2Irph9
         W1grl35pv/hFR7HwBFBRzk7BGA6LIodCF06OIaPpgvVgKjZf5GHTENawbmuRaTTqB2Mj
         ZzYbvWuxIQXguy/n3PGA4QTvOsNvFGs5XX2ULIpz6jn0FR/6uYyvpfLe+x72F21Q0Fep
         OK5DZ/XO89wTOWojIS12y3shwbU5qGesFkjEsOX99B1JqtfingK75xRFNd9Y9wZlYAlz
         IMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706373900; x=1706978700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+rNic9k0UXeI7BVMKejsL/vLfG93AW2nOVjIf/o5qc=;
        b=YzI8pA9ELps8gx5bTeHmiktPl8jj/XW3uXNm2AgLNBOpf0t3pjzbircX/gluuhrw34
         3GoZb7RDAQU2koe+PA2UBBpy4EMTGbTsgGdcnInyqWK8bPi2TfVQVimgYZFc4KT2vqVO
         Qz5mAhJ5W/Zo7sM9Rb4Mh7jZUjlkQtBM97K7t+JAXC8YFmYUV9zjsx6M6M3TCQ/9R5mb
         88rALPv4mX7ufDzxCCDA7JcONz7kKajeFt8xmDxWCW8kANYoEBwxKpg4jfkqFtFVMOxI
         P5dklObmU880vw3yNBWjUAcFI9nBsnU6FAnBrL1ArZbIZMpyNGgVnLEbwc+RwLDNR5f0
         OUlQ==
X-Gm-Message-State: AOJu0YygxCIh4cwv/jrfgt9WrDN3rSLdiNjg7I1vCjdT4SRi3mWJfSGy
	dCEWsIyZrFcmuAWziCa1qd1j6O/0Itka25LkDJ5M9FUrYl/3rsuW
X-Google-Smtp-Source: AGHT+IGHf6eI5YrKJnU2uVmBzVLFMNBBY2NZxJ2qqKnNsAmfStOnKjPWLc4TEZeEa3+J5NIhBiWFIA==
X-Received: by 2002:aa7:db56:0:b0:557:e527:f799 with SMTP id n22-20020aa7db56000000b00557e527f799mr1582572edt.4.1706373899626;
        Sat, 27 Jan 2024 08:44:59 -0800 (PST)
Received: from [192.168.0.103] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id fg14-20020a056402548e00b00558a1937dddsm1750567edb.63.2024.01.27.08.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 08:44:59 -0800 (PST)
Message-ID: <6f13d58a-f072-49dc-a9bc-f742550fc9f7@gmail.com>
Date: Sat, 27 Jan 2024 17:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] Staging: rtl8192e: 18 Additional checkpatch
 fixes for rtllib_softmac.c
Content-Language: en-US
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126223106.986093-1-tdavies@darkphysics.net>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/24 23:30, Tree Davies wrote:
> Version 2
> 
> Another checkpatch fix series to be applied after the series titled:
> 'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list,
> on 1/5/2024
> 
> Thank you in advance to all reviewers
> regards,
> Tree


Is working fine on hardware.

Bye Philipp

