Return-Path: <linux-kernel+bounces-125173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A4E8921A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F495B23360
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71EE2D603;
	Fri, 29 Mar 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBbaHKKl"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5232C19F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729966; cv=none; b=NT6TQuG5H86LxUc+c10iRzPk3+rvFLNHhPAMTmAZd0uqjt5D0+x3ZIx1DassZgvnAiMJNdgUg8nmn7EePdCjLBAm0nGIfnQY4IW66dCJXUAZsxhiDlssCS19kw5dOwb8laHECJ6Un7ncMjlnb4YPZ0DdS+S1HBWJIBroYIxU7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729966; c=relaxed/simple;
	bh=E3HGZbY6E3H/SomNIQGH3/DUr3KviIz8/9DkXlQJ8E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL2V2jHXU/2227B2p1nxSV3BX64A6b5DW+ZM1kmvVO4gycMdsqzljCPH/o/iKs0udVFvkxP0oq3aebTydXgV6QOM7bd04yA67X6MthDRE8mDrl/04n2F09Dz5XH/9dJmPIN3tejM1sikRlq5Epjp33xF2AG88eJLhY6zeVZKy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBbaHKKl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44665605f3so239304066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711729962; x=1712334762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2QgqTKjYeMV4wupX3c1M3yXu+BukxhArfbC4mqtySY=;
        b=hBbaHKKl9h+4ibmGMTVbY3VO5ZIE4I4Mc66qMgKryVSILDsEdikWqmZfeACfICBnV/
         3KGtanmaPnNmJoAJAHUe0XB3tNKkLEIxZl90HMxhudNVNp2i6w3QT9zqTSR+TYaRu1FN
         XlP5gV9BwX7qOauZ7Drq/zQs+NUuXtldtl27ALwr/sO1ywm1X6rFOEZtr3kpkJ6Us3WN
         jnaX0zevuk38JLQpIcnOi3Uw9sGTGDc7uTjyjp9OIaRbZ8IHLhbl3UET4PZUgrOgCDo5
         JTItjFGfQILhXq/B9/fhKFTIXaNQEORER/iYubpcHFoeubM8+zseioKwd98DL80jIZZK
         sn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729962; x=1712334762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2QgqTKjYeMV4wupX3c1M3yXu+BukxhArfbC4mqtySY=;
        b=FCIaNdY5tD7pXY/0kvq1NHzpSKVMFApqgFbmlOR7agLxGHEOe+V8JEv4R8s2dV3Y03
         NE7CM9onD6Nsx6h8IT7IhCICo2lV06MSZNcUTpVWITPuoKnV/dXLP5Pvj6y36W+7j8vV
         e3M7HLj6sTdxFhTHsucihSpzh6XsG/XIYnoX24PoruI27qmEYa5cbrLqPCjxqZH6Kwxh
         dzhGUxRRZOGIo1lx+3w3eNOp9N2rhtFqSkqrmmek0f3hIMgFtAitJqV0HxhHJxJ2qzLj
         CdSlxkYi8C2tlzUgAjdFvTu57UmSChMxaEcxeB79AaeZKT51UG5NHrVywcOsS4TrR5Zb
         FYyw==
X-Forwarded-Encrypted: i=1; AJvYcCUVQ65Q956FjoQ4HhHXPSeLa686kZlpTssJ3VNtr/IevK28bTvAtmQnQPsI85ELQSF/JH3PaqNP6c8S6jpRTZA1SFNPgs8lmETtTj1e
X-Gm-Message-State: AOJu0YwRapZdpr9blV+lrOIFluiBV5Tsv9z4zw5SZ4OYcGu5J3o8F22G
	Cecr/YoeqVHHazGmUphPSpBNLImOOyvAQlJ+WFelgn+2NuUrfcK9KRPfeCOo8Qs=
X-Google-Smtp-Source: AGHT+IGu63POJ6YHNg71abi2Y6v6vkpEJuMdYhaSnyay7s2ilQzvpFifN7/DQE4ir9OfMsCUJbqRRw==
X-Received: by 2002:a17:906:39c6:b0:a4e:26a4:bc36 with SMTP id i6-20020a17090639c600b00a4e26a4bc36mr1698829eje.7.1711729962342;
        Fri, 29 Mar 2024 09:32:42 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id dl5-20020a170907944500b00a4e28b2639asm1607642ejc.209.2024.03.29.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:32:41 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:32:40 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 3/5] spmi: pmic-arb: Make the APID init a
 version operation
Message-ID: <ZgbtKNEJS/m8OQzt@linaro.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
 <20240326-spmi-multi-master-support-v6-3-1c87d8306c5b@linaro.org>
 <9af9cfd1-38c7-4f38-a652-fd046f427f98@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af9cfd1-38c7-4f38-a652-fd046f427f98@linaro.org>

On 24-03-28 09:51:49, Neil Armstrong wrote:
> On 26/03/2024 17:28, Abel Vesa wrote:
> > Rather than using conditionals in probe function, add the APID init
> > as a version specific operation. Due to v7, which supports multiple
> > buses, pass on the bus index to be used for sorting out the apid base
> > and count.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/spmi/spmi-pmic-arb.c | 199 +++++++++++++++++++++++++++----------------
> >   1 file changed, 124 insertions(+), 75 deletions(-)
> > 
> > diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> > index 9ed1180fe31f..38fed8a585fe 100644
> > --- a/drivers/spmi/spmi-pmic-arb.c
> > +++ b/drivers/spmi/spmi-pmic-arb.c
> > @@ -183,6 +183,7 @@ struct spmi_pmic_arb {
> >    * struct pmic_arb_ver_ops - version dependent functionality.
> >    *
> >    * @ver_str:		version string.
> > + * @init_apid:		finds the apid base and count
> >    * @ppid_to_apid:	finds the apid for a given ppid.
> >    * @non_data_cmd:	on v1 issues an spmi non-data command.
> >    *			on v2 no HW support, returns -EOPNOTSUPP.
> > @@ -202,6 +203,7 @@ struct spmi_pmic_arb {
> >    */
> >   struct pmic_arb_ver_ops {
> >   	const char *ver_str;
> > +	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
> >   	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
> >   	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
> >   	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> > @@ -942,6 +944,38 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
> >   	return 0;
> >   }
> > +static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
> > +{
> > +	/*
> > +	 * Initialize max_apid/min_apid to the opposite bounds, during
> > +	 * the irq domain translation, we are sure to update these
> > +	 */
> > +	pmic_arb->max_apid = 0;
> > +	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
> > +{
> > +	u32 *mapping_table;
> > +
> > +	if (index) {
> > +		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> > +			index);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mapping_table = devm_kcalloc(&pmic_arb->spmic->dev, pmic_arb->max_periphs,
> > +				     sizeof(*mapping_table), GFP_KERNEL);
> > +	if (!mapping_table)
> > +		return -ENOMEM;
> > +
> > +	pmic_arb->mapping_table = mapping_table;
> 
> Can you specify in the spmi_pmic_arb->mapping_table struct documentation the mapping_table
> is only used in v1 ? or even better rename it to mapping_table_v1
> 

Actually the mapping_table is used on version 1 through 3.

