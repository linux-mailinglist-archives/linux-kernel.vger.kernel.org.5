Return-Path: <linux-kernel+bounces-163436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A28B6ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA921F21AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29991BC56;
	Tue, 30 Apr 2024 06:49:32 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFC14A9D;
	Tue, 30 Apr 2024 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459772; cv=none; b=bKeSPbTs9ycZ2aQWIhVtC/JtXI3ElGn8tFNKzBVFiKdVmNWX2SoM/J4HuRCcmbte37BvJTO+1w34olNCcg/LBmFb80Flz6AonS5SpRxoKYi9CXjbnO8dnloAOcBtQjeit17IwUpQ3LfElCwJbuBJzWTFvL30kZk4kyszqR2/HAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459772; c=relaxed/simple;
	bh=wfXSPUnLh1VzrudqUMgb6UelKl+cTNK1wPZwDGzcO6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq/lDBPR7p7dqwsC9FlTpnj7VhRpcpTLiUQKgb7S9bw6Edx2uzcdS0C9ZnshLza5qVWdCM9yZP771Eif8dK87Z3kiPv1oBpRbpFejnqPVB9sotc7K+bO9eBPKCffXWDpRQu16UcqdnwpKkZaVUax7x26AJcRdeXKWtgznAh2+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.12.201] (g201.RadioFreeInternet.molgen.mpg.de [141.14.12.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AF12B61E5FE01;
	Tue, 30 Apr 2024 08:48:10 +0200 (CEST)
Message-ID: <a21672d7-82dd-44a9-b301-94aa1537b75c@molgen.mpg.de>
Date: Tue, 30 Apr 2024 08:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] modify Signed-off-by field
To: Kelly Hung <ppighouse@gmail.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Kelly Hung <Kelly_Hung@asus.com>,
 joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, Allenyy_Hsu@asus.com,
 linux-arm-kernel@lists.infradead.org
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240430045853.3894633-1-Kelly_Hung@asus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kelly,


Am 30.04.24 um 06:58 schrieb Kelly Hung:
> For the warning message:
> From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>'
> 
> I replaced Kelly_Hung@asus.com with my private Gmail account.
> 
> Due to a security issue with ASUS's mail server, I am unable to use
> ASUS's mail system to send patches out from my build server.
> So I executed git send-email using my private gmail account.

To put light on ASUS’ upstream work, using your company address would be 
nice in my opinion. Do you have it configured everything in git 
(`~/.gitconfig`)?

     git config --global user.name "Kelly Hung"
     git config --global user.email Kelly_Hung@asus.com

Then `git format-patch` and `git send-email` should put

From: Kelly Hung <Kelly_Hung@asus.com>

at the top of the message.


Kind regards,

Paul

