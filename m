Return-Path: <linux-kernel+bounces-56912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D238584D13E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6191C2244A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F4F12B75;
	Wed,  7 Feb 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPtx3tkW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD01E4A2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330810; cv=none; b=acLXCvdSl/R8+D5yBkFTq+p+yoGfZ1tix1NjojUQ7cSxfNBgNs7K0YwTdP9h4tFPdPkXlApSSCsTS+eUMLGosDM3CHaJlum6h/RuPhh/sQtl02LhzT4LlrGtdiM0n/W+T8jxYZLxhNQ3o45n1U7BzISs8t0WsQy88jmvYieUWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330810; c=relaxed/simple;
	bh=/7Tt5/JBqcT6N6+kqktKgWYKcfcxOH9u9I7epm7UTTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUiEUorSAOTpHo6XKuxvfCMIPKqqRbvXNs0JuK9vaoJmLja0rG4hjupeOjY5JvLQs/zB+zFg3Gmpm7z/prkDltUdiF4uplVPle2UNXGgs1MRKS9PyBJEGJ8wKHF9NhLkyhjnKGe1bW4c15O54tMZLwo4clxQBvtTvF1kCSNr9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPtx3tkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707330806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JMeyJvCCoVivaM21Q/iux8NAUlJDZa/qPlf6Gcoi3a0=;
	b=OPtx3tkWWTr6X3UscEUeXSKX4J/HTy0WCZkMoHQogApw+PV64OLYNwh658SiMR1QzKFK2J
	hO/SvDqHOeZ+JYwVtDL93doTQZOvU6BL2e2irznkbAdIbI4HQRwP+OpJarNRWzkD+JsTGs
	XU7N3Ul6mdeWZ4LlnJYNY95lmPNWJlM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1aEFNCqGPdKJLKN4CJRLUQ-1; Wed, 07 Feb 2024 13:33:25 -0500
X-MC-Unique: 1aEFNCqGPdKJLKN4CJRLUQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42c41b01022so11397321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330805; x=1707935605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMeyJvCCoVivaM21Q/iux8NAUlJDZa/qPlf6Gcoi3a0=;
        b=qr8dxV1XPuyIDglI8bxG6kYJfV7qW5Z8HEz3/3BnwVnhLcgh44UY/OPrOJn7W0hL2A
         PPwlnKOLVuyb8jOshCy0V9cfYvCnx7uUEG9Ip5Dq66IRLBqElTu5v4qX2sYyCWTGZ/id
         OZ+LJo2lozD+jSprJKmll+NmL0qzNyFMnwqmUhBkVqGtfZLhUF+N8bln9to1B2DwP374
         SwwbJesXCURCahQWBj0IQenLNQnRarsg+rwKWVwlbQrFC5WVWQtIOTI99r0dkM2ZAJ4N
         MWUEVK8uPdwMdc+ykA0LUak3EBwlXOBUyGOPB4T9/U29+/oaz3kHgjrlnDGxDl5CgP8I
         5JBg==
X-Gm-Message-State: AOJu0YxYDApzYTDhRh5Y9Ca/GMn4J2ldHJgynWYnDeq7p26Qiio7RShE
	UEwJDhC+sc3+ngRFTNnz2T51uZEOsNI7i1dUw53LgkBLcig5cmDJxfc4xmggAetHSUKi48s8oeU
	j6r6xojIijQJLlZef4NPsEAQtiTbeVlf73MOkRd10doM1v1B7NFIftVRzagm8vA==
X-Received: by 2002:a05:6214:20e9:b0:68c:72a5:a93d with SMTP id 9-20020a05621420e900b0068c72a5a93dmr6711514qvk.27.1707330805139;
        Wed, 07 Feb 2024 10:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+Hwwd3uiOhwan77GCktd7qaNzX3a66FDHuN97fZFIE8Y9wQslAnq+foGUlTIjjFSfUHh11Q==
X-Received: by 2002:a05:6214:20e9:b0:68c:72a5:a93d with SMTP id 9-20020a05621420e900b0068c72a5a93dmr6711482qvk.27.1707330804837;
        Wed, 07 Feb 2024 10:33:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxpGHGTPE0HdL3Oa6o954aovqBcgsKuLo+oIqeNUlTRRYbgCE4PmFYgkJyeTdOLmDZiDV+bEvus8jeI/TT/w82CQCD5bMjTAkbQA7Xm8tNruwT1/CtXaavPwhdBDG2oL4lZlDdkGlLPZMNKtlaGlEvLRZ4WUX/FZfI3vdlRehUs/itDsf8MCDu1Wzisa59KEVDU2lti8am2v7urwI7b6OgoIx7RWM6Zl8M0KxpCxuDozL6JE2TNB7D56n5QAozeQSPbLlzPmivkhy0ToajRalLDC32xPOeNiQXA/g8cioXMqANjgU12T6+P4u3Mnz10uV3CXZftaTgkik7QE1o1Vz1glP/1d7Vt+657TzDMij/+ahL+QOsX40d5cX4Clt5yUTc2WgWfnGIbUZ9QjMiu/6L8NpRnK7JNKaBHgcf9GcPqzMHQFL5z0t0lC/E6JebHVtMlukCqZqja6ZjpF/0jb+yAMa7tVLq12CDyf9FPbb01dDUry8CVKjN5bcBiLeNnOUAFPNYaj2OPGUuVU3feXywl5pjPzFO60EDeTtlEDOEvbknCUfyhcRQ7eLaHLGlwuBYFsRECGA9e3LLhVs0OiXU1VAPAxi27qI6z4kfhqYya0GYrI6BHnF/1DWwXuEdncADojfOJR+BoXxIxh0VYilud/0Eo4hyZN02Bc/G3YQpoPUAod/b1ARnbiso7d9M1PsvKR0MAlcPj0MD+ZOgXrvnvstt1E561qLB9q1OBz+f80mUbVyIgePv
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id nd10-20020a056214420a00b006819aeb62d6sm827097qvb.136.2024.02.07.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:33:24 -0800 (PST)
Date: Wed, 7 Feb 2024 12:33:21 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com
Subject: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all
 queues but 0
Message-ID: <ijcu4dyxmwupro5po5b36p6p7r2swzr3ucd7bp2hfmbt3pgtbr@oeqrhu6xhlcl>
References: <20240207001036.1333450-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207001036.1333450-1-quic_abchauha@quicinc.com>

Hey ABC,

I may have swamped you with information last time when talking about
the commit message etiquette.

This looks a lot better, there's some discussion going on about the
canonical way to refer to another patch in the other thread (which I
agree with in the other thread, outside that this looks pretty good to me).

All that to say, I think you didn't understand my ask prior on the subject line:

    This is a new feature for netdev, so the Subject should have "net-next"
    in it: https://docs.kernel.org/process/maintainer-netdev.html#tl-dr

i.e. assuming no other changes:

    [PATCH net-next v2] net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0

since at the moment I'm considering this a new feature. If it was a fix
(and had a Fixes: tag), you'd target "net" instead of "net-next".

I'll try and test this later today!

I'm not sure how accustomed to inline responses you are, so I'll be
verbose, but normally all responses are inline on list so look for em inline.
I'll repost my missed comment from v1 below inline.


On Tue, Feb 06, 2024 at 04:10:36PM -0800, Abhishek Chauhan wrote:
> TSO and TBS cannot co-exist. TBS requires special descriptor to be
> allocated at bootup. Initialising Tx queues at probe to support
> TSO and TBS can help in allocating those resources at bootup.
> 
> TX queues with TBS can support etf qdisc hw offload.
> 
> This is similar to the patch raised by NXP <3b12ec8f618e>
> <"net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings">
> 
> Changes since v1:
> - Subject is changed as per upstream guidelines
> - Added a reference of a similar change done by NXP in
>   body of the commit message
> 
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..d2f9b8f6c027 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -728,7 +728,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	struct stmmac_resources stmmac_res;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_ethqos *ethqos;
> -	int ret;
> +	int ret, i;
>  
>  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
>  	if (ret)
> @@ -822,6 +822,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
>  	}
>  
> +	/*Enable TSO on queue0 and enable TBS on rest of the queues*/

nitpicky: Please put spaces around the comment markers i.e. /* this */ over /*this*/

Thanks,
Andrew

> +	for (i = 1; i < plat_dat->tx_queues_to_use; i++)
> +		plat_dat->tx_queues_cfg[i].tbs_en = 1;
> +
>  	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>  }
>  
> -- 
> 2.25.1
> 


