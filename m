Return-Path: <linux-kernel+bounces-23760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595582B14E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5BC1C23F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD94BAB0;
	Thu, 11 Jan 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPKdP/tJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401054B5BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704985581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4NyWYyJWIFLvqgVXLzjaVdG5ra7Nvuql968RMbOsilM=;
	b=XPKdP/tJ1WQdLMV5IblcW6iExECZT91Gk0RzMFWhi/AEf6je9/DAskz32pwOL0dhxLfvcq
	cFHDqBtA4gcw1f/1mjzAQeIS8WSGBBMxniJS4PVPHtS933cDfnPmDFuUCqDRWEvnbB5YJG
	ZmSAAdBI9AJhDj5tlvm3rxieBoYZQAo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-1aVh6isWPhCfS5bPkcE0yg-1; Thu, 11 Jan 2024 10:06:20 -0500
X-MC-Unique: 1aVh6isWPhCfS5bPkcE0yg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7831fcbb2a5so526666585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985578; x=1705590378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NyWYyJWIFLvqgVXLzjaVdG5ra7Nvuql968RMbOsilM=;
        b=t3EunJDtCxlEttGyvWnPlbkBnNSLWTDfbMo/FrRswUGWYmHx6f1VZ31sb6yhh0yCn0
         SNzBSoKeeAf9shb5J2y3P3BleTu2g8RNq/nvBkYXAIXqq6lYfh3+677TOCVI+8KtW7T2
         iTs7UHcJ8URI/YxRwcefMlQS5+yPMTlRAKoF8sqaxrRwAonJUIyQ3uVS3K6LZDrkRXQu
         PWgHGatctUFLEx8DyOYujlXqLqMeNFvhuSMBdYqX/sdn3uBFE2Z8K3MxMjvd1FhRoXq/
         KjbC6691g631bu+P7M3LWRR9NzwrH5q48DkEH2zxpJnfFpe4xFMgJZReYF2ogrfCwvAz
         aRvg==
X-Gm-Message-State: AOJu0Yy2Ib36DIw1B/j7fDA47x/HLfXmHTY6mdayu/uArIh832bDcv19
	PIKpLVa86Z/N6eIwuwwbc+BUEqyJe9Aef+jRUVXOSH/HmZViIqbDU7JvJJav6Wtke6hM+PDkYmE
	UtNZ8ivYJsBzqOumSSNw/jStaW1niwhnqDX6xtrpR
X-Received: by 2002:ae9:f109:0:b0:783:2c5f:939c with SMTP id k9-20020ae9f109000000b007832c5f939cmr1424748qkg.39.1704985578191;
        Thu, 11 Jan 2024 07:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ5KysuSrSEUxaDqgCcoAWvvoCJTJvmkb4vE0TaVYFriF7WasRsG2VBwYO6XFSBITehv4rSw==
X-Received: by 2002:ae9:f109:0:b0:783:2c5f:939c with SMTP id k9-20020ae9f109000000b007832c5f939cmr1424735qkg.39.1704985577923;
        Thu, 11 Jan 2024 07:06:17 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a10bb00b0076db5b792basm390174qkk.75.2024.01.11.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:06:17 -0800 (PST)
Date: Thu, 11 Jan 2024 09:06:15 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Lucas Karpinski <lkarpins@redhat.com>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: disable pcie2a node
Message-ID: <ea4ucaogzewpxqiwg3fegipnhj3mpfxcvm455a3ow6vs4maqeb@usgbirpaeqmj>
References: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>
 <ZZ_1ARhDxYNk7Gt2@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ_1ARhDxYNk7Gt2@x1>

On Thu, Jan 11, 2024 at 09:02:41AM -0500, Brian Masney wrote:
> On Tue, Jan 09, 2024 at 10:20:50AM -0500, Lucas Karpinski wrote:
> > pcie2a and pcie3a both cause interrupt storms to occur. However, when
> > both are enabled simultaneously, the two combined interrupt storms will
> > lead to rcu stalls. Red Hat is the only company still using this board
> > and since we still need pcie3a, just disable pcie2a.
> > 
> > Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> 
> To elaborate further: Leaving both pcie2a and pcie3a enabled will lead
> to rcu stalls and the board fails to boot when both are enabled. We
> have the latest firmware that we've been able to get from QC.
> Disabling one of the pcie nodes works around the boot issue. There's
> nothing interesting on pcie2a on the development board, and pcie3a is
> enabled because it has 10GB ethernet that works upstream.
> 
> The interrupt storm on pcie3a can still occur on this platform, however
> that's a separate issue.

Related work-around to that in case anyone is interested in the paper
trail:

    https://lore.kernel.org/all/89c13962f5502a89d48f1efb7a6203d155a7e18d.camel@redhat.com/


