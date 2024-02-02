Return-Path: <linux-kernel+bounces-49077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AC846593
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBFFB25A34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7CB66D;
	Fri,  2 Feb 2024 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV9saPzE"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54238BE1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838743; cv=none; b=eSx6Sg1eKl02F1zZkAm29wyxmFD08Ii/pQeX9HraC7DmQW8QD893RgD7JZQfGGI00tEOOXuM5RS+JGzZCqWBnsrATOt6wDwGhnWELsDRJZWktlkboc2I45kVzsi+Z3esLewAgYyFoslNR2T4xbmeQcztiRky89GZueq2Ic26XqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838743; c=relaxed/simple;
	bh=rVOVnlumYp/3STCVKisehnEgpvGJhl5drLJ2AAZFYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpp6KDxTY5GTIzuyCdylHZrgTbIR8lOAxVfmDDBVTmh6xA6PB5lizkFnEAuSs42jBBGYjD/PKsJS63JBaA0mi6bbQgxTtRMs1nI/pa3SCQ+SJLPuQOsMUcddZI+xzPisyqjXqSjefD0HSXIKrjGKtNQTcCTyicIupYIzEt0eRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV9saPzE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295a7fd8eecso1188259a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 17:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706838741; x=1707443541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqAlHSzLXfxM7Llsu2Lt69aK1q3yICrHShao44M1Ozg=;
        b=UV9saPzEemUulTvk4wVn51D04qaaBH+u8e/nCtjNqnBxl2aSgGY9rvJOPBf9c8Hc8y
         omA6Nvc5akoIdlQm4nQLJQovKUdfKEaWJ4SkVQ2ivgb2GLQPvi5jtRYar+KBbLLSYd45
         jL7s1v6vYRlGg8GiUpoIdsEY38pSblgK2VswatlS0alFdYAusWAoQAh922tVMk2fAWnr
         IlUAqVvRVQZkxeK6MoZyl1MPpXMh+hsewfkfHieGZ8AtbQR8eeLNNu0XheRN8kLYfCHK
         4IVq0MzZsbq3xIlnW4m4gofoux6fq87pwxhf9LhIa9BHEZRpOKDAluEqz7eNfEU2/YWc
         zTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706838741; x=1707443541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqAlHSzLXfxM7Llsu2Lt69aK1q3yICrHShao44M1Ozg=;
        b=qWRJKX6WKL3hjx9hi23jF4pEEvvU2hOVVKbOiV1GwFI9m+ifvnC7xGVCyO9GUgKaHz
         mojLGkyqHqW0V202ma1l4Z6/z1HyKca+ydk1l5lGrlgB9hcPaK8VF6ydUrgdlDwm9j1h
         hfUpVinXGgDpXuZmub8PM5lQ41N+FXc26/8bbrabNjuGvat3ZJ/uef0tlsv739QCMXlj
         wHSv8LKJhAXaCvk37wvrxyxNIyeOhLUYF0qqrGVn4EnwNrBMlF54jlfEF9YoMp2jfF/l
         S/PRfM+a4IHU7S9dG20hOHvzUaWnIx+AHyWssqcPQvCSj5QO6KJWD395bhMjwbV5vVol
         flxA==
X-Gm-Message-State: AOJu0Yz5TwsOFhuUyC5a3UAM5Zr/PYpeS5RwDMT/YhIWqEtKaWfaTB81
	1EbVFwgSrH7ZAtumBxtpQ5OrVpm75xaI4tVBPYJGYUl6ouAnOAE5
X-Google-Smtp-Source: AGHT+IE9sSiBOt6HT7IRvNebSDELY+FoUf/UiMDuCyBgb/EcC0M1zQUsyY7jwZTsFrztDSey/Fctlg==
X-Received: by 2002:a17:90b:2341:b0:296:3846:fb43 with SMTP id ms1-20020a17090b234100b002963846fb43mr982112pjb.33.1706838740863;
        Thu, 01 Feb 2024 17:52:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUFb2gx3pFrvchKZ8bpw4QHIrIU1ySysczr6fDH5aI4lEmLJ5alB/r9GZF1gDbvLgwJori43u2TuRMP1fKEep7DCZ3REdibjOBsY2dk6J+F06oHQVuGIIPZQ4mSRy5E8YcFoG2MwnazK9ESjrzsVe3s/j9jYA0Y5TndVltTfAaeP/J
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id sl3-20020a17090b2e0300b00293d173ccbasm484675pjb.52.2024.02.01.17.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:52:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Feb 2024 15:52:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com, Bjorn Andersson <andersson@kernel.org>
Subject: Re: Workqueue regression
Message-ID: <ZbxK01xuA_FFWaE6@slm.duckdns.org>
References: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org>

Hello,

On Thu, Feb 01, 2024 at 09:57:59PM +0100, Konrad Dybcio wrote:
> So, commit "Implement system-wide nr_active enforcement for unbound workqueues"
> broke *something* and now performing a suspend-wakeup cycle on a Qualcomm
> SC8280XP-based (arm64) platform hangs when performing the resume tasks,
> presumably somewhere near PCIe reinitialization (but that may be a red herring).
> 
> Reverting the commit (and the ones on top of it due to conflicts) fixes
> the issue on next-20240130 and later (plus some out-of-tree patches that
> are largely unrelated).
> 
> Not sure where to start looking.

Hmm... sorry about that. Can you please boot with `console_no_suspend` and
retry? Once the system gets stuck, you can wait for several minutes till the
workqueue watchdog triggers and dumps the state or, if you can, trigger
`sysrq-t` which has workqueue state dump at the end.

If the system doesn't become live enough after suspend/resume cycle to get
more info, the following might help:

$ echo test_resume > /sys/power/disk
$ echo disk > /sys/power/state

That should walk most of the hibernation/wakeup path which is pretty simliar
to suspend/resume path without touching system power state.

Thanks.

-- 
tejun

