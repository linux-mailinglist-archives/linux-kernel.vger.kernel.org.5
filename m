Return-Path: <linux-kernel+bounces-40314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BF83DE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1777B1F22E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD811D555;
	Fri, 26 Jan 2024 16:07:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCF1B59A;
	Fri, 26 Jan 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285253; cv=none; b=PC86/x3VsKoQM/yGDE2QDT4MG+0vO9Y296hNkZj9/CdvZKabFL0jwVLzI6jmoGTOWBDUJ4oXuVPNSXlrvSwjd0KsmlddcsYFmbEo/dXY3SSenIQOfuq7bUdbaZEO3TPBIFSMk2ag2PJidH9kci6IbH3vm04gwAU2OfkXOnXnch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285253; c=relaxed/simple;
	bh=gI+2AU1uVOrK/dIL2QzpzRnID+W2zsuBKmshc8YIqzE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNI6cBL6byIDUnnsY1PhJX0EvumnhhC6mxTM3aQWVc4X/ekmXGiiT4kkz2Yt1fLlOBd2dy/hIZtEoOOMFL4c+nOaOerU0LQ2+W2KAnnF2rjkuxhCaP3R0xpn/SgatwI3T97DDufC4GllXXNPdo1a0j2zX0LLIqevMEKCXB8ZHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM2ZF1QHWz6J9ln;
	Sat, 27 Jan 2024 00:04:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 339D2140AB8;
	Sat, 27 Jan 2024 00:07:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:07:26 +0000
Date: Fri, 26 Jan 2024 16:07:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/pci: Rename DOE mailbox handle to doe_mb
Message-ID: <20240126160725.00006dba@Huawei.com>
In-Reply-To: <20240108114833.241710-2-rrichter@amd.com>
References: <20240108114833.241710-1-rrichter@amd.com>
	<20240108114833.241710-2-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jan 2024 12:48:31 +0100
Robert Richter <rrichter@amd.com> wrote:

> Trivial variable rename for the DOE mailbox handle from cdat_doe to
> doe_mb. The variable name cdat_doe is too ambiguous, use doe_mb that
> is commonly used for the mailbox.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

I don't feel strongly about this one either way, but I've probably spent
too long looking at this code in the past.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6c9c8d92f8f7..89bab00bb291 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -518,14 +518,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
>  static int cxl_cdat_get_length(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,
>  			       size_t *length)
>  {
>  	__le32 request = CDAT_DOE_REQ(0);
>  	__le32 response[2];
>  	int rc;
>  
> -	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  		     &request, sizeof(request),
>  		     &response, sizeof(response));
> @@ -543,7 +543,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  }
>  
>  static int cxl_cdat_read_table(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,
>  			       void *cdat_table, size_t *cdat_length)
>  {
>  	size_t length = *cdat_length + sizeof(__le32);
> @@ -557,7 +557,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  		size_t entry_dw;
>  		int rc;
>  
> -		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
>  			     data, length);
> @@ -617,7 +617,7 @@ void read_cdat_data(struct cxl_port *port)
>  {
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
> -	struct pci_doe_mb *cdat_doe;
> +	struct pci_doe_mb *doe_mb;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> @@ -638,16 +638,16 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!pdev)
>  		return;
>  
> -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					CXL_DOE_PROTOCOL_TABLE_ACCESS);
> -	if (!cdat_doe) {
> +	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> +	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
>  		return;
>  	}
>  
>  	port->cdat_available = true;
>  
> -	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
>  	}
> @@ -656,7 +656,7 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!cdat_buf)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
>  	if (rc)
>  		goto err;
>  


