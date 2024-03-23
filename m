Return-Path: <linux-kernel+bounces-112368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A98878F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7268F1C20F91
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E43F9CE;
	Sat, 23 Mar 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDDvdutb"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC21B95C;
	Sat, 23 Mar 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203422; cv=none; b=Lk7YUiXshQ+qMLYZH1u/mdr36RkWIbFe1BWziB6tFkXk+1s2e6XB5gY0y944K7pJ+wXSTvE6ShdFm98ATNehhwwYO3JMXxIua/Z7LEsZo6On6AQ9nzfgM903FWKXpyzdIjRnG9kPYs5unTNZw8U1eVJ9bX+JTqD3nIaFWhEYavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203422; c=relaxed/simple;
	bh=qJTAmAMF8xYhDLandJVS31/wW0EsQGnjbojo5zaJNTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKOE70UPnCf62eWX4BjyYli8OgRDilx4DCw+w9bg/ZySamDPg3yBUQjtNqzWCTATFxhnYI9ZGYXdcjRa2ii+beZYO6KY2w7IjGB1T8tz+41/JEgZ8vysl0reKw2dwVcAbunpNTmUzuq7aGeMXDzbQ8BMpretj+C3i08ij+A0cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDDvdutb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso1568133b3a.3;
        Sat, 23 Mar 2024 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203420; x=1711808220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT9Y96679eowSW16ewsMwYwbnF/n8rTC4DPmaGQVSOQ=;
        b=bDDvdutbNftGhEFFRKbg5YRqHBG52M+JNgk9NFmG7uAwLYChGQBWhJFviogptX9Ace
         4IN43nrXAPd9sce9N73SbRxenQQOmZsJELvPkpzVF/Ob+6h9ZFkdNOcy+RR3SqfDdI+A
         AZmPsqRrPXvxvQAv2sN5stNcviu/m2RDECNKEoV1u3lubOwPQRYqaBUKn1/wZqeCf9Ib
         B9YptiRCRA5YnuOl+OjHh9IcQuhV6U150xHxEjN/KRlhrBBvGxGdl3qOV93am7FOr/5X
         HmtTPB0fzgKvUyvZwT0Og3Ff5W/cV1WyvBf03vLcbB0RC2T1GDShrctuZLouk5yLBI5q
         pIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203420; x=1711808220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT9Y96679eowSW16ewsMwYwbnF/n8rTC4DPmaGQVSOQ=;
        b=vUXXREUUIa2D6ayc6pcbT6wY/sMYV21qbqGLhabIdtjvuoQMq7e5tv+Mjytl0OzSMe
         +tFaLR2ttwN0yUHZa5wmgtdblXoBjIGFOu8M/DKF3iCDmyYpmlv92d98+7wUW57ET2pW
         +L/rDDDqD5tj7MLysDW3iTiEoUo97narQtYgwWoJ09gffENHJcdqJxF4xVLq+tRjySbk
         kOU5i8xpGnUxtJoKaZT+Qcw5nH8+4bhKylj48omkzbAf86x5tFCncWU30JMKxwpfwyzt
         tdFowiuzKApTEF81dU6N8GGfoGNiGXxrVwjzMfeb3bzZMF8M7NsuUBu+tzxzRNM0vZ8N
         If2w==
X-Forwarded-Encrypted: i=1; AJvYcCWdB3ntBki2DA3iZXGLt0EGhZ1t63EFwIvWXUHuoW8xwIGzMQaIMgY/CCOx7vuXp3lsFlTDPMaHtqdnwxdOL8XeQ618rUb05sgxDxfmXgSEBpBzhArRQarq9OM6jcIeC5D2fbRYCaXDrfCDRH0dQhaAKYuDUhjLTVu+qBonmiCdzB5+KjYZ
X-Gm-Message-State: AOJu0Yw2zWr/0WGzTzi0Js5vK5BPFIhQFSbuQ8puyc6X4ampWxHd0p4B
	VVVtoyfv91patYGxnd0VeYNNI/jAgBp5aMhBg9cihFuX+5+vFtwV
X-Google-Smtp-Source: AGHT+IGZGLKChyVn+YDzIYRkVojMpFXoB8t4ZAnQmRNuwvKHHeRNeIhXEwcEg9AGsvz1HSwTjbqWxg==
X-Received: by 2002:a05:6a20:5085:b0:1a3:6c9e:1e31 with SMTP id l5-20020a056a20508500b001a36c9e1e31mr2060019pza.19.1711203419848;
        Sat, 23 Mar 2024 07:16:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mo7-20020a1709030a8700b001e09322cd1esm1609086plb.150.2024.03.23.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:16:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:16:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: hwmon: ibmpowernv: convert to
 dtschema
Message-ID: <587c30b8-9a2a-4ce5-861c-53bb87c7698c@roeck-us.net>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
 <20240322-hwmon_dtschema-v3-2-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v3-2-6697de2a8228@gmail.com>

On Fri, Mar 22, 2024 at 08:24:36PM +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> The binding has been renamed to match its compatible strings, with no
> further additions.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

