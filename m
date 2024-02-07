Return-Path: <linux-kernel+bounces-56720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CD84CE08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69344B22649
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B28002F;
	Wed,  7 Feb 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NU0KCFI2"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264087FBBA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319740; cv=none; b=O9g354FwyHsxN/ch8o3wnTiMBtmaMvru0Km0VY/6VKSIndBtIBX2H4NvioBwlS4oWPX2w/nVCXQpZYUqCVb+MM+/JRa/Lkh7Gx8NBc+YyOtZu/dV92rimEg7Gw1AOqnW1yetAAI9NjVEXa42unOZfoQnkGUks8sCCWPD5yB0Wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319740; c=relaxed/simple;
	bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAeUlXKaNNFwkM/0nDmG2q2zimJmg3l1RpLD0qdON6gIFf3zXBkpc780QQfDneYyUuhfdC2J/2koAMkO2FtfdX7uDtXSjk7XsZYY2WfE4kfLM6+Wh3O8kJ55y29Y2EVE6sV2LVpDNSdWNYDj99pYDDHxO661FicjyAygOQcKKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NU0KCFI2; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2191b085639so310461fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707319736; x=1707924536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=NU0KCFI2PcXIesrZqDGaMumM07ZvsINqITiEAwBMhskWR31PwJB4q9nWxtvDCTO8Rh
         IfbIpX2RViygtZEXSpGQCGsTpsDT++li9tKJl1fcXN9y0zRUAUS7k9Vj9IluITTrToXf
         xPIJsabXnGELRFFBalq7+OpPtmVwCRBvcBFnDUeNl1oL0ZgyAT+2IHM3qrrw8yQd1d29
         WoNgWFmGjcu4PtpA3hm6bd6GDiVniNDgAiSjev6BW9nIsWDZFtgeSvTTPfYIfoa4Sbxq
         0UlYxzNH7P8IyUa/gcZr3zalpmpaeVxPmxRrNG8d2DEjrIJKcndJUQSHxUSM1ckT3kjU
         0zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319736; x=1707924536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=Akb3cdg/0uYor92T8jvZx4x7PAXj32j8DASoCZcJ5be3YZPz8POykUBJ2S1jfCaHP6
         RCoUn2kmJtY2jtj6d8/65nNJDTdwHJZcJ++dhHjsDLUO5eLEbYfc9z2E+gPNh4J6T4Bh
         1x/LU5WPFKy1zPtBKeawRvzlPiPIiRUu/EHbD3+F26uzd64MQ0YdD8D1iVjt/TmmpLFg
         HvKUuprWB/iF4dGDPvUO3t1vsg25avLQhZBhKe3s0EA2BqgWCPuFcu2nVX1W+HyuCnmf
         WC+fmXHSaAYvGg5jWEDH9hTyJ+KWx1VO9KUaCU+FkaXiS8sBC5TPOIj90/Wu9TIbPHNI
         /GZA==
X-Gm-Message-State: AOJu0YyUWG5eURH51ZwN+FteVQzA+Y6Pn/3AoQG4CdR5yoe1OnDoASiC
	QLwmMw3xp7foZOJRiFGpFf5mUBEFtVMPSAitqTnCD9gLxrRXiDJrdG8ODIcM2UrL72q2x/YizrD
	U7kw=
X-Google-Smtp-Source: AGHT+IHEL7CFznI2Gw3SaxhMoycGQY1ZAMJ2M/MoHIzeasU/nr/2JepWSFEuheW8Ams28t9PtymRRw==
X-Received: by 2002:a05:6870:bac7:b0:219:83cc:287c with SMTP id js7-20020a056870bac700b0021983cc287cmr6065943oab.18.1707319736190;
        Wed, 07 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUY+po1giBXhl03Vf0urto5lU8KkUE0xa/D+uEwt3aAnuuk7whgR0HTCfY+MTVQpslUqqUs/wsMp+t3ROMVbRdiv139tCe2ZBXKAtq4ZceV9PQJGgSNRI8IXanfewIYC0pI3FzZsKmRPGCkekyIVSuYunEdq/NKi0/3z9aOOnSjGhG1HWtDCKx6tkf7sG69wd0voFNXVKcPnx/Nm+iJxlnF6OfGX8tZ9W5Ef2TdHxCT40iWFJmfW6S8uQKXx/coePehrn7fBGc1ApNtwTAo8s/s5HRc5UVF5kRUR22WO8nHBRkrzcJX/Ul/xP8hPJikjNY5otCJsvQrEVBk2ZaVzx3MkqaDTyR4Ul7c2lNd1sQoJE9R4hMA5FyNT4k6cGm9+PELO3Pd2X6HZW5Jm8qV/VAErzvt6LcaoXye2Wua/2AYMT/wp1V94k8M1zgi8oPWuI9edPTgsfIAIs+qSWZnIHymtDR0ZDoa4pbEKoLlGJm39ZpBPkOgypT7AHFEI8rU/GAr/BBLOvIN75lw9qDVd4OTS7E4DjE+P+TXjW/ejHtWFFjkRAxscCfnxXGlxTCjMW8flXh31SrWNWQb7kthgrk5FZ0nc1rQCTq6Q8fWQP0Awd0gAJf2PwiCs47eD05aetIREJ1Gf81uCiJ/HxdH+LBZUmXJT18VOvJdRMBqtyz
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d76c6000000b006e112c93b1esm228799otl.6.2024.02.07.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:28:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjr4-008ccK-Kk;
	Wed, 07 Feb 2024 11:28:54 -0400
Date: Wed, 7 Feb 2024 11:28:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240207152854.GL31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
 <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>

On Wed, Feb 07, 2024 at 02:56:33PM +0000, Gowans, James wrote:
> 2. Tell VFIO to avoid mapping the memory in again after live update
> because it already exists.
> https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d61683eaee02b0
> (the above flag should only be set *after* live update...).

Definately no to that entire idea. It completely breaks how the memory
lifetime model works in iommufd.

iommufd has to re-establish its pins, and has to rebuild all its
mapping data structures. Otherwise it won't work correctly at all.

This is what I was saying in the other thread, you can't just ignore
fully restoring the iommu environment.

The end goal must be to have fully reconstituted iommufd with all its
maps, ioas's, and memory pins back to fully normal operation.

IMHO you need to focus on atomic replace where you go from the frozen
pkernfs environment to a live operating enviornment by hitlessly
replacing the IO page table in the HW. Ie going from an
IOMMU_DOMAIN_PKERFS to an IOMMU_DOMAIN_PAGING owned by iommufd that
describes exactly the same translation.

"adopting" an entire io page table with unknown contents, and still
being able to correctly do map/unmap seems way too hard.

Jason

