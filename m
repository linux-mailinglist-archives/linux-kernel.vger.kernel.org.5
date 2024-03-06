Return-Path: <linux-kernel+bounces-94257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A3873C11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3891F25BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D20137905;
	Wed,  6 Mar 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTVhAcGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F613665A;
	Wed,  6 Mar 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742152; cv=none; b=lOSWgN9KNpCjv2FSRtVVfrPmgGLzJzmt8m3ykPPH/NsV+iBYjyPm2NGOwS44ovoQGq7GZrJwSb836wulS2yxnCCWNdBTxJtV37UfUv5mfoy1WjVz2tdW0KaE/flIWE18wBNBlTFpEvcleCTsGO0VxvdM5sM8iBI5Bz6seqPXPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742152; c=relaxed/simple;
	bh=+KJTQZuaYF3wEiXcdWnySdEhubrnS47IojZ6kAGAEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGn542ZPm8UROgQTt3XNHxB7vgE8rCV2TMQJQu9h5U3GGmyJcFxvJow8k29GsbXjOn40GJtr+5su55lshDycm4QAzkLnuJnvoqxHZdxlCeYCwRY17jIe4Lb30n8nnlKahsFDs6bUcgXb2EK3htff2/tGKhop4siiTMRWjT1s7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTVhAcGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9864BC433F1;
	Wed,  6 Mar 2024 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742151;
	bh=+KJTQZuaYF3wEiXcdWnySdEhubrnS47IojZ6kAGAEHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTVhAcGJbBGD0bpjx8ho5NWpNNX8TWh2NOW/Qe5/qoDQQackrnQknXDrHwkvw5pqg
	 R+M/t7L4uHA3HQ9MM5707FBqWiipHmDcXasXyt5827bh/QpU1cXCTo33F01EYfdaoS
	 O9Wd9ohs77gNH+xobff95KyCyOlT8XUaE4IxR80fkwNPLoL0lDalbNm6L6G/PAIhcV
	 UkkV5oxoFhAChPXmdrYwRdZ/gzpkgjix/dd/Wq06dfmF69thX/tVDAAJo5UyloBDXl
	 rKNCZxUMRFj9/5KZZSpR2LIEAxy2ulsR6CL2bfmsNv1hATWvLXh5V41JJcCL7muIVm
	 mNoJqQsDGCxTQ==
Date: Wed, 6 Mar 2024 08:22:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>, Herve Codina
 <herve.codina@bootlin.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] net: wan: Add support for QMC
 HDLC
Message-ID: <20240306082230.7ecf207b@kernel.org>
In-Reply-To: <MWHPR1801MB191837C8907B39F67893F0BBD3212@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240306080726.167338-2-herve.codina@bootlin.com>
	<20240306105651.1210286-1-rkannoth@marvell.com>
	<20240306143743.5732b298@bootlin.com>
	<MWHPR1801MB191837C8907B39F67893F0BBD3212@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 16:01:48 +0000 Ratheesh Kannoth wrote:
> > > > +	struct qmc_hdlc_desc *desc = context;
> > > > +	struct net_device *netdev = desc->netdev;
> > > > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);  
> > > Reverse xmas tree  
> > 
> > The reverse xmas tree order cannot be used here.
> > qmc_hdlc depends on netdev, netdev depends on desc.
> >   
> ACK. Usually I get comments to split declaration and assignment for
> my patches in upstream. 

Yup, that's our general preference, to split the init out of 
the definition.

