Return-Path: <linux-kernel+bounces-147825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AA8A7A27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65F61F2190A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BE4428;
	Wed, 17 Apr 2024 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Z+TIYxBY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFA184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317367; cv=none; b=OpqBt3V0pDkcWzq1ziMZ1ewyWBZuhHxMUds/pkGmRfA2xyN6gPy9AIVPhdRAN53v8VhfVwFexvAkpviLvGlvAietdWFfPYrzjnPwFMLWDEntehQ4zE+6Q75TafzPIlQsrCqc/06yfRpkYN0trQeoNR5ajJOk7BQnozXP+Abg7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317367; c=relaxed/simple;
	bh=wNqJWqG29URSyGNTwa0pT4T70tImo8bOF9bPqSnaF+o=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=r/QbUpIMXBuPj+P3EZvioPnMFe8821RHlODnztm+qRM2P9aB0v1WLsI/t+p8fSPFNvtqU0kz135juWYYX3UwBNO2dvZTu+951iteCgLmZbi/be0Qvrvi6/h41MseLcc4znm/xO0Spm7U2/lgbHXta7nKsg83ZGNDNBtOdESJ1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Z+TIYxBY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed112c64beso4109563b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713317364; x=1713922164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjuhst609j4ImBXLka66K2BgKWqdoWcRbFtt/DCN7yM=;
        b=Z+TIYxBYusij/cfDbRpJL7xNdnyQ8sPxF/rULvQ0EJcDiKy62OLFrfr7cZq7tMpAsj
         nVkKWfFH2Eb1y+KwOw54727COPyPjhYROhC4LQ5bofgNkyKYUOEGJOEbhhrLoFNzaRKj
         vPW9q3+SWP1pOJlzHls8FVmG7ScSwMm+F7Fwjm9uTYCBZksFIHIDq+QIUYPHSuMMwHTB
         Uir8Rtpcp4WQNASownRFN+RnPX0l61rKn3Z06wgSezoPNn7P4sIOvwFDgRWZ4KZrAELO
         OtTZiO1mzsSg+NZz1s7Iybgi06ThEG95g4O1C6OebBm1pO1fREm89HzVKDqjZK9KX8iS
         zDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713317364; x=1713922164;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjuhst609j4ImBXLka66K2BgKWqdoWcRbFtt/DCN7yM=;
        b=UaLHurs4nSraCXvGE0X5ek0RFJqq8UO07NKvSD7EIdckVDzN7qYAh00onISFHTVD6o
         jkETTnoAvd+jAS/3U7F3LI8QecIgVOwkNkHEpw/VEzyNO2UDXlhsBGjay29qHXnozH/Y
         7tdwrn92CUCYyLeJLN/VBVLgDXeVwYdv9BaWVQ4jCnEF4wt3cvVxmZM2Sn3vI5cwbkml
         Vv5q5j9Z72Vzfuwr41NYRFbAXy4r1xYIYx+AVM9uRRnnwExwSLBRNpiGzHvezV6MhnkE
         uAFRMX2Bb6dHNVV3YJ57cdpBNAeWM0G7FSvT03oC+DlBv0RayGSdeiUIhABBzyIG+T1T
         ZMSg==
X-Forwarded-Encrypted: i=1; AJvYcCXeh+T0FtNm91FqD3Jn3ynWz5xnMCi5SqtkxhBXLlOLmXBHrsBl/eXIFbRTE6LVAsw+D5WF6j7pO69IN8Fsrj6OXTGAcLZ2XGp0kZMD
X-Gm-Message-State: AOJu0Ywi6Uv0FTCZqNoCICfJXL3OyEn2IFdB64rzLIUcDUSxyOvbxD/7
	cFq8NLKMwkgpZHb0gS/5jsO8cc3MzWwNpPZa7IOLKTt8AmvmfG2vK4kyFVhPamE=
X-Google-Smtp-Source: AGHT+IHI+wCzl78CeqvUChLxQhdF2cffkJLj8Y9hhcpgjt77nMQDWk74rPpAZoZWqdPfe8nd7iHbXw==
X-Received: by 2002:a05:6a20:b923:b0:1a7:57d9:9358 with SMTP id fe35-20020a056a20b92300b001a757d99358mr11408064pzb.16.1713317363589;
        Tue, 16 Apr 2024 18:29:23 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001e2a408df30sm10342463plg.273.2024.04.16.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 18:29:22 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:29:22 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2024 18:29:10 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] riscv: Remove superfluous smp_mb()
In-Reply-To: <20240304-aptly-surely-ab9ea7d82337@spud>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Andrea Parri <andrea@rivosinc.com>, samuel.holland@sifive.com,
  anup@brainfault.org, rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
  parri.andrea@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-493ab98f-27df-4576-ab29-90254bee34d0@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 11:25:33 PST (-0800), Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 01:10:55PM +0100, Alexandre Ghiti wrote:
>> This memory barrier is not needed and not documented so simply remove
>> it.
>
> This looks like it should be patch 2 in the series, not patch 1, as it
> is cleanup rather than a fix that needs backporting.

IIUC neither is actually a fix, as the other is only exposed by the 
IOMMU driver and that's not upstream yet.  So I'm just going to pick 
these up on for-next.

>
>> 
>> Suggested-by: Andrea Parri <andrea@rivosinc.com>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
>> ---
>>  arch/riscv/kernel/patch.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index 37e87fdcf6a0..0b5c16dfe3f4 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
>>  	} else {
>>  		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
>>  			cpu_relax();
>> -		smp_mb();
>>  	}
>>  
>>  	return ret;
>> -- 
>> 2.39.2
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

