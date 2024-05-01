Return-Path: <linux-kernel+bounces-165357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78568B8BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D91F21B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24C12F368;
	Wed,  1 May 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gR4Z9xKb"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9750248
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572586; cv=none; b=kgbyLSPBlf6LgRX2PBGyXpI6yE+1266yEupNu7B68Y8n4RamRW9SqkCV7tsd/7ro/+QriYG0gApQTUHN1daLvkexccS4FWi2Goe0HHBXlkdWxZno9TktA41+hfnFhGSFiNR9oszv18EhBvPjDfY9Ls4Bwm1SzlQVz1L4IAhJqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572586; c=relaxed/simple;
	bh=lWkPcYzM0IS2ZNLUbMpap349Ov8pUe/jEyQ1UbI3Lno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzxqkFA2xiGBKqpIKw+ZdR5dQTg7JpBcO+T8wE65pjLjGKOSVjnFL4PI0O6UtRy7NTiqPD3eXhZFLWMRdZbeKOMqqzdbm8oq2oQQqQwXeNmn54ivvwN/WFxEy57w/cuV3oNUPdUUKp7cwqM0ZSQWFXfWs+TPJ5dyr2MrkPQgb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gR4Z9xKb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78f02c96c52so488939985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714572584; x=1715177384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1qoEIkOLck4Sa8ZT+0G2TYNAGl2HaO45P/SMXLf4vc=;
        b=gR4Z9xKbPjGulU9aDeXTQ1HwF4TAnwkWDu4GMq7PFKMfWkbDbfvBuEb2arghwDki0S
         7e1sZnY1kUoBdHUTe0WsmPC1rc6Sx7VdF1MWMcoyHw0mM89jDielDXvzkNFjrFJ8wFmk
         eNssaHJaqDObF3uLY3UjquJNzXs5SWhD4WcrCsPQe2m7NMQx2+eBMqyhtOZ5eX4k+JqU
         /OgnbZgfsWS9th8xyANwkwj1iFejr+cxFzfcSEOsJPw3PoJ0Skn+3cVuudEA+Kdomqg6
         WxB2SckZB3bvkA0DiE1HEM1Su8RP6O/VbI7Wh7gkEP7Ji/9M2+GxG9TY3LxICxCmXHuW
         teLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572584; x=1715177384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1qoEIkOLck4Sa8ZT+0G2TYNAGl2HaO45P/SMXLf4vc=;
        b=Z3C4kMAHfXb8qSezZpu3rTlMU8jesA5lRYCCLYC6lkszls98Y8EotA0wWxmWxFkqSP
         ohaTHzUVVIBlZL56ROqmEVmPS72B05wpdK1smnXDqq1hF3mI1/UfZAWs1aKTH55OGs2I
         Yq/N5vdf0vvZ81gbZi0ghrMgTeNsTmnvM1QbiIv1TBKUfkTqQb9dlxs8wJsLqCMmhC1O
         knh5Se8dkXXxPUOUP08tOUnrSCIT26KJEwJCtd/t+lF56ixHaRXOugTdRhvRdgvXi514
         9JMddHve/6KpZd/0lgDuH0Sg85ofll6maqvI9vLEX2+h/ASWLe4WTE9MFnKXYJUzupYO
         9AVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZv/JREVznR801PzAImbLrj5jyFUelKLdpx2WlXXfeFmCqaIqGzeHT0LULIKBnVDKIxsEF5Ow96amFaN/ImD5z4Wo/Ka3W19w/o/Zr
X-Gm-Message-State: AOJu0Yy5biuqlCnVe8P7zTbYVWxjy3hIlkLHcZQDnWbTVtWNrJ3LDk7B
	KrkDhO2q3annYdI0w2lFt3f1PjOmpP87Dq9Sqe3d+OV/ldSxFFF5k7gZdbeWrjk=
X-Google-Smtp-Source: AGHT+IF213Sn1gI+C+Ltfyt/EaM6iz2FDR/B69onEC5U2qmZQ4cFog5+UAuTjWWtF9BXGrAGR+fPkQ==
X-Received: by 2002:a05:620a:4304:b0:790:944d:65b3 with SMTP id u4-20020a05620a430400b00790944d65b3mr2980242qko.62.1714572583947;
        Wed, 01 May 2024 07:09:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pe16-20020a05620a851000b007883184574esm12405228qkn.98.2024.05.01.07.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:09:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2AeU-00DPni-Mh;
	Wed, 01 May 2024 11:09:42 -0300
Date: Wed, 1 May 2024 11:09:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: mpe@ellerman.id.au, tpearson@raptorengineering.com,
	alex.williamson@redhat.com, linuxppc-dev@lists.ozlabs.org,
	aik@amd.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	gbatra@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, aik@ozlabs.ru,
	ruscur@russell.cc, robh@kernel.org, linux-kernel@vger.kernel.org,
	joel@jms.id.au, kvm@vger.kernel.org, msuchanek@suse.de,
	oohall@gmail.com, mahesh@linux.ibm.com, jroedel@suse.de,
	vaibhav@linux.ibm.com, svaidy@linux.ibm.com
Subject: Re: [RFC PATCH v2 0/6] powerpc: pSeries: vfio: iommu: Re-enable
 support for SPAPR TCE VFIO
Message-ID: <20240501140942.GA1723318@ziepe.ca>
References: <171450753489.10851.3056035705169121613.stgit@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171450753489.10851.3056035705169121613.stgit@linux.ibm.com>

On Tue, Apr 30, 2024 at 03:05:34PM -0500, Shivaprasad G Bhat wrote:
> RFC v1 was posted here [1]. As I was testing more and fixing the
> issues, I realized its clean to have the table_group_ops implemented
> the way it is done on PowerNV and stop 'borrowing' the DMA windows
> for pSeries.
> 
> This patch-set implements the iommu table_group_ops for pSeries for
> VFIO SPAPR TCE sub-driver thereby enabling the VFIO support on POWER
> pSeries machines.

Wait, did they previously not have any support?

Again, this TCE stuff needs to go away, not grow. I can grudgingly
accept fixing it where it used to work, but not enabling more HW that
never worked before! :(

Jason

