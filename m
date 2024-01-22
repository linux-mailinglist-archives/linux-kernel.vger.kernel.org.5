Return-Path: <linux-kernel+bounces-32519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A432835C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A504D1F22DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F64210FD;
	Mon, 22 Jan 2024 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDQ2aEWv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1E18C20
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912209; cv=none; b=MpKlXwtbGmZDvYcHwiP4fXsvej/32FY1kw0wWwqZglBsCeC2Cq+85pb7O3310aJN8UZyYOyqHFmo3IlSLJGz26ukPVA7vR5ttzEY5p2+jywPsl9stERg1htMxZ5bNTLktBx8q985b+IL2+h+rYaxewBqPx+q3Tz9JcsTwTBvjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912209; c=relaxed/simple;
	bh=pMUV4op1QVmaWaTXq7UmoOws2OnRP5AvymPcOZREQRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrSkJaZDot22deW/pwv0X1lcsXwKpZUfdYX4xc4TTyFd/l//cwImF/3dG5+HfH9Cj5OWDoCVkei54lY5jnnNKyAr60nc82+0cNaPHSeflYhZWqlaPo1ios8n8qo/4jaWbQFYhwwBBwUeFVFOAQqEiRFn1HIXEUeim+9Yft85zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZDQ2aEWv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-338aca547d9so2253353f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705912206; x=1706517006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFCiLnY6xBPrqdHIolQZod6apPlIVJ6Tq13E5RZi33g=;
        b=ZDQ2aEWvgcLL3mtV6o2Rv4sEmLDjBkBQHtjN+PMeI9eHXU9jVtTVyIWe/B/V8cFlNP
         T0sOUoAxILun50TTK8as3sRruvPmlNPc+oN4lj5P7jqqX3pBgcMjgaFLLClNFwKsJjgG
         Fi0YXidBTxa5HbaDQPRhnHk20gtf3tZ4+18kcPElMKYQ8/mmXw96oc3qYsS2ET6XJyq+
         1lc7/5KZ/UnRhntfbBQyV5qXLEADRpQBiln5AM7Br4OY3+wsqLsO+cJbaHPIwlBHlRNN
         PiGYO0j+2YeEil7DJxawzBea3kiJtAVmVSo0ORWtc3rejbc6nk/d/mZKZ9LOrDGiAwBs
         QU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912206; x=1706517006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFCiLnY6xBPrqdHIolQZod6apPlIVJ6Tq13E5RZi33g=;
        b=BVUQ/XvdtQf0eHTWM485O6vHeHCw4/53CRWLl8lUGvEIltymebcrLbWiNxUXN1dy51
         4dmO3QmiTt57ZuPwoWOborJCBhFVy1vzk3Y8iYY5cfnqO1YXGyVFCVwUv9xLQT8F4h6L
         ixhaDc6VqtCdpDNbJZ0AqAtoR2NboaPYqsmVCeUEZodHYTpRH2UojMdOhZhNIjHoeK55
         sYO1YWIkdvc/rm1im2ITRN+TNZU2KQmIrBt6xv2FjjmBsZp+7eQym6GdsYp0MAYKn1Fq
         aJNsUBZVM68O1SQ+eXsPNGUET45LdL4Xm2dQhtk2ymks75euCWnSS/FDN/oJHgojIY94
         tkQg==
X-Gm-Message-State: AOJu0YyJiko3/rG4yJ93EUrqI2xFOGQLRbuOWXuEmUIQLmu/25IWN2UH
	wxQeEJ5GMgpwP01dAotAwXRie3Or9SJ0FVdN4dHwey0Y8+WwEor+RFsY0mdJEso=
X-Google-Smtp-Source: AGHT+IFVQ0c6+n6QcK4dPQ4aInfuFL5IaA5u36sUVkTkA1RNClaCwWZfy6oJvnyLXS/5fMx7uCKTPg==
X-Received: by 2002:adf:a18a:0:b0:337:828b:dd72 with SMTP id u10-20020adfa18a000000b00337828bdd72mr907642wru.55.1705912205784;
        Mon, 22 Jan 2024 00:30:05 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d21-20020adfa355000000b003392a486758sm5511850wrb.99.2024.01.22.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:30:05 -0800 (PST)
Date: Mon, 22 Jan 2024 11:30:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: Markus Elfring <Markus.Elfring@web.de>, xen-devel@lists.xenproject.org,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	=?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH v2] x86/xen: Add some null pointer checking to smp.c
Message-ID: <dfb6de51-3ebc-41fc-a750-cf5ca2ac05aa@moroto.mountain>
References: <20240117090018.152031-1-chentao@kylinos.cn>
 <1705655941162581.825.seg@mailgw>
 <517fae75-c4e7-4576-81ff-6a14a3eb9cd7@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <517fae75-c4e7-4576-81ff-6a14a3eb9cd7@kylinos.cn>

On Fri, Jan 19, 2024 at 05:22:25PM +0800, Kunwu Chan wrote:
> On 2024/1/17 18:40, Markus Elfring wrote:
> > > kasprintf() returns a pointer to dynamically allocated memory
> > > which can be NULL upon failure. Ensure the allocation was successful
> > > by checking the pointer validity.
> > …
> > > +++ b/arch/x86/xen/smp.c
> > > @@ -61,10 +61,14 @@ void xen_smp_intr_free(unsigned int cpu)
> > > 
> > >   int xen_smp_intr_init(unsigned int cpu)
> > >   {
> > > -	int rc;
> > > +	int rc = 0;
> > 
> > I find the indication of a successful function execution sufficient by
> > the statement “return 0;” at the end.
> > How do you think about to omit such an extra variable initialisation?
> Thanks, it's no need now. I'll remove it in v3.

This advice is good.  Don't do unnecessary assignments.

> > 
> > 
> > >   	char *resched_name, *callfunc_name, *debug_name;
> > > 
> > >   	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
> > > +	if (!resched_name) {
> > > +		rc = -ENOMEM;
> > > +		goto fail;
> > > +	}
> > >   	per_cpu(xen_resched_irq, cpu).name = resched_name;
> > >   	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
> > >   				    cpu,
> > 
> > You propose to apply the same error code in four if branches.
> > I suggest to avoid the specification of duplicate assignment statements
> > for this purpose.
> > How do you think about to use another label like “e_nomem”?
> I'll add a new label to simply the code.

I'm not a Xen maintainer so I can't really comment on their style
choices.  However, as one of the kernel-janitors list people, I would
say that not everyone agrees with Markus's style preferences.  Markus
was banned from the list for a while, but we unbanned everyone when we
transitioned to the new list infrastructure.  Do a search on lore to
find out more.  https://lore.kernel.org/all/?q=Elfring

Perhaps wait for feedback from the maintainers for how to proceed?

regards,
dan carpenter


