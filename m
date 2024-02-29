Return-Path: <linux-kernel+bounces-86394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0086C4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E391A1F239BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9835917D;
	Thu, 29 Feb 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qvyVbti5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFED58207
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198410; cv=none; b=cih5CKR3jcISu/HUcIHAcUic6/Bx6riX8/So8qJ2+gBOPrMRx9h4Vi2alXnT9EnNTwzbMvxUWJiqjbQYQgnq5Y8E90N25lNkSofU96ZesA8QUwp0Pe+qRslErIWIX3mR1gV7K5dxaO6rChRBBr/8dmSXaHrgTo9DsECmBUX4YfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198410; c=relaxed/simple;
	bh=9ld9CHJWAVfxgUOV9rgblXkoVNbUU8Ep4EODEe+gquw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnSeslt0uCwozqsMZivpl1ZqrbDjuY1+WHqkLoLBcKbrtSj2Wz0dfOM+d7Ogy64Zb1Xov95NZZNZ3xjDsCEiZi7VVONvoDXH3EwXF9nRc1Kaz62v79doOAoi6T/SJOuMKS0R+hs8lDIAilRDdSldF5ppaLV3wyLErdUnq5bLKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qvyVbti5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e706f50beso104690166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709198407; x=1709803207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WwQvPtrchQr55jMR6QmPbP1tMQ2V4TzDErrhsqCBXY=;
        b=qvyVbti5bozXCdsuTMBIZEahD6J3GQRWEwaJu5AKhnvPrTe7KNM45nkphjeUb0GgtE
         M46iKWGBW/Hfj7Eir6pyMJcfMMj21cj8l4XnbVb9xdqDqVapHWoa8oXMTR+qf40JCmKm
         VPlnl9o97X/bTt8+rVMbA3iFJoYkB2xEk6kSY4lXolqzUUYppfupnwUw5WGfcheRbf+n
         Uky4Q97DAvJD7aznUwNIr/Ju2rSpm1sMGighC8U6BopUvBEy2HO0838R0fOfh88X95s/
         AF9etQiJdvEdbdylDsNgKs3LdnbfPPyCUjnFsNFnaQ2jLD7CVLtBgjAtGczoF4WZj35H
         05aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198407; x=1709803207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WwQvPtrchQr55jMR6QmPbP1tMQ2V4TzDErrhsqCBXY=;
        b=RdiWac3qzZlL/NR7kcAs5pFHie0nxUXDiDkw70oqdDoHy7/Zb26agaMZqrSEH1dnmI
         S7b4UU+wO79GIrcsFOhodYqZ1mglgqfxVX/C58TI9jg525DzROoe64rgef7Y6XBbJJZK
         JNGU7SW86hdM8TCuaKRPSwInYsrZBRG+97vKJjAaE56Gdc6Nqc/MFCFj/RfHPg1/1A4v
         DddZqn5mk1F21+MJXFOcAPaIHAltY0vRb/Z5gscv1oGmI6AgY0YAE+4gB2XEt0wG+bxw
         /2ELw8vwE9MPr9mjhq2s3OxB2PFCrRR5WADnZq3pMlSozxBMcXO3GoQlBWupI3q+RiBg
         MbMw==
X-Forwarded-Encrypted: i=1; AJvYcCV38Nk8AQaHAdPUgAS58QNwzGt4yUeZ+ndwuiyFMy3Htvon3d2cDINei+BL/aAyhq7bRJAZrvi/YYdJmmDaGREItpDXZPRmHk16lirl
X-Gm-Message-State: AOJu0YwA0SBFbwCqvMOtHTf0mIn8/GTliHKoArIJ8nBvjeRWGLRduar+
	W6alIMGduWTOPtn1wKPBzv1bFIWlph4icUA8HIbo4Iry712/4RJY6a5MZnqAGAY=
X-Google-Smtp-Source: AGHT+IH4DjWRcIUwOnrisXOgXOTPoAtgvr+Hfo1U5qDrkqpiXjsIbxHBau+xcepAx4WAx5xlZ3c19Q==
X-Received: by 2002:a17:906:1c4b:b0:a3e:a3c3:9658 with SMTP id l11-20020a1709061c4b00b00a3ea3c39658mr1054883ejg.22.1709198407361;
        Thu, 29 Feb 2024 01:20:07 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090699d600b00a3f4bb02bc8sm488281ejn.42.2024.02.29.01.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:20:06 -0800 (PST)
Date: Thu, 29 Feb 2024 10:20:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <ZeBMRXUjVSwUHxU-@nanopsycho>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228084745.2c0fef0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228084745.2c0fef0e@kernel.org>

Wed, Feb 28, 2024 at 05:47:45PM CET, kuba@kernel.org wrote:
>On Wed, 28 Feb 2024 16:59:44 +0100 Larysa Zaremba wrote:
>> Allow to:
>> * receive LLDP packets on a VF
>> * transmit LLDP from a VF
>> 
>> Only a single VF per port can transmit LLDP packets,
>> all trusted VFs can transmit LLDP packets.
>> 
>> For both functionalities to work, private flag
>> fw-lldp-agent must be off.
>> 
>> I am aware that implemented way of configuration (through sysfs) can be
>> potentially controversial and would like some feedback from outside.
>
>Why is the device not in switchdev mode? You can put your lldp-agent
>priv flag on repr netdevs.
>

But isn't it a matter of eswitch configuration? I mean, the user should
be free to configure filtering/forwarding of any packet, including LLDP
ones.

