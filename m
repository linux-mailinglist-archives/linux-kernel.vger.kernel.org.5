Return-Path: <linux-kernel+bounces-88491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB8186E253
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217DF1C22990
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260C66EB60;
	Fri,  1 Mar 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1PEcL76"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250B4086B;
	Fri,  1 Mar 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300227; cv=none; b=EdLsED8YB5SBOUt1MKHKhwZgwXrhjufcVhYrEql70K/1crWJM1LxtI/3DeUDuEUQUNUlTuP5QUorCaqPzrIJCnS4y1stNQVlsTmuE3EwEKr4yLhBmhOopAZdkvIGcjxy7LbUUfkB+Jfq+p3YDHLQNLYSv/qSRkgN9IlURbH9V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300227; c=relaxed/simple;
	bh=BD5t+SGYCOkw0plPMwDOQ7kt+s0BaaClnOZQvqVXnUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI3LjpWJwlwTa0WpxgggUQ6yoAJKzS2thJHA8XM6p/kc0LBdkYYS7UGAcPHmpMuqevODqYTocIga14Nrq7YDMAuHn0bzqCaeBCKFNYCnVEXIIW5+Z0seAnPbtHK9GG6aNAgpH5VxeZAqhmwwxENhQH+zYI7Oxf9oIIMrRRq0XWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1PEcL76; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so24366281fa.3;
        Fri, 01 Mar 2024 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709300224; x=1709905024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYsIdn7slyGMRDx06FHVOcl6wKc/Fc3obP8a4mN3HAc=;
        b=A1PEcL76j9W4I3O2nLdHJaUNb4b9ezkTZcSSyxxGht5UYwrlVq0xTpx3tXKZjhvokq
         5QqgS0V1P2uAjowo3Im3/cg5vnZQZOZRFgisBhaV8mF3rwNNQ8C9SzZpFvqezhb/g3jY
         YvVgUqsorctQE02ES/z2UaLo0+zl+nuCLwjVJlDSIf6k25rmnNkXtQ6bRq8qQ+su6ah0
         FSBSP5m61x9XJfkSfJk1y9BeULUB0rVCzHvD7y4OsVWTGYA+30yjWZag8iGny6QGanDv
         T3/wZeWcrbK+e6z8sxwC9wS3SWIDq9bt0NyOOWXjlJHDmrZi2MKLKzXUknyptejC4vUc
         BeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300224; x=1709905024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYsIdn7slyGMRDx06FHVOcl6wKc/Fc3obP8a4mN3HAc=;
        b=ULrqtGP1d8575paNle/0ykYoIWLIaRGcc0H5Q3fFKjODE/KBybacOysJtOZ1TVyQTj
         7lXwbjBtUrHIt7aKlKAysePxEbVZrJxyiyRRqDiJk5EpsG7NoQqzP8xfFk6V+6xWTeoQ
         6uFR9vlsYoaopZOCxnP8+B7vEO5NGVdLvh6LaMRkIso2A8BD4GCaW1phAACCCV1+xH+o
         D9GW2HBlG4DX113Sz2xM5oTE3xywiKPrA9KctnwWcq2Rj8oXnMDQXfEJTeVq8AU6ZX9k
         kWy029kyBJzaJ2Iy2dwaS4II5UHkUZSay6Ce/7Sp4CrT6PMnZc2aVp7zQOeia2h1/4HN
         xmqw==
X-Forwarded-Encrypted: i=1; AJvYcCWE0gs02pDtqBEV2quawihvyEdD778OPywnbv9A0L6S607XajhgAP83BYWtgAoy3vbwWOTDlodzRawQZoPM9fAWqiz9xiV31k2LPEfEJEg0iAjxBsQs8KXrmfv68gR5yFh/ykHzVslfNAgPZGE8IvX13yctLWusKj9pqsDHWtNy1RLsxzNxug==
X-Gm-Message-State: AOJu0YyIIe+K/uQbezyTMTwim/aa19IpP0M4LlZBVnaMM+eQsMxCEqK6
	YOdpe3wzdgurmp3WDUyC4ryI9wIDgismI4TsIiqQBzTFEiYMR25F
X-Google-Smtp-Source: AGHT+IGUua/IpBGrUHpqPiS6tgGusCvvqcS0npwzCB0lIe8UuNXMyDq5nK1uJo2d0pe3K3btRMw1cg==
X-Received: by 2002:a05:6512:3a85:b0:513:360d:fe7b with SMTP id q5-20020a0565123a8500b00513360dfe7bmr413678lfu.51.1709300223616;
        Fri, 01 Mar 2024 05:37:03 -0800 (PST)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b00412b643b5a3sm5474992wms.11.2024.03.01.05.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:37:02 -0800 (PST)
Message-ID: <91b36da5-637d-4156-8be4-5aed55fc3c5d@gmail.com>
Date: Fri, 1 Mar 2024 14:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency
 table arrays
Content-Language: hu
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Devi Priya <quic_devipriy@quicinc.com>, Anusha Rao
 <quic_anusha@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Georgi Djakov <gdjakov@mm-sol.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
 <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
 <ZeGic5cG8lneKJXp@hovoldconsulting.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <ZeGic5cG8lneKJXp@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Johan,

2024. 03. 01. 10:40 keltezéssel, Johan Hovold írta:
> On Thu, Feb 29, 2024 at 07:07:46PM +0100, Gabor Juhos wrote:
>> The frequency table arrays are supposed to be terminated with an
>> empty element. Add such entry to the end of the arrays where it
>> is missing in order to avoid possible out-of-bound access when
>> the table is traversed by functions like qcom_find_freq() or
>> qcom_find_freq_floor().
>>
>> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> 
> Good find!
> 
> Looks like these should be backported to the stable kernels as well so
> someone should add:
> 
> Cc: stable@vger.kernel.org
> 
> to all patches except possibly the sc8280xp one (that camera clock
> controller was added in 6.8-rc1 so that patch does not need it in case
> you can these fixes in before 6.8 is released).

You are right maybe, although I did not find strong enough reasons for adding
the stable tags.

Only the changes of the gcc-ipq5018 driver has been tested on real hardware the
others are not. So those does not fit into the "It must be obviously correct and
tested." rule.

Since the support for the IPQ5018 platform is quite incomplete as several
drivers are missing even in 6.8-rc6, it is quite unlikely that anyone uses a
stable kernel for something serious on such boards. Hence backporting the
gcc-ipq5018 changes would not help too much in itself.

Regards,
Gabor

