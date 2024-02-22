Return-Path: <linux-kernel+bounces-75740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7C85EE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AEC1F23E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1310A23;
	Thu, 22 Feb 2024 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1WFKZv0p"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3D12B80
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562586; cv=none; b=DtjxOg2girA058awE9wLKYigjQO0aWWFyWd8WNAq2E08MsakiqFpLVU8aoxqF78xNyquFGLjSmJaUTh1dxm4OcS8MSNvgJF36yBD0WXpuy+TFTBfLZF3H4PeBW8pJQ2f79TPi/5u9rlBGbHsMrPYKKlcNLuifsExjFVwQRzmdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562586; c=relaxed/simple;
	bh=70s578QhfI8VfYwqTA58Ok69jNRS8MFE5JRxsyKVwPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLEkc9qV0BzSrjanzZGp9xVYwF4HSJxWckfEz//r2S8LFbXDIADZsGJH0xg772I3n+ZFYitjESKreUeEa2clg1XyNPqynr2Kdbov1O+NSAzGeBOOatYu6ow0Si1IYoD+im31nCrPvKgVbixuTytgJjOXRjZOaSUBA0DzKPpLYEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1WFKZv0p; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2909978624eso4421625a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708562584; x=1709167384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR24aAbNKMU+aX5oJp3mmjRiDv2V+IvxS0ZLhqmyJiA=;
        b=1WFKZv0pAJBZfWvLdsKJB6k92Da4ZkbHRhMmH6TNJ3nFMgzqUzSvKPNmtWBdrWlO4y
         TltR+v3HZ8wcnoCcHckct0296eRkpvkrEFZw8XbUmMbnT/qvwkonqAh3LvWQ5Q3+8o4l
         sslqqSQTeiaxJxmXlhUWfgMdsgsy443CCK8sin/7EZNx7tjlGzz2Nv2Sy+5HIXN3yuC7
         ULVMK0KOb+TABB8I+oCuzeteXl9fDgWXwPw//jwgewZLEkC4/12DQfN7sfFILPAnfwZd
         eXeaXULuroei2yw5d0tPIHywO+liURlP0wX5GaT7ERWe3ZD+2Fto0itXynUtSWargjyB
         dFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562584; x=1709167384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR24aAbNKMU+aX5oJp3mmjRiDv2V+IvxS0ZLhqmyJiA=;
        b=pA3jEbSnmqR27QjRX5n8TBoFZHFHcNCoqS3cyAMnnzTwg1mMAJawGT97+LHMrEwyut
         tGP8drDTaRhSMCIC/5huK1465nusSMEPNYFxgJrzyFx9ec8XVmpZTLnJzsYbg4aZjcnd
         5R5TUeuKJ8iugUHYjt1xK0kU2GG6rhKYmaz0WXTYmqDfQNSrzTX/rNDIg0eNxspnxlCG
         xTw3ud4kpchfL3mWFszvu3UdxzB2DCdXyXXidK/FbnNFC+qa5zIbyLoUe+U+T3W7Teye
         JDzWZzgKzlK0tLMXfVVae5X7u5m/EfCt/2bh+tjh7MVS//HPcqep7fq085lMR19FZcnn
         3G8A==
X-Forwarded-Encrypted: i=1; AJvYcCXx3T9U9Brq6QvSwkFEg5V8Su/bz8Ve9xgwE9iGkthEb+i8oKlWOPPfLnpH8KoLPU2O4Gr8EEPXcs9A0Hmbeo7V/Jp6qax85VRa17Pt
X-Gm-Message-State: AOJu0YyGiNCuvokeV99z1ex2ogjaDbxdLRIyJuWJeaqKDb8zK2cf6e1F
	vBFwMv/nbUYdGKTXeLz/Xdx2S+CsIo8FcP6S9riYiL8cnh1nWSTvFKvkZuloXpc=
X-Google-Smtp-Source: AGHT+IED8Qc8cv5em+hY8R0laXHeLyNpZm08160QFNjQ7Gn8Te5H8kX7oc01tG3ELGqs1k3ZjWLKiQ==
X-Received: by 2002:a17:90b:606:b0:299:99f4:5911 with SMTP id gb6-20020a17090b060600b0029999f45911mr9465260pjb.29.1708562584637;
        Wed, 21 Feb 2024 16:43:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bx12-20020a17090af48c00b0029a4089fbf0sm390177pjb.16.2024.02.21.16.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:43:04 -0800 (PST)
Date: Wed, 21 Feb 2024 16:42:59 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 18/28] prctl: arch-agnostic prtcl for indirect
 branch tracking
Message-ID: <ZdaYk8XERnOtiR3P@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-19-debug@rivosinc.com>
 <ZcJas4tZNzOJv6hW@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcJas4tZNzOJv6hW@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 04:13:39PM +0000, Mark Brown wrote:
>On Wed, Jan 24, 2024 at 10:21:43PM -0800, debug@rivosinc.com wrote:
>
>> To allow userspace to enable this feature for itself, following prtcls are
>> defined:
>>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect branch
>>    tracking.
>>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch tracking
>>    Following status options are allowed
>>            - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>>              thread.
>>            - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>>              thread.
>>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>>    tracking for user thread.
>
>FWIW the arm64 BTI feature is enabled per page of executable memory
>rather than in CPU state so it'd be hard for us to adopt this interface.
>I don't think that's a blocker, just noting it.

Got it, makes sense.



