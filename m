Return-Path: <linux-kernel+bounces-138684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1A89F902
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4DE1F2CE39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6FF16E875;
	Wed, 10 Apr 2024 13:53:02 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2915FA6D;
	Wed, 10 Apr 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757182; cv=none; b=VouapikejDUDKDB6J9pdD9uJmUdjtPMwQPUwocg8rjLfAo+N7f+RUn1kPY8orL2oJb0mUkPnnM8vsct02vzk6WqbqZJNZ48QkfRJu1Y6qcymaRe4ZoECNR1f3FaMSPhK2ten4XpHAS7zbLF8PISds7YIbxZQFZkLJDp5D7yaxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757182; c=relaxed/simple;
	bh=eQCGM2hLXlsELqKGuPmo5wliilM5OD/y4FEKpn+8sGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBtS8+DxXH3AT5A7YMrNvOuockvJTmjDDXyTy8C7Y9+PsrMZ3OKPfM3QDMJ3NAh+RXkoFt3CCc7JHAcj/DmwZCxBRd8uPoZ9ofRO8d161X/TqfYDxxJGyUV/ASvTMUqf5oHkucXAGrEWw1bNbKAGGyfPjq5fdOQzUDIzHdFh9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso5168267a12.2;
        Wed, 10 Apr 2024 06:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757179; x=1713361979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+nHNpjc7nbxViZPMz2OFh3H9yMSlCGh2OFCJgFJuZo=;
        b=Z+VaWFsbPVq6dDJWUOb9pXZQRfcGKH+czXiR4CetyKNmrr1ZhWVE1QEZEqVHkUx5cx
         /QnBhUewDWTZC69ESUrpXjhSCfVcY6weUmiWR/V0Q2Ih+uSpwfMM6v/dvq9JksJlXBzf
         ObHxU3ICh/zL2FbqMk1TFlfVIW2diWpw+CWMJ+94WySYY4alFX3wVWfPkQTNVlQhOycd
         bQfWrg1SMxife+J894iHBq4EzP60I/urKIG/pZkbu5eqFuck9iuIjh4nZW6TSETiQLUw
         TgwJVT45/wiPzR/gAryhIENfjC3MXE8y3dsw2PSrGQDvOUYyMJMbVX+fzCf6zltjA5cG
         Aojw==
X-Forwarded-Encrypted: i=1; AJvYcCWnFBsOoFGFYjBtda9voFAYrpPvnThjcyBn/zOaHrSPX9X26Ce6wYnd/vfKbIZWGtNAuLl2jgVf0ljdEPK4Crgqyy1yyA8NkEDLfwck8YenuJ8w77NBrToJZaDNAfHcM57F4J15
X-Gm-Message-State: AOJu0YyOqdZv0Dm/uJjmub/ue6vSCXoSm0wKpOEpIalSVULZls3GLFJA
	OAUl4kLxb2ZPSdJXZ7BA2Hb5FxriCiSM+Yw8KRd8GtR5Y9YA5S1fRSAyT437E94=
X-Google-Smtp-Source: AGHT+IG05QuaAme6XNB1Zazal7AkIHNsiesYPGMti7akMyeAGlOnHNnoucOCpYJxxJ36YjZL2akARQ==
X-Received: by 2002:a50:8a84:0:b0:56d:c722:93a3 with SMTP id j4-20020a508a84000000b0056dc72293a3mr2098616edj.21.1712757178778;
        Wed, 10 Apr 2024 06:52:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id t9-20020aa7d709000000b0056e785e6b46sm1520621edq.3.2024.04.10.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:52:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 06:52:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dqs: make struct dql more cache
 efficient
Message-ID: <ZhaZuOjq+b5nzqcs@gmail.com>
References: <20240408172605.635508-1-leitao@debian.org>
 <20240408172605.635508-5-leitao@debian.org>
 <20240409172149.6f285b68@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409172149.6f285b68@kernel.org>

On Tue, Apr 09, 2024 at 05:21:49PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Apr 2024 10:25:56 -0700 Breno Leitao wrote:
> > With the previous change, struct dqs->stall_thrs will be in the hot path
> > (at queue side), even if DQS is disabled.
> > 
> > The other fields accessed in this function (last_obj_cnt and num_queued)
> > are in the first cache line, let's move this field  (stall_thrs) to the
> > very first cache line, since there is a hole there.
> > 
> > This does not change the structure size, since it moves an short (2
> > bytes) to 4-bytes whole in the first cache line.
> 
> Doesn't this move the cache line bouncing problem to the other side?

I think so. Looking at dql_check_stall(), it only uses fields in the
second cache line, except now 'dql->stall_thrs' that is in the first
cache line.

> Eric said "copy" I read that as "have two fields with the same value".

Sorry, I misunderstood it. I can create two fields, and update them
together at the only place where they will be updated
(bql_set_stall_thrs).

> I think it's single digit number of alu instructions we'd be saving
> here, not super convinced patch 3 is the right trade off...

Right. I was more concerned about the write barriers (smp_wmb()) inside
the loop which happen quite frequently.

But, if you think that the this is not the right approach, I can drop
this whole patchset. Do you think a profiler will us here?

Thanks!

