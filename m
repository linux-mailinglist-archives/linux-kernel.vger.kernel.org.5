Return-Path: <linux-kernel+bounces-15841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1782342A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC00286C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726951C696;
	Wed,  3 Jan 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+p0Fx1l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933CB1C68C;
	Wed,  3 Jan 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3080787a12.3;
        Wed, 03 Jan 2024 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704305801; x=1704910601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uumraeqLsr2lYf5i74U7JAgU/UNRCFo3U3jeL0oqQzo=;
        b=B+p0Fx1lqMgw9hIN42LrOIleRg47LrzkbJhd+ekrwb37E7RLllezL+4JMByuRE9vzt
         NoMyVIkbfSHJuLV5G5XgdHmvppWQZ35gHk97PSHcAHSIDgXYpR7PL7ENqDUqG4h7i7yL
         BlsC/A5qtgc3hVNuha1OS04iLRIa7AW4ZXhBgwHMnK0EpY7IjUZxkLti/Tt76AHLKxZx
         55vs5xk+w/r36tUzCfkfCCA6XYYt+RmH/DC+zoaMoLsgZ8GBUtArEsJvTdC7Dk5O/qDN
         dBpiJMFZv5naXi8pNDwbsU7SCU8GMUndZNlC/UGtFLP3DXaiOy2IoqZAryf0s7jWkyK5
         7gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305801; x=1704910601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uumraeqLsr2lYf5i74U7JAgU/UNRCFo3U3jeL0oqQzo=;
        b=uW9uG7/y/sP70iNYOvU5J8vIYfjrFRbSkVpYVg5Ew/CIlIxZjtGOegHitr9wEduAMX
         4oI1VsJ/ZPUULPlz72zquKdYW2kWNq8AknV9+zgc9AKPio6MeYsHPCNWxjsUMScAtR4h
         VsheozQSMG/jiKQ4uN/UAhWnJvVlCxhm+Kpi7LhqbmojqzzqTS07I9bSwWZ9P9iwnouD
         VjAvkPhZ79YGz5cff2EROHPF8/nrEzAFwJSDy2hInfkNqk9WQJPuFbeT4EHDE2eP8DhI
         IkOMN5sRIHfd5K5GNDzPiESrnnKPSY7Akxv+xMz0Gn0rVRVj/s9W8X2mH+F0KyH3KIr4
         Ix6A==
X-Gm-Message-State: AOJu0YwCBQeu4ntXQUFzX0yBEjiLoMWLH0v1q7qZ3P0wUBnhPcyLk2IT
	5r6vxTcSdsryr7Ar/WzUyRYA+319XpI74g==
X-Google-Smtp-Source: AGHT+IFbrNrWh744ukhvuIJvNBRk8q07YX7qKiTp8NDJFFroVwlad6rHVCsw6FswhMTHaFTSu5rf5g==
X-Received: by 2002:a17:903:645:b0:1d3:68ee:d958 with SMTP id kh5-20020a170903064500b001d368eed958mr8544492plb.107.1704305800708;
        Wed, 03 Jan 2024 10:16:40 -0800 (PST)
Received: from fedora (c-24-4-59-2.hsd1.ca.comcast.net. [24.4.59.2])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001d46b2ec6a5sm15809732pll.192.2024.01.03.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:16:40 -0800 (PST)
Date: Wed, 3 Jan 2024 10:16:37 -0800
From: Tao Ren <rentao.bupt@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	Andrew Jeffery <andrew@aj.id.au>, taoren@fb.com,
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org,
	Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook
 AST2600 Network BMCs
Message-ID: <ZZWkhaiDFOGvcPQy@fedora>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-4-rentao.bupt@gmail.com>
 <20231220081402.GA3831@wunner.de>
 <ZZSmMJ//l972Qbxu@fedora>
 <20240103124502.GB23899@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103124502.GB23899@wunner.de>

Hi Lukas,

On Wed, Jan 03, 2024 at 01:45:02PM +0100, Lukas Wunner wrote:
> On Tue, Jan 02, 2024 at 04:11:28PM -0800, Tao Ren wrote:
> > On Wed, Dec 20, 2023 at 09:14:02AM +0100, Lukas Wunner wrote:
> > > On Thu, Aug 05, 2021 at 03:28:15PM -0700, rentao.bupt@gmail.com wrote:
> > > > This common descirption is included by all Facebook AST2600 Network BMC
> > > > platforms to minimize duplicated device entries across Facebook Network
> > > > BMC device trees.
> > > [...]
> > > > --- /dev/null
> > > > +++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
> > > [...]
> > > > +		tpmdev@0 {
> > > > +			compatible = "tcg,tpm_tis-spi";
> > > 
> > > What's the chip used on this board?  Going forward, the DT schema for TPMs
> > > requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".
> > 
> > Sorry about the late response. It's "infineon,slb9670", and I will
> > submit a patch for fix it soon.
> 
> Thank you Tao and Patrick for the replies.  I've prepared two commits
> to fix all violations of the TPM schema on this branch:
> 
>   https://github.com/l1k/linux/commits/tpm-dt3
> 
> The commits are named:
> 
>   e95bdbc arm64: dts: Fix TPM schema violations
>   63e5dfd ARM: dts: Fix TPM schema violations
> 
> I've now amended the ARM commit to use "infineon,slb9670" for:
> 
>   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
>   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
>   arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> 
> I intend to submit the two commits once the TPM schema is applied
> either to Jarkko's or Rob's tree:
> 
>   https://lore.kernel.org/all/20231220160422.GA282877-robh@kernel.org/
> 
> Thanks,
> 
> Lukas

I've confirmed it's "infineon,slb9670" for both wedge400 and
ast2600-facebook-netbmc-common.

Pleasr free to add to "63e5dfd (ARM: dts: Fix TPM schema violations)":

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>


Cheers,

- Tao

