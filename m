Return-Path: <linux-kernel+bounces-105651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17387E214
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6B11C213AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB701DFEB;
	Mon, 18 Mar 2024 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="by/cq4iX";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ak2fGyJp"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2E1CFA9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728160; cv=none; b=FxyLmw8PHGJMq9qejWt79I3Of09xSDDUQeuCPqHdHzYGAX4Jgs7us+QSKphdBPcvtu42YiysNCbaD6VckzuznLkW4zvjHePZ+ZaLTHKxnwExe01X7+l01nxMYNsR2l0kPybUm7vyjSY3kWD36lNI4hxJ9WyGR8JgQU5OTtsUcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728160; c=relaxed/simple;
	bh=jIv2QeeJVYaC9+Bza9LsMgEwMk6QP2pxph52rQ3Solk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSWbYIhuUzgTdVHjuza1DZPheHSp736jDZ6exxLGhQ8mBVCg5dc0AO8GOTj6nuYHmUtdul1ioMIALNkIQe5mGcGdNi2FgNFhvV0xlyOZugvy4y5txngBj0PGDgb77DgTsS2F690NB2EWyfnXTy4b5dkxnTAuCh5mjXfuER2/Jug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=by/cq4iX; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ak2fGyJp; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1710728151;
	bh=jIv2QeeJVYaC9+Bza9LsMgEwMk6QP2pxph52rQ3Solk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by/cq4iXu+dCYTw8ZSEZjaQIFZZEBsLF5xZrkcpQ/iNsAWutgfDYN3LhH1ZiOrU3p
	 tSnHzl7COUUtwFOcO4s08RSopgeN75+0Vbh5CjMaRYTRVPz4tbaOUjnYDVC08Ud4AG
	 WXtw6qyFhVoVBAYv8wYDPLYfM/yoXVexPDBBNCGgcqRcIi3pWpiBp1bmF6CXFO+xCK
	 P4r6RBPu+3+AIFjE2zd9ci1oKCU0jMIMVkC4vIgQ6dBNEhYlGQ5gEEfOBwBHpV2HHA
	 L5/MLmLGf6wx5OBtU8BU3SiX6bU65MlZPxLUIt5tOT8hlijCCNq1lgORg56ky1GzGD
	 n3yFh6waS7H/g==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 82B2D4C9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:15:51 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=ak2fGyJp;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 07FBD9D1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:15:50 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dd72cc8590so45318185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1710728149; x=1711332949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZRLjO7yES26IA5YTCwawjya15G39VD0oILYUFB1uhQ=;
        b=ak2fGyJpDNiFolycHx4ogCk9+RcToZ+fydmfJL6ykRf/l8AzWhyY8bDUjYup0Ta0DW
         U7cq8t8UUqUiQSuBT9wEQ3fGcP4VeX1GsTUT7LaMGFJEYX+nNNawE4H3H7THruucWjT2
         /cPO6bf7QlYvbgY1UaJS5CwQVNjBGw/BPNLU2HJZSBpxYhty7OWCVs1zi8gAhRSb256o
         XZgqwXavkPtuhLc/hytEAkbpQWchp52zcOAJhkq1yVo0re2lMxZwNE75gkRUyNORbLEm
         kopiUHcSiE16ls1h29cGL+ErH/j3qnz+YdEHkmeTxDU+kNLPW/M2KLUCU0qVB3/BKaIk
         YGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710728149; x=1711332949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZRLjO7yES26IA5YTCwawjya15G39VD0oILYUFB1uhQ=;
        b=ME+0MOg6XyKXqwhNNOZq/CYUOCExqkEYTXu2zp9piv4MUYhbhU6tl7t8mTnXdO+kkk
         GKulGfwhawPtQtouN9BC3XYofFxZh+/7AqLNyEPdEngVZIo8cT2b+L/c065dylFrI8Oh
         BNg3XEevySlxsasCh7V2oYuIE8trakebdHbRs/0cdT1mTx8XPr5AERShTHQTnmjIPFxQ
         1ZP8W6N6USVYq3Z8Yq8ea3wIzu4B38wcy/DTa/LQpC5PLGcEHKgZgruIqhm3euOg30WJ
         JldQ0vjc2KhOOg/adxJL9X7eLfMWs4sgdrenbhGOJkiqag8luKg5XUarmwueMc8gaoJA
         XCBw==
X-Forwarded-Encrypted: i=1; AJvYcCVJZKIZBYmeoId5QMNdu/lzon3pjP2PQrycdLF1zaOvi+WfFy34v3+Fce1WWAnrzJE/p7Bx6LrtxNvnUCjukDdCq8P+xW7rmUn4+HDP
X-Gm-Message-State: AOJu0YxBEKk1MNlPFufQF74yOa7EDJJeTS2Yr/5Ox12fdecMb/dMJlD/
	PDaPFhzrnbKGzAlvcSMJOPCF5w9zZk6xige5mgnjss2EkTcE9xMbserWGEPLXaEHixYTTQ/6K67
	svdNPg8ANqfZODxC24e2+H9vvAe3LQnS+G4CAGHTixTo2QozO0Db/SYEboZp6NJg=
X-Received: by 2002:a17:902:650e:b0:1db:4941:f703 with SMTP id b14-20020a170902650e00b001db4941f703mr12482669plk.15.1710728148956;
        Sun, 17 Mar 2024 19:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCfH8jMO/aZB8DOpQyNXjy2tRo7yh1p/1BZpESd2N/XQNCV+0cg/uTQfDxBRcLSP0Q1MAffA==
X-Received: by 2002:a17:902:650e:b0:1db:4941:f703 with SMTP id b14-20020a170902650e00b001db4941f703mr12482649plk.15.1710728148480;
        Sun, 17 Mar 2024 19:15:48 -0700 (PDT)
Received: from pc-0182.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id mp16-20020a170902fd1000b001dbb6fef41fsm7918365plb.257.2024.03.17.19.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2024 19:15:47 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rm2XS-005oGb-2I;
	Mon, 18 Mar 2024 11:15:46 +0900
Date: Mon, 18 Mar 2024 11:15:36 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Message-ID: <ZfejyEvPIncygKJ9@atmark-techno.com>
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
 <Zd7hSOw3_zosyrn3@atmark-techno.com>
 <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
 <Zd7qz1Qte8HWieF_@atmark-techno.com>
 <20240228142441.00002a79@Huawei.com>
 <Zd_zB_ymxkx0HB3q@atmark-techno.com>
 <ZfPg-nMANUtBlr6S@atmark-techno.com>
 <CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMknhBG_kJx8JPvTBQo7zpy3mFAkUjZpRY3DLBfXt+39nRJWiA@mail.gmail.com>

David Lechner wrote on Fri, Mar 15, 2024 at 10:53:36AM -0500:
> How about using udev rules to create symlinks for each device based on
> the label attribute? No changes to the kernel are needed.

Right, it's definitely possible to make symlinks for each "device" -- my
patch comment links to such an udev script "solution":
https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/toradex-adc.sh?h=kirkstone-6.x.y
(the script is launched by udev here:
https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-core/udev/files/verdin-imx8mm/99-toradex.rules
)

My conceptual problem with this is that this makes symlinks in /dev to
files in /sys and it feels like we're crossing boundaries.
As far as I can tell there is no way for userspace to create arbitrary
symlinks in /sys, so I think we could have an interface more
user-friendly by allowing paths to be static for users with multiple
devices.
(I guess that's a weak argument given e.g. disks etc will also have an
unreliable name in /sys in the general case, but simple programs don't
interact with them in /sys and can use stable links in /dev so my
expectations here aren't quite the same)


Ultimately, the problem might run deeper in that we're having userspace
interact with the device through /sys and not the /dev char dev... As
far as I could see /dev/iio:deviceX only allows reading buffered values
and doesn't have any ioctl or other way of reading immediate values as
is possible in /sys though, so that'd require quite a bit of work to
duplicate the interface there...

Perhaps I'm just thinking too much and symlinks from /dev to /sys are a
thing in the IIO world? I've not seen it done anywhere except in that
toradex tree when I was looking earlier.


Andy Shevchenko wrote on Sat, Mar 16, 2024 at 10:14:35PM +0200:
> [...]

Thank you for the review!

>> +#include <linux/of.h>
>
> What about ACPI?
> Please try avoid hard to use OF-specific code for the new features.

Given my suggestion here relied on users giving manual hints in the DTB
I'm not sure how that could be interfaced with ACPI, but if you have a
suggestion to make paths static that'd work with either interfaces I'd
be more than happy to give it a try.

I'd also like to add that in my particular case it's a problem created
by the OF interface in the first place: devices are currently created in
the order they're parsed from OF, and it just so happens that this order
doesn't work well for us; I'm not aware of how IIO interacts with ACPI
but perhaps the way the list of devices processed from ACPI is "stable
enough" in practice?


Thank you,
-- 
Dominique



