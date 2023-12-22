Return-Path: <linux-kernel+bounces-9871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B503981CC99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C40D1F232FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CEC241FF;
	Fri, 22 Dec 2023 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYCFm/QC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDC241E7;
	Fri, 22 Dec 2023 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3cfb1568eso17458175ad.1;
        Fri, 22 Dec 2023 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703261660; x=1703866460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+Nb5ElqeFtz92dwwWUYJikxUc/joSbA/RG5MSSdKsA=;
        b=NYCFm/QC3NyuNjSs3pLkM2h2oSWmwrMbzoPpx8MXcMwv9U4JvUoQeeH+8Auq88hbpZ
         hMo0SELCRNjEoqXbTfA0jwsJvw0weJqd4JwaUtunhDbfJl/FZBdHhxFdnjKSf98eqTDm
         lGJPO4k+WTz1HRFLXt+RoB2/2x/fUQm8oQ/5X6Brd5ke2hnbWnWZgym5g5oZdyojKWGC
         FPS8ruqSdjLn4VshgbHoIqfClba0NdKVNUOzgFAUzCIVif71HVCYXxMA7oX2bPyUzK+1
         UzXZBaZ2+16hscOa3arMBxJfsHfYXPwlz7/OQhYWP4NYI/5MpZH403dgPoUx4aobxYtW
         nAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261660; x=1703866460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+Nb5ElqeFtz92dwwWUYJikxUc/joSbA/RG5MSSdKsA=;
        b=PC5Sc0JyFCA8cjV/L1kkeiojTvSF3OwzElVeo8t7ZqG+bNeTepXj+5fw4AzXwLr4D2
         UCXQGQRbk7ehsGCEatyKjN8d2TwLO0vbrw2eaJBik5pi09akjPuQYZm+JqcKb6DTRnaF
         9tYWY5yJG+jjIxpwtPksRaOWmhhZeHmBwErnuiVEgrwQl958vSe9xdGSNJTdQduSzhu1
         aj3SR8211/xy6C4SDqIaOUNWBqau8Q9vNctTRYvFTl8VmpG4+01B5ONLz7m+mBBogYUf
         sIGXu2q+5VB9/rZOXq15PUUkYP4PCMH7dM7tU0HVnNplB3JAxR+O1KCvrDDCX8Ph7aG0
         GTTw==
X-Gm-Message-State: AOJu0YzChsDkFriWkUS0o99k+XLkNDV56yBQfgAppHBGQh2mUdun+J5m
	ZUVqAHMbwMrxRF4FPH80erz1xc1rxRo=
X-Google-Smtp-Source: AGHT+IF+nPY4+R7yComX/08RTlye+Xdlvwaz+D5kUJkVvDvZyMchxs2F2WvKVFBlHyrzbin8bpaNoQ==
X-Received: by 2002:a17:902:690c:b0:1d4:13ca:ab27 with SMTP id j12-20020a170902690c00b001d413caab27mr1330930plk.69.1703261660354;
        Fri, 22 Dec 2023 08:14:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d3d8c04331sm3638637pld.64.2023.12.22.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:14:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Dec 2023 08:14:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: rdunlap@infradead.org, corbet@lwn.net, jdelvare@suse.com,
	linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, luzmaximilian@gmail.com
Subject: Re: [PATCH v2] hwmon: clarify intent of fan min/max
Message-ID: <632bd36b-1652-4c74-9d78-ddea6ce77a00@roeck-us.net>
References: <40285311-8adc-4ca9-86ce-27c8b723a102@infradead.org>
 <20231221233133.14978-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221233133.14978-1-ivor@iwanders.net>

On Thu, Dec 21, 2023 at 06:31:33PM -0500, Ivor Wanders wrote:
> This adds a link to the hwmon sysfs attributes in the hwmon patch
> submission bullet points. It also adds an explanation denoting the
> intent of the fan min and max attributes.
> 

NACK, because that text would be required for _all_ hwmon sysfs
attributes which simply does not make sense to me.

Guenter

