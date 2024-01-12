Return-Path: <linux-kernel+bounces-24898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71082C464
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769CE1C22491
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C11AAC3;
	Fri, 12 Jan 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B1zE97HP"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51541AAAD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-360576be804so3927475ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705079493; x=1705684293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0Vttk9vgl2pIMZk4UzP9itUkUCCJPY3X5z+XJAuPbg=;
        b=B1zE97HPQzLGblOmsHguugiebBfCO/69AbpkCODREWsibnawlve1iD+cUEL0GG3D2I
         QV+RCa6LPy9EaAukV80yZ8dZBxC1GSHTGxCKYmAbqT2sf4G30GeGa3TMWUXRLaF6Robc
         4beIHej1J/psD3xwU9JJJ/n9ciURg3xFTWX9VPTrFG0KvRYl7RZg//g+eYDd6EOGsqaL
         d08JlCJDP3hWg7yEzMqXPeavr835esleZwSPRpZ64giYKlL18yCDskFAOv0WHpDdCO4w
         eSPuBVZ1+lSObUExP1SjZ6v5eVvFFXtFsjyNh4IrRc1X0hDn8VC3HUkG2nm2PIbSO2Ex
         MpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705079493; x=1705684293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0Vttk9vgl2pIMZk4UzP9itUkUCCJPY3X5z+XJAuPbg=;
        b=cnfXl2ewbiR7T68MLTSEji27x+s26HSO9/FAweyQNpsVswbWLxDb3Jogh9zr7rEOld
         ZR0L5fHfybalpEaRFoe907WjChZMXcPXsN6JHchxO6iRmCFqNxLgcerw3dj4u6H6q34q
         KxGmACJSXsqoJWIz7ACJDmjUApkI0Q0J233G1oQSZw6r72NBmu+JDNl1sWK0z/RwoDTE
         /BnTK/3zROhCCVQL4kuswKate2ep24EwNVZOxOqncSWRuxajs4TsMzHQLYbTPL3pb8Nq
         BLhBqN6s70VOFywH1UYEiTTtb4Gnm3gQRl1zq7bd1bgbKgVbkYI7upIaa4wT3MEu5ahO
         dP8w==
X-Gm-Message-State: AOJu0YzzRKTUiocIRtBiIZ9e1ruCZr3j/QBe5SMhaU5FiD7QVnSR7Usg
	PkunLXfdCZFU+fXJv8SEezr/YFaQEvjxvg==
X-Google-Smtp-Source: AGHT+IExhFWsKAwiuWBQQgdWYJDuVJ2ab3qaEJpjWi6IK6vFjpLjekkwD3havgCps5qaeYm21SWGTg==
X-Received: by 2002:a6b:c845:0:b0:7bc:2603:575f with SMTP id y66-20020a6bc845000000b007bc2603575fmr3634052iof.0.1705079493696;
        Fri, 12 Jan 2024 09:11:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cq9-20020a056638478900b00469328386c8sm995517jab.162.2024.01.12.09.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 09:11:33 -0800 (PST)
Message-ID: <79f0bbe3-ade9-43a2-8372-dbe8598c2fd8@kernel.dk>
Date: Fri, 12 Jan 2024 10:11:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>,
 Mateusz Grzonka <mateusz.grzonka@intel.com>,
 Jes Sorensen <jes@trained-monkey.org>
References: <20231214222107.2016042-1-song@kernel.org>
 <20231214222107.2016042-2-song@kernel.org>
 <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com>
 <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com>
 <20240112171010.GA18360@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240112171010.GA18360@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 10:10 AM, Christoph Hellwig wrote:
> On Fri, Jan 12, 2024 at 09:08:04AM -0800, Song Liu wrote:
>> Thanks for the heads-up. I honestly don't know about this use case.
>> Where can I find/get more information about it?
> 
> What NAS uses md linear?
> 
> Either way you can always set up a dm-linear table to get at the
> data.

Or just boot an older kernel... Seems like a bit of a contrived use
case to cater to.

-- 
Jens Axboe



