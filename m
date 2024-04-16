Return-Path: <linux-kernel+bounces-146876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083098A6C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6101F21BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09112C497;
	Tue, 16 Apr 2024 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCvVQ16L"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413E12A177;
	Tue, 16 Apr 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274047; cv=none; b=jiitbg4UC9/fWO51Wpc7sHQ0IESaAPRPtelsdZTOdzfzsn3v6l+TzW+Mnhzd+B2j3ddAMPnNUPKps/v2D8xAC5eBbXA9B8IkDIPv4juWpB/liHRrNx8nWvSNn2kO192O2uClBSyne6EvSk7T0BeN/VoCo2uQQm9DCzeUlH8VStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274047; c=relaxed/simple;
	bh=ow2JBt0MMuxqLvHc9QBerHjRnLSOo+VKZ+by8z8sXuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuBHT3nSPQmuVFbMab8oErnWkMbBxjKhuxQ5B9u3V0obdTvnc3BPAga1cRCxCcabCX5qbXuavYuiUVKRr5C9uTl4aHsxwax2iR2QXfM04e/wQ3eM3ncMMe9myO+25skcnnKsSIUFQHUYFKwuko7P8VwMl5qgW6jMTTGrVf60QUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCvVQ16L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2178b2cf2so40407375ad.0;
        Tue, 16 Apr 2024 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713274045; x=1713878845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9NsG/h7I1qAatxqJoqHkekmP7IXYPTVQrQqbrESwUc=;
        b=OCvVQ16LfVPBWUYTts4c0VO32t9tEzoH8PzrWX/VwShm6IyicfHBtXJVVCchvqL5EK
         /zmliJ6GJpquXYOt3DDQx5BWUZCekRnLpC/bhWDVpc9h78Lp1s0j7gv+91HNt+uRhho7
         CEnY6Yk50+40edxHwBNr1y+IwNGF1vutwfGYwD/6pi+d7DuOVAY5NIrh9ZqvUMLZ60bX
         l/VMI9XJen+ZtOB8/Hs+wgETrPyu6k5IfjNNXTKlUssFjQO5MagcLccrHpS2ni7RVNKo
         N1bwMwPhcFyFxtMr5TTgl793nFh7IqicKO78YX48wtLsOuWMHqiQ2kbTzoYtQ6H6l+4Y
         qtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274045; x=1713878845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9NsG/h7I1qAatxqJoqHkekmP7IXYPTVQrQqbrESwUc=;
        b=BO2+ke+1a3FNtdS+ICpuRQb5PDFXqdau78Au0Vw35lA7B7gc+vFH8KvcZW3Tjr8Ypv
         Ui3Fuytng05fSKv61TiKyx9go7y0cKl5ye5MyMZPaSzf4PlfkGAmfrtlx3bw20x8l8D/
         Nrp7sY/Kj0jlWiIzK0RH9uM2rxSbx4r5SEcDqPDBaPmgiW5TSAbRST39yW2PQZ6FUfgn
         lHUlVZarcejH8zZKqhVlFQIkOU281sAT44vetMYXnDYKqsQPkiHIRU0+QBXd6/949oGR
         p1gfLtkdJwguIkqJXfWXxZX75sL3rs1jNlFQ0K1tdAXqYtWVD7sZnbx3hslk16/JxJpq
         i1lw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Uf0ckGUpnzo6lgcPLBFYy6WMrDJTSp4AQdxTtrbEkDa4TMJ7WOd+FO6hilemTZcWfnil5sOjRqxDl7zRfoYrgYvBTgBzqd3mMhjm+n/lCf/LsFlW8HYp5YHzvCgqcgbQdrKsBX3CC7JLbfV+0GhkK/BP3CS9yfWM5qWp6UzamNK79te9AXwcOZqEpFX
X-Gm-Message-State: AOJu0YyJLaJpbqsUOsrRrXJqUCswO8LGGl8OH1NIlCAGKssJ00qzetOC
	hF/jENRnBAJBvlDub7lIUN5WFU23qyZDxXn/UncCGwCUfQxcOt4S
X-Google-Smtp-Source: AGHT+IGP81onBIJvH28QglUmjzIfpVxw2YNsM852qyC2z/16XKfVARYLzBRJGuaX+IsdfrPmgWbhiQ==
X-Received: by 2002:a17:902:d481:b0:1e3:cfc5:589c with SMTP id c1-20020a170902d48100b001e3cfc5589cmr17085328plg.28.1713274044687;
        Tue, 16 Apr 2024 06:27:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001e0f5034e95sm9680933plg.288.2024.04.16.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:27:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 16 Apr 2024 06:27:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
Message-ID: <7ba2554a-4f71-4ca0-ab49-59dbd03e1968@roeck-us.net>
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-2-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330112409.3402943-2-luzmaximilian@gmail.com>

On Sat, Mar 30, 2024 at 12:24:00PM +0100, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
[ ... ]
> +	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev,
> +			"surface_thermal", ssam_temp, &ssam_temp_hwmon_chip_info,
> +			NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	return 0;

	return PTR_ERR_OR_ZERO(hwmon_dev);

