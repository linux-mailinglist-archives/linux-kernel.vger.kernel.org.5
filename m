Return-Path: <linux-kernel+bounces-63268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB2852D14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76ABDB27955
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85738DD5;
	Tue, 13 Feb 2024 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CQiIePV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImQV3ToI"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB1381BF;
	Tue, 13 Feb 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817862; cv=none; b=f3/FXloa1OMlncWJqcPoHnP0bIVFWG6qJ7P8wHX/pdX+Pf1fwSXXidTPLWIsLkca0gUdkDj0J1w5W8VQvIAq066AThesPZjKuj8rkHnUq7nbdq69rDq359yO5cehv4TXlM0ZwSiGy4jrKeopW8nzH840L/aavFD2mQdCnSuomOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817862; c=relaxed/simple;
	bh=du5IWnetsbefdXGP7RTt9oa3EydqVOtEqT7mUA/DKPM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pLjZDJJc+DrAzTaGiAYrRdKL8+yVBAcvz/licZYCh2Fkyd6lBioAnRGm8dx5GDoCzd/LLQa8TAG5aiwtSdX5o96WvJMryCI8G2z6ILEBdXCqqGKsKS8IpYb/am0w3RYGBdQOlmUNoM446VB2OXEWyBEucNQHSpxz8aMo0lAXNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CQiIePV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImQV3ToI; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CD29E1800092;
	Tue, 13 Feb 2024 04:50:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 04:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707817856; x=1707904256; bh=lHYsTK1bfv
	xaz8ZLnxtMiOszwDEbZ3X5lHEYDDbn/s4=; b=CQiIePV5jYKolbhb+hZq6ezei6
	Wtv+RrejZ+2KBZJy8yq2wk1h/pKErRHX/0afATPyG8zEIuqVvH9xMzssrPftbTri
	4P/cU32EASZA4yUv/4HOUQXkxfl5tjyJH2SzluKJ/RHCgzIt4JTOLYO4L0UdXjft
	V0ztrpdwdQXyGvGArBPS71XPPYRcHMoE3V+jpzpixBVZA+3qN+aGasQrhW4eeD5p
	oqOIvFyKpDC+kBOd45QmnOnqZw2oRpsZbAtX1QA1QOujVs/TJKhy57itdo1r2EwR
	knQXmQ0CV+PlVcgUPzySY5pIL1mwUqWff6ioVUP0+/d4JEdOtnx79ci35EGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707817856; x=1707904256; bh=lHYsTK1bfvxaz8ZLnxtMiOszwDEb
	Z3X5lHEYDDbn/s4=; b=ImQV3ToIG2iFqj7LvNzhWlLy0JJpcQkwHH8CPhHvPF5M
	fcGH6tgJDeM7mdornTeX3N/rp2b5+IiQrDku4RKRz4eibn98+wIbH95xgHOYhUhP
	KRFXplMeo6lmUMEhxttLPiKIw38XzeOvdhDup6drNVtf597M1NzwUA5gKRUlDCkr
	qNVPENfarayqRCd7xfPZFs0ZDHKsyHxEGWZllgpSGqgcloLNb0WexWxnkSzNNnSu
	CR6Sjo5tjhX4KM9YlzTJRRBICQWPh76iOok3n6w51prR+0qx8iDZp/VS2PWmzaZR
	BMG8EfBslDyJB7EPKvHhRbq3Z8bwZeGDgHobwJWF1A==
X-ME-Sender: <xms:gDvLZfHHHEVOk9EVqJDdwZqjypKSMXu9MV_5mkY0WkB9kufUQ705YQ>
    <xme:gDvLZcXDBeElJo3nFjgPksrliMVjZBMpXeJLcJuqKAWcu7nRNkZV8VJNTd7nTolTe
    pLUeSVR2_KW5de04J4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gDvLZRKxU0SaVK-LVEq_Aihz8OxEqONY9ITHaoAiKT5BTqsPiY4wtQ>
    <xmx:gDvLZdH8M2Z93jqDfmKi8QDO-FyZk_FbrJWJw8op6zgsZzF2Py4LXw>
    <xmx:gDvLZVUvNsTvd9l76WHdGPV-aKNFdj4BTkqcK_9Uqm0wnjIxdzLH_w>
    <xmx:gDvLZafzJYs9f85v-Xjcw_OAiHiVON9oOLpKGDs687AFRn7oe_C44YxTmoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F075FB6008D; Tue, 13 Feb 2024 04:50:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7723c9f1-fda7-4dc9-bb5a-e12d4908becf@app.fastmail.com>
In-Reply-To: <1707024641-22460-9-git-send-email-quic_taozha@quicinc.com>
References: <1707024641-22460-1-git-send-email-quic_taozha@quicinc.com>
 <1707024641-22460-9-git-send-email-quic_taozha@quicinc.com>
Date: Tue, 13 Feb 2024 10:50:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tao Zhang" <quic_taozha@quicinc.com>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Konrad Dybcio" <konradybcio@gmail.com>,
 "Mike Leach" <mike.leach@linaro.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 regressions@lists.linux.dev
Cc: "Mao Jinlong" <quic_jinlmao@quicinc.com>, "Leo Yan" <leo.yan@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "Tingwei Zhang" <quic_tingweiz@quicinc.com>,
 "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
 "Trilok Soni" <quic_tsoni@quicinc.com>,
 "Song Chai" <quic_songchai@quicinc.com>, linux-arm-msm@vger.kernel.org,
 "Bjorn Andersson" <andersson@kernel.org>
Subject: Re: [PATCH v7 08/10] coresight-tpdm: Add timestamp control register support
 for the CMB
Content-Type: text/plain

On Sun, Feb 4, 2024, at 06:30, Tao Zhang wrote:

> @@ -910,7 +1014,7 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
>  	DSB_PATT_MASK_ATTR(5),
>  	DSB_PATT_MASK_ATTR(6),
>  	DSB_PATT_MASK_ATTR(7),
> -	&dev_attr_enable_ts.attr,
> +	DSB_PATT_ENABLE_TS,
>  	&dev_attr_set_type.attr,
>  	NULL,
>  };
> @@ -964,6 +1068,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
>  	CMB_PATT_ATTR(1),
>  	CMB_PATT_MASK_ATTR(0),
>  	CMB_PATT_MASK_ATTR(1),
> +	CMB_PATT_ENABLE_TS,
>  	NULL,
>  };
> 
> @@ -158,6 +175,10 @@
>  		tpdm_simple_dataset_rw(tpmr##nr,		\
>  		DSB_PATT_MASK, nr)
> 
> +#define DSB_PATT_ENABLE_TS					\
> +		tpdm_patt_enable_ts(enable_ts,			\
> +		DSB_PATT)
> +
>  #define DSB_MSR_ATTR(nr)					\
>  		tpdm_simple_dataset_rw(msr##nr,			\
>  		DSB_MSR, nr)

This is causing build failures in linux-next now:

drivers/hwtracing/coresight/coresight-tpdm.c:1055:2: error: missing field 'idx' initializer [-Werror,-Wmissing-field-initializers]
 1055 |         DSB_PATT_ENABLE_TS,
      |         ^
drivers/hwtracing/coresight/coresight-tpdm.h:184:3: note: expanded from macro 'DSB_PATT_ENABLE_TS'
  184 |                 tpdm_patt_enable_ts(enable_ts,                  \
      |                 ^
drivers/hwtracing/coresight/coresight-tpdm.h:156:5: note: expanded from macro 'tpdm_patt_enable_ts'
  156 |            }                                                    \
      |            ^
drivers/hwtracing/coresight/coresight-tpdm.c:1109:2: error: missing field 'idx' initializer [-Werror,-Wmissing-field-initializers]
 1109 |         CMB_PATT_ENABLE_TS,
      |         ^
drivers/hwtracing/coresight/coresight-tpdm.h:208:3: note: expanded from macro 'CMB_PATT_ENABLE_TS'
  208 |                 tpdm_patt_enable_ts(enable_ts,                  \
      |                 ^
drivers/hwtracing/coresight/coresight-tpdm.h:156:5: note: expanded from macro 'tpdm_patt_enable_ts'
  156 |            }                                                    \
      |            ^

Not sure what is going on, so I reverted your patch locally
for my test setup.
Can you send a fix to make it build again?

      Arnd

