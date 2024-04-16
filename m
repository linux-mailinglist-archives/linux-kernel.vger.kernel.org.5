Return-Path: <linux-kernel+bounces-146968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AEE8A6DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9051C22191
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C81134425;
	Tue, 16 Apr 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imdJkKDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70882134406;
	Tue, 16 Apr 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276652; cv=none; b=VVurmvnTemEmGbceNSgEp/OMQSF3lDN4V+IVoYvEgOyqIfqq8wRgdgemmADT5XyBVDKRS5hdAjsK0CmQ86kKTKVaG3sCKC2se1Z7rmb/esDPc7eNwjk5qduQiopjfTK9v0oktg5CgMBEQ6c7SWVpX/3k6CRkWV1DZYPY5X2uJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276652; c=relaxed/simple;
	bh=KrWX/mg6sB3IEZrckEkLG2wQSu4eyNuu4r2kX+Ke2dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db3wHoY1pd3GKhChwlDAGwFg+xY98oukv4CKtjuk3Z67Ya2VFbtV5wXiWMqv9m/X/Dc27RrjMdWnSBhwe12IK8Qy2o2h3ovIPmAhwk+VmXh5RuPCGYjGdz7u57TlDDWilQGGHI6TeK6aiy7T++wJxpUaCeYapc6zkgvjU7O/zFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imdJkKDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9EAC4AF0B;
	Tue, 16 Apr 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276652;
	bh=KrWX/mg6sB3IEZrckEkLG2wQSu4eyNuu4r2kX+Ke2dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imdJkKDYt4IFdH2ZckctnvXhpZbwxdxcgmUWwCvsrSIY1BBC3Zve/1ZAOnUB2VU7r
	 o4QWE3QJ+6HF2FSN6XVw50nGwR+64xUP/kb4KIAsCz1CUF/S04ZGbwS6f0cNjWe/6v
	 Rhj+mq5FCttUy+RNqV+pPUOjSwdGaS4b88AK/rycT+U6phHhDzlgDZf0O84XN0yt+1
	 e32QCFkUFHSakyxij42InYbVbscHOW6jZ387u0s5pPfaJqOT1VIUeRuM5INvBzmzCY
	 AXM8KInzJKNcTTY+bsVy+F9LdvQ2sltQNRfvKI1Wg3WsbTvJHSVVGU9ob7lxzLUD1E
	 RLYXnH8XFlEuA==
Date: Tue, 16 Apr 2024 09:10:49 -0500
From: Rob Herring <robh@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: property: Add fw_devlink support for
 interrupt-map property
Message-ID: <20240416141049.GA2148267-robh@kernel.org>
References: <20240413091942.316054-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413091942.316054-1-apatel@ventanamicro.com>

On Sat, Apr 13, 2024 at 02:49:42PM +0530, Anup Patel wrote:
> Some of the PCI controllers (such as generic PCI host controller)
> use "interrupt-map" DT property to describe the mapping between
> PCI endpoints and PCI interrupt pins. This the only case where
> the interrupts are not described in DT.
> 
> Currently, there is no fw_devlink created based on "interrupt-map"
> DT property so interrupt controller is not guaranteed to be probed
> before PCI host controller. This affects every platform where both
> PCI host controller and interrupt controllers are probed as regular
> platform devices.
> 
> This creates fw_devlink between consumers (PCI host controller) and
> supplier (interrupt controller) based on "interrupt-map" DT property.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
> Changes since v1:
> - Updated commit description based on Rob's suggestion
> - Use of_irq_parse_raw() for parsing interrupt-map DT property
> ---
>  drivers/of/property.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..67be66384dac 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1311,6 +1311,63 @@ static struct device_node *parse_interrupts(struct device_node *np,
>  	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
>  }
>  
> +static struct device_node *parse_interrupt_map(struct device_node *np,
> +					       const char *prop_name, int index)
> +{
> +	const __be32 *imap, *imap_end, *addr;
> +	struct of_phandle_args sup_args;
> +	struct device_node *tn, *ipar;
> +	u32 addrcells, intcells;
> +	int i, j, imaplen;
> +
> +	if (!IS_ENABLED(CONFIG_OF_IRQ))
> +		return NULL;
> +
> +	if (strcmp(prop_name, "interrupt-map"))
> +		return NULL;
> +
> +	ipar = of_node_get(np);
> +	do {
> +		if (!of_property_read_u32(ipar, "#interrupt-cells", &intcells))
> +			break;
> +		tn = ipar;
> +		ipar = of_irq_find_parent(ipar);
> +		of_node_put(tn);
> +	} while (ipar);

No need for this loop. We've only gotten here if 'interrupt-map' is 
present in the node and '#interrupt-cells' is required if 
'interrupt-map' is present.

> +	if (!ipar)
> +		return NULL;
> +	addrcells = of_bus_n_addr_cells(ipar);
> +	of_node_put(ipar);
> +
> +	imap = of_get_property(np, "interrupt-map", &imaplen);
> +	if (!imap || imaplen <= (addrcells + intcells))
> +		return NULL;
> +	imap_end = imap + imaplen;
> +
> +	sup_args.np = NULL;
> +	for (i = 0; i <= index && imap < imap_end; i++) {
> +		if (sup_args.np) {
> +			of_node_put(sup_args.np);
> +			sup_args.np = NULL;
> +		}
> +
> +		addr = imap;
> +		imap += addrcells;
> +
> +		sup_args.np = np;
> +		sup_args.args_count = intcells;
> +		for (j = 0; j < intcells; j++)
> +			sup_args.args[j] = be32_to_cpu(imap[j]);
> +		imap += intcells;
> +
> +		if (of_irq_parse_raw(addr, &sup_args))
> +			return NULL;
> +		imap += sup_args.args_count + 1;
> +	}

Doesn't this leak a ref on the last time the function is invoked? For 
example, if we have 2 entries and index is 2. We'll get index=1, but 
then exit because imap==imap_end. We need a put on index==1 node.

Look at my next branch where I've converted things to use __free() 
cleanups. I don't see it helping here as-is, but maybe when it is 
correct.

Rob

