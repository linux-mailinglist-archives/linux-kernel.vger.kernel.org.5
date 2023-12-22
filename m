Return-Path: <linux-kernel+bounces-9869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6B81CC93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24F61F232F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7606B241FD;
	Fri, 22 Dec 2023 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyHlWWvE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59253249E2;
	Fri, 22 Dec 2023 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d099d316a8so1950285b3a.0;
        Fri, 22 Dec 2023 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703261572; x=1703866372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSRGLKk61Gx7n2iPSV+CfABhLdXJBJYaVEf5Qmgbq2g=;
        b=GyHlWWvEvksj81874yWgTO7rDnHHvZggLhoko1EcvtkmxuxTxY/HSuyF3Sk0VG9tqm
         +FL1U4zV4G14+5Sep2U/1sKaGgyBZGb082GeUDBOr2GzqmFOSyJ3rB3H/De+rMTLUcxT
         ZnEY/EOBMrI9O2PdkSikP12mihpMkOVPo7glOlcZJ5oxtvoJ2qLNolPm9AMlg8iAFZqX
         RYcqSlgq9LPyzOnUBsRegi0kPg7ExhTjL5CMV0rUHISAQj5GlxJs2dtKrX7Ctfz1TBnN
         q8PIDyDvVcGrNvdQ/UwZogNWgyUbXLH1ebFZeReNg2Eq5VinqSLuXwz8m5P4WGUV7ZZg
         IXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261572; x=1703866372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSRGLKk61Gx7n2iPSV+CfABhLdXJBJYaVEf5Qmgbq2g=;
        b=TFQBb+cfzbb42JZaxEh5ne7erS5WvqXdQQHRNn4kZ0NihzwETHItJP6cZ7Z+HPvAEp
         V5nF24WWZAHEQpCLvnd8X6cLzJV0msvBW/cQrkSqHvZO9mF3335ZHlNB+p3bn8GxsLOW
         QC/kbltgh3AWfuaqqJUhOfxSa4Ydul4UeWw0UHwMIsOY49cg4XzdrgBGZV/qFxcGXIQJ
         e1W9AuBFm1AwGWjZdFH4tUkUC8Lau995sA6iIHUxRCXeTUhtOgTMCSHz9BxydiAyKSTG
         c8k/DtywE6R7DmmHO/1+wYcIYtnpI5TxZ3t6EaJMnr+owKPde9xqhBdEWCJ1kJUyGHHW
         Zv+g==
X-Gm-Message-State: AOJu0YwiMPSMfwYQIsDCkkVlHHjcki7ipycQvpwmyvt+uFE35t7KfxOw
	mcZAOe7H6Km6VtW69KE2G2h20BGFylY=
X-Google-Smtp-Source: AGHT+IFKYhBMdHNX3T5Fp2jfNsCcmTkjMnd2Wl5BOROCq7E9ATKQiX4FxsNq1t+sQZvWeTYIUYgX2Q==
X-Received: by 2002:a05:6a20:394e:b0:18f:ef63:7839 with SMTP id r14-20020a056a20394e00b0018fef637839mr1756269pzg.100.1703261572571;
        Fri, 22 Dec 2023 08:12:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t20-20020a056a00139400b006c4d128b71esm3703714pfg.98.2023.12.22.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:12:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Dec 2023 08:12:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH 0/1] clarify intent of fan min and max attributes
Message-ID: <ce60c838-0fad-4bb4-8af4-a94d43092d4d@roeck-us.net>
References: <20231221225149.11295-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221225149.11295-1-ivor@iwanders.net>

On Thu, Dec 21, 2023 at 05:51:48PM -0500, Ivor Wanders wrote:
> In [1] I got the feedback that fan min and max attributes are intended for
> writing to the device and not merely providing constants to userspace.
> This patch clarifies this intent in the documentation such that future
> contributers don't make incorrect assumptions about them.
> 

Documentation/hwmon/sysfs-interface already states:

"
All entries (except name) are optional, and should only be created in a
given driver if the chip has the feature.
"

I do not see the point of clarifying this for individual attributes,
especially since that might create the impression that it would possibly
not apply to other attributes (for those not reading the above
documentation).

Guenter

