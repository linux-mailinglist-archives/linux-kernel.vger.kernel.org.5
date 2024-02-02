Return-Path: <linux-kernel+bounces-50209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E18475C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11A4291BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56414A4D7;
	Fri,  2 Feb 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8zpX9Xs"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CA7CF04
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893663; cv=none; b=q72gwt/0nrhMhsLRKQMlC6J2l5sYd1kyxfJPDrqTyVq5vOOyAtQNUJH8hCyzvpa7lXnrkCV15cNZmdsVOK53CZoD9v8VUqX7T2ZH/bpFTl46AZHAVle7MKIPuLJzbF7G1nFqYyuSSnuTr93e2bPSM5WDqgKfS+zFnGtCDrRWhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893663; c=relaxed/simple;
	bh=c4RcPMFX8/n1fPS/BEjIz5l09Pf1Qh+kPRau7pkLQ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0hfUrGJWJA4pqQ8gibenMdj4Ml/+SPBVFXST+bAmZqVTs6NNIDKK24oPQz/mavY/qLgpqFn0YSEUvjeW7Q0fHtqwbn0e5ffnvE5azgZlTDCIrsyRHSyk3cPR6Ao5Z7e37qxuQRUO0qHO0nO7vaqwLPDXckDZTSXdDANY8uRYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8zpX9Xs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d932f6ccfaso18695595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893661; x=1707498461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXiHcGm/fEWJbHkucFqY9QtCWzZf+8tRbfnCNBla688=;
        b=c8zpX9Xs/tCs4oTL1KMhDJ9gJjrbECzHT971OMJa+HsBK8TEmd41vHHnAqvxryWKnc
         ilpGK2XVqKr5IOVdw/iu23W9Yd+hjRGPwlwEFMMkoSmCA/ASoKFe9C27XQkQCXcD6PdY
         v9OhnqAr3WvcDNl8S4uByXylrTZPOCez6pf0X41AnX/nqxuJbK3nw6zXOoL8ZkwTORQS
         LJiD8eV/twC31HndQL3asvLyb6TH6R/II0gNXQa3hemwoSnOT9SLflivwxWWyPu9Gk2y
         ZratI2fkY5JNREZT4lKvI1qHs1LA6TYad9F6pmNjGhJl83KDM7twNqKCYOEF9TnsUrwt
         p71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893661; x=1707498461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXiHcGm/fEWJbHkucFqY9QtCWzZf+8tRbfnCNBla688=;
        b=DFhmM0gZmQYFM+/QHzSlvrRS4sxM8YQbIF451ozIGv2hZvftJyDRLlRFkgtWgV6bJX
         ukULAb4jadWiU4ongk+O1Kwwy3kQJP3kwmQADwWu8qF9tbTF1nQBCb8khvMJN/3ai/Xn
         5GRKLzBv7xibsoK6hUH1e0aRPV49rJf/OZj9UCmyZC+XVyy6SHbjDON///W0CBi6pH2e
         pvPki6o2AxzowL1BNVFV2d57ma+lK+q/rnMZ5UG+ftVMAZshMBHs9PEODUKMASwvPT3v
         w1FR3bEZdlD3TXENQPDbkfVy6aplsrvW6ELWIRSd4ZOAhtp3SBnTz6k0qd/ooynyRS80
         /WzA==
X-Gm-Message-State: AOJu0YxrmpmrOXWcWsHRRTo9w281Xlb3udkEmK9FeNc/KTrQii4XysRV
	I+zISD+wAM/xI/ztv++MrggYoeEawQ/poC30X+YPd/9xXJQAIVrXhA03D1HLrVA=
X-Google-Smtp-Source: AGHT+IHIu3EAwC5B4Q4BYqqfcYp8/QGh817BIxy7EUL4xdDr1iHONRWOwyePb4EgK/cLsEcCSXU4YA==
X-Received: by 2002:a17:903:1d2:b0:1d8:fe1e:7cb9 with SMTP id e18-20020a17090301d200b001d8fe1e7cb9mr11129366plh.19.1706893661549;
        Fri, 02 Feb 2024 09:07:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfv6SYCKtmQaa9wAyQLbdqRRfAfnjsFSqxPLTWpoO8Tlz5ZpOTxNLSdLbpFrD/kFeLP7X137J6gdCoRof9gzIDDmmpss0/GcV3G21l+mgs79V9v5MFuioKmKOjvI7O6XMIymqK5vLU2sSGiEppOMHpAi7Ix+vnPhbRoAjECNxh0hikJT6tE0iZCTz+MY4BOY4w2EO6zFBaOlMraEUFxPA=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001d8921f2058sm1820644plb.205.2024.02.02.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:07:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 07:07:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>
Subject: Re: [RFC PATCH 0/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <Zb0hXLDlXmfmn_Yw@slm.duckdns.org>
References: <20240130183336.511948-1-longman@redhat.com>
 <ZbpElS5sQV_o9NG1@localhost.localdomain>
 <89927d84-279a-492e-83d3-6d3e20b722f7@redhat.com>
 <Zbtv4v2KCKshnCL2@localhost.localdomain>
 <ff2c0ce1-4d40-4661-8d74-c1d81ff505ec@redhat.com>
 <Zb0CU2OrTCv457Wo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb0CU2OrTCv457Wo@localhost.localdomain>

Hello,

On Fri, Feb 02, 2024 at 03:55:15PM +0100, Juri Lelli wrote:
> Indeed. I believe this is what my 3/4 [1] was trying to cure, though. I
> still think that with current code the new_attr->cpumask gets first
> correctly initialized considering unbound_cpumask
> 
> apply_wqattrs_prepare ->
>   copy_workqueue_attrs(new_attrs, attrs);
>   wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> 
> but then overwritten further below using cpu_possible_mask
> 
> apply_wqattrs_prepare ->
>   copy_workqueue_attrs(new_attrs, attrs);
>   cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
> 
> operation that I honestly seem to still fail to grasp why we need to do.
> :)

So, imagine the following scenario on a system with four CPUs:

1. Initially both wq_unbound_cpumask and wq A's cpumask are 0xf.

2. wq_unbound_cpumask is set to 0x3. A's effective is 0x3.

3. A's cpumask is set to 0xe, A's effective is 0x3.

4. wq_unbound_cpumask is restore to 0xf. A's effective should become 0xe.

The reason why we're saving what user requested rather than effective is to
be able to do #4 so that the effective is always what's currently allowed
from what the user specified for the workqueue.

Now, if you want the current effective cpumask, that always coincides with
the workqueue's dfl_pwq's __pod_cpumask and if you look at the current
wq/for-6.9 branch, that's accessible through unbound_effective_cpumask()
helper.

Thanks.

-- 
tejun

