Return-Path: <linux-kernel+bounces-107448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB6387FCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106451F2329B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F77E591;
	Tue, 19 Mar 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lzRhyvXH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B954BF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846936; cv=none; b=KsnrdCOxDpotaoB4phAqXi8YI1nVEZKlhYyfzacitegVFqsX2Vf35qzyJFlCZSmHRGPffPKcD8FbHS5SJyAcW/IFBUjUIx5VzuqPiXwOPs6UIdu6UnqE7Z0Mzc47p4mV8NFds5t9pL6O5lwTcGVgRlcmpxyXBQRBlyleDI1D2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846936; c=relaxed/simple;
	bh=FJPOHR0KwUVEvMMGpuRrL6GtQVyAcw4uqZNGWeVKDHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg4hDhBJCYy86ToRJscQ6hWnPT3eUSldg9XcQmb0msJYQZ4broIoDxgLho9qjUQXZbzX85s+2nZY/kWvBc8bZhQL5OSn0zbCPTsOrUKN7XUXbUHkpupm8x4r+Q2MHRbvuKSAQrKDBh4ahQW0CWVOBKKkBR3Eu91UmXVdr57IDtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lzRhyvXH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso1615074f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710846932; x=1711451732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFEfZ7jjfFsWdtg4BLep0osLTyzfrZ3asbccm0VYPZU=;
        b=lzRhyvXHZ9KSkVQBkWurw/9chVkp0LmFw7USdZLy+d3R1Q5ZSiprBsyJf/86/1RaVY
         REy6nrGTDCCFzEruQ5n2oc6XIFUGiU9oehhLOtxo4R58DY5Y/6rooLrBZerNzoiVHz2p
         RD5RL0YlVcIemQAVG2McJqw69B206SNwOhamp4aoiwZ2GbIqgPYaA9V/1VOH7eRMdRQ5
         ou45iKfSUlaEcQQfdCPzIJz9aqqc9namXqTaFq5HPKJq+cOv/xKvLydn3A2CCTD/bV61
         wLJXuRuFVbvDgjQ21N2VYOSM2x4G4BOyyPzWkPI0DEFOF334auF7EmRnkb6yFd1++l+V
         SaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846932; x=1711451732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFEfZ7jjfFsWdtg4BLep0osLTyzfrZ3asbccm0VYPZU=;
        b=Esa3UQM5f9VXdeG03K0RPgslVBFAUi8qOe+RVRQ1jREs21fIFy0mTcz7D9SbxOMhGe
         ZcQwL0feC+EHmPk6Q1h/5OH/clc11o8zj22eYFcIqwNA85TeSCR4gVQSArB6Sv1PnBbF
         NTX1O0F3Kgu8pnPmolCePLAKOzUVb5rUeUQDoL0aZLPGoLoPmz+I7f+7tTjK2FpWQQvW
         uWDA76S7nCksIkPEYsib6Gy1eJQmavkd1641FFt9xCmFsFY7R4DxAUvV3oymAR7NtLd5
         5U9K/F1WHfhL2x4BgY8/WzywfO+QNf1Q2/f7CMcb8/n/RhrSbTy6byJAZj29VcOiVkic
         Wqeg==
X-Forwarded-Encrypted: i=1; AJvYcCVxEZanJ7cSCvvMwtSOkG3ATskn8Tvc/ToJ5ajVPF54fJeZXsZbzMPnCbIHgSL7A+NwFJMkLsFDWm1RlCgt5y+/hL9hQH/BE8aC3Mxa
X-Gm-Message-State: AOJu0Yzca1BKDwI7D2V9pWrwnJJFXXy8cn469ywXeRuUn9/VsmINtWOb
	3F/3DIWOY4m/h4ex8VAFCeRVnUOnpuYlOHLTRRCIxxs7cIe4lbMi7EdP0Su5Ihs=
X-Google-Smtp-Source: AGHT+IH2GsvCdlUEymf0Hauy207l3a7XxGQroWiRZrLvAn4lxr2fL68ujr6LW6JZjTGxHBTib9Xw1w==
X-Received: by 2002:a5d:4e02:0:b0:33e:ca35:9fe8 with SMTP id p2-20020a5d4e02000000b0033eca359fe8mr8744900wrt.19.1710846931802;
        Tue, 19 Mar 2024 04:15:31 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033dedd63382sm12040550wrx.101.2024.03.19.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:15:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:15:28 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <Zflz0PK6mgQm1ZgO@nanopsycho>
References: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
 <ZfloWPxw_iFJvLDs@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfloWPxw_iFJvLDs@nanopsycho>

Tue, Mar 19, 2024 at 11:26:32AM CET, jiri@resnulli.us wrote:
>Mon, Mar 18, 2024 at 06:32:08PM CET, lnimi@hotmail.com wrote:
>>From: Min Li <min.li.xe@renesas.com>
>>
>>The main porpose of this series is [PATCH 1/5], which is to support read/write
>>to the whole 32-bit address space. Other changes are increamental since
>>[PATCH 1/5].
>
>net-next is closed, send again next week.

Ah, different tree. Sorry.

>
>> 
>>
>>Min Li (5):
>>  ptp: clockmatrix: support 32-bit address space
>>  ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
>>  ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
>>  ptp: clockmatrix: Fix caps.max_adj to reflect
>>    DPLL_MAX_FREQ_OFFSET[MAX_FFO]
>>  ptp: clockmatrix: move register and firmware related definition to
>>    idt8a340_reg.h
>>
>> drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
>> drivers/ptp/ptp_clockmatrix.h    |  66 +--
>> include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------
>> 3 files changed, 482 insertions(+), 368 deletions(-)
>>
>>-- 
>>2.39.2
>>
>>

