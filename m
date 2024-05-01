Return-Path: <linux-kernel+bounces-165172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CD8B890A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F39C1C235F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D16657304;
	Wed,  1 May 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="oF/s9RQi"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3748CE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561879; cv=none; b=hWv67ft18W7458vwtVNye/Npyox2CfVujuKrGLf8wJhH12axVbI/bb2vkirOx2EO+Y1A7cGlQEpJh3viFsFVCS2/Elr0rrwD+w+dz82csdsJ/NCqpSOtBxt312ol389xDq/xRVE6o2u1mDr61SIIhSjGYdbJokMBPfs+Yxl7rI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561879; c=relaxed/simple;
	bh=WKvJ4yQ7gTqMARA10nfWHeuid0LSjbzkk5i1ci2lX+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEnST/1PLH+zIF1OqcsnqVUOpQf7V38WFl6GukCg0jXVQpk8KU785UlprYOvUW7YiRpjicoh5BBVXi31FTNhd5425Y9WXHt06JFG1NdhUtKSb0wI0J2pRUAojCqfuMZiZdGnUNyZLnqB8cOASyV03ELtYXw1rlzNOxgfTINGaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=oF/s9RQi; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714561875; bh=WKvJ4yQ7gTqMARA10nfWHeuid0LSjbzkk5i1ci2lX+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF/s9RQiL9DBVW2xFZ4zfi1Z/wY9L3BCPxdb2JBfAFgQztNB3g8mZjgnSECJdlJgq
	 xdaYyWM3qvm4ZH0HiAW7Cv++7HAprQiuRUWzK6hdZaBtO270Ft8IqxIdR/abWLKKun
	 lemlTeFBLCTEsG+87g1cLHSBl9PY0S8FOTb77JYvZr3xbDmD/++i0+KsnRx+115kNc
	 UmhDxwryECrLi4WdBmUuL1z6Fj4wo7Aj8zqYgp11y8WKMVeMWzp7qpY7b/p6rwAD3v
	 prrJ39OW2n/gzoHNodoR0DlHQIZLK6pnPuROSa2suzKNicwxCBCeQ+3xYKADM3GTpN
	 ++9Pv1pOYPZbw==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VTvWl5K84zBL;
	Wed,  1 May 2024 13:11:15 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Wed, 1 May 2024 13:11:14 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: kernel test robot <lkp@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] regulator/core: use rdev->dev.driver_data
Message-ID: <ZjIjUiTPenTPXMaO@qmqm.qmqm.pl>
References: <0a480abe4913f0169f9693f6f959fbe1a397ae93.1714399603.git.mirq-linux@rere.qmqm.pl>
 <202404301218.URkWO6dj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202404301218.URkWO6dj-lkp@intel.com>

On Tue, Apr 30, 2024 at 12:53:02PM +0800, kernel test robot wrote:
> Hi Micha³,
> 
> kernel test robot noticed the following build errors:
[...]
>    drivers/pinctrl/renesas/pfc-sh73a0.c: In function 'sh73a0_vccq_mc0_endisable':
> >> drivers/pinctrl/renesas/pfc-sh73a0.c:4027:33: error: 'struct regulator_dev' has no member named 'reg_data'
>     4027 |         struct sh_pfc *pfc = reg->reg_data;
>          |                                 ^~
>    drivers/pinctrl/renesas/pfc-sh73a0.c: In function 'sh73a0_vccq_mc0_is_enabled':
>    drivers/pinctrl/renesas/pfc-sh73a0.c:4060:33: error: 'struct regulator_dev' has no member named 'reg_data'
>     4060 |         struct sh_pfc *pfc = reg->reg_data;
>          |                                 ^~

A patch for the driver coming in v3.

Best Regards
Micha³ Miros³aw

