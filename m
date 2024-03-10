Return-Path: <linux-kernel+bounces-98322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4B877866
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C7D1F212DB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8F3A1DA;
	Sun, 10 Mar 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cb87LhzD"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140B381B9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710101965; cv=none; b=fVpyzaenTBTM0rvXT/ZOSJgQ7aKCXorZ0Rj8gxMVUpEV8AVMVSt3iHBEZI53xe2I4kEUKGL6VSH+oYhE2pX/cqKykcrh7lmjdDjzOkLt/EIjFloOPJZ+O3/uSHN3DXvZH7Q7OpSoB7/kDhQStsd+i/EhngPy8sC08ZQZMA/1GiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710101965; c=relaxed/simple;
	bh=xVgw+WLpstkp51McpETd1ecy51TvKLzFwrwza0ZRMNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAnji7TKvTzu/yOtoRcjjYOSX2ybXKSoSe+FJINkEr7w4Z+nxsmGo+8qKtTo/FY7+OVoNvZmyHqCbAvms+V6BOItKnv2/5dfdy7wC5TJgrqU+tS43XPNl3ssKvSVWdRkc5fDZEnQwF91BPnKh80dvRMVE6ic3MtD/nE4m4p6GKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cb87LhzD; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3664e49a960so2051105ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710101963; x=1710706763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p/OFdmYo9bWywhrZ/WxG3/jOMvpbouzGPdTG2yUZyw=;
        b=cb87LhzDNUq96H9olgzx6I3vhlmYBDXkWJItiB25d9zM6veUBCPEtJntns5J6vBRnW
         4GrWW+dR/hvcNiSp4YJYYpdKFLGS9s2Shhn+BTVBDVmzJtl36vsoHiyrP+Ai45uH3zPS
         R5Qq7+g3vQCqijMEd69bWDSWR3DeloA9mZs8VZkAglOXDKOQZZLJE5gKZdEtjZMK6ZVE
         IBugTZmuSDfDeuh+lCKqW5tYe4aGn59Ok2F6T+r/jZCn6i4o2vT/htAB7j6o022MX3G/
         QOH0DWxyXBguLimH+EhUVqc/2fU0p9AbSyJ0du+FkwwZLu7TO/RHlJmKHkw3mpqxRx45
         Fh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710101963; x=1710706763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p/OFdmYo9bWywhrZ/WxG3/jOMvpbouzGPdTG2yUZyw=;
        b=TjRl5hYVjPJkicHEWeFWKrCY1cPJns9xjCz6CCCa5PkzxnpdLGrAXu4ABzZo7tWqXm
         b72ly6XMKuqB++J3m0bzZ3dK0PpcZKHK722Y2tJW61mQgdUITiPJyrzF33a8TRynudOW
         8gaCrqmfRfSEiR4gmHoMaSzM9IKUKjjkwhJzAxJqdMBp5zeY1Z1cx3gj2LK0CxnqduWH
         lnE95kCurbGk14ybwY7m7e4HNsQq2PvjcIHdZaPCvbVji8jb8MESEwbHkf037hY7IMB7
         06D6LU/ZgWhhEAhphOGg7u2DnXQgGtoLLc0hF4iZTwyrVDzJAajnzpk+nA+g2Q7wKuG3
         Yn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf+TueDNNMRy6S84gVXqVi7+IkSfBqC+UaFbOaY1YkgZ1rTdaaKU5Uj0y09LnQb59f+qUKkiCShisa2alXUhSS489CdvtyD23vkNlL
X-Gm-Message-State: AOJu0YzdkaTI5kChNYCNSReBF+EphCt8A2aBgndBQUc+P60CFETZHAm3
	6uc+2DyDmjpddCJcKVETER2bciSr1d1Xu8wjiWlf+9vA7kIzmsNiniX/wHlvEg==
X-Google-Smtp-Source: AGHT+IFKWg0hXoZLmFIdYMz6hJTqPMSruvwbNITVdX3FilLT2IXrNKs5ao0yzivkQ3kT2B/4G5GAww==
X-Received: by 2002:a05:6e02:1748:b0:365:d2be:3de6 with SMTP id y8-20020a056e02174800b00365d2be3de6mr6871993ill.2.1710101962804;
        Sun, 10 Mar 2024 13:19:22 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id q19-20020a656253000000b005d553239b16sm2473866pgv.20.2024.03.10.13.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:19:22 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:19:17 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] scsi: hisi_sas: Use LIBSAS_SHT_BASE_NO_SLAVE_INIT
Message-ID: <Ze4VxRS1GQ1q4Jke@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-4-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:36AM +0000, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 18 +-----------------
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 18 +-----------------
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 18 +-----------------
>  3 files changed, 3 insertions(+), 51 deletions(-)

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

