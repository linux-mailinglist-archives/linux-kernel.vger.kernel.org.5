Return-Path: <linux-kernel+bounces-5155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1568B81874B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A806C1F2489C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02B171DF;
	Tue, 19 Dec 2023 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="P1FOmpz5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C62171B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 56CF83B9;
	Tue, 19 Dec 2023 13:21:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702988500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4462tXyvX8m/dDm2VaEPF8Qf0tyEGqZeXunhv64sqpM=;
	b=P1FOmpz5vI/3M+LFLI7NhYcJfJBk0SxRKkmZ90WnMTjf4ndFUmk/hog/rw+QylMEiTLWzj
	dYNKTV5FELNlG8iA9AqQezWXL9R9jWzJ+3rn3EzsjPP4TJW84I38hPL5uWeebaNku9/Pc+
	Gzvq+jaVxThTY5ypYr+PT/kXjUOssuXgt5LZYtUbae50Ml88tQ/aV/Mdx/oAFzArVbxUSt
	t8VNfYcThNO5utaMcINZE2ESnmhi0vi0uQ7kz7VyLUHvpMiRFL5KD7QEsxDlWbF+Ssm04v
	Vb/gXBqWVXrPGu1OSnX38/hxj/4cjsBon/O1L5DVJdn234Z8l78v7E6yCPJdNg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Dec 2023 13:21:40 +0100
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>
Subject: Re: [PATCH v6.8 2/2] nvmem: drop nvmem_layout_get_match_data()
In-Reply-To: <20231219120104.3422-2-zajec5@gmail.com>
References: <20231219120104.3422-1-zajec5@gmail.com>
 <20231219120104.3422-2-zajec5@gmail.com>
Message-ID: <040fbc414bf7404046b12dfed7a1c647@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Thanks for layouts refactoring we now have "struct device" associated
> with layout. Also its OF pointer points directly to the "nvmem-layout"
> DT node.
> 
> All it takes to get match data is a generic of_device_get_match_data().

Isn't device_get_match_data() preferred?

> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Michael Walle <michael@walle.cc>

-michael

