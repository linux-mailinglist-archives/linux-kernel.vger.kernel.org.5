Return-Path: <linux-kernel+bounces-51139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA38486FE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC28D1C2139A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646275F47B;
	Sat,  3 Feb 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/juOOCy"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E25EE9B;
	Sat,  3 Feb 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973005; cv=none; b=s2ugzvtvvFQK8IxPieuzVL/n/zogbW51JYGYLzLW1v4Un3wt3iBMNN9KzYuolhHRB+aZZL+Zi2B1Y91RZQKeByMG787SYo6Iq7xfYOl9kSd+nNE5Y9fJjQgE90XqjR106MjDhY2og6xGd5t+qTReP7xzvahp502hWOwDiESrzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973005; c=relaxed/simple;
	bh=rm+33P086YaogmsaE3YG2LMaWJ2e0KMxXe5Si8IvvAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvtNN3eLdd787pzWlQQeG7tonUx9SJ9jg0LfbsZ6UhFALDBO+VsDqAJB0ImOLg+zKgIFVMKmGpiHyofMadP0EReA5FCVVciyYBnruWzOLW6W1v2yZljne5aq1/JYQ35kjX4+cM9Ckytko90yfEViVUup5L8MmOLBgATB8Ccsv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/juOOCy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d746ce7d13so25451835ad.0;
        Sat, 03 Feb 2024 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706972993; x=1707577793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y83Ve4uLOGO1Q1NCgtGVhF9CxcVhuT/kEdq7RalQ3Lw=;
        b=E/juOOCyU/UvCCdUBdDIWOYoBIxhutFVaULCxTcGq1QjgOzpJ1JLaPr1x545MFrCKN
         L7r9zyhVlWz3RvyJAVv3hohf0erOJHJN2r9GBdk2sIojY5RXlR1rI1J0HSenKvlPKxRc
         RdQ1DUXWCYgh8Ip0wMkPENBnlJ0yTIDKMWpwQ5nXwubSe7OeUQm3SqGXx9OLt8ab67wv
         tF1rptDXCTJV5Z9JGd6Icsry1ZOEMUa0u/Ogx8tVG9r8V/bfaB1SUQEs4DG4zgq6p1wc
         hqa6AEPn8PmA3vp8ZRClnbQ1m1Dlqw7Ue0CbrITYRv0Wn0UYF8w6Hl4BMMcPeJtoJYZS
         NpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972993; x=1707577793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y83Ve4uLOGO1Q1NCgtGVhF9CxcVhuT/kEdq7RalQ3Lw=;
        b=diqNjOjZ7NHTPOYlKT5qqnAjaaGz00DlFfdOMqwnvU7kY5oQe5iyuXOWJY/+UtvR3F
         gd6K0JAbxKG4I4vsVX5tc+gGoSukUVg5B8VZkh9t1MlAO8S5t4AzMWtz0Z9WsEbjZjMX
         IzXc1J5TTEUffITJZxM2ANQd4kjaXEXusGzL6QT8Hg0s7yAY/ncdVQKviB2moBpfHsAf
         2mz00NJs8omLhEqGiCleHygYr4cSKx8FyLHXg2XOZOTlTSMz3uGnUtHKxHTzlamA8doL
         PEhIn6TRAIhqrQr6pkl4LGn/PsQzKaASVVrn2Lw+rl3cgaSw4daG4dlC676qFRe+HZyi
         BLrQ==
X-Gm-Message-State: AOJu0YzRN1z8fBJjv8ZW3iSNVMOM56m2fvpUN0zrSYu4uBqH36YGPFMm
	AgtsyI9uzS7UUgmWujyGkF+M/S3clcqUm03WmKn844cdlCuKE8m2ftaCMr6h
X-Google-Smtp-Source: AGHT+IG3vELmvhTEQC3aDsXeNDl+XOLOu+5Y28d4UGVx1cpRm8e3bTPKToV6F+6k0h4JcfJSawTByA==
X-Received: by 2002:a17:902:6b8a:b0:1d8:e4b8:95dc with SMTP id p10-20020a1709026b8a00b001d8e4b895dcmr6447144plk.41.1706972993536;
        Sat, 03 Feb 2024 07:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6R3KrGu18pkdWp5X+zu2s9nKiSurYWIo5X4HUN1wO+X1iU2BRAy+vmLwO0O5gPMcEMMHkAIVMqN+jJtfyM1w8TyC6YwjdLkACDkXusqdLpAPzCBBjY/kJoATE8/R46HozV0jKWLkF2C/gF8RFgBMrw31kti4A7n0L8r8yMnpW4gUnqDwUl4cmW0Nk1Wp+7GSga1dxgEomJPw8H707TuKyE8HaBLUJVHxdRMa2nLH3F58EdL1LZNsnaU7x96oo3szK5+vHAa3hAmUFvm9hlkLnHj45UuebI9muViDVPfRo30J+DyJ904dDfT6krVamYtGsqIGp1kJZOA8wNDFLzO0h562PiTvmNRLsHaZ3xN6W1GsjrlM88Hs/N3OblnX3l0381U7ayD83gWvQKQNxwh6zeMjue8b1VNxTUVWPKyCkFwnnYsCwk0wiqNyWAcfLcVQY9Jc1oXTFnGH66iUGlfLnOa+Wh6NjADrzQirhk5yprQcyrTqjiD/uSVs5JkN8HhrAYmgEIFOhtj4krJXXgYYS6NxGhdI7Nca1R6JqBrQ0TfM3qFcDg08=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d3cd00b001d93966b2acsm3360202plb.143.2024.02.03.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:09:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:09:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com, kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com, naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <5dd9d5f8-c909-4245-b37f-cfb0a8096a50@roeck-us.net>
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com>
 <20231222013352.3873689-2-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222013352.3873689-2-kcfeng0@nuvoton.com>

On Fri, Dec 22, 2023 at 09:33:50AM +0800, baneric926@gmail.com wrote:
> From: Naresh Solanki <naresh.solanki@9elements.com>
> 
> Add common fan properties bindings to a schema.
> 
> Bindings for fan controllers can reference the common schema for the
> fan
> 
> child nodes:
> 
>   patternProperties:
>     "^fan@[0-2]":
>       type: object
>       $ref: fan-common.yaml#
>       unevaluatedProperties: false
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>

Unfortunately the dt maintainer's Reviewed-by: tag on the latest version
of the fan schema patch got lost. I am not sure if I can add that back
in on my own without violating some rules. That will need to get resolved
before we can move forward with these patches.

Guenter

