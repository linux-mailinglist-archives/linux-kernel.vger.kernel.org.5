Return-Path: <linux-kernel+bounces-102263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED387AFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936951F2478C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB08288A;
	Wed, 13 Mar 2024 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih/RA9K2"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C69823D0;
	Wed, 13 Mar 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350773; cv=none; b=JKiclYvZz1YAvmyLFiI99I00XL1kFol8T6RuuILJtwpRUks9CPuPlE4AWDWnVEm4+/PHbnE82vF1nej6hyLSE9EC89A64Hg4oFaue+NY36vA9Nn+wLuyxTyTKAg3+VbMJNuhWjEDLgqTS5bM/n2LM9XRWkSiV/GlE0zJFQKCw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350773; c=relaxed/simple;
	bh=pHdBbxIGCsn6bga9ZUWJIdqQzQ/NGDwpmOuAP2belZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibx26gv1Mj/Xtquvv7wHvPBXz5wvd8YFw3V3kOrcyUFWvUaSNViukZ8tVe4T48raWir0bxeJI+57M6veZCmYC5WBpO2canfvevzHGlXwyTkRNg2Uux0DyZ9aPux8ChVDUYdyBYrm0CPLH+DF+TszTr2cXpYBCdJeUHHZ6pf3Yao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih/RA9K2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-788598094c4so5260685a.0;
        Wed, 13 Mar 2024 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710350770; x=1710955570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xlPdDv6yvSDgUYLn/3ttkYWsR7atQ5kgTqz8H924Zg=;
        b=ih/RA9K2TpucD0A8pA6vOGj9e4ua/89FjLztujfp+MObcS6sHjzdTD4V2y03sGUViV
         i4NtKtEWQgFU+D30OVanaxcXUpLvUPifvTOeVh+Orw42h7O8mM31avL9dM0GiaTpYNX8
         j6fu5qDupiMnOJP28RpUUMPWfqEhC1Y5d8JGruSWx+U7DFnGucoT1lVXgTHisueicQpG
         5yZho8mUottLpWQiG2uPItRPouijwVyOo7WWfKIB50c9vNPwryJm6sRnleih+begoJq4
         CN4cZUsrdtiBfjuBvovONrkGFEyt8/d65g4ztbabkbAC767KOT0Kwhsj+urEWCOAEcOB
         1Sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710350770; x=1710955570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xlPdDv6yvSDgUYLn/3ttkYWsR7atQ5kgTqz8H924Zg=;
        b=l2sPbEtEXDR/ZzjWkb4lZirt95S6+HtbpsJ4YH2qAw2C+5XVYDeM23nfdzdbkGNf1O
         ebxbUwDalEW5FHvXVPixRPvFmG1lsNalGRRcktKen4Tc+Ib4FXc9qaZX6yj+NwfwmOnk
         zil3GodIdC2dsbl3FT6nGQ4DXqgnSFvMVtMyY+4EUgX8q9DBvTmCyixtZCBXTYii2ACS
         P+7T/tBCCuJsUvv5/0QUj0mWPltMuPKCHyDmXVuO2q6Rds4hbpVeGLh3ahT++9sX+QI9
         MqdibHSqvWO4YyEtC5oajnGo4HevHaVSmEVr5PWy7of0rsiOb2WBWjiPAiRCs8ZXn6oy
         GCcA==
X-Forwarded-Encrypted: i=1; AJvYcCVtE4uApdPj7Yyod1FQX0vhaaX+0aFzdWcm+ca9H4ZwFQNbsgSp2wfuphEHVxMVbypgBMWrPaEHoGxk49Z0lkIifwgz+YM3YKvnxJy7pwtIDGXvIIQ7lrXto5IewspRLWDfHjKOJQPH8pm1ekpO8rqkgn3NfiGGtRmc1w7f4e0wXGNRD60uI96Oi24qW6u28MtI96UYlMz6WEbwC3QoewzYLluFlVOoVHhM++Xrseyhe+CiLXJz2ZMXOytL6MWazRZRsv0bb3kQiJ55nyDF1iutQAKjnVOQMkmtbLM=
X-Gm-Message-State: AOJu0YzfUlNScLe8t9U5ISTys6i3l55qhlJv3bIerPSkcROfz9rucFPA
	+eJbwsv2qztSddrDgz26fl6eR0lQE8tIYXea7Uo417XUHo2C6rV9
X-Google-Smtp-Source: AGHT+IFyyiGiWin6XQHjnKeLqB0dBkLVo4kmfRKf8luDrrfr/cY3NN2DX7JZ46wiVXxtXIKQSkqJLg==
X-Received: by 2002:a05:620a:178e:b0:787:a83a:cfed with SMTP id ay14-20020a05620a178e00b00787a83acfedmr607731qkb.70.1710350770507;
        Wed, 13 Mar 2024 10:26:10 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id yf23-20020a05620a3bd700b007884b14b0b4sm4888800qkn.51.2024.03.13.10.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 10:26:10 -0700 (PDT)
Message-ID: <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
Date: Wed, 13 Mar 2024 10:26:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
To: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>, dimitri.ledkov@canonical.com
Cc: alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, iwd@lists.linux.dev
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 1:56 AM, Johannes Berg wrote:
> Not sure why you're CC'ing the world, but I guess adding a few more
> doesn't hurt ...
>
> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>   and I use iwd
> This is your problem, the wireless stack in the kernel doesn't use any
> kernel crypto code for 802.1X.

Yes, the wireless stack has zero bearing on the issue. I think that's 
what you meant by "problem".

IWD has used the kernel crypto API forever which was abruptly broken, 
that is the problem.

The original commit says it was to remove support for sha1 signed kernel 
modules, but it did more than that and broke the keyctl API.

>
> I suppose iwd wants to use the kernel infrastructure but has no
> fallbacks to other implementations.
> johannes
>

