Return-Path: <linux-kernel+bounces-150208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F38A9BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B161C230E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6E165FC4;
	Thu, 18 Apr 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVhCXV/d"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A81635C5;
	Thu, 18 Apr 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448377; cv=none; b=LG118vMstorpggci1tdeXPEFdlarn8bQB3peR7EhYFo+MeYdqTmYsPFBWlVcOuQOSozDI3YRulfQii327mmexHGd5Sa9+AxR577poIUMTLzwQRKDOVvwJimxkI65g8hn9V9gDj85dN9uJAq5SAQYY0lUYBimc0r+4lqIrkLOYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448377; c=relaxed/simple;
	bh=OOfclcgBJP4rjtOQmlOeafKYzgvn9V5QPUbGwmpD9H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx/jTF/ej1kG0g1NRyrf14jRUXA+iLbK6mBeop2azyaEbguPP2D+SrbISmh0t/A/9Zs4Vh6nYqK2YEcmCh0NJty82dgaoxQxX6W0ni8Fq/6MhAa8aptFxUQ9zDCPbsjNViGDxVA2g1lOBzEmp2kYzEIPqT72XVjc6U0hI0U1Ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVhCXV/d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f074520c8cso868763b3a.0;
        Thu, 18 Apr 2024 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713448376; x=1714053176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyA3fzOku9oWwA8R0hs2Mphvf99QfjgFFiLxSpYNLQc=;
        b=AVhCXV/dDhmFuzVqOhwIwoq/nCiyJGr5iECYptBsOBUCQ47eBZrQ4QlAJY7FQKnHHI
         1HvCpUttn30Kq54lNnSCo8f+k+dngFDCQwpx/qhzcFm5JAvRZKDD+HJUnR8fYW8C803I
         mtKm8RqZFZIjt3997sJHgnM58VjNm4nFEONhs4oUZfYI6USTu3Ut/HvyZc0RFxx2N2wD
         GgArO249F93TVxxlRCCYsC3k89cvW/amqOQoFQ6pjNyRw50fXPSGudgOnhAwQBpYynr4
         upmyaIktM6ivR+v4TSakpdUj7xiTk0rqTdeHLsrF5cDw0vP3cH/Czb0hNWtmaDwf18vQ
         nRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448376; x=1714053176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyA3fzOku9oWwA8R0hs2Mphvf99QfjgFFiLxSpYNLQc=;
        b=Q5xq8CCl8TKtSBNU6js68iTqkVQVXH+BfGNg3eJUoYCGYiNp5tBRErXyXntQeM84Tx
         970DwZAP684PtvGGN6SLVJEXGYlmAvKVWLtIdHMhc1wtMaS7xHGdT8o3LN1Eg6ULwYfg
         lCt2OJxWPiDKk9+zigOribT/IewYKyleJK1+7M5GKlVQeTE33aEfswh0UD20TTIsybmY
         3VuLqCuld/prA/gbczZTYLZvKD4MRsyd1zeawe8EaU7fHvoaXTUfhmplOX1eyQ0pcQl+
         ORdFSvDia4S7e1bz5NiebRs32eNQPt2E3uxbHxQTU1KtxLuEInK4IRzo1ReR5lSDGSb2
         UyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmdTtN0lVTJr6cL7oLYRXXp2Kjpk4SSaUdjQqNraL0CHEOu9tPpiX6nT6ApuqnN78dRbwJphgVC8OVIcea/JLFk9xV8TlkBVVRjQx7KJ7ZPBL3vWGSQ9k9MiLgL18xtMX3ntOcN/6Zk5Y=
X-Gm-Message-State: AOJu0Yx5INB//ki1UFelb0uWQmNvbjkwzk2NzoQ974pfBYML4Him/aHT
	s3Ufm9qeCyHbj4CFUg2A81BW5uS2aoa45AYXgmr5qlkLeKhUPx6c
X-Google-Smtp-Source: AGHT+IFKjXEU0yszXeRAs3pRq6UlLYqDpFbI6NzJmKcNmljEtyYAhAhxpmnGaPhWktOFaXkyMjn/2w==
X-Received: by 2002:a05:6a20:841b:b0:1a9:ccf8:6ea5 with SMTP id c27-20020a056a20841b00b001a9ccf86ea5mr3873023pzd.8.1713448375740;
        Thu, 18 Apr 2024 06:52:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001e28d7329e6sm1530208plb.91.2024.04.18.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:52:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Apr 2024 06:52:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Message-ID: <f1d02e4f-a947-4af1-a7c0-9f7c12c57b3e@roeck-us.net>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212216.9605-1-tony.luck@intel.com>
 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
 <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb09d67409c94284928243d8ffb1f8a3128d849.camel@intel.com>

On Thu, Apr 18, 2024 at 01:32:15PM +0000, Winiarska, Iwona wrote:
> On Tue, 2024-04-16 at 23:57 +0000, Luck, Tony wrote:
> > > If the CPU defines and the new macro are to be kept in architecture code,
> > > maybe include arch/x86/include/asm/cpu_device_id.h from linux/peci.cpu.h.
> > > That would not be worse than today's include of intel-family.h.
> > 
> > Guenter,
> > 
> > Looks like I did that to resolve one of the other peci problems. Because I
> > already have:
> > 
> > #include "../../arch/x86/include/asm/cpu_device_id.h"
> > #include "../../arch/x86/include/asm/intel-family.h"
> > 
> > in <linux/peci_cpu.h>
> > 
> > Simply deleting the include from cputemp.c builds OK in the
> > context of all the other changes in my patch series.
> 
> Hi Tony,
> 
> It won't build on non-x86, as cpu_device_id.h includes <asm/intel-family.h>.
> I think the simplest way to solve the issue is to provide a copy of VFM_* macros
> and X86_VENDOR_INTEL in include/linux/peci-cpu.h.
> 

I think the proper fix would really be to move the include files to a
generic directory, such as include/linux/x86/ or include/linux/cpu/x86/.
After all, they _are_ now needed in non-Intel code.

Guenter

