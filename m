Return-Path: <linux-kernel+bounces-122070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0116388F17E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A56B225C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCEA153592;
	Wed, 27 Mar 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="2k/G9K3b"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4331152DEA;
	Wed, 27 Mar 2024 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576985; cv=none; b=hJrzHmlMrX1CkP9TSWWV+HnyXZScACUsQN7LA6jbp5XiDDas0CGKs53LTThoLwjhKuOHD5sg86tOz0C1ZhJpQGA+Wc+8IQ0pf5seazNwoAI5okXRjybtNuOu/dMuNTbLQGaOzO6Dw+/ZuUbK/IRbvaPgO0IQJ1AhlOFUUXYqMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576985; c=relaxed/simple;
	bh=jWuwm3yCgWB03ubkJNtntvlEINaAcsVYw2MymxzZJXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivzXre2XY4NnSEMaGB1DF1opS+NKsKpVirla7h9Rk4AmSb1HKlOSvyZr+XkSzA1KTmPl1iCLTSSVUQwuET9J0qyUV92jOSNjt7X3EXtoYpBbIYGNdH60kKUlD+G9BaCM0rBN7MdO/4vOhGtwXr8MnMCfYIkKki6MXtyjp4acc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=2k/G9K3b; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpbMF-003TPG-2H;
	Wed, 27 Mar 2024 23:02:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y17hiGV996+K4S6RfRDWuHMPAgyJsgUU6fhOvr2veRY=; b=2k/G9K3bKAvRmY6dLbnym1BSKH
	EbJG7puEXJVi6XDdnORN9kppspA6MC55GFlNfvPGHYuOCVZbc4mpoJTR9t+H+ZI1cm1126N/WRjQA
	vL30FvDVoVGmGaHAb4pWqagow2GIxtGhNj3NdogjazQnWqOJbTpe1iNUV566Q2L/0+o7A8Eon6WJf
	Qi28Sg9ze2CVAF2R1WVD4d/KYDFJcpS76naLVNfpiRiIGARYX02qXF9g1ry2vrVL9w4VhLley97E2
	fSXt6WMyX+yrIyki+KooKxzQyWEN4HwQBYaNiwvUWaRQ3AiIJhybUgPd4U1atEvBGmuux9ghWN6eA
	i5Kyo8Fw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rpbMD-0005O0-2K;
	Wed, 27 Mar 2024 23:02:54 +0100
Date: Wed, 27 Mar 2024 23:02:52 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240327230252.0535e895@aktux>
In-Reply-To: <c6f5a515-61a1-4d87-a029-4000fa96f10e@gmail.com>
References: <20240326192258.298143-1-andreas@kemnade.info>
	<20240326192258.298143-3-andreas@kemnade.info>
	<815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
	<20240327140451.65ff8e18@aktux>
	<c6f5a515-61a1-4d87-a029-4000fa96f10e@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matti,

On Wed, 27 Mar 2024 16:11:36 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 3/27/24 15:04, Andreas Kemnade wrote:
> > Hi,
> > 
> > On Wed, 27 Mar 2024 09:32:29 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> It's worth noting that there is another PMIC, BD71879, which, from the
> >> driver software point of view, should be (almost?) identical to the
> >> BD71828. I believe the BD71828 drivers should work with it as well - if
> >> not out of the box, at least with very minor modifications.
> >> Unfortunately I don't know products where the BD71879 is used or if it
> >> is sold via distributors - so I don't know if adding a DT
> >> compatible/chip type define for it would be beneficial.  
> > 
> > yes, you already told we thet the BD71828 drivers are compatible with
> > the BD71879 and I am using the latter.
> > But that at least should be commented somewhere, so that
> > people do not raise questions, like: Do I have some strange board revision,
> > etc?
> > The most terse form to comment it is a separate dt compatible so we are
> > prepare any "almost identical" surprises.  
> 
> I agree. Reason why I haven't done this already is that I don't always 
> (like in this case) know which of the variant are eventually sold. So, 
> it's balancing dance between adding compatibles for ICs that will never 
> been seen by large audience, and missing compatibles for some of the 
> variants.
> 
> This is also why I was interested in knowing which variant you had, and 
> where was it used.
> 
I have found it in the Kobo Clara 2E ebook reader.
Kobo seems to switch from RC5T619 to BD71879.
The Kobo Nia rev C also has that one.
Kobo Libra 2 has several hardware revs out in the wild, some of them
with the BD71879.

> But yes, I think that as the BD71879 has obviously been found by a 
> community linux kernel user - it would make sense to add a compatible 
> for it!
> 
> Do you feel like adding the compatible 'rohm,bd71879' in 
> rohm,bd71828-pmic.yaml as part of this series(?)

Do we want a separate chip_type now? Or do we want to add it later if
we ever see a difference. My personal opinion is to wait until there is
really a need.
If we do not need it, then it is a different series I think but sure
I will produce such a patch.

Regards,
Andreas

