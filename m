Return-Path: <linux-kernel+bounces-9768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4D81CB22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5021C22338
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844B1CF94;
	Fri, 22 Dec 2023 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WikqRj0v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9811CA86
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703254250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkQAmZuOC5AajVxxYEXgSRDGaDpgeamEyrGio63IlrA=;
	b=WikqRj0vEpcknCaf2kO+QlqAxAclByQ/orEEAlBEpLPzVqZq8IfZxohp+UAACYKFdMjV2g
	MVwVA5prce4v1PQHQyRXcWMYKmI7NQU+CD5gFmL7zeG8pJisLsObQ8dkndHyoUNZrBo7kO
	J/bOYXzF3YAPUD8cvVy8LqXCsG0TpGs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-yZct57yuOXeW9ggRcH5lhw-1; Fri, 22 Dec 2023 09:10:48 -0500
X-MC-Unique: yZct57yuOXeW9ggRcH5lhw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54db2c98694so942122a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:10:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254247; x=1703859047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkQAmZuOC5AajVxxYEXgSRDGaDpgeamEyrGio63IlrA=;
        b=j4JdidCT3zN2WeVFqAaCUrnkz87jEhZir+j7/aZJAG/RECI37lEy3+OenY31qftQj8
         OoRI0nVo++Kt9Rm74FrrxjrnY+Pe8dvhTAcid/sLGUYB3zboixZQLlYsynWGyTZWf+eN
         Urk65AAK1BJ8jHfMpQnuMTSlv51KDQ2/jI/SeODn4n2mzxzf5qX91xYakEXv/SD5T/Ax
         hMNqrnz2HpHNKGhRSR37uMPHkU7ZsqaKsG+AtOKqP+C9TkdtIgYS1b9FeXvxfXqf9jCL
         dtth7i3Yaht5J5jx6UOG2/mSbnIe+Bm2YOEGt17iy3AtDANnwLGDS0MmaGIy1RjcqYPN
         OHug==
X-Gm-Message-State: AOJu0Yx7VoUXpCi9FOCdVEm8dIm2kUcF/LYpC7Hz7mh1sWVpPLcZ5ta/
	ekTPVb3fExc6buumilggEWVFg3v06HDYgDybUWvn2t7VRuNyyg+FJrSmhHROdiDYP8W4TvA1F4N
	hnE+dde9PSrgTjMXJbDt7Mj8KWx6TBfTW
X-Received: by 2002:a50:9b57:0:b0:553:a9bc:dcf3 with SMTP id a23-20020a509b57000000b00553a9bcdcf3mr411711edj.104.1703254247626;
        Fri, 22 Dec 2023 06:10:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnkMPAD4si2nVyUwGK33MxorwGVzxttwJWVauJYoesXrXl4ANgznSSQRLSTfkse/ozp3sNVQ==
X-Received: by 2002:a50:9b57:0:b0:553:a9bc:dcf3 with SMTP id a23-20020a509b57000000b00553a9bcdcf3mr411702edj.104.1703254247353;
        Fri, 22 Dec 2023 06:10:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b00553ba2e96f3sm2622229edv.40.2023.12.22.06.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 06:10:46 -0800 (PST)
Message-ID: <3d087d6b-2ab5-4113-99aa-4dd6b9d88b22@redhat.com>
Date: Fri, 22 Dec 2023 15:10:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US, nl
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Gross <markgross@kernel.org>
Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231222135412.6bd796cc@canb.auug.org.au>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231222135412.6bd796cc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 12/22/23 03:54, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drivers-x86 tree, today's linux-next build (x86_64
> allmodconfig) produced these warnings:
> 
> drivers/platform/x86/intel/pmc/arl.c:680:6: warning: no previous prototype for 'arl_d3_fixup' [-Wmissing-prototypes]
>   680 | void arl_d3_fixup(void)
>       |      ^~~~~~~~~~~~
> drivers/platform/x86/intel/pmc/arl.c:685:5: warning: no previous prototype for 'arl_resume' [-Wmissing-prototypes]
>   685 | int arl_resume(struct pmc_dev *pmcdev)
>       |     ^~~~~~~~~~
> drivers/platform/x86/intel/pmc/lnl.c:503:6: warning: no previous prototype for 'lnl_d3_fixup' [-Wmissing-prototypes]
>   503 | void lnl_d3_fixup(void)
>       |      ^~~~~~~~~~~~
> drivers/platform/x86/intel/pmc/lnl.c:509:5: warning: no previous prototype for 'lnl_resume' [-Wmissing-prototypes]
>   509 | int lnl_resume(struct pmc_dev *pmcdev)
>       |     ^~~~~~~~~~
> 
> Introduced by commits
> 
>   f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
>   119652b855e6 ("platform/x86/intel/pmc: Add Lunar Lake M support to intel_pmc_core driver")

Ravji, can you please submit some fixes for these ?

Please split out the fixes into one per file, then I'll squash
them into the original commits.

Stephen, thank you for reporting these.

Regards,

Hans




