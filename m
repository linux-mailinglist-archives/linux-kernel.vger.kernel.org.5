Return-Path: <linux-kernel+bounces-71003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FC859F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C61C21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573672263E;
	Mon, 19 Feb 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl9dFohN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BD1400D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333641; cv=none; b=OVs6+C1icF3t2l4j1LsZP5NVePPbShvdALeBjdIEDlFJ39yBQMGAjnj6Ek2ghMCDhbbciSRpQO0XGQVgWVms698kbZOGKTFG5HshuMWh5OhjejyyXbn02vGXwiloTubGMiFo84AJc8p/Gews0l2PjAXomVL1labLpfqSBgewC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333641; c=relaxed/simple;
	bh=d3ncpbbD/jIqmrr9YKmvODI4grcXh+LHI1qn0nheqY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhK2Wcl2+Cim38k3OW0xCUDpLcIWvmUhtBo6DhGg2LMKQ5gUKvFXoN4o8G/o4Yemq75DFJWQVGwxBOefAdRADGGLqQC/vp0qh+uUNtl3potwPt+DJRt4fML8CYrzI5OJjGdh56myt0mXvNyHNkDLsm+AvBJ+nGLBtPDHrxuhl/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yl9dFohN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e82664d53so92350666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708333638; x=1708938438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tC1ZEm/yWZ4l2HBOpjXuJwNzMGpHf/k/betJFo2Hfaw=;
        b=yl9dFohND7zz+17UZ1IZ5lzZ8J7+wRiT7gYOoiFhhZpGUGULpvWmAlGn2eiN33RmBI
         sr0WG8BfNbuuYP+v+uDwijWajWQAAMxRCA5TUiOQFeY01S8WtIZpzFcR04n1+QSNTd1i
         arfGyS+9ruV2f+Jq34JUTcikUnwtcH1JoECfLabNDXqzU2+v4qhDlYQBWHUdtYjNsnHn
         hLIz91ac9E3jtNkdXsDczOeu29tJKuJe8wo0VTf/Wq2tudhCQ9E+Ruh0sQsiWweMI69d
         2wXFvmvtNJUwUHVx6VuBhAzrBbj8RHzqCkCo7ZPpv5o+J3ATDYxC7zS4LslkMvxE66rz
         OpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333638; x=1708938438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC1ZEm/yWZ4l2HBOpjXuJwNzMGpHf/k/betJFo2Hfaw=;
        b=nj35lWT4vUkgJhCGMa3+GM5B+ynJUsbcs1QOhUv+zQ3GCfEgQYwvcScET1W+C9hmR0
         Ku9YeqQ9MsQffPgCDE6yYmwvaa2O59nk0JRx7FSo99TAXTnSIOXUuhNlPn7u9sJtqtec
         twaNtzHMBboiKuT5ssaNN6X2xzxG0Q5ZT9/5xnIOY+G5nkpiRtFLrpRMtrjLGC3piIJy
         uOrRwbWm6eqSox26JcNTFCSJWhCIzbaWwk8pg0VtcuOQ2vRNRkx5hkyHZWv3yZO+bZUr
         yLmRMzTYyBYnQCniVSTq69u4cjFj/+JapaUAez8MCurGo3L3v+ghd6lDyZ+VqDz8AWCG
         +Bow==
X-Forwarded-Encrypted: i=1; AJvYcCXjP9ayTJx+Wy+o24Mb9SvM+VpI0r+4nRboDDjVEeuUOdkYS/dzDJ4cDCe4PTA9VQjeYl46PF3T2oIs8RNEWCitsYHnqk4HKmzakeKT
X-Gm-Message-State: AOJu0YyFnFPBvAsTdcl1gx5QOYJbqbFdV1CERoo/LFppF6QmgXMLnmrX
	6aiVbn30unaw65mCY/ftwRiHlH1s03dOhirMNNpoYk7ApgKZuv7GOugWHe0OwL4=
X-Google-Smtp-Source: AGHT+IFXr86gnM3CYEw6CwvqwgSKBh1+1CONJiQ5jWR3N5jH3cLVIYhSjpo8tuXQ5b5eV4kUF47BrQ==
X-Received: by 2002:a17:906:649:b0:a3e:b869:11b3 with SMTP id t9-20020a170906064900b00a3eb86911b3mr685183ejb.55.1708333638283;
        Mon, 19 Feb 2024 01:07:18 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906168800b00a3e7a2d9ac4sm1210148ejd.6.2024.02.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:07:18 -0800 (PST)
Date: Mon, 19 Feb 2024 12:07:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <8e6825b6-261b-439b-bb28-9fc585e50979@moroto.mountain>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
 <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
 <65cd4e1f69205_d5b4829463@iweiny-mobl.notmuch>
 <65d0092079c20_6c7452946@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d0092079c20_6c7452946@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Feb 16, 2024 at 05:17:20PM -0800, Dan Williams wrote:
> > commit 807fbe9cac9b190dab83e3ff377a30d18859c8ab
> > Author: Ira Weiny <ira.weiny@intel.com>
> > Date:   Wed Feb 14 15:25:24 2024 -0800
> > 
> >     Revert "acpi/ghes: Process CXL Component Events"
> >     
> >     This reverts commit 671a794c33c6e048ca5cedd5ad6af44d52d5d7e5.
> 
> Even reverts need changelogs, I can add one. I got conflicts trying to
> apply this to current fixes branch. I think I am going to just
> surgically backout the drivers/acpi/apei/ghes.c changes.

The `git revert` command comes from ancient times and it just sets
people up for failure...  :/

regards,
dan carpenter

