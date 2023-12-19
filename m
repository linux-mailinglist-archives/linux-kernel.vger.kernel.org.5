Return-Path: <linux-kernel+bounces-5770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05628818F44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868611F27D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB339AC7;
	Tue, 19 Dec 2023 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ChvD66dC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88E39863
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5907ded6287so3065997eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1703009209; x=1703614009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bFR3yte01HbYlDHRv97Ae0s+mmV5KMmIsjF09sLSAo=;
        b=ChvD66dCRbrb4Tz/VIZQITdIe3VhCTIvwu6b9nmnkohd1giplrKCKATqfNFHm5We6X
         rNayGvEjH+njcjmQnDCARGDHkg5hnoy+1qmkLj/IDcbmDgyQRG++qmq5he3lIvYUFTy6
         gcpIcfeQy55OMr1unUOYNSqPwNcTey5Q/9IO4yPDIrEsKOky7RyV6YhxJrk97fI3DY1z
         2hVEB/JeArL1Xcs5RGvqAtefJ5WVLVH2/wqLZl+W4h0wb3iWJoHUAWbny3ULk/urXJve
         /TZVHfffGNnPuvLyLcu03B+72KkAOl4gmKD3umtANKIHVqf/8Q5HBeFMl0iI31mqYsIX
         QJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009209; x=1703614009;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bFR3yte01HbYlDHRv97Ae0s+mmV5KMmIsjF09sLSAo=;
        b=oP8WCHFOhPfXgnIqzqg82I22GE3hVjkMXZ8IEfwiNA5eF2MzfY8JmzykaNL9Ke+aWB
         Ndr7/pPsDe5/oHRcGQzg1Ibhi1K5x4YkcLYvf5dgGLGWrz+pOvovYJdLrUYd3e9uq0ax
         e7SrH30JlxXeFVWkJJ69cyoCcO4fTPneDuRwG5kSTvHWslEv3rvZ7iZehAwNY95xyW6o
         /PkIiqeUOFdWPV1kZ54GpvEV+NLl99IKP3YSxQ20gMvjrn2ZxBK7JEjN69FLeJcNRhYQ
         DymMOPvj5C29P82Q83ppU0CaKjqWhLw2yY78GcLR++IVQzJnUxHL9B76C9+XA/djMhxn
         041w==
X-Gm-Message-State: AOJu0YxtegbQ60IX6lrCQlEFO6pr7ewVcF+MqCAsLbJ6mSPwsIrBf9v9
	HeT8GoQCS9LHQ5m6BL+t8CZGyA==
X-Google-Smtp-Source: AGHT+IGvPerCtBqoYqOL8gM8DjEGEeInNA7fBUfyY5sV10T7iaCe0Q9SaOquZFFdB4wBcBusiAV1LQ==
X-Received: by 2002:a05:6359:4c22:b0:170:c91a:b466 with SMTP id kj34-20020a0563594c2200b00170c91ab466mr17943635rwc.23.1703009209277;
        Tue, 19 Dec 2023 10:06:49 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b006d698583881sm4850781pfo.141.2023.12.19.10.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:06:48 -0800 (PST)
Date: Tue, 19 Dec 2023 10:06:48 -0800 (PST)
X-Google-Original-Date: Tue, 19 Dec 2023 10:06:47 PST (-0800)
Subject:     RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
In-Reply-To: <OSZPR01MB70195C6084CF2CDA5EE13D68AA97A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
CC: Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
  prabhakar.csengg@gmail.com, geert+renesas@glider.be, Atish Patra <atishp@rivosinc.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, apatel@ventanamicro.com, alexghiti@rivosinc.com,
  Bjorn Topel <bjorn@rivosinc.com>, suagrfillet@gmail.com, jeeheng.sia@starfivetech.com,
  petrtesarik@huaweicloud.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Message-ID: <mhng-378700ef-2f59-431a-bba6-2c70e0584738@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 09:27:42 PST (-0800), prabhakar.mahadev-lad.rj@bp.renesas.com wrote:
> Hi Conor,
> 
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel.org>
>> Sent: Tuesday, December 19, 2023 5:18 PM
>> To: Conor Dooley <conor.dooley@microchip.com>
>> Cc: Lad, Prabhakar <prabhakar.csengg@gmail.com>; Palmer Dabbelt <palmer@dabbelt.com>;
>> geert+renesas@glider.be; Atish Patra <atishp@rivosinc.com>; Paul Walmsley <paul.walmsley@sifive.com>;
>> apatel@ventanamicro.com; alexghiti@rivosinc.com; Bjorn Topel <bjorn@rivosinc.com>;
>> suagrfillet@gmail.com; jeeheng.sia@starfivetech.com; petrtesarik@huaweicloud.com; linux-
>> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org; Prabhakar Mahadev Lad
>> <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
>> 
>> Hey,
>> 
>> On Thu, Dec 07, 2023 at 01:11:23PM +0000, Conor Dooley wrote:
>> > On Thu, Dec 07, 2023 at 01:02:00PM +0000, Lad, Prabhakar wrote:
>> > > On Wed, Dec 6, 2023 at 2:26 PM Conor Dooley <conor@kernel.org> wrote:
>> > > > On Wed, Dec 06, 2023 at 04:52:11AM -0800, Palmer Dabbelt wrote:
>> > > > > On Thu, 10 Aug 2023 02:07:10 PDT (-0700), Conor Dooley wrote:
>> >
>> > > > > > I'm perfectly happy to drop this series though, if people
>> > > > > > generally are of the opinion that this sort of firmware workaround is ill-advised.
>> > > > > > We are unaffected by it, so I certainly have no pressure to
>> > > > > > have something working here. It's my desire not to be
>> > > > > > user-hostile that motivated this patch.
>> > > > >
>> > > > > IIUC you guys and Reneas are the only ones who have hardware
>> > > > > that might be in a spot where users aren't able to update the
>> > > > > firmware (ie, it's out in production somewhere).
>> > > >
>> > > > I dunno if we can really keep thinking like that though. In terms
>> > > > of people who have devicetrees in the kernel and stuff available
>> > > > in western catalog distribution, sure.
>> > > > I don't think we can assume that that covers all users though,
>> > > > certainly the syntacore folks pop up every now and then, and I
>> > > > sure hope that Andes etc have larger customer bases than the
>> > > > in-kernel users would suggest.
>> > > >
>> > > > > So I'm adding Geert, though he probably saw this months ago...
>> > > >
>> > > > Prabhakar might be a good call on that front. I'm not sure if the
>> > > > Renesas stuff works on affected versions of OpenSBI though, guess
>> > > > it depends on the sequencing of the support for the non-coherent
>> > > > stuff and when this bug was fixed.
>> > > >
>> > > ATM, I dont think there are any users who are using the upstream
>> > > kernel + OpenSBI (apart from me and Geert!). Currently the customers
>> > > are using the BSP releases.
>> >
>> > That doesn't really answer whether or not you (and your customers) are
>> > using an affected version of the vendor OpenSBI?
>> > The affected range for OpenSBI itself is [v0.8 to v1.3).
>> 
>> Did you perhaps miss this mail Prabhakar?
>> 
> Oops sorry for that.
> 
> I can confirm the BSP version used by the customers is v1.0 [0].
> 
> [0] https://github.com/renesas-rz/rz_opensbi/commits/work/OpenSBI-PMA/

OK, so sounds like would end up with broken systems from this bug, then?

IIRC we still have the Renesas systems as NONPORTABLE due to that DMA 
pool Kconfig conflict.  So if it's really only these Renesas systems 
that have the bug, maybe we can still remove hibernation from 
NONPORTABLE and just add in some sort of Kconfig to disable the 
Renesas+hibernation combinations that would break?

> 
> Cheers,
> Prabhakar

