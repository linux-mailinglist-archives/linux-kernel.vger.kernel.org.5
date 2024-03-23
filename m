Return-Path: <linux-kernel+bounces-112367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6998878F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE57DB20F66
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C1C3F9C2;
	Sat, 23 Mar 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZuunKFp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2673D0B3;
	Sat, 23 Mar 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203371; cv=none; b=QWK9gI9Yf39ijoyADvnQfknia4Hq9/Sz5+zLV1eE+D6gLD2xfpd4DS88J7NNJf4dZB7n2eTXhNE9spR5jqGNZCyraxq9VrbpYTVUBRptNMVyX/HhFKNQlNGayCVHhkR4MRaGSRNnsb6vC+z7I3hDLFulTtGw+nqX+TJyx+ikdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203371; c=relaxed/simple;
	bh=Zonfln1xYbt18YMcFcafYS5a3XzTEoVoGH/sk34xKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY5bUFI2Y0ZLDVlUE/QUTxCLhrSiKQ/CmUiU3eI4Fx1r7O+/HvCY4QzxxGklw2a3UPE+7/axYdcfQg2eikfuNNLmggQvKcrUaFY3b2f/13UYHgcFIk08/CldtbOfUvsw+n0z+hycdK34MsMfgSH8DmMLczq2Y7M4qz6TNPZrjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZuunKFp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dde26f7e1dso22014685ad.1;
        Sat, 23 Mar 2024 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711203369; x=1711808169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yHZUKY2RezcV60fnvTvfbW3kfQRjFkJeR3hdq5nZuY=;
        b=nZuunKFpCdBjogst9lnFIwPANpsSeI0QcIT/Q4B9PkCZHxSXBTccAIw3fUgaw16tX7
         c9QVlbX0QtD44XwS2z8r9w86rL6+JFWiuCY1k3iGS/4AJl9PRvMph42LHqWF015bYxVA
         kCMTFiE/w/pd1K3C3jG875s5nW4OR1QFdDmlohDO/KedRAJLr0ynMb1yM3EJMPssJwnA
         h73jE74aVwaOM/hdvS5ZRLpNa13dafrOYv5mOPjqzAZaYeyEDvrsynOU9FLhnMLwE5Sq
         lT/5Ri6xTsjRGL2zR6jI2YfVURN7COhoqRpSPBUC4R03i6Nkb2YrAnkpytNI7YA1wwNT
         UYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711203369; x=1711808169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yHZUKY2RezcV60fnvTvfbW3kfQRjFkJeR3hdq5nZuY=;
        b=mu3v5vqxQa5tEMiz9We1iO6JyPugtkC+naR0gXNoPNymrBjzYee3MbjqzL2pzuz8kC
         +lzeX3jWvI/nS3kv0+BglQMLDgbjGIlNP07HIba1brFH5srDEvfMeepYxtndsQEiRu01
         9d36IdNpBqAltV7ECMQ78Hi1TKZk6VQB3cbArQkytCw+PJCL5lW85+kjClhxZVaegOPz
         blfbIuQz3jBmYB8EnLz/3iQ8mqdWtPVvtwvXRkf23U6fUm4VTX2Ln7CAPYkALX3RwfO6
         bfRq7tFm10bElpIgciYNfwr6gm3Ed235PlKbhnN/AUy2Qwz+2M+SBafZuH5E1JUgDdzl
         WP+w==
X-Forwarded-Encrypted: i=1; AJvYcCXH1+3krgdiPvdayNuvF/KxrsjiznFdIuO7+YqbY+lceTDfdkhSew61Gg3HgO2mKW4yR7i/XX7wJPdzyoAoY726/BT/vLJPODdgOMtj4GuUsLA9miQGBa3iWjuLrrpecjIl6RxK8pydkJqKEqDLHMUPEXOQfp7xKwyeHL8Ar1aw1t1GTsNm
X-Gm-Message-State: AOJu0YxNUR2bm0ScmI+jTJsCVdybIIBIF2gTGdH1UMHGzJ/9LCMyCrT6
	3JUYMB18hsFO4K6A3gXEd0HLQzDmaEaeRJ+8SGa7SL6drLSbZlbZjII3QCUh
X-Google-Smtp-Source: AGHT+IE4Qp4YYnow/2jOmSjfy+hfB76Afq1NrBb0M4yGd34xRyXDm5SXGf+ljHUMeWADEY6YII99dA==
X-Received: by 2002:a17:902:f641:b0:1e0:3f65:f503 with SMTP id m1-20020a170902f64100b001e03f65f503mr3201038plg.39.1711203369046;
        Sat, 23 Mar 2024 07:16:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001def0324a64sm1597237plf.135.2024.03.23.07.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:16:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Mar 2024 07:16:07 -0700
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
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/5] dt-bindings: hwmon: as370: convert to dtschema
Message-ID: <aabc0c6c-dbc2-4e63-ba7a-f8c15db714a2@roeck-us.net>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
 <20240322-hwmon_dtschema-v3-1-6697de2a8228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-hwmon_dtschema-v3-1-6697de2a8228@gmail.com>

On Fri, Mar 22, 2024 at 08:24:35PM +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> This is a straightforward conversion with now new properties.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied to hwmon-next.

Please note that the branch will be pushed after the commit window closed.

Thanks,
Guenter

