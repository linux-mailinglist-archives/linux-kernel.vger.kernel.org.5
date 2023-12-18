Return-Path: <linux-kernel+bounces-3047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B2A816693
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C837B1F215DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109476FB5;
	Mon, 18 Dec 2023 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R1rGBwYF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405816FA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3c8781c92so751395ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702881268; x=1703486068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNzWN5t7u2gxnvLE/wUGU2nmIrr3uGH5m13BIGWGMnk=;
        b=R1rGBwYF8xCw/WX7zw9ojd/G8pXzQrAYO9InnFi/kch92yXqXOVtK3PJByLi3cpcEH
         siWczb6o28RN9gc/caLFHUsXLn/L9Lld8UfUhHrP+Gtk2O/yAFTZdXmtCdiMM9Ve+2kJ
         N/lMvK6o2fosHyvo3OQJsvQubiEHdlxlVDDtTdzD2Sd03YxDr4NMFt84brAMecPcvacd
         876qTYx0ocPDuT/YmnQkRe8OBlypzhL+8ViE8xT8k5s52LQDlIP0aL0/iXH4gfbFZCK6
         wX9bEiZnW8CKZWmYWrfh2EpvTwn09jMpNsDO4QZnTXxwiMpetogN312GNcq+bJB4hf/o
         Mguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702881268; x=1703486068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNzWN5t7u2gxnvLE/wUGU2nmIrr3uGH5m13BIGWGMnk=;
        b=j1RdDM7RG95k5M+gISV+f8wqJbQsGW6VlU73K83WQIl1t7z/RWLeJW+9VvjUK13Jwt
         aaNlRpBr0vn8bbmY1X4K/AgQoyALX3mkdx/VrVwFm3AI7QYn6RvOJU2h/r21x8MWoZCA
         SH0isRHpE3ryuhvsBOwpWFUsJOFIqdKjfc5wDdNIaHRLYc80BzgkRJOP1tTwbsTykMDB
         9iApxC+bvvt2SHnxsgAXUf4EOIcGtoddsneN+L+4eTbK609epUZZY44DULc9Gqosvsk3
         CR+LI+ilK11bfzmveHKAsB2W29vsT2uMveDdYlXYhWi1rTnnGaq/obg9yuIJlnomRLw6
         z3Xw==
X-Gm-Message-State: AOJu0YxLVdb2BqRcB2oNtyb4AJM6ORikZ0muaGnd4MiAjJOsZHGrL9pO
	ouoFShwEluSBBHq/uAxu30enGg==
X-Google-Smtp-Source: AGHT+IG2pVwUdn27kNNiaKbx66NC0lj/as8aYtuJzNJZp0x1hsL/r+tQky+UaURXQJtqXMrIX1TUKA==
X-Received: by 2002:a17:903:24c:b0:1d0:6ffd:9e1e with SMTP id j12-20020a170903024c00b001d06ffd9e1emr18147120plh.112.1702881268468;
        Sun, 17 Dec 2023 22:34:28 -0800 (PST)
Received: from [10.84.154.115] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001c9db5e2929sm18272762plx.93.2023.12.17.22.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 22:34:27 -0800 (PST)
Message-ID: <46bc7aa3-4b08-4e5f-9563-485ee17e2785@bytedance.com>
Date: Mon, 18 Dec 2023 14:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
To: David Rientjes <rientjes@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>
Cc: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231208025240.4744-1-gang.li@linux.dev>
 <996ba32c-78f0-1807-5e64-af5841a820e7@google.com>
 <20231212230813.GB7043@monkey>
 <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com>
Content-Language: en-US
From: Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <55c6c1f6-0792-61c3-86ed-4729d4a3fdf5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2023/12/13 08:10, David Rientjes wrote:
> On 6.6 I measured "hugepagesz=1G hugepages=11776" on as 12TB host to be
> 77s this time around.

Thanks for your test! Is this the total kernel boot time, or just the
hugetlb initialization time?

> 
> A latest Linus build with this patch set does not boot successfully, so

Which branch/tag is it compiled on?
I test this patch on v6.7-rc4 and next-20231130.

> I'll need to look into that and try to capture the failure.  Not sure if
> it's related to this patch or the latest Linus build in general.
> 

