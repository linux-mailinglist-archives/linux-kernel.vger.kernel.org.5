Return-Path: <linux-kernel+bounces-117001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBE88A5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB3B1C350EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533673537;
	Mon, 25 Mar 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBUrfOtf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AD433AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369855; cv=none; b=TaCnUD6Er/V25sDqk8ZabzXMxUglosv1MVLGrt7nRzTO54XcjjWSh+0lUslvYAc40xYjiNH5gi0QQtoCearpV8PdXL9IOm9c7Iw+usdSmC3mNBCdg+LRB8IiknCGdCfPkr9TUCdlXMtj7YksCj37FA9HgbZHWC2Jb1zr9OhojkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369855; c=relaxed/simple;
	bh=I/0ssb9qvsZJ2CesquYjFBsL5CjwMBvCD4gHJOCAmRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3xTJ4H7zFo3i6B69ne7QOm4we/LAgwAFh62Y57P9USQtNFKm9wJflkm1rMIF30/CLi0IFxdAvb/vYmX3cdP3FFvxzmRKo2PdhN4Ea6P9tLHe+DXkY2YhsWoyNERJGVtsxv9AR+V87py27rLDbq0o1aM642sUmW2AgqCY1f8RPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBUrfOtf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea9a616cc4so955546b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711369853; x=1711974653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAcaRqwrbRM30TKi6X9l/01RCi8ibTxboxlerqqN1jg=;
        b=WBUrfOtfLI+2O0uxxZ2oEaeu7MHJdp0SGcSjNLHFMKsBDLfO6eBDFKxkQiXkGNQzmY
         eD5/jchQYgvBNXpxUXrnPBOqx5yo9jd5QL9OxIsqhjWWttPgUUmWA+B+4hlBJzSFMz6U
         IBYEqVYFmyTG9sDM3mOin+CF9/9XKZTyPt8PY9FhP3OFNQPXscllOJk4O7qpR8T8vJED
         GufvJLcpte5UyfU8fKNxhjtjdvNVB0ji3NCAnis9vKc6DSB2mtIkYRqQWb/yHcWu8WWY
         AsYDRR/N+JPnpHvglrVNzEAHPShiB3Wgzy3yXU6Xdfvb/YbHydIw4b8hJr6gmFrsLrjH
         4Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711369853; x=1711974653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAcaRqwrbRM30TKi6X9l/01RCi8ibTxboxlerqqN1jg=;
        b=m1TfyAfewe54zx/W38qcuToUr8NvuqG+gnUIsa9A1ZyuA64Sh+jdDi8Vr9T+ZmHrg4
         pIkZflIpiuMlG6kx7VEENKgVcA4V1iIuIjUemoDU15OhKzPFFcKGR3CPNb7zIH0XT2/T
         sHbOAfPJMBRJDTmP1CHu+BhDfRYwTqvgsUUoXD3akWtUT0G1pqCrViRhrVjrAh2xB5bv
         BcwsD34DGsLsqi9bG7dpqXtgQ3dKngaq8wYjzYrCSCN9FmeMnKY6rYLlgnZAYLIP3TxP
         HSicNuf+0SdgAlhSXJf3lADGJjbi9f2PoJwgOznM4eI5ZuX6FOxgAHz1vjBcG48v8iGV
         sXvw==
X-Forwarded-Encrypted: i=1; AJvYcCVvM8l4AuTw6Ubcd1j58nj/W5mYC8DFba0yrnmAAfzgdlfPhv8rcRE6S9z/5cE+tHdp1C2zefT7XIDD5UeA40T3ssNQsiddvnSLnPFa
X-Gm-Message-State: AOJu0Yyt3djTd6Ba2Y3haaB3JIhBCG2rHhyL69iSM7Va9N6sz9Icxeqs
	rpH9dzH891v9d8LET69IoltAkf0aCt2kX11EBbVEyK+No+M/5HEd
X-Google-Smtp-Source: AGHT+IEat6rsjLdajx4W51QuWs+Y1lh7QaH+sRoXZSCvbdL3bJONNi7oYAq0aJavojZ/C1MnPmm07Q==
X-Received: by 2002:a05:6a21:3949:b0:1a3:cb4d:3fd7 with SMTP id ac9-20020a056a21394900b001a3cb4d3fd7mr1854408pzc.56.1711369853059;
        Mon, 25 Mar 2024 05:30:53 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id n12-20020a056a000d4c00b006e6c0895b95sm4039410pfv.7.2024.03.25.05.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 05:30:52 -0700 (PDT)
Message-ID: <a9a84b30-838f-41e6-8faf-b3508d1ba263@gmail.com>
Date: Mon, 25 Mar 2024 20:30:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] mm/ksm: use folio in stable_node_dup
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Izik Eidus <izik.eidus@ravellosystems.com>, david@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240322083703.232364-1-alexs@kernel.org>
 <20240322083703.232364-6-alexs@kernel.org>
 <Zf2qcH-bDEgLAP7d@casper.infradead.org>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <Zf2qcH-bDEgLAP7d@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/22/24 11:57 PM, Matthew Wilcox wrote:
> On Fri, Mar 22, 2024 at 04:36:52PM +0800, alexs@kernel.org wrote:
>> -static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>> -				    struct ksm_stable_node **_stable_node,
>> -				    struct rb_root *root,
>> -				    bool prune_stale_stable_nodes)
>> +static void *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
>> +			     struct ksm_stable_node **_stable_node,
>> +			     struct rb_root *root,
>> +			     bool prune_stale_stable_nodes)
> 
> Do we really have to go through this void * stage?

Hi Willy,
Thank a lot for reminder. Yes, we could keep the 'struct page*' return value here.
And so we don't need to change indent here.

Thanks!

> 
> Also, please stop reindenting the arguments.  I tend to just switch to
> two tabs, but lining them up with the opening bracket leads to extra
> churn.  Either leave them alone for the entire series or switch _once_.
> 

