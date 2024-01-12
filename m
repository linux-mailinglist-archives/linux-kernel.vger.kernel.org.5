Return-Path: <linux-kernel+bounces-25006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607682C5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A147CB24507
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D90168B9;
	Fri, 12 Jan 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYxyGbrF"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3616426;
	Fri, 12 Jan 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d41bb4da91so40996645ad.0;
        Fri, 12 Jan 2024 11:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088433; x=1705693233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJCyV0ZVfkYa6azqkKQYvg8QMt8CHM5kXhp66DP2KrQ=;
        b=TYxyGbrFOpbGGGuKIOIgXqSHGMec5NwdPF5zsYVjNWz8PyNI6gg2GgoDqso1r8Hd7n
         lJs2yHyoKBipF+hFabdpg4TzHLN/V5hSOmwU/tFvm2aFrDVgjXQegBXjXXuTAb+LxgFu
         LuWB3d1b5XeHLemNQkEBs4UDcmOZIqoy2CE8MH3gESmtQ0J3rS5BD03IZ8mMwL91wrRQ
         v7ge3J1hH5HN/a8XN4yVGxFL+UjA12IuM+yJbcEZvF8w1xAsaV9OPlhNX68LgIygv5v8
         AEcYPEgSD9ENGFBPH64F/7tbHavzq3ljkGWx7BaoNZBRXsMUUck87ET8Bi5Xzpk+xmby
         KX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088433; x=1705693233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJCyV0ZVfkYa6azqkKQYvg8QMt8CHM5kXhp66DP2KrQ=;
        b=TFnVYsPIwOe9Fegsr+hTe9zAdPxiC5jXnNqBIpOUXovGTzxKfIFyGkjI3IIObdvsqx
         qQIikvyb7d4pyAjIRUytmaiIPRCj6I8e2fM6IRluurycjAD4xg4dTpHBaaD1DXLZhlFl
         8TvP7Kpj72IBY2ktxhycTk8fx0VKTm9tZz9xIgCY77/jerbkP4giXBAy7xOU6cfM3pco
         7W37WKPEwwAmEIujm1gQ9ixgOs84X7uHjNbnACTpHn6FLajrtvRTabiQDBjnMS/XKiK6
         cOkN19QuTgpyWp7fDK/852EgwJrtCb3b6k96unHzvdBGQwpYzREylG/T5p5IsG5wWHZl
         BK8A==
X-Gm-Message-State: AOJu0YxZ3cRbYqkU/KXWT4DoI53pc+IWfdZCCRKBkXYBfe+OEe2GNt6N
	cDbAd3cI6W4SiGb1d7Ti3CA=
X-Google-Smtp-Source: AGHT+IG7YLEeac9EBpoy18WaYQqF/O1qNa7V2zPtZedjFVNl1gVhgmNYsYIbhbPbvVDJn03LT78jWA==
X-Received: by 2002:a17:902:aa08:b0:1d4:4f4d:38cd with SMTP id be8-20020a170902aa0800b001d44f4d38cdmr1026830plb.38.1705088432580;
        Fri, 12 Jan 2024 11:40:32 -0800 (PST)
Received: from debian (c-71-202-83-215.hsd1.ca.comcast.net. [71.202.83.215])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001d508715f5csm3490463plx.197.2024.01.12.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 11:40:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 12 Jan 2024 11:40:11 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Skip irq features if MSI/MSI-X are not supported
Message-ID: <ZaGVm5tHXoTZd4Ad@debian>
References: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>

On Thu, Jan 11, 2024 at 05:54:45PM -0800, Ira Weiny wrote:
> CXL 3.1 Section 3.1.1 states:
> 
> 	"A Function on a CXL device must not generate INTx messages if
> 	that Function participates in CXL.cache protocol or CXL.mem
> 	protocols."
> 
> The generic CXL memory driver only supports devices which use the
> CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
> vectors in anticipation of their need for mailbox interrupts or event
> processing.  However, the above requirement does not require a device to
> support interrupts, only that they use MSI/MSI-X.  For example, a device
> may disable mailbox interrupts and be configured for firmware first
> event processing and function well with the driver.
> 
> Rather than fail device probe if interrupts are not supported; flag that
> irqs are not enabled and avoid features which require interrupts.
> Emit messages appropriate for the situation to aid in debugging should
> device behavior be unexpected due to a failure to allocate vectors.
> 
> Note that it is possible for a device to have host based event
> processing through polling.  However, the driver does not support
> polling and it is not anticipated to be required.  Leave that case to
> the future if such a device comes along.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> Changes in v1:
> - [djbw: remove persistent irq boolean]
> - [djbw: Simplify error messages]
> - [Alison: spell check]
> - [iweiny: test]
> - Link to RFC: https://lore.kernel.org/r/20240108-dont-fail-irq-v1-1-4407228debd2@intel.com
> ---
>  drivers/cxl/pci.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..bd12b97bb38e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -381,7 +381,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> -static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> +static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> @@ -443,6 +443,11 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_err(cxlds->dev, "Mailbox irq enabled but no interrupt vectors.\n");
> +		return 0;
> +	}
> +
>  	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>  	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>  	if (irq < 0)
> @@ -587,7 +592,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>  }
>  
> -static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  {
>  	int nvecs;
>  
> @@ -604,9 +609,9 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> -		return -ENXIO;
> +		return false;
>  	}
> -	return 0;
> +	return true;
>  }
>  
>  static irqreturn_t cxl_event_thread(int irq, void *id)
> @@ -742,7 +747,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  }
>  
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> -			    struct cxl_memdev_state *mds)
> +			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_event_interrupt_policy policy;
>  	int rc;
> @@ -754,6 +759,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (!host_bridge->native_cxl_error)
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_info(mds->cxlds.dev, "No interrupt vectors, no polling, skip event processing.\n");
> +		return 0;
> +	}
> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
> @@ -788,6 +798,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
> +	bool irq_avail;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -845,11 +856,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	else
>  		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
>  
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> +	irq_avail = cxl_alloc_irq_vectors(pdev);
>  
> -	rc = cxl_pci_setup_mailbox(mds);
> +	rc = cxl_pci_setup_mailbox(mds, irq_avail);
>  	if (rc)
>  		return rc;
>  
> @@ -908,7 +917,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		}
>  	}
>  
> -	rc = cxl_event_config(host_bridge, mds);
> +	rc = cxl_event_config(host_bridge, mds, irq_avail);
>  	if (rc)
>  		return rc;
>  
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240108-dont-fail-irq-a96310368f0f
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 

