Return-Path: <linux-kernel+bounces-29459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201F830E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432071F26724
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874225578;
	Wed, 17 Jan 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvnPzArD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3B25562;
	Wed, 17 Jan 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526606; cv=none; b=WJr+14bR/XZHzyW/KFLM5pGtIRjXFU6nnw3XKILQDdZvcaIKavrKhvV4eFZRLuJf2NukF1avihpf/9/QqzROZPmnrEr1mRcI3JVbxxCpoRrbzlxgQ2D+k6ecgtyXHVuSZgZlZ+OXupi4p8DEkc8ZPyguy2hNwVs23XdPyPEcIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526606; c=relaxed/simple;
	bh=3AY9LGw6/TkBoROmZw0TC6yg8B3XpOWqe162rh+rYA8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj9fQV4qa3fVhAlpbXsjZ6I6ofBkXbmRnBF6ZR9cLaOmW1E8cQIPf6WbPB0kxHO9uz7jOL1dFxlUgA4C+ttig286/MXyndahBevgtLgJHMr1VRiKMkzNAu5HHltfBrYt8nm70HfGNpbjJnNFdpEhQ1J6kbZ2DR5kM9ETH1Qr2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvnPzArD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so9385554b3a.0;
        Wed, 17 Jan 2024 13:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705526604; x=1706131404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgz7MUVBcIvLhtX7IpLAmxqdvaGpE/thV4ki6p4meGA=;
        b=OvnPzArDGHA5YfmWh0Ry9ev0JClR/bNG1qscMfFfqg0qvbiFr3zqKolm4Kz+myPslV
         RLTIXBoluE/83bUnif5K1gDY02/+UK290MPBIUqReKiQ0TTvoftur3yUEhasyYoz+uNo
         ZNtrAJ9GDZsFwD+U8UvtygzF8zWB1qZKMi6X4uQClkuOS0t9JwUtNm7rcsz7wIkMgzsl
         KrvhjibwHUnsAJfkqjSNhtbcuFOwiWZs4C1Bt0HsMxDbSjDuFffV3ZVHjNqXWK0ofo7v
         A4SSN9U9R8V4aQi+7LYuwoBKh+z0HRnewux+Y3NOjiS5m/jg9bz1jSkvNIS9TdSFYBJZ
         6rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526604; x=1706131404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgz7MUVBcIvLhtX7IpLAmxqdvaGpE/thV4ki6p4meGA=;
        b=JN8N+yorhQcajV7bEK4DmchmCx06XB8ejYrFZZzQGdLzUetW8egPF8qRlrQGqTarm2
         LKsd7ByQujGeYYpo0AeoY4soMLM/MUmbCMdiqkigzQKiOEUBzbEtWPsZlxYXQw1bC7og
         G1AIjnpT7M+CrEnBj9n9JCJku/2QnqH7b1IKGuATQz5ObESqIhI28R4s02sdwZP0aXEK
         7OJbiZTjUhvlkQtS/e8W9vnn2oMYuN32H3FBvWU4rF5btmbVlF6ZmvRIyBesa0N2cb8P
         HEyt6a2NbfDCvKaEq8X0ZTqGQCqACPHKfUA0qquORSZXkZFYfNXvK6TFhszbnpinY59W
         uPyw==
X-Gm-Message-State: AOJu0YwJUYdIuYTD17nb5ywnr6ehem4aqNoTj6Kmpy70RWXY8kSTQ+pD
	BDHYgtTB5YfGfOACKfsg7ps=
X-Google-Smtp-Source: AGHT+IFu/ROGIs9WmjuksVHTQdsxmN8PGo5qkkiBnukl1zuTNP2GEIu8oEv30rHze7iwegJY+peXlQ==
X-Received: by 2002:a05:6a21:329c:b0:19a:5c85:fff6 with SMTP id yt28-20020a056a21329c00b0019a5c85fff6mr9472967pzb.33.1705526604076;
        Wed, 17 Jan 2024 13:23:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020aa785c6000000b006d9b4eda6b0sm1902967pfn.157.2024.01.17.13.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:23:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Jan 2024 13:23:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: ina2xx: Describe
 #io-channel-cells property
Message-ID: <6d097147-0bd9-4f80-8b58-7bdb2a811acb@roeck-us.net>
References: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
 <aa303b9fe3116e7f98d6b72822f7f57694366db3.1703077926.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa303b9fe3116e7f98d6b72822f7f57694366db3.1703077926.git.michal.simek@amd.com>

On Wed, Dec 20, 2023 at 02:12:14PM +0100, Michal Simek wrote:
> There are two drivers in the Linux kernel. One is hwmon based and second
> IIO. IIO version requires to define #io-channel-cells to operate.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Guenter

