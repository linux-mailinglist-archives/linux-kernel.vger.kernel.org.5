Return-Path: <linux-kernel+bounces-109478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82238881A07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226881F22A53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3738612C;
	Wed, 20 Mar 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWD6at8M"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22871E87E;
	Wed, 20 Mar 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975609; cv=none; b=XTQu0CzlKC+R1+9KJe8773Ds2VHs/y+YPZz+sH3s1Bqbl64OgkomEkmG3uXBIC150klr+iDq+0nODOXUunc/yz6T30QCYFqEkRRE6gJJS7Whan9UbCnGtbWusnz0W6GNcmWALc9C6pB+wTk8l8YtmkpWAlkMa2Gins/n9Xm8w/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975609; c=relaxed/simple;
	bh=XnbPtg+O2IYA+qWONEybl7Qhpn7SsiI2acn8i+RwEFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM2aMOOHDHXR/56qQe5RKbTMWXpI29607LbLsTKZKJVLbc6zQD5ZB8bZkq0OCHrnBnOnTgXK0iDRwCV3P2Zrad9FOYNb/D4P467yBvkhP0K4D6hp8LdfeKOjotj34P9OYQBA4LyaN5m3oEALKbchYc7xJCm7xXuy5D98r4QlMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWD6at8M; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42e323a2e39so3955801cf.1;
        Wed, 20 Mar 2024 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710975607; x=1711580407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6v8eA1cPx7sUw+dmQFSGsW4h/lZzNvuLTYyd3ImSWM=;
        b=EWD6at8MQLH3XdwqupvpEpVqMPlN+ap/F99lrUiJarzYYINJin+KIxgDv+azz6hPx7
         oC3JY5fjePyixStUAHJictFncJEbtof/DnTlr1fg4d3kZsA3wljhczfOLdelbi8eMn3j
         D4gQq/asqecbCNXPrJtWzOwOblhCncXT69e9F3PKb0jfr53Rt63SK86LFZnZoyZNGMdY
         aC0eQhUsBEFRjmse7xKzKg17GJnSlJfxGJ4+Zhi2rJCRH51juWXRjfrtQno76WlfVjir
         vIDNELZ6rjtmwsgVAE+GPGZyuurLIj22Q5aHxJb6/yq4yGLq8MBSZvOH37eJTo6PXXf9
         s+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975607; x=1711580407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6v8eA1cPx7sUw+dmQFSGsW4h/lZzNvuLTYyd3ImSWM=;
        b=Ob0vwVd4a5fK6sz9hfEoVkabnlv/REqrFAgvRpTmjzVyvs+hQgV44Psy5cjjAUrzp3
         XpIba+JatXA5bZYFInvZ0sASRtv1i/3kNTGw7zYZn9I4ZWQ7/jKI/0OoNeooQ892QDZ8
         kOJzquEK6Na46xYQQOw9i3NBG3mY4s90G/RzOObxvsYU4Ek7w10AmO/KdckQqnRM08Ll
         kz/eII9+6wqQf9vFWk1d315Ouv6ooC0QCQECROHHz1LYRFYh16wMxqGSraWwwRWR3q8C
         QySMefrLkHhzitAebD7EdeFuD9ppNd921RYzH+X9wH9FWi4NoUZl4Pj/CTgcXX5y/AID
         6+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD9EuFDRw0ZZ8vaaHmqcLZshg7X9Y2tda6MRgi6MCYtg8C6je79uZEaUC4HiIYKi9/GjYYQtnTSu3E8u90KFyg+AiwiBjkmPAMKnk5
X-Gm-Message-State: AOJu0YyFqMyVJw/qHeorTn/h3STRpXWYQBDdKZqgrtCVEGVltfzBFpqW
	QMdEwNTSjQwZnkJTAqRzSxbTSJiXhuy28g34rBHmnKvSafnzUdZ5
X-Google-Smtp-Source: AGHT+IFzdVkgFVucq+ZP1v8OpUIXwkxjGJR9OB5Tn+7GHhqMBG8/1E9dagmdQZXN7zOjwbPCjYaFAQ==
X-Received: by 2002:ac8:7e89:0:b0:431:1d8d:9229 with SMTP id w9-20020ac87e89000000b004311d8d9229mr1897432qtj.24.1710975605218;
        Wed, 20 Mar 2024 16:00:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d4-20020ac85344000000b00430ac082732sm7169592qto.70.2024.03.20.16.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 16:00:03 -0700 (PDT)
Message-ID: <6059f7e5-fd2c-493f-a1dd-acfc7e9e7701@gmail.com>
Date: Wed, 20 Mar 2024 15:59:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when PHY
 does not
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
 <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <22089299-a3e2-4cbd-942a-65ea070657b8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/24 15:53, Andrew Lunn wrote:
>> +	if (netdev->phydev) {
>> +		ret = phy_ethtool_set_wol(netdev->phydev, wol);
>> +		if (ret != -EOPNOTSUPP && ret != 0)
>> +			return ret;
> 
> I'm not sure this condition is correct.
> 
> If there is an error, and the error is not EOPNOTSUPP, you want to
> report that error. However, if the PHY can support the WoL
> configuration, it will return 0, and this function should exit, WoL in
> the MAC is not needed. And doing WoL in the PHY consumes less power
> since you can suspend the MAC.
> 
> So i think it should simply be:
> 
>> +		if (ret != -EOPNOTSUPP)
>> +			return ret;

Agreed, that's what I did for bcmgenet_wol.c.
-- 
Florian


