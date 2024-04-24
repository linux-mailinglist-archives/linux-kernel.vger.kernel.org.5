Return-Path: <linux-kernel+bounces-157103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E58B0CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB211B28A85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FC15ECE2;
	Wed, 24 Apr 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XBv9tqD0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65315E80A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969708; cv=none; b=rFxbVX7tl6vVzekZVz2EGp5rn4t0pXahXPYVZYt+rhBZL+I/1nSSjf6BQw/a8Z18ElcXb8CwZZuPHvzBcvpMvmxqU33nuVppI9MsDj1d6DkYu68l15AC8lEKUEfO9FXumRa09IaLwJlx5iwggZMvnvBqaVy0YNjrRVvMWtabibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969708; c=relaxed/simple;
	bh=jzg4BBCh3cq6Sy73nNHz9QmiKL7thUrN27kWtWd508g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ZltitiKsHj0zrNsq5qDuNQX7i40YO1yzwrkAHZJ5+MtBrGEfqjWpUAMvG2HcKysXKE614+I5IkUjbgPwNKzUokClpA2no5LqdUVwJi4bxvnTx4uDuITFjYa1RAREflHqeeeAsgwn3p+frh3OJ5CQcs7FGES+93wqoLOLIcYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XBv9tqD0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso26861045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713969705; x=1714574505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=585fL2S+MdCX45+yRKa17/Q5RuA1bShcRMqVY48gZdU=;
        b=XBv9tqD0fBNUeaI1WBbQOxAVEBf4S4HGNviT8nn1140EdxlqfAUWvGFjr+3Br1UJze
         /XizQYDYC9lX53nXtyv4tPRExKXGjBY3Ewz+ygDLSyCgLacMk3WLjtpjCzz/4LrmEQ1/
         2kL/eK0vjCl3agz1aRXWjIrqRrtp4poii8bFhxLXVfvoF2uSOzZ8Mnnv5dNDzhsCjSp+
         CEYE11Md1hYxFzex3frfH8bTNkgIXysM6kPyWgVgQqCApfk7xJtJ6E8gjstG53EIE9Lh
         Q3HUCd2fmmrgAr7S/v5CbsVvekvxA/vDoGmId5f5kGnp/n1snOfF+VmP0hrpvy6Ef8rj
         17ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969705; x=1714574505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=585fL2S+MdCX45+yRKa17/Q5RuA1bShcRMqVY48gZdU=;
        b=Q2aHHnB5d+GT6iJXOhPb851GtsbQPwXCfbeTTowV6PpiTaAovML5tb8pqMBrTBPYq2
         0Ix3GMiOmvHo9LhJNKO8deMZjdtg+EFMTGHbzSrWVmeKsuMRSJOceFOk3JFN2tpeCgCF
         6YjvAzqPPLVpZWWbCE4DK1+7PNPwKjlLYZNVpUL4Y+axhN+vF1QR4OHXPqt7/IPUxjnk
         YvdqIzm3Xp18OnVkZbBx0UFkrfR7h76BwF7M/SU5qMIUFvCGbUXvnhLOuHwSTbRhkK3j
         2pjDfGWV1ID0mvWmv3EnAIJarzUwb3Srs5WlUzw2QkXDsIn7Jd3UmReD12eScRDp6vQ+
         bGJA==
X-Forwarded-Encrypted: i=1; AJvYcCVM6numSQdMpdGRNyqQCO70HDZH1336V0PZ2KqnCSIbHGCwUGUR7+kGvB1kujV+7XtXoGVaGslogjs6FAEvhwWQXUPtulZdok7E3OnO
X-Gm-Message-State: AOJu0YyLhyO8uMZuClPlG+Sbs+A580BHEHQIF5OEgrC/mIPnkN0q1fwY
	bbyRkJqALyFEOO4dQPRPmZXLLz3kdhsSU+zIcCEXbwYGs6gnIy+mAuIUY/afCpizg86mUMIYzyb
	w
X-Google-Smtp-Source: AGHT+IHWqJp4tQPcJyHxmVz/5N3oHbhRsRwdcDsdPdmvKxnidXnLBunMCjixUfJ6D/xIoLjodQUuOw==
X-Received: by 2002:a05:600c:1d99:b0:41b:2e2f:5828 with SMTP id p25-20020a05600c1d9900b0041b2e2f5828mr34312wms.29.1713969705262;
        Wed, 24 Apr 2024 07:41:45 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b00418d434ae4esm24078115wmq.10.2024.04.24.07.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:41:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:41:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support
 to sync link state between representor and VFs
Message-ID: <ZikaJcqEqwhN-RSE@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com>
 <ZieyWKC7ReztKRWF@nanopsycho>
 <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>

Tue, Apr 23, 2024 at 06:09:02PM CEST, gakula@marvell.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 6:37 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>
>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>> Subject: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support to
>> sync link state between representor and VFs
>> 
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>> 
>> ----------------------------------------------------------------------
>> Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
>> >Implements mbox function to sync the link state between VFs and its
>> >representors. Same mbox is use to notify other updates like mtu etc.
>> >
>> >This patch enables
>> >- Reflecting the link state of representor based on the VF state and
>> >link state of VF based on representor.
>> 
>> Could you please elaborate a bit more how exactly this behaves? Examples
>> would help.
>> 
>We patch implement the below requirement mentioned the representors documentation.
>Eg: ip link set r0p1 up/down  will disable carrier on/off of the corresponding representee(eth0) interface.
>
>
>"
>The representee's link state is controlled through the representor. Setting the representor administratively UP or DOWN should cause carrier ON or OFF at the representee.

Put these into patch description please.

>"
>
>> 
>> >- On VF interface up/down a notification is sent via mbox to
>> >representor
>> >  to update the link state.
>> >- On representor interafce up/down will cause the link state update of VF.
>> >

