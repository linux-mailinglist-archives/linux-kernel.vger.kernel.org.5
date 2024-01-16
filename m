Return-Path: <linux-kernel+bounces-27697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EE82F44A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB031C23822
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C71C6AD;
	Tue, 16 Jan 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7YtMfeJ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96250257A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429909; cv=none; b=QC+zwCONM2jiPSGM+F4pGn4kuXbH1XIDl6gMZdJYsmaN9ok2Wl0UIwFO31BdmDYM8lo+CnERDCj24oXWKKPbtRMYuA7vwjlXBh/nxXpCRuH/+x4TXhBZ3bpkiK0eujw+B7CbdJKp87yT9xy2ev5QWVyFVX8SB/t5P+zB4Ztvj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429909; c=relaxed/simple;
	bh=u25NWr5gJK3oIJ5CH/ykuA1WxEzkBaijY+CVYsOK7Pg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egp7bxJkI5jYgC/CHqWF/JbvMJ9RUxDlFFKz4RgVRhZtGReh/wfVUWnNWhtbnNNBlWYx2NRcizPsfq1Hq+IoxKdEflH7PT6pJXf2qz4kWs3kHsoTMNvjYZKsiLjDmcBqqSGO/nujxDcZdXAnqyrWDo6NNcQjP6DU3OGr8jk4UzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7YtMfeJ; arc=none smtp.client-ip=209.85.167.176
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd8cd40a04so407288b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705429907; x=1706034707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oMDoznzC9eNGCxtxnpKJXGMgVd6tz1LN6Nd14UBe90=;
        b=E7YtMfeJgZ7orqENmMuUpF6BaI0ajkN+S/fzuGxltKK/5II7FM4vL5/OhllVsdmqd0
         P1zThpJlJj9DHEqqZvGoejohcTa2c2V9jaZnM1vSMTYfnWv9/cwCPDkEKCPzsRsvmVXM
         8q0laGSvLuvcMZ3VxrijSrTjX6Fh3IDm97hxIeusyhDamJ2TYmOAdTDkYXYR28HeAbKD
         oUUp9YTRwwbROHNPFkiOIHm8v2a1XYz2fIPXA8E7YZ33eXWxWTAUCsw2R0Dq+GeJoko1
         i1wVbaD3ASXn96fiCTzj6g3uvv782ryI4mStdouPjqU5LOKtF7SbEJhtCTjbmnx0N7jz
         dL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429907; x=1706034707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oMDoznzC9eNGCxtxnpKJXGMgVd6tz1LN6Nd14UBe90=;
        b=hj8wQ2F6BTmSg8c738jKScDUG/5+E8KuHhhUHNZzm9scfEAykZh9T9M7OFwEO5DLNe
         2H1quFn6vSCW4Fex2Tly2ZOPcPEw/8gGMFy+Hu+vp4Ynl+gNq7pPCtGWFu8rVDjFabtw
         CNPsNUEwtolU+icCqXg6gc7+uQim+OiuEGtkYVi7rmIbtVbKBvTxcdofLePUc9NDctUv
         rYa6Vxs+rF6rhTi8J/GarXTssGgUXN4Z2ir/gcTQXRUoeDMITDhK5BwQsalBTt07c0xd
         UkX7vZGwpLN2DkCTkof77Pb3v53SzRxXb3tGdoAzEov1Pi05oo7aAV/1qN/su1s6Of9N
         6ejw==
X-Gm-Message-State: AOJu0YzTIs4UP+/57inn97ejXkQ7/6ssBhGmo7njidJ2k+sIZg+wW5qo
	6bowdLIBelRNyXpddNvcwtk=
X-Google-Smtp-Source: AGHT+IErXEEhbwE3HxlN8RAVe8YC5ifMpQd4+q2c2+yhlykdG1Hpsbbm1ZREiZG9zTTiSfjTtByvAQ==
X-Received: by 2002:a05:6358:592a:b0:175:f04c:3ca4 with SMTP id g42-20020a056358592a00b00175f04c3ca4mr2790860rwf.63.1705429907440;
        Tue, 16 Jan 2024 10:31:47 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id p3-20020a625b03000000b006cbe1bb5e3asm10051664pfb.138.2024.01.16.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:31:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 08:31:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <audra@redhat.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH v3] workqueue.c: Increase workqueue name length
Message-ID: <ZabLkep0gOFEyjxH@slm.duckdns.org>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240115170822.451231-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115170822.451231-1-audra@redhat.com>

On Mon, Jan 15, 2024 at 12:08:22PM -0500, Audra Mitchell wrote:
> Currently we limit the size of the workqueue name to 24 characters due to
> commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
> Increase the size to 32 characters and print a warning in the event
> the requested name is larger than the limit of 32 characters.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

