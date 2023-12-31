Return-Path: <linux-kernel+bounces-13777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29C820C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D82281E5D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A95944E;
	Sun, 31 Dec 2023 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT6S4JA1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686F8F57;
	Sun, 31 Dec 2023 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4350757b3a.0;
        Sun, 31 Dec 2023 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704046812; x=1704651612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIpTps2Gd27tNr3Tgv5wfCAUbFZsgb7+4fv9SKg9nU4=;
        b=AT6S4JA1hm3JLxw63A0E0gya3UrR8Hsru2/0W+ZyJ9do84/2G+CGNwA9fGkTybS+YU
         GVQ+Cs8qKGbklSGv4N/cVHSki3EcTovVBggJUKrzlYv9RoOeH7vyYY0ybEBwdX6pcJqd
         SVPYe/QRHgMGIZP6xhHZFbErJCCu6Bv7uipicqU/ThJN+30XEi/TxIS4eKUMmZ/Q08Q+
         tO1RrHL8BM9PN/4JvmUd6o0GDoP79eX+3Tsou3er81UZ3qhnYENlAa013tEDBf71uUEg
         tcgbBlJrTYXbx88dYgG9pqOQdBUYqu0+Hv8cqP77P6OCsdS6gkbcBDT//SWZOd+LA6vc
         XPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704046812; x=1704651612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIpTps2Gd27tNr3Tgv5wfCAUbFZsgb7+4fv9SKg9nU4=;
        b=N9JGEd2bA/wWsn9fHW9TfC7ZA2bJALSeaX/QXPiO/GD0SySRIgbzGbjUwNwRB3jmTd
         16ECQAgR2ie9phd7fdiipxyWJ6x18q2aGfoOApOXcG6N5SxESrxli7ChkDfXrPa0Vo14
         BpBUaa7Z7U0myvo6Lu67vMRrfqD0xWVX1UxfgPAB+XdVlyAkRGhBLACiWRwBmbvot4GM
         W8hUcDQufa1W08cUZEtIW0QSPXwAL558pZ1UM1sikNskhqRnsFJJJrPfLT0uueuTSXch
         88zVo4/EOYGrbwf+YZgZiyuvuNa9hRNZVVjju11RSGOPUfE3qzFKEDx+P8+FCbhDb7tf
         M6Iw==
X-Gm-Message-State: AOJu0Yyxl5perCRYx4sZhBmC2y+SEmcOxnBRarnc2fm3/n11J/P6N81Q
	VZqYEJ1MFAAaQBiGKuveUsc=
X-Google-Smtp-Source: AGHT+IEG0seqytSNt5hdasgs0H+g4deXdxR0yd8qUYx+kg461NzeRl3WO0/HHhgneD7MctaaEsCEvQ==
X-Received: by 2002:a05:6a00:1152:b0:6da:2f76:2421 with SMTP id b18-20020a056a00115200b006da2f762421mr5144804pfm.38.1704046812576;
        Sun, 31 Dec 2023 10:20:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a001ac600b006d9a48882f7sm14189381pfv.118.2023.12.31.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 10:20:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 10:20:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: (lm75) Add AMS AS6200 temperature sensor
Message-ID: <d25238a7-0193-4025-950e-086ae2ce853b@roeck-us.net>
References: <17ba2dfdb3d25bf1b5b4ed9f858b6e28902bedbe.1703127334.git.alkuor@gmail.com>
 <d1686678991bf8ee0d00cb08ca046798f37ca4b3.1703127334.git.alkuor@gmail.com>
 <ca786cac-aa83-4795-8b91-ee85b07bdcfa@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca786cac-aa83-4795-8b91-ee85b07bdcfa@roeck-us.net>

On Sun, Dec 31, 2023 at 10:17:05AM -0800, Guenter Roeck wrote:
> On Sat, Dec 23, 2023 at 11:21:59AM -0500, Abdel Alkuor wrote:
> > as6200 is a temperature sensor with 0.0625°C resolution and a
> > range between -40°C to 125°C.
> > 
> > By default, the driver configures as6200 as following:
> > - Converstion rate: 8 Hz
> > - Conversion mode: continuous
> > - Consecutive fault counts: 4 samples
> > - Alert state: high polarity
> > - Alert mode: comparator mode
> > 
> > Interrupt is supported for the alert pin.
> > 
> > Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> 
> Applied. Side note below.
> 
> > +    Datasheet: Publicly available at the AMS website
> > +
> > +               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> 
> Apparently checkpatch doesn't like this way of pointing to a datasheet anymore
> and reacts with a warning, demanding the use of Link: or similar.
> I don't think this is appropriate, so I guess we see the first instance of
> to-be-ignored checkpatch warnings ins the hwmon subsystem.
> 

Ah, no, this was a tag in the commit message, which is indeeed inappropriate.
I dropped it from the commit.

Guenter

