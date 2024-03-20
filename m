Return-Path: <linux-kernel+bounces-109264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CAB8816F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A783281A14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77D6A8B5;
	Wed, 20 Mar 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R930Tg3O"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD76A359;
	Wed, 20 Mar 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957612; cv=none; b=ahhE1lEeNJ1bK1iHR0s36/7qKf9lWi2//wAWtNiFbM4EM6JitV6/2tL+urk4snZorCHEHF21v7zmW2KyUO/n5wwT8P1Ilr69VQhhoKfPxSpQDjDKJnLLO2JFKq1ghnGnjhjZb/05X2+g6rhNtzK+oQY3m9e4WbbJ3fsx8ARPQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957612; c=relaxed/simple;
	bh=u2ficWTRB7/C92TP0dSjSn7oEUj3yvr5zCepFHQnHIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfGgBbI5smJWX4engQfi4JdFJAmPq0Osy+ZT5C6QVy7MzDfRplBt44p21/msGfbiPPtfS5o9jsoinXBVaCCeCUt7af+4QlNS0kezddIyUEFB4MsTQV7CM/VYSl2O8O3Tm07wqUPEuw+s9OsHzW0902ECdeeWmnlyCrt+keCDPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R930Tg3O; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso198663b3a.0;
        Wed, 20 Mar 2024 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957610; x=1711562410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEaZmuSwz46Hcw3JWMaFjB/vxwT2qH65FH7pBddW/iU=;
        b=R930Tg3OSKNJNGQDcI/72Qrz05iW4IV+o5AdjAP5Wm3PmPh+V9dXm+63zrT9EJZ15P
         c0hn6K/o+j/ZlvikOpa9Ay+4StVUuejb/Im++iuw5kh7WBgRr72gwRBGCZc2UY2bf49o
         B/i7Xvye+Y7mXzc7xXCotsf2Ks1tvo7xgWADBP5N5lPV8REGBUpZ0uyR2CWB8gB0KSLh
         zTOQGlr6/3FCawVvtWpmwI+6P9PIcoDY6fTmUG8n63AOjuHQQgyHLkvKwlFrccNFqY0O
         reOYMEItyWO7hWaN2vYyVRcmIYjDTl9a0iwMlDevm3zdf7mX9yPHdDyMhBLiDSk9X1Z4
         QRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957610; x=1711562410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEaZmuSwz46Hcw3JWMaFjB/vxwT2qH65FH7pBddW/iU=;
        b=k3PoYt5myymTZMH6qECyH5FwHztiecHsowZahWi6cqcj7+OD8QLcXlXIkxV3+ZceHO
         +AA++iyFLgipuEM9gL/OqTPUlMW0mf8hmlqKrB4bNDSe0A/29cWOrLgjSSPw52QUl+3h
         BYzeFVQyE8z39EWYSdBYDRQrv+F+yjcmsU44RM4Ln3AZDCAxp/Ry82x38okizH3osNAK
         Z3ThqBOcAeETTuPxDmjd/9jVAn2SH1OR77rGxAp0InAb8fDlqAcfQ92swo1gYyDUZuao
         dWkYYcxWQwEVPjxNa94p+Aiccwg9yestra/S7rq3dm17kqXvvARZwOF06te2kJ6DPGl3
         SfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGuU8tFJxw1yuifR5LIvVnsgFbw8ZMidNoxypXYRAiClvXPBkmfT/IgvsRQ6gZdLQmForL9rHC0PqO7/wixdGy5ENNho2xB3DdlQqMwACqa+tcUSge/p4azXdRpUoliTZvFjcBxsnozXAwYpiw1UKcc7SaOatOqUqaxcWrmsMNNAAmDYIp
X-Gm-Message-State: AOJu0YyixEGfEVrygLtTJQAs9NIFRhMirWFKmOP0WAQJGkNeEqcuC0qN
	UHb25b36AWf1Q3jVc1BZAokGve/miwUf50Qr0Jz/vNYwNhunX6aElLqRcdts
X-Google-Smtp-Source: AGHT+IEmAvWRUh6LSC9BFmM0+cCgly0PVhJKwMHdEfzIHpTtRrsZ3MGXZQIy44f3qojeizWQddZYgw==
X-Received: by 2002:a05:6a00:a12:b0:6e6:e587:3c30 with SMTP id p18-20020a056a000a1200b006e6e5873c30mr19298221pfh.25.1710957609975;
        Wed, 20 Mar 2024 11:00:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s40-20020a056a0017a800b006e74a85f862sm3053167pfg.146.2024.03.20.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:00:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:00:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 1/2] ACPI: IPMI: Add helper to wait for when SMI is
 selected
Message-ID: <f7ed4f78-b5cb-4a46-9c13-d67af3ba0700@roeck-us.net>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320084317.366853-1-kai.heng.feng@canonical.com>

On Wed, Mar 20, 2024 at 04:43:16PM +0800, Kai-Heng Feng wrote:
> On Dell servers, many APCI methods of acpi_power_meter module evaluate
> variables inside IPMI region, so the region handler needs to be
> installed. In addition to that, the handler needs to be fully
> functional, and that depends on SMI being selected.
> 
> So add a helper to let acpi_power_meter know when the handler is
> installed and ready to be used.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

