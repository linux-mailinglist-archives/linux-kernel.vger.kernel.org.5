Return-Path: <linux-kernel+bounces-149277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81258A8EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638BA1F21FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293214037F;
	Wed, 17 Apr 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWHKkFQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC622338;
	Wed, 17 Apr 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391821; cv=none; b=qXCtQL4QtD8WuxJajQEujTh4orEiD8msvKEZaCo6pW16WESZGh1rr+iDrw2wzuIphyKVEY+FUV4YPMNIVrKGdVZVqf/SJbApPb9hwIoro5SCB/7MNcdFLoowbriMrj12mXzUtOZZ2uTRQlGMnIRXvjCSVyW/nQa1coFzkJeLV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391821; c=relaxed/simple;
	bh=7Z20tbLxC5O4ltU3plGgmWQIn5Hvd3ptzRJFvtnJm7A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WRRDSTizg1VmrrAur746RJSEDkOXc7y+4RGxd5HcxfegBlAdfDomWEA9ct2VkrGMUrZT7p8SQcWWsFY0/Qtcf58F7Gd0K9KxXOVqJHSfEzwp2PjEplsnoqtCPYHTrlzXhEIA2SA1tZ9bWap/vgxu37pVd0SCGeV0okiPYkrkjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWHKkFQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9EFC072AA;
	Wed, 17 Apr 2024 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713391821;
	bh=7Z20tbLxC5O4ltU3plGgmWQIn5Hvd3ptzRJFvtnJm7A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZWHKkFQPTmNqpUCBVBhdAyFSvX4ytbFsy9UsBDAt+xa5qq6GTH9KATPc1tezaCVMQ
	 e98oLS8rOZ3L6CPNPHib8za3LukWgNmTDlAv60TTVMx/uQFklhXmij440/UP98+kxQ
	 0ikGQH1LtCAKhRZqHnqprF2R9KzLNxoTU+lcMXIwaqfS8kpTO44n3qAHVrd1dMe8Ep
	 GpBcE16GeN7mdtLy3TXA03pM2/SKKKGdIAlQjckfJi4jPYhiK97KEtC3ruum1l5Eh1
	 YuLafqMistqPiKwIXYSVz383Cp80DZRdM+9GMcj/YBNchHcGRvIPtPvbGjF0GQa1P8
	 ZNyw21arSuw5Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 01:10:17 +0300
Message-Id: <D0MQPITI39QG.6OBIUUUL3AQA@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
 <patches@lists.linux.dev>
Subject: Re: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
 <D0MIG62V6JNV.3OZB5M1T63T7@kernel.org>
 <SJ1PR11MB6083CC350A16FED86B109C81FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CC350A16FED86B109C81FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed Apr 17, 2024 at 7:38 PM EEST, Luck, Tony wrote:
> > >  #ifdef CONFIG_X86
> > > -   return ((boot_cpu_data.x86_model =3D=3D INTEL_FAM6_ATOM_AIRMONT) =
? 1 : 0);
> > > +   return ((boot_cpu_data.x86_vfm =3D=3D INTEL_ATOM_AIRMONT) ? 1 : 0=
);
> > >  #else
> > >     return false;
> > >  #endif
> >
> > Thanks!
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > You want me to pick this?
>
> This depends on patches 1,2,3 in this series. Boris may be applying those=
 to TIP soon.
>
> Are you Ok with this patch also going into the TIP tree to keep all the p=
arts in sync?
>
> Otherwise it can wait until this moves from TIP to Linus. I'm not in a gr=
eat rush.

I don't mind Boris applying this. It is very unlikely to cause any
possible merge issues with other patches.

>
> -Tony

BR, Jarkko

