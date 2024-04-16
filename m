Return-Path: <linux-kernel+bounces-147754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA08A789F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1386C28343F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013D013A88F;
	Tue, 16 Apr 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIPYPENS"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48574AEE9;
	Tue, 16 Apr 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310631; cv=none; b=V3wjMkKexdOSoWJI8fXMu7xAcNDaeoExl8SxI6BcPKWyrFQRsI3MRQKm1VlIj8d2iHM66E6/UkmHelYx+jGZ8GQLKaxfuOLf0z6smoj7hFq1eQ7UTej4qIs5n/kadwgu8m3QViem6+p/XOPPDDZ7mj8IWk8ksfYbeply9W4dbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310631; c=relaxed/simple;
	bh=5U6nMna7SZk/DJ9T0/T/d7oFo7eqY6+bP8se+cova7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBTXDvyceSB1+XF0q1eR01ql2Ut2/8aRnS4pVklQRTNXXm+4XzZ39R6UioVwjxsVJ5xa56Lrhb5tKOriQW8AEQf0InEMiGGQznKqT8IZGs8nQLLMmXKrKgMUpf+tGdmT3etEEgIFZjLkqKzfGk0v2j9lJAdXjsRO32jvNeb/fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIPYPENS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a6ff4f91cbso3151384a91.0;
        Tue, 16 Apr 2024 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713310629; x=1713915429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTfwUoX6e0yKJZCWswKlfqOpaMBvbmr2XuMgc00p1Zw=;
        b=QIPYPENS0bTlwOW75ldXjN1A66A+T9y2GCTP2RDzFtf8s4zyg0fDzkBPsGXA92YzO3
         GVolItWHLAO8Dl70VeJ0tZ8nq1FyIIQ/EZqim9B7i7lIMBHJ+Q566NVS8TWgH+ODmYNz
         6r2RUf8yiDwBsl5Frnd92EU52WBMJhy+pr2nuq1mpWhZdQkDYbcD2tTcGZ/NY7xrVZyn
         6NpPIzKqvZZQTiHCFKSd40TEn4D+OnBlx+7Bgy7Vpp8Kebi5AVNXoSOoA7J+jhtUxWfk
         Ybo4NdrqCHw52twE3/7CiYE6ETe2gw1YthaxIjL9Kzd/HTxQZ26lPzMJm7sTc8AWpTxg
         7tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713310629; x=1713915429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTfwUoX6e0yKJZCWswKlfqOpaMBvbmr2XuMgc00p1Zw=;
        b=PwZn3wpIzNjGBJmwp4CP2Rq2XIsAgek3m1ZCZ6Lq9NvYzGP4k8NHtonJnh8+eg5bGq
         cSHcK2y3NTx9LH2Ib7ikmGFFMhYlf+usHWTrbHqgETI0iVdLgQXkP1eMBTatMfHpDGuu
         AjBOd2mJQT4C0vw+k/TO72EiVMglyt/26VkBWDD3qvkNEmmBeWdzVzXRA3EyV9DK3//B
         FzuRkPPkvTzD+4RYck3aKvCygs5v45i612qC6ZuEAbiCw+YaLs1Ec7KtYRHP1FXdxIz/
         uTL1YzWgsEoIr+6Rudd1rTuUgjGEsJlT2G+xJqQQoLokZwMjhucE9XjvLbYjGh2PqA9D
         +GQw==
X-Forwarded-Encrypted: i=1; AJvYcCUWOe3/CMbsETHAaZsARCO0CIpb0qYyA7ZzaY1T8kPZy+ddKVNICX+vpMXNlxmmk3GTY/Hg6S0g0det6+TU+m2KfWC5SftTEWU5RfSFQaBaF4mHC9lXxzjsMAduKbDdVUUL+ptb49smY6M=
X-Gm-Message-State: AOJu0YyZMa4f27KvVaONw7/sUJYBlVRq+hDwi+muFgqKNf6X9lceaOmc
	p7lIqEuuiA6PU0Q98LTgIoLW+ruRaK67MhNKkQgg2sxQ17LmEwvBkF7anw==
X-Google-Smtp-Source: AGHT+IGDyd586AvicCSraj2ozwB3Hcl1DlgfR2cmkHRXes+QFZ70g/SypQBB2aoQnfjNs8dRBr0OJA==
X-Received: by 2002:a17:90b:33cd:b0:2a8:5968:449d with SMTP id lk13-20020a17090b33cd00b002a85968449dmr6682233pjb.32.1713310627938;
        Tue, 16 Apr 2024 16:37:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090ad50d00b002a5dbfca370sm152661pju.48.2024.04.16.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:37:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 16:37:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	"Winiarska, Iwona" <iwona.winiarska@intel.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Message-ID: <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212216.9605-1-tony.luck@intel.com>
 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Apr 16, 2024 at 11:05:15PM +0000, Luck, Tony wrote:
> Guenter,
> 
> Thanks for taking a look at this patch.
> 
> > > +   case VFM_MODEL(INTEL_ICELAKE_X):
> > > +   case VFM_MODEL(INTEL_ICELAKE_D):
> > > +   case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):
> >
> > $ git describe
> > v6.9-rc4-31-g96fca68c4fbf
> > $ git grep VFM_MODEL
> > $
> >
> > So I guess this depends on some other patch ?
> > That might be worth mentioning, especially since
> >
> > $ git describe
> > next-20240416
> > $ git grep VFM_MODEL
> > $
> >
> > doesn't find it either.
> 
> 
> Yes. This depends on parts 1,2,3 of this series. I should have added
> that to the "---" meta comment part of these patches that I'm spraying
> out to maintainers of random subsystems that use INTEL_FAM6 defines.
> 
> > On top of that, it looks like
> >
> > #include <asm/cpu_device_id.h>
> >
> > introduces a dependency on X86 which is not currently the case.
> > CONFIG_PECI is typically used on BMCs. Many of those do not use
> > Intel CPUs. It does not seem appropriate to make support for PECI
> > based hardware monitoring dependent on it running on an Intel CPU.
> 
> It seems that some use (or need to know about) Icelake and Sapphire Rapids.
> 
> How does this code get the value "peci_dev->info.model" used in this switch?
> 

My understanding is that the PECI protocol provides that information.

> Given that it is doing some magic just for some recent Intel CPUs, it seems
> plausible that when non-family 6 CPUs appear in the market, it might have
> to grab both the family and the model to reliably determine what to do?
> 
> Simple options to avoid including <asm/cpu_device_id.h> would be
> to either:
> 
> 1) provide a copy of the VFM_MODEL macro here.
> 
> or
> 
> 2) Keep using the old INTEL_FAM6_* #define names, but define those for
> the three CPU models peci needs locally instead of getting them from
> <asm/intel-family.h>. It looks like there is a somewhat convoluted path to
> include that. I see in <linux/peci.cpu.h>
> 
>   #include "../../arch/x86/include/asm/intel-family.h"
> 
> 
> Or maybe some better option?
> 

If the CPU defines and the new macro are to be kept in architecture code,
maybe include arch/x86/include/asm/cpu_device_id.h from linux/peci.cpu.h.
That would not be worse than today's include of intel-family.h.

Guenter

