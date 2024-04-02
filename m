Return-Path: <linux-kernel+bounces-127840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76685895195
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117BC1F26D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22E6217D;
	Tue,  2 Apr 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qLoRjEh9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE7604BB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056623; cv=none; b=DHd9ZXlG+shDwiOqueGXCXlpf6Er36Qu+TwuZImkE/3zyvz5AdscPIRSC9blyxQF/belVBV3CwTN2KXQuT5eGTmxFdJLZkyz8vv6SQNpRb4vtgLTsuZhNxxgcMAUIZvKRFwuwr0XhXgATAseYj3Onpin97l8Hu3aHHP8zJSLB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056623; c=relaxed/simple;
	bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZMCB+BkbkYvKOG8/ezWUGW9Sepw0TjVEomI0bjJN4f/dE0xwChLkRDHq+rdVRIYkb5+FrCr+Mx+W/3r5k2nfAAvr+OzZRAi3tYpBeP4imoV+SNYQAsbmSGysCd1hbbLgtDTlQ6+hdFGYpdRzZAo0Mm8gqyxgXRP+tutwP3cfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qLoRjEh9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so69255061fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712056619; x=1712661419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
        b=qLoRjEh9GcHcEMjbQILykXRUOgSsvvhbXxnGkfMzP8t7n+y+qw8bt2vKlZFzGOnSF/
         vRz3KUHW992RfKu4v8YDRDsA9J/4biPdlWOseia151Vq8RQdXetgi1sHiPTmhvhq8QWv
         W5/nLEx+S6BQadjfHZxOag/a/I34ToGVSl0ElDOpFT3niq/xouShA6I/yQozFviWf9gH
         V3jkGbFV9dvUfGOuNrXlHoTdSVk4DgR46dEiDFvA36BpsO9TiUw8lJAnQa6Z3M4BXaha
         /mTSn6t6pPiUYiTqkHkUHvgRAJtoWMiAweHodBjM+dHQaibvsAldG+VSpDtL6r8y2Fik
         ZLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056619; x=1712661419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgLSSKVSmZ+TJd00RE4I+uJLkb4KSan/Eetpt3+KJXY=;
        b=qKny9vCDCvp3PhSJ6JRNgMNwKvS7ojQ7qVdSgAG4p1bFU4zAeeO32TY+hCuVUvvbG8
         /4eg0vIf9or0nZEY7NqGOPRfhcLVA8ezrKu4covAy78qc+tgX9bjvtGQnYFnop2mEjEp
         NBTUzesaDzawxBa15rApCPSMp5d5bxecSsLN6qMS9clhCGCZQdp7t4W+oKe1wfffZC0o
         Xeq1DzsJErRElyvzyAgagOh9M25jGSVRhNI88gTKIwDZVXzqXLLO3GgtMrKmjK0G46dX
         JBIL/6MNALqmcxX/IGpvS1qNcEi4X0j3HmL3E3VHm/CmQK+T0zkq6KhlDK9fQ63cVU1G
         xMzA==
X-Forwarded-Encrypted: i=1; AJvYcCXSHXnUtT6E+ruCW5AAZORgAyd/43xUyCwMvSaOtAAk/HKCzNiOdmuf/L3U8Ycmgq2IAWZH7myozlxwk7K5nAi5RIY5V8j1Hm3BYIRc
X-Gm-Message-State: AOJu0Yzk/Sb0ID2E1I5x2AvnnbKawNHL36LYCM/AqFLvDIoQXiGuWMNN
	DR00ti+SJbd8FXaxC/5WfCBWpALnt0XCRn57auBmOmJMHFSj+7hUMWdUoc7APlo=
X-Google-Smtp-Source: AGHT+IHrfn5+qakoSjfF+eVmHdWpMnGzJDOCxp4hvlOHRl6xcuXO3Uw28u/M5GHuIJk6sqbBj3Wnxg==
X-Received: by 2002:a2e:920c:0:b0:2d6:87e2:e11e with SMTP id k12-20020a2e920c000000b002d687e2e11emr6983150ljg.8.1712056618756;
        Tue, 02 Apr 2024 04:16:58 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004161c690b80sm1225823wmb.13.2024.04.02.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:16:57 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:16:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: gaoxingwang <gaoxingwang1@huawei.com>, mkubecek@suse.cz,
	idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <ZgvpKNFcBw-39SOD@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
 <Zf097_S2K9uxGsR5@nanopsycho>
 <20240322080727.786dd760@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322080727.786dd760@kernel.org>

Fri, Mar 22, 2024 at 04:07:27PM CET, kuba@kernel.org wrote:
>On Fri, 22 Mar 2024 09:14:39 +0100 Jiri Pirko wrote:
>> "gaoxingwang" certainly is not.
>
>According to what rules? Honest question, I don't know much about
>transliteration of what I guess is a Chinese name.

At least capital letter would be nice :) But "Wang" looks like a surname
and therefore a space would be appropriate too.

