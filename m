Return-Path: <linux-kernel+bounces-74262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EBD85D1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5601C1F26C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DC63B2BB;
	Wed, 21 Feb 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na7ZfenU"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A5F3AC26;
	Wed, 21 Feb 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501863; cv=none; b=fkVzDIFlzAjgsV45toAOKpWmIdiGSx33t41DKO4bNGD9HXFmc+sO+zW9VGvnC98VNkLXlFU5ME09ALGO08NtCr8okb+LkjOzEC2eGTnUkRm7eiwllFlGVjoPKER2AfQTzHzL7gdR7onkPtp2E6hHDKCXssXmLGPXl/GgdUvILnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501863; c=relaxed/simple;
	bh=WMEVPRk/cMv9MwbUdnJDZQNfMyeamxwLXtEaC9Nkglg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIGARl/pLUIzwjXiio2HPoVZB64md/HnHa5LHNkG6je6xElBv5ZBG3W4xYyOvVHH4TxOozji3jOgAclv/4v/xGnlKFJStYejM6JWEayo0xPQR8lQH/JSVR+mI/sSqLrczrjxCq2+bp/h9WhSTWhZJUiJT4qKFDuTgdGmxTdHmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na7ZfenU; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd72353d9fso4722303b6e.3;
        Tue, 20 Feb 2024 23:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708501861; x=1709106661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WxYfPd5VUxR2AqwN/E1W/Qk2rLQTXMyaj5oNoN/9CA=;
        b=na7ZfenURI5j8c6yWx2v3wV7UjEFr03fWdPvu9cekMaPFsG68tbWsJSxep2vx9/uzl
         AQcT+I0feD2LyVME9Wmgw+FArgdO5+bq6R23wjVqaFKRjqiklNQcoCkgOI/RwUpueZ9L
         GqpnSGrFNWMuOxDmquDNEtsu3haAPr6tI/+jM1cusOb8fD5ewJZcOJ4UAvXlBKaqufiU
         ZYwS+pJptDkQ6bkB4ums5/ScFo677xQjEm5KQQLFwX7+A4IQUYD38wxH3jTlj1GWzOd0
         mNTylBkpHtJ83dYNuCu1RGT55gFv7XrSgzyqTlb3QCOaghHIj/R2M3S6xaD3/8zFAcuK
         j2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501861; x=1709106661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WxYfPd5VUxR2AqwN/E1W/Qk2rLQTXMyaj5oNoN/9CA=;
        b=SdxeWKKqrHp62L3QLrLPQ/sbNs89nsGNGFC3wzJV63TB31upiyVLZenlEDCiLr2v1f
         bGGHxSZjYIXKYTItKIZQv0TzhIWRf0q5FYlXervDb/1PH2mE7pJkPbtzBvbPJ1L+nbqS
         TGRB6Tb32xrPm7SEbIT7v4JtzDwrgItpGqsozEp2PkRYFMd8MFyasBQDSHoRwMOGdgIv
         DaFMMrC56DoZQw0DE8N2aAMQjbU+To1WZFolnk9UWM4fqo3tBAJJIQZ0mExJGnzNAzIj
         zAzmg2ZqB6DRi+ZGbHaxZL4BW7qQOqqcga5dPYtIhMvBjnk3VY1L5IpPorzlJGkCHXCG
         /VFA==
X-Forwarded-Encrypted: i=1; AJvYcCWQf9dowa4Uwkaw+tTpok78BCxdtUsrFJ3rvb93zomyPPXcup2CRN+ceP630heFed5NAh+Tv3MD5R6MR1+18qIGhHNVUP2H6uGBMQ3klxW3sFlZipqTyj+0Izxr8BDEv5w83oQ5
X-Gm-Message-State: AOJu0YxVX0//VGbEvHE9Tr74HWjq6OOxX4g4HVZ0kZ5bkzsHdxph3wJI
	Fdidu3D0mZQ51t22G1FW2/4cm4dBDLLK6st2RRdUYNpIaqnwzdyi
X-Google-Smtp-Source: AGHT+IEaot28fIQDjxTt1GFRY6aRRqnZycO4q4j9ERdRvkVxi8anzShk1jhdOtBwPQcD8Hi7xxnpxA==
X-Received: by 2002:a05:6808:220c:b0:3bf:f4bb:7630 with SMTP id bd12-20020a056808220c00b003bff4bb7630mr23413978oib.45.1708501861356;
        Tue, 20 Feb 2024 23:51:01 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id by41-20020a056a0205a900b005dc4ce8d2a4sm6745749pgb.58.2024.02.20.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:51:00 -0800 (PST)
Date: Wed, 21 Feb 2024 15:50:55 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next v5] bonding: rate-limit bonding driver inspect
 messages
Message-ID: <ZdWrXyQTfF_bMPCA@Laptop-X1>
References: <20240221050809.4372-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221050809.4372-1-praveen.kannoju@oracle.com>

On Wed, Feb 21, 2024 at 10:38:09AM +0530, Praveen Kumar Kannoju wrote:
> Through the routine bond_mii_monitor(), bonding driver inspects and commits
> the slave state changes. During the times when slave state change and
> failure in aqcuiring rtnl lock happen at the same time, the routine
> bond_mii_monitor() reschedules itself to come around after 1 msec to commit
> the new state.
> 
> During this, it executes the routine bond_miimon_inspect() to re-inspect
> the state chane and prints the corresponding slave state on to the console.
> Hence we do see a message at every 1 msec till the rtnl lock is acquired
> and state chage is committed.
> 
> This patch doesn't change how bond functions. It only simply limits this
> kind of log flood.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
> v5:
>   - Redundant indentation addressed.
> v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@oracle.com/
>   - Rectification in the patch subject and versioning details.
> v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
>   - Commit message is modified to provide summary of the issue, because of
>     which rate-limiting the bonding driver messages is needed.
> v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
>   - Use exising net_ratelimit() instead of introducing new rate-limit
>     parameter.
> v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
> ---
>  drivers/net/bonding/bond_main.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4e0600c..c8482cd 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2609,12 +2609,12 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			bond_propose_link_state(slave, BOND_LINK_FAIL);
>  			commit++;
>  			slave->delay = bond->params.downdelay;
> -			if (slave->delay) {
> +			if (slave->delay && net_ratelimit()) {
>  				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
>  					   (BOND_MODE(bond) ==
> -					    BOND_MODE_ACTIVEBACKUP) ?
> -					    (bond_is_active_slave(slave) ?
> -					     "active " : "backup ") : "",
> +					   BOND_MODE_ACTIVEBACKUP) ?
> +					   (bond_is_active_slave(slave) ?
> +					   "active " : "backup ") : "",

Why these lines changed?

Hangbin

