Return-Path: <linux-kernel+bounces-145522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC78A5761
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED12B23D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C72824A3;
	Mon, 15 Apr 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZjKwUMqo"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00207F7FA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197590; cv=none; b=H9N/ORYRGUXD6gtNu/0eoLWYVCySl3JA1cVqUIiDM0cxlE2jmhJXC/WhYHDy7PKOG1u4mYuz4IePFx8Oeqq0Jxb1t+kvq/McFiECSxvForE+FkRo0Ewmqr7UHo7FbTu6akIgH9NesryCf7qZWJHZvmi6cVRv0XRE2egdgin1VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197590; c=relaxed/simple;
	bh=3txhU/uOLpNTBRjbxQmBVPq2bA1GUBYvBxcrijzixx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThMvX1X9pKswLA0t1Qnr9/H2NCj0bbOHQTh5mqa53awKemmn3nPUuTlkwFAnRfAiXtfG+MHd3QLhdU/eZnrzQ1WfNrBGasOhGUekP2ljHMKG1MlaRJEYdRNHL7qsy8YWhxoW+hd+L23poyguGD7xoweCoJ8wDuuvD9whRwxSa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZjKwUMqo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434d0f63c31so14577451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713197587; x=1713802387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=on+iLChflz05Dr/oXUYjGxNpjkJObC3efkHZq3cR0H4=;
        b=ZjKwUMqoA90oBHmVpe7Xx0DHnZ1fQROR9vxQKYtPJg84Ecb9bm/HjbOlMAZMyhSg1/
         MvUIapL9MB4IEm0uNhhwEo8pAXK77x+AM/RgVUPPRd3BvKHYY05lt1zZoo2d1csm7h/b
         9algl+2CpVYyPX9XM/b4q6MDtBCso6jMDLyMIyzZxlmJMROzJr29Myw9hqfk1xzk7PHb
         Xku0zjkwFejkxprHeybOYuJDd8MEheW6/OAtkn9c2sMjJba+qQStYO71cdRx++2nct2s
         twrfNNyyMCAuqb4dKNhLnd9PIXvXEpKiML+V8pt79S5Qls5XnxilPVE2N/jQGrbt1uzm
         70bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197587; x=1713802387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on+iLChflz05Dr/oXUYjGxNpjkJObC3efkHZq3cR0H4=;
        b=S+jvE5Ob6BrIdW+zM6aHA7DbQ7+9BkkHNzbS5uDdEwjR9AHO7PflSQKkXqFnGxByh2
         5ZuvTPUC02DYMLsx/gv91Fnq8R3tsge1NhZOW2metMxuINdPWMGinolfmAo7xeH5KN83
         qBOFNoB5w2Nf5NuSOD6eWcjFf4ZTtW6MWEcJ6eyPRD9pVPVoXPn5e8xVYXl0CRkWPzo9
         wF50B0U5xW2u2bAElSTGD+4pFVoHTRW3Q5Fq9k7wU2pwCBj2KgK1LFIjd9ubSOIvfSQj
         8XOWdHecL/tzrBaFMx4tF+cV6z120PrRxk5FyfJLwcXRJyTsP2GyaPFro87Pu2n7Zp/X
         +SIg==
X-Gm-Message-State: AOJu0YwV5zeOUUXO77ldKMMnePdO0sgWjj27hKcmzzE1+Juz850UlqFq
	vjkm9O7LN+CTS9cz3lgTuXJB+gDUA+YmRKsvs9G+pOi/Bn/qtDBOLBRzXJKjhjM=
X-Google-Smtp-Source: AGHT+IHyzaUorlIitkHhSGZXmR2GMsZtGczdvew6u4b3tEs8jO7YUxIlFj/Hon53gMR9WnKJ7zNFWQ==
X-Received: by 2002:ac8:5747:0:b0:434:9253:da0c with SMTP id 7-20020ac85747000000b004349253da0cmr12619578qtx.7.1713197586903;
        Mon, 15 Apr 2024 09:13:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fp17-20020a05622a509100b004343d021503sm6144270qtb.67.2024.04.15.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:13:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwOx7-006Br7-Sv;
	Mon, 15 Apr 2024 13:13:05 -0300
Date: Mon, 15 Apr 2024 13:13:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <20240415161305.GO223006@ziepe.ca>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>

On Mon, Apr 15, 2024 at 02:49:49AM -0700, Shradha Gupta wrote:
> Add new device attributes to view multiport, msix, and adapter MTU
> setting for MANA device.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
>  include/net/mana/gdma.h                       |  9 +++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 1332db9a08eb..6674a02cff06 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +static ssize_t mana_attr_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct gdma_context *gc = pci_get_drvdata(pdev);
> +	struct mana_context *ac = gc->mana.driver_data;
> +
> +	if (strcmp(attr->attr.name, "mport") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> +	else if (strcmp(attr->attr.name, "msix") == 0)
> +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> +	else
> +		return -EINVAL;
> +

That is not how sysfs should be implemented at all, please find a
good example to copy from. Every attribute should use its own function
with the macros to link it into an attributes group and sysfs_emit
should be used for printing

Jason

