Return-Path: <linux-kernel+bounces-111158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E516288687D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858B41F215AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C941A29F;
	Fri, 22 Mar 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8CNUMnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="isbvmZQJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8CNUMnj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="isbvmZQJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5D19452;
	Fri, 22 Mar 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097387; cv=none; b=i6NGHouzsRCkhLaQDe3BnYpgwwOVICqwyFC1EQGdxArzOhBcpCwKFtvJ60Rw4gTiygs+Q1lKTHYvJuyhpKtuOfzo7EXLNv6X3kGEJrtzGZap6VhvuQGp6j9MKwfAHp7ocS9Ug3buic6uE9vuTT7Tkvve8CGIwWKRLILKtzmxRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097387; c=relaxed/simple;
	bh=Rus4EOlYjpMcjkHVpN+7Cwqd1GjzJuQxBDkGG/aunOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csYcT1BbFnWTREhTGKvqSuswm7ATlAe5xtTXMQKzwX1BqWRZuWC0dbdI0/H+GF1CLkOKUVlXwq86EdWv4zSiueDxNoH15rdhMoP5rIHnAA075c8csbjxIhCXJsPAqln/HfyYtS4yXMMnGAxdV1pRTKqVSf3FhawGATI7/x93hiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8CNUMnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=isbvmZQJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8CNUMnj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=isbvmZQJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47F8D382B0;
	Fri, 22 Mar 2024 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711097383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus4EOlYjpMcjkHVpN+7Cwqd1GjzJuQxBDkGG/aunOE=;
	b=y8CNUMnjl7AtHfrpc0fCXd2UwyPa4Ub748sc5+GmKAVam87psdAIPAC7ikpP5+eNbW7kHV
	nJQ/ucT/uxS5CUGdqtjhIrd2jWWSa7bqB0zuCGGAMQo5mseCdrFm8s8d2Dv2EPwi6lXfst
	e9b/S8vyVN3RndrdOX/3WFH60+l0HuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711097383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus4EOlYjpMcjkHVpN+7Cwqd1GjzJuQxBDkGG/aunOE=;
	b=isbvmZQJNTnQ8jY7mycgQAJVRRIpIj2W+R+OvPTNzi0y/6D5y08b+GP73P30B7zP6HOvDg
	p7WTxlqS90PS4DDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711097383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus4EOlYjpMcjkHVpN+7Cwqd1GjzJuQxBDkGG/aunOE=;
	b=y8CNUMnjl7AtHfrpc0fCXd2UwyPa4Ub748sc5+GmKAVam87psdAIPAC7ikpP5+eNbW7kHV
	nJQ/ucT/uxS5CUGdqtjhIrd2jWWSa7bqB0zuCGGAMQo5mseCdrFm8s8d2Dv2EPwi6lXfst
	e9b/S8vyVN3RndrdOX/3WFH60+l0HuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711097383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus4EOlYjpMcjkHVpN+7Cwqd1GjzJuQxBDkGG/aunOE=;
	b=isbvmZQJNTnQ8jY7mycgQAJVRRIpIj2W+R+OvPTNzi0y/6D5y08b+GP73P30B7zP6HOvDg
	p7WTxlqS90PS4DDw==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 332CF2013C; Fri, 22 Mar 2024 09:49:43 +0100 (CET)
Date: Fri, 22 Mar 2024 09:49:43 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Jiri Pirko <jiri@resnulli.us>
Cc: gaoxingwang <gaoxingwang1@huawei.com>, idosch@nvidia.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <20240322084943.5xodsuxt45jr5l3l@lion.mk-sys.cz>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
 <Zf09wW36JcpObTPC@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ukcioxpoksvkjmav"
Content-Disposition: inline
In-Reply-To: <Zf09wW36JcpObTPC@nanopsycho>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_SHORT(-0.18)[-0.900];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 SIGNED_PGP(-2.00)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 BAYES_HAM(-0.16)[69.36%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.96)[-0.962];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com]
X-Spam-Flag: NO


--ukcioxpoksvkjmav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2024 at 09:13:53AM +0100, Jiri Pirko wrote:
> Please make clear indication which project/tree you target with your
> patch by putting appropriate name in the [patch NAME] brackets

In this case, it should be "[PATCH ethtool]".

Michal

--ukcioxpoksvkjmav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmX9RiIACgkQ538sG/LR
dpV54Qf9FtN1QlHG75yHE/hJz2aF1y3i5z0dOYv9E3lxYq+FZCZiJmupSZ8oprnw
uU9WgpCodagxtfKvO3g9XQjAEe/wljfpoVebyHoKumDqQIh7RRUaVbPy1Vb+3I+J
c/JrDUVGj5n360v0iFYVA6RP4Ss8dQRTLzVkZImrkuvMPP+Pw/+xENFHGrGRHca3
1avhqxI3ypvNsA17+f9Nek4TRC+eGA/5JD28dW3LVshetkOmwFuyhauV++Cn/Yb/
m+AiPuO+71cYNiMUgFbmhlu7Qe2pyGCPzW6nDQ75zi4il6dEJZ2szlUQOIWcdWH4
h7MbPIvU4WHO16edrDyRUrZwGodz3A==
=94wM
-----END PGP SIGNATURE-----

--ukcioxpoksvkjmav--

