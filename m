Return-Path: <linux-kernel+bounces-88186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2964786DE50
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D474C1F280EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5606A8B2;
	Fri,  1 Mar 2024 09:32:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47F6A35C;
	Fri,  1 Mar 2024 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285523; cv=none; b=Irvn0ZFIdrpvWt9NMJq5gSRvBVE59I1lsUqNZCR+RdfVUazZPB43f8fkx62fr24He7WgMOxCJY1QLNmNQmY0Z2E6LV+qszqglMe5FqXQlnSpk0NDErQd0JxlSKK6fqxuKTsdbUL5Jx8JdFmPb+linz6lmmmsdPOq/VWuu67Ulzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285523; c=relaxed/simple;
	bh=k9i8rJ7Ge2FeFZOsQ8ywHxiOYkWVHKe0l76fgYSB6CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuZoCUv5AafablWIsFgD6XAdBan9z44lReC5K1fDzQUY1Tlyw0QpOTSVcuxpZwdC6QcqcMpZr76IVOtk4sri3CCcjzoVqn+RnwIlyAUF9sk8Itt630I9rcF2N7ykD5JJmu2Tyf/FNzDrmB3imqbloQYvSLVU62ASmpCtyroCmjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819451FB;
	Fri,  1 Mar 2024 01:32:38 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E42E43F762;
	Fri,  1 Mar 2024 01:31:58 -0800 (PST)
Date: Fri, 1 Mar 2024 09:31:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: arm,scmi: support system power
 protocol
Message-ID: <ZeGgjL6TkEdIHgzq@bogus>
References: <20240226130243.3820915-1-peng.fan@oss.nxp.com>
 <ZdyR_MWeqOWga8iQ@pluto>
 <ZdyoAsYGXK9GjHVx@pluto>
 <DU0PR04MB941710FB1400D0A17F99B6ED88592@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeCNyLxQOIazc07h@bogus>
 <DU0PR04MB9417C06FD66182C705238662885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZeGJIvk_LqglqdBa@pluto>
 <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417EAC31D3D7EC716A66C05885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Fri, Mar 01, 2024 at 09:22:24AM +0000, Peng Fan wrote:
> " Ignoring unsupported system_state:" we have new defined
> number here.

Why ?

-- 
Regards,
Sudeep

