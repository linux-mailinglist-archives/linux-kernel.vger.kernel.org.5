Return-Path: <linux-kernel+bounces-156901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25DE8B0A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25289B22DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651C15B128;
	Wed, 24 Apr 2024 12:54:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB96134A5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963247; cv=none; b=A3gETHMXFQlMIv3e5ZBddsPhMo+0tdLtdYrU0z7HDGhRAm/poEkpOWDWflXPz65AjjMnC99J92k9z6bUQ0VP4PsjqZtyFzC69+kfDqFggut47WUlGnuNAU2D2j7jwnFj5RBhtZemqi8kkvvrL2VtxwytAFEFgRq0pfGrEkw0Sao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963247; c=relaxed/simple;
	bh=RW2L08j1RqQ+8tqNu36J8/94KbnD6n5HU+j41v6iJn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkHH6cwBFK0nkNtoGlRqtr09avfCBA/ttsutwOzpDoUOm/Nuc40K4oe2uq+YqYpGTjKErLAUGSZxrO/lziAUpLGQLOir9TMfZ/EJVMWJH9SpDAvcpSoTxRAg+xoat99OK8UsPtS4ZMSqo/bHhYRRMtRTLsNp9o99TghCzerjZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21EB11516;
	Wed, 24 Apr 2024 05:54:33 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4DB3F64C;
	Wed, 24 Apr 2024 05:54:03 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:54:01 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Sudeep Holla <sudeep.holla@arm.com>, julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] drivers: use __free attribute instead of of_node_put()
Message-ID: <20240424125401.oxvt5n64d7a57ge3@bogus>
References: <20240419140106.3mkayxriqjt2cz5i@bogus>
 <20240422130931.176635-1-vincenzo.mezzela@gmail.com>
 <20240424103756.jhloae3fcyinyba4@bogus>
 <d677360a-0f97-412c-8563-1def406061bd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d677360a-0f97-412c-8563-1def406061bd@gmail.com>

On Wed, Apr 24, 2024 at 02:42:16PM +0200, Vincenzo Mezzela wrote:
>
> I'll fix the misalignment and the checkpatch.pl warnings and send an updated
> version.
>
> Furthermore, would you like to see this patch split in two patches where:
>
> - patch 1 reorganizes the content of the loop using "if(!t) break;" instead
> of having the "if(t) { all for body }";
>
> - patch 2 gets rid of of_node_put;
>
> This might be better than having both the reorganizations in the same patch.
>
> Please let me know what would you prefer.

I am fine either way. Splitting might help in the review for others.

--
Regards,
Sudeep

