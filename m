Return-Path: <linux-kernel+bounces-89938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A686F7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756FBB209EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576D77AE67;
	Sun,  3 Mar 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SA7CO97z"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED27A733;
	Sun,  3 Mar 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709507008; cv=none; b=CyxQI+w6yvjtaJyEL6240vQAtrlJE9UsBse9YZ1LQBLrAWR6Jn6+wGPCjkeawYUjCLO4ksKnT8RDbvfSFr41BXDuGf67b0g9DsDHBNTD0ko65+lxgzRhDYebu1COo9sBqwSRk2DQGua3m2gTQfxSbkrlg3JNmKzNo7fnP+wMkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709507008; c=relaxed/simple;
	bh=0BI8/jUO4JBJJdK5HKsSkLJoIirDi5UQ7bwc9IyKrdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnDuUE166CTF96otufBhbp13eTBYxrfugXF07ohoQvD2IUm9MrQVWQEpd2BTtc3DxnSt2yEgmmp7O5DWbMQWzZWQrJRDj3Htu/XZ5T2GWkJqGcMQgeV2tG56RSO92xb9MhyK4OkcsAZR6RsF4wTTKVCG4P/6ts216/PQLY9pqPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SA7CO97z; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365145ef32fso11470595ab.1;
        Sun, 03 Mar 2024 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709507006; x=1710111806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61++O39w51YEMfF9lMeZIqSFW4ZB2qp88F85r1cwXdE=;
        b=SA7CO97z7mchDiO1dSlEmeSvHdatQiwDxz6uJv2VlS4Ab4eY7QiDwFtrMY963OWFzf
         HkYWXkDyefbHreG+BnAE95ZZ/2FJsGETDEY0Xu3n7F6dOxzYvdSgq/ZM53ehpbn691qC
         mvOvhZKOPDap9L40UzxMlj65XBaYNRN/Pl4yhYZwty0uJ3c2mRJseavjFxVxDRMVFGYW
         dB5JfwMbIzL37y2v5Ni9tsuXWeQyD+igHQpG3gMPZtbdcrahEoo+x+eN4YaFKcDnfgiH
         tI/sEVI5mTF8ZfORsuZ6HFLYZn4jUEB/NiAiRNT+jNmZRTkEs0HflwLKon1A7vLx1QJf
         roPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709507006; x=1710111806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61++O39w51YEMfF9lMeZIqSFW4ZB2qp88F85r1cwXdE=;
        b=ReESomt5CrcK/45AzcVUd9kbdRSXonYT/kkVsSSNe+i6oJEgS/v/Tt5ri7NeXgp+LR
         2pR/jSNbKe0Xinu/ZM3a2x5Ho//GUykICL2ISaSxkZxjo5ZeJSLENHg2EgvVHxa4XoNG
         zGVZAfWYoQ4r0S9wPTB+1vIa4Q2iRsq0Lvlms1b+ci8UHKClPS4/CDAOOTVADNpAEg1f
         N2KVR9ln5bpd7tz0ErLEkSHMUxf5OhrrufstBzXUcxOvASbmfJEf9Glb5610VwJGILTZ
         WhRPlACy4nSqv0gyFc+qumRapk9+sHd/zPFDPjqchg0he+N3qd3Sxl3oGQLcHrRlnYkz
         6tkw==
X-Forwarded-Encrypted: i=1; AJvYcCWxkdgDEpAV9nEGzXMRIFVddtzYA7ImLDP0bej1oOk7vBdKhfkZ++CpTXHCziRhiVL2E/77/M+kFTQIKFdFwMNU+OtPsKiovq6LGvpYegOEjr64WdKPnyohl37pv6CayHvVmAE0xdTFoEw=
X-Gm-Message-State: AOJu0YxzYWhilzJVLuXgu21WJydUrNulviwarX2EHsLWcSO9fIGCzyec
	dg6PgfzJ4MkXv3j+sdbYLBD9P4JzBVtwxx32vrLoWN4w4bEru7Le
X-Google-Smtp-Source: AGHT+IEogfpCYQeeIL8DmPcXUVVqH0oUCfdsUywZPcXVsX8xqU3u8IKjHEwQczLESBify2jE0KOSdQ==
X-Received: by 2002:a05:6e02:1a8f:b0:365:aaca:d166 with SMTP id k15-20020a056e021a8f00b00365aacad166mr9043005ilv.28.1709507006309;
        Sun, 03 Mar 2024 15:03:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id g1-20020a633741000000b005e47afd5c5dsm6376157pgn.37.2024.03.03.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 15:03:25 -0800 (PST)
Date: Sun, 3 Mar 2024 15:03:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: michal.simek@amd.com, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] Input: Fix kernel-doc for xps2_of_probe function
Message-ID: <ZeUBu2yWg2u3WgwR@google.com>
References: <20240301092115.123092-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301092115.123092-1-yang.lee@linux.alibaba.com>

On Fri, Mar 01, 2024 at 05:21:15PM +0800, Yang Li wrote:
> The existing comment block above the xps2_of_probe function
> does not conform to the kernel-doc standard. This patch fixes the
> documentation to match the expected kernel-doc format, which includes
> a structured documentation header with param and return value.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied, thank you.

-- 
Dmitry

