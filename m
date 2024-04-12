Return-Path: <linux-kernel+bounces-141761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184558A2314
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98B82846AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086124C6C;
	Fri, 12 Apr 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQoleHqJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B6635;
	Fri, 12 Apr 2024 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712883450; cv=none; b=UzAS0RBe9cKIpuEP7PcrhnBEUP3HwPC+Ou3DIYLDW3l3cukpNuRpBJd6snjxVIcrr6uCpx7f75mjUok/MKHnDQxBkZI/ZWlOLFn+2cmRbaXKa1YXmHKj3R9JeA8V3dsl1OSw5PNbUxt9C7RX7R0lx2HvtY0C9OqfgQesgDTOtbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712883450; c=relaxed/simple;
	bh=MIfoj+MveIgyU2tpQCyROYfjOQSPryYHNoW/UUrNq+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3QK4kLcccBL+J82vgqY98I5wXesFiJUXMbnmHoglwUnEDszjcWST4HLGYHSeXsvjztlL0O6WzLQSbEHZz9GrBPq2dPX/OTHyjwtBOvdqn/0WKRbt1I2oiQWMxGJBig5H74SyDkJ0m8/HXUCAoGhYCVpfWfG8BabQsAkwBxc2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQoleHqJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3ff14f249so3267795ad.1;
        Thu, 11 Apr 2024 17:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712883448; x=1713488248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXUPX3W8MoBNn+iv4m0YCN2/u0CoFiw63dWg/F1IegM=;
        b=NQoleHqJGXU3MW86bbZHF1rIB7ok5HnoFgNlhF/hPA2Cp93A440ZBdAC7c58DQy9BW
         Il3SSuzMgNXoulyOWoz7MI6+EJLuQYKBkPYxJ+DV+65aihiLK0XwqtrvwKI+mstQTyaA
         fD28RhYfCvNwpel5K8ZgB/PSrA/wvu4/JZ3OhX7o0TFNSPiypzkKPrIUyM88V5AnJZXV
         eilXhZj8JrxeSiv15GGsMSaxoabiDBGlsSVJBq+teEWeu5vFEKG+MCb0hPY4jHjz1Zg5
         GA5WJ3oq1hTKMhYBBJeJfCT8VPYRqnXpf+yO3Zk1VsSvz/iw1VIHn6I74mX2+UDyoMHV
         2zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712883448; x=1713488248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXUPX3W8MoBNn+iv4m0YCN2/u0CoFiw63dWg/F1IegM=;
        b=lZGorXAv5ZZBcJVLBpGWR0/Jk5ZHhedDTr5u4t3vLqJyHXyn+uvI+3qXST5enpxMP0
         uhY5Q+a/NfZ1/3khnAT7OrC/uwhEidKrE68vgd3rqz3YuBmBHfVJ6drG2nQzflmB70pI
         ZjxEL1QA+X85VqjCIBFrqKI9fdq6ZCx4OC8J7yGl+bpgmhSctdUtyW/hAxy4+DmZLJb5
         etsF/vtulvmDwGZ4aCWQzmZkvv7N5fKRSAvs/e2DH6L7E4cK9pgoyLNM3KrpNkIrU9rd
         M+ATxj6Of1y3DtrmmcgHxvN8BE6XrLgSsY8ohoWv6X7F2oNSy4LLH/D+iGenBGF/xcsM
         dioQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEOtjIw9CtoAzrOBUjkALUnPwDuanFNoYHU+rXZ+qf+VuoBkKDpLFD0nFtz9PptJOyWedYMdhVIlFMrKEKpkk/W94dPSY/cmzFoA+4fFGWNyx11ni8Y+fGIrC5MI7n6EBLDEGHiwd9dBSMF4TM92zyk5kHcPDjfdTnbtslBlXKpDkSknF8MiwCe77deMRJcRoeAiQLgWB/DlhCTiWTYzDa3IYPG9DPMEBIbA==
X-Gm-Message-State: AOJu0YxEL1bNJeXGcJuXvRjsPdrJwAv534WLL3oB8xv6HIG4pRfa8Xgb
	y+8dsTD4IA5TePpFl5EQ4dgEB64MXN/ckHbNcMAxDB1rzOaB6xgP
X-Google-Smtp-Source: AGHT+IF3fEVLEbfpH2K0DBl22UuXRCWrmLZcvHt+WYnbX0VMziEsqGFEm5HUu+wPYMMc+73AHxAjCg==
X-Received: by 2002:a17:903:2303:b0:1e5:5c69:fcda with SMTP id d3-20020a170903230300b001e55c69fcdamr3572445plh.26.1712883448007;
        Thu, 11 Apr 2024 17:57:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b001e25da6f2f2sm1788084pla.68.2024.04.11.17.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 17:57:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 11 Apr 2024 17:57:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Mikael Lund Jepsen <mlj@danelec.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@weissschuh.net" <linux@weissschuh.net>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: fan: Add hwmon support
Message-ID: <e5398618-5140-4553-8dab-6f5ad73de805@roeck-us.net>
References: <20240409213323.8031-1-W_Armin@gmx.de>
 <AS4P189MB21333C826C173582E12FFE3EBA062@AS4P189MB2133.EURP189.PROD.OUTLOOK.COM>
 <e6798f0a-5e50-41df-ae3e-0069c16abec3@gmx.de>
 <b0899d74-79d7-459c-8f2d-17a17a0f58d7@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0899d74-79d7-459c-8f2d-17a17a0f58d7@gmx.de>

On Fri, Apr 12, 2024 at 01:38:11AM +0200, Armin Wolf wrote:
[ .. ]
> I just noticed that the drvdata argument of the is_visible callback is marked as const, so i cannot use dev_get_drvdata() on the resulting ACPI device.
> Guenter, would it be ok to make drvdata non-const in a separate patch series?
> 

I don't know what you are trying to do (the is_visible callback
isn't supposed to change the information passed to it), but not
really.

Guenter

