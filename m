Return-Path: <linux-kernel+bounces-25095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B182C7E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7F61C21A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350B18EA1;
	Fri, 12 Jan 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVrWkyml"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D418EB0;
	Fri, 12 Jan 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ddf1e88e51so2242510a34.0;
        Fri, 12 Jan 2024 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705101662; x=1705706462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+R6LXJVge0h7fUk/3TQXTr3ZvxpqRoV0hUEB5JHJ4Uc=;
        b=nVrWkymlR3pes2nj9a7JGepHlcRtjGyrqwcWkVCa1aM++B6/pAVE35QHApVBDJOfYW
         vGuhQXX8OHKqqsiFnAm7TLBrEJ+fbpFHMWt59zcxOmv/UIPWKtqFibTx16oCGFobG1b9
         Vim3d+9sJsBQf5WWqbiP5NrC6ko2A+NYVO4k1H6XeInod6hOycXrkNGyjYka8fpc+IV5
         /fxK7P5EJ5KGeD40Q9nU+yzcU5INHVNPVrg2QDEjKLgy/q7mCePbc0UHUWEvL2tL7rWI
         L9WYyFxUye87et47pe/mOQfOfsbNPtkGHT2aq515aEoK43FmwdVQ7pOyqhFz6gNq+h2C
         CMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705101662; x=1705706462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+R6LXJVge0h7fUk/3TQXTr3ZvxpqRoV0hUEB5JHJ4Uc=;
        b=fxHCy8z8vd3t8hjBkCRd8kKc1EEp4pH6LEUqJqMhNJDFjEQITAD+5zFUcrqhg81Ovb
         WzAHDqhsdqxamEUe7hzvp94idiLOnp9mb4lN2rojQRekuV835tK9SRcrc3zkJ8y5a4eG
         QKI18ftXczyOTCS0woiAx7nI4Dxx7MdD57+Uba/q9hwfqvaWAXpHHB2cJumeHvX2F7a1
         aDkvEaEJVuw8Bp6ugZ1irjLi/CCJqb2M/WWPOVAiuSp5NJLCulyeRLvTgDUM4IZCHFin
         emjFhJV87haZnVI5Y5I9Zd+3tMsp6DMRfDb7aRCE0BvJuqZxG2rxm24FOd/RUqsZedrq
         kjTg==
X-Gm-Message-State: AOJu0YyaTwpqNE4xUzPwDXsu96+rDpnfwIai2fDY0jApxRRRSXm2AtsS
	F6QcFnfEq3Jxu7+8b/PnyZ0=
X-Google-Smtp-Source: AGHT+IEtB+JdPKiLzTjmqhuJdJljDqSSDwHNhit5ZFGTVZAmInqthiT+wVFxGeDMoFTs2XwuWxjKXQ==
X-Received: by 2002:a05:6830:1e95:b0:6de:a2be:2b1 with SMTP id n21-20020a0568301e9500b006dea2be02b1mr2373740otr.35.1705101662247;
        Fri, 12 Jan 2024 15:21:02 -0800 (PST)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id fd41-20020a056a002ea900b006d49ed3eff2sm3690967pfb.75.2024.01.12.15.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 15:21:01 -0800 (PST)
Message-ID: <c8e42104-d194-4c8d-800f-c50125973500@gmail.com>
Date: Sat, 13 Jan 2024 08:20:59 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Documentation for 6.8
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <87sf37vegj.fsf@meer.lwn.net>
 <CAHk-=whtqOvx4_GL8MX+bGroS5hfueP+Arch_qVYwQDJVvFCKg@mail.gmail.com>
 <87v87yk3xg.fsf@meer.lwn.net>
 <a445d391-4cc9-4d6d-85ad-02d23aa57ebb@gmail.com>
 <ZaFkKdFyThJNLDcm@casper.infradead.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ZaFkKdFyThJNLDcm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Willy,

On 2024/01/13 1:09, Matthew Wilcox wrote:
> On Sat, Jan 13, 2024 at 12:28:44AM +0900, Akira Yokosawa wrote:
>> Official python 3.10 support was new to Sphinx 4.3.
>> So, I guess reasonable version for recommending is Sphinx>=4.3.
>>
>> But at the same time, The latest Sphinx 7.2.6 works only with
>> python>=3.9.  If your base python3 is 3.8 (e.g. ubuntu 20.04),
>> you can't have the latest one.
> 
> I don't know that I care about Ubuntu 20.04; that's almost 4 years old and
> probably isn't being used by anyone who's building kernel documentation.
> 
> Oracle Linux 9 (2022) ships Python 3.9.14.  It also appears to ship python
> 3.11.2 as an optional install.  It doesn't seem to ship sphinx at all.
> At least not that I can find from a quick rummage in the repositories.
> The recommendation I'm finding is to use pip to install sphinx if you
> need it.
> 

Oracle Linux 9 has the same version as RHEL/CentOS/Alma/Rocky 9
by the package name of python3-sphinx in the ol9_codeready_builder
repo.  You need to enable it by saying:

    dnf --enablerepo=ol9_codeready_builder install python3-sphinx

HTH,

Akira

