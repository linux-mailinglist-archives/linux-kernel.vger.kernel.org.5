Return-Path: <linux-kernel+bounces-66386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856D855BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B001F21C37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1512B87;
	Thu, 15 Feb 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PACGvz0u"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C41DDDC;
	Thu, 15 Feb 2024 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984471; cv=none; b=p0Iu4NfND4orD+UAofP67DY0uw/9y628UeHx134Br7e/XHy3/8nGQ2eyN8eHdQMq4VjE7aB0DiKieleXk0umE/xU/KAQNYlUUOxyr7SDpCpRT9ZtkFp9l41ryNv/ud2n1O3SXwbXqyOibwsKddI2UcrhsOM23qUYk3K8nIYGQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984471; c=relaxed/simple;
	bh=7yYMt2oSXZoV2EPsQzgkcYnovurqdAcjtyiA0yDXkLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5mWqK/xqoqlaH5GXpOp3eepX89cvFIbuGQ50NGL8brH1nZ521eo1e0vqpVRThXfCZ/qrMraYncfXsy+V7aJRzvFiQgBP3YrRdwSiZbMMbNanIkH2se+TWElYvm7Mg3NJZINPYmZowuC2CJ6z6B7ZBtBRhqBQ8tmG+Y+qNbBlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PACGvz0u; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707984469; x=1739520469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yYMt2oSXZoV2EPsQzgkcYnovurqdAcjtyiA0yDXkLY=;
  b=PACGvz0uH9pP0UJ2CSprG9vU1A6yMXbxDP9umDTGiJK+FWe1eIJOW0RG
   PVGB1MJGR22YKttiAw4S6mpS8HFbn6fV3cXfDtpGD/lrHZzmtX0Z3bVUw
   wOXQFhaLICY49o3qelNArSqmNRD1szJRP+9MI0xU0M8AmS9YRyUDhyAJT
   CMBM8yp2Gvb3v1A9rmICKMR1i6cIe2m6PJdT6MpsKuCsT8RMGSiydlPDU
   LVXHdQi7Qs8RtV1o919SCWtPjhRFSquUXzLr+EMCmTy0cF9P/N3OU6tdL
   G+JJ3O12u93Qwn4iOfSm0KDA14bb3UcVpmyah6bUxGZu2yoIqW20v6kCQ
   Q==;
X-CSE-ConnectionGUID: EtHR5lSFTvKxfzaNENlYXg==
X-CSE-MsgGUID: XAe0vKyHQF6MdQRkzmwP/w==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="247017844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 01:07:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 01:07:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 15 Feb 2024 01:07:43 -0700
Date: Thu, 15 Feb 2024 09:07:42 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Florian Fainelli <f.fainelli@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <u.kleine-koenig@pengutronix.de>,
	<rmk+kernel@armlinux.org.uk>, <vladimir.oltean@nxp.com>,
	<jacob.e.keller@intel.com>, <yuehaibing@huawei.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: sparx5: Add spinlock for frame
 transmission from CPU
Message-ID: <20240215080742.t2yswxegwob34ouy@DEN-DL-M31836.microchip.com>
References: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
 <5476743f-3648-4038-97f8-a9df22c0f507@gmail.com>
 <20240214081442.w533wvcvqpvq5352@DEN-DL-M31836.microchip.com>
 <20240214070908.37b49ddf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240214070908.37b49ddf@kernel.org>

The 02/14/2024 07:09, Jakub Kicinski wrote:
> 
> On Wed, 14 Feb 2024 09:14:42 +0100 Horatiu Vultur wrote:
> > > Any reason you targeted 'net-next' rather than 'net', as this appears to
> > > be clearly a bug fix here?
> >
> > Yes, it is a bug but it is not something that happens all the
> > time and I thought this fits more into the lines of 'This could be a
> > problem ...' therefore I had targeted 'net-next'.
> > But if you consider that I should target 'net' instead of 'net-next' I
> > can do that.
> 
> Definitely a bug fix worthy of net, yes, please.

Perfect, I will do that.

> 

-- 
/Horatiu

