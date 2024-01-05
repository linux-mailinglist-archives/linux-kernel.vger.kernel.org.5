Return-Path: <linux-kernel+bounces-17877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F933825478
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51041F227BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113312D63D;
	Fri,  5 Jan 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFI0IUs6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E402D629
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdtxfx03dNb9a84Q0U5VUlr4uhmr3eybv63WL4zK3CI=;
	b=XFI0IUs6WgXVc6w3vVzNDeODzfKDnDD8GjjVGis2IS+HJ8l5qyBkNQKB58NVgY1T+Z51mU
	oFrY480hTUpR/VP5vAv/cgQedUgrIGioeFs2xxYpr059QL8KqB4t4thGferoMImoWlD0zQ
	6Tv3P+VvISz+2zLBiJ9l7++UhuG4J+0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-4Kb8O2NlPqW5CSTmkPtPFQ-1; Fri, 05 Jan 2024 08:30:17 -0500
X-MC-Unique: 4Kb8O2NlPqW5CSTmkPtPFQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce53c43ea1so1357995a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 05:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461417; x=1705066217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vdtxfx03dNb9a84Q0U5VUlr4uhmr3eybv63WL4zK3CI=;
        b=VmHY9tTfkd54n7g18jSYXIKL9EQ/epHMwNG1FVrvRVvqy38chn20P7QBVT8H4J2or0
         k2U4+jeKZz7CX9nm+GVJXZqd2FmW0z+Y1c7vnFfQCrncEWorK4nz701/Ssi6l2dnvE0Q
         bqrKdInDa2nAGB4kNrPUhIkNNNPepzmmzd9/NwsNbUaAnKbWceNPEPSYA9cvfRZIS9lu
         RpED1tciA2syzzTqgtClpmWWnfrFeBazzHqjZYSGjB6w0zEK74b4Bbm4nU/68h8kOtiy
         xAV8iwLxIruy+z7RyRj4kyB1oXKrQKp0jzi6dk9v0C600TnyrEkHYKLTWzIXk8sAfLUd
         Bw+Q==
X-Gm-Message-State: AOJu0YwSYt1YaNl0Qf69j4jm8j6GcIhk3ek0fqD4rS4Jd+Mrc3lzPdqV
	hP/Z2/sBVWZyoZ2qDRnAqYUX/mq9vMSJ/NaOwW1CHaVn67TpNibzJU/X3iu8605Ch0FohmGeD7x
	L3tlM2dVAUU3rWptKl0efF6Vij04MeIVe
X-Received: by 2002:a05:6a20:12c4:b0:198:fd1a:64d0 with SMTP id v4-20020a056a2012c400b00198fd1a64d0mr1931042pzg.55.1704461416823;
        Fri, 05 Jan 2024 05:30:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ9UPTeduheyPYn+wcdUXUh2lcFwbNX6NSk8O1ez2Z4LwdaqU4OyWIPTs64CwQIAS9A+x9cA==
X-Received: by 2002:a05:6a20:12c4:b0:198:fd1a:64d0 with SMTP id v4-20020a056a2012c400b00198fd1a64d0mr1931026pzg.55.1704461416419;
        Fri, 05 Jan 2024 05:30:16 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7800f000000b006d9a0902937sm1427752pfi.149.2024.01.05.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:30:16 -0800 (PST)
Date: Fri, 5 Jan 2024 21:27:02 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <35tiggwgbrb2sapyykv3umio5l2xqhmzc43wy33dxmz4hyu24c@bprgz7skpxma>
References: <20231227044156.166009-1-coxu@redhat.com>
 <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>

On Tue, Jan 02, 2024 at 12:54:02PM -0500, Mimi Zohar wrote:
>Hi Coiby,

Hi Mimi,

>
>According to https://docs.kernel.org/process/submitting-patches.html,the summary line should be no more than  70 - 75 characters.

Thanks for pointing me to this limit! How about 
integrity: eliminate harmless error "Problem loading X.509 certificate -126"?

>
>On Wed, 2023-12-27 at 12:41 +0800, Coiby Xu wrote:
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Otherwise, the patch looks good.

Thanks for reviewing the patch!

>
>-- 
>thanks,
>
>Mim
>
>
>

-- 
Best regards,
Coiby


